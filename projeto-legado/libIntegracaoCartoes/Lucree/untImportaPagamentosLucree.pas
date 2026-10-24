{*****************************************************}
{* Importação de arquivos com RESTClient da Lucree     *}
{**************************************************MT*}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{****************************************MT*}
unit untImportaPagamentosLucree;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Vcl.Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  ComCtrls, cxCalendar, IPPeerClient, DateUtils, System.Generics.Collections,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Json, untLucreePgto, REST.Authenticator.Basic,IdHTTP,IdSSLOpenSSL,IdComponent;

Type
  TChavesLucree = class
  private
  public
    Empresa,
    UserName,
    Password,
    Token,
    status,
    msg:String;

    Expiracao: Integer;
    RefreshTime: TTime;
  end;


Type
  TImportaPagamentosLucree = Class(TComponent)
  Private
    frmForm   : TForm;
    pgbProg   : TProgressBar;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    memXMLDoc : TMemo;
    lblInform : TLabel;
    pnlFund   : TPanel;

    FAplicacao: HWND;

    FListaChaves: TList<TChavesLucree>;

    FLinkAutenticacao,
    FLinkPagamentos,
    FAmbiente: String;

    procedure OnAfterExecute(Sender: TCustomRESTRequest);

    procedure pDisableControls(blnDisable: Boolean);
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function fRetUltimaData: String;

    function RetornaListaDeChavesLucree: TList<TChavesLucree>;

    procedure CriarComponentesRequisicao;
    procedure DestroiComponentesRequisicao;
    procedure ProcessaDownload;
    procedure DownloadDataSelecionada(AChaveSelecionada: TChavesLucree;
                                      ADataInicial,
                                      ADataFinal: TDateTime;
                                      AiCartoes: TLucreePgto);

    procedure GetToken(var AChaveAtual: TChavesLucree);
 
    procedure CarregaLinks;

    function RetornaLinkFormatado(ALinkOriginal: String;
                                  AChaveSelecionada: TChavesLucree;
                                  ADataInicial,
                                  ADataFinal: TDateTime;
                                  ADadosPagina: String): String;

    function OnException(Var AAutorizado: Boolean; Var AMsgErro :String;
                         Var AContador: Integer; AChaveSelecionada: TChavesLucree;
                             AMensagem: String): Boolean;

    function Autorizado(AAutorizado: Boolean;AContador: Integer):Boolean;
    function GetRestResponseError: TRestResponse;

  Public
    property Aplicacao: HWND read FAplicacao write FAplicacao;
    procedure pSelecionaFonte;

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

{ TImportaPagamentosLucree }

function TrataObjeto(jObj:TJSONObject; value:String):string;
var i:integer;
   jPar: TJSONPair;
begin
    result := '';
    for i := 0 to jObj.Count - 1 do
    begin
         jPar := jObj.Pairs[i];
         if jPar.JsonValue Is TJSONObject then
            result := TrataObjeto((jPar.JsonValue As TJSONObject),value) else
         if sametext(trim(jPar.JsonString.Value),value) then
         begin
              Result := jPar.JsonValue.Value;
              break;
         end;
         if result <> '' then
            break;
    end;
end;

function getCamposJsonString(json,value:String): String;
var
   LJSONObject: TJSONObject;

begin
   LJSONObject := nil;
   try
      LJSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(json),0) as TJSONObject;
      result := TrataObjeto(LJSONObject,Value);
   finally
      LJSONObject.Free;
   end;
end;

procedure TImportaPagamentosLucree.CarregaLinks;
begin

  FLinkAutenticacao := 'https://api.lucree.com.br/autenticacao/v1';

  FLinkPagamentos := 'https://transacoes-publica.lucree.com.br/recebimentos-cliente?'+
  'init_date=[INICIO]&end_date=[FIM]&page=[PAGINA]&items=500';



  FAmbiente := 'PRODUÇÃO';

end;

constructor TImportaPagamentosLucree.Create(Owner: TComponent);
begin
  inherited;
  FListaChaves := RetornaListaDeChavesLucree;
  CriarComponentesRequisicao;
end;

procedure TImportaPagamentosLucree.CriarComponentesRequisicao;
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
  FRestRequest.Params[0].Kind := pkHTTPHEADER;
  FRestRequest.Params[0].Options := [poDoNotEncode];
  FRestRequest.Params[1].Kind := pkHTTPHEADER;
  FRestRequest.Params[1].Options := [poDoNotEncode];
end;

procedure TImportaPagamentosLucree.DestroiComponentesRequisicao;
begin
  FreeAndNil(FRestResponse);
  FreeAndNil(FRestRequest);
  FreeAndNil(FRestClient);
end;

destructor TImportaPagamentosLucree.Destroy;
begin
  inherited;
  FreeAndNil(FListaChaves);
  DestroiComponentesRequisicao;
end;

procedure TImportaPagamentosLucree.DownloadDataSelecionada(AChaveSelecionada: TChavesLucree;
                                                         ADataInicial,
                                                         ADataFinal: TDateTime;
                                                         AiCartoes: TLucreePgto);
  Var
    LContador: Integer;

    LAutorizado: Boolean;

    LMensagem: String;
    LPaginas: String;
    PaginaAtual:Integer;
    LMsgErro : String;
Begin
  LAutorizado := False;

  LContador   := 0;
  LPaginas    := '0';
  PaginaAtual := -1;
  While Not Autorizado(LAutorizado,LContador) Do
  Begin
    Try
      GetToken(AChaveSelecionada);
     Repeat
          //Pagamentos
          Inc(PaginaAtual);
          lblInform.Caption := 'Aguarde... Importando pagamentos da empresa ' + AChaveSelecionada.Empresa + '.';
          Application.ProcessMessages;

          FRestClient.BaseUrl := RetornaLinkFormatado(FLinkPagamentos,
                                                      AChaveSelecionada,
                                                      ADataInicial,
                                                      ADataFinal,
                                                      IntToStr(PaginaAtual));

          FRestRequest.Params[0].Value := AChaveSelecionada.Token;
          FRestRequest.Execute;


          If FRestResponse.StatusCode <> 200 Then
            Raise Exception.Create(FRestResponse.Content);

          AiCartoes.TipoDoArquivo := 'PAGAMENTOS';
          AiCartoes.pAdicionaLinha(FRestResponse.Content);

          LPaginas   := AiCartoes.Paginas;
      Until (LPaginas.Equals(IntToStr(PaginaAtual)));

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

procedure TImportaPagamentosLucree.FormOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
    TForm(Sender).Perform(40,0,0);
end;

function TImportaPagamentosLucree.fRetUltimaData: String;
  Var
    qryDados: IDataSet;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.SQL := 'SELECT MAX(LUC_DTAEFE) AS DTAPAG FROM LUC_LUPGTO';
  qryDados.Open;

  Result := 'Nenhuma';
  If qryDados.FieldByName('DTAPAG').AsString <> '' Then
    Result := qryDados.FieldByName('DTAPAG').AsString;
end;


function TImportaPagamentosLucree.GetRestResponseError: TRestResponse;
begin
  Result := FRestResponse; // Response get registros
end;

procedure TImportaPagamentosLucree.GetToken(var AChaveAtual: TChavesLucree);
var
  LIncMinute : Integer;
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JsonBody: TJSONObject;
begin
  Try
    Try
      If (AChaveAtual.RefreshTime >= fTime()) Then
        Exit;

      CarregaLinks;

      RESTClient   := TRESTClient.Create(nil);
      RESTRequest  := TRESTRequest.Create(nil);
      RESTResponse := TRESTResponse.Create(nil);

      RESTRequest.Client   := RESTClient;
      RESTRequest.Response := RESTResponse;
      RESTRequest.Method   := TRESTRequestMethod.rmPOST;

      RESTClient.BaseURL   := FLinkAutenticacao;

      JsonBody := TJSONObject.Create;
      JsonBody.AddPair('username', AChaveAtual.UserName);
      JsonBody.AddPair('password', AChaveAtual.Password);
      JsonBody.ToString;

      RESTRequest.AddBody(JsonBody);
      RESTRequest.Execute;

    Except

      On E:EIdHTTPProtocolException Do
      Begin
       Raise Exception.Create(E.ErrorMessage);
      End;

      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally

   AChaveAtual.Token   :=getCamposJsonString(RESTResponse.Content,'id_token');
   AChaveAtual.status  :=getCamposJsonString(RESTResponse.Content,'status');
   AChaveAtual.msg     :=getCamposJsonString(RESTResponse.Content,'msg');

   if (AChaveAtual.status='fail') and (AChaveAtual.msg='The username or password is incorrect') Then
   AChaveAtual.msg:='Usuário ou senha incorretos.';


   LIncMinute := Round(AChaveAtual.Expiracao/60);
   LIncMinute := (LIncMinute - 1);
   AChaveAtual.RefreshTime := IncMinute(fTime(), LIncMinute);
   FreeAndNil(RESTClient);
   FreeAndNil(RESTRequest);
   FreeAndNil(RESTResponse);
  End;

end;

procedure TImportaPagamentosLucree.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

function TImportaPagamentosLucree.OnException(var AAutorizado: Boolean;
                                  var AMsgErro: String; Var AContador: Integer;
                                  AChaveSelecionada: TChavesLucree; AMensagem : String): Boolean;
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
      AMsgErro :='Ocorreu um erro ao conectar-se ao serviço da Lucree.' + #13 +
                             'Tente novamente mais tarde!' + #13 +
                             'Código do erro: ' + GetRestResponseError.StatusCode.ToString + '-' +
                                                  GetRestResponseError.StatusText;

      Case GetRestResponseError.StatusCode Of
        0  :  AMsgErro := 'Chaves de autorização incorretas ou não liberada utilização no ambiente de ' + FAmbiente + '!' + #13 +
                          'Empresa: ' +  AChaveSelecionada.Empresa + '.';

        503 : AMsgErro := 'O serviço da Lucree está com problemas no funcionamento. Tente novamente mais tarde!' + #13 +
                           AMensagem + #13 +
                           'Erro código 503.';

        500 : AMsgErro :='Ocorreu um erro interno no serviço da Lucree. ' + AMensagem + #13 +
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

  if (AChaveSelecionada.status='fail') and (AChaveSelecionada.msg='Usuário ou senha incorretos') Then
    AMsgErro:='Usuário ou senha incorretos.';

end;


procedure TImportaPagamentosLucree.btnSairClick(Sender: TObject);
Begin
  frmForm.Close;
End;

function TImportaPagamentosLucree.Autorizado(AAutorizado: Boolean; AContador: Integer): Boolean;
begin
  Result := True;

  If Not AAutorizado Then // Não fui autorizado a importar pela api ainda ?
  Begin
    If AContador <= 5 Then Result := False; // continuo tentando importar até 5x
  End;

end;

procedure TImportaPagamentosLucree.btnConfClick(Sender: TObject);
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
    objFunctions.fIMensagem('ATENÇÃO','Não existem Pontos de Vendas com chaves de acesso a API configurados!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 5 Then
  Begin
    If objFunctions.fIMensagem('','A quantidade de dias do período é maior 5 dias. ' +
                                  'A importação da Lucree é feita através da Internet, dependendo da quantidade ' +
                                  'de registros a operação pode demorar. Deseja realmente continuar?',['&Sim','&Não']) = 2 Then
      Exit;
  End;

  pDisableControls(True);
  ProcessaDownload;
  pDisableControls(False);
End;

procedure TImportaPagamentosLucree.ProcessaDownload;
  Var
    LiCartoes: TLucreePgto;

    LMensagem: String;

    LChavesLucree: TChavesLucree;

    LContador: Integer;

    LOcorreuErro,
    LPararNoErro: Boolean;
begin
  Try
    pValidaLibsWebService;

    LiCartoes := TLucreePgto.Create;

    If FListaChaves.Count = 0 Then
    Begin
      objFunctions.fIMensagem('ATENÇÃO','Não existem empresas configuradas com a chave de Autorização da Lucree. Operação cancelada!',['&OK']);
      Exit;
    End;

    LOcorreuErro := False;
    LPararNoErro := False;

    LContador := 0;

    For LChavesLucree In FListaChaves Do
    Begin
      Inc(LContador);

      lblInform.Caption := 'Aguarde... Efetuando download da Empresa ' + LChavesLucree.Empresa;
      Application.ProcessMessages;

      Try
        DownloadDataSelecionada(LChavesLucree,
                                edtDtaIni.Date,
                                edtDtaFin.Date,
                                LiCartoes);



        lblInform.Caption := 'Aguarde... Gravando os lançamentos da Empresa ' + LChavesLucree.Empresa;
        Application.ProcessMessages;

        LiCartoes.pGravarRegistros(pgbProg);

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
    If TLucreePgto(LiCartoes).ImportouRegistro Then
    Begin
      If Not LOcorreuErro Then
      Begin
        LMensagem := 'Dados importados com sucesso';
        If Not TLucreePgto(LiCartoes).ImportouPagamento Then
          LMensagem := LMensagem + ', porém não possui registros de pagamentos no período selecionado';

        LMensagem := LMensagem + '!';
      End
      Else
        LMensagem := 'Registros foram importados, porém ocorrereu algum erro durante a importação.';
    End;
    objFunctions.fIMensagem('ATENÇÃO', LMensagem,['&OK']);

  Finally
    pDisableControls(False);
  End;

  frmForm.Close;
end;

procedure TImportaPagamentosLucree.pDisableControls(blnDisable: Boolean);
begin
  pnlFund.Enabled    := not blnDisable;
  edtDtaIni.Enabled  := not blnDisable;
  edtDtaFin.Enabled  := not blnDisable;
end;

procedure TImportaPagamentosLucree.pSelecionaFonte;
  Var
    lblDtaIni,
    lblDtaFin: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;
Begin

  frmForm := TForm.Create(Self);

  frmForm.BorderStyle  := bsSingle;
  frmForm.Caption      := 'Importação de Registros (Lucree API)';
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

  FreeAndNil(frmForm);

End;


function TImportaPagamentosLucree.RetornaLinkFormatado(ALinkOriginal: String;
  AChaveSelecionada: TChavesLucree; ADataInicial, ADataFinal: TDateTime;
  ADadosPagina: String): String;
begin
  Result := StringReplace(ALinkOriginal, '[INICIO]', FormatDateTime('yyyy-mm-dd', edtDtaIni.Date), [rfReplaceAll]);
  Result := StringReplace(Result, '[FIM]', FormatDateTime('yyyy-mm-dd', edtDtaFin.Date), [rfReplaceAll]);
  Result := StringReplace(Result, '[PAGINA]', ADadosPagina, [rfReplaceAll]);

end;

function TImportaPagamentosLucree.RetornaListaDeChavesLucree: TList<TChavesLucree>;
  Var
    LDados: IDataset;

    LChavesLucree: TChavesLucree;
begin
  Result := TList<TChavesLucree>.Create;

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := 'SELECT SIS_VALCFG, SIS_CODEMP FROM CFGSIS          ' +
                ' WHERE SIS_CODCFG IN("CFG_LUCUSU") AND ' +
                ' SIS_VALCFG IS NOT NULL AND TRIM(SIS_VALCFG) <> "" ' +
                ' ORDER BY SIS_CODEMP                               ';

  LDados.Open;

  While Not LDados.Eof Do
  Begin
    LChavesLucree            := TChavesLucree.Create;
    LChavesLucree.Empresa    := LDados.FieldByName('SIS_CODEMP').AsString;
    LChavesLucree.UserName   := fRetornaValorConfiguracao('CFG_LUCUSU', LDados.FieldByName('SIS_CODEMP').AsString);
    LChavesLucree.Password   := fRetornaValorConfiguracao('CFG_LUCSEN', LDados.FieldByName('SIS_CODEMP').AsString);
    Result.Add(LChavesLucree);
    LDados.Next;
  End;
end;

end.

