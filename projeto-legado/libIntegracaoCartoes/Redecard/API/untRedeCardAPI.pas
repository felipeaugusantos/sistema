{*****************************************************}
{* Importação de arquivos com RESTClient da REDECARD *}
{**************************************************AJ*}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{****************************************AJ*}
unit untRedeCardAPI;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Vcl.Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  ComCtrls, cxCalendar, IPPeerClient, DateUtils, System.Generics.Collections,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Json, untRedeCardAPIPgto, REST.Authenticator.Basic,untFuncoesSimples;

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
    frmForm   : TForm;
    pgbProg   : TProgressBar;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    memXMLDoc : TMemo;
    lblInform : TLabel;
    pnlFund   : TPanel;

    FAplicacao: HWND;

    FListaChaves: TList<TChavesRedeCard>;

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

    function RetornaListaDeChavesRedeCard: TList<TChavesRedeCard>;

    procedure CriarComponentesRequisicao;
    procedure DestroiComponentesRequisicao;
    procedure ProcessaDownload;
    procedure DownloadDataSelecionada(AChaveSelecionada: TChavesRedeCard;
                                      ADataInicial,
                                      ADataFinal: TDateTime;
                                      AiCartoes: TRedeCardAPIPgto);

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
                               AMensagem: String): Boolean;

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

uses untFuncoes, untIDataSet;

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

  If fRetornaValorConfiguracao('CFG_REDHOM', ACodigoEmpresa)= 'N' Then
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
  FListaChaves := RetornaListaDeChavesRedeCard;

  lstEstabel := TStringList.Create;

  CriarComponentesRequisicao;
  FConfirmaCartoes   := False;
  FImportouVendas    := False;
  FImportouPagamentos:= False;
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
  inherited;
  FreeAndNil(FListaChaves);

  FreeAndNil(lstEstabel);

  DestroiComponentesRequisicao;
end;

procedure TRedeCardAPI.DownloadDataSelecionada(AChaveSelecionada: TChavesRedeCard;
                                               ADataInicial,
                                               ADataFinal: TDateTime;
                                               AiCartoes: TRedeCardAPIPgto);
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
      AiCartoes.Progresso := pgbProg;

      Repeat
        //Pagamentos
        lblInform.Caption := 'Importando pagamentos do estabelecimento ' + AChaveSelecionada.Estabelecimento +
                             ' da empresa ' + AChaveSelecionada.Empresa +  '.';

        Application.ProcessMessages;

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
        //Pagamentos
        lblInform.Caption := 'Importando pagamentos diários do estabelecimento ' + AChaveSelecionada.Estabelecimento +
                             ' da empresa ' + AChaveSelecionada.Empresa +  '.';

        Application.ProcessMessages;

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
                             ' da empresa ' + AChaveSelecionada.Empresa +  '.';

        Application.ProcessMessages;

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
                             ' da empresa ' + AChaveSelecionada.Empresa +  '.';

        Application.ProcessMessages;

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
                             ' da empresa ' + AChaveSelecionada.Empresa +  '.';

        Application.ProcessMessages;

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

        If OnException(LAutorizado,LMsgErro,LContador,AChaveSelecionada,LMensagem) Then
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
    qryDados: IDataSet;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.SQL := 'SELECT MAX(RED_DTAPAG) AS DTAPAG FROM RED_APPGTO';
  qryDados.Open;

  Result := 'Nenhuma';
  If qryDados.FieldByName('DTAPAG').AsString <> '' Then
    Result := qryDados.FieldByName('DTAPAG').AsString;
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
  Try
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
    Except
      On E: Exception Do
        Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(LRestClient);
    FreeAndNil(LRestAuthenticator);
    FreeAndNil(LRestRequest);

    LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
    AChaveAtual.Token := LJsonObject.GetValue<String>('access_token');
    AChaveAtual.RefreshToken := LJsonObject.GetValue<String>('refresh_token');
    AChaveAtual.Expiracao := LJsonObject.GetValue<Integer>('expires_in');

    LIncMinute := Round(AChaveAtual.Expiracao/60);
    LIncMinute := (LIncMinute - 1);
    AChaveAtual.RefreshTime := IncMinute(fTime(),LIncMinute);
    FreeAndNil(LJsonObject);
  End;
end;

procedure TRedeCardAPI.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

function TRedeCardAPI.OnException(var AAutorizado: Boolean;
                                  var AMsgErro: String; Var AContador: Integer;
                                  AChaveSelecionada: TChavesRedeCard; AMensagem : String): Boolean;
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
      Application.ProcessMessages;

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
    Application.ProcessMessages;
  End;

  Result := Not fEmptyStr(AMsgErro);

end;

procedure TRedeCardAPI.btnSairClick(Sender: TObject);
Begin
  frmForm.Close;
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
  If (edtDtaIni.Date > Date) Or (edtDtaFin.Date > Date) Then
  Begin
    fMensagem('','As datas para importação não podem ser maiores que a data atual!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date = 0) Or (edtDtaFin.Date = 0) Then
  Begin
    fMensagem('','É necessário digitar a data inicial e a data final!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date > edtDtaFin.Date) Then
  Begin
    fMensagem('','A data inicial deve ser menor que data final!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 30 Then
  Begin
    fMensagem('ATENÇÃO','A quantidade de dias do período não pode ser maior que 30!',['&OK']);
    Exit;
  End;
  If FListaChaves.Count = 0 Then
  Begin
    fMensagem('ATENÇÃO','Não existem Pontos de Vendas com chaves de acesso a API configurados!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 5 Then
  Begin
    If fMensagem('','A quantidade de dias do período é maior 5 dias. ' +
                                  'A importação da RedeCard é feita através da Internet, dependendo da quantidade ' +
                                  'de registros a operação pode demorar. Deseja realmente continuar?',['&Sim','&Não']) = 2 Then
      Exit;
  End;
  If (edtDtaIni.Date = Date) Or (edtDtaFin.Date = Date) Then
  Begin
    fMensagem('','Em um dia posterior a hoje lembre-se de importar novamente a data atual pois nem toda movimentação diária está disponível no momento.',['&OK']);
  End;

  pDisableControls(True);
  ProcessaDownload;
  pDisableControls(False);
End;

procedure TRedeCardAPI.ProcessaDownload;
  Var
    LiCartoes: TRedeCardAPIPgto;

    LMensagem: String;

    LChavesRedeCard: TChavesRedeCard;

    LContador: Integer;

    LOcorreuErro,
    LPararNoErro: Boolean;
begin
  Try
    pValidaLibsWebService;

    LiCartoes := TRedeCardAPIPgto.Create;

    If FListaChaves.Count = 0 Then
    Begin
      fMensagem('ATENÇÃO','Não existem empresas configuradas com a chave de Autorização da RedeCard. Operação cancelada!',['&OK']);
      Exit;
    End;

    LOcorreuErro := False;
    LPararNoErro := False;

    LContador := 0;

    For LChavesRedeCard In FListaChaves Do
    Begin
      Inc(LContador);

      lblInform.Caption := 'Aguarde... Efetuando download da Empresa ' + LChavesRedeCard.Empresa;
      Application.ProcessMessages;

      Try
        DownloadDataSelecionada(LChavesRedeCard,
                                edtDtaIni.Date,
                                edtDtaFin.Date,
                                LiCartoes);



        lblInform.Caption := 'Aguarde... Gravando os lançamentos da Empresa ' + LChavesRedeCard.Empresa;
        Application.ProcessMessages;

        LiCartoes.pGravarRegistros(pgbProg);

        Application.ProcessMessages;
      Except
        On E: Exception Do
        Begin
          LOcorreuErro := True;

          If (LContador = FListaChaves.Count) Then
            fMensagem('ERRO', E.Message, ['&OK'])
          Else
            LPararNoErro := fMensagem('ERRO', E.Message + #13 +
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

        LMensagem := LMensagem + '!';
      End
      Else
        LMensagem := 'Registros foram importados, porém ocorrereu algum erro durante a importação.';
    End;
    fMensagem('ATENÇÃO', LMensagem,['&OK']);

  Finally
    pDisableControls(False);
  End;

  frmForm.Close;
end;

procedure TRedeCardAPI.pDisableControls(blnDisable: Boolean);
begin
  pnlFund.Enabled    := not blnDisable;
  edtDtaIni.Enabled  := not blnDisable;
  edtDtaFin.Enabled  := not blnDisable;
end;

procedure TRedeCardAPI.pSelecionaFonte;
  Var
    lblDtaIni,
    lblDtaFin: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;
Begin

  frmForm := TForm.Create(Self);

  frmForm.BorderStyle  := bsSingle;
  frmForm.Caption      := 'Importação de Registros (REDECARD API)';
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
  edtDtaIni.Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);
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
  edtDtaFin.Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);
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
  FDataInicial :=  edtDtaIni.Date;
  FDataFinal   :=  edtDtaFin.Date;

  FreeAndNil(frmForm);
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

  If (AChaveAtual.RefreshTime > fTime()) Then
    Exit;

  Try

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
    Except
      On E: Exception Do
        Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(LRestClient);
    FreeAndNil(LRestAuthenticator);
    FreeAndNil(LRestRequest);

    LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
    AChaveAtual.Token := LJsonObject.GetValue<String>('access_token');

    LIncMinute := Round(AChaveAtual.Expiracao/60);
    AChaveAtual.RefreshTime := IncMinute(fTime(), LIncMinute);

    FreeAndNil(LJsonObject);
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
  Result := StringReplace(Result, '[INICIO]', FormatDateTime('yyyy-mm-dd', edtDtaIni.Date), []);
  Result := StringReplace(Result, '[FIM]', FormatDateTime('yyyy-mm-dd', edtDtaFin.Date), []);
  If Not ADadosPagina.IsEmpty Then
    Result := Result + '&pageKey=' + ADadosPagina;
end;

function TRedeCardAPI.RetornaListaDeChavesRedeCard: TList<TChavesRedeCard>;
  Var
    LDados: IDataset;

    LChavesRedeCard: TChavesRedeCard;

    LEstabelecimento,
    LEstabelecimentoLink: String;

    LListaEstabelecimentos: TStringList;
begin
  Result := TList<TChavesRedeCard>.Create;

  LListaEstabelecimentos := TStringList.Create;
  LListaEstabelecimentos.Delimiter := ',';
  LListaEstabelecimentos.StrictDelimiter := True;

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := 'SELECT SIS_VALCFG, SIS_CODEMP FROM CFGSIS          ' +
                ' WHERE SIS_CODCFG="CFG_REDCLI" AND                 ' +
                ' SIS_VALCFG IS NOT NULL AND TRIM(SIS_VALCFG) <> "" ' +
                ' ORDER BY SIS_CODEMP                               ';
  LDados.Open;

  While Not LDados.Eof Do
  Begin
    LListaEstabelecimentos.DelimitedText := fRetornaValorConfiguracao('CFG_REDEST', LDados.FieldByName('SIS_CODEMP').AsString);

    If Not LListaEstabelecimentos.DelimitedText.IsEmpty Then
    Begin
      For LEstabelecimento In LListaEstabelecimentos Do
      Begin
        LChavesRedeCard := TChavesRedeCard.Create;
        LChavesRedeCard.Empresa := LDados.FieldByName('SIS_CODEMP').AsString;
        LChavesRedeCard.Estabelecimento := LEstabelecimento;
        LChavesRedeCard.ClientID := fRetornaValorConfiguracao('CFG_REDCLI', LDados.FieldByName('SIS_CODEMP').AsString);
        LChavesRedeCard.SecretCode := fRetornaValorConfiguracao('CFG_REDSEC', LDados.FieldByName('SIS_CODEMP').AsString);
        LChavesRedeCard.Usuario := fRetornaValorConfiguracao('CFG_REDUSU', LDados.FieldByName('SIS_CODEMP').AsString);
        LChavesRedeCard.Senha := fRetornaValorConfiguracao('CFG_REDSEN', LDados.FieldByName('SIS_CODEMP').AsString);

        Result.Add(LChavesRedeCard);
      End;
    End;

    LEstabelecimentoLink := fRetornaValorConfiguracao('CFG_REDECO', LDados.FieldByName('SIS_CODEMP').AsString);
    If Not LEstabelecimentoLink.IsEmpty Then
    Begin
      LChavesRedeCard := TChavesRedeCard.Create;
      LChavesRedeCard.Empresa := LDados.FieldByName('SIS_CODEMP').AsString;
      LChavesRedeCard.Estabelecimento := LEstabelecimentoLink;
      LChavesRedeCard.ClientID := fRetornaValorConfiguracao('CFG_REDCLI', LDados.FieldByName('SIS_CODEMP').AsString);
      LChavesRedeCard.SecretCode := fRetornaValorConfiguracao('CFG_REDSEC', LDados.FieldByName('SIS_CODEMP').AsString);
      LChavesRedeCard.Usuario := fRetornaValorConfiguracao('CFG_REDUSU', LDados.FieldByName('SIS_CODEMP').AsString);
      LChavesRedeCard.Senha := fRetornaValorConfiguracao('CFG_REDSEN', LDados.FieldByName('SIS_CODEMP').AsString);

      Result.Add(LChavesRedeCard);
    End;

    LDados.Next;
  End;

  FreeAndNil(LListaEstabelecimentos);
end;

end.
