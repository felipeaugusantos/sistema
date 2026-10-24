unit untTImportaPagamentosPagarMe;

interface

uses System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Controls,
     WinApi.Windows, Vcl.Graphics, Vcl.Buttons, System.StrUtils,
     System.SysUtils, Vcl.ComCtrls, System.DateUtils, System.Json,
     System.Generics.Collections, System.NetEncoding, Data.DB,

     BitBtnLockedIncrem, cxCalendar, Uni, cxProgressBar, EditFocus, REST.Types,
     REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
     REST.Authenticator.Basic, IdHTTP, IdSSLOpenSSL, IdComponent,
     IPPeerCommon, IPPeerClient,

     untPagarMePgto, untPagarMeTipos, untTPagarMeFuncoes, untLibCartoesInterfacesTipos;

Type
  TChavesPagarMe = class
  private
  public
    Empresa,
    ApiKey,
    Versao: String;
    ModeloAtualizado: Boolean;
  end;

  TTipoDataRecebivel = (tdCadastro, tdPagamento);

Type
  TImportaPagamentosPagarMe = Class(TComponent)
  Private
    frmFormularioImportacao: TForm;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    lblInform : TLabel;
    pnlFund   : TPanel;

    FAplicacao: HWND;

    FListaChaves: TObjectList<TChavesPagarMe>;

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

    FRestClient: TRestClient;
    FRestRequest: TRestRequest;
    FRestResponse: TRestResponse;

    procedure OnAfterExecute(Sender: TCustomRESTRequest);

    procedure pDisableControls(blnDisable: Boolean);
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function fRetUltimaData: String;

    function RetornaListaDeChavesPagarMe: TObjectList<TChavesPagarMe>;

    procedure CriarComponentesRequisicao;
    procedure DestroiComponentesRequisicao;
    procedure PrepararHeadersRequisicao(AChaveSelecionada: TChavesPagarMe);

    function ProcessaDownload(prgStatus: TcxProgressBar): Boolean;

    procedure DownloadDataSelecionada(AChaveSelecionada: TChavesPagarMe;
                                      ADataInicial,
                                      ADataFinal: TDateTime;
                                      AiCartoes: TPagarMePgto;
                                      prgStatus: TcxProgressBar);

    procedure DownloadDataSelecionadaAPIv5(AChaveSelecionada: TChavesPagarMe;
                                           ADataInicial,
                                           ADataFinal: TDateTime;
                                           AiCartoes: TPagarMePgto;
                                           prgStatus: TcxProgressBar);

    procedure DownloadCobrancaPorId(AChaveSelecionada: TChavesPagarMe;
                                    ACobranca_ID: String;
                                    AiCartoes: TPagarMePgto;
                                    prgStatus: TcxProgressBar);

    procedure DownloadCobrancasNaoEncontradas(AListaCobrancas: TStringList;
                                              AChaveSelecionada: TChavesPagarMe;
                                              AiCartoes: TPagarMePgto;
                                              prgStatus: TcxProgressBar);

    procedure ImportarCobrancas(AChaveSelecionada: TChavesPagarMe;
                                ADataInicial,
                                ADataFinal: TDateTime;
                                AiCartoes: TPagarMePgto;
                                AStatus: String;
                                prgStatus: TcxProgressBar);

    procedure ImportarRecebiveis(ATipoData: TTipoDataRecebivel;
                                 AChaveSelecionada: TChavesPagarMe;
                                 ADataInicial, ADataFinal: TDateTime;
                                 AiCartoes: TPagarMePgto;
                                 prgStatus: TcxProgressBar);

    procedure ImportarTransferencias(AChaveSelecionada: TChavesPagarMe;
                                     ADataInicial,
                                     ADataFinal: TDateTime;
                                     AiCartoes: TPagarMePgto;
                                     prgStatus: TcxProgressBar;
                                     AStatus: String = '');

    procedure CarregaLinks(ACodigoEmpresa: String; AModeloAtualizado: Boolean);

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
                                              AValorPaginacao: String = ''): String;

    function RetornaProximoCursor(AJsonRetorno: String): String;

    function RetornaLinkFormatadoApiTransferenciasV5(ADataInicial,
                                                 ADataFinal: TDateTime;
                                                 ACodigoEmpresa: String;
                                                 APagina: String;
                                                 AModeloAtualizado: Boolean;
                                                 AStatus: String = ''): String;

    function OnException(Var AAutorizado: Boolean; Var AMsgErro :String;
                         Var AContador: Integer; AChaveSelecionada: TChavesPagarMe;
                             AMensagem: String; prgStatus: TcxProgressBar): Boolean;

    function Autorizado(AAutorizado: Boolean; AContador: Integer):Boolean;
    function GetRestResponseError: TRESTResponse;
    function FormatarJson(AResponseContent: String): String;
    function RetornaStatusCobranca(AResponseContent: String): String;

    procedure CorrigirValoresMovCar;
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
  End;

  Hack = Class(TWinControl)
  End;

implementation
Uses untIPagarMeIntegracaoLibCartoes;
{ TImportaPagamentosPagarMe }

procedure TImportaPagamentosPagarMe.CarregaLinks(ACodigoEmpresa: String; AModeloAtualizado: Boolean);
begin

  LLinkTransacoes := 'https://api.pagar.me/1/transactions?count=1000&page=[PAGINA]&status=[STATUS]'+
                     '&date_created=>=[INICIO]&date_created=<=[FIM]&api_key=[KEY]';

  LLinkRecebiveisTransacao := 'https://api.pagar.me/1/payables?count=1000&page=[PAGINA]&status=[STATUS]'+
                              '&type=[TIPO]&payment_date=>=[INICIO]&payment_date=<=[FIM]&api_key=[KEY]';

  FLinkCobranca := 'https://api.pagar.me/core/v5/charges?created_since=[INICIO]&created_until=[FIM]&size=30'+
                   '&status=[STATUS]&page=[PAGINA]';

  FLinkCobrancaPorId := 'https://api.pagar.me/core/v5/charges/';

  FLinkRecebiveis := 'https://api.pagar.me/core/v5/payables?size=30';

  If AModeloAtualizado Then
    FLinkTransferencias := 'https://api.pagar.me/core/v5/settlements' +
                           '?payment_date_start=[INICIO]' +
                           '&payment_date_end=[FIM]' +
                           '&limit=1000' +
                           '&page=[PAGINA]'
  Else
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
  FListaChaves := RetornaListaDeChavesPagarMe;
  CriarComponentesRequisicao;
  FImportouVendas := False;
  FImportouCobrancas := False;

  TPagarMeFuncoes.FDadosImportacaoConfirmacao := TDadosImportacaoConfirmacao.Create;
end;

procedure TImportaPagamentosPagarMe.CriarComponentesRequisicao;
begin
  FRestClient := TRestClient.Create(Nil);
  FRestClient.RaiseExceptionOn500 := False;
  FRestClient.HandleRedirects := True;
  FRestClient.SynchronizedEvents := True;
  FRestClient.Authenticator := Nil;

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
  If Assigned(FRestClient) Then
  Begin
    If FRestClient.Authenticator <> Nil Then
      FRestClient.Authenticator.Destroy;

    FreeAndNil(FRestClient);
  End;
end;

destructor TImportaPagamentosPagarMe.Destroy;
begin
  FreeAndNil(FListaChaves);
  DestroiComponentesRequisicao;

  inherited;
end;

procedure TImportaPagamentosPagarMe.DownloadCobrancaPorId(AChaveSelecionada: TChavesPagarMe;
  ACobranca_ID: String; AiCartoes: TPagarMePgto; prgStatus: TcxProgressBar);
begin
  if Trim(ACobranca_ID).IsEmpty then
    Exit;

  PrepararHeadersRequisicao(AChaveSelecionada);

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
      AiCartoes.CodEmpresa     := AChaveSelecionada.Empresa;
      AiCartoes.ModeloAtualizado := AChaveSelecionada.ModeloAtualizado;
      AiCartoes.pAdicionaLinha(FormatarJson(FRestResponse.Content), prgStatus);
    End;
  except
    On E: Exception do
      raise Exception.Create('Problemas ao buscar cobrança por id. ' + E.Message);
  end;
end;

procedure TImportaPagamentosPagarMe.DownloadCobrancasNaoEncontradas(
  AListaCobrancas: TStringList; AChaveSelecionada: TChavesPagarMe;
  AiCartoes: TPagarMePgto; prgStatus: TcxProgressBar);
var
  LCobranca_ID: String;
begin
  if AListaCobrancas.Count < 1 then
    Exit;

  try
    If FRestClient.Authenticator <> Nil Then
      FRestClient.Authenticator.Destroy;
    FRestClient.Authenticator := THTTPBasicAuthenticator.Create(AChaveSelecionada.ApiKey,'');

    lblInform.Caption := 'Aguarde... Importando cobranças da empresa ' + AChaveSelecionada.Empresa + '.';
    Application.ProcessMessages;

    for LCobranca_ID in AListaCobrancas do
    begin
      DownloadCobrancaPorId(AChaveSelecionada, LCobranca_ID, AiCartoes, prgStatus);
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
                                                            AiCartoes: TPagarMePgto;
                                                            prgStatus: TcxProgressBar);
  Var
    LContador: Integer;

    LAutorizado: Boolean;

    LMensagem: String;
    LMsgErro : String;
    LFimDaImportacao: Boolean;
    LPagina: Integer;
Begin
  CarregaLinks(AChaveSelecionada.Empresa,AChaveSelecionada.ModeloAtualizado);
  PrepararHeadersRequisicao(AChaveSelecionada);

  LAutorizado := False;

  LContador := 0;

  While Not Autorizado(LAutorizado,LContador) Do
  Begin
    Try
      LFimDaImportacao := False;
      LPagina := 1;
      Repeat
        //Pagamentos
        TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Importando pagamentos da empresa ' + AChaveSelecionada.Empresa + '.', False);

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
          AiCartoes.CodEmpresa     := AChaveSelecionada.Empresa;
          AiCartoes.pAdicionaLinha(FRestResponse.Content,prgStatus);
          Inc(LPagina);
        End Else LFimDaImportacao := True;

      Until (LFimDaImportacao);

      LFimDaImportacao := False;
      LPagina := 1;
      Repeat
        //vendas pagas
        TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Importando vendas pagas da empresa ' + AChaveSelecionada.Empresa + '.', False);

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
          AiCartoes.CodEmpresa     := AChaveSelecionada.Empresa;
          AiCartoes.pAdicionaLinha(FRestResponse.Content,prgStatus);
          Inc(LPagina);
        End Else LFimDaImportacao := True;

      Until (LFimDaImportacao);

      LFimDaImportacao := False;
      LPagina := 1;
      Repeat
        //reembolsos
        TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Importando reembolsos da empresa ' + AChaveSelecionada.Empresa + '.', False);

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
          AiCartoes.CodEmpresa     := AChaveSelecionada.Empresa;
          AiCartoes.pAdicionaLinha(FRestResponse.Content,prgStatus);
          Inc(LPagina);
        End Else LFimDaImportacao := True;

      Until (LFimDaImportacao);

      LFimDaImportacao := False;
      LPagina := 1;
      Repeat
        //Vendas Reembolsadas
        TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Importando vendas reembolsadas da empresa ' + AChaveSelecionada.Empresa + '.', False);

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
          AiCartoes.CodEmpresa     := AChaveSelecionada.Empresa;
          AiCartoes.pAdicionaLinha(FRestResponse.Content,prgStatus);
          Inc(LPagina);
        End Else LFimDaImportacao := True;

      Until (LFimDaImportacao);

      LAutorizado := True;
    Except
      On E: Exception Do
      Begin
        If OnException(LAutorizado,LMsgErro,LContador,AChaveSelecionada,LMensagem, prgStatus) Then
          Raise Exception.Create(LMsgErro);
      End;
    End;
  End;
end;

procedure TImportaPagamentosPagarMe.DownloadDataSelecionadaAPIv5(
  AChaveSelecionada: TChavesPagarMe; ADataInicial, ADataFinal: TDateTime;
  AiCartoes: TPagarMePgto; prgStatus: TcxProgressBar);
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
  CarregaLinks(AChaveSelecionada.Empresa, AChaveSelecionada.ModeloAtualizado);

  LAutorizado := False;

  LContador := 0;

  If FRestClient.Authenticator <> Nil Then
    FRestClient.Authenticator.Destroy;
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
                          LStatus,
                          prgStatus);
      end;

      ImportarRecebiveis(TTipoDataRecebivel.tdCadastro,
                         AChaveSelecionada,
                         ADataInicial,
                         ADataFinal,
                         AiCartoes,
                         prgStatus);

      ImportarRecebiveis(TTipoDataRecebivel.tdPagamento,
                         AChaveSelecionada,
                         ADataInicial,
                         ADataFinal,
                         AiCartoes,
                         prgStatus);

      If AChaveSelecionada.ModeloAtualizado Then
      Begin
        If Date <= EncodeDate(2026, 08, 28) Then
        Begin
          TPagarMeFuncoes.fMensagem('ATENÇÃO',
                              'O endpoint de transferências da Pagar.Me só estará disponível nessa versão(v5.1), a partir de 28/08/2026.' + #13 +
                              'A importação de transferências não será executada para a empresa ' + AChaveSelecionada.Empresa + '.',
                              ['&OK']);
        End
        Else
        Begin
          ImportarTransferencias(AChaveSelecionada,
                                 ADataInicial,
                                 ADataFinal,
                                 AiCartoes,
                                 prgStatus);
        end;
      End
      Else
      Begin
        for LStatus in LStatusTransferencias do
        begin
          ImportarTransferencias(AChaveSelecionada,
                           ADataInicial,
                           ADataFinal,
                           AiCartoes,
                           prgStatus,
                           LStatus);
        end;
      End;

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
    qryDados: TUniQuery;
begin
  qryDados := Nil;
  Try
    qryDados := VS_FuncoesExternas.fICriaQuery;
    qryDados.SQL.Text := 'SELECT MAX(PGM_DTAPAG) AS DTAPAG FROM PGM_PMRECE';
    qryDados.Open;

    Result := 'Nenhuma';
    If qryDados.FieldByName('DTAPAG').AsString <> '' Then
      Result := qryDados.FieldByName('DTAPAG').AsString;
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(qryDados);
  End;
end;

function TImportaPagamentosPagarMe.GetRestResponseError: TRESTResponse;
begin
  Result := FRestResponse; // Response get registros
end;

procedure TImportaPagamentosPagarMe.ImportarCobrancas(
  AChaveSelecionada: TChavesPagarMe; ADataInicial, ADataFinal: TDateTime;
  AiCartoes: TPagarMePgto; AStatus: String; prgStatus: TcxProgressBar);
var
  LPagina: Integer;
  LFimDaImportacao: Boolean;
begin
  PrepararHeadersRequisicao(AChaveSelecionada);
  LFimDaImportacao := False;
  LPagina := 1;
  Repeat
    TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Importando cobranças da empresa ' + AChaveSelecionada.Empresa + '.', False);

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
      AiCartoes.CodEmpresa     := AChaveSelecionada.Empresa;
      AiCartoes.ModeloAtualizado := AChaveSelecionada.ModeloAtualizado;
      AiCartoes.pAdicionaLinha(FRestResponse.Content,prgStatus);
      Inc(LPagina);
    End Else LFimDaImportacao := True;

  Until (LFimDaImportacao);
end;

procedure TImportaPagamentosPagarMe.ImportarTransferencias(AChaveSelecionada: TChavesPagarMe;
                                                           ADataInicial,
                                                           ADataFinal: TDateTime;
                                                           AiCartoes: TPagarMePgto;
                                                           prgStatus: TcxProgressBar;
                                                           AStatus: String = '');
var
  LFimDaImportacao: Boolean;
  LPagina:          Integer;
begin
  PrepararHeadersRequisicao(AChaveSelecionada);

  LFimDaImportacao := False;
  LPagina := 1;
  Repeat
    TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Importando transferências da empresa ' + AChaveSelecionada.Empresa + '.', False);

    FRestClient.BaseUrl := RetornaLinkFormatadoApiTransferenciasV5(ADataInicial,
                                                                   ADataFinal,
                                                                   AChaveSelecionada.Empresa,
                                                                   LPagina.ToString,
                                                                   AChaveSelecionada.ModeloAtualizado,
                                                                   AStatus);

    FRestRequest.Execute;

    If FRestResponse.StatusCode <> 200 Then
      Raise Exception.Create(FRestResponse.Content);

    If Not (Pos('"data": []',FRestResponse.Content) > 0 ) Then
    Begin
      AiCartoes.TipoDoArquivo := 'Transferencias';
      AiCartoes.KeyApi :=  AChaveSelecionada.ApiKey;
      AiCartoes.CodEmpresa     := AChaveSelecionada.Empresa;
      AiCartoes.ModeloAtualizado := AChaveSelecionada.ModeloAtualizado;
      AiCartoes.pAdicionaLinha(FRestResponse.Content, prgStatus);
      Inc(LPagina);
    End
    Else
      LFimDaImportacao := True;

    if not LFimDaImportacao then
      Sleep(1000);

  Until (LFimDaImportacao);
end;

function TImportaPagamentosPagarMe.RetornaProximoCursor(AJsonRetorno: String): String;
var
  LJson:   TJSONObject;
  LPaging: TJSONObject;
  LValor:  TJSONValue;
begin
  Result := '';

  LJson := TJSONObject.ParseJSONValue(AJsonRetorno) as TJSONObject;
  Try
    If Assigned(LJson) And LJson.TryGetValue<TJSONObject>('paging', LPaging) And Assigned(LPaging) Then
    Begin
      LValor := LPaging.GetValue('forward_cursor');
      If Assigned(LValor) And Not (LValor Is TJSONNull) Then
        Result := LValor.Value;
    End;
  Finally
    FreeAndNil(LJson);
  End;
end;

procedure TImportaPagamentosPagarMe.ImportarRecebiveis(
  ATipoData: TTipoDataRecebivel; AChaveSelecionada: TChavesPagarMe;
  ADataInicial, ADataFinal: TDateTime; AiCartoes: TPagarMePgto;
  prgStatus: TcxProgressBar);
var
  LFimDaImportacao: Boolean;
  LPagina:          Integer;
  LCursor:          String;
begin
  PrepararHeadersRequisicao(AChaveSelecionada);

  LFimDaImportacao := False;
  LPagina := 1;
  LCursor := '';

  Repeat
    TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Importando recebíveis da empresa ' + AChaveSelecionada.Empresa + '.', False);

    If AChaveSelecionada.ModeloAtualizado Then
      FRestClient.BaseUrl := RetornarLinkFormatadoApiRecebiveisV5(FLinkRecebiveis,
                                                                  AChaveSelecionada,
                                                                  ATipoData,
                                                                  ADataInicial,
                                                                  ADataFinal,
                                                                  LCursor)
    Else
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
      AiCartoes.CodEmpresa     := AChaveSelecionada.Empresa;
      AiCartoes.ModeloAtualizado := AChaveSelecionada.ModeloAtualizado;
      AiCartoes.pAdicionaLinha(FRestResponse.Content, prgStatus);

      If AChaveSelecionada.ModeloAtualizado Then
      Begin
        LCursor := RetornaProximoCursor(FRestResponse.Content);
        LFimDaImportacao := LCursor.IsEmpty;
      End
      Else
        Inc(LPagina);
    End
    Else
      LFimDaImportacao := True;

  Until (LFimDaImportacao);
end;

procedure TImportaPagamentosPagarMe.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

function TImportaPagamentosPagarMe.OnException(var AAutorizado: Boolean;
                                  var AMsgErro: String; Var AContador: Integer;
                                  AChaveSelecionada: TChavesPagarMe;
                                  AMensagem : String; prgStatus: TcxProgressBar): Boolean;
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

  Result := Not TPagarMeFuncoes.fEmptyStr(AMsgErro);
end;

procedure TImportaPagamentosPagarMe.btnSairClick(Sender: TObject);
Begin
  frmFormularioImportacao.Close;
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
  TPagarMeFuncoes.FDadosImportacaoConfirmacao.DataInicial := edtDtaIni.Date;
  TPagarMeFuncoes.FDadosImportacaoConfirmacao.DataFinal := edtDtaFin.Date;

  If (edtDtaIni.Date >= Date) Or (edtDtaFin.Date >= Date) Then
  Begin
    TPagarMeFuncoes.fMensagem('ATENÇÃO','As datas para importação não podem ser maiores ou iguais a data atual!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date = 0) Or (edtDtaFin.Date = 0) Then
  Begin
    TPagarMeFuncoes.fMensagem('ATENÇÃO','É necessário digitar a data inicial e a data final!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date > edtDtaFin.Date) Then
  Begin
    TPagarMeFuncoes.fMensagem('ATENÇÃO','A data inicial deve ser menor que data final!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 30 Then
  Begin
    TPagarMeFuncoes.fMensagem('ATENÇÃO','A quantidade de dias do período não pode ser maior que 30!',['&OK']);
    Exit;
  End;
  If FListaChaves.Count = 0 Then
  Begin
    TPagarMeFuncoes.fMensagem('ATENÇÃO','Não existem Empresas com chaves de acesso a API configurados!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 5 Then
  Begin
    If TPagarMeFuncoes.fMensagem('ATENÇÃO','A quantidade de dias do período é maior 5 dias. ' +
                                           'A importação da Pagar.Me é feita através da Internet, dependendo da quantidade ' +
                                           'de registros a operação pode demorar. Deseja realmente continuar?',['&Sim','&Não']) = 2 Then
      Exit;
  End;

  pDisableControls(True);
  TPagarMeFuncoes.ExecutaAguarde(ProcessaDownload, 'Aguarde... Carregando chaves de autorização.');
  pDisableControls(False);
End;

procedure TImportaPagamentosPagarMe.PrepararHeadersRequisicao(AChaveSelecionada: TChavesPagarMe);
begin
  FRestRequest.Params.Clear;
  FRestRequest.Params.AddHeader('Authorization', '');
  FRestRequest.Params.AddHeader('Content-Type', 'application/json');
end;

function TImportaPagamentosPagarMe.ProcessaDownload(prgStatus: TcxProgressBar): Boolean;
  Var
    LiCartoes: ICartoesPagarMe;

    LMensagem: String;

    LChavesPagarMe: TChavesPagarMe;

    LContador: Integer;

    LOcorreuErro,
    LPararNoErro: Boolean;
    LListaIdCobrancas: TStringList;
begin
  Result := True;

  LListaIdCobrancas := Nil;
  Try
    LListaIdCobrancas := TStringList.Create;
    TPagarMeFuncoes.ValidaLibsWebService;

    LiCartoes := TPagarMePgto.Create;

    If FListaChaves.Count = 0 Then
    Begin
      TPagarMeFuncoes.fMensagem('ATENÇÃO','Não existem empresas configuradas com a chave de Autorização da Pagar.Me. Operação cancelada!',['&OK']);
      Exit;
    End;

    LOcorreuErro := False;
    LPararNoErro := False;

    LContador := 0;

    For LChavesPagarMe In FListaChaves Do
    Begin
      Inc(LContador);

      TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Efetuando download da Empresa ' + LChavesPagarMe.Empresa + '.', False);

      Try
        If LChavesPagarMe.Versao.StartsWith('v5') Then
          DownloadDataSelecionadaAPIv5(LChavesPagarMe,
                                       edtDtaIni.Date,
                                       edtDtaFin.Date,
                                       TPagarMePgto(LiCartoes),
                                       prgStatus)
        Else
          DownloadDataSelecionada(LChavesPagarMe,
                                  edtDtaIni.Date,
                                  edtDtaFin.Date,
                                  TPagarMePgto(LiCartoes),
                                  prgStatus);

        TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Gravando os lançamentos da Empresa ' + LChavesPagarMe.Empresa + '.', False);

        LiCartoes.pGravarRegistros(prgStatus);

        if LChavesPagarMe.Versao.StartsWith('v5') then
        begin
          LListaIdCobrancas := TPagarMePgto(LiCartoes).RetornarIdCobrancasNaoEncontradas(edtDtaIni.Date,
                                                                                         edtDtaFin.Date,
                                                                                         LChavesPagarMe.ApiKey);

          DownloadCobrancasNaoEncontradas(LListaIdCobrancas, LChavesPagarMe, TPagarMePgto(LiCartoes), prgStatus);
          LiCartoes.pGravarRegistros(prgStatus);
        end;


        Application.ProcessMessages;
      Except
        On E: Exception Do
        Begin
          VS_FuncoesExternas.fIRollBack;

          LOcorreuErro := True;

          If (LContador = FListaChaves.Count) Then
            TPagarMeFuncoes.fMensagem('ERRO', E.Message, ['&OK'])
          Else
            LPararNoErro := TPagarMeFuncoes.fMensagem('ERRO', E.Message + #13 +
                                                      'Deseja continuar com a importação das outras empresas?',
                                                      ['&Sim', 'Não']) = 2;
        End;
      End;

      If LPararNoErro Then
        Break;
    End;

    LMensagem := 'Nenhum registro foi importado no período selecionado!';
    FImportouVendas := TPagarMePgto(LiCartoes).ImportouRegistro;
    FImportouCobrancas := TPagarMePgto(LiCartoes).ImportouCobrancas;
    FDataInicial := edtDtaIni.Date;
    FDataFinal := edtDtaFin.Date;

    If TPagarMePgto(LiCartoes).ImportouRecebiveis Then
    Begin
      If Not LOcorreuErro Then
      Begin
        LMensagem := 'Dados importados com sucesso';

        TPagarMeFuncoes.FDadosImportacaoConfirmacao.ImportouVendas := TPagarMePgto(LiCartoes).ImportouRecebiveis;
        TPagarMeFuncoes.FDadosImportacaoConfirmacao.ImportouPagamentos := TPagarMePgto(LiCartoes).ImportouPagamento;

        LMensagem := LMensagem + '!';
        CorrigirValoresMovCar;
      End
      Else
        LMensagem := 'Registros foram importados, porém ocorrereu algum erro durante a gravação.';
    End;
    TPagarMeFuncoes.fMensagem('ATENÇÃO', LMensagem,['&OK']);

  Finally
    pDisableControls(False);
    TPagarMeFuncoes.FreeAndNilStringLists(LListaIdCobrancas);
  End;

  frmFormularioImportacao.Close;
end;

procedure TImportaPagamentosPagarMe.CorrigirValoresMovCar;
var
  LQuery: TUniQuery;
begin
  LQuery := VS_FuncoesExternas.fICriaQuery;

  Try
    try

      LQuery.SQL.Text := 'SELECT                                 ' +
                         ' 1                                     ' +
                         'FROM                                   ' +
                         ' information_schema.routines           ' +
                         'WHERE routine_name = "pAjusta_PagarMe" ' +
                         ' AND routine_type = "PROCEDURE"        ' +
                         ' AND routine_schema = DATABASE()       ';

      LQuery.Open;
      if LQuery.IsEmpty then
        Exit;

      LQuery.Close;
      LQuery.SQL.Text := 'CALL pAjusta_PagarMe()';
      LQuery.ExecSQl;
    except
      On E: Exception do
        raise Exception.Create('Ocorreram problemas ao corrigir o valor das movimentações de cartão. ' + E.message);
    end;
  Finally
    LQuery.Close;
    FreeAndNil(LQuery);
  End;
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

    LImagemVaziaConf,
    LImagemVaziaSair: TBitmap;
Begin

  frmFormularioImportacao := TForm.Create(Self);
  frmFormularioImportacao.BorderStyle  := bsSingle;
  frmFormularioImportacao.Caption      := 'Importação de Registros (Pagar.Me)';
  frmFormularioImportacao.ClientHeight := 96;
  frmFormularioImportacao.ClientWidth  := 402;
  frmFormularioImportacao.Color        := 16770261;
  frmFormularioImportacao.Position     := poScreenCenter;
  frmFormularioImportacao.BorderIcons  := [biSystemMenu];
  frmFormularioImportacao.KeyPreview   := True;
  frmFormularioImportacao.OnKeyDown    := FormOnKeyDown;
  frmFormularioImportacao.Icon := TPagarMeFuncoes.FIconeAplicacao;

  LImagemVaziaConf := TBitmap.Create;
  LImagemVaziaSair := TBitmap.Create;

  Try
    lblDtaIni := TLabel.Create(frmFormularioImportacao);
    lblDtaIni.Parent   := frmFormularioImportacao;
    lblDtaIni.Top      := 12;
    lblDtaIni.AutoSize := True;
    lblDtaIni.Caption  := 'Data Inicial:';
    lblDtaIni.Left     := Round(frmFormularioImportacao.Width / 2) - lblDtaIni.Width - 95 - 5;

    edtDtaIni := TcxDateEdit.Create(frmFormularioImportacao);
    edtDtaIni.Parent   := frmFormularioImportacao;
    edtDtaIni.Left     := lblDtaIni.Left + lblDtaIni.Width + 2;
    edtDtaIni.Top      := 8;
    edtDtaIni.Height   := 21;
    edtDtaIni.TabOrder := 0;
    edtDtaIni.Width    := 90;
    edtDtaIni.Text     := DateToStr(Yesterday);
    lblDtaFin := TLabel.Create(frmFormularioImportacao);
    lblDtaFin.Parent   := frmFormularioImportacao;
    lblDtaFin.Left     := edtDtaIni.Left + edtDtaIni.Width + 15 + 5;
    lblDtaFin.Top      := 12;
    lblDtaFin.AutoSize := True;
    lblDtaFin.Caption  := 'Data Final:';
    edtDtaIni.Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);


    edtDtaFin := TcxDateEdit.Create(frmFormularioImportacao);
    edtDtaFin.Parent   := frmFormularioImportacao;
    edtDtaFin.Left     := lblDtaFin.Left + lblDtaFin.Width + 2;
    edtDtaFin.Top      := 8;
    edtDtaFin.Height   := 21;
    edtDtaFin.TabOrder := 1;
    edtDtaFin.Width    := 90;
    edtDtaFin.Text     := DateToStr(Yesterday);
    edtDtaFin.Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);

    lblInform := TLabel.Create(frmFormularioImportacao);
    lblInform.Parent   := frmFormularioImportacao;
    lblInform.Left     := 0;
    lblInform.Top      := 42;
    lblInform.AutoSize := False;
    lblInform.Width    := frmFormularioImportacao.Width;
    lblInform.Alignment:= taCenter;
    lblInform.Caption  := 'Digite o período para realizar a importação. Última data importada: ' + fRetUltimaData;

    pnlFund := TPanel.Create(frmFormularioImportacao);
    pnlFund.Parent   := frmFormularioImportacao;
    pnlFund.Align    := alBottom;
    pnlFund.Height   := 28;
    pnlFund.Color    := clGray;
    pnlFund.TabOrder := 2;

    btnSair := TBitBtnLocked.Create(frmFormularioImportacao);
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
    btnSair.Glyph    := LImagemVaziaSair;

    btnConf := TBitBtnLocked.Create(frmFormularioImportacao);
    btnConf.Parent   := pnlFund;
    btnConf.Left     := 4;
    btnConf.Top      := 2;
    btnConf.Width    := 72;
    btnConf.Height   := 24;
    btnConf.TabOrder := 0;
    btnConf.OnClick  := btnConfClick;
    btnConf.Default  := False;
    btnConf.Caption  := '&Importar';
    btnConf.Glyph    := LImagemVaziaConf;

    frmFormularioImportacao.ShowModal;
  Finally
    FreeAndNil(LImagemVaziaConf);
    FreeAndNil(LImagemVaziaSair);

    FreeAndNil(frmFormularioImportacao);
  End;
End;

function TImportaPagamentosPagarMe.RetornaEmpresasApiV5: String;
var
  LChave: TChavesPagarMe;
begin
  Result := '';
  for LChave in FListaChaves do
  begin
    if LChave.Versao.StartsWith('v5') then
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

function TImportaPagamentosPagarMe.RetornaListaDeChavesPagarMe: TObjectList<TChavesPagarMe>;
  Var
    LDados: TUniQuery;
    LChaves: TStringList;
    LContador: Integer;
begin
  Result := TObjectList<TChavesPagarMe>.Create;

  LChaves := Nil;
  LDados := Nil;
  try
    LChaves := TStringList.Create;

    LDados := VS_FuncoesExternas.fICriaQuery;
    LDados.SQL.Text := 'SELECT SIS_VALCFG, SIS_CODEMP FROM CFGSIS ' +
                       ' WHERE SIS_CODCFG = "CFG_PGMKEY" AND      ' +
                       '       IFNULL(TRIM(SIS_VALCFG), "") <> "" ';

    {If Not TPagarMeFuncoes.fEmptyStr(edtCodigoEmpresa.Text) Then
      LDados.SQL.Add('  AND SIS_CODEMP="' + edtCodigoEmpresa.Text + '" ');}

    LDados.SQL.Add(' ORDER BY SIS_CODEMP                      ');

    LDados.Open;

    While Not LDados.Eof Do
    Begin
      LChaves.CommaText := LDados.FieldByName('SIS_VALCFG').AsString;

      for LContador := 0 to Pred(LChaves.Count) do
      begin
        Result.Add(TChavesPagarMe.Create);
        Result.Last.Empresa := LDados.FieldByName('SIS_CODEMP').AsString;
        Result.Last.ApiKey  := Trim(LChaves[LContador]);
        Result.Last.Versao  := TPagarMeFuncoes.RetornaValorCfg('CFG_PGMVER',
                                                               LDados.FieldByName('SIS_CODEMP').AsString,
                                                               'v5');
        Result.Last.ModeloAtualizado := Result.Last.Versao.Equals(C_PGM_VERSAO_ATUALIZADA);
      end;

      LDados.Next;
    End;
  finally
    TPagarMeFuncoes.FreeAndNilStringlists(LChaves);
    TPagarMeFuncoes.FreeAndNilDatasets(LDados);
  end;
end;

function TImportaPagamentosPagarMe.RetornarLinkFormatadoApiRecebiveisV5(
  ALinkOriginal: String; AChaveSelecionada: TChavesPagarMe;
  ATipoData: TTipoDataRecebivel; ADataInicial, ADataFinal: TDateTime;
  AValorPaginacao: String): String;
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

  If AChaveSelecionada.ModeloAtualizado Then
  Begin
    If Not AValorPaginacao.IsEmpty Then
      Result := Result + '&forward_cursor=' + AValorPaginacao;
  End
  Else
  Begin
    Result := Result + '&page=' + AValorPaginacao;
  End;
end;

function TImportaPagamentosPagarMe.RetornaLinkFormatadoApiTransferenciasV5(ADataInicial, ADataFinal: TDateTime;
  ACodigoEmpresa: String; APagina: String; AModeloAtualizado: Boolean; AStatus: String): String;
begin
  Result := FLinkTransferencias;

  If AModeloAtualizado Then
  Begin
    Result := StringReplace(Result, '[INICIO]', FormatDateTime('YYYY-MM-DD', ADataInicial), [rfReplaceAll]);
    Result := StringReplace(Result, '[FIM]',    FormatDateTime('YYYY-MM-DD', ADataFinal), [rfReplaceAll]);
    Result := StringReplace(Result, '[PAGINA]', APagina, [rfReplaceAll]);
  End
  Else
  Begin
    Result := StringReplace(Result, '[INICIO]', FormatDateTime('YYYY-MM-DD', ADataInicial) + 'T00:00:00', [rfReplaceAll]);
    Result := StringReplace(Result, '[FIM]',    FormatDateTime('YYYY-MM-DD', ADataFinal)   + 'T23:59:59', [rfReplaceAll]);
    Result := StringReplace(Result, '[STATUS]', AStatus, [rfReplaceAll]);
    Result := StringReplace(Result, '[PAGINA]', APagina, [rfReplaceAll]);
  End;
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
    TPagarMeFuncoes.FreeAndNilObjeto(LJSON);
  end;
end;

end.

