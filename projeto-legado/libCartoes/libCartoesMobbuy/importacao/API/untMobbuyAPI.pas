unit untMobbuyAPI;

interface

uses System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Dialogs,
     Vcl.Controls, Winapi.Windows, Vcl.Graphics, Vcl.Buttons, System.StrUtils,
     System.SysUtils, Vcl.ComCtrls, System.DateUtils, System.Generics.Collections,
     REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
     System.Json,

     BitBtnLockedIncrem, cxCalendar, IPPeerClient, Uni, cxProgressBar,

     untIMobbuyIntegracaoLibCartoes, untMobbuyAPIPgto, untTMobbuyFuncoes,
     untLibCartoesGravando;

type
  TMobbuyChaves = class
  public
    Empresa           : string;
    Estabelecimento   : string;
    ApiKey            : string;
  end;

type
  TMobbuyAPI = class(TComponent)
  private
    frmImportacaoCartoesAPI: TForm;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    memXMLDoc : TMemo;
    lblInform : TLabel;
    pnlFundo  : TPanel;

    FAplicacao: HWND;
    FConfirmaCartoes: Boolean;
    FImportouVendas: Boolean;
    FImportouPagamentos: Boolean;

    FDataInicial,
    FDataFinal: TDateTime;

    FRestClient   : TRestClient;
    FRestRequest  : TRestRequest;
    FRestResponse : TRestResponse;

    FListaChaves : TObjectList<TMobbuyChaves>;
    
    FLinkPagamentos       : string;
    FLinkVendasAnaliticas : string;

    procedure OnAfterExecute(Sender: TCustomRESTRequest);
    procedure pDisableControls(blnDisable: Boolean);
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure CriarComponentesRequisicao;
    procedure DestroiComponentesRequisicao;

    function  RetornaListaDeChavesMobbuy: TObjectList<TMobbuyChaves>;
    function  RetornaConfiguracoesIncompletas: String;
    procedure CarregaLinks(ACodigoEmpresa: String);

    function  ProcessaDownload(pgbProgresso: TcxProgressBar): Boolean;
    procedure DownloadDataSelecionada(AChave: TMobbuyChaves;
                                      ADataInicial, ADataFinal: TDateTime;
                                      AiCartoes: TMobbuyAPIPgto;
                                      var prgStatus: TcxProgressBar);

    function  MontaBodyPagamentos(const AChave: TMobbuyChaves; const AIni, AFim: TDateTime): string;
    function  MontaBodyVendasDia(const AChave: TMobbuyChaves; const ADataInicial, ADataFinal: String): string;

    function ExecutaPOST(const AEndpoint: string; const ABodyJSON: string): String;

    function fRetUltimaData: String;

    function RetornouCodigoDeErro(AResponse: String): Boolean;
    function RetornaDescricaoErro(AResponse: String): String;
  public
    property Aplicacao          : HWND read FAplicacao write FAplicacao;
    property ConfirmaCartoes    : Boolean read FConfirmaCartoes write FConfirmaCartoes;
    property ImportouVendas     : Boolean read FImportouVendas write FImportouVendas;
    property ImportouPagamentos : Boolean read FImportouPagamentos write FImportouPagamentos;
    property DataInicial        : TDateTime read FDataInicial;
    property DataFinal          : TDateTime read FDataFinal;

    constructor Create(Owner: TComponent); override;
    destructor  Destroy; override;

    procedure pSelecionaFonte;
  end;

implementation

{ TMobbuyAPI }

constructor TMobbuyAPI.Create(Owner: TComponent);
begin
  inherited;
  FListaChaves := RetornaListaDeChavesMobbuy;

  VS_ListaEstabelecimentos := TStringList.Create;

  CriarComponentesRequisicao;

  FConfirmaCartoes    := False;
  FImportouVendas     := False;
  FImportouPagamentos := False;
end;

destructor TMobbuyAPI.Destroy;
begin
  If Assigned(FListaChaves) Then
    FreeAndNil(FListaChaves);

  DestroiComponentesRequisicao;

  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  inherited;
end;

procedure TMobbuyAPI.CriarComponentesRequisicao;
begin
  FRestClient := TRestClient.Create(nil);
  FRestClient.RaiseExceptionOn500 := False;
  FRestClient.HandleRedirects := True;
  FRestClient.SynchronizedEvents := True;

  FRestResponse := TRestResponse.Create(nil);

  FRestRequest := TRestRequest.Create(nil);
  FRestRequest.Client := FRestClient;
  FRestRequest.Response := FRestResponse;
  FRestRequest.Method := rmPost;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.OnAfterExecute := OnAfterExecute;

  FRestRequest.Params.AddHeader('Content-Type', 'application/json');
  FRestRequest.Params[0].Kind := pkHTTPHEADER;
  FRestRequest.Params[0].Options := [poDoNotEncode];
end;

procedure TMobbuyAPI.DestroiComponentesRequisicao;
begin
  FreeAndNil(FRestResponse);
  FreeAndNil(FRestRequest);
  FreeAndNil(FRestClient);
end;

procedure TMobbuyAPI.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

procedure TMobbuyAPI.CarregaLinks(ACodigoEmpresa: String);
begin
  FLinkPagamentos        := 'https://acesso.semprepronto.com.br/prontoev15/rest/PagamentosM12WS';
  FLinkVendasAnaliticas  := 'https://acesso.semprepronto.com.br/prontoev15/rest/VendasAnaliticasM12WS';
end;

function TMobbuyAPI.MontaBodyPagamentos(const AChave: TMobbuyChaves; const AIni, AFim: TDateTime): string;
  Var
    LJsonObject,
    LJsonObjectValue: TJSONObject;
begin
  LJsonObject := Nil;
  try
    LJsonObject := TJSONObject.Create;
    LJsonObjectValue := TJSONObject.Create;

    LJsonObjectValue.AddPair(TJSONPair.Create('ApiKeyLoja',     TJSONString.Create(AChave.ApiKey)));
    LJsonObjectValue.AddPair(TJSONPair.Create('CpfCnpj',        TJSONString.Create(AChave.Estabelecimento)));
    LJsonObjectValue.AddPair(TJSONPair.Create('DataInicial',    TJSONString.Create(FormatDateTime('yyyymmdd', AIni))));
    LJsonObjectValue.AddPair(TJSONPair.Create('DataFinal',      TJSONString.Create(FormatDateTime('yyyymmdd', AFim))));
    LJsonObjectValue.AddPair(TJSONPair.Create('Status',         TJSONString.Create('')));
    LJsonObjectValue.AddPair(TJSONPair.Create('Lancamento',     TJSONString.Create('')));
    LJsonObjectValue.AddPair(TJSONPair.Create('ValorTotal',     TJSONNumber.Create(0)));
    LJsonObjectValue.AddPair(TJSONPair.Create('FiltroValor',    TJSONNumber.Create(0)));
    LJsonObjectValue.AddPair(TJSONPair.Create('Bandeira',       TJSONString.Create('')));
    LJsonObjectValue.AddPair(TJSONPair.Create('AgruparBandeira',TJSONBool.Create(False)));

    LJsonObject.AddPair('PagamentosM12EntradaSDT', LJsonObjectValue);
    Result := LJsonObject.ToJSON;
  finally
    TMobbuyFuncoes.FreeAndNilObjeto(LJsonObject);
  end;
end;

function TMobbuyAPI.MontaBodyVendasDia(const AChave: TMobbuyChaves;
  const ADataInicial, ADataFinal: String): string;
var
  LJsonObject,
  LEntrada: TJSONObject;
begin
  LJsonObject := Nil;
  try
    LJsonObject := TJSONObject.Create;
    LEntrada := TJSONObject.Create;

    LEntrada.AddPair('ApiKeyLoja', AChave.ApiKey);
    LEntrada.AddPair('CpfCnpj', AChave.Estabelecimento);
    LEntrada.AddPair('DataInicial', TJSONNumber.Create(TMobbuyFuncoes.fRetSomenteNumeros(ADataInicial)));
    LEntrada.AddPair('DataFinal', TJSONNumber.Create(TMobbuyFuncoes.fRetSomenteNumeros(ADataFinal)));
    LEntrada.AddPair('TipoOperacao', '');
    LEntrada.AddPair('ValorTransacao', TJSONNumber.Create(0));
    LEntrada.AddPair('FiltroValor', TJSONNumber.Create(0));
    LEntrada.AddPair('Nsu', TJSONNumber.Create(0));
    LEntrada.AddPair('Autorizacao', '');
    LEntrada.AddPair('TerminalId', '');
    LEntrada.AddPair('Bandeira', '');
    LEntrada.AddPair('AgruparBandeira', TJSONBool.Create(False));

    LJsonObject.AddPair('VendasAnaliticasM12EntradaSDT', LEntrada);

    Result := LJsonObject.ToJSON;
  finally
    TMobbuyFuncoes.FreeAndNilObjeto(LJsonObject);
  end;
end;

function TMobbuyAPI.ExecutaPOST(const AEndpoint, ABodyJSON: string): String;
begin
  FRestClient.BaseURL := AEndpoint;

  FRestRequest.Params.Clear;
  FRestRequest.Body.ClearBody;
  FRestRequest.Method := rmPOST;

  FRestRequest.AddParameter('Accept', 'application/json', pkHTTPHEADER);
  FRestRequest.AddBody(ABodyJSON, ctAPPLICATION_JSON);

  FRestRequest.Execute;

  If FRestResponse.StatusCode <> 200 Then
    Raise Exception.Create(FRestResponse.Content);

  If RetornouCodigoDeErro(FRestResponse.Content) Then
    Raise Exception.Create(RetornaDescricaoErro(FRestResponse.Content));

  Result := FRestResponse.Content;
end;


procedure TMobbuyAPI.DownloadDataSelecionada(AChave: TMobbuyChaves;
  ADataInicial, ADataFinal: TDateTime; AiCartoes: TMobbuyAPIPgto;
  var prgStatus: TcxProgressBar);
var
  LDia,
  LDataFinal,
  LBody,
  LResponse: string;

  LData: TDateTime;
begin
  AiCartoes.LimparRegistros;
  CarregaLinks(AChave.Empresa);

  // PAGAMENTOS
  lblInform.Caption := 'Importando pagamentos do estabelecimento ' + AChave.Estabelecimento +
                       ' da empresa ' + AChave.Empresa + '.';
  untLibCartoesGravando.pInformacao(lblInform.Caption, prgStatus);

  LBody := MontaBodyPagamentos(AChave, ADataInicial, ADataFinal);
  LResponse := ExecutaPOST(FLinkPagamentos, LBody);

  AiCartoes.EstabelecimentoAtual := AChave.Estabelecimento;
  AiCartoes.TipoDoArquivo := 'PAGAMENTOS';
  AiCartoes.pAdicionaLinha(LResponse, prgStatus);

  LData := ADataInicial;
  While LData <= ADataFinal Do
  Begin
    AiCartoes.ListaDatasVendas.Add(FormatDateTime('yyyy-mm-dd', LData));

    LData := IncDay(LData);
  End;

  For LDia In AiCartoes.ListaDatasVendas do
  begin
    lblInform.Caption := Format('Importando vendas (%s) do estabelecimento %s da empresa %s.',
                                [RightStr(LDia, 2) + '/' + Copy(LDia, 6, 2) + '/' + LeftStr(LDia, 4), AChave.Estabelecimento, AChave.Empresa]);
    untLibCartoesGravando.pInformacao(lblInform.Caption, prgStatus);

    LDataFinal := LDia;
    If LDia = FormatDateTime('yyyy-mm-dd', ADataInicial) Then
      LDataFinal := FormatDateTime('yyyy-mm-dd', ADataFinal);

    LBody := MontaBodyVendasDia(AChave, LDia, LDataFinal);
    LResponse := ExecutaPOST(FLinkVendasAnaliticas, LBody);

    AiCartoes.EstabelecimentoAtual := AChave.Estabelecimento;
    AiCartoes.TipoDoArquivo := 'VENDAS';
    AiCartoes.pAdicionaLinha(LResponse, prgStatus);

    If Not LDia.Equals(LDataFinal) Then
      Break;
  end;

end;

function TMobbuyAPI.RetornaConfiguracoesIncompletas: String;
  Var
    LChaves: TMobbuyChaves;
begin
  Result := EmptyStr;

  For LChaves In FListaChaves Do
  Begin
    If LChaves.ApiKey.IsEmpty And (Pos('Empresa ' + LChaves.Empresa + ': CFG_MOBKEY', Result) = 0) Then
      Result := Result + #13 + '- Empresa ' + LChaves.Empresa + ': CFG_MOBKEY não preenchida.';

    If (Not (Length(LChaves.Estabelecimento) In [11, 14])) Or
       (TMobbuyFuncoes.fRetSomenteNumeros(LChaves.Estabelecimento) <> LChaves.Estabelecimento) Then
      Result := Result + #13 + '- Empresa ' + LChaves.Empresa + ': CFG_MOBEST deve ser o CNPJ do lojista, ' +
                               'somente números (informado: ' + LChaves.Estabelecimento + ').';
  End;
end;

function TMobbuyAPI.RetornaDescricaoErro(AResponse: String): String;
  Var
    LJsonValue: TJSONValue;
    LJsonObject: TJsonObject;

    LCodigoRetorno,
    LDescricao: String;
begin
  Result := AResponse;

  LJsonValue := Nil;

  Try
    LJsonValue := TJSONObject.ParseJSONValue(AResponse);

    If Not (LJsonValue Is TJSONObject) Then
      Exit;

    LJsonObject := TJSONObject(LJsonValue);

    LCodigoRetorno := EmptyStr;
    If LJsonObject.GetValue('ret_cod') <> Nil Then
    Begin
      LCodigoRetorno := LJsonObject.GetValue<String>('ret_cod');
      LDescricao := LJsonObject.GetValue<String>('ret_dsc');
    End;

    If LJsonObject.GetValue('ErroCod') <> Nil Then
    Begin
      LCodigoRetorno := LJsonObject.GetValue<String>('ErroCod');
      LDescricao := LJsonObject.GetValue<String>('ErroDesc');
    End;


    If LCodigoRetorno.IsEmpty Then
      Exit
    Else If LCodigoRetorno.Equals('1') Then
      Exit('Falha na autenticação com o servidor Sempre Pronto.' + #13 +
           'Por favor, verifique as configurações de "ApiKey" e "Estabelecimento" no Autcom.' + #13 +
           'Se o erro persistir, entre em contato com o suporte da Sempre Pronto.')
    Else
      Result := LDescricao;

    If Result.IsEmpty Then
      Exit(AResponse);
  Finally
    If Assigned(LJsonValue) Then
      FreeAndNil(LJsonValue);
  End;
end;

function TMobbuyAPI.RetornaListaDeChavesMobbuy: TObjectList<TMobbuyChaves>;
var
  LDados : TUniQuery;
  LChaves: TMobbuyChaves;
  LListaEstabelecimentos: TStringList;
  LEmpresa, LEstab: string;
begin
  Result := TObjectList<TMobbuyChaves>.Create;

  LListaEstabelecimentos := Nil;
  LDados := Nil;
  try
    LListaEstabelecimentos := TStringList.Create;
    LListaEstabelecimentos.Delimiter := ',';
    LListaEstabelecimentos.StrictDelimiter := True;

    LDados := VS_FuncoesExternas.fICriaQuery;
    LDados.SQL.Text :=
      'SELECT SIS_CODEMP '+
      '  FROM CFGSIS '+
      ' WHERE SIS_CODCFG = "CFG_MOBEST" '+
      '   AND SIS_VALCFG IS NOT NULL '+
      '   AND TRIM(SIS_VALCFG) <> "" '+
      ' GROUP BY SIS_CODEMP '+
      ' ORDER BY SIS_CODEMP';
    LDados.Open;

    while not LDados.Eof do
    begin
      LEmpresa := LDados.FieldByName('SIS_CODEMP').AsString;

      LListaEstabelecimentos.DelimitedText :=
        TMobbuyFuncoes.fRetornaValorConfiguracao('CFG_MOBEST', LEmpresa);

      if not LListaEstabelecimentos.DelimitedText.IsEmpty then
      begin
        for LEstab in LListaEstabelecimentos do
        begin
          LChaves := TMobbuyChaves.Create;
          LChaves.Empresa          := LEmpresa;
          LChaves.Estabelecimento  := Trim(LEstab);
          LChaves.ApiKey           := Trim(TMobbuyFuncoes.fRetornaValorConfiguracao('CFG_MOBKEY', LEmpresa));

          Result.Add(LChaves);
        end;
      end;

      LDados.Next;
    end;

  finally
    TMobbuyFuncoes.FreeAndNilDatasets(LDados);

    If Assigned(LListaEstabelecimentos) Then
      FreeAndNil(LListaEstabelecimentos);
  end;
end;


function TMobbuyAPI.RetornouCodigoDeErro(AResponse: String): Boolean;
  Var
    LJsonValue: TJSONValue;
    LJsonObject: TJsonObject;
begin
  Result := False;

  LJsonValue := Nil;

  Try
    LJsonValue := TJSONObject.ParseJSONValue(AResponse);

    If Not (LJsonValue Is TJSONObject) Then
      Exit(True);

    LJsonObject := TJSONObject(LJsonValue);

    If LJsonObject.GetValue('ret_cod') <> Nil Then
      Exit(Not MatchStr(LJsonObject.GetValue<String>('ret_cod'), ['0', '5']));

    If LJsonObject.GetValue('ErroCod') <> Nil Then
      Exit(Not MatchStr(LJsonObject.GetValue<String>('ErroCod'), ['0', '8', '11', '12']));
  Finally
    If Assigned(LJsonValue) Then
      FreeAndNil(LJsonValue);
  End;
end;

function TMobbuyAPI.fRetUltimaData: String;
var
  LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT MAX(MOB_DTAPAG) AS DTAPAG FROM MOB_APPGTO';
    LConsulta.Open;
    Result := 'Nenhuma';
    if LConsulta.FieldByName('DTAPAG').AsString <> '' then
      Result := LConsulta.FieldByName('DTAPAG').AsString;
  finally
    TMobbuyFuncoes.FreeAndNilDatasets(LConsulta);
  end;
end;

procedure TMobbuyAPI.btnSairClick(Sender: TObject);
begin
  frmImportacaoCartoesAPI.Close;
end;

procedure TMobbuyAPI.FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    TForm(Sender).Perform(40, 0, 0);
end;

procedure TMobbuyAPI.pDisableControls(blnDisable: Boolean);
begin
  pnlFundo.Enabled := not blnDisable;
  edtDtaIni.Enabled := not blnDisable;
  edtDtaFin.Enabled := not blnDisable;
end;

procedure TMobbuyAPI.btnConfClick(Sender: TObject);
  Var
    LConfiguracoesIncompletas: String;
begin
  if (edtDtaIni.Date > Date) or (edtDtaFin.Date > Date) then
  begin
    TMobbuyFuncoes.fMensagem('ATENÇÃO', 'As datas não podem ser maiores que hoje!', ['&OK']);
    Exit;
  end;

  if (edtDtaIni.Date = 0) or (edtDtaFin.Date = 0) then
  begin
    TMobbuyFuncoes.fMensagem('ATENÇÃO', 'Informe data inicial e final!', ['&OK']);
    Exit;
  end;

  if (edtDtaIni.Date > edtDtaFin.Date) then
  begin
    TMobbuyFuncoes.fMensagem('ATENÇÃO', 'A data inicial deve ser menor/igual à final!', ['&OK']);
    Exit;
  end;

  if (edtDtaFin.Date - edtDtaIni.Date) > 30 then
  begin
    TMobbuyFuncoes.fMensagem('ATENÇÃO','Período não pode ultrapassar 30 dias!',['&OK']);
    Exit;
  end;

  if FListaChaves.Count = 0 then
  begin
    TMobbuyFuncoes.fMensagem('ATENÇÃO','Não há ECs configurados p/ Sempre Pronto!',['&OK']);
    Exit;
  end;

  LConfiguracoesIncompletas := RetornaConfiguracoesIncompletas;
  if not LConfiguracoesIncompletas.IsEmpty then
  begin
    TMobbuyFuncoes.fMensagem('ATENÇÃO', 'As configurações da Sempre Pronto estão incompletas:' + #13 +
                                        LConfiguracoesIncompletas + #13#13 +
                                        'Corrija em Útil > Configuração do Sistema e tente novamente.', ['&OK']);
    Exit;
  end;

  if (edtDtaFin.Date - edtDtaIni.Date) > 5 then
  begin
    if TMobbuyFuncoes.fMensagem('ATENÇÃO', 'Período acima de 5 dias. A importação via Internet pode demorar. Continuar?',
                                          ['&Sim','&Não']) = 2 then
      Exit;
  end;

  try
    pDisableControls(True);
    TMobbuyFuncoes.ExecutaAguarde(ProcessaDownload, 'Aguarde... Importando registros Sempre Pronto.');
  finally
    pDisableControls(False);
  end;
end;

function TMobbuyAPI.ProcessaDownload(pgbProgresso: TcxProgressBar): Boolean;
var
  LiCartoes : ICartoes;
  LMensagem: string;
  LChaves  : TMobbuyChaves;
  LContador: Integer;
  LOcorreuErro, LPararNoErro: Boolean;
begin
  try
    TMobbuyFuncoes.ValidaLibsWebService;

    LiCartoes := TMobbuyAPIPgto.Create;

    if FListaChaves.Count = 0 then
    begin
      TMobbuyFuncoes.fMensagem('ATENÇÃO','Não existem ECs configurados para Sempre Pronto. Operação cancelada!',['&OK']);
      Exit(False);
    end;

    LOcorreuErro := False;
    LPararNoErro := False;
    LContador := 0;

    for LChaves in FListaChaves do
    begin
      Inc(LContador);

      lblInform.Caption := 'Aguarde... Efetuando download da Empresa ' + LChaves.Empresa;
      untLibCartoesGravando.pInformacao(lblInform.Caption, pgbProgresso);
      Application.ProcessMessages;

      try
        DownloadDataSelecionada(LChaves,
                                edtDtaIni.Date,
                                edtDtaFin.Date,
                                TMobbuyAPIPgto(LiCartoes),
                                pgbProgresso);

        lblInform.Caption := 'Aguarde... Gravando os lançamentos da Empresa ' + LChaves.Empresa;
        untLibCartoesGravando.pInformacao(lblInform.Caption, pgbProgresso);

        LiCartoes.pGravarRegistros(pgbProgresso);

        Application.ProcessMessages;
      except
        on E: Exception do
        begin
          LOcorreuErro := True;
          if (LContador = FListaChaves.Count) then
            TMobbuyFuncoes.fMensagem('ERRO', E.Message, ['&OK'])
          else
            LPararNoErro := TMobbuyFuncoes.fMensagem('ERRO', E.Message + #13 +
                                                          'Deseja continuar com a importação das outras empresas?',
                                                          ['&Sim', 'Não']) = 2;
        end;
      end;

      if LPararNoErro then Break;
    end;

    LMensagem := 'Nenhum registro foi importado no período selecionado!';
    if (TMobbuyAPIPgto(LiCartoes).ImportouRegistro) then
    begin
      if not LOcorreuErro then
      begin
        LMensagem := 'Dados importados com sucesso';
        if (not TMobbuyAPIPgto(LiCartoes).ImportouPagamento) and (TMobbuyAPIPgto(LiCartoes).ImportouVendas) then
          LMensagem := LMensagem + ', porém não há pagamentos no período selecionado'
        else if (not TMobbuyAPIPgto(LiCartoes).ImportouVendas) and (TMobbuyAPIPgto(LiCartoes).ImportouPagamento) then
          LMensagem := LMensagem + ', porém não há vendas no período selecionado'
        else if (not TMobbuyAPIPgto(LiCartoes).ImportouVendas) and (not TMobbuyAPIPgto(LiCartoes).ImportouPagamento) then
          LMensagem := LMensagem + ', porém não há pagamentos e vendas no período selecionado';

        FImportouVendas     := TMobbuyAPIPgto(LiCartoes).ImportouVendas;
        FImportouPagamentos := TMobbuyAPIPgto(LiCartoes).ImportouPagamento;

        LMensagem := LMensagem + '!';
      end
      else
        LMensagem := 'Registros foram importados, porém ocorreu algum erro durante a importação.';
    end;

    TMobbuyFuncoes.fMensagem('ATENÇÃO', LMensagem, ['&OK']);
  finally
    Result := True;
    pDisableControls(False);
  end;

  frmImportacaoCartoesAPI.Close;
end;

procedure TMobbuyAPI.pSelecionaFonte;
 Var
    lblDtaIni,
    lblDtaFin: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;

    LImagemVaziaConf,
    LImagemVaziaSair: TBitmap;
Begin
  frmImportacaoCartoesAPI := TForm.Create(Self);
  Try
    frmImportacaoCartoesAPI.BorderStyle  := bsSingle;
    frmImportacaoCartoesAPI.Caption      := 'Importação de Registros (Sempre Pronto Online)';
    frmImportacaoCartoesAPI.ClientHeight := 102;
    frmImportacaoCartoesAPI.ClientWidth  := 402;
    frmImportacaoCartoesAPI.Color        := 16770261;
    frmImportacaoCartoesAPI.Position     := poScreenCenter;
    frmImportacaoCartoesAPI.BorderIcons  := [biSystemMenu];
    frmImportacaoCartoesAPI.KeyPreview   := True;
    frmImportacaoCartoesAPI.OnKeyDown    := FormOnKeyDown;
    frmImportacaoCartoesAPI.Icon := TMobbuyFuncoes.FIconeAplicacao;

    LImagemVaziaConf := TBitmap.Create;
    LImagemVaziaSair := TBitmap.Create;

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
end;

end.

