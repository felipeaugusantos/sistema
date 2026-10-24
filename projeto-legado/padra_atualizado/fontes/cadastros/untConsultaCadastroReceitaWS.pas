unit untConsultaCadastroReceitaWS;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Winapi.ActiveX, untInterfaces,
  IPPeerClient, REST.Client, Rest.Types, Vcl.Forms;

type
  TConsultaCadastroReceitaWS = class
  private
    cltCliente  : TRestClient;
    rspResponse : TRestResponse;
    reqRequest  : TRestRequest;

    FCodEmp: String;
    function fRealizarConsultaTRestClient(strLinkAPI : String): TStringStream;
    function fParseResponse(const arrJSON: TArray<Byte>): TRetornoConsultaCadastro;
  public
    constructor Create(strCodEmp: String);
    destructor Destroy; Override;
    function fConsultaCadastro(strCnpj: String): TRetornoConsultaCadastro;
  end;

implementation

{ TConsultaCadastroReceitaWS }

uses untFuncoesSimples;

constructor TConsultaCadastroReceitaWS.Create(strCodEmp: String);
begin
  inherited Create;

  FCodEmp := strCodEmp;
end;

destructor TConsultaCadastroReceitaWS.Destroy;
begin
  If Assigned(reqRequest) Then
    pFreeAndNil(reqRequest);
  If Assigned(rspResponse) Then
    pFreeAndNil(rspResponse);
  If Assigned(cltCliente) Then
    pFreeAndNil(cltCliente);

  inherited;
end;

function TConsultaCadastroReceitaWS.fConsultaCadastro(strCnpj: String): TRetornoConsultaCadastro;
Var
  strURL: String;
  strResultado: TStringStream;
begin
  Result := nil;
  strResultado := TStringStream.Create;
  Try
    strURL := 'https://www.receitaws.com.br/v1/cnpj/';
    strURL := strURL + strCnpj;

    strResultado := fRealizarConsultaTRestClient(strURL);

    If rspResponse.Status.Success Then
    Begin
      strResultado.Seek(0, soFromBeginning);
      Result := fParseResponse(strResultado.Bytes);
    End
    Else
    Begin
      Raise ErroConsultaCadastro.Create('Ocorreu um erro imprevisto na consulta!' + #13#10 +
                                        'Código do erro: ' + rspResponse.StatusCode.toString + #13#10 +
                                        'Descrição do erro: ' + rspResponse.ErrorMessage);
    End;
  Finally
    FreeAndNil(strResultado);
    CoFreeUnusedLibrariesEx(0,0);
  End;
end;

function TConsultaCadastroReceitaWS.fParseResponse(
  const arrJSON: TArray<Byte>): TRetornoConsultaCadastro;
var
  objJson: TJSONObject;
begin
  Result := nil;
  objJson := TJSONObject.Create;
  Try
    objJson.Parse(arrJSON, 0);

    If objJson.GetValue('status').Value = 'OK' Then
    Begin
      Result := TRetornoConsultaCadastro.Create();
      Result.strRazaoSocial  := objJson.GetValue('nome').Value;
      Result.strNomeFantasia := objJson.GetValue('fantasia').Value;
      Result.strIE           := '';
      Result.strEndereco     := objJson.GetValue('logradouro').Value;
      Result.strNumero       := objJson.GetValue('numero').Value;
      Result.strComplemento  := objJson.GetValue('complemento').Value;
      Result.strBairro       := objJson.GetValue('bairro').Value;
      Result.strCEP          := fTiraCaracEspeciaisPonto(objJson.GetValue('cep').Value);
      Result.strCodCidade    := '';
      Result.strDescSituacao := objJson.GetValue('situacao').Value;
      Result.blnHabilitado   := (objJson.GetValue('situacao').Value = 'ATIVA');
      Result.strCpfCnpj      := fTiraCaracEspeciaisPonto(objJson.GetValue('cnpj').Value);
      Result.strCnae         := fTiraCaracEspeciaisPonto(TJSONObject(TJSONArray(objJson.GetValue('atividade_principal')).Items[0]).GetValue('code').Value);
    End
    Else
      Raise ErroConsultaCadastro.Create(objJson.GetValue('message').Value);

  Finally
    FreeAndNil(objJson);
  End;
end;

function TConsultaCadastroReceitaWS.fRealizarConsultaTRestClient(strLinkAPI: String): TStringStream;
begin
  Result := TStringStream.Create('');

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

      reqRequest.Accept          := 'application/json';
      reqRequest.AcceptCharset   := 'UTF-8';
      reqRequest.Client          := cltCliente;
      reqRequest.Method          := rmGET;
      reqRequest.Response        := rspResponse;
      reqRequest.Timeout         := 60000;

      reqRequest.Execute;
      
      Result := TStringStream.Create(rspResponse.Content, TEncoding.UTF8);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

end.
