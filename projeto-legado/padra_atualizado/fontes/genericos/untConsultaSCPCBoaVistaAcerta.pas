unit untConsultaSCPCBoaVistaAcerta;

interface

uses Classes, System.SysUtils, StrUtils, idHTTP, IdURI, IdSSLOpenSSL, MSHTML, JSON, MaskUtils,
  System.Generics.Collections, System.Variants, EditFocus, Forms, untConsultaSCPC, untDMPageProducer,
  IPPeerClient, REST.Client, Rest.Types;

type
  //*****************************************
  //* Dados da consulta de pessoa jurídica  *
  //**************************************RS*
  TIdentificacaoPJ = class
  private
    FRazaoSocial: String;
    FCnpj: String;
    FNire: String;
    FNomeFantasia: String;
    FRazaoAnterior: String;
    FDataRazao: String;
    FDataFundacao: String;
    FDataEncerramento: String;
    FInscrEst: String;
    FSituacaoCnpj: String;
    FDataCnpj: TDate;
    FConsultaCnpj: TDate;
    FSituacaoSintegra: String;
    FDataSintegra: TDate;
    FConsultaSintegra: TDate;
    FNaturezaJuridica: String;
    FFaixaFuncionarios: String;
    FFiliais: Integer;
    FCnaePri: String;
    FCnaeSec: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TLocalizacaoPJ = class
  private
    FEndereco: String;
    FBairro: String;
    FCidadeUF: String;
    FCep: String;
    FEnderecoMatriz: String;
    FBairroMatriz: String;
    FCidadeUFMatriz: String;
    FCepMatriz: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TComportamentoPagamentoPJ = class
  private
    FQtdFornecedores: Integer;
    FQtdTitulos: Integer;
    FAVista: Double;
    FPotual: Double;
    FAtraso6_15: Double;
    FAtraso16_30: Double;
    FAtraso31_60: Double;
    FAtraso61_: Double;
    FAtrasoMedio: Double;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TComportamentosPagamentoPJ = class
  private
    FComportamentos: TObjectList<TComportamentoPagamentoPJ>;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TReferenciasNegociosPJ = class
  private
    FDataUltimaCompra: String;
    FValorUltimaCompra: Double;
    FMediaUltimacompra: Double;
    FDataMaiorFatura: String;
    FValorMaiorFatura: Double;
    FMediaMaiorFatura: Double;
    FDataMaiorCredito: String;
    FValorMaiorCredito: Double;
    FMediaMaiorCredito: Double;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TPendenciaPJ = class
    FData: String;
    FCredor: String;
    FValor: Double;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TPendenciasPJ = class
    FQtdPendencias: Integer;
    FQtdCredores: Integer;
    FValorTotal: Double;
    FDataPrimeiro: String;
    FValorPrimeiro: Double;
    FDataMaior: String;
    FValorMaior: Double;
    FPendencias: TObjectList<TPendenciaPJ>;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TChequeSustadoPJ = class
  private
    FData: String;
    FBanco: String;
    FAgencia: String;
    FCheques: String;
    FDataOcorrencia: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TChequesSustadosPJ = Class
  private
    FDataIni: TDate;
    FDataFin: TDate;
    FCheques: TObjectList<TChequeSustadoPJ>;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TChequeSemFundoPJ = Class
  private
    FQuantidade: Integer;
    FDataUltimo: String;
    FBanco: String;
    FAgencia: String;
    FMotivo: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
    property intQuantidade: Integer read FQuantidade;
  End;

  TChequesSemFundoPJ = class
  private
    FCheques: TObjectList<TChequeSemFundoPJ>;
    function fGetCount: Integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
    property intCount: Integer read fGetCount;
  End;

  TProtestoPJ = class
  private
    FData: String;
    FVencimento: String;
    FCartorio: String;
    FCidade: String;
    FEstado: String;
    FValor: Double;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TProtestosPJ = class
  private
    FQtdTotal: Integer;
    FValorTotal: Double;
    FDataPrimeiro: String;
    FValorPrimeiro: Double;
    FDataMaior: String;
    FValorMaior: Double;
    FUltimosProtestos: TObjectList<TProtestoPJ>;
    function fGetCount: Integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
    property intCount: Integer read fGetCount;
  End;

  TAcaoPJ = class
  private
    FQuantidade: Integer;
    FTipo: String;
    FData: String;
    FVara: String;
    FUF: String;
    FCidade: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TAcoesPJ = class
  private
    FAcoes: TObjectList<TAcaoPJ>;
    function fGetCount: Integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
    property intCount: Integer read fGetCount;
  End;

  //*****************************************
  //* Classe consulta Boa Vista             *
  //**************************************RS*
  TConsultaSCPCBoaVistaAcerta = class(TConsultaSCPC)
  private
    cltCliente  : TRestClient;
    rspResponse : TRestResponse;
    reqRequest  : TRestRequest;

    FHTTP: TidHTTP;
    FSSL : TIdSSLIOHandlerSocketOpenSSL;
    FEntidade: String;
    FLogin: String;
    FSenha: String;
    FToken: String;
    FTokenBearer: String;
    FDocConsulta: String;
    FResp: String;
    FMsgErro: String;
    FSucesso: Boolean;
    FRestClient: Boolean;
    FPessoaFisica: Boolean;

    FIdentificacaoPJ: TIdentificacaoPJ;
    FLocalizacaoPJ: TLocalizacaoPJ;
    FComportamentosPJ: TComportamentosPagamentoPJ;
    FReferenciasNegociosPJ: TReferenciasNegociosPJ;
    FPendenciasPJ: TPendenciasPJ;
    FChequesSustadosPJ: TChequesSustadosPJ;
    FChequesSemFundoPJ: TChequesSemFundoPJ;
    FProtestosPJ: TProtestosPJ;
    FAcoesPJ: TAcoesPJ;
    FDMPageProducer: TdmPageProducer;

    strAcertaPnDebitos,
    strAcertaPnConsultasAnteriores,
    strAcertaPnChequesSemFundo,
    strAcertaPnChequesSustadoMotivo21,
    strAcertaPnProtestos,
    strAcertaPnDevolucoesUsuario: String;

    strAcertaRegistrosDebitos,
    strAcertaProtestos,
    strAcertaConsultasAnteriores,
    strAcertaChequesSemFundos,
    strAcertaChequesSustados,
    strAcertaChequesDevolucoes,
    strAcertaPainel,
    strAcertaScore: String;

    procedure pParseResponse(strResponse: String);
    procedure pParsePJ(varDoc: OleVariant);
    function fVerTableHead(varElement: OleVariant; strTitulo: String): Boolean;
    function fAcentua(strTexto: String): String;
    function fProcessaRetornoPF(strResp:String):Boolean;
    function fAcertaChequesDevolucoes(strJson: String): String;
    function fAcertaChequesSemFundos(strJson: String): String;
    function fAcertaChequesSustados(strJson: String): String;
    function fAcertaConsultasAnteriores(strJson: String): String;
    function fAcertaPainel: String;
    function fAcertaScore(strJson: String): String;
    function fAcertaProtestos(strJson: String): String;
    function fAcertaRegistrosDebitos(strJson: String): String;
    function fFormataData(strData: String): String;
    function fFormataValor(strValor: String): String;
    function fGetBlocoAcerta(strJson, strBloco: String; AVerificaArray: Boolean = False): TJSONArray;
    function fRealizarConsultaTRestClient(strLinkAPI : String): TStringStream;
  protected
    function fGetMsgErro: String; override;
    function fGetRelatorio: String; override;
    function fGetQtdProtestos: Integer; override;
    function fGetQtdCheques: Integer; override;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    function fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean; override;
    procedure pSaveToFile(Const strFileName: String); override;
  end;

{$EXTERNALSYM CoFreeUnusedLibrariesEx}
procedure CoFreeUnusedLibrariesEx(dwUnloadDelay, dwReserved: LongWord); stdcall;

implementation

{ TConsultaSCPCBoaVistaAcerta }

uses untFuncoesSimples;

procedure CoFreeUnusedLibrariesEx; external 'ole32.dll' name 'CoFreeUnusedLibrariesEx';

constructor TConsultaSCPCBoaVistaAcerta.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHTTP := TidHTTP.Create(Self);
  FSSL  := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
  FHTTP.IOHandler := FSSL;
  FEntidade := fCfgSis('ENTBOV');
  FToken    := fCfgSis('TOKBOV');
  FTokenBearer := '';

  FIdentificacaoPJ := TIdentificacaoPJ.Create;
  FLocalizacaoPJ := TLocalizacaoPJ.Create;
  FComportamentosPJ := TComportamentosPagamentoPJ.Create;
  FReferenciasNegociosPJ := TReferenciasNegociosPJ.Create;
  FPendenciasPJ := TPendenciasPJ.Create;
  FChequesSustadosPJ := TChequesSustadosPJ.Create;
  FChequesSemFundoPJ := TChequesSemFundoPJ.Create;
  FProtestosPJ := TProtestosPJ.Create;
  FAcoesPJ := TAcoesPJ.Create;
  FPessoaFisica := False;
  FDMPageProducer := TdmPageProducer.Create(nil);

  strAcertaPnDebitos                := '0';
  strAcertaPnConsultasAnteriores    := '0';
  strAcertaPnChequesSemFundo        := '0';
  strAcertaPnChequesSustadoMotivo21 := '0';
  strAcertaPnProtestos              := '0';
  strAcertaPnDevolucoesUsuario      := '0';

  strAcertaScore                    := '';
  strAcertaPainel                   := '';
  strAcertaRegistrosDebitos         := '';
  strAcertaConsultasAnteriores      := '';
  strAcertaChequesSemFundos         := '';
  strAcertaChequesSustados          := '';
  strAcertaProtestos                := '';
  strAcertaChequesDevolucoes        := '';
end;

destructor TConsultaSCPCBoaVistaAcerta.Destroy;
begin
  FreeAndNil(FHTTP);

  FreeAndNil(FIdentificacaoPJ);
  FreeAndNil(FLocalizacaoPJ);
  FreeAndNil(FComportamentosPJ);
  FreeAndNil(FReferenciasNegociosPJ);
  FreeAndNil(FPendenciasPJ);
  FreeAndNil(FChequesSustadosPJ);
  FreeAndNil(FChequesSemFundoPJ);
  FreeAndNil(FProtestosPJ);
  FreeAndNil(FAcoesPJ);
  FreeAndNil(FDMPageProducer);

  inherited;
end;

function TConsultaSCPCBoaVistaAcerta.fAcentua(strTexto: String): String;
begin
  Result := strTexto;
  Result := AnsiReplaceStr(Result, 'inv?lida', 'inválida');
  Result := AnsiReplaceStr(Result, 'NAO', 'NÃO');
  Result := AnsiReplaceStr(Result, 'C?digo', 'Código');
  Result := AnsiReplaceStr(Result, 'n?o', 'não');
end;

function TConsultaSCPCBoaVistaAcerta.fGetMsgErro: String;
begin
  Result := FMsgErro;
end;

function TConsultaSCPCBoaVistaAcerta.fGetQtdCheques: Integer;
begin
  If Length(FDocConsulta) = 11 Then
    Result := strToIntDef( strAcertaPnChequesSemFundo, 0 )
  Else
    Result := FChequesSemFundoPJ.intCount;
end;

function TConsultaSCPCBoaVistaAcerta.fGetQtdProtestos: Integer;
begin
  If Length(FDocConsulta) = 11 Then
    Result :=  strToIntDef( strAcertaPnProtestos, 0 )
  Else
    Result := FProtestosPJ.intCount;
end;

function TConsultaSCPCBoaVistaAcerta.fGetRelatorio: String;
begin
  If Length(FDocConsulta) = 11 Then
    Result :=  strAcertaScore +
               strAcertaPainel +
               strAcertaRegistrosDebitos +
               strAcertaProtestos +
               strAcertaConsultasAnteriores +
               strAcertaChequesSemFundos +
               strAcertaChequesSustados +
               strAcertaChequesDevolucoes
  Else
    Result := FIdentificacaoPJ.fGetRelatorio() +
              FLocalizacaoPJ.fGetRelatorio() +
              FComportamentosPJ.fGetRelatorio() +
              FReferenciasNegociosPJ.fGetRelatorio() +
              FPendenciasPJ.fGetRelatorio() +
              FChequesSustadosPJ.fGetRelatorio() +
              FChequesSemFundoPJ.fGetRelatorio() +
              FProtestosPJ.fGetRelatorio() +
              FAcoesPJ.fGetRelatorio();
end;

function TConsultaSCPCBoaVistaAcerta.fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean;
Var
  strPostData,
  strURL: String;
  strResultado: TStringStream;
  PostData: TStringStream;
  jsResposta: TJSONObject;
  blnSucesso: Boolean;
  blnGlobal: Boolean;
begin
  FMsgErro := '';
  FDocConsulta := strDocumento;
  Result    := False;
  blnGlobal := fCfgSis('CNSCPC') = 'G';
  FPessoaFisica := (Length(strDocumento) = 11);

  If Not fInputQueryTipo('Boa Vista Acerta Serviços', 'Login:', FLogin, ttInteiro) Then
    Exit;

  If Not fInputQueryTipo('Boa Vista Acerta Serviços', 'Senha:', FSenha, ttAlfanumerico, '*') Then
    Exit;

  If fEmptyStr(FEntidade) Then
  Begin
    FMsgErro :=
      'Para acessar a consulta SCPC você deve informar o código da entidade nas configurações do sistema!';
    Exit;
  End;

  If blnGlobal And fEmptyStr(FToken) Then
  Begin
    FMsgErro :=
      'Para acessar a consulta SCPC Global você deve informar o Token nas configurações do sistema!';
    Exit;
  End;

  strResultado := TStringStream.Create;
  Try
    If blnGlobal Then
    Begin
      PostData := TStringStream.Create;
      FHTTP.Request.ContentType := 'application/json';

      strUrl := TIdURI.URLEncode('http://pwl.bvsnet.com.br/Account/login?token='+FToken);
      FHTTP.Post(strUrl, PostData, strResultado);

      jsResposta := TJSONObject.ParseJSONValue(strResultado.DataString) as TJSONObject;
      blnSucesso := (jsResposta.GetValue('success') as TJSONBool).AsBoolean;
      If blnSucesso Then
        FTokenBearer := (jsResposta.GetValue('token') as TJSONString).Value;
      FHTTP.Request.CustomHeaders.Add('Authorization:Bearer ' + FTokenBearer);

      strPostData := '{ ';
      strPostData := strPostData + '"Token": "'+FToken+'",';
      strPostData := strPostData + '"codigoServico": "'+FLogin+'", ';
      strPostData := strPostData + '"Associado": "'+FLogin+'", ';
      strPostData := strPostData + '"senha": "'+FSenha+'", ';
      strPostData := strPostData + '"'+IIF(FPessoaFisica,'cpf','cnpj')+'": "'+strDocumento+'", ';
      strPostData := strPostData + '"tipoCredito": "CD", ';
      strPostData := strPostData + '"uf": "'+strUF+'", ';
      strPostData := strPostData + '"scoreCredito": "S", ';
      strPostData := strPostData + '"modelosScore": [ "63" ], ';
      strPostData := strPostData + '"consultarCheque": "N", ';
      strPostData := strPostData + '"entidade": "'+FEntidade+'" ';
      strPostData := strPostData + ' }';
      PostData := TStringStream.Create(strPostData);

      strResultado.Clear;
      strUrl := TIdURI.URLEncode('http://pwl.bvsnet.com.br/acerta/consultar/1/json');

      FHTTP.HTTPOptions := FHTTP.HTTPOptions + [hoNoProtocolErrorException];
      FHTTP.Post(strUrl, PostData, strResultado);
      FRestClient := False;
    End
    Else
    Begin
      strURL := 'https://integra.boavistaservicos.com.br/lac/layercon/consumir';

      strURL := strURL + '?solicitante=$CITELSOFTWARE';
      strURL := strURL + '&entidade=' + FEntidade;
      strURL := strURL + '&associado=' + FLogin;
      strURL := strURL + '&loginacesso=' + FLogin;
      strURL := strURL + '&senhaacesso=' + FSenha;
      If FPessoaFisica Then
      Begin
        strURL := strURL + '&produto=ACERTA';
        strURL := strURL + '&score=N';
        strURL := strURL + '&tipocredito=OU';
        strURL := strURL + '&formato=json2';
        strURL := strURL + '&cpf=' + strDocumento;
      End
      Else
      Begin
        strURL := strURL + '&produto=CONSULTEPJ';
        strURL := strURL + '&cnpj=' + strDocumento;
      End;
      strURL := strURL + '&mostraframe=n';

      strResultado := fRealizarConsultaTRestClient(strURL);
      FRestCLient := True;
    End;

    If FRestClient Then
    Begin
      If rspResponse.Status.Success Then
      Begin
        strResultado.Seek(0, soFromBeginning);
        FResp := strResultado.DataString;
        pParseResponse(FResp);
        Result := FSucesso;
      End
      Else
      Begin
        FMsgErro := 'Ocorreu um erro imprevisto na consulta!' + #13#10 +
                    'Código do erro: ' + rspResponse.StatusCode.toString + #13#10 +
                    'Descrição do erro: ' + rspResponse.ErrorMessage;
        Exit;
      End;
    End
    Else
    Begin
      If FHTTP.ResponseCode = 200 Then
      Begin
        strResultado.Seek(0, soFromBeginning);
        FResp := strResultado.DataString;
        pParseResponse(FResp);
        Result := FSucesso;
      End
      Else
      Begin
        FMsgErro := 'Ocorreu um erro imprevisto na consulta!' + #13#10 +
                    'Código do erro: ' + IntToStr(FHTTP.ResponseCode) + #13#10 +
                    'Descrição do erro: ' + FHTTP.ResponseText;
        Exit;
      End;
    End;
  Finally
    If Assigned(PostData) Then
      FreeAndNil(PostData);
    FreeAndNil(strResultado);
    CoFreeUnusedLibrariesEx(0,0);
  End;

end;

function TConsultaSCPCBoaVistaAcerta.fRealizarConsultaTRestClient(strLinkAPI: String): TStringStream;
begin
  Result := TStringStream.Create('');;

  If Assigned(reqRequest) Then
    pFreeAndNil(reqRequest);
  If Assigned(rspResponse) Then
    pFreeAndNil(rspResponse);
  If Assigned(cltCliente) Then
    pFreeAndNil(cltCliente);

  If Not fEmptyStr(strLinkAPI) Then
  Begin
    Try
      cltCliente := TRestClient.Create(strLinkAPI);
      cltCliente.BaseURL         := strLinkAPI;
      cltCliente.Accept          := 'application/json';
      cltCliente.AcceptCharset   := 'UTF-8';
      cltCliente.HandleRedirects := True;

      rspResponse := TRestResponse.Create(Application);
      rspResponse.ContentType := 'application/json';

      reqRequest := TRestRequest.Create(Application);

      reqRequest.Accept           := 'application/json';
      reqRequest. AcceptCharset   := 'UTF-8';
      reqRequest.Client          := cltCliente;
      reqRequest.Method          := rmGET;
      reqRequest.Response        := rspResponse;
      reqRequest.Timeout         := 60000;

      reqRequest.Execute;
      Result := TStringStream.Create(rspResponse.Content);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function TConsultaSCPCBoaVistaAcerta.fVerTableHead(varElement: OleVariant;
  strTitulo: String): Boolean;
Var
  el: OleVariant;
  i: Integer;
begin
  Result := False;
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'THEAD') and ContainsText(el.innerText, strTitulo) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

procedure TConsultaSCPCBoaVistaAcerta.pParsePJ(varDoc: OleVariant);
Var
  el: OleVariant;
  i: Integer;
begin
  For i := 0 to varDoc.body.all.length - 1 Do
  Begin
    el := varDoc.body.all.item(i);
    If (el.tagName = 'DIV') And (el.className = 'cnt-resultado') Then
    Begin
      If fVerTableHead(el, 'IDENTIFICAÇÃO') Then
        FIdentificacaoPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'LOCALIZAÇÃO') Then
        FLocalizacaoPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'COMPORTAMENTO DE PAGAMENTOS') Then
        FComportamentosPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'REFERENCIAIS DE NEGÓCIOS') Then
        FReferenciasNegociosPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'PENDÊNCIAS E RESTRIÇÕES FINANCEIRAS') Then
        FPendenciasPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'CHEQUES SUSTADOS MOTIVO 21') Then
        FChequesSustadosPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'CHEQUES SEM FUNDO') Then
        FChequesSemFundoPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'PROTESTOS') Then
        FProtestosPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'RECUPERAÇÕES, FALÊNCIAS E AÇÕES JUDICIAIS') Then
        FAcoesPJ.pParseHtml(el);
    End;
  End;
end;

procedure TConsultaSCPCBoaVistaAcerta.pParseResponse(strResponse: String);
Var
  doc: OleVariant;
  el: OleVariant;
  i: Integer;
begin
  FSucesso := True;

  If Length(FDocConsulta) <> 11 Then
  Begin
    doc := CoHTMLDocument.Create as IHTMLDocument2;
    doc.write(strResponse);
    doc.Close;

    FMsgErro := '';

    For i := 0 to doc.body.all.length - 1 Do
    Begin
      el := doc.body.all.item(i);
      If (el.tagName = 'SPAN') And ((el.className = 'war-header') Or (el.className = 'err-header')) Then
        FMsgErro := FMsgErro + Trim(el.innerText);
      If (el.tagName = 'LI') And (Not fEmptyStr(FMsgErro)) Then
        FMsgErro := FMsgErro + #13#10 + fAcentua(Trim(el.innerText));
    End;

    If Not fEmptyStr(FMsgErro) Then
      FSucesso := False
    Else
      pParsePJ(doc);
  End
  Else
    FSucesso := fProcessaRetornoPF(strResponse);

end;

procedure TConsultaSCPCBoaVistaAcerta.pSaveToFile(const strFileName: String);
var
  stlTexto: TStringList;
begin
  inherited;
  If Not DirectoryExists(ExtractFilePath(strFileName)) Then
    fCriaDiretorio(ExtractFilePath(strFileName));

  stlTexto := TStringList.Create;
  Try
    stlTexto.Text := Self.fGetRelatorio;
    stlTexto.SaveToFile(strFileName);

    If Not FPessoaFisica Then
    Begin
      stlTexto.Text := FResp;
      stlTexto.SaveToFile(AnsiReplaceStr(strFileName, ExtractFileExt(strFileName), '.html'));
    End
    Else
    Begin
      stlTexto.Text := FResp;
      stlTexto.SaveToFile(AnsiReplaceStr(strFileName, ExtractFileExt(strFileName), '.json'));

      stlTexto.Text := FDMPageProducer.pageJsonBoaVistaAcerta.HTMLDoc.Text;
      stlTexto.Text := stlTexto.Text.Replace('#JsonValue', FResp, [rfReplaceAll]);
      stlTexto.SaveToFile(AnsiReplaceStr(strFileName, ExtractFileExt(strFileName), '.html'));
    End;
  Finally
    FreeAndNil(stlTexto);
  End;
end;

{ TIdentificacaoPJ }

function TIdentificacaoPJ.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            '                        IDENTIFICAÇÃO                        ' + #13#10 +
            '-------------------------------------------------------------' + #13#10;
  If Not fEmptyStr(FRazaoSocial) Then
    Result := Result + 'Razão Social:          ' + FRazaoSocial + #13#10;
  If Not fEmptyStr(FCnpj) Then
    Result := Result + 'CNPJ:                  ' + FCnpj + #13#10;
  If Not fEmptyStr(FNire) Then
    Result := Result + 'Nire:                  ' + FNire + #13#10;
  If Not fEmptyStr(FNomeFantasia) Then
    Result := Result + 'Nome Fantasia:         ' + FNomeFantasia + #13#10;
  If Not fEmptyStr(FRazaoAnterior) Then
    Result := Result + 'Razão Anterior:        ' + FRazaoAnterior + #13#10;
  If Not fEmptyStr(FDataRazao) Then
    Result := Result + 'Razaõ anterior até:    ' + FDataRazao + #13#10;
  If Not fEmptyStr(FDataFundacao) Then
    Result := Result + 'Data da Fundação:      ' + FDataFundacao + #13#10;
  If Not fEmptyStr(FDataEncerramento) Then
    Result := Result + 'Data de Encerramento:  ' + FDataEncerramento + #13#10;
  If Not fEmptyStr(FInscrEst) Then
    Result := Result + 'Inscr. Est.:           ' + FInscrEst + #13#10;
  If Not fEmptyStr(FSituacaoCnpj) Then
    Result := Result + 'Situação do CNPJ:      ' + FSituacaoCnpj + #13#10;
  If (FDataCnpj > 0) Then
    Result := Result + 'Data:                  ' + DateToStr(FDataCnpj) + #13#10;
  If (FConsultaCnpj > 0) Then
    Result := Result + 'Consultado em:         ' + DateToStr(FConsultaCnpj) + #13#10;
  If Not fEmptyStr(FSituacaoSintegra) Then
    Result := Result + 'Situação SINTEGRA:     ' + FSituacaoSintegra + #13#10;
  If (FDataSintegra > 0) Then
    Result := Result + 'Data:                  ' + DateToStr(FDataSintegra) + #13#10;
  If (FConsultaSintegra > 0) Then
    Result := Result + 'Consultado em:         ' + DateToStr(FConsultaSintegra) + #13#10;
  If Not fEmptyStr(FNaturezaJuridica) Then
    Result := Result + 'Natureza Jurídica:     ' + FNaturezaJuridica + #13#10;
  If Not fEmptyStr(FFaixaFuncionarios) Then
    Result := Result + 'Faixa de funcionários: ' + FFaixaFuncionarios + #13#10;
  If (FFiliais > 0) Then
    Result := Result + 'Filiais:               ' + IntToStr(FFiliais) + #13#10;
  If Not fEmptyStr(FCnaePri) Then
    Result := Result + 'Ramo de Atividade Primário - CNAE: ' + FCnaePri + #13#10;
  If Not fEmptyStr(FCnaeSec) Then
    Result := Result + 'Ramo de Atividade secundário:      ' + FCnaeSec + #13#10;
  Result := Result + #13#10;
end;

procedure TIdentificacaoPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;
  blnSitCnpj,
  blnSitSintegra,
  blnRazaoAnterior: Boolean;
begin
  blnSitCnpj := False;
  blnSitSintegra := False;
  blnRazaoAnterior := False;

  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Razão Social') Then
      FRazaoSocial := Trim(fReplaceStr(el.parentElement.innerText, 'Razão Social', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'CNPJ') Then
      FCnpj := Trim(fReplaceStr(el.parentElement.innerText, 'CNPJ', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Nire') Then
      FNire := Trim(fReplaceStr(el.parentElement.innerText, 'Nire', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Nome Fantasia') Then
      FNomeFantasia := Trim(fReplaceStr(el.parentElement.innerText, 'Nome Fantasia', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Razão Anterior') Then
    Begin
      FRazaoAnterior := Trim(fReplaceStr(el.parentElement.innerText, 'Razão Anterior', ''));
      blnRazaoAnterior := True;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Data') And blnRazaoAnterior Then
    Begin
      FDataRazao := Trim(fReplaceStr(el.parentElement.innerText, 'Data', ''));
      blnRazaoAnterior := False;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Data de Fundação') Then
      FDataFundacao := Trim(fReplaceStr(el.parentElement.innerText, 'Data de Fundação', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Data de Encerramento') Then
      FDataEncerramento := Trim(fReplaceStr(el.parentElement.innerText, 'Data de Encerramento', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Inscr. Est.') Then
      FInscrEst := Trim(fReplaceStr(el.parentElement.innerText, 'Inscr. Est.', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Situação do CNPJ') Then
    Begin
      FSituacaoCnpj := Trim(fReplaceStr(el.parentElement.innerText, 'Situação do CNPJ', ''));
      blnSitCnpj := True;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Data') And blnSitCnpj Then
      FDataCnpj := StrToDateDef(Trim(fReplaceStr(el.parentElement.innerText, 'Data', '')), 0)
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Consultado em') And blnSitCnpj Then
    Begin
      FConsultaCnpj := StrToDateDef(Trim(fReplaceStr(el.parentElement.innerText, 'Consultado em', '')), 0);
      blnSitCnpj := False;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Situação SINTEGRA') Then
    Begin
      FSituacaoSintegra := Trim(fReplaceStr(el.parentElement.innerText, 'Situação SINTEGRA', ''));
      blnSitSintegra := True;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Data') And blnSitSintegra Then
      FDataSintegra := StrToDateDef(Trim(fReplaceStr(el.parentElement.innerText, 'Data', '')), 0)
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Consultado em') And blnSitSintegra Then
    Begin
      FConsultaSintegra := StrTodateDef(Trim(fReplaceStr(el.parentElement.innerText, 'Consultado em', '')), 0);
      blnSitSintegra := False;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Natureza Jurídica') Then
      FNaturezaJuridica := Trim(fReplaceStr(el.parentElement.innerText, 'Natureza Jurídica', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Faixa de Funcionários') Then
      FFaixaFuncionarios := Trim(fReplaceStr(el.parentElement.innerText, 'Faixa de Funcionários', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Filiais') Then
      FFiliais := Trunc(fStrToFloat(Trim(fReplaceStr(el.parentElement.innerText, 'Filiais ', ''))))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Ramo de Atividade Primário') Then
      FCnaePri := Trim(fReplaceStr(el.parentElement.innerText, 'Ramo de Atividade Primário - CNAE', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Ramo de Atividade secundário') Then
      FCnaeSec := Trim(fReplaceStr(el.parentElement.innerText, 'Ramo de Atividade secundário', ''));
  End;
end;

{ TLocalizacaoPJ }

function TLocalizacaoPJ.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            '                         LOCALIZAÇÃO                         ' + #13#10 +
            '-------------------------------------------------------------' + #13#10;
  If Not fEmptyStr(FEndereco) Then
    Result := Result + 'Endereço:           ' + FEndereco + #13#10;
  If Not fEmptyStr(FBairro) Then
    Result := Result + 'Bairro:             ' + FBairro + #13#10;
  If Not fEmptyStr(FCidadeUF) Then
    Result := Result + 'Cidade - UF:        ' + FCidadeUF + #13#10;
  If Not fEmptyStr(FCep) Then
    Result := Result + 'CEP:                ' + FCep + #13#10;
  If Not fEmptyStr(FEnderecoMatriz) Then
    Result := Result + 'Endereço da Matriz: ' + FEnderecoMatriz + #13#10;
  If Not fEmptyStr(FBairroMatriz) Then
    Result := Result + 'Bairro da Matriz:   ' + FBairroMatriz + #13#10;
  If Not fEmptyStr(FCidadeUFMatriz) Then
    Result := Result + 'Cidade - UF:        ' + FCidadeUFMatriz + #13#10;
  If Not fEmptyStr(FCepMatriz) Then
    Result := Result + 'CEP:                ' + FCepMatriz + #13#10 + #13#10;
end;

procedure TLocalizacaoPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;
  blnMatriz: Boolean;
begin
  blnMatriz := False;
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);

    If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Endereço') Then
      FEndereco := Trim(fReplaceStr(el.parentElement.innerText, 'Endereço', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Bairro') Then
      FBairro := Trim(fReplaceStr(el.parentElement.innerText, 'Bairro', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Cidade - UF') And (Not blnMatriz) Then
      FCidadeUF := Trim(fReplaceStr(el.parentElement.innerText, 'Cidade - UF', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'CEP') And (Not blnMatriz) Then
      FCep := Trim(fReplaceStr(el.parentElement.innerText, 'CEP', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Endereço da Matriz') Then
    Begin
      FEnderecoMatriz := Trim(fReplaceStr(el.parentElement.innerText, 'Endereço da Matriz', ''));
      blnMatriz := True;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Bairro da matriz') Then
    Begin
      FBairroMatriz := Trim(fReplaceStr(el.parentElement.innerText, 'Bairro da matriz', ''));
      blnMatriz := True;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Cidade - UF') And blnMatriz Then
      FCidadeUFMatriz := Trim(fReplaceStr(el.parentElement.innerText, 'Cidade - UF', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'CEP') And blnMatriz Then
      FCepMatriz := Trim(fReplaceStr(el.parentElement.innerText, 'CEP', ''));
  End;
end;

{ TChequeSustado }

function TChequeSustadoPJ.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            'Data:               ' + FData + #13#10 +
            'Banco:              ' + FBanco + #13#10 +
            'Agência:            ' + FAgencia + #13#10 +
            'Cheques:            ' + FCheques + #13#10 +
            'Data da ocorrência: ' + FDataOcorrencia + #13#10;
end;

procedure TChequeSustadoPJ.pParseHtml(varElement: OleVariant);
begin
  FData           := Trim(varElement.children.item(0).innerText);
  FBanco          := Trim(varElement.children.item(1).innerText);
  FAgencia        := Trim(varElement.children.item(2).innerText);
  FCheques        := Trim(varElement.children.item(3).innerText);
  FDataOcorrencia := Trim(varElement.children.item(4).innerText);
end;

{ TChequesSustados }

constructor TChequesSustadosPJ.Create;
begin
  inherited Create;
  FCheques := TObjectList<TChequeSustadoPJ>.Create;
end;

destructor TChequesSustadosPJ.Destroy;
begin
  FreeAndNil(FCheques);
  inherited;
end;

function TChequesSustadosPJ.fGetRelatorio: String;
Var
  objCheque: TChequeSustadoPJ;
begin
  If FCheques.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                  CHEQUES SUSTADOS MOTIVO 21                 ' + #13#10 +
              '-------------------------------------------------------------' + #13#10 +
              'Período: ' + DateToStr(FDataIni) + ' a ' + DateToStr(FDataFin) + #13#10;

    For objCheque In FCheques Do
      Result := Result + objCheque.fGetRelatorio;

    Result := Result + #13#10;
  End;
end;

procedure TChequesSustadosPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParsePeriodo(varTBody: OleVariant);
  Var
    strContent: String;
  Begin
    strContent := varTBody.children.item(0).innerText;
    If ContainsText(strContent, 'Período:') Then
    Begin
      strContent := Trim(fReplaceStr(strContent, 'Período:', ''));
      FDataIni   := StrToDateDef(Copy(strContent, 1, 10), 0);
      strContent := Trim(Copy(strContent, Pos('à', strContent) + 1, Length(strContent)));
      FDataFin   := StrToDateDef(Copy(strContent, 1, 10), 0);
    End;
  End;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    objCheque: TChequeSustadoPJ;
  Begin
    For j := 2 to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objCheque := TChequeSustadoPJ.Create;
      objCheque.pParseHtml(elTr);
      FCheques.Add(objCheque);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParsePeriodo(el);
      pParseItens(el);
      Break;
    End;
  End;
end;

{ TChequeSemFundo }

function TChequeSemFundoPJ.fGetRelatorio: String;
begin
  Result := 'Quantidade:     ' + IntToStr(FQuantidade) + #13#10 +
            'Data do último: ' + FDataUltimo + #13#10 +
            'Banco:          ' + FBanco + #13#10 +
            'Agência:        ' + FAgencia + #13#10 +
            'Motivo:         ' + FMotivo + #13#10;
end;

procedure TChequeSemFundoPJ.pParseHtml(varElement: OleVariant);
begin
  FQuantidade := Trunc(fStrToFloat(Trim(varElement.children.item(0).innerText)));
  FDataUltimo := Trim(varElement.children.item(1).innerText);
  FBanco      := Trim(varElement.children.item(2).innerText);
  FAgencia    := Trim(varElement.children.item(3).innerText);
  FMotivo     := Trim(varElement.children.item(4).innerText);
end;

{ TChequesSemFundo }

constructor TChequesSemFundoPJ.Create;
begin
  inherited Create;
  FCheques := TObjectList<TChequeSemFundoPJ>.Create;
end;

destructor TChequesSemFundoPJ.Destroy;
begin
  FreeAndNil(FCheques);
  inherited;
end;

function TChequesSemFundoPJ.fGetCount: Integer;
Var
  objCheque: TChequeSemFundoPJ;
begin
  Result := 0;
  For objCheque In FCheques Do
    Result := Result + objCheque.intQuantidade;
end;

function TChequesSemFundoPJ.fGetRelatorio: String;
Var
  objCheque: TChequeSemFundoPJ;
begin
  If FCheques.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                      CHEQUES SEM FUNDO                      ' + #13#10 +
              '-------------------------------------------------------------' + #13#10;

    For objCheque In FCheques Do
    Begin
      If objCheque <> FCheques.First Then
        Result := Result + '-------------------------------------------------------------' + #13#10;

      Result := Result + objCheque.fGetRelatorio;
    End;

    Result := Result + #13#10;
  End;
end;

procedure TChequesSemFundoPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    objCheque: TChequeSemFundoPJ;
  Begin
    For j := 3 to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objCheque := TChequeSemFundoPJ.Create;
      objCheque.pParseHtml(elTr);
      FCheques.Add(objCheque);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParseItens(el);
      Break;
    End;
  End;
end;

{ TProtestoPJ }

function TProtestoPJ.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            'Data:       ' + FData + #13#10 +
            'Vencimento: ' + FVencimento + #13#10 +
            'Cartório:   ' + FCartorio + #13#10 +
            'Cidade:     ' + FCidade + #13#10 +
            'Estado:     ' + FEstado + #13#10 +
            'Valor:      ' + FormatFloat('#,##0.00', FValor) + #13#10;
end;

procedure TProtestoPJ.pParseHtml(varElement: OleVariant);
begin
  FData       := Trim(varElement.children.item(0).innerText);
  FVencimento := Trim(varElement.children.item(1).innerText);
  FCartorio   := Trim(varElement.children.item(2).innerText);
  FCidade     := Trim(varElement.children.item(3).innerText);
  FEstado     := Trim(varElement.children.item(4).innerText);
  FValor      := fStrToFloat(Trim(varElement.children.item(5).innerText));
end;

{ TProtestosPJ }

constructor TProtestosPJ.Create;
begin
  inherited Create;
  FUltimosProtestos := TObjectList<TProtestoPJ>.Create();
end;

destructor TProtestosPJ.Destroy;
begin
  FreeAndNil(FUltimosProtestos);
  inherited;
end;

function TProtestosPJ.fGetCount: Integer;
begin
  Result := FQtdTotal;
end;

function TProtestosPJ.fGetRelatorio: String;
Var
  objProtesto: TProtestoPJ;
begin
  If FUltimosProtestos.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                          PROTESTOS                          ' + #13#10 +
              '-------------------------------------------------------------' + #13#10 +
              'Total de protestos: ' + IntToStr(FQtdTotal) + #13#10 +
              'Valor:              ' + FormatFloat('#,##0.00', FValorTotal) + #13#10;
              If Not fEmptyStr(FDataPrimeiro) Then
              Begin
                Result := Result +
                'Data do primeiro:   ' + FDataPrimeiro + #13#10 +
                'Valor do primeiro:  ' + FormatFloat('#,##0.00', FValorPrimeiro) + #13#10;
              End;
              If Not fEmptyStr(FDataMaior) Then
              Begin
                Result := Result +
                'Data do maior:      ' + FDataMaior + #13#10 +
                'Valor do maior:     ' + FormatFloat('#,##0.00', FValorMaior) + #13#10;
              End;

    For objProtesto In FUltimosProtestos Do
      Result := Result + objProtesto.fGetRelatorio;

    Result := Result + #13#10;
  End;
end;

procedure TProtestosPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseCabecalho(varTBody: OleVariant);
  Var
    strContent: String;
  Begin
    If varTBody.children.item(0).children.length > 1 Then
    Begin
      strContent := varTBody.children.item(0).children.item(1).InnerText;
      If ContainsText(strContent, 'Total de Protestos:') Then
      Begin
        strContent := Trim(fReplaceStr(strContent, 'Total de Protestos:', ''));
        FQtdTotal := Trunc(fStrToFloat(strContent));
      End;
    End;

    If varTBody.children.item(0).children.length > 2 Then
    Begin
      strContent := varTBody.children.item(0).children.item(2).InnerText;
      If ContainsText(strContent, 'Valor (R$):') Then
      Begin
        strContent := Trim(fReplaceStr(strContent, 'Valor (R$):', ''));
        FValorTotal := fStrToFloat(strContent);
      End;
    End;

    If varTBody.children.length > 2 Then
    Begin
      If ContainsText(varTBody.children.item(2).children.item(0).InnerText, 'Primeiro:') Then
      Begin
        FDataPrimeiro := varTBody.children.item(2).children.item(1).InnerText;
        FValorPrimeiro := fStrToFloat(varTBody.children.item(2).children.item(2).InnerText);
      End;
    End;

    If varTBody.children.length > 3 Then
    Begin
      If ContainsText(varTBody.children.item(3).children.item(0).InnerText, 'Maior:') Then
      Begin
        FDataMaior := varTBody.children.item(3).children.item(1).InnerText;
        FValorMaior := fStrToFloat(varTBody.children.item(3).children.item(2).InnerText);
      End;
    End;
  End;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    intPrimeiroItem: Integer;
    objProtesto: TProtestoPJ;
  Begin
    intPrimeiroItem := varTBody.children.length;
    For j := 0 to varTBody.children.length - 1 Do
    Begin
      If ContainsText(varTBody.children.item(j).InnerText, 'Últimas Ocorrências') Then
      Begin
        intPrimeiroItem := j + 2;
        Break;
      End;
    End;

    For j := intPrimeiroItem to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objProtesto := TProtestoPJ.Create;
      objProtesto.pParseHtml(elTr);
      FUltimosProtestos.Add(objProtesto);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParseCabecalho(el);
      pParseItens(el);
      Break;
    End;
  End;
end;

{ TAcaoPJ }

function TAcaoPJ.fGetRelatorio: String;
begin
  Result := 'Quantidade:         ' + IntToStr(FQuantidade) + #13#10 +
            'Tipo de ocorrência: ' + FTipo + #13#10 +
            'Data:               ' + FData + #13#10 +
            'Vara:               ' + FVara + #13#10 +
            'UF:                 ' + FUF + #13#10 +
            'Cidade:             ' + FCidade + #13#10;
end;

procedure TAcaoPJ.pParseHtml(varElement: OleVariant);
begin
  FQuantidade := Trunc(fStrToFloat(Trim(varElement.children.item(0).innerText)));
  FTipo       := Trim(varElement.children.item(1).innerText);
  FData       := Trim(varElement.children.item(2).innerText);
  FVara       := Trim(varElement.children.item(3).innerText);
  FUF         := Trim(varElement.children.item(4).innerText);
  FCidade     := Trim(varElement.children.item(5).innerText);
end;

{ TAcoesPJ }

constructor TAcoesPJ.Create;
begin
  inherited Create;
  FAcoes := TObjectList<TAcaoPJ>.Create();
end;

destructor TAcoesPJ.Destroy;
begin
  FreeAndNil(FAcoes);
  inherited;
end;

function TAcoesPJ.fGetCount: Integer;
begin
  Result := FAcoes.Count;
end;

function TAcoesPJ.fGetRelatorio: String;
Var
  objAcao: TAcaoPJ;
begin
  If FAcoes.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '          RECUPERAÇÕES, FALÊNCIAS E AÇÕES JUDICIAIS          ' + #13#10 +
              '-------------------------------------------------------------' + #13#10;

    For objAcao In FAcoes Do
    Begin
      If objAcao <> FAcoes.First Then
        Result := Result + '-------------------------------------------------------------' + #13#10;

      Result := Result + objAcao.fGetRelatorio;
    End;

    Result := Result + #13#10;
  End;
end;

procedure TAcoesPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    objAcao: TAcaoPJ;
  Begin
    For j := 1 to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objAcao := TAcaoPJ.Create;
      objAcao.pParseHtml(elTr);
      FAcoes.Add(objAcao);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParseItens(el);
      Break;
    End;
  End;
end;

{ TComportamentoPagamentoPJ }

function TComportamentoPagamentoPJ.fGetRelatorio: String;
begin
  Result := 'Fornecedores:                  ' + IntToStr(FQtdFornecedores) + #13#10 +
            'Títulos:                       ' + IntToStr(FQtdTitulos) + #13#10 +
            'À Vista (%):                   ' + FormatFloat('#,##0.00', FAVista) + #13#10 +
            'Pontual (%):                   ' + FormatFloat('#,##0.00', FPotual) + #13#10 +
            '6 a 15 dias de atraso (%):     ' + FormatFloat('#,##0.00', FAtraso6_15) + #13#10 +
            '16 a 30 dias de atraso (%):    ' + FormatFloat('#,##0.00', FAtraso16_30) + #13#10 +
            '31 a 60 dias de atraso (%):    ' + FormatFloat('#,##0.00', FAtraso31_60) + #13#10 +
            'Mais de 60 dias de atraso (%): ' + FormatFloat('#,##0.00', FAtraso61_) + #13#10 +
            'Atraso médio (dias):           ' + FormatFloat('#,##0.00', FAtrasoMedio) + #13#10;
end;

procedure TComportamentoPagamentoPJ.pParseHtml(varElement: OleVariant);
begin
  FQtdFornecedores := Trunc(fStrToFloat(Trim(varElement.children.item(1).innerText)));
  FQtdTitulos      := Trunc(fStrToFloat(Trim(varElement.children.item(2).innerText)));
  FAVista          := fStrToFloat(Trim(varElement.children.item(3).innerText));
  FPotual          := fStrToFloat(Trim(varElement.children.item(4).innerText));
  FAtraso6_15      := fStrToFloat(Trim(varElement.children.item(5).innerText));
  FAtraso16_30     := fStrToFloat(Trim(varElement.children.item(6).innerText));
  FAtraso31_60     := fStrToFloat(Trim(varElement.children.item(7).innerText));
  FAtraso61_       := fStrToFloat(Trim(varElement.children.item(8).innerText));
  FAtrasoMedio     := fStrToFloat(Trim(varElement.children.item(9).innerText));
end;

{ TComportamentosPagamentoPJ }

constructor TComportamentosPagamentoPJ.Create;
begin
  inherited Create;
  FComportamentos := TObjectList<TComportamentoPagamentoPJ>.Create();
end;

destructor TComportamentosPagamentoPJ.Destroy;
begin
  FreeAndNil(FComportamentos);
  inherited;
end;

function TComportamentosPagamentoPJ.fGetRelatorio: String;
Var
  objComp: TComportamentoPagamentoPJ;
begin
  If FComportamentos.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                 COMPORTAMENTO DE PAGAMENTOS                 ' + #13#10 +
              '-------------------------------------------------------------' + #13#10;

    For objComp In FComportamentos Do
    Begin
      If objComp <> FComportamentos.First Then
        Result := Result + '-------------------------------------------------------------' + #13#10;

      Result := Result + objComp.fGetRelatorio;
    End;

    Result := Result + #13#10;
  End;
end;

procedure TComportamentosPagamentoPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    objComp: TComportamentoPagamentoPJ;
  Begin
    For j := 2 to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objComp := TComportamentoPagamentoPJ.Create;
      objComp.pParseHtml(elTr);
      FComportamentos.Add(objComp);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParseItens(el);
      Break;
    End;
  End;
end;

{ TReferenciasNegociosPJ }

function TReferenciasNegociosPJ.fGetRelatorio: String;
begin
  If (FValorUltimaCompra > 0) Or (FValorMaiorFatura > 0) Or (FValorMaiorCredito > 0) Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                   REFERÊNCIAIS DE NEGÓCIOS                  ' + #13#10 +
              '-------------------------------------------------------------' + #13#10 +
              'Data da última compra:  ' + FDataUltimaCompra + #13#10 +
              'Valor da última compra: ' + FormatFloat('#,##0.00', FValorUltimaCompra) + #13#10 +
              'Média da última compra: ' + FormatFloat('#,##0.00', FMediaUltimacompra) + #13#10 +
              'Data da maior fatura:   ' + FDataMaiorFatura + #13#10 +
              'Valor da maior fatura:  ' + FormatFloat('#,##0.00', FValorMaiorFatura) + #13#10 +
              'Média da maior fatura:  ' + FormatFloat('#,##0.00', FMediaMaiorFatura) + #13#10 +
              'Data do maior crédito:  ' + FDataMaiorCredito + #13#10 +
              'Valor do maior crédito: ' + FormatFloat('#,##0.00', FValorMaiorCredito) + #13#10 +
              'Média do maior crédito: ' + FormatFloat('#,##0.00', FMediaMaiorCredito) + #13#10 + #13#10;
  End;
end;

procedure TReferenciasNegociosPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseInfo(varTBody: OleVariant);
  Begin
    If ContainsText(varTBody.children.item(1).children.item(0).InnerText, 'Última Compra') Then
    Begin
      FDataUltimaCompra  := varTBody.children.item(1).children.item(1).InnerText;
      FValorUltimaCompra := fStrToFloat(varTBody.children.item(1).children.item(2).InnerText);
      FMediaUltimacompra := fStrToFloat(varTBody.children.item(1).children.item(3).InnerText);
    End;
    If ContainsText(varTBody.children.item(2).children.item(0).InnerText, 'Maior Fatura') Then
    Begin
      FDataMaiorFatura  := varTBody.children.item(2).children.item(1).InnerText;
      FValorMaiorFatura := fStrToFloat(varTBody.children.item(2).children.item(2).InnerText);
      FMediaMaiorFatura := fStrToFloat(varTBody.children.item(2).children.item(3).InnerText);
    End;
    If ContainsText(varTBody.children.item(3).children.item(0).InnerText, 'Maior Crédito') Then
    Begin
      FDataMaiorCredito  := varTBody.children.item(3).children.item(1).InnerText;
      FValorMaiorCredito := fStrToFloat(varTBody.children.item(3).children.item(2).InnerText);
      FMediaMaiorCredito := fStrToFloat(varTBody.children.item(3).children.item(3).InnerText);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParseInfo(el);
      Break;
    End;
  End;
end;

{ TPendenciaPJ }

function TPendenciaPJ.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            'Data:   ' + FData + #13#10 +
            'Credor: ' + FCredor + #13#10 +
            'Valor:  ' + FormatFloat('#,##0.00', FValor) + #13#10;
end;

procedure TPendenciaPJ.pParseHtml(varElement: OleVariant);
begin
  FData   := Trim(varElement.children.item(0).innerText);
  FCredor := Trim(varElement.children.item(1).innerText);
  FValor  := fStrToFloat(Trim(varElement.children.item(2).innerText));
end;

{ TPendenciasPJ }

constructor TPendenciasPJ.Create;
begin
  inherited Create;
  FPendencias := TObjectList<TPendenciaPJ>.Create();
end;

destructor TPendenciasPJ.Destroy;
begin
  FreeAndNil(FPendencias);
  inherited;
end;

function TPendenciasPJ.fGetRelatorio: String;
Var
  objPendencia: TPendenciaPJ;
begin
  If FPendencias.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '             PENDÊNCIAS E RESTRIÇÕES FINANCEIRAS             ' + #13#10 +
              '-------------------------------------------------------------' + #13#10 +
              'Total de Pendências: ' + IntToStr(FQtdPendencias) + #13#10 +
              'Total de Credores;   ' + IntToStr(FQtdCredores) + #13#10 +
              'Valor:               ' + FormatFloat('#,##0.00', FValorTotal) + #13#10 +
              'Data do primeiro:    ' + FDataPrimeiro + #13#10 +
              'Valor do primeiro:   ' + FormatFloat('#,##0.00', FValorPrimeiro) + #13#10 +
              'Data do maior:       ' + FDataMaior + #13#10 +
              'Valor do maior:      ' + FormatFloat('#,##0.00', FValorMaior) + #13#10;

    For objPendencia In FPendencias Do
      Result := Result + objPendencia.fGetRelatorio;

    Result := Result + #13#10;
  End;
end;

procedure TPendenciasPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseCabecalho(varTBody: OleVariant);
  Var
    strContent: String;
  Begin
    If varTBody.children.item(0).children.length > 0 Then
    Begin
      strContent := varTBody.children.item(0).children.item(0).InnerText;
      If ContainsText(strContent, 'Total de Pendências:') Then
      Begin
        strContent := Trim(fReplaceStr(strContent, 'Total de Pendências:', ''));
        FQtdPendencias := Trunc(fStrToFloat(strContent));
      End;
    End;

    If varTBody.children.item(0).children.length > 1 Then
    Begin
      strContent := varTBody.children.item(0).children.item(1).InnerText;
      If ContainsText(strContent, 'Total de Credores:') Then
      Begin
        strContent := Trim(fReplaceStr(strContent, 'Total de Credores:', ''));
        FQtdCredores := Trunc(fStrToFloat(strContent));
      End;
    End;

    If varTBody.children.item(0).children.length > 2 Then
    Begin
      strContent := varTBody.children.item(0).children.item(2).InnerText;
      If ContainsText(strContent, 'Valor (R$):') Then
      Begin
        strContent := Trim(fReplaceStr(strContent, 'Valor (R$):', ''));
        FValorTotal := fStrToFloat(strContent);
      End;
    End;

    If varTBody.children.length > 2 Then
    Begin
      If ContainsText(varTBody.children.item(2).children.item(0).InnerText, 'Primeiro') Then
      Begin
        FDataPrimeiro := varTBody.children.item(2).children.item(1).InnerText;
        FValorPrimeiro := fStrToFloat(varTBody.children.item(2).children.item(2).InnerText);
      End;
    End;

    If varTBody.children.length > 3 Then
    Begin
      If ContainsText(varTBody.children.item(3).children.item(0).InnerText, 'Maior') Then
      Begin
        FDataMaior := varTBody.children.item(3).children.item(1).InnerText;
        FValorMaior := fStrToFloat(varTBody.children.item(3).children.item(2).InnerText);
      End;
    End;
  End;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    objPendencia: TPendenciaPJ;
  Begin
    For j := 2 to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objPendencia := TPendenciaPJ.Create;
      objPendencia.pParseHtml(elTr);
      FPendencias.Add(objPendencia);
    End;
  End;

  function fVerPrimeiroTR(varElement: OleVariant; strTitulo: String): Boolean;
  Var
    elTr: OleVariant;
    k: Integer;
  Begin
    Result := False;
    For k := 0 to varElement.parentElement.all.length - 1 Do
    Begin
      elTr := varElement.parentElement.all.item(k);
      If (elTr.tagName = 'TR') Then
      Begin
        Result := ContainsText(elTr.innerText, strTitulo);
        Break;
      End;
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      If fVerPrimeiroTR(el, 'PENDÊNCIAS E RESTRIÇÕES FINANCEIRAS') Then
        pParseCabecalho(el);
      If fVerPrimeiroTR(el, 'Últimas Ocorrências') Then
        pParseItens(el);
    End;
  End;
end;

function TConsultaSCPCBoaVistaAcerta.fProcessaRetornoPF(strResp:String):boolean;

  function fMensagemErro: Boolean;
  var
    objJSON: TJSONObject;
    arrJSON: TJSONArray;
  begin
    Try
      objJSON := TJSONObject.ParseJSONValue(strResp) as TJSONObject;
      objJSON := objJSON.GetValue('Blocos') as TJSONObject;
      objJSON := objJSON.GetValue('Erro_999') as TJSONObject;

      If objJSON = nil Then
      Begin
        objJSON := TJSONObject.ParseJSONValue(strResp) as TJSONObject;
        objJSON := objJSON.GetValue('Blocos') as TJSONObject;
        arrJSON := objJSON.GetValue('Erro_9999') as TJSONArray;
        objJSON := arrJSON.Items[0] as TJSONObject;
      End;

      FMsgErro := 'Erro Boa Vista Acerta: ' + objJSON.GetValue('Mensagem').Value;
      Result := Not fEmptyStr(objJSON.GetValue('Mensagem').Value);
    Except
      Result := False;
    End;
  end;

begin
  Result := True;

  If fMensagemErro Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    strAcertaRegistrosDebitos    := fAcertaRegistrosDebitos(strResp);
    strAcertaProtestos           := fAcertaProtestos(strResp);
    strAcertaConsultasAnteriores := fAcertaConsultasAnteriores(strResp);
    strAcertaChequesSemFundos    := fAcertaChequesSemFundos(strResp);
    strAcertaChequesSustados     := fAcertaChequesSustados(strResp);
    strAcertaChequesDevolucoes   := fAcertaChequesDevolucoes(strResp);
    strAcertaPainel              := fAcertaPainel;
    strAcertaScore               := fAcertaScore(strResp);
  Except
    Result := False;
  End;

end;

function TConsultaSCPCBoaVistaAcerta.fGetBlocoAcerta(strJson, strBloco:String; AVerificaArray: Boolean = False):TJSONArray;
var
  JSONObj1,
  JSONObj2: TJSONObject;

  LJsonValue: TJsonValue;
begin
  JSONObj1 := TJSONObject.ParseJSONValue( strJson ) as TJSONObject;
  JSONObj2 := JSONObj1.GetValue('Blocos') as TJSONObject;

  Try
    If Not AVerificaArray Then
    Begin
      Result := JSONObj2.GetValue( strBloco ) as TJSONArray;
      Exit;
    End;

    LJsonValue := JSONObj2.GetValue( strBloco );

    If (LJsonValue Is TJSONArray) Then
      Result := LJsonValue as TJSONArray
    Else
    Begin
      Result := TJSONArray.Create;
      Result.AddElement(LJsonValue);
    End;
  Except
    Result := nil;
  End;
end;

function TConsultaSCPCBoaVistaAcerta.fFormataValor(strValor:String): String;
var fltResultado: Double;
Begin
  fltResultado := fStrToFloat(strValor);
  fltResultado := fltResultado / 100;
  Result := FormatFloat('#,##0.00', fltResultado);
End;

function TConsultaSCPCBoaVistaAcerta.fFormataData(strData:String): String;
Begin
  Result := FormatMaskText('99/99/9999;0',strData);
End;

function TConsultaSCPCBoaVistaAcerta.fAcertaPainel: String;
Begin
  Result := '------------------------------------------------------------------'  + #13#10 +
            '                       Painel de Controle                         '  + #13#10 +
            '------------------------------------------------------------------'  + #13#10 +
            'Registro de Débitos: ' + strAcertaPnDebitos                          + #13#10 +
            'Consultas Anteriores: ' + strAcertaPnConsultasAnteriores             + #13#10 +
            'Cheques sem Fundo: ' + strAcertaPnChequesSemFundo                    + #13#10 +
            'Cheque Sustado Motivo 21: ' + strAcertaPnChequesSustadoMotivo21      + #13#10 +
            'Protestos: ' + strAcertaPnProtestos                                  + #13#10 +
            'Devoluções Informadas pelo Usuário: ' + strAcertaPnDevolucoesUsuario + #13#10 ;

End;

function TConsultaSCPCBoaVistaAcerta.fAcertaScore(strJson: String): String;
var
  objJSON: TJSONObject;
  arrJSON: TJSONArray;
  strLine: String;
  intLine: Integer;

  function fGetTipo(strTipo:String): String;
  Begin
    if strTipo = '1' Then
      Result := 'CPF'
    else
      Result := 'CNPJ';
  End;

Begin
  arrJSON := fGetBlocoAcerta(strJson, 'ScoreClassificacaoVariosModelos_601' );

  If not assigned(arrJSON) then exit;

  strLine := '------------------------------------------------------------------' + #13#10 +
             '                               Score                              ' + #13#10 +
             '------------------------------------------------------------------' + #13#10 ;

  For intLine := 0 to arrJSON.count - 1 do
  Begin
    objJSON := arrJSON.Items[intLine] as TJSONObject;

    strLine := strLine + 'Registro: '+ objJSON.GetValue('Registro').Value +  #13#10 +
                         'Tipo Score: '+ fGetTipo(objJSON.GetValue('TipoScore').Value) +  #13#10 +
                         'Score: ' + objJSON.GetValue('Score').Value  +  #13#10 +
                         'Plano Execução: ' + objJSON.GetValue('PlanoExecucao').Value  +  #13#10 +
                         'Modelo Plano: ' + objJSON.GetValue('ModeloPlano').Value  +  #13#10 +
                         'Modelo Score: ' + objJSON.GetValue('ModeloScore').Value  +  #13#10 +
                         'Nome Score: ' + objJSON.GetValue('NomeScore').Value  +  #13#10 +
                         'Classificação Numérica: ' + objJSON.GetValue('ClassificacaoNumerica').Value  +  #13#10 +
                         'Classificação Alfabética: ' + objJSON.GetValue('ClassificacaoAlfabetica').Value  +  #13#10 +
                         'Probabilidade: ' + FormatFloat('##0.00', (StrToFloatDef(objJSON.GetValue('Probabilidade').Value,0)/100)) + ' %'+ #13#10 +
                         'Texto: ' + objJSON.GetValue('Texto').Value  +  #13#10 +
                         'Código Natureza Modelo: ' + objJSON.GetValue('CodigoNaturezaModelo').Value  +  #13#10 +
                         'Descrição Natureza: ' + objJSON.GetValue('DescricaoNatureza').Value  +  #13#10;
  End;

  Result := strLine;

End;

function TConsultaSCPCBoaVistaAcerta.fAcertaRegistrosDebitos(strJson: String): String;
var
  objJSON: TJSONObject;
  arrJSON: TJSONArray;
  strLine: String;
  intLine: Integer;

  function fGetOcorrencia(strTipOco:String): String;
  Begin
    if strTipOco = 'RG' Then  Result := 'Registrado';
    if strTipOco = 'IA' Then  Result := 'Imob. e Administração de Bens';
    if strTipOco = 'EC' Then  Result := 'Consórcio';
    if strTipOco = 'AL' Then  Result := 'Locadora';
    if strTipOco = 'SF' Then  Result := 'Emp. Crédito Imobiliário';
    if strTipOco = 'OJ' Then  Result := 'Outras Ativ. Econômicas';
    if strTipOco = 'TP' Then  Result := 'Título Protestado';
  End;

  function fGetSituacao(strSituacao:String): String;
  Begin
    if strSituacao = 'C' Then  Result := 'Comprador';
    if strSituacao = 'A' Then  Result := 'Avalista';
  End;

Begin
  arrJSON := fGetBlocoAcerta(strJson, 'DebitosTitulosProtestados_124' );

  If not assigned(arrJSON) then exit;

  strLine := '------------------------------------------------------------------' + #13#10 +
             '                     Registros de Débitos                         ' + #13#10 +
             '------------------------------------------------------------------' + #13#10 ;

  For intLine := 0 to arrJSON.count - 1 do
  Begin
    objJSON := arrJSON.Items[intLine] as TJSONObject;

    strLine := strLine + 'Ocorrência: ' + fFormataData(objJSON.GetValue('DataOcorrencia').Value) +  #13#10 +
                         'Disponibilização: ' +  fFormataData(objJSON.GetValue('DataDisponibilizacao').Value) +  #13#10 +
                         'Informante: ' + objJSON.GetValue('Informante').Value +  #13#10 +
                         'Tipo Ocorrência: ' + fGetOcorrencia(objJSON.GetValue('TipoOcorrencia').Value) +  #13#10 +
                         'Contrato: ' + objJSON.GetValue('Contrato').Value +  #13#10 +
                         'Cidade: ' + objJSON.GetValue('Cidade').Value +  #13#10 +
                         'UF: ' + objJSON.GetValue('UF').Value +  #13#10 +
                         'Situação: ' + fGetSituacao(objJSON.GetValue('Situacao').Value) +  #13#10 +
                         'Valor: ' + fFormataValor(objJSON.GetValue('Valor').Value) +  #13#10 +  #13#10;
  End;

  strAcertaPnDebitos := IntToStr( arrJSON.count );

  Result := strLine;

End;

function TConsultaSCPCBoaVistaAcerta.fAcertaProtestos(strJson: String): String;
var
  objJSON: TJSONObject;
  arrJSON: TJSONArray;
  strLine: String;
  intLine: Integer;
  intQtde: Integer;

Begin
  arrJSON := fGetBlocoAcerta(strJson, 'TotalTitulosProtestadosRegional_146', True );

  If not assigned(arrJSON) then exit;

  strLine := '------------------------------------------------------------------' + #13#10 +
             '                           Protestos                              ' + #13#10 +
             '------------------------------------------------------------------' + #13#10 ;

  intQtde := 0;
  For intLine := 0 to arrJSON.count - 1 do
  Begin
    If arrJSON.Items[intLine].ToJson = 'null' Then
      Continue;

    objJSON := arrJSON.Items[intLine] as TJSONObject;

    intQtde := intQtde + StrToInt(VarToStr(objJSON.GetValue('Total').Value));

    strLine := strLine + 'Total: '+ objJSON.GetValue('Total').Value +  #13#10 +
                         'UF: ' + objJSON.GetValue('UF').Value  +  #13#10 +
                         'Data Inicial: ' + fFormataData(objJSON.GetValue('PeriodoInicial').Value) +  #13#10 +
                         'Data Final: ' + fFormataData(objJSON.GetValue('PeriodoFinal').Value) +  #13#10 +
                         'Moeda: ' + objJSON.GetValue('Moeda').Value  +  #13#10 +
                         'Valor: ' + fFormataValor(objJSON.GetValue('Valor').Value)  +  #13#10 + #13#10 ;
  End;

  strAcertaPnProtestos := IntToStr(intQtde);

  Result := strLine;

End;

function TConsultaSCPCBoaVistaAcerta.fAcertaConsultasAnteriores(strJson: String): String;
var
  objJSON: TJSONObject;
  arrJSON: TJSONArray;
  strLine: String;
  intLine: Integer;

  function fGetOcorrencia(strTipOco:String): String;
  Begin
    if strTipOco = 'CC' Then  Result := 'Cartão de Crédito';
    if strTipOco = 'CD' Then  Result := 'Crédito Direto';
    if strTipOco = 'CG' Then  Result := 'Crédito Consignado';
    if strTipOco = 'CH' Then  Result := 'Cheque';
    if strTipOco = 'CP' Then  Result := 'Crédito Pessoal';
    if strTipOco = 'CV' Then  Result := 'Crédito Veículos';
    if strTipOco = 'OU' Then  Result := 'Outros';
  End;

Begin
  arrJSON := fGetBlocoAcerta(strJson, 'ConsultasAnteriores_126' );

  If not assigned(arrJSON) then exit;

  strLine := '------------------------------------------------------------------' + #13#10 +
             '                       Consultas Anteriores                       ' + #13#10 +
             '------------------------------------------------------------------' + #13#10 ;

  For intLine := 0 to arrJSON.count - 1 do
  Begin
    objJSON := arrJSON.Items[intLine] as TJSONObject;

    strLine := strLine + 'Data: '+ fFormataData(objJSON.GetValue('Data').Value) +  #13#10 +
                         'Empresa: ' + objJSON.GetValue('Informante').Value  +  #13#10 +
                         'Tipo Ocorrência: ' + fGetOcorrencia(objJSON.GetValue('TipoOcorrencia').Value) +  #13#10 +  #13#10;
  End;

  strAcertaPnConsultasAnteriores := IntToStr(arrJSON.count);

  Result := strLine;

End;

function TConsultaSCPCBoaVistaAcerta.fAcertaChequesSemFundos(strJson: String): String;
var
  objJSON: TJSONObject;
  arrJSON: TJSONArray;
  strLine: String;
  intLine: Integer;
  intQtde: Integer;
Begin
  arrJSON := fGetBlocoAcerta(strJson, 'DevolucaoCCF_242' );

  If not assigned(arrJSON) then exit;

  strLine := '------------------------------------------------------------------' + #13#10 +
             '                       Cheques Sem Fundo                          ' + #13#10 +
             '------------------------------------------------------------------' + #13#10 ;

  intQtde := 0;
  For intLine := 0 to arrJSON.count - 1 do
  Begin
    objJSON := arrJSON.Items[intLine] as TJSONObject;

    If objJSON.GetValue('Motivo12').Value <> '000' Then
    Begin
      intQtde := intQtde + StrToInt( varToStr( objJSON.GetValue('Motivo12').Value ) );
      strLine := strLine + 'Data Ocorrência: '+ fFormataData(objJSON.GetValue('DataUltimaOcorrenciaMotivo12').Value) +  #13#10 +
                           'Alínea: 12 '+  #13#10 +
                           'Banco: ' + objJSON.GetValue('NomeBanco').Value  +  #13#10 +
                           'Agência: ' + objJSON.GetValue('Agencia').Value  +  #13#10 +
                           'Quantidade: ' + objJSON.GetValue('Motivo12').Value  +  #13#10 +  #13#10;
    End;

    If objJSON.GetValue('Motivo13').Value <> '000' Then
    Begin
      intQtde := intQtde + StrToInt( varToStr( objJSON.GetValue('Motivo13').Value ) );
      strLine := strLine + 'Data Ocorrência: '+ fFormataData(objJSON.GetValue('DataUltimaOcorrenciaMotivo13').Value) +  #13#10 +
                           'Alínea: 13 '+  #13#10 +
                           'Banco: ' + objJSON.GetValue('NomeBanco').Value  +  #13#10 +
                           'Agência: ' + objJSON.GetValue('Agencia').Value  +  #13#10 +
                           'Quantidade: ' + objJSON.GetValue('Motivo13').Value  +  #13#10 +  #13#10;
    End;

    If objJSON.GetValue('Motivo14').Value <> '000' Then
    Begin
      intQtde := intQtde + StrToInt( varToStr( objJSON.GetValue('Motivo14').Value ) );
      strLine := strLine + 'Data Ocorrência: '+ fFormataData(objJSON.GetValue('DataUltimaOcorrenciaMotivo14').Value) +  #13#10 +
                           'Alínea: 14 '+  #13#10 +
                           'Banco: ' + objJSON.GetValue('NomeBanco').Value  +  #13#10 +
                           'Agência: ' + objJSON.GetValue('Agencia').Value  +  #13#10 +
                           'Quantidade: ' + objJSON.GetValue('Motivo14').Value  +  #13#10 +  #13#10;
    End;

    If objJSON.GetValue('Motivo99').Value <> '000' Then
    Begin
      intQtde := intQtde + StrToInt( varToStr( objJSON.GetValue('Motivo99').Value ) );
      strLine := strLine + 'Data Ocorrência: '+ fFormataData(objJSON.GetValue('DataUltimaOcorrenciaMotivo99').Value) +  #13#10 +
                           'Alínea: 99 '+  #13#10 +
                           'Banco: ' + objJSON.GetValue('NomeBanco').Value  +  #13#10 +
                           'Agência: ' + objJSON.GetValue('Agencia').Value  +  #13#10 +
                           'Quantidade: ' + objJSON.GetValue('Motivo99').Value  +  #13#10 +  #13#10;
    End;

  End;

  strAcertaPnChequesSemFundo := IntToStr(intQtde);

  Result := strLine;

End;

function TConsultaSCPCBoaVistaAcerta.fAcertaChequesSustados(strJson: String): String;
var
  objJSON: TJSONObject;
  arrJSON: TJSONArray;
  strLine: String;
  intLine: Integer;

  function fGetTipo(strTipo:String): String;
  Begin
    if strTipo = '1' Then
      Result := 'CPF'
    else
      Result := 'CNPJ';
  End;

Begin
  arrJSON := fGetBlocoAcerta(strJson, 'ChequeSustadoMotivo21_245' );

  If not assigned(arrJSON) then exit;

  strLine := '------------------------------------------------------------------' + #13#10 +
             '                   Cheques Sustados Motivo 21                     ' + #13#10 +
             '------------------------------------------------------------------' + #13#10 ;

  For intLine := 0 to arrJSON.count - 1 do
  Begin
    objJSON := arrJSON.Items[intLine] as TJSONObject;

    strLine := strLine + 'Tipo Documento: '+ fGetTipo(objJSON.GetValue('TipoDocumento').Value) +  #13#10 +
                         'Documento: ' + objJSON.GetValue('Documento').Value  +  #13#10 +
                         'Banco: ' + objJSON.GetValue('Banco').Value  +  #13#10 +
                         'Agência: ' + objJSON.GetValue('Agencia').Value  +  #13#10 +
                         'Conta Corrente: ' + objJSON.GetValue('ContaCorrente').Value  +  #13#10 +
                         'Cheque Inicial: ' + objJSON.GetValue('ChequeInicial').Value  +  #13#10 +
                         'Cheque Final: ' + objJSON.GetValue('ChequeFinal').Value  +  #13#10 +
                         'Alínea: ' + objJSON.GetValue('Alinea').Value  +  #13#10 +
                         'Data da Ocorrência: ' + fFormataData(objJSON.GetValue('DataOcorrencia').Value) +  #13#10 +
                         'Data da Disponibilização: ' + fFormataData(objJSON.GetValue('DataDisponibilizacao').Value) +  #13#10 +
                         'Moeda: ' + objJSON.GetValue('Moeda').Value  +  #13#10 +
                         'Valor: ' + fFormataValor(objJSON.GetValue('Valor').Value)  +  #13#10 +
                         'Informante: ' + objJSON.GetValue('Informante').Value  +  #13#10 + #13#10;
  End;

  strAcertaPnDevolucoesUsuario := IntToStr(arrJSON.count);

  Result := strLine;

End;

function TConsultaSCPCBoaVistaAcerta.fAcertaChequesDevolucoes(strJson: String): String;
var
  objJSON: TJSONObject;
  arrJSON: TJSONArray;
  strLine: String;
  intLine: Integer;

  function fGetTipo(strTipo:String): String;
  Begin
    if strTipo = '1' Then
      Result := 'CPF'
    else
      Result := 'CNPJ';
  End;

Begin
  arrJSON := fGetBlocoAcerta(strJson, 'DevolucaoUsuario_244' );

  If not assigned(arrJSON) then exit;

  strLine := '------------------------------------------------------------------' + #13#10 +
             '               Devoluções Informadas pelo Usuário                 ' + #13#10 +
             '------------------------------------------------------------------' + #13#10 ;

  For intLine := 0 to arrJSON.count - 1 do
  Begin
    objJSON := arrJSON.Items[intLine] as TJSONObject;

    strLine := strLine + 'Tipo Documento: '+ fGetTipo(objJSON.GetValue('TipoDocumento').Value) +  #13#10 +
                         'Documento: ' + objJSON.GetValue('Documento').Value  +  #13#10 +
                         'Banco: ' + objJSON.GetValue('Banco').Value  +  #13#10 +
                         'Agência: ' + objJSON.GetValue('Agencia').Value  +  #13#10 +
                         'Conta Corrente: ' + objJSON.GetValue('ContaCorrente').Value  +  #13#10 +
                         'Cheque Inicial: ' + objJSON.GetValue('ChequeInicial').Value  +  #13#10 +
                         'Cheque Final: ' + objJSON.GetValue('ChequeFinal').Value  +  #13#10 +
                         'Motivo: ' + objJSON.GetValue('Motivo').Value  +  #13#10 +
                         'Alínea: ' + objJSON.GetValue('Alinea').Value  +  #13#10 +
                         'Data da Ocorrência: ' + fFormataData(objJSON.GetValue('DataOcorrencia').Value) +  #13#10 +
                         'Data da Disponibilização: ' + fFormataData(objJSON.GetValue('DataDisponibilizacao').Value) +  #13#10 +
                         'Moeda: ' + objJSON.GetValue('Moeda').Value  +  #13#10 +
                         'Valor: ' + fFormataValor(objJSON.GetValue('Valor').Value)  +  #13#10 +
                         'Código do Informante: ' + objJSON.GetValue('CodigoInformante').Value  +  #13#10 +
                         'Informante: ' + objJSON.GetValue('Informante').Value  +  #13#10 +
                         'Cidade: ' + objJSON.GetValue('Cidade').Value  +  #13#10 +
                         'UF: ' + objJSON.GetValue('UF').Value +  #13#10 +  #13#10;
  End;

  strAcertaPnDevolucoesUsuario := IntToStr(arrJSON.count);

  Result := strLine;

End;

end.
