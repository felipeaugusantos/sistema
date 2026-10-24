unit untConsultaSimplesNacional;

interface

uses
  System.SysUtils, System.Classes, VCL.TMSFNCWebBrowser, VCL.Controls, VCL.Dialogs, untInterfaces;

type
  ConsultaSimplesException = class(Exception);
  ConsultaSimplesCaptchaException = class(ConsultaSimplesException);

  TConsultaSimplesStatus = (stNull = -4, stDocInvalido = -3, stConsulta = 0, stPaginaDesconhecida = -1, stValidationError = -2, stResultado = 1);

  TConsultaSimplesStatusConverter = class
    public
      //devolve o status do tipo enumerado com base no string retornado pela função javascript
      class function statusFromStr(AStr: string): TConsultaSimplesStatus;
  end;

  TConsultaSimples = class
  private
    const
      //url base do serviço
      url = 'https://consopt.www8.receita.fazenda.gov.br/consultaoptantes';

      //url alternativa
      url_alt = 'http://consopt.www8.receita.fazenda.gov.br/consultaoptantes';

      //funcao javascript para retornar o status da página atual
      js_func_obter_status =
        'function getCurrentPage(){                                                                                                               ' +
        'if (document.getElementById("consultarForm")){                                                                                           ' +
        'if ([].slice.call(document.getElementsByClassName("validation-summary-errors")).map(div => div.innerText, []).length > 0)                ' +
        'return -2;                                                                                                                               ' +
        'if ([].slice.call(document.getElementsByTagName("span")).find(span => span.innerText.toLowerCase().includes("informe um cnpj válido")))  ' +
        'return -3;                                                                                                                               ' +
        'if ([].slice.call(document.getElementsByTagName("span")).find(span => span.innerText.toLowerCase().includes("cnpj inválido")))           ' +
        'return -3; return 0;                                                                                                                     ' +
        '} else {                                                                                                                                 ' +
        'if ((document.getElementById("conteudo")) && (document.getElementById("conteudo").innerText.toLowerCase().includes("data da consulta"))) ' +
        'return 1; return -1; }}                                                                                                                  ' ;

      //funcao javascript para retornar os valores da consulta
      js_func_obter_resp =
        'function getContentByLabel(label){                                                   ' +
        '  label = label.toLowerCase() + ": ";                                                ' +
        '  let content =                                                                      ' +
        '	[].slice.call(document.getElementsByClassName("panel-body"))                        ' +
        '      .find(div => div.innerText.toLowerCase().includes(label))                      ' +
        '	  .innerText.toLowerCase();                                                         ' +
        '  content = content.substring(content.indexOf(label) + label.length, content.length) ' +
        '    .toUpperCase();                                                                  ' +
        '  if (content.indexOf("\n") >= 0)                                                    ' +
        '     content = content.substring(0, content.indexOf("\n"));                          ' +
        '  return content;                                                                    ' +
        '}                                                                                    ' ;

    var FBrowser: TTMSFNCWebBrowser;

    procedure Carregar; //carrega a pagina inicial da consulta
    procedure PreencherDocumento(ACNPJ: string); //preenche o documento no campo da consulta
    function Consultar: TRetornoConsultaCadastro; //clica no botão para consultar e trata o retorno

    procedure BrowserNavigateComplete(Sender: TObject; var Params: TTMSFNCCustomWebBrowserNavigateCompleteParams); //evento do componente browser

  public
    function ConsultarCNPJ(ACNPJ: string): TRetornoConsultaCadastro ; //executa a consulta de forma síncrona

    constructor Create(ABrowser: TTMSFNCWebBrowser);
    destructor Destroy; override;
end;

implementation

uses
  System.StrUtils, VCL.Forms;

{ TConsultaSimples }

constructor TConsultaSimples.Create(ABrowser: TTMSFNCWebBrowser);
begin
  FBrowser := ABrowser;
  FBrowser.BeginUpdate;
  FBrowser.OnNavigateComplete := BrowserNavigateComplete;
  FBrowser.EndUpdate;
  FBrowser.Url := 'about:blank';
end;

destructor TConsultaSimples.Destroy;
begin
  FBrowser.BeginUpdate;
  FBrowser.OnNavigateComplete := nil;
  FBrowser.EndUpdate;
  FBrowser.Url := 'about:blank';
  inherited;
end;

procedure TConsultaSimples.BrowserNavigateComplete(Sender: TObject;
  var Params: TTMSFNCCustomWebBrowserNavigateCompleteParams);
begin
  //sempre que a página é carregada, injeta função javascript que permite consultar o status
  FBrowser.ExecuteJavaScript(js_func_obter_status);
end;

procedure TConsultaSimples.Carregar;
var
  LTentativas: Integer;
  LStatus: TConsultaSimplesStatus;
begin
  //navega para a página inicial da consulta
  FBrowser.URL := url;
  //verifica se a página inicial da consulta foi carregada
  LTentativas := 0;
  repeat
    Sleep(200);
    Inc(LTentativas);
    Application.ProcessMessages;
    LStatus := TConsultaSimplesStatusConverter.statusFromStr(FBrowser.ExecuteJavaScriptSync('getCurrentPage()'));
  until (LStatus = stConsulta) or (LTentativas >= 50); //timeout ~10 segundos 200ms * 50

  if LStatus <> stConsulta then
    raise ConsultaSimplesException.Create('Erro ao carregar consulta.');
end;

procedure TConsultaSimples.PreencherDocumento(ACNPJ: string);
begin
  Sleep(100);
  FBrowser.ExecuteJavaScript('document.getElementById("Cnpj").value = "' + ACNPJ + '"');
end;

function TConsultaSimples.Consultar: TRetornoConsultaCadastro;
var
  LTentativas: Integer; LAuxMsg: string;
  LStatus: TConsultaSimplesStatus;
begin
  Result := TRetornoConsultaCadastro.Create;
  try
    //clica no botao de consulta
    FBrowser.ExecuteJavaScript('[].slice.call(document.getElementById("consultarForm").getElementsByTagName("button")).find(btn => btn.innerText.toLowerCase = "consultar").click();');

    //aguarda o carregamento da página e captura o status do retorno
    LTentativas := 0;
    repeat
      Sleep(200);
      Inc(LTentativas);
      Application.ProcessMessages;
      LStatus := TConsultaSimplesStatusConverter.statusFromStr(FBrowser.ExecuteJavaScriptSync('getCurrentPage()'));
    until ((LStatus <> stNull) and (LStatus <> stConsulta)) or (LTentativas >= 50); //timeout ~10 segundos 200ms * 50

    //trata os possíveis retornos
    case LStatus of
      stResultado:
      begin
        FBrowser.ExecuteJavaScript(js_func_obter_resp);
        Result.strRazaoSocial     := StringReplace(FBrowser.ExecuteJavaScriptSync('getContentByLabel("nome empresarial")'), '"', '', [rfReplaceAll, rfIgnoreCase]);
        Result.strSituacaoSimples := StringReplace(FBrowser.ExecuteJavaScriptSync('getContentByLabel("situação no simples nacional")'), '"', '', [rfReplaceAll, rfIgnoreCase]);
        Result.strSituacaoSimei   := StringReplace(FBrowser.ExecuteJavaScriptSync('getContentByLabel("situação no simei")'), '"', '', [rfReplaceAll, rfIgnoreCase]);
      end;

      stValidationError:
      begin
        LAuxMsg := StringReplace(FBrowser.ExecuteJavaScriptSync('[].slice.call(document.getElementsByClassName("validation-summary-errors")).map(div => div.innerText, []).join("; ")'), '"', '', [rfReplaceAll, rfIgnoreCase]);

        if LAuxMsg.ToLower.Contains('captcha') then
          raise ConsultaSimplesCaptchaException.Create(LAuxMsg)
        else
          raise ConsultaSimplesException.Create(LAuxMsg);
      end;

      stDocInvalido:
        raise ConsultaSimplesException.Create('CNPJ inválido.');

      stNull, stPaginaDesconhecida, stConsulta:
        raise ConsultaSimplesException.Create('Erro ao realizar consulta.');
    end;
  except
    FreeAndNil(Result);

    raise;
  end;
end;

function TConsultaSimples.ConsultarCNPJ(ACNPJ: string): TRetornoConsultaCadastro;
var
  LTentativas: Integer;
  LTentarNovamente: Boolean;
begin
  Result := nil;

  if ACNPJ.IsEmpty then
    raise ConsultaSimplesException.Create('CNPJ não informado para consulta.');

  LTentativas := 0;
  LTentarNovamente := False;
  repeat
    try
      Inc(LTentativas);
      Sleep(300);
      Self.Carregar;
      Sleep(300);
      Self.PreencherDocumento(ACNPJ);
      Sleep(400);
      Result := Self.Consultar;

      LTentarNovamente := False;
    except
      on ECaptcha: ConsultaSimplesCaptchaException do
      begin
        if LTentativas >= 5 then
          raise;

        LTentarNovamente := True;
        Sleep(500);
      end;

      on E: Exception do
        raise;
    end;
  until (not LTentarNovamente);
end;

{ TConsultaSimplesStatusConverter }

class function TConsultaSimplesStatusConverter.statusFromStr(
  AStr: string): TConsultaSimplesStatus;
begin
  case AnsiIndexStr(AStr.ToUpper, ['NULL', '-3', '-2', '-1', '0', '1']) of
    0: Result := stNull;
    1: Result := stDocInvalido;
    2: Result := stValidationError;
    3: Result := stPaginaDesconhecida;
    4: Result := stConsulta;
    5: Result := stResultado;
    else
      Result := stNull;
  end;
end;

end.
