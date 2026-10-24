unit untAncoraController;

interface

uses
  Soap.SOAPHTTPClient, untAwsRedeAncoraService, System.SysUtils;

type
  TAncoraController = class
  private
    FCnpj: string;
    FToken: string;
    FHttpRio: THTTPRIO;
    FWSRedeAncoraServiceSoapPort: WSRedeAncoraServiceSoapPort;
    FRequest: WSRedeAncoraService_Execute;
    FResponse: WSRedeAncoraService_ExecuteResponse;

    function GetCriterionListasPreco(ACodigoProdutoFornecedor, ACodigoCNA, AMarca: string): string;
    function GetCriterionBuscarProdutos(ACodigoCNA: string): string;

    procedure Executar(ServiceName, CriterionJson: string);
    function GetIdentification(ServiceName: string): string;
    function PrecisaGerarNovoToken(LNomeArquivo: string): Boolean;
    function BuscarToken: String;
    function GerarNovoToken: string;
    procedure VerificaComplementos;

    procedure TrataErro(AError: string);

  public
    constructor Create;
    destructor Destroy; override;
    function BuscaPreco(ACodigoProdutoFornecedor, ACodigoCNA, AMarca: string): Double;
    function fTemSaldo(ACodigoCNA: string; var fltPreco: Double): Boolean;
  end;

  EAncoraRetornoErro = class(Exception);

implementation

{ TAncoraController }

uses
  Vcl.Forms, System.Classes, System.DateUtils,
  untFuncoesSimples, untTypesSistema, untAncoraCriterionListasPreco, untAncoraIdentification,
  untAncoraResultListasPreco, untAncoraResultError,
  untAncoraCriterionBuscaProduto, untAncoraResultBuscaProduto, ShellApi;

function TAncoraController.BuscaPreco(ACodigoProdutoFornecedor,
  ACodigoCNA, AMarca: string): Double;
var
  LAncoraResultListasPrecoResultados: TAncoraResultListasPrecoResultados;
begin
  Result := 0;

  Executar(
    'ListasPreço',
    GetCriterionListasPreco(
      ACodigoProdutoFornecedor,
      ACodigoCNA,
      AMarca
    )
  );

  LAncoraResultListasPrecoResultados := TAncoraResultListasPrecoResultados.FromJsonString<TAncoraResultListasPrecoResultados>(FResponse.Result);
  try
    if Length(LAncoraResultListasPrecoResultados.Resultados) > 0 then
      Result := LAncoraResultListasPrecoResultados.Resultados[0].Preco;
  finally
    LAncoraResultListasPrecoResultados.Free;
  end;
end;

constructor TAncoraController.Create;
begin
  FHttpRio := THTTPRIO.Create(nil);
  FRequest := WSRedeAncoraService_Execute.Create;
  FCnpj := fRetCGCEmpresa(VS_strCodEmp);
  FToken := BuscarToken;

  FHttpRio.HTTPWebNode.SendTimeout := 15000; //15s
  FHttpRio.HTTPWebNode.ReceiveTimeout := 15000; //15s
  FHttpRio.HTTPWebNode.ConnectTimeout := 15000; //15s

  FWSRedeAncoraServiceSoapPort := GetWSRedeAncoraServiceSoapPort(False, fCfgSis('URLANC', varString), FHttpRio)
end;

destructor TAncoraController.Destroy;
begin
  FRequest.Free;
  if Assigned(FResponse) then
    FResponse.Free;
  inherited;
end;

procedure TAncoraController.Executar(ServiceName, CriterionJson: string);
begin
  FRequest.Identification := GetIdentification(ServiceName);
  FRequest.Criterion := CriterionJson;

  if Assigned(FResponse) then
    FreeAndNil(FResponse);

  FResponse := FWSRedeAncoraServiceSoapPort.Execute(FRequest);

  if not fEmptyStr(FResponse.Erros) then
    TrataErro(FResponse.Erros);
end;

function TAncoraController.fTemSaldo(ACodigoCNA: string; var fltPreco: Double): Boolean;
var
  LAncoraResultBuscaProdutoResultados: TAncoraResultBuscaProdutoResultados;
begin
  Result := False;

  Executar('BuscarProdutos',
           GetCriterionBuscarProdutos(
           ACodigoCNA));

  LAncoraResultBuscaProdutoResultados := TAncoraResultBuscaProdutoResultados.FromJsonString<TAncoraResultBuscaProdutoResultados>(FResponse.Result);
  try
    if Length(LAncoraResultBuscaProdutoResultados.Resultados) > 0 then
    Begin
      Result := LAncoraResultBuscaProdutoResultados.Resultados[0].Estoque > 0;
      fltPreco := LAncoraResultBuscaProdutoResultados.Resultados[0].Preco;
    End;

  finally
    LAncoraResultBuscaProdutoResultados.Free;
  end;
end;

function TAncoraController.GetCriterionListasPreco(ACodigoProdutoFornecedor, ACodigoCNA, AMarca: string): string;
var
  LCriterionListasPreco: TAncoraCriterionListasPreco;
begin
  LCriterionListasPreco := TAncoraCriterionListasPreco.Create;
  try
   LCriterionListasPreco.Filtros.ProdutoCodigoFornecedor := ACodigoProdutoFornecedor;
   LCriterionListasPreco.Filtros.ProdutoCNA := ACodigoCNA;
   LCriterionListasPreco.Filtros.Cnpj := FCnpj;
   LCriterionListasPreco.Filtros.Marca := AMarca;

   Result := LCriterionListasPreco.ToJsonString;
  finally
    LCriterionListasPreco.Free;
  end;
end;

function TAncoraController.GetCriterionBuscarProdutos(ACodigoCNA: string): string;
begin
Result := '{"Filtros":'+
          '{'+
          '"CNPJ":"'+FCnpj+'",'+
          '"Itens":'+
          '['+
          '{'+
          '"CNA":"'+ACodigoCNA+'",'+
          '"EAN":""'+
          '}'+
          ']'+
          '}'+
          '}';

end;

function TAncoraController.GetIdentification(ServiceName: string): string;
var
  LIndentification: TAncoraIdentification;
begin
  LIndentification := TAncoraIdentification.Create;
  try
    LIndentification.Security.Token := FToken;
    LIndentification.Service.Name := ServiceName;
    LIndentification.Service.Version := '1.5.0';

    Result := LIndentification.ToJsonString;
  finally
    LIndentification.Free;
  end;
end;

function TAncoraController.PrecisaGerarNovoToken(LNomeArquivo: string): Boolean;
var
  LDateFile: TDateTime;
begin
  Result := True;

  if not FileExists(LNomeArquivo) then
    Exit;

  if (not FileAge(LNomeArquivo, LDateFile)) then
    Exit;

  if (HoursBetween(fNow, LDateFile) > 23) then
    Exit;

  Result := False;
end;

procedure TAncoraController.TrataErro(AError: string);
var
  LListAncoraResultError: TListAncoraResultError;
  LErro: string;
  I: Integer;
begin
  LListAncoraResultError := TListAncoraResultError.FromJsonString<TListAncoraResultError>(AError);
  try
    for I := 0 to Pred(LListAncoraResultError.Messages.Count) do
      if not fEmptyStr(LListAncoraResultError.Messages[I].Message) then
        LErro := LErro + LListAncoraResultError.Messages[I].Message;

    raise EAncoraRetornoErro.Create(LErro);
  finally
    LListAncoraResultError.Free;
  end;
end;

procedure TAncoraController.VerificaComplementos;
var
  LNomeArquivo: string;
begin
  If (fMensagem(
    '',
    'Token de acesso ao Web Service não foi gerado com sucesso! Tente reinstalar o Microsoft Visual J#.' + sLineBreak + sLineBreak +
    'Deseja executar o instalador agora?' + sLineBreak + sLineBreak +
    'Após a instalação será necessário reiniciar o AUTCOM e tentar novamente!'
  , ['&Sim', '&Não']) = 1) Then
  begin
    LNomeArquivo := ExtractFilePath(Application.ExeName) + 'Ancora\vjredist.exe';
    if FileExists(LNomeArquivo) then
    begin
      ShellExecute(0, nil, PChar(LNomeArquivo), nil, nil, 1);
      raise Exception.Create('Após a reinstalação do Microsoft Visual J# reinicie o AUTCOM e tente novamente!');
    end
    else
      raise Exception.CreateFmt('Arquivo %s não existe! Instale o Microsoft Visual J# manualmente!', [LNomeArquivo]);
  end
  else
    raise Exception.Create('Instale o Microsoft Visual J# manualmente!');
end;

function TAncoraController.BuscarToken: String;
var
  LstrList: TStringList;
  LNomeArquivo: string;
begin
  LNomeArquivo := ExtractFilePath(Application.ExeName) + 'Ancora\ARATokenGenerator.txt';
  if PrecisaGerarNovoToken(LNomeArquivo) then
    Result := GerarNovoToken
  else
  begin
    LstrList := TStringList.Create;
    try
      LstrList.LoadFromFile(LNomeArquivo);
      Result := LstrList.Text.Trim;
    finally
      LstrList.Free;
    end;
  end;
end;

function TAncoraController.GerarNovoToken: string;
var
  LNomeArquivo: string;
  LExitCode: Cardinal;
begin
  LNomeArquivo := ExtractFilePath(Application.ExeName) + 'Ancora\tokengenerator.exe';
  if FileExists(LNomeArquivo) then
  begin
    LExitCode := fCriarProcessoSimplesExitCode(LNomeArquivo + ' ' + FCnpj, True, tcpOculto);
    if LExitCode <> 0 then
      VerificaComplementos
    else
      Result := BuscarToken;
  end
  else
    raise Exception.CreateFmt('Arquivo %s não existe! Não é possível gerar um novo Token', [LNomeArquivo]);
end;

end.
