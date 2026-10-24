{************************************************************}
{* Obtém o Comprovante de Inscrição e de Situação Cadastral *}
{* de Pessoa Jurídica através de consulta do CNPJ no portal *}
{* da Receita Federal.                                      *}
{* Adaptado do projeto ACBr (https://projetoacbr.com.br)    *}
{************************************************************}

unit untConsultaCNPJ;

interface

uses
  //Synapse
  httpsend, synautil, ssl_openssl, blcksock,
  Classes,
  Controls,
  SysUtils,
  untInterfaces;

type
  TConsultaCnpjReceitaFederal = class
  private
    { private declarations }
    objHttp: THTTPSend;
    respHttp: TStringList;
    strCaptcha: String;
    strCNPJ: String;
    procedure pRealizaConsulta;
    procedure pMontaCabecalhoRequisicao;
    procedure pTrataRetornoDeRequisicao(strMetodo, strURLOriginal: String);
    function fRetornaURLLocation(strURLOriginal: String): String;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    function fObtemCaptcha: Boolean;
    function fConsultaCadastro(const strCnpj, strCaptcha: String): TRetornoConsultaCadastro;
  end;

const
  URL_CAPT = 'https://solucoes.receita.fazenda.gov.br/Servicos/cnpjreva/captcha/gerarCaptcha.asp';
  URL_REFE = 'https://solucoes.receita.fazenda.gov.br/Servicos/cnpjreva/Cnpjreva_Solicitacao_CS.asp';
  URL_POST = 'https://solucoes.receita.fazenda.gov.br/Servicos/cnpjreva/valida.asp';
  TMP_CAPTCHA = 'captcha_cnpj.png';
  HTTP_TIMEOUT = 90000;

implementation

uses untFuncoesSimples, untConsultaCNPJ_util;

{ TConsultaCnpjReceitaFederal }

constructor TConsultaCnpjReceitaFederal.Create;
begin
  objHttp := THTTPSend.Create;
  respHttp := TStringList.Create;

  objHttp.Timeout := HTTP_TIMEOUT;

  objHttp.Sock.ConnectionTimeout   := HTTP_TIMEOUT;
  objHttp.Sock.InterPacketTimeout  := False;
  objHttp.Sock.NonblockSendTimeout := HTTP_TIMEOUT;
  objHttp.Sock.SocksTimeout        := HTTP_TIMEOUT;
  objHttp.Sock.HTTPTunnelTimeout   := HTTP_TIMEOUT;
end;

destructor TConsultaCnpjReceitaFederal.Destroy;
begin
  objHttp.Free;
  respHttp.Free;
  inherited;
end;

function TConsultaCnpjReceitaFederal.fObtemCaptcha: Boolean;
begin
  Try
    objHttp.Clear;
    objHttp.HTTPMethod('GET', URL_CAPT);

    pTrataRetornoDeRequisicao('GET', URL_CAPT);

    Result := (objHttp.ResultCode = 200);

    If Result Then
      objHttp.Document.SaveToFile(fRetTemporaryDir + TMP_CAPTCHA);
  Except
    On E: Exception Do
      Raise ErroConsultaCadastro.Create('Erro ao obter o captcha: '+ E.Message);
  End;
end;

function TConsultaCnpjReceitaFederal.fConsultaCadastro(const strCnpj, strCaptcha: String): TRetornoConsultaCadastro;
  Var
    stlRetorno: TStringList;
    blnRetentar: Boolean;
    intTentativas: Integer;
    strErro: String;
begin
  Result := TRetornoConsultaCadastro.Create;
  stlRetorno := TStringList.Create;

  Self.strCNPJ := strCnpj;
  Self.strCaptcha := strCaptcha;

  Try
    blnRetentar   := True;
    intTentativas := 0;

    While blnRetentar Do
    Begin
      pRealizaConsulta;

      blnRetentar := (intTentativas < 5) And
                     (Pos('Captcha Sonoro', respHttp.Text) > 0) And
                     (Pos('Digite o número de CNPJ da empresa e clique em', respHttp.Text) > 0);
      Inc(intTentativas);
    End;

    strErro := fVerificaErros(respHttp.Text);
    If strErro <> '' Then
      Raise ErroConsultaCadastro.Create(strErro);

    stlRetorno.Text := fStripHTML(respHttp.Text);
    pRemoveEmptyLines(stlRetorno);

    Result.strRazaoSocial := fLerCampo(stlRetorno, 'NOME EMPRESARIAL');

    If Trim(Result.strRazaoSocial) = '' Then
      Raise ErroConsultaCadastro.Create('Não foi possível obter os dados, tente novamente.');

    Result.strNomeFantasia := fLerCampo(stlRetorno, 'TÍTULO DO ESTABELECIMENTO (NOME DE FANTASIA)');
    Result.strIE           := '';
    Result.strEndereco     := fLerCampo(stlRetorno, 'LOGRADOURO');
    Result.strNumero       := fLerCampo(stlRetorno, 'NÚMERO');
    Result.strComplemento  := fLerCampo(stlRetorno, 'COMPLEMENTO');
    Result.strBairro       := fLerCampo(stlRetorno, 'BAIRRO/DISTRITO');
    Result.strCEP          := fTiraCaracEspeciaisPonto(fLerCampo(stlRetorno, 'CEP'));
    Result.strCodCidade    := '';
    Result.strDescSituacao := fLerCampo(stlRetorno, 'SITUAÇÃO CADASTRAL');
    Result.blnHabilitado   := (Result.strDescSituacao = 'ATIVA');
    Result.strCpfCnpj      := fTiraCaracEspeciaisPonto(fLerCampo(stlRetorno, 'NÚMERO DE INSCRIÇÃO'));
    Result.dtaDataAbertura := StrToDateDef(fLerCampo(stlRetorno, 'DATA DE ABERTURA'), 0);    
    Result.strCnae         := fLerCampo(stlRetorno, 'CÓDIGO E DESCRIÇÃO DA ATIVIDADE ECONÔMICA PRINCIPAL');

    If Pos(' - ', Result.strCnae) > 0 Then
      Result.strCnae := Copy(Result.strCnae, 1, Pos(' - ', Result.strCnae) -1);
    Result.strCnae := Trim(fTiraCaracEspeciaisPonto(Result.strCnae));

  Finally
    stlRetorno.Free;
  End;
end;

procedure TConsultaCnpjReceitaFederal.pRealizaConsulta;
  Var
    strMetodo: String;
begin
  respHttp.Clear;

  strMetodo := 'POST';

  objHttp.Clear;
  pMontaCabecalhoRequisicao;
  objHttp.HTTPMethod(strMetodo, URL_POST);

  pTrataRetornoDeRequisicao(strMetodo, URL_POST);

  respHttp.LoadFromStream(objHttp.Document);

  If objHttp.ResultCode <> 200 Then
    Raise ErroConsultaCadastro.Create('code: '+ IntToStr(objHttp.ResultCode) + sLineBreak +
                                      'error: '+ objHttp.Sock.LastErrorDesc + sLineBreak +
                                      'url: '+ URL_POST);
end;

procedure TConsultaCnpjReceitaFederal.pMontaCabecalhoRequisicao;
  Var
    strEnvio: String;
    strEnvioUTF8: UTF8String;
begin
  strEnvio := 'origem=comprovante&'+
              'cnpj='+ fTiraCaracEspeciaisPonto(strCnpj) +'&'+
              'txtTexto_captcha_serpro_gov_br='+ Trim(strCaptcha) +'&'+
              'search_type=cnpj';

  strEnvioUTF8 := UTF8String(strEnvio);

  objHttp.Document.Write(PAnsiChar(strEnvioUTF8)^, Length(strEnvioUTF8));
  objHttp.MimeType := 'application/x-www-form-urlencoded';
  objHttp.Cookies.Add('flag=1');
  objHttp.Headers.Add('Accept-Charser: utf-8;q=*;q=0.7');
  objHttp.Headers.Add('Referer: '+ URL_REFE);
end;

function TConsultaCnpjReceitaFederal.fRetornaURLLocation(strURLOriginal: String): String;
  Var
    strLocation: String;
begin
  strLocation := fFindInList(objHttp.Headers, 'Location:');
  strLocation := Trim(SeparateLeft(strLocation, ';'));

  If fIsAbsoluteURL(strLocation) Then
    Result := strLocation
  Else
    Result := fGetUrlBasePath(strURLOriginal) + strLocation;
end;

procedure TConsultaCnpjReceitaFederal.pTrataRetornoDeRequisicao(strMetodo, strURLOriginal: String);
  Var
    intTentativa: Integer;
    strNovaURL: String;
    strNovoMetodo: String;
begin
  intTentativa := 0;

  While intTentativa <= 10 Do
  Begin
    Inc(intTentativa);

    Case objHttp.ResultCode Of
      301, 302, 303, 307:
      Begin
        strNovaURL := fRetornaURLLocation(strURLOriginal);
        strNovoMetodo := strMetodo;

        objHttp.Clear;

        If (strMetodo.Equals('POST')) Then
        Begin
          pMontaCabecalhoRequisicao;

          If (objHttp.ResultCode = 300) Then
            strNovoMetodo := 'GET';
        End;

        objHttp.HTTPMethod(strNovoMetodo, strNovaURL);
      End;
    Else
      Break;
    End;
  End;
end;

end.
