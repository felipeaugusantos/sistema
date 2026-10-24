unit Produto.GS1CNP.Service.Consulta;

interface

uses System.SysUtils, System.Classes, System.JSON, System.Variants, Vcl.Imaging.jpeg,
  Winapi.ActiveX, idHTTP,
  IdSSLOpenSSL, IdAuthentication, IdURI, untFuncoesSimples,
  Produto.GS1CNP.Interfaces.Service, Produto.GS1CNP.Interfaces.Consulta,
  Produto.GS1CNP.Tipos.Consulta, Produto.GS1CNP.Interfaces.JSONParse,
  Produto.GS1CNP.Shared.JSONParse, Produto.GS1CNP.Interfaces.Http, Produto.GS1CNP.Http;

type
  TProdutoGS1CNPServiceConsulta = class(TInterfacedObject, IProdutoGS1CNPServiceConsulta)
  private
    FHTTP: IProdutoGS1CNPHttp;
    FAccessToken: String;

    function ParseResponse(const AJson: String): IProdutoGS1CNPConsultaRetorno;
  public
    constructor Create(const AAccessToken: String); overload;
    destructor Destroy; override;

    function Consultar(const strCodBar: String): IProdutoGS1CNPConsultaRetorno;

    class function New(const AAccessToken: String): IProdutoGS1CNPServiceConsulta;
  end;

implementation

uses Produto.GS1CNP.Auth;

{ TProdutoGS1CNPServiceConsulta }

function TProdutoGS1CNPServiceConsulta.Consultar(
  const strCodBar: String): IProdutoGS1CNPConsultaRetorno;
Var
  LURL: String;
  LResponse: TStringStream;
begin
  Result := Nil;
  Try
    LURL := 'https://' + fCfgSis('GCURLA') + '/gs1/v0/products/';
    LURL := LURL + strCodBar;

    FHTTP.SetCustomHeaders(FAccessToken);

    Try
      LResponse := TStringStream.Create('', TEncoding.UTF8);
      LURL := TIdURI.URLEncode(LURL);

      FHTTP.GetHttp.Get(LURL, LResponse);

      If FHTTP.GetHttp.ResponseCode = 200 Then //sucesso
      Begin
        LResponse.Seek(0, soFromBeginning);
        Result := ParseResponse(LResponse.DataString);
        Exit;
      End;

      Raise Exception.Create('Ocorreu um erro imprevisto na consulta!' + #13#10 +
                                      'Código do erro: ' + IntToStr(FHTTP.GetHttp.ResponseCode) + #13#10 +
                                      'Descrição do erro: ' + FHTTP.GetHttp.ResponseText);

    Except
      On E: Exception Do
      Begin
        If FHTTP.GetHttp.ResponseCode = 400 Then
          Raise Exception.Create('A requisição é inválida!' + #13 + 'Erro código 400.')
        Else If FHTTP.GetHttp.ResponseCode = 404 Then
          Raise Exception.Create('Produto não encontrado!' + #13 + 'Erro código 404.')
        Else If FHTTP.GetHttp.ResponseCode = 500 Then
          Raise Exception.Create('Erro interno!' + #13 + 'Erro código 500.')
        Else
          Raise Exception.Create('Ocorreu um erro ao conectar-se ao serviço GS1/CNP: ' + E.Message);
      End;
    End
  Finally
    FreeAndNil(LResponse);
    CoFreeUnusedLibrariesEx(0,0);
  End;
end;

constructor TProdutoGS1CNPServiceConsulta.Create(const AAccessToken: String);
begin
  inherited Create;
  FHTTP := TProdutoGS1CNPHttp.New();
  FAccessToken := AAccessToken;
end;

destructor TProdutoGS1CNPServiceConsulta.Destroy;
begin
  inherited;
end;

class function TProdutoGS1CNPServiceConsulta.New(const AAccessToken: String): IProdutoGS1CNPServiceConsulta;
begin
  Result := Self.Create(AAccessToken);
end;

function TProdutoGS1CNPServiceConsulta.ParseResponse(const AJson: String): IProdutoGS1CNPConsultaRetorno;
  Var
    LJSONParse: IProdutoGS1CNPJSONParse;
begin
  LJSONParse := TProdutoGS1CNPJSONParse.New(AJson);

  Try
    Result := TProdutoGS1CNPConsultaRetorno.New;

    Result.SetStatus(LJSONParse.GetEntryValue('gtinStatusCode'));
    Result.SetDescricao(LJSONParse.GetEntryValueChild('tradeItemDescriptionInformation', 'tradeItemDescription', ''));
    Result.SetMarca(LJSONParse.GetEntryValueChild('brandNameInformation', 'brandName', ''));
    Result.SetPesoBruto(strToFloat(LJSONParse.GetEntryValueChild('tradeItemWeight', 'grossWeight', 'value', '0')));
    Result.SetPesoLiquido(strToFloat(LJSONParse.GetEntryValueChild('tradeItemWeight', 'netWeight', 'value', '0')));
    Result.SetCodigoGPC(LJSONParse.GetEntryValueChild('tradeItemClassification', 'gpcCategoryCode', ''));
    Result.SetImagem(LJSONParse.GetEntryArray('referencedFileInformations', 'uniformResourceIdentifier'));
    Result.SetNcm(LJSONParse.GetEntryNcmValueArray('tradeItemClassification', 'additionalTradeItemClassifications', 'additionalTradeItemClassificationSystemCode', 'additionalTradeItemClassificationCodeValue'));
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TProdutoGS1CNPService.ParseResponse]');
  End;
end;

end.
