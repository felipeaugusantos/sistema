{*****************************************************}
{* Importação de arquivos com RESTClient da PagarMe  *}
{**************************************************MT*}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{****************************************MT*}
unit untTImportaPagamentosPagarMe;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Vcl.Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  ComCtrls, cxCalendar, IPPeerClient, DateUtils, System.Generics.Collections,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Json, untPagarMePgto, REST.Authenticator.Basic,IdHTTP,IdSSLOpenSSL,IdComponent;

Type
  TChavesPagarMe = class
  private
  public
    Empresa,
    ApiKey,
    Versao : String
  end;

  TTipoDataRecebivel = (tdCadastro, tdPagamento);

Type
  TImportaPagamentosPagarMe = Class(TComponent)
  Private
    procedure ImportarTransferencias(AStatusTransferencia: String;
                                     AChaveSelecionada: TChavesPagarMe;
                                     ADataInicial,
                                     ADataFinal: TDateTime;
                                     AiCartoes: TPagarMePgto);
    procedure CorrigirValoresMovCar;
    var
    frmForm   : TForm;
    pgbProg   : TProgressBar;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    memXMLDoc : TMemo;
    lblInform : TLabel;
    pnlFund   : TPanel;

    FAplicacao: HWND;

    FListaChaves: TList<TChavesPagarMe>;

    LLinkTransacoes,  //v4
    LLinkRecebiveisTransacao, //v4
    FLinkCobranca, //v5
    FLinkCobrancaPorId, //v5
    FLinkRecebiveis,
    FLinkTransferencias, //v5
    FAmbiente: String;
    FImportouVendas: Boolean;
    FImportouCobrancas: Boolean;
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;

    procedure OnAfterExecute(Sender: TCustomRESTRequest);

    procedure pDisableControls(blnDisable: Boolean);
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function fRetUltimaData: String;

    function RetornaListaDeChavesPagarMe: TList<TChavesPagarMe>;

    procedure CriarComponentesRequisicao;
    procedure DestroiComponentesRequisicao;
    procedure ProcessaDownload;
    procedure DownloadDataSelecionada(AChaveSelecionada: TChavesPagarMe;
                                      ADataInicial,
                                      ADataFinal: TDateTime;
                                      AiCartoes: TPagarMePgto);

    procedure DownloadDataSelecionadaAPIv5(AChaveSelecionada: TChavesPagarMe;
                                           ADataInicial,
                                           ADataFinal: TDateTime;
                                           AiCartoes: TPagarMePgto);

    procedure DownloadCobrancaPorId(AChaveSelecionada: TChavesPagarMe;
                                    ACobranca_ID: String;
                                    AiCartoes: TPagarMePgto);

    procedure DownloadCobrancasNaoEncontradas(AListaCobrancas: TStringList;
                                              AChaveSelecionada: TChavesPagarMe;
                                              AiCartoes: TPagarMePgto);

    procedure ImportarCobrancas(AChaveSelecionada: TChavesPagarMe;
                                ADataInicial,
                                ADataFinal: TDateTime;
                                AiCartoes: TPagarMePgto;
                                AStatus: String);

    procedure ImportarRecebiveis(ATipoData: TTipoDataRecebivel;
                                 AChaveSelecionada: TChavesPagarMe;
                                 ADataInicial, ADataFinal: TDateTime;
                                 AiCartoes: TPagarMePgto);

    procedure CarregaLinks;

    function RetornaLinkFormatado(ALinkOriginal: String;
                                  AChaveSelecionada: TChavesPagarMe;
                                  ADataInicial,
                                  ADataFinal: TDateTime;
                                  APagina: String = '';
                                  AStatus: String = '';
                                  ATipo: String = ''): String;

    function RetornaLinkFormatadoAPIv5(ALinkOriginal: String;
                                       AChaveSelecionada: TChavesPagarMe;
                                       ADataInicial,
                                       ADataFinal: TDateTime;
                                       APagina: String = '';
                                       AStatus: String = ''): String;

    function RetornarLinkFormatadoApiRecebiveisV5(ALinkOriginal: String;
                                                  AChaveSelecionada: TChavesPagarMe;
                                                  ATipoData: TTipoDataRecebivel;
                                                  ADataInicial,
                                                  ADataFinal: TDateTime;
                                                  APagina: String = '1'): String;

    function RetornaLinkFormatadoApiTransferenciasV5(ADataInicial,
                                                     ADataFinal: TDateTime;
                                                     AStatus,
                                                     APagina: String): String;

    function OnException(Var AAutorizado: Boolean; Var AMsgErro :String;
                         Var AContador: Integer; AChaveSelecionada: TChavesPagarMe;
                             AMensagem: String): Boolean;

    function Autorizado(AAutorizado: Boolean; AContador: Integer):Boolean;
    function GetRestResponseError: TRestResponse;
    function FormatarJson(AResponseContent: String): String;
    function RetornaStatusCobranca(AResponseContent: String): String;
  Public
    property Aplicacao: HWND read FAplicacao write FAplicacao;
    property ImportouVendas: Boolean read FImportouVendas;
    property ImportouCobrancas: Boolean read FImportouCobrancas;
    property DataInicial: TDateTime read FDataInicial;
    property DataFinal: TDateTime read FDataFinal;
    procedure pSelecionaFonte;
    function RetornaEmpresasApiV5: String;

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  protected
    FRestClient: TRestClient;
    FRestRequest: TRestRequest;
    FRestResponse: TRestResponse;

    FChavesStone: TStringList;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TImportaPagamentosPagarMe }

procedure TImportaPagamentosPagarMe.CarregaLinks;
begin
  LLinkTransacoes := 'https://api.pagar.me/1/transactions?count=1000&page=[PAGINA]&status=[STATUS]'+
                     '&date_created=>=[INICIO]&date_created=<=[FIM]&api_key=[KEY]';

  LLinkRecebiveisTransacao := 'https://api.pagar.me/1/payables?count=1000&page=[PAGINA]&status=[STATUS]'+
                              '&type=[TIPO]&payment_date=>=[INICIO]&payment_date=<=[FIM]&api_key=[KEY]';

  FLinkCobranca := 'https://api.pagar.me/core/v5/charges?created_since=[INICIO]&created_until=[FIM]&size=30'+
                   '&status=[STATUS]&page=[PAGINA]';

  FLinkCobrancaPorId := 'https://api.pagar.me/core/v5/charges/';

  FLinkRecebiveis := 'https://api.pagar.me/core/v5/payables?size=30&page=[PAGINA]';

  FLinkTransferencias := 'https://api.pagar.me/core/v5/balance/operations' +
                         '?created_since=[INICIO]' +
                         '&created_until=[FIM]' +
                         '&status=[STATUS]' +
                         '&size=1000' +
                         '&page=[PAGINA]';

  FAmbiente := 'PRODUÇÃO';
end;

constructor TImportaPagamentosPagarMe.Create(Owner: TComponent);
begin
  inherited;
  CarregaLinks;
  FListaChaves := RetornaListaDeChavesPagarMe;
  CriarComponentesRequisicao;
  FImportouVendas := False;
  FImportouCobrancas := False;
end;

procedure TImportaPagamentosPagarMe.CriarComponentesRequisicao;
begin
  FRestClient := TRestClient.Create(Nil);
  FRestClient.RaiseExceptionOn500 := False;
  FRestClient.HandleRedirects := True;
  FRestClient.SynchronizedEvents := True;

  FRestResponse := TRestResponse.Create(Nil);

  FRestRequest := TRestRequest.Create(Nil);
  FRestRequest.Client := FRestClient;
  FRestRequest.Response := FRestResponse;
  FRestRequest.Method := rmGet;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.OnAfterExecute := OnAfterExecute;

  FRestRequest.Params.AddHeader('Authorization', '');
  FRestRequest.Params.AddHeader('Content-Type', 'application/json');
end;

procedure TImportaPagamentosPagarMe.DestroiComponentesRequisicao;
begin
  FreeAndNil(FRestResponse);
  FreeAndNil(FRestRequest);
  FreeAndNil(FRestClient);
end;

destructor TImportaPagamentosPagarMe.Destroy;
begin
  inherited;
  FreeAndNil(FListaChaves);
  DestroiComponentesRequisicao;
end;

procedure TImportaPagamentosPagarMe.DownloadCobrancaPorId(AChaveSelecionada: TChavesPagarMe;
  ACobranca_ID: String; AiCartoes: TPagarMePgto);
begin
  if Trim(ACobranca_ID).IsEmpty then
    Exit;

  try
    FRestClient.BaseUrl := FLinkCobrancaPorId + ACobranca_ID;
    FRestRequest.Execute;

    If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

    If Not FRestResponse.Content.Equals('{}') and
       MatchStr(RetornaStatusCobranca(FRestResponse.Content),
                ['paid', 'canceled', 'chargedback']) Then
    Begin
      AiCartoes.TipoDoArquivo := 'Cobrancas';
      AiCartoes.KeyApi :=  AChaveSelecionada.ApiKey;
      AiCartoes.pAdicionaLinha(FormatarJson(FRestResponse.Content), pgbProg);
    End
  except
    On E: Exception do
      raise Exception.Create('Problemas ao buscar cobrança por id. ' + E.Message);
  end;
end;

procedure TImportaPagamentosPagarMe.DownloadCobrancasNaoEncontradas(
  AListaCobrancas: TStringList; AChaveSelecionada: TChavesPagarMe;
  AiCartoes: TPagarMePgto);
var
  LCobranca_ID: String;
begin
  if AListaCobrancas.Count < 1 then
    Exit;

  try
    FRestClient.Authenticator := THTTPBasicAuthenticator.Create(AChaveSelecionada.ApiKey,'');

    lblInform.Caption := 'Aguarde... Importando cobranças da empresa ' + AChaveSelecionada.Empresa + '.';
    Application.ProcessMessages;

    for LCobranca_ID in AListaCobrancas do
    begin
      DownloadCobrancaPorId(AChaveSelecionada, LCobranca_ID, AiCartoes);
      Sleep(500);
    end;
  except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TImportaPagamentosPagarMe.DownloadDataSelecionada(AChaveSelecionada: TChavesPagarMe;
                                                            ADataInicial,
                                                            ADataFinal: TDateTime;
                                                            AiCartoes: TPagarMePgto);
  Var
    LContador: Integer;

    LAutorizado: Boolean;

    LMensagem: String;
    LMsgErro : String;
    LFimDaImportacao: Boolean;
    LPagina: Integer;
Begin
  LAutorizado := False;

  LContador := 0;

  While Not Autorizado(LAutorizado,LContador) Do
  Begin
    Try
      LFimDaImportacao := False;
      LPagina := 1;
      Repeat
        //Pagamentos
        lblInform.Caption := 'Aguarde... Importando pagamentos da empresa ' + AChaveSelecionada.Empresa + '.';
        Application.ProcessMessages;

        FRestClient.BaseUrl := RetornaLinkFormatado(LLinkTransacoes,
                                                    AChaveSelecionada,
                                                    ADataInicial,
                                                    ADataFinal,
                                                    LPagina.ToString,
                                                    'paid');

        FRestRequest.Execute;


        If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

        If Not FRestResponse.Content.Equals('[]') Then
        Begin
          AiCartoes.TipoDoArquivo := 'Pagamentos';
          AiCartoes.KeyApi :=  AChaveSelecionada.ApiKey;
          AiCartoes.pAdicionaLinha(FRestResponse.Content,pgbProg);
          Inc(LPagina);
        End Else LFimDaImportacao := True;

      Until (LFimDaImportacao);

      LFimDaImportacao := False;
      LPagina := 1;
      Repeat
        //vendas pagas
        lblInform.Caption := 'Aguarde... Importando vendas pagas da empresa ' + AChaveSelecionada.Empresa + '.';
        Application.ProcessMessages;

        FRestClient.BaseUrl := RetornaLinkFormatado(LLinkRecebiveisTransacao,
                                                    AChaveSelecionada,
                                                    ADataInicial,
                                                    ADataFinal,
                                                    LPagina.ToString,
                                                    'paid',
                                                    'credit');

        FRestRequest.Execute;


        If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

        If Not FRestResponse.Content.Equals('[]') Then
        Begin
          AiCartoes.TipoDoArquivo := 'VendasPagas';
          AiCartoes.KeyApi :=  AChaveSelecionada.ApiKey;
          AiCartoes.pAdicionaLinha(FRestResponse.Content,pgbProg);
          Inc(LPagina);
        End Else LFimDaImportacao := True;

      Until (LFimDaImportacao);

      LFimDaImportacao := False;
      LPagina := 1;
      Repeat
        //reembolsos
        lblInform.Caption := 'Aguarde... Importando reembolsos da empresa ' + AChaveSelecionada.Empresa + '.';
        Application.ProcessMessages;

        FRestClient.BaseUrl := RetornaLinkFormatado(LLinkTransacoes,
                                                    AChaveSelecionada,
                                                    ADataInicial,
                                                    ADataFinal,
                                                    LPagina.ToString,
                                                    'refunded');

        FRestRequest.Execute;


        If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

        If Not FRestResponse.Content.Equals('[]') Then
        Begin
          AiCartoes.TipoDoArquivo := 'Reembolsos';
          AiCartoes.KeyApi :=  AChaveSelecionada.ApiKey;
          AiCartoes.pAdicionaLinha(FRestResponse.Content,pgbProg);
          Inc(LPagina);
        End Else LFimDaImportacao := True;

      Until (LFimDaImportacao);

      LFimDaImportacao := False;
      LPagina := 1;
      Repeat
        //Vendas Reembolsadas
        lblInform.Caption := 'Aguarde... Importando vendas reembolsadas da empresa ' + AChaveSelecionada.Empresa + '.';
        Application.ProcessMessages;

        FRestClient.BaseUrl := RetornaLinkFormatado(LLinkRecebiveisTransacao,
                                                    AChaveSelecionada,
                                                    ADataInicial,
                                                    ADataFinal,
                                                    LPagina.ToString,
                                                    'paid',
                                                    'refund');

        FRestRequest.Execute;


        If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

        If Not FRestResponse.Content.Equals('[]') Then
        Begin
          AiCartoes.TipoDoArquivo := 'VendasReembolsadas';
          AiCartoes.KeyApi :=  AChaveSelecionada.ApiKey;
          AiCartoes.pAdicionaLinha(FRestResponse.Content,pgbProg);
          Inc(LPagina);
        End Else LFimDaImportacao := True;

      Until (LFimDaImportacao);

      LAutorizado := True;
    Except
      On E: Exception Do
      Begin
        If OnException(LAutorizado,LMsgErro,LContador,AChaveSelecionada,LMensagem) Then
          Raise Exception.Create(LMsgErro);
      End;
    End;
  End;
end;

procedure TImportaPagamentosPagarMe.DownloadDataSelecionadaAPIv5(
  AChaveSelecionada: TChavesPagarMe; ADataInicial, ADataFinal: TDateTime;
  AiCartoes: TPagarMePgto);
  Var
    LContador: Integer;

    LAutorizado: Boolean;

    LMensagem: String;
    LMsgErro : String;
    LStatus: String;
  Const
    LStatusCobranca: array of string = ['paid', 'canceled', 'chargedback'];
    LStatusTransferencias: array of string = ['available', 'transferred'];
Begin
  LAutorizado := False;

  LContador := 0;

  FRestClient.Authenticator := THTTPBasicAuthenticator.Create(AChaveSelecionada.ApiKey,'');

  While Not Autorizado(LAutorizado,LContador) Do
  Begin
    Try
      for LStatus in LStatusCobranca do
      begin
        ImportarCobrancas(AChaveSelecionada,
                          ADataInicial,
                          ADataFinal,
                          AiCartoes,
                          LStatus);
      end;

      ImportarRecebiveis(TTipoDataRecebivel.tdCadastro,
                         AChaveSelecionada,
                         ADataInicial,
                         ADataFinal,
                         AiCartoes);

      ImportarRecebiveis(TTipoDataRecebivel.tdPagamento,
                         AChaveSelecionada,
                         ADataInicial,
                         ADataFinal,
                         AiCartoes);

      for LStatus in LStatusTransferencias do
      begin
        ImportarTransferencias(LStatus,
                               AChaveSelecionada,
                               ADataInicial,
                               ADataFinal,
                               AiCartoes);
      end;

      LAutorizado := True;
    Except
      On E: Exception Do
      Begin
        If OnException(LAutorizado,LMsgErro,LContador,AChaveSelecionada,LMensagem) Then
          Raise Exception.Create(LMsgErro);
      End;
    End;
  End;
end;

function TImportaPagamentosPagarMe.FormatarJson(
  AResponseContent: String): String;
var
  LJsonRetorno: TJSONObject;
  LJsonArray: TJSONArray;
  LJsonDados: TJSONObject;
begin
  Result := EmptyStr;
  LJsonDados := TJSONObject.ParseJSONValue(AResponseContent) as TJSONObject;
  LJsonRetorno := TJSONObject.Create;
  LJsonArray := TJSONArray.Create;
  try
    LJsonArray.AddElement(LJsonDados.Clone as TJSONObject);

    // Cria o objeto final com "data": [ {dados} ]
    LJsonRetorno.AddPair('data', LJsonArray);
    Result := LJsonRetorno.ToString;
  finally
    LJsonDados.Free;
    LJsonArray.Free;
  end;
end;

procedure TImportaPagamentosPagarMe.FormOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
    TForm(Sender).Perform(40,0,0);
end;

function TImportaPagamentosPagarMe.fRetUltimaData: String;
  Var
    qryDados: IDataSet;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.SQL := 'SELECT MAX(PGM_DTACRE) AS DTAPAG FROM PGM_PMPGTO';
  qryDados.Open;

  Result := 'Nenhuma';
  If qryDados.FieldByName('DTAPAG').AsString <> '' Then
    Result := qryDados.FieldByName('DTAPAG').AsString;
end;

function TImportaPagamentosPagarMe.GetRestResponseError: TRestResponse;
begin
  Result := FRestResponse; // Response get registros
end;

procedure TImportaPagamentosPagarMe.ImportarCobrancas(
  AChaveSelecionada: TChavesPagarMe; ADataInicial, ADataFinal: TDateTime;
  AiCartoes: TPagarMePgto; AStatus: String);
var
  LPagina: Integer;
  LFimDaImportacao: Boolean;
begin
  LFimDaImportacao := False;
  LPagina := 1;
  Repeat
    lblInform.Caption := 'Aguarde... Importando cobranças da empresa ' + AChaveSelecionada.Empresa + '.';
    Application.ProcessMessages;

    FRestClient.BaseUrl := RetornaLinkFormatadoAPIv5(FLinkCobranca,
                                                     AChaveSelecionada,
                                                     ADataInicial,
                                                     ADataFinal,
                                                     LPagina.ToString,
                                                     AStatus);

    FRestRequest.Execute;


    If FRestResponse.StatusCode <> 200 Then
      Raise Exception.Create(FRestResponse.Content);

    If Not (Pos('"data": []',FRestResponse.Content) > 0 ) Then
    Begin
      AiCartoes.TipoDoArquivo := 'Cobrancas';
      AiCartoes.KeyApi :=  AChaveSelecionada.ApiKey;
      AiCartoes.pAdicionaLinha(FRestResponse.Content,pgbProg);
      Inc(LPagina);
    End Else LFimDaImportacao := True;

  Until (LFimDaImportacao);
end;

procedure TImportaPagamentosPagarMe.ImportarTransferencias(AStatusTransferencia: String;
                                                           AChaveSelecionada: TChavesPagarMe;
                                                           ADataInicial,
                                                           ADataFinal: TDateTime;
                                                           AiCartoes: TPagarMePgto);
var
  LFimDaImportacao: Boolean;
  LPagina:          Integer;
begin
  LFimDaImportacao := False;
  LPagina := 1;
  Repeat
    lblInform.Caption := 'Aguarde... Importando transferências da empresa ' + AChaveSelecionada.Empresa + '.';
    Application.ProcessMessages;

    FRestClient.BaseUrl := RetornaLinkFormatadoApiTransferenciasV5(ADataInicial,
                                                                   ADataFinal,
                                                                   AStatusTransferencia,
                                                                   LPagina.ToString);

    FRestRequest.Execute;


    If FRestResponse.StatusCode <> 200 Then
      Raise Exception.Create(FRestResponse.Content);

    If Not (Pos('"data": []',FRestResponse.Content) > 0 ) Then
    Begin
      AiCartoes.TipoDoArquivo := 'Transferencias';
      AiCartoes.KeyApi :=  AChaveSelecionada.ApiKey;
      AiCartoes.pAdicionaLinha(FRestResponse.Content, pgbProg);
      Inc(LPagina);
    End Else LFimDaImportacao := True;

    if not LFimDaImportacao then
      Sleep(1000);
  Until (LFimDaImportacao);
end;

procedure TImportaPagamentosPagarMe.ImportarRecebiveis(
  ATipoData: TTipoDataRecebivel; AChaveSelecionada: TChavesPagarMe;
  ADataInicial, ADataFinal: TDateTime; AiCartoes: TPagarMePgto);
var
  LFimDaImportacao: Boolean;
  LPagina:          Integer;
begin
  LFimDaImportacao := False;
  LPagina := 1;
  Repeat
    lblInform.Caption := 'Aguarde... Importando recebíveis da empresa ' + AChaveSelecionada.Empresa + '.';
    Application.ProcessMessages;

    FRestClient.BaseUrl := RetornarLinkFormatadoApiRecebiveisV5(FLinkRecebiveis,
                                                                AChaveSelecionada,
                                                                ATipoData,
                                                                ADataInicial,
                                                                ADataFinal,
                                                                LPagina.ToString);
    FRestRequest.Execute;


    If FRestResponse.StatusCode <> 200 Then
      Raise Exception.Create(FRestResponse.Content);

    If Not (Pos('"data": []',FRestResponse.Content) > 0 ) Then
    Begin
      AiCartoes.TipoDoArquivo := 'Recebiveis';
      AiCartoes.KeyApi :=  AChaveSelecionada.ApiKey;
      AiCartoes.pAdicionaLinha(FRestResponse.Content, pgbProg);
      Inc(LPagina);
    End Else LFimDaImportacao := True;

  Until (LFimDaImportacao);
end;

procedure TImportaPagamentosPagarMe.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

function TImportaPagamentosPagarMe.OnException(var AAutorizado: Boolean;
                                  var AMsgErro: String; Var AContador: Integer;
                                  AChaveSelecionada: TChavesPagarMe; AMensagem : String): Boolean;
begin
  AAutorizado := GetRestResponseError.StatusCode <> 401;

  If GetRestResponseError.StatusCode = 401 Then
  Begin
    If AContador <= 4 Then
    Begin
      Inc(AContador);
      lblInform.Caption := 'Revalidando chaves de autorização para a empresa ' + AChaveSelecionada.Empresa + '.';
    End
    Else
      AMsgErro := 'Chaves de autorização incorretas ou não liberada utilização no ambiente de ' + FAmbiente + '!' + #13 +
                             'Empresa: ' +  AChaveSelecionada.Empresa + #13 +
                             'Erro código 401.';
  End
  Else
  Begin
    AAutorizado := False;

    If AContador <= 4 Then
    Begin
      Inc(AContador);
      lblInform.Caption := 'Erro ao realizar a importação. Nova tentativa após 5 segundos.';
      Application.ProcessMessages;

      Sleep(5000);
    End
    Else
    Begin

      AMsgErro :='Ocorreu um erro ao conectar-se ao serviço da Pagar.Me.' + #13 +
                             'Tente novamente mais tarde!' + #13 +
                             'Código do erro: ' + GetRestResponseError.StatusCode.ToString + '-' +
                                                  GetRestResponseError.StatusText;

      Case GetRestResponseError.StatusCode Of
        503 : AMsgErro := 'O serviço da Pagar.Me está com problemas no funcionamento. Tente novamente mais tarde!' + #13 +
                           AMensagem + #13 +
                           'Erro código 503.';

        500 : AMsgErro :='Ocorreu um erro interno no serviço da Pagar.Me. ' + AMensagem + #13 +
                         'Tente novamente mais tarde!' + #13 +
                         'Erro código 500.';

        429 : AMsgErro :='Você atingiu o limite de requisições na API da Pagar.Me.'+ #13 +
                         'Tente novamente mais tarde!' + #13 +
                         'Erro código 429.';
      End;

    End;
  End;

  If AContador > 0 Then
  Begin
    lblInform.Caption := 'Aguarde... Nova tentativa de download da Empresa ' + AChaveSelecionada.Empresa;
    Application.ProcessMessages;
  End;

  Result := Not fEmptyStr(AMsgErro);

end;

procedure TImportaPagamentosPagarMe.btnSairClick(Sender: TObject);
Begin
  frmForm.Close;
End;

function TImportaPagamentosPagarMe.Autorizado(AAutorizado: Boolean; AContador: Integer): Boolean;
begin
  Result := True;

  If Not AAutorizado Then // Não fui autorizado a importar pela api ainda ?
  Begin
    If AContador <= 5 Then Result := False; // continuo tentando importar até 5x
  End;

end;

procedure TImportaPagamentosPagarMe.btnConfClick(Sender: TObject);
Begin
  If (edtDtaIni.Date >= Date) Or (edtDtaFin.Date >= Date) Then
  Begin
    objFunctions.fIMensagem('','As datas para importação não podem ser maiores ou iguais a data atual!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date = 0) Or (edtDtaFin.Date = 0) Then
  Begin
    objFunctions.fIMensagem('','É necessário digitar a data inicial e a data final!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date > edtDtaFin.Date) Then
  Begin
    objFunctions.fIMensagem('','A data inicial deve ser menor que data final!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 30 Then
  Begin
    objFunctions.fIMensagem('ATENÇÃO','A quantidade de dias do período não pode ser maior que 30!',['&OK']);
    Exit;
  End;
  If FListaChaves.Count = 0 Then
  Begin
    objFunctions.fIMensagem('ATENÇÃO','Não existem Empresas com chaves de acesso a API configurados!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 5 Then
  Begin
    If objFunctions.fIMensagem('','A quantidade de dias do período é maior 5 dias. ' +
                                  'A importação da Pagar.Me é feita através da Internet, dependendo da quantidade ' +
                                  'de registros a operação pode demorar. Deseja realmente continuar?',['&Sim','&Não']) = 2 Then
      Exit;
  End;

  pDisableControls(True);
  ProcessaDownload;
  pDisableControls(False);
End;

procedure TImportaPagamentosPagarMe.ProcessaDownload;
  Var
    LiCartoes: TPagarMePgto;

    LMensagem: String;

    LChavesPagarMe: TChavesPagarMe;

    LContador: Integer;

    LOcorreuErro,
    LPararNoErro: Boolean;
    LListaIdCobrancas: TStringList;
begin
  LListaIdCobrancas := TStringList.Create;
  Try
    pValidaLibsWebService;

    LiCartoes := TPagarMePgto.Create;

    If FListaChaves.Count = 0 Then
    Begin
      objFunctions.fIMensagem('ATENÇÃO','Não existem empresas configuradas com a chave de Autorização da Pagar.Me. Operação cancelada!',['&OK']);
      Exit;
    End;

    LOcorreuErro := False;
    LPararNoErro := False;

    LContador := 0;

    For LChavesPagarMe In FListaChaves Do
    Begin
      Inc(LContador);

      lblInform.Caption := 'Aguarde... Efetuando download da Empresa ' + LChavesPagarMe.Empresa;
      Application.ProcessMessages;

      Try
        If LChavesPagarMe.Versao = 'v5' Then
          DownloadDataSelecionadaAPIv5(LChavesPagarMe,
                                       edtDtaIni.Date,
                                       edtDtaFin.Date,
                                       LiCartoes)
        Else
          DownloadDataSelecionada(LChavesPagarMe,
                                  edtDtaIni.Date,
                                  edtDtaFin.Date,
                                  LiCartoes);

        lblInform.Caption := 'Aguarde... Gravando os lançamentos da Empresa ' + LChavesPagarMe.Empresa;
        Application.ProcessMessages;

        LiCartoes.pGravarRegistros(pgbProg);

        if LChavesPagarMe.Versao = 'v5' then
        begin
          LListaIdCobrancas := LiCartoes.RetornarIdCobrancasNaoEncontradas(edtDtaIni.Date,
                                                                           edtDtaFin.Date,
                                                                           LChavesPagarMe.ApiKey);

          DownloadCobrancasNaoEncontradas(LListaIdCobrancas, LChavesPagarMe, LiCartoes);
          LiCartoes.pGravarRegistros(pgbProg);
        end;


        Application.ProcessMessages;
      Except
        On E: Exception Do
        Begin
          LOcorreuErro := True;

          If (LContador = FListaChaves.Count) Then
            objFunctions.fIMensagem('ERRO', E.Message, ['&OK'])
          Else
            LPararNoErro := objFunctions.fIMensagem('ERRO', E.Message + #13 +
                                                    'Deseja continuar com a importação das outras empresas?',
                                                    ['&Sim', 'Não']) = 2;
        End;
      End;

      If LPararNoErro Then
        Break;
    End;

    LMensagem := 'Nenhum registro foi importado no período selecionado!';
    FImportouVendas :=    TPagarMePgto(LiCartoes).ImportouRegistro;
    FImportouCobrancas := TPagarMePgto(LiCartoes).ImportouCobrancas;
    FDataInicial    := edtDtaIni.Date;
    FDataFinal      := edtDtaFin.Date;

    If FImportouVendas Then
    Begin
      If Not LOcorreuErro Then
      Begin
        LMensagem := 'Dados importados com sucesso';
        If Not TPagarMePgto(LiCartoes).ImportouPagamento Then
          LMensagem := LMensagem + ', porém não possui registros de Recebiveis no período selecionado';

        LMensagem := LMensagem + '!';
        CorrigirValoresMovCar;
      End
      Else
        LMensagem := 'Registros foram importados, porém ocorrereu algum erro durante a gravação.';
    End;
    objFunctions.fIMensagem('ATENÇÃO', LMensagem,['&OK']);

  Finally
    pDisableControls(False);
    LListaIdCobrancas.Free;
  End;

  frmForm.Close;
end;

procedure TImportaPagamentosPagarMe.CorrigirValoresMovCar;
var
  LQuery: IDataSet;
begin
  LQuery := objFunctions.fGetDataSet;
  try
    LQuery.Close;
    LQuery.SQL := 'SELECT                                 ' +
                  ' 1                                     ' +
                  'FROM                                   ' +
                  ' information_schema.routines           ' +
                  'WHERE routine_name = "pAjusta_PagarMe" ' +
                  ' AND routine_type = "PROCEDURE"        ' +
                  ' AND routine_schema = DATABASE()       ';

    LQuery.Open;
    if LQuery.RecordCount = 0 then
      Exit;

    LQuery.Close;
    LQuery.SQL := 'CALL pAjusta_PagarMe()';
    LQuery.ExecSQl;
  except
    On E: Exception do
      raise Exception.Create('Ocorreram problemas ao corrigir o valor das movimentações de cartão. ' + E.message);
  end;
end;

procedure TImportaPagamentosPagarMe.pDisableControls(blnDisable: Boolean);
begin
  pnlFund.Enabled    := not blnDisable;
  edtDtaIni.Enabled  := not blnDisable;
  edtDtaFin.Enabled  := not blnDisable;
end;

procedure TImportaPagamentosPagarMe.pSelecionaFonte;
  Var
    lblDtaIni,
    lblDtaFin: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;
Begin

  frmForm := TForm.Create(Self);

  frmForm.BorderStyle  := bsSingle;
  frmForm.Caption      := 'Importação de Registros (Pagar.Me)';
  frmForm.ClientHeight := 102;
  frmForm.ClientWidth  := 402;
  frmForm.Color        := 16770261;
  frmForm.Position     := poScreenCenter;
  frmForm.BorderIcons  := [biSystemMenu];
  frmForm.KeyPreview   := True;
  frmForm.OnKeyDown    := FormOnKeyDown;
  frmForm.Icon.LoadFromResourceName(HInstance, 'AUTCOM1');  //utilizando recurso para adicionar o icone AJ

  lblDtaIni := TLabel.Create(frmForm);
  lblDtaIni.Parent   := frmForm;
  lblDtaIni.Top      := 12;
  lblDtaIni.AutoSize := True;
  lblDtaIni.Caption  := 'Data Inicial:';
  lblDtaIni.Left     := Round(frmForm.Width / 2) - lblDtaIni.Width - 95 - 5;


  edtDtaIni := TcxDateEdit.Create(frmForm);
  edtDtaIni.Parent   := frmForm;
  edtDtaIni.Left     := lblDtaIni.Left + lblDtaIni.Width + 2;
  edtDtaIni.Top      := 8;
  edtDtaIni.Height   := 21;
  edtDtaIni.TabOrder := 0;
  edtDtaIni.Width    := 90;
  edtDtaIni.Text     := DateToStr(Yesterday);
 //DELPHI 2007
 {$IF Defined(VER185) Or Defined(VER180)}
  edtDtaIni.Properties.ButtonGlyph.LoadFromResourceName(HInstance, 'CALENDARIO');
 {$ELSE}
 {$IF Defined(VER270)}
 {$ELSE}
  edtDtaIni.Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);
 {$IFEND}
 {$ENDIF}


  lblDtaFin := TLabel.Create(frmForm);
  lblDtaFin.Parent   := frmForm;
  lblDtaFin.Left     := edtDtaIni.Left + edtDtaIni.Width + 15 + 5;
  lblDtaFin.Top      := 12;
  lblDtaFin.AutoSize := True;
  lblDtaFin.Caption  := 'Data Final:';


  edtDtaFin := TcxDateEdit.Create(frmForm);
  edtDtaFin.Parent   := frmForm;
  edtDtaFin.Left     := lblDtaFin.Left + lblDtaFin.Width + 2;
  edtDtaFin.Top      := 8;
  edtDtaFin.Height   := 21;
  edtDtaFin.TabOrder := 1;
  edtDtaFin.Width    := 90;
  edtDtaFin.Text     := DateToStr(Yesterday);
 //DELPHI 2007
 {$IF Defined(VER185) Or Defined(VER180)}
  edtDtaFin.Properties.ButtonGlyph.LoadFromResourceName(HInstance, 'CALENDARIO');
 {$ELSE}
 {$IF Defined(VER270)}
 {$ELSE}
  edtDtaFin.Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);
 {$IFEND}
 {$ENDIF}


  lblInform := TLabel.Create(frmForm);
  lblInform.Parent   := frmForm;
  lblInform.Left     := 0;
  lblInform.Top      := 42;
  lblInform.AutoSize := False;
  lblInform.Width    := frmForm.Width;
  lblInform.Alignment:= taCenter;
  lblInform.Caption  := 'Digite o período para realizar a importação. Última data importada: ' + fRetUltimaData;


  memXMLDoc := TMemo.Create(frmForm);
  memXMLDoc.Parent   := frmForm;
  memXMLDoc.Left     := 8;
  memXMLDoc.Top      := 42;
  memXMLDoc.Visible  := False;


  pnlFund := TPanel.Create(frmForm);
  pnlFund.Parent   := frmForm;
  pnlFund.Align    := alBottom;
  pnlFund.Height   := 28;
  pnlFund.Color    := clGray;
  pnlFund.TabOrder := 2;


  pgbProg := TProgressBar.Create(frmForm);
  pgbProg.Parent   := frmForm;
  pgbProg.Align    := alBottom;
  pgbProg.Height   := 10;
  pgbProg.Position := 0;


  btnSair := TBitBtnLocked.Create(frmForm);
  btnSair.Parent   := pnlFund;
  btnSair.Left     := 327;
  btnSair.Top      := 2;
  btnSair.Width    := 72;
  btnSair.Height   := 24;
  btnSair.TabOrder := 1;
  btnSair.OnClick  := btnSairClick;
  btnSair.Kind     := bkClose;
  btnSair.Caption  := '&Sair';
  btnSair.Cancel   := True;
  btnSair.Glyph    := TBitmap.Create;


  btnConf := TBitBtnLocked.Create(frmForm);
  btnConf.Parent   := pnlFund;
  btnConf.Left     := 4;
  btnConf.Top      := 2;
  btnConf.Width    := 72;
  btnConf.Height   := 24;
  btnConf.TabOrder := 0;
  btnConf.OnClick  := btnConfClick;
  btnConf.Default  := False;
  btnConf.Caption  := '&Importar';
  btnConf.Glyph    := TBitmap.Create;


  frmForm.ShowModal;

  FreeAndNil(frmForm);
End;

function TImportaPagamentosPagarMe.RetornaEmpresasApiV5: String;
var
  LChave: TChavesPagarMe;
begin
  Result := '';
  for LChave in FListaChaves do
  begin
    if LChave.Versao = 'v5' then
      Result := Result + LChave.Empresa + ', ';
  end;
  SetLength(Result, Length(Result) - 2);
end;

function TImportaPagamentosPagarMe.RetornaLinkFormatado(ALinkOriginal: String;
                                                        AChaveSelecionada: TChavesPagarMe;
                                                        ADataInicial,
                                                        ADataFinal: TDateTime;
                                                        APagina: String = '';
                                                        AStatus: String = '';
                                                        ATipo: String = ''): String;

  Var
    LDateInicial : Integer;
    LDateFinal   : Integer;
begin
  ADataFinal := IncHour(ADataFinal,23);
  ADataFinal := IncMinute(ADataFinal,59);
  ADataFinal := IncSecond(ADataFinal,59);

  LDateInicial := DateTimeToUnix(ADataInicial);
  LDateFinal   := DateTimeToUnix(ADataFinal);

  Result := StringReplace(ALinkOriginal, '[INICIO]',LDateInicial.ToString + '000' , [rfReplaceAll]);
  Result := StringReplace(Result, '[FIM]', LDateFinal.ToString + '000', [rfReplaceAll]);
  Result := StringReplace(Result, '[KEY]', AChaveSelecionada.ApiKey, [rfReplaceAll]);
  Result := StringReplace(Result, '[PAGINA]', APagina, [rfReplaceAll]);
  Result := StringReplace(Result, '[STATUS]', AStatus, [rfReplaceAll]);
  Result := StringReplace(Result, '[TIPO]', ATipo, [rfReplaceAll]);
end;

function TImportaPagamentosPagarMe.RetornaLinkFormatadoAPIv5(
  ALinkOriginal: String; AChaveSelecionada: TChavesPagarMe; ADataInicial,
  ADataFinal: TDateTime; APagina, AStatus: String): String;
  Var
    LDateInicial : String;
    LDateFinal   : String;
begin
  LDateInicial := FormatDateTime('YYYY-MM-DD',ADataInicial) + 'T00:00:00';
  LDateFinal   := FormatDateTime('YYYY-MM-DD',ADataFinal)   + 'T23:59:59';

  Result := StringReplace(ALinkOriginal, '[INICIO]',LDateInicial, [rfReplaceAll]);
  Result := StringReplace(Result, '[FIM]', LDateFinal, [rfReplaceAll]);
  Result := StringReplace(Result, '[PAGINA]', APagina, [rfReplaceAll]);
  Result := StringReplace(Result, '[STATUS]', AStatus, [rfReplaceAll]);
end;

function TImportaPagamentosPagarMe.RetornaListaDeChavesPagarMe: TList<TChavesPagarMe>;
  Var
    LDados: IDataset;
    LChaves: TStringList;
    I: Integer;
begin
  Result := TList<TChavesPagarMe>.Create;
  LChaves := TStringList.Create;
  LDados := objFunctions.fGetDataSet;
  try
    LDados.Close;
    LDados.SQL := 'SELECT SIS_VALCFG, SIS_CODEMP FROM CFGSIS ' +
                  ' WHERE SIS_CODCFG = "CFG_PGMKEY" AND      ' +
                  '       IFNULL(TRIM(SIS_VALCFG), "") <> "" ' +
                  ' ORDER BY SIS_CODEMP                      ';

    LDados.Open;

    While Not LDados.Eof Do
    Begin
      LChaves.CommaText := LDados.FieldByName('SIS_VALCFG').AsString;

      for I := 0 to Pred(LChaves.Count) do
      begin
        Result.Add(TChavesPagarMe.Create);
        Result.Last.Empresa := LDados.FieldByName('SIS_CODEMP').AsString;
        Result.Last.ApiKey  := Trim(LChaves[i]);
        Result.Last.Versao  := fRetornaValorConfiguracao('CFG_PGMVER', LDados.FieldByName('SIS_CODEMP').AsString);
      end;

      LDados.Next;
    End;
  finally
    LChaves.Free;
  end;
end;

function TImportaPagamentosPagarMe.RetornarLinkFormatadoApiRecebiveisV5(
  ALinkOriginal: String; AChaveSelecionada: TChavesPagarMe;
  ATipoData: TTipoDataRecebivel; ADataInicial, ADataFinal: TDateTime;
  APagina: String): String;
var
  LDataInicial,
  LDataFinal,
  LFiltro: String;
begin
  LDataInicial := FormatDateTime('YYYY-MM-DD', ADataInicial) + 'T00:00:00';
  LDataFinal   := FormatDateTime('YYYY-MM-DD', ADataFinal)   + 'T23:59:59';

  case ATipoData of
    tdCadastro: LFiltro := 'created_since=' + LDataInicial +
                           '&created_until=' + LDataFinal;
  else
    LFiltro := 'payment_date_since=' + LDataInicial +
               '&payment_date_until=' + LDataFinal;
  end;

  Result := ALinkOriginal + '&' + LFiltro;
  Result := StringReplace(Result, '[PAGINA]', APagina, [rfReplaceAll]);
end;

function TImportaPagamentosPagarMe.RetornaLinkFormatadoApiTransferenciasV5(ADataInicial, ADataFinal: TDateTime;
  AStatus, APagina: String): String;
begin
  Result := FLinkTransferencias;
  Result := StringReplace(Result, '[INICIO]', FormatDateTime('YYYY-MM-DD', ADataInicial) + 'T00:00:00', [rfReplaceAll]);
  Result := StringReplace(Result, '[FIM]',    FormatDateTime('YYYY-MM-DD', ADataFinal)   + 'T23:59:59', [rfReplaceAll]);

  Result := StringReplace(Result, '[STATUS]', AStatus, [rfReplaceAll]);
  Result := StringReplace(Result, '[PAGINA]', APagina, [rfReplaceAll]);
end;

function TImportaPagamentosPagarMe.RetornaStatusCobranca(
  AResponseContent: String): String;
var
  LJSON: TJSONObject;
begin
  Result := '';
  LJSON := nil;
  try
    LJSON := TJSONObject.ParseJSONValue(AResponseContent) as TJSONObject;
    if Assigned(LJSON) then
      Result := LJSON.GetValue<String>('status');
  finally
    if Assigned(LJSON) then
      LJSON.Free;
  end;
end;

end.

