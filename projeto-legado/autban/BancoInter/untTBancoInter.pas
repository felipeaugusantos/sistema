unit untTBancoInter;

interface

Uses Classes, SysUtils, IPPeerClient, IPPeerCommon,
     REST.Json, System.Json, untConstantes, System.Net.URLClient, IdIOHandler,
     IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
     IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, Forms,
     System.Generics.Collections, UniClientDataSet, DB, Uni, untGravando,
     untFuncoesSimples, IdCoder, IdCoder3to4, IdCoderMIME,untTRegBol,
     untTypesSistema,untFuncAutban, untArqNaoGravados;

Type
  TDadosToken = class
  private
    Access_Token : String;
    Expiracao: Integer;
    RefreshTime: TTime;
    Exception : String;
    function GetAccessToken: String;
  Public
    Property AccessToken : String  Read GetAccessToken  Write Access_Token;
  end;

Type
  TRetornoPesquisaBancoInter = class
  public
    seuNumero,
    nossoNumero,
    linhaDigitavel,
    dataPagamento,
    valorPago,
    valorMulta,
    valorMora,
    valorDesconto,
    dataVencimento,
    dataEmissao,
    valorDuplicata,
    valorJuros,
    codigoSolicitacao: String;
  end;

Type
  TRetornoBoletoBancoInter = class
  public
    seuNumero,
    nossoNumero,
    linhaDigitavel,
    codigoDeBarras,
    codigoSolicitacao: String;
  end;

Type
  TBancoInter = class(TObject)
  private
    LDadosToken: TDadosToken;
    FRequisicao: TIdHTTP;
    FProtocoloSSL: TIdSSLIOHandlerSocketOpenSSL;

    FListaRequisicaoRegistroBoleto : TList<TRequisicaoRegistroBoleto>;

    FTentarNovamente: Boolean;
    FLinkAPI,
    FPastaInter,
    FContaCorrente,
    FCarteira,
    FEmpresaCarteira,
    FBaixaAutomatica,
    FObservacao1,
    FObservacao2,
    FObservacao3,
    FObservacao4,
    FObservacao5,
    LClient_ID,
    LClient_Secret: String;

    LIdConnection: String;
    LUtilizaApiV2: Boolean;
    LVersaoUtilizadaAPI: String;
    FPercentualMulta,
    FPercentualMora: Double;

    FAmbiente,
    FLinkTokenAPI : String;

    FUsaSacadorAvalista,
    FNomeBeneficiario,
    FEnderecoBeneficiario,
    FBairroBeneficiario,
    FCidadeBeneficiario,
    FUFBeneficiario,
    FCEPBeneficiario,
    FCNPJBeneficiario : String;

    FTrabalhaComPontualidade: Boolean;

    function RetornaEmailCliente(ADadosCliente: TDataSet): String;

    function RetornaDadosDaRequisicaoApiV1(ADadosDuplicata, ADadosCliente: TDataset): String;
    function RetornaDadosDaRequisicaoApiV2(ADadosDuplicata, ADadosCliente: TDataset): String;
    function RetornaGrupoDescontos(ADadosDuplicata: TDataset): String;
    function RetornaGrupoDesconto2(ADadosDuplicata: TDataset; AImprimeValor: Boolean): String;
    function RetornaGrupoMulta(ADadosDuplicata: TDataset): String;
    function RetornaGrupoMora(ADadosDuplicata: TDataset): String;

    function RetornaDadosDaRequisicaoApiV3(ADadosDuplicata, ADadosCliente: TDataset): String;
    function RetornaGrupoDescontosV3(ADadosDuplicata: TDataset): String;
    function RetornaGrupoMultaV3(ADadosDuplicata: TDataset): String;
    function RetornaGrupoMoraV3(ADadosDuplicata: TDataset): String;
    function RetornaBeneficiarioFinalV3(): String;

    function RetornaCampoDecimalJSON(AValor: String): String;
    function RetornaValorString(AValor: String; ATamanho: Integer = 0): String;

    function RetornaDDDTelefoneCliente(ADadosCliente: TDataset): String;
    Procedure AguardeCincoSegundos;
    function ResponseError(AJson:String): String;
    procedure GerarToken;
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure CriarComponenteRequisicaoApiV1;
    procedure CriarComponenteRequisicaoApiV2;
    procedure CriarComponenteRequisicaoApiV3;
    procedure DefinirURL;
    procedure CriarProtocoloSSL;
    function  RetiraQuebraDeLinha(AValue: String): String;
    function  RetornaTextoErro(ADadosRetorno: String): String;
    procedure ExibeFormMensagemErro(AMensagem: String);
    function  CorrigirUltimaVirgulaJson(const JsonStr: string): string;
    function  CorrigirEncodingUTF8(const Texto: String): string;
    function RetornaDadosBoletoCadastrado(ACodigoSolicitacao:String): String;
    function RetornaCodigoSolicitacaoBoletoEmProcessamento(const AAutoincremDuplicata: string): string;
  public
    constructor Create(ACarteira: String);
    Destructor  Destroy; override;

    property PercentualMulta: Double read FPercentualMulta write FPercentualMulta;
    property PercentualMora: Double read FPercentualMora write FPercentualMora;

    function ConsultaBoletosPorPeriodoApiV1(ADataInicial,
                                            ADataFinal: String;
                                            AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoInter>;

    function ConsultaBoletosPorPeriodoApiV2(ADataInicial,
                                            ADataFinal: String;
                                            AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoInter>;

    function ConsultaBoletosPorPeriodoApiV3(ADataInicial,
                                            ADataFinal: String;
                                            AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoInter>;

    function CadastrarNovoBoleto(ADadosDuplicata, ADadosCliente: TDataSet): TRetornoBoletoBancoInter;

    function CadastrarNovoBoletoV3(ADadosDuplicata, ADadosCliente: TDataSet): TRetornoBoletoBancoInter;

    function ConsultaBoletoPDF(ANossoNumero: String): String;

    function SolicitarBaixaDoBoleto(ANossoNumero, ACodigoBaixa: String): String;

    function VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoInter; out ADuplicata: TDuplicataCtr): Boolean;
    function RetornaSolucaoErro(AErro:String): String;
    function LerResponseErroJSON(const AJSONString: string): string;

    function RetornaCodigoSolicitacaoRegBol( AAutoinc : String) : String;
    procedure BaixaBoletoRegistrado(ADataSet: TDataSet);
    procedure CancelarBoletos(ADataSet: TDataSet);

    procedure GravarDadosRequisicaoRegistroBoleto;

    property TentarNovamente  : Boolean   Read FTentarNovamente  Write FTentarNovamente;
  end;

Const
  FCodigoBanco: String = '077';
  FNomeBanco: String = 'BANCO INTER SA';

  // VERSAO 3.0
  C_URL            = 'https://cdpj.partners.bancointer.com.br/cobranca/v3/cobrancas';
  C_URL_HOM        = 'https://cdpj-sandbox.partners.uatinter.co/cobranca/v3/cobrancas';

  C_URL_OAUTH_PROD = 'https://cdpj.partners.bancointer.com.br/oauth/v2/token';
  C_URL_OAUTH_HOM  = 'https://cdpj-sandbox.partners.uatinter.co/oauth/v2/token';

implementation
Uses StrUtils, DateUtils, untLogCtr;

{ TBancoInter }

function TBancoInter.ResponseError(AJson: String): String;
  Var
    LJsonError: TJSONObject;
    LJsonArray: TJSONArray;
begin
  Try
    LJsonError := TJSONObject.ParseJSONValue(AJson) as TJSONObject;
    LJsonArray := LJsonError.GetValue<TJSONArray>('message') as TJSONArray;

    Result := LJsonArray.ToString;
  Except
    Result:= AJson;
  End;
end;

function TBancoInter.RetiraQuebraDeLinha(AValue: String): String;
begin
  Result := untFuncoesSimples.fTiraEnter(AValue);
end;

function TBancoInter.RetornaCampoDecimalJSON(AValor: String): String;
begin
  Result := AValor.Replace('.', EmptyStr);
  Result := Result.Replace(',', '.');
end;

function TBancoInter.RetornaDadosBoletoCadastrado(
  ACodigoSolicitacao: String): String;
var
  LJson: String;
  LSituacao: String;
  LTentativa: Integer;
  LJSONValue: TJSONValue;
  LJSONObj: TJSONObject;
begin
  FRequisicao.Request.Method := 'GET';

  for LTentativa := 1 to 3 do
  begin
    LJson := FRequisicao.Get(FLinkAPI + '/' + ACodigoSolicitacao);

    LJSONValue := TJSONObject.ParseJSONValue(LJson);

    if Assigned(LJSONValue) then
    try
      if LJSONValue is TJSONObject then
      begin
        LJSONObj := TJSONObject(LJSONValue);

        if Assigned(LJSONObj.GetValue('cobranca')) then
        begin
          LSituacao := LJSONObj.GetValue<string>('cobranca.situacao');

          if LSituacao <> 'EM_PROCESSAMENTO' then
            Exit(LJson);
        end;
      end;
    finally
      LJSONValue.Free;
    end;

    if LTentativa < 3 then
      Sleep(2000);
  end;

  Self.FTentarNovamente := False;

  raise Exception.Create(
    'INTER-Não foi possível gerar o boleto no momento, pois o servidor do banco apresenta lentidão ' +
    'no processamento da cobrança e não retornou a confirmação após 3 tentativas. ' +
    'Pedimos que aguarde alguns minutos e realize a impressão novamente pelo financeiro.'
  );
end;


function TBancoInter.RetornaDadosDaRequisicaoApiV1(ADadosDuplicata,ADadosCliente: TDataset): String;
  Var
    LArquivoJSON: TStringList;
begin
  Try
    Result := Concat('{' + #13 + #9,
                        '"dataEmissao":"' + FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTACAD').AsDateTime) + '",' + #13 + #9,
                        '"seuNumero":"' + ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString + ADadosDuplicata.FieldByName('CTR_PARCEL').AsString + '",'+ #13 + #9,
                        '"dataLimite":"' + FBaixaAutomatica + '",'+ #13 + #9,
                        '"dataVencimento":"' + FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime) + '",'+ #13 + #9,
                        '"valorNominal":' + RetornaCampoDecimalJSON(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat.ToString) + ','+ #13 + #9,
                        '"valorAbatimento":0,'+ #13 + #9,

                        '"pagador":{ '+ #13 + #9 + #9,
                          '"tipoPessoa":"' + IIF(ADadosCliente.FieldByName('CLI_CGCCPF').AsString = '2', 'FISICA', 'JURIDICA') +'",'+ #13 + #9 + #9,
                          '"cnpjCpf": "' + fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString) + '",'+ #13 + #9 + #9,
                          '"nome":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 100) + '",'+ #13 + #9 + #9,
                          '"email":"' + LeftStr(RetornaEmailCliente(ADadosCliente), 50) + '",'+ #13 + #9 + #9,
                          '"cep":"' + fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString) + '",'+ #13 + #9 + #9,
                          '"endereco":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_ENDERE').AsString, 90) + '",'+ #13 + #9 + #9,
                          '"numero":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_ENDNUM').AsString) + '",'+ #13 + #9 + #9,
                          '"complemento":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_ENDCOM').AsString, 30) + '",'+ #13 + #9 + #9,
                          '"bairro":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_BAIRRO').AsString, 60) + '",'+ #13 + #9 + #9,
                          '"cidade":"' + RetornaValorString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 60) + '",'+ #13 + #9 + #9,
                          '"uf":"' + RetornaValorString(ADadosCliente.FieldByName('CID_ESTADO').AsString) + '",'+ #13 + #9 + #9,
                          RetornaDDDTelefoneCliente(ADadosCliente),
                        '},'+ #13 + #9,

                        '"mensagem":{'+ #13 + #9 +#9,
                          '"linha1":"' + RetornaValorString(FObservacao1, 78) + '",'+ #13 + #9 +#9,
                          '"linha2":"' + RetornaValorString(FObservacao2, 78) + '",'+ #13 + #9 +#9,
                          '"linha3":"' + RetornaValorString(FObservacao3, 78) + '",'+ #13 + #9 +#9,
                          '"linha4":"' + RetornaValorString(FObservacao4, 78) + '",'+ #13 + #9 +#9,
                          '"linha5":"' + RetornaValorString(FObservacao5, 78) + '"'+ #13 + #9,
                        '},'+ #13 + #9,

                        RetornaGrupoDescontos(ADadosDuplicata),

                        RetornaGrupoMulta(ADadosDuplicata),

                        RetornaGrupoMora(ADadosDuplicata),

                        '"cnpjCPFBeneficiario":"' + fRetCGCEmpresa(RightStr(FCarteira, 3)) + '",'+ #13 + #9,
                        '"numDiasAgenda":"' + FBaixaAutomatica + '"'+ #13 + #9,
                     '}');


    LArquivoJSON := TStringList.Create;
    LArquivoJSON.Append(Result);

    Result := FPastaInter + ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                            ADadosDuplicata.FieldByName('CTR_PARCEL').AsString +
                            ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString +
                            ADadosDuplicata.FieldByName('CTR_CODEMP').AsString +
                            ADadosDuplicata.FieldByName('CTR_CODCLI').AsString + '.json';

    LArquivoJSON.SaveToFile(Result);
  Finally
    If Assigned(LArquivoJSON) Then
      FreeAndNil(LArquivoJSON);
  End;
end;

function TBancoInter.RetornaDadosDaRequisicaoApiV2(ADadosDuplicata,ADadosCliente: TDataset): String;
  Var
    LArquivoJSON: TStringList;
begin
  Try
    Result := Concat('{' + #13 + #9,
                        '"seuNumero":"' + ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString + ADadosDuplicata.FieldByName('CTR_PARCEL').AsString + '",'+ #13 + #9,
                        '"valorNominal":' + RetornaCampoDecimalJSON(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat.ToString) + ','+ #13 + #9,
                        '"dataVencimento":"' + FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime) + '",'+ #13 + #9,
                        '"valorAbatimento":0,'+ #13 + #9,

                        '"pagador":{ '+ #13 + #9 + #9,
                          '"cpfCnpj": "' + fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString) + '",'+ #13 + #9 + #9,
                          '"tipoPessoa":"' + IIF(ADadosCliente.FieldByName('CLI_CGCCPF').AsString = '2', 'FISICA', 'JURIDICA') +'",'+ #13 + #9 + #9,
                          '"nome":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 100) + '",'+ #13 + #9 + #9,
                          '"endereco":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_ENDERE').AsString, 90) + '",'+ #13 + #9 + #9,
                          '"numero":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_ENDNUM').AsString) + '",'+ #13 + #9 + #9,
                          '"complemento":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_ENDCOM').AsString, 30) + '",'+ #13 + #9 + #9,
                          '"bairro":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_BAIRRO').AsString, 60) + '",'+ #13 + #9 + #9,
                          '"cidade":"' + RetornaValorString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 60) + '",'+ #13 + #9 + #9,
                          '"uf":"' + RetornaValorString(ADadosCliente.FieldByName('CID_ESTADO').AsString) + '",'+ #13 + #9 + #9,
                          '"cep":"' + fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString) + '",'+ #13 + #9 + #9,
                          '"email":"' + LeftStr(RetornaEmailCliente(ADadosCliente), 50) + '",'+ #13 + #9 + #9,
                          RetornaDDDTelefoneCliente(ADadosCliente),
                        '},'+ #13 + #9,

                        '"mensagem":{'+ #13 + #9 +#9,
                          '"linha1":"' + RetornaValorString(FObservacao1, 78) + '",'+ #13 + #9 +#9,
                          '"linha2":"' + RetornaValorString(FObservacao2, 78) + '",'+ #13 + #9 +#9,
                          '"linha3":"' + RetornaValorString(FObservacao3, 78) + '",'+ #13 + #9 +#9,
                          '"linha4":"' + RetornaValorString(FObservacao4, 78) + '",'+ #13 + #9 +#9,
                          '"linha5":"' + RetornaValorString(FObservacao5, 78) + '"'+ #13 + #9,
                        '},'+ #13 + #9,

                        RetornaGrupoDescontos(ADadosDuplicata),

                        RetornaGrupoMulta(ADadosDuplicata),

                        RetornaGrupoMora(ADadosDuplicata),

                        '"numDiasAgenda":"' + FBaixaAutomatica + '"'+ #13 + #9,

                     '}');




    LArquivoJSON := TStringList.Create;
    LArquivoJSON.Append(Result);

    Result := FPastaInter + ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                            ADadosDuplicata.FieldByName('CTR_PARCEL').AsString +
                            ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString +
                            ADadosDuplicata.FieldByName('CTR_CODEMP').AsString +
                            ADadosDuplicata.FieldByName('CTR_CODCLI').AsString + '.json';

    LArquivoJSON.SaveToFile(Result);
  Finally
    If Assigned(LArquivoJSON) Then
      FreeAndNil(LArquivoJSON);
  End;
end;

function TBancoInter.RetornaDadosDaRequisicaoApiV3(ADadosDuplicata,ADadosCliente: TDataset): String;
  Var
    LArquivoJSON: TStringList;
begin
  Try
    Result := Concat('{' + #13 + #9,
                        '"seuNumero":"' + ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString + ADadosDuplicata.FieldByName('CTR_PARCEL').AsString + '",'+ #13 + #9,
                        '"valorNominal":' + RetornaCampoDecimalJSON(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat.ToString) + ','+ #13 + #9,
                        '"dataVencimento":"' + FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime) + '",'+ #13 + #9,
                        '"numDiasAgenda":' + FBaixaAutomatica + ','+ #13 + #9,


                        '"pagador":{ '+ #13 + #9 + #9,
                          '"email":"' + LeftStr(RetornaEmailCliente(ADadosCliente), 50) + '",'+ #13 + #9 + #9,
                          RetornaDDDTelefoneCliente(ADadosCliente) + ','+ #13 + #9 + #9,
                          '"numero":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_ENDNUM').AsString) + '",'+ #13 + #9 + #9,
                          '"complemento":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_ENDCOM').AsString, 30) + '",'+ #13 + #9 + #9,
                          '"cpfCnpj": "' + fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString) + '",'+ #13 + #9 + #9,
                          '"tipoPessoa":"' + IIF(ADadosCliente.FieldByName('CLI_CGCCPF').AsString = '2', 'FISICA', 'JURIDICA') +'",'+ #13 + #9 + #9,
                          '"nome":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 100) + '",'+ #13 + #9 + #9,
                          '"endereco":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_ENDERE').AsString, 100) + '",'+ #13 + #9 + #9,
                          '"bairro":"' + RetornaValorString(ADadosCliente.FieldByName('CLI_BAIRRO').AsString, 60) + '",'+ #13 + #9 + #9,
                          '"cidade":"' + RetornaValorString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 60) + '",'+ #13 + #9 + #9,
                          '"uf":"' + RetornaValorString(ADadosCliente.FieldByName('CID_ESTADO').AsString) + '",'+ #13 + #9 + #9,
                          '"cep":"' + fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString) + '"'+ #13 + #9 + #9,
                        '},'+ #13 + #9,

                        RetornaGrupoDescontosV3(ADadosDuplicata),

                        RetornaGrupoMultaV3(ADadosDuplicata),

                        RetornaGrupoMoraV3(ADadosDuplicata),

                        '"mensagem":{'+ #13 + #9 +#9,
                          '"linha1":"' + RetornaValorString(FObservacao1, 78) + '",'+ #13 + #9 +#9,
                          '"linha2":"' + RetornaValorString(FObservacao2, 78) + '",'+ #13 + #9 +#9,
                          '"linha3":"' + RetornaValorString(FObservacao3, 78) + '",'+ #13 + #9 +#9,
                          '"linha4":"' + RetornaValorString(FObservacao4, 78) + '",'+ #13 + #9 +#9,
                          '"linha5":"' + RetornaValorString(FObservacao5, 78) + '"'+ #13 + #9,
                        '},'+ #13 + #9,

                        RetornaBeneficiarioFinalV3,
                     '}');

    LArquivoJSON := TStringList.Create;
    LArquivoJSON.Append( CorrigirUltimaVirgulaJson(Result) );

    Result := FPastaInter + ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                            ADadosDuplicata.FieldByName('CTR_PARCEL').AsString +
                            ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString +
                            ADadosDuplicata.FieldByName('CTR_CODEMP').AsString +
                            ADadosDuplicata.FieldByName('CTR_CODCLI').AsString + '.json';

    LArquivoJSON.SaveToFile(Result);
  Finally
    If Assigned(LArquivoJSON) Then
      FreeAndNil(LArquivoJSON);
  End;
end;

function TBancoInter.RetornaDDDTelefoneCliente(ADadosCliente: TDataset): String;
  Var
    LDDD : String;
    LTelefone: String;
begin
  Result := Concat('"ddd":"",' + #13 +#9 +#9,
                   '"telefone": ""' + #13 +#9);

  If fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_FONE01').AsString).Length >= 10 Then
  Begin
    LDDD :=  LeftStr(ADadosCliente.FieldByName('CLI_FONE01').AsString, 2);
    LTelefone := RightStr(ADadosCliente.FieldByName('CLI_FONE01').AsString, ADadosCliente.FieldByName('CLI_FONE01').AsString.Length - 2);

    If ((Trim(LDDD).Length = 2) And (Trim(LTelefone).Length = 9)) Then
    Begin
      Result := Concat('"ddd":"' + LDDD + '",' + #13 +#9 +#9,
                       '"telefone": "' + LTelefone + '"' + #13 +#9);
      Exit;
    End;

  End;

  If fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_CELULA').AsString).Length >= 10 Then
  Begin
    LDDD := LeftStr(ADadosCliente.FieldByName('CLI_CELULA').AsString, 2);
    LTelefone := RightStr(ADadosCliente.FieldByName('CLI_CELULA').AsString, ADadosCliente.FieldByName('CLI_CELULA').AsString.Length - 2);

    If ((Trim(LDDD).Length = 2) And (Trim(LTelefone).Length = 9)) Then
    Begin
      Result := Concat('"ddd":"' + LDDD + '",' + #13 +#9 +#9,
                       '"telefone": "' + LTelefone + '"' + #13 +#9);
      Exit;
    End;

  End;

  If fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_FONE02').AsString).Length >= 10 Then
  Begin
    LDDD  := LeftStr(ADadosCliente.FieldByName('CLI_FONE02').AsString, 2);
    LTelefone := RightStr(ADadosCliente.FieldByName('CLI_FONE02').AsString, ADadosCliente.FieldByName('CLI_FONE02').AsString.Length - 2);

    If ((Trim(LDDD).Length = 2) And (Trim(LTelefone).Length = 9)) Then
    Begin
      Result := Concat('"ddd":"' + LDDD + '",' + #13 +#9 +#9,
                       '"telefone": "' + LTelefone + '"' + #13 +#9);
      Exit;
    End;

  End;


end;

function TBancoInter.RetornaEmailCliente(ADadosCliente: TDataSet): String;
begin
  Result := ADadosCliente.FieldByName('CLI_EMCOB1').AsString;

  If Result.IsEmpty Then
    Result := ADadosCliente.FieldByName('CLI_EMCOB2').AsString;

  If Result.IsEmpty Then
    Result := ADadosCliente.FieldByName('CLI_EMAIL_').AsString;

  If Result.IsEmpty Then
    Result := ADadosCliente.FieldByName('CLI_EMAIL2').AsString;

  If Result.IsEmpty Then
    Result := ADadosCliente.FieldByName('CLI_EMAIL3').AsString;

  Result := AnsiReplaceStr(Result, ';', EmptyStr);
  Result := RetiraQuebraDeLinha(Result);
end;

function TBancoInter.RetornaGrupoDescontos(ADadosDuplicata: TDataset): String;
  Var
    LValorDesconto: Double;

    LVencimentoPontualidade: TDateTime;

    LGrupo2Valor: Boolean;
begin
  Result := Concat('"desconto1":{'+ #13 + #9 +#9,
                                  '"codigoDesconto":"NAOTEMDESCONTO",'+ #13 + #9 +#9,
                                  '"taxa":0,'+ #13 + #9 +#9,
                                  '"valor":0,'+ #13 + #9 +#9,
                                  '"data":""'+ #13 + #9,
                               '},'+ #13 + #9,
                    RetornaGrupoDesconto2(ADadosDuplicata, False));

  LGrupo2Valor := False;

  LValorDesconto := fFormataFloat(ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat, 2);

  If (ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat > 0) Then
  Begin
    If FTrabalhaComPontualidade Then
    Begin

      LValorDesconto := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat *
                                      (ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat / 100), 2);

      LVencimentoPontualidade := ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime -
                                 ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger;

      LGrupo2Valor := LVencimentoPontualidade <> ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime;
      If LGrupo2Valor Then
        LGrupo2Valor := ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0;

      LValorDesconto := fFormataFloat(LValorDesconto + IIF(LGrupo2Valor, 0, ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat), 2);

      If LValorDesconto = 0 Then
      Begin
        Result := Concat('"desconto1":{'+ #13 + #9 +#9,
                                         '"codigoDesconto":"PERCENTUALDATAINFORMADA",'+ #13 + #9 +#9,
                                         '"taxa":' + RetornaCampoDecimalJSON(fFormataFloat(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat, 2).ToString) + ','+ #13 + #9 +#9,
                                         '"valor":0,'+ #13 + #9 +#9,
                                         '"data":"' + FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime -
                                                                                   ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger) + '"'+ #13 + #9,
                                      '},'+ #13 + #9,
                          RetornaGrupoDesconto2(ADadosDuplicata, LGrupo2Valor));

        Exit;
      End;
    End;
  End;

  If LValorDesconto > 0 Then
  Begin
    Result := Concat('"desconto1":{'+ #13 + #9 +#9,
                                    '"codigoDesconto":"VALORFIXODATAINFORMADA",'+ #13 + #9 +#9,
                                    '"taxa":0,'+ #13 + #9 +#9,
                                    '"valor":' + RetornaCampoDecimalJSON(LValorDesconto.ToString) + ','+ #13 + #9 +#9,
                                    '"data":"' + FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime -
                                                                              ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger) + '"'+ #13 + #9,
                                    '},'+ #13 + #9,
                       RetornaGrupoDesconto2(ADadosDuplicata, LGrupo2Valor));
  End;

end;

function TBancoInter.RetornaGrupoDesconto2(ADadosDuplicata: TDataset; AImprimeValor: Boolean): String;
  Var
    LValorDesconto: Double;
begin
  Result := Concat('"desconto2":{'+ #13 + #9 +#9,
                                  '"codigoDesconto":"NAOTEMDESCONTO",'+ #13 + #9 +#9,
                                  '"taxa":0,'+ #13 + #9 +#9,
                                  '"valor":0,'+ #13 + #9 +#9,
                                  '"data":""'+ #13 + #9,
                               '},'+ #13 + #9,
                    '"desconto3":{'+ #13 + #9 +#9,
                                   '"codigoDesconto":"NAOTEMDESCONTO",'+ #13 + #9 +#9,
                                   '"taxa":0,'+ #13 + #9 +#9,
                                   '"valor":0,'+ #13 + #9 +#9,
                                   '"data":""'+ #13 + #9,
                                '},'+ #13 + #9);

  If Not AImprimeValor Then
    Exit;

  LValorDesconto := fFormataFloat(ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat, 2);

  If (LValorDesconto > 0) Then
  Begin
    Result := Concat('"desconto2":{'+ #13 + #9 +#9,
                                     '"codigoDesconto":"VALORFIXODATAINFORMADA",'+ #13 + #9 +#9,
                                     '"taxa":0,'+ #13 + #9 +#9,
                                     '"valor":' + RetornaCampoDecimalJSON(LValorDesconto.ToString) + ','+ #13 + #9 +#9,
                                     '"data":"' + FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime) + '"'+ #13 + #9,
                                  '},'+ #13 + #9,
                     '"desconto3":{'+ #13 + #9 +#9,
                                     '"codigoDesconto":"NAOTEMDESCONTO",'+ #13 + #9 +#9,
                                     '"taxa":0,'+ #13 + #9 +#9,
                                     '"valor":0,'+ #13 + #9 +#9,
                                     '"data":""'+ #13 + #9,
                                 '},'+ #13 + #9);
  End;
end;

function TBancoInter.RetornaGrupoMora(ADadosDuplicata: TDataset): String;
  Var
    LValorMora: Double;
begin
  Result := Concat('"mora":{'+ #13 + #9 +#9,
                              '"codigoMora":"ISENTO",'+ #13 + #9 +#9,
                              '"valor":0,'+ #13 + #9 +#9,
                              '"taxa":0,' + #13 + #9 +#9 +
                              '"data":""'+ #13 + #9,
                           '},'+ #13 + #9);

  If FPercentualMora > 0 Then
  Begin
    LValorMora := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (FPercentualMora / 100), 2);

    Result := Concat('"mora":{'+ #13 + #9 +#9,
                        '"codigoMora":"VALORDIA",'+ #13 + #9 +#9,
                        '"valor":' + RetornaCampoDecimalJSON((fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (FPercentualMora / 100), 2)).ToString) + ','+ #13 + #9 +#9,
                        '"taxa":0,' + #13 + #9 +#9 +
                        '"data":"' + FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 1)) + '"'+ #13 + #9,
                      '},'+ #13 + #9);

    If LValorMora = 0 Then
    Begin
      Result := Concat('"mora":{'+ #13 + #9 +#9,
                                 '"codigoMora":"TAXAMENSAL",'+ #13 + #9 +#9,
                                 '"valor":0,'+ #13 + #9 +#9,
                                 '"taxa":' + RetornaCampoDecimalJSON(fFormataFloat(FPercentualMora * 30, 2).ToString) + ',' + #13 + #9 +#9 +
                                 '"data":"' + FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 1)) + '"'+ #13 + #9,
                               '},'+ #13 + #9);
    End;
  End;
end;

function TBancoInter.RetornaGrupoMulta(ADadosDuplicata: TDataset): String;
  Var
    LValorMulta: Double;
begin
  Result := Concat('"multa":{'+ #13 + #9 +#9,
                               '"codigoMulta":"NAOTEMMULTA",'+ #13 + #9 +#9,
                               '"valor":0,'+ #13 + #9 +#9,
                               '"taxa":0,'+ #13 + #9 +#9,
                               '"data":""'+ #13 + #9,
                            '},'+ #13 + #9);

  LValorMulta := 0;
  If FPercentualMulta = 0 Then
    FPercentualMulta := fStrToFloat(fGetBancoConfig(0, FCarteira, 'PERMULT', ''));

  If FPercentualMulta > 0 Then
  Begin
    LValorMulta := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat *
                                 (FPercentualMulta / 100), 2);

    Result := Concat('"multa":{'+ #13 + #9 +#9,
                                '"codigoMulta":"VALORFIXO",'+ #13 + #9 +#9,
                                '"valor":' + RetornaCampoDecimalJSON(LValorMulta.ToString) + ','+ #13 + #9 +#9,
                                '"taxa":0,'+ #13 + #9 +#9,
                                '"data":"' + FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 1)) + '"'+ #13 + #9,
                              '},'+ #13 + #9);
  End;
end;


function TBancoInter.RetornaSolucaoErro(AErro: String): String;
begin
  If (Pos('Data de emissão inválida',AErro) > 0) Then
    Result := 'Data de cadastro deve ser igual ou superior a data atual.'

  Else If (Pos('O título não pode estar vencido',AErro) > 0) Then
    Result := 'Data de vencimento deve ser igual ou superior a data atual.'

  Else If (Pos('Verificar situação do beneficiário',AErro) > 0) Then
    Result := 'O cadastro do beneficiário está correto,'+
              ' porém ainda não está registrado na Câmara Interbancária de Pagamentos (CIP),'+
              ' Aguardar alguns minutos para efetivar o cadastro.'

  Else If (Pos('CPF/CNPJ do beneficiário inválido',AErro) > 0) Then
    Result := 'Verificar CPF/CNPJ no cadastro na empresa.'

  Else If (Pos('Erro ao gerar boletos',AErro) > 0) Then
    Result := 'Verificar e retirar nos dados do pagador caracteres especiais,'+
              ' como cedilha, acentos e outros caracteres nos campos, nome, email, telefone, etc.'

  Else If (Pos('Limite excedido para gerar este boleto',AErro) > 0) Then
    Result := 'É necessário adquirir novo pacote de boleto diretamente na conta.'

  Else If (Pos('Beneficiário não encontrado',AErro) > 0) Then
    Result := 'Beneficiário(empresa) ainda não está habilitado para emissão de boleto.'

  Else If (Pos('Valor do boleto deve ser maior ou igual',AErro) > 0) Then
    Result := 'Valor do boleto deve ser maior ou igual ao sugerido.'

  Else If (Pos('Data da mora do título deve ser maior que a data de vencimento informada',AErro) > 0) Then
    Result := 'Data da mora do título deve ser maior que a data de vencimento informada.'

  Else If (Pos('Data da multa do título deverá ser maior que a data de vencimento informada',AErro) > 0) Then
    Result := 'Data da multa do título deverá ser maior que a data de vencimento informada.'

  Else If (Pos('Ocorreu um erro ao realizar a autenticação na API do Banco.',AErro) > 0) Then
    Result := 'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de PRODUÇÃO.'

  Else
  If LVersaoUtilizadaAPI = '3' Then
  Begin

    If (Pos('Falha durante a execução da request.',AErro) > 0) Then
       Result := 'Verifique se os dados informados estão de acordo com a documentação disponibilizada e tente novamente.'

    Else If (Pos('Dados inválidos.',AErro) > 0) Then
       Result := 'Verifique se os dados informados estão de acordo com a documentação disponibilizada e tente novamente.'

    Else If (Pos('Acesso Negado.',AErro) > 0) Then
       Result := 'Requisição de participante autenticado que viola alguma regra de autorização.'

    Else If (Pos('Erro Interno.',AErro) > 0) Then
       Result := 'Ocorreu um erro não esperado. Tente novamente mais tarde.'

    Else If (Pos('Serviço Indisponível.',AErro) > 0) Then
       Result := 'Serviço não está disponível no momento. Serviço solicitado pode estar em manutenção ou fora da janela de funcionamento.';

  End
  Else
    Result := AErro;
end;

function TBancoInter.RetornaValorString(AValor: String;
  ATamanho: Integer): String;
begin
  Result := AValor;

  If Result.IsEmpty Then
    Exit;

  If ATamanho > 0 Then
    Result := LeftStr(Result, ATamanho);

  Result := fRemoveAcento(Result);
  Result := fRetirarCaracteresEspeciais(Result);
  Result := RetiraQuebraDeLinha(Result);
end;

function TBancoInter.SolicitarBaixaDoBoleto(ANossoNumero,
  ACodigoBaixa: String): String;
  Var
    LDadosArquivo: TStringList;
begin
  LDadosArquivo := TStringList.Create;
  LDadosArquivo.Add('{"codigoBaixa": "' + ACodigoBaixa + '"}');
  LDadosArquivo.SaveToFile(FPastaInter + ANossoNumero + '.json');
  FreeAndNil(LDadosArquivo);

  FRequisicao.Request.Method := 'POST';

  Result := FRequisicao.Post(FLinkAPI + ANossoNumero + '/baixas', FPastaInter + ANossoNumero + '.json');
end;

function TBancoInter.VerificaSeADuplicataExisteCadrec(
  ABoleto: TRetornoPesquisaBancoInter; out ADuplicata: TDuplicataCtr): Boolean;
  Var
    LPesquisa: TUniQuery;
begin
  ADuplicata.strAutoIn := EmptyStr;
  ADuplicata.strNumDup := EmptyStr;
  ADuplicata.strParcel := EmptyStr;
  ADuplicata.strEspdoc := EmptyStr;
  ADuplicata.strCodEmp := EmptyStr;
  ADuplicata.strCodCli := EmptyStr;

  Try
    LPesquisa := fCriaQuery;
    LPesquisa.SQL.Text := 'SELECT AUTOINCREM, CTR_NUMDUP, CTR_CODEMP,     ' +
                          'CTR_PARCEL, CTR_ESPDOC, CTR_CODCLI, CTR_CARTEI ' +
                          'FROM CADREC                                    ' +
                          'WHERE CTR_NOSNUM=:NOSNUM                       ' +
                          '  AND CTR_BCOENV=:BCOENV                       ' +
                          '  AND CTR_NUMDUP=:NUMDUP                       ' +
                          '  AND CTR_PARCEL=:PARCEL                       ' +
                          '  AND CTR_SEQBAI=0                             ';

    LPesquisa.ParamByName('NOSNUM').AsString := ABoleto.nossoNumero;
    LPesquisa.ParamByName('BCOENV').AsString := '077';
    LPesquisa.ParamByName('NUMDUP').AsString := LeftStr(ABoleto.seuNumero, 12);
    LPesquisa.ParamByName('PARCEL').AsString := RightStr(ABoleto.seuNumero, ABoleto.seuNumero.Length - 12);

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

    If LPesquisa.RecordCount > 1 Then
    Begin
      LPesquisa.Filter := 'CTR_CARTEI=' + FCarteira.QuotedString;
      LPesquisa.Filtered := True;

      If Not LPesquisa.IsEmpty Then
      Begin
        ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
        ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
        ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
        ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
        ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
        ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;
      End;
    End;
  Finally
    FreeAndNil(LPesquisa);
  End;
end;

constructor TBancoInter.Create(ACarteira: String);
begin
  LUtilizaApiV2 := False;
  LIdConnection := fGetConnectionID;
  Self.FTentarNovamente := True;
  FCarteira := ACarteira;

  FTrabalhaComPontualidade := fCfgSis('DESPON', varBoolean, FEmpresaCarteira);

  FEmpresaCarteira := RightStr(ACarteira, 3);

  FContaCorrente := fGetBancoConfig(0, FCarteira, 'NUMCTAC', '') +
                    fGetBancoConfig(0, FCarteira, 'DIGCTAC', '');

  If MatchStr(fGetBancoConfig(0, FCarteira, 'BAIAUTO', ''), ['TRINTA','SESSENTA']) Then
     FBaixaAutomatica := IIF((FBaixaAutomatica = 'TRINTA'),'30','60')
  Else
     FBaixaAutomatica := fGetBancoConfig(0, FCarteira, 'BAIAUTO', '');

  LUtilizaApiV2    := (LeftStr(fGetBancoConfig(0, FCarteira, 'VERSAO_API', ''),1) = '2');
  LClient_ID       := fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '');
  LClient_Secret   := fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', '');

  LVersaoUtilizadaAPI := LeftStr(fGetBancoConfig(0, FCarteira, 'VERSAO_API', ''),1);
  FAmbiente           := fGetBancoConfig(0, FCarteira, 'AMBIENTE', '0');

  FObservacao1 := fGetBancoConfig(0, FCarteira, 'OBSERV1', '');
  FObservacao2 := fGetBancoConfig(0, FCarteira, 'OBSERV2', '');
  FObservacao3 := fGetBancoConfig(0, FCarteira, 'OBSERV3', '');
  FObservacao4 := fGetBancoConfig(0, FCarteira, 'OBSERV4', '');
  FObservacao5 := fGetBancoConfig(0, FCarteira, 'OBSERV5', '');

  FUsaSacadorAvalista   := fGetBancoConfig(0, FCarteira, 'SACAVAL', '', FEmpresaCarteira);
  FNomeBeneficiario     := fGetBancoConfig(0, FCarteira, 'NOMEBEN', '', FEmpresaCarteira);
  FEnderecoBeneficiario := fGetBancoConfig(0, FCarteira, 'ENDEBEN', '', FEmpresaCarteira);
  FBairroBeneficiario   := fGetBancoConfig(0, FCarteira, 'BAIRBEN', '', FEmpresaCarteira);
  FCidadeBeneficiario   := fGetBancoConfig(0, FCarteira, 'CIDABEN', '', FEmpresaCarteira);
  FUFBeneficiario       := fGetBancoConfig(0, FCarteira, 'ESTABEN', '', FEmpresaCarteira);
  FCEPBeneficiario      := fGetBancoConfig(0, FCarteira, 'CEP_BEN', '', FEmpresaCarteira);
  FCNPJBeneficiario     := fGetBancoConfig(0, FCarteira, 'CNPJBEN', '', FEmpresaCarteira);

  DefinirUrl;
  CriarProtocoloSSL;
  If LUtilizaApiV2 Then
     CriarComponenteRequisicaoApiV2
  Else If LVersaoUtilizadaAPI = '1' Then
     CriarComponenteRequisicaoApiV1
  Else If LVersaoUtilizadaAPI = '3' Then
     CriarComponenteRequisicaoApiV3;

  FListaRequisicaoRegistroBoleto := TList<TRequisicaoRegistroBoleto>.Create;

end;

procedure TBancoInter.CriarComponenteRequisicaoApiV1;
begin
  //Api Versão 1.0
  FRequisicao := TIdHTTP.Create(Application);
  FRequisicao.ReadTimeout := 120000;
  FRequisicao.IOHandler := FProtocoloSSL;
  FRequisicao.Request.CustomHeaders.Add('x-inter-conta-corrente: ' + FContaCorrente);
  FRequisicao.Request.CustomHeaders.Add('Content-Type: application/json');
  FRequisicao.Request.Host := 'https://apis.bancointer.com.br';
  FRequisicao.Request.Accept := '*/*';
  FRequisicao.ProtocolVersion := pv1_1;
end;

procedure TBancoInter.CriarComponenteRequisicaoApiV2;
begin
  // Api Versão 2.0
  FRequisicao := TIdHTTP.Create(Nil);
  FRequisicao.ReadTimeout := 120000;
  FRequisicao.IOHandler := FProtocoloSSL;
  FRequisicao.Request.Connection := 'keep-alive';
  FRequisicao.Request.ContentType := 'application/json';
  FRequisicao.Request.Host := 'https://cdpj.partners.bancointer.com.br';
  FRequisicao.Request.Accept := 'application/json';
  FRequisicao.Request.CharSet := 'UTF-8';
  FRequisicao.ProtocolVersion := pv1_1;

  FRequisicao.Response.KeepAlive := True;
  FRequisicao.HTTPOptions := [];
  FRequisicao.OnWork := OnWork;

  FRequisicao.HandleRedirects := True;
end;

procedure TBancoInter.CriarComponenteRequisicaoApiV3;
begin
  // Api Versão 3.0
  FRequisicao := TIdHTTP.Create(Nil);
  FRequisicao.ReadTimeout := 120000;
  FRequisicao.IOHandler := FProtocoloSSL;
  FRequisicao.Request.CustomHeaders.Add('x-inter-conta-corrente: ' + Inttostr(StrToInt(FContaCorrente)));
  FRequisicao.Request.Connection := 'keep-alive';
  FRequisicao.Request.ContentType := 'application/json';
  FRequisicao.Request.Accept := 'application/json';
  FRequisicao.Request.CharSet := 'UTF-8';
  FRequisicao.ProtocolVersion := pv1_1;
  FRequisicao.Response.KeepAlive := True;
  FRequisicao.HTTPOptions := [];
  FRequisicao.OnWork := OnWork;

  FRequisicao.HandleRedirects := True;
end;

procedure TBancoInter.CriarProtocoloSSL;
  Var
  LBase64CRT,
  LBase64Key: WideString;

  LStream: TMemoryStream;

  LDecoder: TIdDecoderMIME;
begin
  LBase64CRT := fGetBancoConfig(0, FCarteira, 'AUTHCRT', '');
  LBase64Key := fGetBancoConfig(0, FCarteira, 'AUTHKEY', '');

  LDecoder := TIdDecoderMIME.Create(nil);
  LStream := TMemoryStream.Create;
  try
    LDecoder.DecodeStream(LBase64CRT, LStream);

    LStream.SaveToFile(FPastaInter + 'aut' + LIdConnection + 'r');
    Sleep(1000);
  finally
    LDecoder.Free;
    LStream.Free;
  end;

  LDecoder := TIdDecoderMIME.Create(nil);
  LStream := TMemoryStream.Create;
  try
    LDecoder.DecodeStream(LBase64Key, LStream);

    LStream.SaveToFile(FPastaInter + 'aut' + LIdConnection + 'y');
    Sleep(1000);
  finally
    LDecoder.Free;
    LStream.Free;
  end;

  FProtocoloSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  FProtocoloSSL.DefaultPort := 443;
  FProtocoloSSL.SSLOptions.CertFile := FPastaInter + 'aut' + LIdConnection + 'r';
  FProtocoloSSL.SSLOptions.KeyFile := FPastaInter + 'aut' + LIdConnection + 'y';
  FProtocoloSSL.SSLOptions.Method := sslvTLSv1_2;
  FProtocoloSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
  FProtocoloSSL.SSLOptions.Mode := sslmBoth;
end;

procedure TBancoInter.AguardeCincoSegundos;
begin
  Sleep(5000);
end;

function TBancoInter.CadastrarNovoBoleto(ADadosDuplicata, ADadosCliente: TDataSet): TRetornoBoletoBancoInter;
  Var
    LRetornoPost,
    LDadosRequisicao: String;

    LJsonRetorno: TJSONObject;
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
    LMensagemErro: String;
begin
  If LVersaoUtilizadaAPI = '3' Then
  Begin
     Result := CadastrarNovoBoletoV3(ADadosDuplicata, ADadosCliente);
     Exit;
  End;

  Result := TRetornoBoletoBancoInter.Create;
  LRequisicaoRegistroBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoRegistroBoleto.LCartei := FCarteira;
  Insert('-',LRequisicaoRegistroBoleto.LCartei,12);
  LRequisicaoRegistroBoleto.LCodBco := '077';

  If LUtilizaApiV2 Then LDadosRequisicao := RetornaDadosDaRequisicaoApiV2(ADadosDuplicata, ADadosCliente)
  Else LDadosRequisicao := RetornaDadosDaRequisicaoApiV1(ADadosDuplicata, ADadosCliente);

  LRequisicaoRegistroBoleto.LJsoEnv := LDadosRequisicao;
  LRequisicaoRegistroBoleto.LDuplic := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;

  Try
    Try

      If LUtilizaApiV2 Then
      Begin
        TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');
        FRequisicao.Request.CustomHeaders.AddValue('Authorization', 'Bearer ' + LDadosToken.AccessToken);
      End;

      FRequisicao.Request.Method := 'POST';
      LRetornoPost := FRequisicao.Post(FLinkAPI, LDadosRequisicao);
      LRequisicaoRegistroBoleto.LJsoRec := LRetornoPost;

      LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoPost) as TJSONObject;
      Result.nossoNumero := LJsonRetorno.GetValue<String>('nossoNumero');
      Result.seuNumero := LJsonRetorno.GetValue<String>('seuNumero');
      Result.linhaDigitavel := LJsonRetorno.GetValue<String>('linhaDigitavel');
      Result.codigoDeBarras := LJsonRetorno.GetValue<String>('codigoBarras');
    Except

      On E:EIdHTTPProtocolException Do
      Begin
        LMensagemErro := ResponseError(E.ErrorMessage);
        LMensagemErro := IIF(fEmptyStr(LMensagemErro),E.Message,LMensagemErro);
        LRequisicaoRegistroBoleto.LExcept := Concat('Error: ',E.Message,'Response: ',E.ErrorMessage);
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
        Raise Exception.Create(RetornaTextoErro(LMensagemErro));
      End;

      On E: Exception Do
      Begin
        LRequisicaoRegistroBoleto.LExcept := E.Message;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos, 'Falha na comunicação, Nova tentativa em 5 segundos.', '');
        Raise Exception.Create(RetornaTextoErro(E.Message));
      End;
    End;
  Finally
    Begin
      TRegBol.GravarRequisicaoReqistroBoleto(LRequisicaoRegistroBoleto);
      FreeAndNil(LRequisicaoRegistroBoleto);

      If FileExists(LDadosRequisicao) Then
        DeleteFile(LDadosRequisicao);
    End;
  End;
end;

function TBancoInter.RetornaCodigoSolicitacaoBoletoEmProcessamento(const AAutoincremDuplicata: string): string;
  Var
    LConsulta: TUniQuery;
begin
  Result := '';

  LConsulta := fCriaQuery(Nil);
  try
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Text :=
      'SELECT ' +
      '  CASE ' +
      '    WHEN JSON_VALID(REG_JSOENV) = 1 ' +
      '    AND JSON_EXTRACT(REG_JSOENV, ''$.seuNumero'') IS NOT NULL ' +
      '    AND JSON_EXTRACT(REG_JSOENV, ''$.valorNominal'') IS NOT NULL ' +
      '    AND JSON_EXTRACT(REG_JSOENV, ''$.dataVencimento'') IS NOT NULL ' +
      '    AND JSON_EXTRACT(REG_JSOENV, ''$.pagador'') IS NOT NULL ' +
      '    AND JSON_VALID(REG_JSOREC) = 1 ' +
      '    AND JSON_EXTRACT(REG_JSOREC, ''$.codigoSolicitacao'') IS NOT NULL ' +
      '    THEN JSON_UNQUOTE(JSON_EXTRACT(REG_JSOREC, ''$.codigoSolicitacao'')) ' +
      '    ELSE NULL ' +
      '  END AS CODIGO_SOLICITACAO ' +
      'FROM ' +
      '  REGBOL ' +
      'WHERE REG_DUPLIC = :REG_DUPLIC ' +
      '  AND IFNULL(REG_DESCRI, ''REGISTRO'') = "REGISTRO" ' +
      'ORDER BY REG_DTAREG DESC, ' +
      '  REG_HRAREG DESC ' +
      'LIMIT 1';

    LConsulta.ParamByName('REG_DUPLIC').AsString := AAutoincremDuplicata;

    try
      LConsulta.Open;

      if not LConsulta.IsEmpty then
      begin
        if not LConsulta.FieldByName('CODIGO_SOLICITACAO').IsNull then
          Result := LConsulta.FieldByName('CODIGO_SOLICITACAO').AsString;
      end;

      LConsulta.Close;
    except
      on E: Exception do
      begin
        //
      end;
    end;
  finally
    FreeAndNil(LConsulta);
  end;
end;

function TBancoInter.CadastrarNovoBoletoV3(ADadosDuplicata, ADadosCliente: TDataSet): TRetornoBoletoBancoInter;
  Var
    LRetornoPost,
    LRetornoGet,
    LDadosRequisicao: String;

    LJsonRetorno,
    LJsonRetornoGet, LJsonCobranca, LJsonBoleto: TJSONObject;
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
    LMensagemErro: String;
begin
  Self.FTentarNovamente := True;
  Result := TRetornoBoletoBancoInter.Create;
  LRequisicaoRegistroBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoRegistroBoleto.LCartei := FCarteira;
  Insert('-',LRequisicaoRegistroBoleto.LCartei,12);
  LRequisicaoRegistroBoleto.LCodBco := '077';
  LRequisicaoRegistroBoleto.FDescricao := 'REGISTRO';
  LRequisicaoRegistroBoleto.LLocImp    := 'CTR';

  LDadosRequisicao := RetornaDadosDaRequisicaoApiV3(ADadosDuplicata, ADadosCliente);

  LRequisicaoRegistroBoleto.LJsoEnv := LDadosRequisicao;
  LRequisicaoRegistroBoleto.LDuplic := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;

  Try
    Try

      TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');
      FRequisicao.Request.CustomHeaders.AddValue('Authorization', 'Bearer ' + LDadosToken.AccessToken);

      Result.codigoSolicitacao := RetornaCodigoSolicitacaoBoletoEmProcessamento(ADadosDuplicata.FieldByName('AUTOINCREM').AsString);

      If fEmptyStr(Result.codigoSolicitacao) Then
      Begin
        FRequisicao.Request.Method := 'POST';
        LRetornoPost := FRequisicao.Post(FLinkAPI, LDadosRequisicao);
        LRequisicaoRegistroBoleto.LJsoRec := LRetornoPost;

        LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoPost) as TJSONObject;
        Result.codigoSolicitacao := LJsonRetorno.GetValue<String>('codigoSolicitacao');
      End;

      // FAZ NOVA SOLICITAÇÃO PAR PEGAR OS DADOS DO BOLETO
      If Not FemptyStr(Result.codigoSolicitacao) Then
      Begin
         LRetornoGet := RetornaDadosBoletoCadastrado(Result.codigoSolicitacao);
         LRequisicaoRegistroBoleto.LJsoRec := LRetornoGet;
      End;

      LRequisicaoRegistroBoleto.LLnkApi := FLinkAPI;

      LJsonRetornoGet       := TJSONObject.ParseJSONValue(LRetornoget) as TJSONObject;

      If Assigned(LJsonRetornoGet) Then
      Begin
        LJsonCobranca := LJsonRetornoGet.GetValue<TJSONObject>('cobranca');
        if Assigned(LJsonCobranca) then
          Result.seuNumero := LJsonCobranca.GetValue<string>('seuNumero');

        LJsonBoleto := LJsonRetornoGet.GetValue<TJSONObject>('boleto');
        if Assigned(LJsonBoleto) then
        begin
          Result.nossoNumero    := LJsonBoleto.GetValue<string>('nossoNumero');
          Result.linhaDigitavel := LJsonBoleto.GetValue<string>('linhaDigitavel');
          Result.codigoDeBarras := LJsonBoleto.GetValue<string>('codigoBarras');
        end;
      End;

    Except
      On E:EIdHTTPProtocolException Do
      Begin
        LMensagemErro := LerResponseErroJSON( CorrigirEncodingUTF8(E.ErrorMessage) );
        LMensagemErro := IIF(fEmptyStr(LMensagemErro),E.Message,LMensagemErro);
        LRequisicaoRegistroBoleto.LExcept := Concat('Error: ',E.Message,'Response: ',CorrigirEncodingUTF8(E.ErrorMessage));
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
        Raise Exception.Create(RetornaTextoErro(LMensagemErro));
      End;

      On E: Exception Do
      Begin
        LRequisicaoRegistroBoleto.LExcept := E.Message;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos, 'Falha na comunicação, Nova tentativa em 5 segundos.', '');
        Raise Exception.Create(RetornaTextoErro(E.Message));
      End;
    End;
  Finally
    Begin
      TRegBol.GravarRequisicaoReqistroBoleto(LRequisicaoRegistroBoleto);
      FreeAndNil(LRequisicaoRegistroBoleto);

      If FileExists(LDadosRequisicao) Then
        DeleteFile(LDadosRequisicao);
    End;
  End;
end;

function TBancoInter.ConsultaBoletoPDF(ANossoNumero: String): String;
begin
  Try
    FRequisicao.Request.Method := 'GET';

    Result := FRequisicao.Get(FLinkAPI + ANossoNumero + '/pdf');

  Finally

  End;
end;

function TBancoInter.ConsultaBoletosPorPeriodoApiV1(ADataInicial,
  ADataFinal: String; AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoInter>;
  Var
    LRetornoGet: String;

    LPagina: Integer;

    LPaginaFinal: Boolean;

    LArrayValores: TJSONArray;

    LValorUnico,
    LValorUnico1: TJSONValue;

    LJsonRetorno: TJSONObject;

    LDadosBoleto: TRetornoPesquisaBancoInter;
begin
  Result := TList<TRetornoPesquisaBancoInter>.Create;

  LPagina := 0;
  LPaginaFinal := False;

  Try
    FRequisicao.Request.Method := 'GET';

    While (Not LPaginaFinal) Do
    Begin
      AProgresso.pgbStatus.Visible := False;
      AProgresso.lblGravando.Caption := 'Aguarde... Recebendo requisição ' + (LPagina + 1).ToString + ' da API.';
      Application.ProcessMessages;

      LRetornoGet := FRequisicao.Get(FLinkAPI +
                                     '?filtrarPor=PAGOS' +
                                     '&dataInicial=' + ADataInicial +
                                     '&dataFinal=' + ADataFinal +
                                     '&ordenarPor=SEUNUMERO' +
                                     '&filtrarDataPor=SITUACAO' +
                                     '&page=' + LPagina.ToString + '&' +
                                     'size=50');

      LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJSONObject;

      LPaginaFinal := LJsonRetorno.GetValue<String>('last') = 'true';

      LValorUnico := LJsonRetorno.GetValue('summary');

      LValorUnico1 := LValorUnico.GetValue<TJSONValue>('recebidos');

      Inc(LPagina);

      If StrToInt(LValorUnico1.GetValue<string>('quantidade')) > 0 Then
      Begin
        LArrayValores := LJsonRetorno.GetValue<TJSONArray>('content');

        For LValorUnico1 In LArrayValores Do
        Begin
          LDadosBoleto := TRetornoPesquisaBancoInter.Create;
          LDadosBoleto.nossoNumero := LValorUnico1.GetValue<string>('nossoNumero');
          LDadosBoleto.seuNumero := LValorUnico1.GetValue<string>('seuNumero');
          LDadosBoleto.linhaDigitavel := LValorUnico1.GetValue<string>('linhaDigitavel');
          LDadosBoleto.dataPagamento := LValorUnico1.GetValue<string>('dataPagtoBaixa');
          LDadosBoleto.valorPago := fRetSomenteNumeros(LValorUnico1.GetValue<string>('valorTotalRecebimento'));
          LDadosBoleto.valorMulta := fRetSomenteNumeros(LValorUnico1.GetValue<string>('valorMulta')); // precisamos verificar
          LDadosBoleto.valorMora := fRetSomenteNumeros(LValorUnico1.GetValue<string>('valorJuros')); // precisamos verificar
          LDadosBoleto.dataVencimento := LValorUnico1.GetValue<string>('dataVencimento');
          LDadosBoleto.dataEmissao := LValorUnico1.GetValue<string>('dataEmissao');
          LDadosBoleto.valorDuplicata := fRetSomenteNumeros(LValorUnico1.GetValue<string>('valorNominal'));

          LDadosBoleto.valorDesconto := '0';
          LDadosBoleto.valorJuros := '0';

          If (StrToInt64(LDadosBoleto.valorPago) > StrToInt64(LDadosBoleto.valorDuplicata)) Then
            LDadosBoleto.valorJuros := (StrToInt64(LDadosBoleto.valorPago) - StrToInt64(LDadosBoleto.valorDuplicata)).ToString;

          If (StrToInt64(LDadosBoleto.valorPago) < StrToInt64(LDadosBoleto.valorDuplicata)) Then
            LDadosBoleto.valorDesconto := (StrToInt64(LDadosBoleto.valorDuplicata) - StrToInt64(LDadosBoleto.valorPago)).ToString;

          Result.Add(LDadosBoleto);
        End;

        FreeAndNil(LArrayValores);
      End;
    End;
  Except

    On E:EIdHTTPProtocolException Do
    Begin
      ExibeFormMensagemErro( RetornaTextoErro(IIF(fEmptyStr(E.ErrorMessage),E.Message,E.ErrorMessage)) );
    End;

    On E: Exception Do
    Begin
      ExibeFormMensagemErro( RetornaTextoErro(E.Message) );
    End;

  End;

end;

function TBancoInter.ConsultaBoletosPorPeriodoApiV2(ADataInicial,
  ADataFinal: String;
  AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoInter>;
  Var
    LRetornoGet: String;

    LPagina: Integer;

    LPaginaFinal: Boolean;

    LArrayValores: TJSONArray;

    LValorUnico: TJSONValue;

    LJsonRetorno: TJSONObject;

    LDadosBoleto: TRetornoPesquisaBancoInter;
begin
  Result := TList<TRetornoPesquisaBancoInter>.Create;

  LPagina := 0;
  LPaginaFinal := False;

  Try

    TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');
    FRequisicao.Request.CustomHeaders.AddValue('Authorization', 'Bearer ' + LDadosToken.AccessToken);
    FRequisicao.Request.CustomHeaders.AddValue('Content-Type', 'application/json');


    FRequisicao.Request.Method := 'GET';

    While (Not LPaginaFinal) Do
    Begin
      AProgresso.pgbStatus.Visible := False;
      AProgresso.lblGravando.Caption := 'Aguarde... Recebendo requisição ' + (LPagina + 1).ToString + ' da API.';
      Application.ProcessMessages;

      LRetornoGet := FRequisicao.Get(FLinkAPI +
                                     '?situacao=PAGO' +
                                     '&dataInicial=' + ADataInicial +
                                     '&dataFinal=' + ADataFinal +
                                     '&ordenarPor=SEUNUMERO' +
                                     '&filtrarDataPor=SITUACAO' +
                                     '&paginaAtual=' + LPagina.ToString + '&' +
                                     'itensPorPagina=50');

      LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJSONObject;

      LPaginaFinal := LJsonRetorno.GetValue<String>('last') = 'true';

      Inc(LPagina);

      If StrToInt(LJsonRetorno.GetValue<string>('numberOfElements')) > 0 Then
      Begin
        LArrayValores := LJsonRetorno.GetValue<TJSONArray>('content');

        For LValorUnico In LArrayValores Do
        Begin
          LDadosBoleto := TRetornoPesquisaBancoInter.Create;
          LDadosBoleto.nossoNumero := LValorUnico.GetValue<string>('nossoNumero');
          LDadosBoleto.seuNumero := LValorUnico.GetValue<string>('seuNumero');
          LDadosBoleto.linhaDigitavel := LValorUnico.GetValue<string>('linhaDigitavel');
          LDadosBoleto.dataPagamento := FormatDateTime('DD/MM/YYYY', LValorUnico.GetValue<TDateTime>('dataHoraSituacao'));
          LDadosBoleto.valorPago := fRetSomenteNumeros(LValorUnico.GetValue<string>('valorTotalRecebimento'));
          LDadosBoleto.dataVencimento := FormatDateTime('DD/MM/YYYY', LValorUnico.GetValue<TDateTime>('dataVencimento'));
          LDadosBoleto.dataEmissao := LValorUnico.GetValue<string>('dataEmissao');
          LDadosBoleto.valorDuplicata := fRetSomenteNumeros(LValorUnico.GetValue<string>('valorNominal'));

          LDadosBoleto.valorDesconto := '0';
          LDadosBoleto.valorJuros := '0';

          If (StrToInt64(LDadosBoleto.valorPago) > StrToInt64(LDadosBoleto.valorDuplicata)) Then
            LDadosBoleto.valorJuros := (StrToInt64(LDadosBoleto.valorPago) - StrToInt64(LDadosBoleto.valorDuplicata)).ToString;

          If (StrToInt64(LDadosBoleto.valorPago) < StrToInt64(LDadosBoleto.valorDuplicata)) Then
            LDadosBoleto.valorDesconto := (StrToInt64(LDadosBoleto.valorDuplicata) - StrToInt64(LDadosBoleto.valorPago)).ToString;

          Result.Add(LDadosBoleto);
        End;

        FreeAndNil(LArrayValores);
      End;
    End;
  Except

    On E:EIdHTTPProtocolException Do
    Begin
      ExibeFormMensagemErro( RetornaTextoErro(IIF(fEmptyStr(E.ErrorMessage),E.Message,E.ErrorMessage)) );
    End;

    On E: Exception Do
    Begin
      ExibeFormMensagemErro( RetornaTextoErro(E.Message) );
    End;

  End;

end;

function TBancoInter.ConsultaBoletosPorPeriodoApiV3(ADataInicial,
  ADataFinal: String;
  AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoInter>;
  Var
    LRetornoGet: String;

    LPagina: Integer;

    LPaginaFinal: Boolean;

    LArrayValores: TJSONArray;

    LValorUnico: TJSONValue;

    LJsonRetorno,
    LJsonCobranca, LJsonBoleto: TJSONObject;

    LDadosBoleto: TRetornoPesquisaBancoInter;

    LValorStr: string;
    Lmensagem: String;
begin
  Result := TList<TRetornoPesquisaBancoInter>.Create;

  LPagina := 0;
  LPaginaFinal := False;

  Try

    TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');
    FRequisicao.Request.CustomHeaders.AddValue('Authorization', 'Bearer ' + LDadosToken.AccessToken);
    FRequisicao.Request.CustomHeaders.AddValue('Content-Type', 'application/json');

    FRequisicao.Request.Method := 'GET';

    While (Not LPaginaFinal) Do
    Begin
      AProgresso.pgbStatus.Visible := False;
      AProgresso.lblGravando.Caption := 'Aguarde... Recebendo requisição ' + (LPagina + 1).ToString + ' da API.';
      Application.ProcessMessages;

      LRetornoGet := FRequisicao.Get(FLinkAPI +
                                     '?dataInicial=' + ADataInicial +
                                     '&dataFinal=' + ADataFinal +
                                     '&situacao=RECEBIDO' +
                                     '&ordenarPor=IDENTIFICADOR' +
                                     '&filtrarDataPor=PAGAMENTO' +
                                     '&paginaAtual=' + LPagina.ToString +
                                     '&itensPorPagina=100');

      LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJSONObject;

      LPaginaFinal := LJsonRetorno.GetValue<String>('ultimaPagina') = 'true';

      Inc(LPagina);

      If StrToInt(LJsonRetorno.GetValue<string>('numeroDeElementos')) > 0 Then
      Begin
        LArrayValores := LJsonRetorno.GetValue<TJSONArray>('cobrancas');

        If Assigned(LArrayValores) Then
        Begin

           For LValorUnico In LArrayValores Do
           Begin

             LDadosBoleto := TRetornoPesquisaBancoInter.Create;

             // Dados Cobrança
             LJsonCobranca := LValorUnico.GetValue<TJSONObject>('cobranca');
             If Assigned(LJsonCobranca) Then
             Begin
                LDadosBoleto.seuNumero     := LJsonCobranca.GetValue<string>('seuNumero');

                LDadosBoleto.dataPagamento  := FormatDateTime('DD/MM/YYYY', LJsonCobranca.GetValue<TDateTime>('dataSituacao'));

                LValorStr := LJsonCobranca.GetValue<string>('valorTotalRecebido');
                LValorStr := StringReplace(LValorStr, '.', ',', [rfReplaceAll]);
                LDadosBoleto.valorPago      := fRetSomenteNumeros(FormatFloat('0.00', StrToFloat(LValorStr)));

                LDadosBoleto.dataVencimento := FormatDateTime('DD/MM/YYYY', LJsonCobranca.GetValue<TDateTime>('dataVencimento'));
                LDadosBoleto.dataEmissao    := FormatDateTime('DD/MM/YYYY', LJsonCobranca.GetValue<TDateTime>('dataEmissao'));

                LValorStr := LJsonCobranca.GetValue<string>('valorNominal');
                LValorStr := StringReplace(LValorStr, '.', ',', [rfReplaceAll]);
                LDadosBoleto.valorDuplicata := fRetSomenteNumeros(FormatFloat('0.00', StrToFloat(LValorStr)));
             End;

             // Dados Boleto
             LJsonBoleto := LValorUnico.GetValue<TJSONObject>('boleto');
             If Assigned(LJsonBoleto) Then
             Begin
               LDadosBoleto.nossoNumero    := LJsonBoleto.GetValue<string>('nossoNumero');
               LDadosBoleto.linhaDigitavel := LJsonBoleto.GetValue<string>('linhaDigitavel');
             End;

             LDadosBoleto.valorDesconto := '0';
             LDadosBoleto.valorJuros    := '0';

             If (StrToInt64(LDadosBoleto.valorPago) > StrToInt64(LDadosBoleto.valorDuplicata)) Then
               LDadosBoleto.valorJuros := (StrToInt64(LDadosBoleto.valorPago) - StrToInt64(LDadosBoleto.valorDuplicata)).ToString;

             If (StrToInt64(LDadosBoleto.valorPago) < StrToInt64(LDadosBoleto.valorDuplicata)) Then
               LDadosBoleto.valorDesconto := (StrToInt64(LDadosBoleto.valorDuplicata) - StrToInt64(LDadosBoleto.valorPago)).ToString;

             Result.Add(LDadosBoleto);

           End;

        End;

        FreeAndNil(LArrayValores);
      End;

    End;
  Except

    On E:EIdHTTPProtocolException Do
    Begin
      Lmensagem := LerResponseErroJSON( CorrigirEncodingUTF8(IIF(fEmptyStr(E.ErrorMessage),E.Message,E.ErrorMessage)) );
      ExibeFormMensagemErro( RetornaTextoErro(Lmensagem) );
    End;

    On E: Exception Do
    Begin
      Lmensagem := CorrigirEncodingUTF8(E.Message);
      ExibeFormMensagemErro( RetornaTextoErro(Lmensagem) );
    End;

  End;

end;

procedure TBancoInter.DefinirURL;
begin
  FLinkTokenAPI := '';
  FLinkApi      := '';

  If LUtilizaApiV2 Then FLinkAPI := 'https://cdpj.partners.bancointer.com.br/cobranca/v2/boletos/'
  Else If LVersaoUtilizadaAPI = '1' Then
     FLinkAPI := 'https://apis.bancointer.com.br/openbanking/v1/certificado/boletos/'
  Else If LVersaoUtilizadaAPI = '3' Then
  Begin
     FLinkTokenAPI := IIF( (FAmbiente = '0'),C_URL_OAUTH_HOM, C_URL_OAUTH_PROD);
     FLinkApi      := IIF( (FAmbiente = '0'),C_URL_HOM, C_URL);
  End;

  FPastaInter := ExtractFilePath(Application.ExeName)+ 'API_INTER\';
  If Not DirectoryExists(FPastaInter) Then
    CreateDir(ExtractFilePath(FPastaInter));
end;

destructor TBancoInter.Destroy;
  Var
    LArquivoCRT,
    LArquivoKey: String;
begin
  LArquivoCRT := FProtocoloSSL.SSLOptions.CertFile;
  LArquivoKEY := FProtocoloSSL.SSLOptions.KeyFile;

  FreeAndNil(FRequisicao);
  FreeAndNil(FProtocoloSSL);
  FreeAndNil(FListaRequisicaoRegistroBoleto);

  DeleteFile(LArquivoCRT);
  DeleteFile(LArquivoKEY);
  inherited;
end;

procedure TBancoInter.GerarToken;
  Var
    LRequisicao: TidHTTP;
    LParametros: TStringList;
    LResposta: String;
    LJsonObject: TJSONObject;
begin

  If Assigned(LDadosToken) Then
  Begin
    If (LDadosToken.RefreshTime >= fNow) And fEmptyStr(LDadosToken.Exception) Then
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
      LParametros.Add('scope=boleto-cobranca.write boleto-cobranca.read');

      LParametros.Add('client_id=' + LClient_ID);
      LParametros.Add('client_secret=' + LClient_Secret);

      LRequisicao := TIdHTTP.Create(Nil);
      LRequisicao.OnWork := OnWork;
      LRequisicao.IOHandler := FProtocoloSSL;
      LRequisicao.Request.ContentType := 'application/x-www-form-urlencoded';

      Application.ProcessMessages;

      If LUtilizaApiV2 Then
         LResposta := LRequisicao.Post('https://cdpj.partners.bancointer.com.br/oauth/v2/token', LParametros)
      Else
         LResposta := LRequisicao.Post(FLinkTokenAPI, LParametros);

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
                                'PRODUÇÃO. Erro:' + E.ErrorMessage;
    End;

    On E: Exception Do
    Begin
      LDadosToken.Exception := 'Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                               'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                               'PRODUÇÃO. Erro:' + E.Message;
    End;

  End;
end;

procedure TBancoInter.OnWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;

{ TDadosToken }

function TDadosToken.GetAccessToken: String;
begin
  If Not fEmptyStr(Self.Exception) Then
    Raise SysUtils.Exception.Create(Self.Exception)
  Else
    Result := Self.Access_Token;
end;

function TBancoInter.RetornaTextoErro(ADadosRetorno: String): String;
 Var
   LErroInstabilidade,
   LErroAutenticacao : String;
begin
  Result := ADadosRetorno;

  LErroInstabilidade := 'Ocorreu um erro não identificado no servidor do banco. Tente novamente mais tarde! ';

  LErroAutenticacao  := 'Ocorreu um erro ao realizar a autenticação na API do Banco.';

  If fEmptyStr(ADadosRetorno) Then
  Begin
     Result := LErroInstabilidade;
     Exit;
  End;

  // Verifica se é erro de authenticação - gerar token
  If (Pos(LErroAutenticacao, ADadosRetorno) > 0) Then
  Begin
     Result := LErroAutenticacao;
     Exit;
  End;

end;

procedure TBancoInter.ExibeFormMensagemErro(AMensagem: String);
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

function TBancoInter.RetornaGrupoDescontosV3(ADadosDuplicata: TDataset): String;
  Var
    LValorDesconto: Double;

    LVencimentoPontualidade: TDateTime;

    LGrupo2Valor: Boolean;
begin
  LValorDesconto := fFormataFloat(ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat, 2);

  If (ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat > 0) Then
  Begin
    If FTrabalhaComPontualidade Then
    Begin

      LValorDesconto := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat *
                                      (ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat / 100), 2);

      LVencimentoPontualidade := ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime -
                                 ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger;

      LGrupo2Valor := LVencimentoPontualidade <> ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime;
      If LGrupo2Valor Then
        LGrupo2Valor := ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0;

      LValorDesconto := fFormataFloat(LValorDesconto + IIF(LGrupo2Valor, 0, ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat), 2);

      If LValorDesconto = 0 Then
      Begin
        Result := Concat('"desconto":{'+ #13 + #9 +#9,
                                        '"taxa":' + RetornaCampoDecimalJSON(fFormataFloat(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat, 2).ToString) + ','+ #13 + #9 +#9,
                                        '"codigo":"PERCENTUALDATAINFORMADA",'+ #13 + #9 +#9,
                                        '"quantidadeDias":"' + ADadosDuplicata.FieldByName('CTR_QTDDAV').AsString + '"'+ #13 + #9,
                                    '},'+ #13 + #9);

        Exit;
      End;
    End;
  End;

  If LValorDesconto > 0 Then
  Begin
    Result := Concat('"desconto":{'+ #13 + #9 +#9,
                                    '"valor":' + RetornaCampoDecimalJSON(LValorDesconto.ToString) + ','+ #13 + #9 +#9,
                                    '"codigo":"VALORFIXODATAINFORMADA",'+ #13 + #9 +#9,
                                    '"quantidadeDias":"' + ADadosDuplicata.FieldByName('CTR_QTDDAV').AsString + '"'+ #13 + #9,
                                 '},'+ #13 + #9);
  End;

end;

function TBancoInter.RetornaGrupoMultaV3(ADadosDuplicata: TDataset): String;
  Var
    LValorMulta: Double;
begin
  LValorMulta := 0;
  If FPercentualMulta = 0 Then
    FPercentualMulta := fStrToFloat(fGetBancoConfig(0, FCarteira, 'PERMULT', ''));

  If FPercentualMulta > 0 Then
  Begin
    LValorMulta := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat *
                                 (FPercentualMulta / 100), 2);

    Result := Concat('"multa":{'+ #13 + #9 +#9,
                                '"valor":' + RetornaCampoDecimalJSON(LValorMulta.ToString) + ','+ #13 + #9 +#9,
                                '"codigo":"VALORFIXO"'+ #13 + #9 +#9,
                             '},'+ #13 + #9);
  End;
end;

function TBancoInter.RetornaGrupoMoraV3(ADadosDuplicata: TDataset): String;
  Var
    LValorMora: Double;
begin
  If FPercentualMora > 0 Then
  Begin
    LValorMora := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (FPercentualMora / 100), 2);

    Result := Concat('"mora":{'+ #13 + #9 +#9,
                        '"valor":' + RetornaCampoDecimalJSON((fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (FPercentualMora / 100), 2)).ToString) + ','+ #13 + #9 +#9,
                        '"codigo":"VALORDIA"'+ #13 + #9 +#9,
                      '},'+ #13 + #9);

    If LValorMora = 0 Then
    Begin
      Result := Concat('"mora":{'+ #13 + #9 +#9,
                                 '"taxa":' + RetornaCampoDecimalJSON(fFormataFloat(FPercentualMora * 30, 2).ToString) + ',' + #13 + #9 +#9 +
                                 '"codigo":"TAXAMENSAL"'+ #13 + #9 +#9,
                               '},'+ #13 + #9);
    End;
  End;

end;

function TBancoInter.RetornaBeneficiarioFinalV3(): String;
Begin
   Result := '';

   If FUsaSacadorAvalista = 'S' Then
   Begin
      Result := Concat('"beneficiarioFinal":{ '+ #13 + #9 + #9,
                                             '"cpfCnpj": "' + fTiraCaracEspeciaisPonto(FCNPJBeneficiario) + '",'+ #13 + #9 + #9,
                                             '"tipoPessoa":"' + IIF(FCNPJBeneficiario = '2', 'FISICA', 'JURIDICA') +'",'+ #13 + #9 + #9,
                                             '"nome":"' + RetornaValorString(FNomeBeneficiario, 100) + '",'+ #13 + #9 + #9,
                                             '"endereco":"' + RetornaValorString(FEnderecoBeneficiario) + '",'+ #13 + #9 + #9,
                                             '"bairro":"' + RetornaValorString(FBairroBeneficiario, 60) + '",'+ #13 + #9 + #9,
                                             '"cidade":"' + RetornaValorString(FCidadeBeneficiario, 60) + '",'+ #13 + #9 + #9,
                                             '"uf":"' + RetornaValorString(FUFBeneficiario) + '",'+ #13 + #9 + #9,
                                             '"cep":"' + fRetSomenteNumeros(FCEPBeneficiario) + '"'+ #13 + #9 + #9,
                                           '}'+ #13 + #9);
   End;

End;

function TBancoInter.CorrigirUltimaVirgulaJson(const JsonStr: string): string;
var
  S: string;
  I: Integer;
begin
  S := TrimRight(JsonStr);

  if S = '' then
    Exit(S);

  // começa do fim da string e ignora espaços e quebras de linha
  I := Length(S);
  while (I > 0) and CharInSet(S[I], [#9, #10, #13, ' ']) do
    Dec(I);

  if I <= 2 then
    Exit(S);

  // se o último caractere é '}' ou ']', procura uma vírgula antes dele
  if CharInSet(S[I], ['}', ']']) then
  begin
    // volta até achar um caractere não espaço antes do fechamento
    Dec(I);
    while (I > 0) and CharInSet(S[I], [#9, #10, #13, ' ']) do
      Dec(I);

    // se esse caractere for vírgula, remove
    if (I > 0) and (S[I] = ',') then
      Delete(S, I, 1);
  end;

  Result := S;
end;

function TBancoInter.LerResponseErroJSON(const AJSONString: string): string;
var
  LJsonObj: TJSONObject;
  LJsonArray: TJSONArray;
  LItem: TJSONValue;
  LTitle, LDetail, LStatusStr, LMsg: string;
  LRazao, LProp, LVal: string;
  I: Integer;
begin
  Result := '';
  Try
    LJsonObj := TJSONObject.ParseJSONValue(AJSONString) as TJSONObject;
    Try
      if LJsonObj = nil then
         raise Exception.Create('JSON inválido');

      LTitle     := LJsonObj.GetValue<string>('title',  '');
      LDetail    := LJsonObj.GetValue<string>('detail', '');
      LStatusStr := LJsonObj.GetValue<string>('status', '');

      LMsg := '';
      If LStatusStr <> '' then
         LMsg := LMsg + 'Status: ' + LStatusStr + sLineBreak;
      If LTitle <> '' then
         LMsg := LMsg + 'Título: ' + LTitle + sLineBreak;
      If LDetail <> '' then
         LMsg := LMsg + 'Detalhe: ' + LDetail + sLineBreak;

      If LJsonObj.TryGetValue<TJSONArray>('violacoes', LJsonArray) Then
      Begin

        If LJsonArray.Count > 0 Then
           LMsg := LMsg + 'Violações:' + sLineBreak;

        For I := 0 to LJsonArray.Count - 1 Do
        Begin
          LItem := LJsonArray.Items[I];

          If LItem is TJSONObject Then
          Begin
            LRazao := (LItem as TJSONObject).GetValue<string>('razao', '');
            LProp  := (LItem as TJSONObject).GetValue<string>('propriedade', '');
            LVal   := (LItem as TJSONObject).GetValue<string>('valor', '');
            LMsg   := LMsg + Format('- Razão: %s%s', [LRazao, sLineBreak]);

            if LProp <> '' then
               LMsg := LMsg + Format('  Propriedade: %s%s', [LProp, sLineBreak]);

            if LVal <> '' then
               LMsg := LMsg + Format('  Valor: %s%s', [LVal, sLineBreak]);
          End;

        End;

      End;

      Result := Trim(LMsg);
    Finally
      LJsonObj.Free;
    End;
  Except
    on E: Exception do
       Result := 'Erro ao ler JSON: ' + E.Message;
  End;
end;

Function TBancoInter.CorrigirEncodingUTF8(const Texto: String): string;
Var
  Bytes: TBytes;
Begin
  Result :=  Texto;

  If LVersaoUtilizadaAPI.Equals('3') Then
    Exit;

  Bytes  := TEncoding.ANSI.GetBytes(Texto);
  Result := TEncoding.UTF8.GetString(Bytes);
End;

function TBancoInter.RetornaCodigoSolicitacaoRegBol( AAutoinc : String ): String;
  Var
    LPesquisa: TUniQuery;
    LRetornoGet: String;
    LJsonRetornoGet, LJsonCobranca : TJSONObject;
begin
  Result := '';

  Try
    LPesquisa := fCriaQuery;
    LPesquisa.SQL.Text := ' SELECT REG_JSOREC FROM REGBOL '+
                          '  WHERE REG_CODBCO = :CODBCO AND REG_DUPLIC = :AUTINC '+
                          '    AND REG_EXCEPT IS NULL ';
    LPesquisa.ParamByName('AUTINC').AsString := AAutoinc;
    LPesquisa.ParamByName('CODBCO').AsString := '077';
    LPesquisa.Open;

    If LPesquisa.IsEmpty Then
       Exit;

    Try
      LRetornoGet := trim(LPesquisa.FieldByName('REG_JSOREC').AsString);

      LJsonRetornoGet := TJSONObject.ParseJSONValue(LRetornoget) as TJSONObject;

      If Assigned(LJsonRetornoGet) Then
      Begin
        LJsonCobranca := LJsonRetornoGet.GetValue<TJSONObject>('cobranca');
        if Assigned(LJsonCobranca) then
           Result := LJsonCobranca.GetValue<String>('codigoSolicitacao');
      End;

    Except

    End;

  Finally
    FreeAndNil(LPesquisa);
  End;

end;

procedure TBancoInter.CancelarBoletos(ADataSet: TDataSet);
  Var
    LDocumentosRestantes: String;

    LErroAPI: Boolean;

    LContadorTentativas: Integer;
begin
  Try
    LContadorTentativas := 1;
    LErroAPI := False;
    ADataSet.First;

   {$IFNDEF LINUX}
    frmGravandoGenericProcedure.pgbStatus.Visible := True;
    frmGravandoGenericProcedure.pgbStatus.Position := 0;
    frmGravandoGenericProcedure.pgbStatus.Properties.Max := ADataSet.RecordCount;
   {$ENDIF}

    While (LContadorTentativas <= 2) Do
    Begin
      Try

        While Not ADataSet.Eof Do
        Begin
          BaixaBoletoRegistrado(ADataSet);

          ADataSet.Next;

         {$IFNDEF LINUX}
          pStep(frmGravandoGenericProcedure.pgbStatus);
         {$ENDIF}
          LContadorTentativas := 0;
        End;

        LErroAPI := False;

      Except
        On E:Exception Do
        begin
          LErroAPI := True;

          If (LContadorTentativas >= 2) Then
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

            ExibeFormMensagemErro('Ocorreram erros ao cancelar o(s) boleto(s) no Banco Inter [Online].' + #13#10 + E.Message + #13#10 +
                                  'Documento(s) ficaram sem cancelar o boleto: ' + LDocumentosRestantes);

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

   {$IFNDEF LINUX}
    frmGravandoGenericProcedure.pgbStatus.Visible := False;
   {$ENDIF}
  Finally
    GravarDadosRequisicaoRegistroBoleto;
  End
end;

procedure TBancoInter.BaixaBoletoRegistrado(ADataSet: TDataSet);
  Var
    LUrl,
    LRetornoPost,
    LcodigoSolicitacao : String;
    LRequisicaoAlteraBoleto: TRequisicaoRegistroBoleto;
    LStream: TStringStream;
    LJsonBody: TJSONObject;
begin

  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;
  LRequisicaoAlteraBoleto.LCartei    := FCarteira;
  LRequisicaoAlteraBoleto.LCodBco    := '077';
  LRequisicaoAlteraBoleto.FDescricao := 'CANCELAMENTO';
  LRequisicaoAlteraBoleto.LLocImp    := 'ATB';

  Try
    Try

      LcodigoSolicitacao := RetornaCodigoSolicitacaoRegBol(ADataSet.FieldByName('AUTOINCREM').AsString);

      LJsonBody := TJSONObject.Create;

      LJsonBody.AddPair('motivoCancelamento', 'Cancelamento boleto - AutCom');
      LStream := TStringStream.Create(LJsonBody.ToJSON, TEncoding.UTF8);

      LURL := FLinkAPI + '/' + LcodigoSolicitacao + '/cancelar';
      LRequisicaoAlteraBoleto.FRequisicao := LJsonBody.ToJSON;
      LRequisicaoAlteraBoleto.LDuplic := ADataSet.FieldByName('AUTOINCREM').AsString;

      TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');
      FRequisicao.Request.CustomHeaders.AddValue('Authorization', 'Bearer ' + LDadosToken.AccessToken);
      FRequisicao.Request.ContentType := 'application/json; charset=UTF-8';
      FRequisicao.Request.Accept  := 'application/problem+json';
      FRequisicao.Request.CharSet := 'utf-8';

      FRequisicao.Request.Method := 'POST';

      LRetornoPost := FRequisicao.Post(LURL, LStream);
      LRequisicaoAlteraBoleto.LJsoRec := LRetornoPost;
      LRequisicaoAlteraBoleto.LLnkApi := LURL;

      If MatchStr(FRequisicao.ResponseCode.ToString, ['200','202']) Then
      Begin
        fStartTransaction;
        LimpaDadosBoleto(ADataSet.FieldByName('AUTOINCREM').AsString);

        untLogCtr.GravaLogCtr(ADataSet.FieldByName('AUTOINCREM').AsString,
                              'CANCELAMENTO DE BOLETO - BANCO INTER [ONLINE]',
                              'TBancoInter');
        fCommit;
      End;

    Except

      On E: Exception Do
      Begin
        LRequisicaoAlteraBoleto.LExcept := CorrigirEncodingUTF8(E.Message);
       {$IFDEF LINUX}
        AguardeCincoSegundos;
       {$ELSE}
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
       {$ENDIF}

        Raise Exception.Create(RetornaTextoErro( LerResponseErroJSON(CorrigirEncodingUTF8(E.Message))) );
      End;

    End;
  Finally
    FListaRequisicaoRegistroBoleto.Add(LRequisicaoAlteraBoleto);
  End;

end;

procedure TBancoInter.GravarDadosRequisicaoRegistroBoleto;
  Var
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
begin
  If Assigned(FListaRequisicaoRegistroBoleto) Then
  Begin
    If FListaRequisicaoRegistroBoleto.Count > 0 Then
    Begin
      For LRequisicaoRegistroBoleto In FListaRequisicaoRegistroBoleto Do
        TRegBol.GravarRequisicaoReqistroBoleto(LRequisicaoRegistroBoleto);
    End;

    FListaRequisicaoRegistroBoleto.Clear;
  End;
end;

end.
