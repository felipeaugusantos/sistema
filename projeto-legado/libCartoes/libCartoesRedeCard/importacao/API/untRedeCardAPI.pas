{*****************************************************}
{* Importação de arquivos com RESTClient da REDECARD *}
{**************************************************AJ*}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{****************************************AJ*}
unit untRedeCardAPI;

interface

uses System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Dialogs,
     Vcl.Controls, Winapi.Windows, Vcl.Graphics, Vcl.Buttons, System.StrUtils,
     System.SysUtils, Vcl.ComCtrls, System.DateUtils, System.Generics.Collections,
     REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
     System.Json, REST.Authenticator.Basic, System.Math,

     BitBtnLockedIncrem, cxCalendar, IPPeerClient, Uni, cxProgressBar,

     untIRedeCardIntegracaoLibCartoes, untRedeCardAPIPgto, untTRedeCardFuncoes,
     untLibCartoesGravando, untLibCartoesInterfacesTipos;

Type
  TChavesRedeCard = class
  private
  public
    Empresa,
    Estabelecimento,
    ClientID,
    SecretCode,
    Token,
    RefreshToken,
    Usuario,
    Senha: String;

    Expiracao: Integer;
    RefreshTime: TTime;
  end;

Type
  TRedeCardAPI = Class(TComponent)
  Private
    frmImportacaoCartoesAPI: TForm;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    memXMLDoc : TMemo;
    lblInform : TLabel;
    pnlFundo: TPanel;

    FAplicacao: HWND;

    FListaChaves: TObjectList<TChavesRedeCard>;

    FLinkAutenticacao,
    FLinkVendas,
    FLinkVendasParceladas,
    FLinkAjustes,
    FLinkPagamentos,
    FLinkPagamentosDiarios,
    FAmbiente: String;

    FConfirmaCartoes: Boolean;
    FImportouVendas: Boolean;
    FImportouPagamentos: Boolean;

    FDataInicial: TDateTime;
    FDataFinal:TDateTime;

    procedure OnAfterExecute(Sender: TCustomRESTRequest);

    procedure pDisableControls(blnDisable: Boolean);
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function fRetUltimaData: String;

    procedure CarregaListaDeChavesRedeCard(var AListaChaves: TObjectList<TChavesRedeCard>);

    procedure CriarComponentesRequisicao;
    procedure DestroiComponentesRequisicao;
    function ProcessaDownload(pgbProgresso: TcxProgressBar): Boolean;
    procedure DownloadDataSelecionada(AChaveSelecionada: TChavesRedeCard;
                                      ADataInicial,
                                      ADataFinal: TDateTime;
                                      AiCartoes: TRedeCardAPIPgto;
                                      var prgStatus: TcxProgressBar;
                                      AInfoPaginacao: String = '');

    procedure DownloadPorPeriodoMaximo(AQtdeDiasMaximo: Integer;
                                       AChaveSelecionada: TChavesRedeCard;
                                       ADataInicial,
                                       ADataFinal: TDateTime;
                                       AiCartoes: TRedeCardAPIPgto;
                                       var APrgStatus: TcxProgressBar);

    procedure GetTokenChave13(var AChaveAtual: TChavesRedeCard);
    procedure RefreshToken(var AChaveAtual: TChavesRedeCard);

    procedure CarregaLinks(ACodigoEmpresa: String);

    function RetornaLinkFormatado(ALinkOriginal: String;
                                  AChaveSelecionada: TChavesRedeCard;
                                  ADataInicial,
                                  ADataFinal: TDateTime;
                                  ADadosPagina: String): String;

    function OnException(Var AAutorizado: Boolean; Var AMsgErro :String;
                           Var AContador: Integer; AChaveSelecionada: TChavesRedeCard;
                               AMensagem: String;
                           var prgStatus: TcxProgressBar): Boolean;

    function Autorizado(AAutorizado: Boolean;AContador: Integer):Boolean;
    function GetRestResponseError: TRestResponse;
    function RetiraZerosEsquerda(AString: String): String;

  Public
    property Aplicacao: HWND read FAplicacao write FAplicacao;
    property ConfirmaCartoes: Boolean Read FConfirmaCartoes Write FConfirmaCartoes;
    property ImportouVendas: Boolean Read FImportouVendas Write FImportouVendas;
    property ImportouPagamentos: Boolean Read FImportouPagamentos Write FImportouPagamentos;
    property DataInicial: TDateTime Read FDataInicial;
    property DataFinal: TDateTime Read FDataFinal;
    procedure pSelecionaFonte;


    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  protected
    FRestClient: TRestClient;
    FRestRequest: TRestRequest;
    FRestResponse: TRestResponse;

    FChavesStone: TStringList;
    LRestResponse: TRestResponse;// get Token
  End;

implementation

{ TRedeCardAPI }

procedure TRedeCardAPI.CarregaLinks(ACodigoEmpresa: String);
begin
  FLinkAutenticacao := 'https://rl7-sandbox-api.useredecloud.com.br/oauth/token';

  FLinkVendas := 'https://rl7-sandbox-api.useredecloud.com.br/merchant-statement/v1/sales?' +
                 'parentCompanyNumber=[ESTABELECIMENTO]&subsidiaries=[ESTABELECIMENTO]' +
                 '&startDate=[INICIO]&endDate=[FIM]';

  FLinkVendasParceladas := 'https://rl7-sandbox-api.useredecloud.com.br/merchant-statement/v1/sales/installments?' +
                           'parentCompanyNumber=[ESTABELECIMENTO]&subsidiaries=[ESTABELECIMENTO]' +
                           '&startDate=[INICIO]&endDate=[FIM]';

  FLinkAjustes := 'https://rl7-sandbox-api.useredecloud.com.br/merchant-statement/v1/charges?'+
                  'parentCompanyNumber=[ESTABELECIMENTO]&subsidiaries=[ESTABELECIMENTO]&'+
                  'startDate=[INICIO]&endDate=[FIM]';


  FLinkPagamentos := 'https://rl7-sandbox-api.useredecloud.com.br/merchant-statement/v1/payments/credit-orders?' +
                     'parentCompanyNumber=[ESTABELECIMENTO]&subsidiaries=[ESTABELECIMENTO]' +
                     '&startDate=[INICIO]&endDate=[FIM]';


  FLinkPagamentosDiarios := 'https://rl7-sandbox-api.useredecloud.com.br/merchant-statement/v2/payments/daily?' +
                            'parentCompanyNumber=[ESTABELECIMENTO]' +
                            '&startDate=[INICIO]&endDate=[FIM]';

  FAmbiente := 'HOMOLOGAÇÃO';

  If TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDHOM', ACodigoEmpresa)= 'N' Then
  Begin
    FLinkAutenticacao := 'https://api.userede.com.br/redelabs/oauth/token';

    FLinkVendas := 'https://api.userede.com.br/redelabs/merchant-statement/v1/sales?' +
                   'parentCompanyNumber=[ESTABELECIMENTO]&subsidiaries=[ESTABELECIMENTO]' +
                   '&startDate=[INICIO]&endDate=[FIM]';

    FLinkVendasParceladas := 'https://api.userede.com.br/redelabs/merchant-statement/v1/sales/installments?' +
                             'parentCompanyNumber=[ESTABELECIMENTO]&subsidiaries=[ESTABELECIMENTO]' +
                             '&startDate=[INICIO]&endDate=[FIM]';

    FLinkAjustes := 'https://api.userede.com.br/redelabs/merchant-statement/v1/charges?'+
                    'parentCompanyNumber=[ESTABELECIMENTO]&subsidiaries=[ESTABELECIMENTO]&'+
                    'startDate=[INICIO]&endDate=[FIM]';

    FLinkPagamentos := 'https://api.userede.com.br/redelabs/merchant-statement/v1/payments/credit-orders?' +
                       'parentCompanyNumber=[ESTABELECIMENTO]&subsidiaries=[ESTABELECIMENTO]' +
                       '&startDate=[INICIO]&endDate=[FIM]';


    FLinkPagamentosDiarios := 'https://api.userede.com.br/redelabs/merchant-statement/v2/payments/daily?' +
                              'parentCompanyNumber=[ESTABELECIMENTO]' +
                              '&startDate=[INICIO]&endDate=[FIM]';


    FAmbiente := 'PRODUÇÃO';
  End;
end;

constructor TRedeCardAPI.Create(Owner: TComponent);
begin
  inherited;
  CarregaListaDeChavesRedeCard(FListaChaves);

  VS_ListaEstabelecimentos := TStringList.Create;

  CriarComponentesRequisicao;
  FConfirmaCartoes   := False;
  FImportouVendas    := False;
  FImportouPagamentos:= False;

  TRedeCardFuncoes.FDadosImportacaoConfirmacao := TDadosImportacaoConfirmacao.Create;
end;

procedure TRedeCardAPI.CriarComponentesRequisicao;
begin
  FRestClient := TRestClient.Create(Nil);
  FRestClient.RaiseExceptionOn500 := False;
  FRestClient.HandleRedirects := True;
  FRestClient.SynchronizedEvents := True;

  FRestResponse := TRestResponse.Create(Nil);
  LRestResponse := TRestResponse.Create(Nil); // get Token

  FRestRequest := TRestRequest.Create(Nil);
  FRestRequest.Client := FRestClient;
  FRestRequest.Response := FRestResponse;
  FRestRequest.Method := rmGet;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.OnAfterExecute := OnAfterExecute;

  FRestRequest.Params.AddHeader('Authorization', '');
  FRestRequest.Params.AddHeader('Content-Type', 'application/json');
  FRestRequest.Params[0].Kind := pkHTTPHEADER;
  FRestRequest.Params[0].Options := [poDoNotEncode];
  FRestRequest.Params[1].Kind := pkHTTPHEADER;
  FRestRequest.Params[1].Options := [poDoNotEncode];
end;

procedure TRedeCardAPI.DestroiComponentesRequisicao;
begin
  FreeAndNil(FRestResponse);
  FreeAndNil(LRestResponse);
  FreeAndNil(FRestRequest);
  FreeAndNil(FRestClient);
end;

destructor TRedeCardAPI.Destroy;
begin
  FreeAndNil(FListaChaves);

  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  DestroiComponentesRequisicao;

  inherited;
end;

procedure TRedeCardAPI.DownloadPorPeriodoMaximo(AQtdeDiasMaximo: Integer;
                                                AChaveSelecionada: TChavesRedeCard;
                                                ADataInicial,
                                                ADataFinal: TDateTime;
                                                AiCartoes: TRedeCardAPIPgto;
                                                var APrgStatus: TcxProgressBar);
var
  LDtaIniAtual,
  LDtaFimAtual: TDatetime;
  LContador,
  LMaximoLoops: Integer;
  LInfoPaginacao: String;
begin
  LDtaIniAtual := ADataInicial;
  LDtaFimAtual := IncDay(ADataInicial, AQtdeDiasMaximo);
  LContador := 1;
  LMaximoLoops := Ceil(DaysBetween(ADataInicial, ADataFinal) / AQtdeDiasMaximo);

  while (LContador <= LMaximoLoops) do
  begin
    If LDtaFimAtual > ADataFinal Then
      LDtaFimAtual := ADataFinal;

    LInfoPaginacao := Format(' (%d/%d)', [LContador, LMaximoLoops]);

    DownloadDataSelecionada(AChaveSelecionada,
                            LDtaIniAtual,
                            LDtaFimAtual,
                            AiCartoes,
                            APrgStatus,
                            LInfoPaginacao);

    lblInform.Caption := 'Aguarde... Gravando os lançamentos de ' +
                         FormatDateTime('dd/mm/yyyy', LDtaIniAtual) + ' a ' +
                         FormatDateTime('dd/mm/yyyy', LDtaFimAtual) +
                         LInfoPaginacao + '.';

    untLibCartoesGravando.pInformacao(lblInform.Caption, APrgStatus);

    AiCartoes.pGravarRegistros(APrgStatus);

    Application.ProcessMessages;

    Inc(LContador);
    LDtaIniAtual := IncDay(LDtaFimAtual);
    LDtaFimAtual := IncDay(LDtaFimAtual, AQtdeDiasMaximo);
  end;
end;

procedure TRedeCardAPI.DownloadDataSelecionada(AChaveSelecionada: TChavesRedeCard;
                                               ADataInicial,
                                               ADataFinal: TDateTime;
                                               AiCartoes: TRedeCardAPIPgto;
                                               var prgStatus: TcxProgressBar;
                                               AInfoPaginacao: String = '');
  Var
    LContador: Integer;

    LAutorizado: Boolean;

    LMensagem,
    LDadosPagina: String;
    LMsgErro : String;
Begin
  LAutorizado := False;

  LContador := 0;

  LDadosPagina := '';

  While Not Autorizado(LAutorizado,LContador) Do
  Begin
    Try
      GetTokenChave13(AChaveSelecionada);
      AiCartoes.Progresso := prgStatus;

      Repeat
        //Pagamentos
        lblInform.Caption := 'Importando pagamentos do estabelecimento ' + AChaveSelecionada.Estabelecimento +
                             ' da empresa ' + AChaveSelecionada.Empresa +
                             ' de ' +
                             FormatDateTime('dd/mm/yyyy', ADataInicial) + ' a ' +
                             FormatDateTime('dd/mm/yyyy', ADataFinal) +
                             AInfoPaginacao + '.';

        untLibCartoesGravando.pInformacao(lblInform.Caption, prgStatus);

        FRestClient.BaseUrl := RetornaLinkFormatado(FLinkPagamentos,
                                                    AChaveSelecionada,
                                                    ADataInicial,
                                                    ADataFinal,
                                                    LDadosPagina);
        RefreshToken(AChaveSelecionada);

        FRestRequest.Params[0].Value := 'Bearer ' + AChaveSelecionada.Token;
        FRestRequest.Execute;


        If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

        AiCartoes.EstabelecimentoAtual := AChaveSelecionada.Estabelecimento;
        AiCartoes.TipoDoArquivo := 'PAGAMENTOS';
        AiCartoes.pAdicionaLinha(FRestResponse.Content);

        LDadosPagina := AiCartoes.ProximaPagina;
      Until (LDadosPagina.IsEmpty);


      Repeat
        //Pagamentos diários
        lblInform.Caption := 'Importando pagamentos diários do estabelecimento ' + AChaveSelecionada.Estabelecimento +
                             ' da empresa ' + AChaveSelecionada.Empresa +
                             ' de ' +
                             FormatDateTime('dd/mm/yyyy', ADataInicial) + ' a ' +
                             FormatDateTime('dd/mm/yyyy', ADataFinal) +
                             AInfoPaginacao + '.';

        untLibCartoesGravando.pInformacao(lblInform.Caption, prgStatus);

        FRestClient.BaseUrl := RetornaLinkFormatado(FLinkPagamentosDiarios,
                                                    AChaveSelecionada,
                                                    ADataInicial,
                                                    ADataFinal,
                                                    LDadosPagina);
        RefreshToken(AChaveSelecionada);

        FRestRequest.Params[0].Value := 'Bearer ' + AChaveSelecionada.Token;
        FRestRequest.Execute;


        If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

        AiCartoes.EstabelecimentoAtual := AChaveSelecionada.Estabelecimento;
        AiCartoes.TipoDoArquivo := 'PAGAMENTOS DIARIOS';
        AiCartoes.pAdicionaLinha(FRestResponse.Content);

        LDadosPagina := AiCartoes.ProximaPagina;
      Until (LDadosPagina.IsEmpty);

      Repeat
        //Vendas
        lblInform.Caption := 'Importando vendas do estabelecimento ' + AChaveSelecionada.Estabelecimento +
                             ' da empresa ' + AChaveSelecionada.Empresa +
                             ' de ' +
                             FormatDateTime('dd/mm/yyyy', ADataInicial) + ' a ' +
                             FormatDateTime('dd/mm/yyyy', ADataFinal) +
                             AInfoPaginacao + '.';

        untLibCartoesGravando.pInformacao(lblInform.Caption, prgStatus);

        FRestClient.BaseUrl := RetornaLinkFormatado(FLinkVendas,
                                                    AChaveSelecionada,
                                                    ADataInicial,
                                                    ADataFinal,
                                                    LDadosPagina);

        RefreshToken(AChaveSelecionada);

        FRestRequest.Params[0].Value := 'Bearer ' + AChaveSelecionada.Token;
        FRestRequest.Execute;


        If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

        AiCartoes.EstabelecimentoAtual := AChaveSelecionada.Estabelecimento;
        AiCartoes.TipoDoArquivo := 'VENDAS';
        AiCartoes.pAdicionaLinha(FRestResponse.Content);

        LDadosPagina := AiCartoes.ProximaPagina;
      Until (LDadosPagina.IsEmpty);

      Repeat
        //Vendas parceladas
        lblInform.Caption := 'Importando vendas parceladas do estabelecimento ' + AChaveSelecionada.Estabelecimento +
                             ' da empresa ' + AChaveSelecionada.Empresa +
                             ' de ' +
                             FormatDateTime('dd/mm/yyyy', ADataInicial) + ' a ' +
                             FormatDateTime('dd/mm/yyyy', ADataFinal) +
                             AInfoPaginacao + '.';

        untLibCartoesGravando.pInformacao(lblInform.Caption, prgStatus);

        FRestClient.BaseUrl := RetornaLinkFormatado(FLinkVendasParceladas,
                                                    AChaveSelecionada,
                                                    ADataInicial,
                                                    ADataFinal,
                                                    LDadosPagina);

        RefreshToken(AChaveSelecionada);

        FRestRequest.Params[0].Value := 'Bearer ' + AChaveSelecionada.Token;
        FRestRequest.Execute;


        If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

        AiCartoes.EstabelecimentoAtual := AChaveSelecionada.Estabelecimento;
        AiCartoes.TipoDoArquivo := 'VENDAS PARCELADAS';
        AiCartoes.pAdicionaLinha(FRestResponse.Content);

        LDadosPagina := AiCartoes.ProximaPagina;
      Until (LDadosPagina.IsEmpty);

      Repeat
        // Débitos - Visão Detalhada
        lblInform.Caption := 'Importando ajustes do estabelecimento ' + AChaveSelecionada.Estabelecimento +
                             ' da empresa ' + AChaveSelecionada.Empresa +
                             ' de ' +
                             FormatDateTime('dd/mm/yyyy', ADataInicial) + ' a ' +
                             FormatDateTime('dd/mm/yyyy', ADataFinal) +
                             AInfoPaginacao + '.';

        untLibCartoesGravando.pInformacao(lblInform.Caption, prgStatus);

        FRestClient.BaseUrl := RetornaLinkFormatado(FLinkAjustes,
                                                    AChaveSelecionada,
                                                    ADataInicial,
                                                    ADataFinal,
                                                    LDadosPagina);

        RefreshToken(AChaveSelecionada);

        FRestRequest.Params[0].Value := 'Bearer ' + AChaveSelecionada.Token;
        FRestRequest.Execute;


        If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

        AiCartoes.EstabelecimentoAtual := AChaveSelecionada.Estabelecimento;
        AiCartoes.TipoDoArquivo := 'AJUSTES';
        AiCartoes.pAdicionaLinha(FRestResponse.Content);

        LDadosPagina := AiCartoes.ProximaPagina;
      Until (LDadosPagina.IsEmpty);

      LAutorizado := True;
    Except
      On E: Exception Do
      Begin

        If OnException(LAutorizado,LMsgErro,LContador,AChaveSelecionada,LMensagem,prgStatus) Then
          Raise Exception.Create(LMsgErro);

      End;
    End;
  End;
end;

procedure TRedeCardAPI.FormOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
    TForm(Sender).Perform(40,0,0);
end;

function TRedeCardAPI.fRetUltimaData: String;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT MAX(RED_DTAPAG) AS DTAPAG FROM RED_APPGTO';
    LConsulta.Open;

    Result := 'Nenhuma';
    If LConsulta.FieldByName('DTAPAG').AsString <> '' Then
      Result := LConsulta.FieldByName('DTAPAG').AsString;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TRedeCardAPI.GetRestResponseError: TRestResponse;
begin
  If LRestResponse.StatusCode <> 200 Then
    Result := LRestResponse // Response get Token
  Else
    Result := FRestResponse; // Response get registros
end;

procedure TRedeCardAPI.GetTokenChave13(var AChaveAtual: TChavesRedeCard);
  Var
    LRestClient: TRestClient;

    LRestRequest: TRestRequest;

    LRestAuthenticator: THTTPBasicAuthenticator;

    LJsonObject: TJsonObject;

    LResposta: String;

    LIncMinute : Integer;
begin
  LRestClient := Nil;
  LRestAuthenticator := Nil;
  LRestRequest := Nil;
  Try
    CarregaLinks(AChaveAtual.Empresa);

    LRestAuthenticator := THTTPBasicAuthenticator.Create(AChaveAtual.ClientID, AChaveAtual.SecretCode);

    LRestClient := TRestClient.Create(Nil);
    LRestClient.RaiseExceptionOn500 := False;
    LRestClient.HandleRedirects := True;
    LRestClient.SynchronizedEvents := False;
    LRestClient.Authenticator := LRestAuthenticator;

    LRestRequest := TRestRequest.Create(Nil);
    LRestRequest.Client := LRestClient;
    LRestRequest.Response := LRestResponse;
    LRestRequest.Method := rmPost;
    LRestRequest.HandleRedirects := True;
    LRestRequest.SynchronizedEvents := False;
    LRestRequest.OnAfterExecute := OnAfterExecute;

    LRestRequest.AddParameter('Content-Type', 'application/x-www-form-urlencoded', pkGETorPOST, [poAutoCreated]);
    LRestRequest.AddParameter('grant_type', 'password', pkGETorPOST, [poAutoCreated]);
    LRestRequest.AddParameter('username', AChaveAtual.Usuario, pkGETorPOST, [poAutoCreated]);
    LRestRequest.AddParameter('password', AChaveAtual.Senha, pkGETorPOST, [poAutoCreated]);


    LRestClient.BaseUrl := FLinkAutenticacao;

    LRestRequest.Execute;

    LResposta := LRestResponse.Content;

    If LRestResponse.StatusCode <> 200 Then
      Raise Exception.Create(LRestResponse.StatusCode.ToString + ' - ' +
                             LRestResponse.StatusText);
  Finally
    If Assigned(LRestClient) Then
      FreeAndNil(LRestClient);
    If Assigned(LRestAuthenticator) Then
      FreeAndNil(LRestAuthenticator);
    If Assigned(LRestRequest) Then
      FreeAndNil(LRestRequest);

    LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;

    If LJsonObject <> Nil Then
    Begin
      If LJsonObject.GetValue('access_token') <> Nil Then
      Begin
        AChaveAtual.Token := LJsonObject.GetValue<String>('access_token');
        AChaveAtual.RefreshToken := LJsonObject.GetValue<String>('refresh_token');
        AChaveAtual.Expiracao := LJsonObject.GetValue<Integer>('expires_in');

        LIncMinute := Round(AChaveAtual.Expiracao/60);
        LIncMinute := (LIncMinute - 1);
        AChaveAtual.RefreshTime := IncMinute(TRedeCardFuncoes.fTime(),LIncMinute);
      End;

      FreeAndNil(LJsonObject);
    End;
  End;
end;

procedure TRedeCardAPI.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

function TRedeCardAPI.OnException(var AAutorizado: Boolean;
                                  var AMsgErro: String; Var AContador: Integer;
                                  AChaveSelecionada: TChavesRedeCard;
                                  AMensagem : String;
                                  var prgStatus: TcxProgressBar): Boolean;
begin
  AAutorizado := GetRestResponseError.StatusCode <> 401;

  if GetRestResponseError.StatusCode = 400 Then
  Begin
    AMsgErro := 'Requisição incorreta. Verifique o Ponto de venda (Estabelecimento) está incorreto para a empresa ' + AChaveSelecionada.Empresa + '.';
  End
  Else If GetRestResponseError.StatusCode = 401 Then
  Begin
    If AContador <= 4 Then
    Begin
      Inc(AContador);
      lblInform.Caption := 'Revalidando chaves de autorização para a empresa ' + AChaveSelecionada.Empresa + '.';
      untLibCartoesGravando.pInformacao(lblInform.Caption, prgStatus);
    End
    Else
      AMsgErro := 'Chaves de autorização, Ponto de Venda (Estabelecimento) incorretas ou não liberado utilização no ambiente de ' + FAmbiente + '!' + #13 +
                             'Ponto de Venda: ' + AChaveSelecionada.Estabelecimento + ' - Empresa: ' +  AChaveSelecionada.Empresa + #13 +
                             'Erro código 401.';
  End
  Else
  Begin
    AAutorizado := False;

    If AContador <= 4 Then
    Begin
      Inc(AContador);
      lblInform.Caption := 'Erro ao realizar a importação. Nova tentativa após 5 segundos.';
      untLibCartoesGravando.pInformacao(lblInform.Caption, prgStatus);

      Sleep(5000);
    End
    Else
    Begin

      AMsgErro :='Ocorreu um erro ao conectar-se ao serviço da RedeCard.' + #13 +
                             'Tente novamente mais tarde!' + #13 +
                             'Código do erro: ' + GetRestResponseError.StatusCode.ToString + '-' +
                                                  GetRestResponseError.StatusText;

      Case GetRestResponseError.StatusCode Of
        404 : AMsgErro := 'O serviço da RedeCard não encontrou o Ponto de Venda (Estabelecimento) ou a data informada.!' + #13 +
                          'Ponto de Venda: ' + AChaveSelecionada.Estabelecimento + ' - Empresa: ' +  AChaveSelecionada.Empresa + #13 +
                          'Erro código 404.';

        503 : AMsgErro := 'O serviço da RedeCard está com problemas no funcionamento. Tente novamente mais tarde!' + #13 +
                           AMensagem + #13 +
                           'Erro código 503.';

        500 : AMsgErro :='Ocorreu um erro interno no serviço da RedeCard. ' + AMensagem + #13 +
                         'Tente novamente mais tarde!' + #13 +
                         'Erro código 500.';
      End;

    End;
  End;

  If AContador > 0 Then
  Begin
    lblInform.Caption := 'Aguarde... Nova tentativa de download da Empresa ' + AChaveSelecionada.Empresa;
    untLibCartoesGravando.pInformacao(lblInform.Caption, prgStatus);
  End;

  Result := Not AMsgErro.Trim.IsEmpty;

end;

procedure TRedeCardAPI.btnSairClick(Sender: TObject);
Begin
  frmImportacaoCartoesAPI.Close;
End;

function TRedeCardAPI.Autorizado(AAutorizado: Boolean; AContador: Integer): Boolean;
begin
  Result := True;

  If Not AAutorizado Then // Não fui autorizado a importar pela api ainda ?
  Begin
    If AContador <= 5 Then Result := False; // continuo tentando importar até 5x
  End;

end;

procedure TRedeCardAPI.btnConfClick(Sender: TObject);
Begin
  TRedeCardFuncoes.FDadosImportacaoConfirmacao.DataInicial := edtDtaIni.Date;
  TRedeCardFuncoes.FDadosImportacaoConfirmacao.DataFinal := edtDtaFin.Date;

  If (edtDtaIni.Date > Date) Or (edtDtaFin.Date > Date) Then
  Begin
    TRedeCardFuncoes.fMensagem('','As datas para importação não podem ser maiores que a data atual!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date = 0) Or (edtDtaFin.Date = 0) Then
  Begin
    TRedeCardFuncoes.fMensagem('','É necessário digitar a data inicial e a data final!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date > edtDtaFin.Date) Then
  Begin
    TRedeCardFuncoes.fMensagem('','A data inicial deve ser menor que data final!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 30 Then
  Begin
    TRedeCardFuncoes.fMensagem('ATENÇÃO','A quantidade de dias do período não pode ser maior que 30!',['&OK']);
    Exit;
  End;
  If FListaChaves.Count = 0 Then
  Begin
    TRedeCardFuncoes.fMensagem('ATENÇÃO','Não existem Pontos de Vendas com chaves de acesso a API configurados!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 5 Then
  Begin
    If TRedeCardFuncoes.fMensagem('','A quantidade de dias do período é maior 5 dias. ' +
                                        'A importação da RedeCard é feita através da Internet, dependendo da quantidade ' +
                                        'de registros a operação pode demorar. Deseja realmente continuar?',['&Sim','&Não']) = 2 Then
      Exit;
  End;
  If (edtDtaIni.Date = Date) Or (edtDtaFin.Date = Date) Then
  Begin
    TRedeCardFuncoes.fMensagem('','Em um dia posterior a hoje lembre-se de importar novamente a data atual pois nem toda movimentação diária está disponível no momento.',['&OK']);
  End;

  VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);
  Try
    pDisableControls(True);
    TRedeCardFuncoes.ExecutaAguarde(ProcessaDownload, 'Aguarde... Importando registros.');
  Finally
    VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);
    pDisableControls(False);
  End;
End;

function TRedeCardAPI.ProcessaDownload(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LiCartoes: ICartoes;

    LMensagem: String;

    LChavesRedeCard: TChavesRedeCard;

    LQtdeDiasMaximo,
    LContador: Integer;

    LOcorreuErro,
    LPararNoErro: Boolean;
begin
  Try
    TRedeCardFuncoes.ValidaLibsWebService;

    LiCartoes := TRedeCardAPIPgto.Create;

    If FListaChaves.Count = 0 Then
    Begin
      TRedeCardFuncoes.fMensagem('ATENÇÃO','Não existem empresas configuradas com a chave de Autorização da RedeCard. Operação cancelada!',['&OK']);
      Exit(False);
    End;

    LOcorreuErro := False;
    LPararNoErro := False;

    LContador := 0;

    For LChavesRedeCard In FListaChaves Do
    Begin
      Inc(LContador);

      lblInform.Caption := 'Aguarde... Efetuando download da Empresa ' + LChavesRedeCard.Empresa;
      untLibCartoesGravando.pInformacao(lblInform.Caption, pgbProgresso);
      Application.ProcessMessages;

      Try
        LQtdeDiasMaximo := 15;
        If DaysBetween(edtDtaIni.Date, edtDtaFin.Date) > LQtdeDiasMaximo Then
        Begin
          DownloadPorPeriodoMaximo(LQtdeDiasMaximo,
                                   LChavesRedeCard,
                                   edtDtaIni.Date,
                                   edtDtaFin.Date,
                                   TRedeCardAPIPgto(LiCartoes),
                                   pgbProgresso);
        End
        Else
        Begin
          DownloadDataSelecionada(LChavesRedeCard,
                                  edtDtaIni.Date,
                                  edtDtaFin.Date,
                                  TRedeCardAPIPgto(LiCartoes),
                                  pgbProgresso);



          lblInform.Caption := 'Aguarde... Gravando os lançamentos da Empresa ' + LChavesRedeCard.Empresa;
          untLibCartoesGravando.pInformacao(lblInform.Caption, pgbProgresso);

          LiCartoes.pGravarRegistros(pgbProgresso);

          Application.ProcessMessages;
        End;
      Except
        On E: Exception Do
        Begin
          LOcorreuErro := True;

          If (LContador = FListaChaves.Count) Then
            TRedeCardFuncoes.fMensagem('ERRO', E.Message, ['&OK'])
          Else
            LPararNoErro := TRedeCardFuncoes.fMensagem('ERRO', E.Message + #13 +
                                                                  'Deseja continuar com a importação das outras empresas?',
                                                                  ['&Sim', 'Não']) = 2;
        End;
      End;

      If LPararNoErro Then
        Break;
    End;

    LMensagem := 'Nenhum registro foi importado no período selecionado!';
    If TRedeCardAPIPgto(LiCartoes).ImportouRegistro Then
    Begin
      If Not LOcorreuErro Then
      Begin
        LMensagem := 'Dados importados com sucesso';
        If Not TRedeCardAPIPgto(LiCartoes).ImportouPagamento And TRedeCardAPIPgto(LiCartoes).ImportouVendas Then
          LMensagem := LMensagem + ', porém não possui registros de pagamentos no período selecionado'

        Else If Not TRedeCardAPIPgto(LiCartoes).ImportouVendas And TRedeCardAPIPgto(LiCartoes).ImportouPagamento Then
          LMensagem := LMensagem + ', porém não possui registros de vendas no período selecionado'

        Else If Not TRedeCardAPIPgto(LiCartoes).ImportouVendas And Not TRedeCardAPIPgto(LiCartoes).ImportouPagamento Then
          LMensagem := LMensagem + ', porém não possui registros de pagamentos e vendas no período selecionado';

        FImportouVendas := TRedeCardAPIPgto(LiCartoes).ImportouVendas;
        FImportouPagamentos := TRedeCardAPIPgto(LiCartoes).ImportouPagamento;

        TRedeCardFuncoes.FDadosImportacaoConfirmacao.ImportouVendas := FImportouVendas;
        TRedeCardFuncoes.FDadosImportacaoConfirmacao.ImportouPagamentos := FImportouPagamentos;

        LMensagem := LMensagem + '!';
      End
      Else
        LMensagem := 'Registros foram importados, porém ocorrereu algum erro durante a importação.';
    End;
    TRedeCardFuncoes.fMensagem('ATENÇÃO', LMensagem,['&OK']);

  Finally
    LiCartoes := Nil;
    Result := True;
    pDisableControls(False);
  End;

  frmImportacaoCartoesAPI.Close;
end;

procedure TRedeCardAPI.pDisableControls(blnDisable: Boolean);
begin
  pnlFundo.Enabled    := not blnDisable;
  edtDtaIni.Enabled  := not blnDisable;
  edtDtaFin.Enabled  := not blnDisable;
end;

procedure TRedeCardAPI.pSelecionaFonte;
  Var
    lblDtaIni,
    lblDtaFin: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;

    LImagemVaziaConf,
    LImagemVaziaSair: TBitmap;
Begin

  frmImportacaoCartoesAPI := TForm.Create(Self);

  frmImportacaoCartoesAPI.BorderStyle  := bsSingle;
  frmImportacaoCartoesAPI.Caption      := 'Importação de Registros (REDECARD Online)';
  frmImportacaoCartoesAPI.ClientHeight := 102;
  frmImportacaoCartoesAPI.ClientWidth  := 402;
  frmImportacaoCartoesAPI.Color        := 16770261;
  frmImportacaoCartoesAPI.Position     := poScreenCenter;
  frmImportacaoCartoesAPI.BorderIcons  := [biSystemMenu];
  frmImportacaoCartoesAPI.KeyPreview   := True;
  frmImportacaoCartoesAPI.OnKeyDown    := FormOnKeyDown;
  frmImportacaoCartoesAPI.Icon := TRedeCardFuncoes.FIconeAplicacao;

  LImagemVaziaConf := TBitmap.Create;
  LImagemVaziaSair := TBitmap.Create;

  Try
    lblDtaIni := TLabel.Create(frmImportacaoCartoesAPI);
    lblDtaIni.Parent   := frmImportacaoCartoesAPI;
    lblDtaIni.Top      := 12;
    lblDtaIni.AutoSize := True;
    lblDtaIni.Caption  := 'Data Inicial:';
    lblDtaIni.Left     := Round(frmImportacaoCartoesAPI.Width / 2) - lblDtaIni.Width - 95 - 5;

    edtDtaIni := TcxDateEdit.Create(frmImportacaoCartoesAPI);
    edtDtaIni.Parent   := frmImportacaoCartoesAPI;
    edtDtaIni.Left     := lblDtaIni.Left + lblDtaIni.Width + 2;
    edtDtaIni.Top      := 8;
    edtDtaIni.Height   := 21;
    edtDtaIni.TabOrder := 0;
    edtDtaIni.Width    := 90;
    edtDtaIni.Text     := DateToStr(Yesterday);
    edtDtaIni.Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);

    lblDtaFin := TLabel.Create(frmImportacaoCartoesAPI);
    lblDtaFin.Parent   := frmImportacaoCartoesAPI;
    lblDtaFin.Left     := edtDtaIni.Left + edtDtaIni.Width + 15 + 5;
    lblDtaFin.Top      := 12;
    lblDtaFin.AutoSize := True;
    lblDtaFin.Caption  := 'Data Final:';


    edtDtaFin := TcxDateEdit.Create(frmImportacaoCartoesAPI);
    edtDtaFin.Parent   := frmImportacaoCartoesAPI;
    edtDtaFin.Left     := lblDtaFin.Left + lblDtaFin.Width + 2;
    edtDtaFin.Top      := 8;
    edtDtaFin.Height   := 21;
    edtDtaFin.TabOrder := 1;
    edtDtaFin.Width    := 90;
    edtDtaFin.Text     := DateToStr(Yesterday);
    edtDtaFin.Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);

    lblInform := TLabel.Create(frmImportacaoCartoesAPI);
    lblInform.Parent   := frmImportacaoCartoesAPI;
    lblInform.Left     := 0;
    lblInform.Top      := 42;
    lblInform.AutoSize := False;
    lblInform.Width    := frmImportacaoCartoesAPI.Width;
    lblInform.Alignment:= taCenter;
    lblInform.Caption  := 'Digite o período para realizar a importação. Última data importada: ' + fRetUltimaData;

    memXMLDoc := TMemo.Create(frmImportacaoCartoesAPI);
    memXMLDoc.Parent   := frmImportacaoCartoesAPI;
    memXMLDoc.Left     := 8;
    memXMLDoc.Top      := 42;
    memXMLDoc.Visible  := False;

    pnlFundo := TPanel.Create(frmImportacaoCartoesAPI);
    pnlFundo.Parent   := frmImportacaoCartoesAPI;
    pnlFundo.Align    := alBottom;
    pnlFundo.Height   := 28;
    pnlFundo.Color    := clGray;
    pnlFundo.TabOrder := 2;

    btnSair := TBitBtnLocked.Create(frmImportacaoCartoesAPI);
    btnSair.Parent   := pnlFundo;
    btnSair.Left     := 327;
    btnSair.Top      := 2;
    btnSair.Width    := 72;
    btnSair.Height   := 24;
    btnSair.TabOrder := 1;
    btnSair.OnClick  := btnSairClick;
    btnSair.Kind     := bkClose;
    btnSair.Caption  := '&Sair';
    btnSair.Cancel   := True;
    btnSair.Glyph    := LImagemVaziaSair;

    btnConf := TBitBtnLocked.Create(frmImportacaoCartoesAPI);
    btnConf.Parent   := pnlFundo;
    btnConf.Left     := 4;
    btnConf.Top      := 2;
    btnConf.Width    := 72;
    btnConf.Height   := 24;
    btnConf.TabOrder := 0;
    btnConf.OnClick  := btnConfClick;
    btnConf.Default  := False;
    btnConf.Caption  := '&Importar';
    btnConf.Glyph    := LImagemVaziaConf;

    frmImportacaoCartoesAPI.ShowModal;
    FDataInicial :=  edtDtaIni.Date;
    FDataFinal   :=  edtDtaFin.Date;
  Finally
    FreeAndNil(LImagemVaziaConf);
    FreeAndNil(LImagemVaziaSair);

    FreeAndNil(frmImportacaoCartoesAPI);
  End;
End;

procedure TRedeCardAPI.RefreshToken(var AChaveAtual: TChavesRedeCard);
  Var
    LRestClient: TRestClient;

    LRestRequest: TRestRequest;

    LRestAuthenticator: THTTPBasicAuthenticator;

    LJsonObject: TJsonObject;

    LResposta: String;

    LIncMinute: Integer;
begin

  If (AChaveAtual.RefreshTime > TRedeCardFuncoes.fTime()) Then
    Exit;

  Try
    LRestAuthenticator := THTTPBasicAuthenticator.Create(AChaveAtual.ClientID, AChaveAtual.SecretCode);

    LRestClient := TRestClient.Create(Nil);
    LRestClient.RaiseExceptionOn500 := False;
    LRestClient.HandleRedirects := True;
    LRestClient.SynchronizedEvents := False;
    LRestClient.Authenticator := LRestAuthenticator;

    LRestRequest := TRestRequest.Create(Nil);
    LRestRequest.Client := LRestClient;
    LRestRequest.Response := LRestResponse;
    LRestRequest.Method := rmPost;
    LRestRequest.HandleRedirects := True;
    LRestRequest.SynchronizedEvents := False;
    LRestRequest.OnAfterExecute := OnAfterExecute;

    LRestRequest.AddParameter('Content-Type', 'application/x-www-form-urlencoded', pkGETorPOST, [poAutoCreated]);
    LRestRequest.AddParameter('grant_type',   'refresh_token', pkGETorPOST, [poAutoCreated]);
    LRestRequest.AddParameter('refresh_token',AChaveAtual.RefreshToken, pkGETorPOST, [poAutoCreated]);

    LRestClient.BaseUrl := FLinkAutenticacao;

    LRestRequest.Execute;

    LResposta := LRestResponse.Content;

    If LRestResponse.StatusCode <> 200 Then
      Raise Exception.Create(LRestResponse.StatusCode.ToString + ' - ' +
                             LRestResponse.StatusText);
  Finally
    FreeAndNil(LRestClient);
    FreeAndNil(LRestAuthenticator);
    FreeAndNil(LRestRequest);

    LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
    If LJsonObject <> Nil Then
    Begin
      AChaveAtual.Token := LJsonObject.GetValue<String>('access_token');

      LIncMinute := Round(AChaveAtual.Expiracao/60);
      AChaveAtual.RefreshTime := IncMinute(TRedeCardFuncoes.fTime(), LIncMinute);

      FreeAndNil(LJsonObject);
    End;
  End;
end;

function TRedeCardAPI.RetiraZerosEsquerda(AString: String): String;
begin

  While AString[1] = '0' do
    Delete(AString,1,1);

  Result := AString;
end;

function TRedeCardAPI.RetornaLinkFormatado(ALinkOriginal: String;
  AChaveSelecionada: TChavesRedeCard; ADataInicial, ADataFinal: TDateTime;
  ADadosPagina: String): String;
begin
  Result := StringReplace(ALinkOriginal, '[ESTABELECIMENTO]', RetiraZerosEsquerda(AChaveSelecionada.Estabelecimento), [rfReplaceAll]);
  Result := StringReplace(Result, '[INICIO]', FormatDateTime('yyyy-mm-dd', ADataInicial), []);
  Result := StringReplace(Result, '[FIM]', FormatDateTime('yyyy-mm-dd', ADataFinal), []);
  If Not ADadosPagina.IsEmpty Then
    Result := Result + '&pageKey=' + ADadosPagina;
end;

procedure TRedeCardAPI.CarregaListaDeChavesRedeCard(var AListaChaves: TObjectList<TChavesRedeCard>);
  Var
    LDados: TUniQuery;

    LChavesRedeCard: TChavesRedeCard;

    LEstabelecimento,
    LEstabelecimentoLink: String;

    LListaEstabelecimentos: TStringList;
begin
  If Assigned(AListaChaves) Then
    FreeAndNil(AListaChaves);

  AListaChaves := TObjectList<TChavesRedeCard>.Create;

  LListaEstabelecimentos := TStringList.Create;
  LListaEstabelecimentos.Delimiter := ',';
  LListaEstabelecimentos.StrictDelimiter := True;

  LDados := Nil;
  Try
    LDados := VS_FuncoesExternas.fICriaQuery;
    LDados.SQL.Text := 'SELECT SIS_VALCFG, SIS_CODEMP FROM CFGSIS          ' +
                       ' WHERE SIS_CODCFG="CFG_REDCLI" AND                 ' +
                       ' SIS_VALCFG IS NOT NULL AND TRIM(SIS_VALCFG) <> "" ' +
                       ' ORDER BY SIS_CODEMP                               ';
    LDados.Open;

    While Not LDados.Eof Do
    Begin
      LListaEstabelecimentos.DelimitedText := TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDEST', LDados.FieldByName('SIS_CODEMP').AsString);

      If Not LListaEstabelecimentos.DelimitedText.IsEmpty Then
      Begin
        For LEstabelecimento In LListaEstabelecimentos Do
        Begin
          LChavesRedeCard := TChavesRedeCard.Create;
          LChavesRedeCard.Empresa := LDados.FieldByName('SIS_CODEMP').AsString;
          LChavesRedeCard.Estabelecimento := LEstabelecimento;
          LChavesRedeCard.ClientID := TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDCLI', LDados.FieldByName('SIS_CODEMP').AsString);
          LChavesRedeCard.SecretCode := TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDSEC', LDados.FieldByName('SIS_CODEMP').AsString);
          LChavesRedeCard.Usuario := TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDUSU', LDados.FieldByName('SIS_CODEMP').AsString);
          LChavesRedeCard.Senha := TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDSEN', LDados.FieldByName('SIS_CODEMP').AsString);

          AListaChaves.Add(LChavesRedeCard);
        End;
      End;

      LEstabelecimentoLink := TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDECO', LDados.FieldByName('SIS_CODEMP').AsString);
      If Not LEstabelecimentoLink.IsEmpty Then
      Begin
        LChavesRedeCard := TChavesRedeCard.Create;
        LChavesRedeCard.Empresa := LDados.FieldByName('SIS_CODEMP').AsString;
        LChavesRedeCard.Estabelecimento := LEstabelecimentoLink;
        LChavesRedeCard.ClientID := TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDCLI', LDados.FieldByName('SIS_CODEMP').AsString);
        LChavesRedeCard.SecretCode := TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDSEC', LDados.FieldByName('SIS_CODEMP').AsString);
        LChavesRedeCard.Usuario := TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDUSU', LDados.FieldByName('SIS_CODEMP').AsString);
        LChavesRedeCard.Senha := TRedeCardFuncoes.fRetornaValorConfiguracao('CFG_REDSEN', LDados.FieldByName('SIS_CODEMP').AsString);

        AListaChaves.Add(LChavesRedeCard);
      End;

      LDados.Next;
    End;
  Finally
    FreeAndNil(LListaEstabelecimentos);

    TredeCardFuncoes.FreeAndNilDatasets(LDados);
  End;
end;

end.
