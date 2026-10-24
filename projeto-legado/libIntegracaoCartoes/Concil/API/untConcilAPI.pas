{******************************************************}
{* Importação de arquivos com RESTClient da Concil *}
{***************************************************MT*}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{****************************************MT*}
unit untConcilAPI;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Vcl.Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  ComCtrls, cxCalendar, IPPeerClient, DateUtils, System.Generics.Collections,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Json, untConcilAPIPgto,System.NetEncoding;

Type
  TChavesConcil = class
  private
  public
    Empresa,
    Estabelecimento,
    ApiKey,
    Pfj : String;
  end;

Type
  TConcilAPI = Class(TComponent)
  Private
    frmForm   : TForm;
    pgbProg   : TProgressBar;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    memXMLDoc : TMemo;
    lblInform : TLabel;
    pnlFund   : TPanel;

    FAplicacao: HWND;

    FListaChaves: TList<TChavesConcil>;

    FLinkPagamentos,
    FLinkAjustes,
    FAmbiente: String;

    procedure OnAfterExecute(Sender: TCustomRESTRequest);

    procedure pDisableControls(blnDisable: Boolean);
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function fRetUltimaData: String;

    function RetornaListaDeChavesConcil: TList<TChavesConcil>;

    procedure CriarComponentesRequisicao;
    procedure DestroiComponentesRequisicao;
    procedure ProcessaDownload;
    procedure DownloadDataSelecionada(AChaveSelecionada: TChavesConcil;
                                      ADataPagamento: TDateTime;
                                      AiCartoes: TConcilAPIPgto);

    procedure CarregaLinks(ACodEmp:String);

    function RetornaLinkFormatado(ALinkOriginal: String;
                                  ADataPagmento: TDateTime;
                                  APagina: String): String;

    function OnException(Var AAutorizado: Boolean; Var AMsgErro :String;
                           Var AContador: Integer; AChaveSelecionada: TChavesConcil;
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

  End;

implementation

uses untFuncoes, untIDataSet;

{ TConcilAPI }

procedure TConcilAPI.CarregaLinks(ACodEmp:String);
begin
  FLinkPagamentos := 'https://api.concilcard.com/v2/received?searchDate=[DATA_PAGAMENTO]&offset=[NUMERO_PAGINA]'+
                     '&limit=1000&status=CONCILIADO ';

  FLinkAjustes := 'https://api.concilcartoes.com.br/v2/adjustment?searchDate=[DATA_PAGAMENTO]&offset=[NUMERO_PAGINA]&limit=1000';

  FAmbiente := 'PRODUÇÃO';

  If (fRetornaValorConfiguracao('CFG_CONHOM', ACodEmp)= 'S') Then
  Begin
    FLinkPagamentos := 'https://api.concilcartoes.com.br/v2/mock/received?searchDate=[DATA_PAGAMENTO]&offset=[NUMERO_PAGINA]'+
                       '&limit=1000&status=CONCILIADO ';

    FLinkAjustes := 'https://api.concilcartoes.com.br/v2/mock/adjustment?searchDate=[DATA_PAGAMENTO]&offset=[NUMERO_PAGINA]&limit=1000';


    FAmbiente := 'HOMOLOGAÇÃO';
  End;

end;

constructor TConcilAPI.Create(Owner: TComponent);
begin
  inherited;
  FListaChaves := RetornaListaDeChavesConcil;

  lstEstabel := TStringList.Create;

  CriarComponentesRequisicao;
end;

procedure TConcilAPI.CriarComponentesRequisicao;
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

  FRestRequest.Params.AddHeader('apikey', '');
  FRestRequest.Params[0].Kind := pkHTTPHEADER;
  FRestRequest.Params[0].Options := [poDoNotEncode];

  FRestRequest.Params.AddHeader('pfj', '');
  FRestRequest.Params[1].Kind := pkHTTPHEADER;
  FRestRequest.Params[1].Options := [poDoNotEncode];


  FRestRequest.Params.AddHeader('Content-Type', 'application/json');
  FRestRequest.Params[2].Kind := pkHTTPHEADER;
  FRestRequest.Params[2].Options := [poDoNotEncode];

end;

procedure TConcilAPI.DestroiComponentesRequisicao;
begin
  FreeAndNil(FRestResponse);
  FreeAndNil(FRestRequest);
  FreeAndNil(FRestClient);
end;

destructor TConcilAPI.Destroy;
begin
  inherited;
  FreeAndNil(FListaChaves);

  FreeAndNil(lstEstabel);

  DestroiComponentesRequisicao;
end;

procedure TConcilAPI.DownloadDataSelecionada(AChaveSelecionada: TChavesConcil;
                                             ADataPagamento: TDateTime;
                                             AiCartoes: TConcilAPIPgto);
  Var
    LContador: Integer;

    LAutorizado: Boolean;

    LMensagem,
    LPagina: String;
    LMsgErro : String;
Begin
  LAutorizado := False;
  LContador := 0;

  While Not Autorizado(LAutorizado,LContador) Do
  Begin
    Try
      LPagina := '0';
      Repeat
        CarregaLinks(AChaveSelecionada.Empresa);
        lblInform.Caption := 'Efetuando o download do(s) pagamento(s) do dia ' + FormatDateTime('dd/mm/yyyy', ADataPagamento) +
                            ' da Empresa ' + AChaveSelecionada.Empresa;

        Application.ProcessMessages;

        FRestClient.BaseUrl := RetornaLinkFormatado(FLinkPagamentos,
                                                    ADataPagamento,
                                                    LPagina);

        FRestRequest.Params[0].Value := AChaveSelecionada.ApiKey;
        FRestRequest.Params[1].Value := AChaveSelecionada.Pfj;
        FRestRequest.Execute;

        If Not MatchStr(FRestResponse.StatusCode.ToString,['200','204']) Then
          Raise Exception.Create(FRestResponse.Content);

        If FRestResponse.StatusCode = 204 Then
          LPagina := '';

        If FRestResponse.StatusCode = 200 Then
        Begin
          AiCartoes.EstabelecimentoAtual := AChaveSelecionada.Estabelecimento;
          AiCartoes.TipoDoArquivo := 'PAGAMENTOS';
          AiCartoes.pAdicionaLinha(FRestResponse.Content);
          LPagina := IntToStr(StrToInt(LPagina) + 1);
        End;

      Until (LPagina.IsEmpty);

      LPagina := '0';
      Repeat
        CarregaLinks(AChaveSelecionada.Empresa);
        lblInform.Caption := 'Efetuando o download do(s) ajuste(s) do dia ' + FormatDateTime('dd/mm/yyyy', ADataPagamento) +
                            ' da Empresa ' + AChaveSelecionada.Empresa;

        Application.ProcessMessages;

        FRestClient.BaseUrl := RetornaLinkFormatado(FLinkAJustes,
                                                    ADataPagamento,
                                                    LPagina);

        FRestRequest.Params[0].Value := AChaveSelecionada.ApiKey;
        FRestRequest.Params[1].Value := AChaveSelecionada.Pfj;
        FRestRequest.Execute;

        If Not MatchStr(FRestResponse.StatusCode.ToString,['200','204']) Then
          Raise Exception.Create(FRestResponse.Content);

        If FRestResponse.StatusCode = 204 Then
          LPagina := '';

        If FRestResponse.StatusCode = 200 Then
        Begin
          AiCartoes.EstabelecimentoAtual := AChaveSelecionada.Estabelecimento;
          AiCartoes.TipoDoArquivo := 'AJUSTES';
          AiCartoes.pAdicionaLinha(FRestResponse.Content);
          LPagina := IntToStr(StrToInt(LPagina) + 1);
        End;

      Until (LPagina.IsEmpty);


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

procedure TConcilAPI.FormOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
    TForm(Sender).Perform(40,0,0);
end;

function TConcilAPI.fRetUltimaData: String;
  Var
    qryDados: IDataSet;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.SQL := 'SELECT MAX(CON_DTAPAG) AS DTAPAG FROM CON_APPGTO';
  qryDados.Open;

  Result := 'Nenhuma';
  If qryDados.FieldByName('DTAPAG').AsString <> '' Then
    Result := qryDados.FieldByName('DTAPAG').AsString;
end;

function TConcilAPI.GetRestResponseError: TRestResponse;
begin
  Result := FRestResponse; // Response get registros
end;

procedure TConcilAPI.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

function TConcilAPI.OnException(var AAutorizado: Boolean;
                                  var AMsgErro: String; Var AContador: Integer;
                                  AChaveSelecionada: TChavesConcil; AMensagem : String): Boolean;
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
      AMsgErro := 'Chave de acesso e/ou Ponto de Venda (Estabelecimento) estão incorretos ou não liberado utilização no ambiente de ' + FAmbiente + '!' + #13 +
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

      AMsgErro :='Ocorreu um erro ao conectar-se ao serviço da Concil.' + #13 +
                             'Tente novamente mais tarde!' + #13 +
                             'Código do erro: ' + GetRestResponseError.StatusCode.ToString + '-' +
                                                  GetRestResponseError.StatusText;

      Case GetRestResponseError.StatusCode Of
        404 : AMsgErro := 'O serviço da Concil não encontrou o Ponto de Venda (Estabelecimento) ou a data informada.!' + #13 +
                          'Ponto de Venda: ' + AChaveSelecionada.Estabelecimento + ' - Empresa: ' +  AChaveSelecionada.Empresa + #13 +
                          'Erro código 404.';

        503 : AMsgErro := 'O serviço da Concil está com problemas no funcionamento. Tente novamente mais tarde!' + #13 +
                           AMensagem + #13 +
                           'Erro código 503.';

        500 : AMsgErro :='Ocorreu um erro interno no serviço da Concil. ' + AMensagem + #13 +
                         'Tente novamente mais tarde!' + #13 +
                         'Erro código 500.';
      End;

    End;
  End;

  If AContador > 0 Then
  Begin
    lblInform.Caption := 'Aguarde... Nova tentativa de download da Empresa ' + AChaveSelecionada.Empresa;
    Application.ProcessMessages;
    Sleep(1000);
  End;

  Result := Not fEmptyStr(AMsgErro);

end;

procedure TConcilAPI.btnSairClick(Sender: TObject);
Begin
  frmForm.Close;
End;

function TConcilAPI.Autorizado(AAutorizado: Boolean; AContador: Integer): Boolean;
begin
  Result := True;

  If Not AAutorizado Then // Não fui autorizado a importar pela api ainda ?
  Begin
    If AContador <= 5 Then Result := False; // continuo tentando importar até 5x
  End;

end;

procedure TConcilAPI.btnConfClick(Sender: TObject);
Begin
  If (edtDtaIni.Date > Date) Or (edtDtaFin.Date > Date) Then
  Begin
    objFunctions.fIMensagem('','As datas para importação não podem ser maiores que a data atual!',['&OK']);
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
                                  'A importação da Concil é feita através da Internet, dependendo da quantidade ' +
                                  'de registros a operação pode demorar. Deseja realmente continuar?',['&Sim','&Não']) = 2 Then
      Exit;
  End;
  If (edtDtaIni.Date = Date) Or (edtDtaFin.Date = Date) Then
  Begin
    objFunctions.fIMensagem('','Em um dia posterior a hoje lembre-se de importar novamente a data atual pois nem toda movimentação diária está disponível no momento.',['&OK']);
  End;

  pDisableControls(True);
  ProcessaDownload;
  pDisableControls(False);
End;

procedure TConcilAPI.ProcessaDownload;
  Var
    LiCartoes: TConcilAPIPgto;

    LMensagem: String;

    LChavesConcil: TChavesConcil;

    LContador: Integer;

    LOcorreuErro,
    LPararNoErro: Boolean;
    LDataSelecionada: TDate;
begin
  Try
    pValidaLibsWebService;

    LiCartoes := TConcilAPIPgto.Create;

    If FListaChaves.Count = 0 Then
    Begin
      objFunctions.fIMensagem('ATENÇÃO','Não existem empresas configuradas com a chave de Autorização da Concil. Operação cancelada!',['&OK']);
      Exit;
    End;

    LOcorreuErro := False;
    LPararNoErro := False;

    //Correndo os dias para efetuar o download
    LDataSelecionada := edtDtaIni.Date;
    While (LDataSelecionada <= edtDtaFin.Date) Do
    Begin
      LContador := 0;

      For LChavesConcil In FListaChaves Do
      Begin
        Inc(LContador);

        lblInform.Caption := 'Aguarde... Efetuando o download do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                            ' da Empresa ' + LChavesConcil.Empresa;

        Application.ProcessMessages;

        Try
          DownloadDataSelecionada(LChavesConcil,
                                  LDataSelecionada,
                                  LiCartoes);

          lblInform.Caption := 'Aguarde... Gravando os lançamentos do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                              ' da Empresa ' + LChavesConcil.Empresa;

          Application.ProcessMessages;

          LiCartoes.pGravarRegistros(pgbProg);

          Application.ProcessMessages;
        Except
          On E: Exception Do
          Begin
            LOcorreuErro := True;

            If (LContador = FListaChaves.Count) And (LDataSelecionada = edtDtaFin.Date) Then
              objFunctions.fIMensagem('ERRO', E.Message, ['&OK'])
            Else
              LPararNoErro := objFunctions.fIMensagem('ERRO', E.Message + #13 +
                                                      'Deseja continuar com a importação das outras datas/empresas?',
                                                      ['&Sim', 'Não']) = 2;
          End;

        End;

        If LPararNoErro Then
          Break;
      End;

      If LPararNoErro Then
        Break;

      LDataSelecionada := IncDay(LDataSelecionada, 1);
    End;

    LMensagem := 'Nenhum registro foi importado no período selecionado!';
    If TConcilAPIPgto(LiCartoes).ImportouRegistro Then
    Begin
      If Not LOcorreuErro Then
      Begin
        LMensagem := 'Dados importados com sucesso';
        If Not TConcilAPIPgto(LiCartoes).ImportouPagamento Then
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

procedure TConcilAPI.pDisableControls(blnDisable: Boolean);
begin
  pnlFund.Enabled    := not blnDisable;
  edtDtaIni.Enabled  := not blnDisable;
  edtDtaFin.Enabled  := not blnDisable;
end;

procedure TConcilAPI.pSelecionaFonte;
  Var
    lblDtaIni,
    lblDtaFin: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;
Begin

  frmForm := TForm.Create(Self);

  frmForm.BorderStyle  := bsSingle;
  frmForm.Caption      := 'Importação de Registros (Concil API)';
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

function TConcilAPI.RetornaLinkFormatado(ALinkOriginal: String;
                                         ADataPagmento: TDateTime;
                                         APagina: String): String;
begin
  Result := StringReplace(ALinkOriginal, '[DATA_PAGAMENTO]',FormatDateTime('YYYYMMDD', ADataPagmento), [rfReplaceAll]);
  Result := StringReplace(Result, '[NUMERO_PAGINA]', APagina, []);
end;

function TConcilAPI.RetornaListaDeChavesConcil: TList<TChavesConcil>;
  Var
    LDados: IDataset;
    LChavesConcil: TChavesConcil;
    LApiKey: String;
    LPfj: String;
begin
  Result := TList<TChavesConcil>.Create;

  LDados := objFunctions.fGetDataSet;
  LDados.Close;

  LDados.SQL := 'SELECT                            '+
                '  SIS_VALCFG,                     '+
                '  SIS_CODEMP                      '+
                'FROM                              '+
                '  CFGSIS                          '+
                'WHERE (                           '+
                '    SIS_CODCFG = "CFG_CONCEST"     '+
                '    AND SIS_VALCFG IS NOT NULL    '+
                '    AND TRIM(SIS_VALCFG) <> ""    '+
                '  )                               '+
                'ORDER BY SIS_CODEMP               ';

  LDados.Open;

  While Not LDados.Eof Do
  Begin
    LApiKey := fRetornaValorConfiguracao('CFG_CONKEY', LDados.FieldByName('SIS_CODEMP').AsString);
    LPfj := fRetornaValorConfiguracao('CFG_CONPFJ', LDados.FieldByName('SIS_CODEMP').AsString);

    If (Not LApiKey.IsEmpty) And (Not LPfj.IsEmpty) Then
    Begin
      LChavesConcil := TChavesConcil.Create;
      LChavesConcil.Empresa         := LDados.FieldByName('SIS_CODEMP').AsString;
      LChavesConcil.Estabelecimento := fRetornaValorConfiguracao('CFG_CONCEST', LDados.FieldByName('SIS_CODEMP').AsString);
      LChavesConcil.ApiKey          := LApiKey;
      LChavesConcil.Pfj             := LPfj;
      Result.Add(LChavesConcil);
    End;

    LDados.Next;
  End;

end;

end.
