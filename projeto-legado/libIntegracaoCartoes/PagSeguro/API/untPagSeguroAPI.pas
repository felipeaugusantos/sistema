{******************************************************}
{* Importação de arquivos com RESTClient da PagSeguro *}
{***************************************************MT*}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{****************************************MT*}
unit untPagSeguroAPI;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Vcl.Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  ComCtrls, cxCalendar, IPPeerClient, DateUtils, System.Generics.Collections,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Json, untPagSeguroAPIPgto,System.NetEncoding, HTTPSend, blcksock, synautil,
  ssl_openssl;

Type
  TChavesPagSeguro = class
  private
  public
    Empresa,
    Estabelecimento,
    Authorization : String;
  end;

Type
  TPagSeguroAPI = Class(TComponent)
  Private
    frmForm   : TForm;
    pgbProg   : TProgressBar;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    memXMLDoc : TMemo;
    lblInform : TLabel;
    pnlFund   : TPanel;

    FAplicacao: HWND;

    FListaChaves: TList<TChavesPagSeguro>;

    FLinkPagamentos,
    FAmbiente: String;

    procedure pDisableControls(blnDisable: Boolean);
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function fRetUltimaData: String;

    function RetornaListaDeChavesPagSeguro: TList<TChavesPagSeguro>;

    procedure CriarComponentesRequisicao;
    procedure DestroiComponentesRequisicao;
    procedure ProcessaDownload;
    procedure DownloadDataSelecionada(AChaveSelecionada: TChavesPagSeguro;
                                      ADataMovimento: TDateTime;
                                      AiCartoes: TPagSeguroAPIPgto);

    procedure CarregaLinks;

    function RetornaLinkFormatado(ALinkOriginal: String;
                                  AChaveSelecionada: TChavesPagSeguro;
                                  ADataMovimento: TDateTime;
                                  ATipoMovimento: String;
                                  APagina: String): String;

    function OnException(Var AAutorizado: Boolean; Var AMsgErro :String;
                           Var AContador: Integer; AChaveSelecionada: TChavesPagSeguro;
                               AMensagem: String): Boolean;

    function Autorizado(AAutorizado: Boolean;AContador: Integer):Boolean;
    function GetRestResponseError: THTTPSend;
    function RetiraZerosEsquerda(AString: String): String;
    function RetornaToken(AEstabelecimento,AToken: String): String;

  Public
    property Aplicacao: HWND read FAplicacao write FAplicacao;
    procedure pSelecionaFonte;

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  protected
    FHTTPSend: THTTPSend;

    FChavesStone: TStringList;
  End;

Const
  EXTRATO: Array of String = ['financial'];

implementation

uses untFuncoes, untIDataSet;

{ TPagSeguroAPI }

procedure TPagSeguroAPI.CarregaLinks;
begin
  FLinkPagamentos := 'https://edi.api.pagbank.com.br/movement/v3.00/[TIPO_MOVIMENTO]/[DATA_MOVIMENTO]?pageNumber=[NUMERO_PAGINA]&pageSize=1000';

  FAmbiente := 'PRODUÇÃO';
end;

constructor TPagSeguroAPI.Create(Owner: TComponent);
begin
  inherited;
  FListaChaves := RetornaListaDeChavesPagSeguro;

  lstEstabel := TStringList.Create;

  CarregaLinks;
end;

procedure TPagSeguroAPI.CriarComponentesRequisicao;
begin
  If Assigned(FHTTPSend) Then
    FreeAndNil(FHTTPSend);

  FHTTPSend :=THTTPSend.Create;
  FHTTPSend.MimeType  := 'application/json; charset=utf-8';
  FHTTPSend.UserAgent := 'Mozilla/4.0';
  FHTTPSend.Protocol  := '1.1';
  FHTTPSend.KeepAlive := True;

  FHTTPSend.Sock.SSL.SSLType:= LT_TLSv1_2;

  FHTTPSend.Sock.SetTimeout(90000);
  FHTTPSend.Sock.ConnectionTimeout   := 90000;
  FHTTPSend.Sock.InterPacketTimeout  := False;
  FHTTPSend.Sock.NonblockSendTimeout := 90000;
  FHTTPSend.Sock.SocksTimeout        := 90000;
  FHTTPSend.Sock.HTTPTunnelTimeout   := 90000;
  FHTTPSend.Sock.SocksType := TSocksType.ST_Socks4;
end;

procedure TPagSeguroAPI.DestroiComponentesRequisicao;
begin
  If Assigned(FHTTPSend) Then
    FreeAndNil(FHTTPSend);
end;

destructor TPagSeguroAPI.Destroy;
begin
  inherited;
  FreeAndNil(FListaChaves);

  FreeAndNil(lstEstabel);

  DestroiComponentesRequisicao;
end;

procedure TPagSeguroAPI.DownloadDataSelecionada(AChaveSelecionada: TChavesPagSeguro;
                                                ADataMovimento: TDateTime;
                                                AiCartoes: TPagSeguroAPIPgto);
  Var
    LContador: Integer;

    LAutorizado: Boolean;

    LMensagem,
    LPagina: String;
    LMsgErro : String;
    LTipoExtrato : Integer;
    LBaseUrl:String;
    LDataResp: TMemoryStream;
    LResposta: String;
Begin
  LAutorizado := False;
  LContador := 0;

  While Not Autorizado(LAutorizado,LContador) Do
  Begin
    Try
      For LTipoExtrato := 0 To Length(EXTRATO) - 1 Do
      Begin
        LPagina := '1';

        Repeat
          lblInform.Caption := 'Aguarde... Efetuando o download do dia ' + FormatDateTime('dd/mm/yyyy', ADataMovimento) +
                              ' da Empresa ' + AChaveSelecionada.Empresa;

          Application.ProcessMessages;

          CriarComponentesRequisicao;

          FHTTPSend.Headers.Clear;
          FHTTPSend.Headers.Add('Accept: application/json');
          FHTTPSend.Headers.Add('Content-Type: application/json');
          FHTTPSend.Headers.Add('Authorization: '+AChaveSelecionada.Authorization);

          LBaseUrl := RetornaLinkFormatado(FLinkPagamentos,
                                           AChaveSelecionada,
                                           ADataMovimento,
                                           EXTRATO[LTipoExtrato],
                                           LPagina);


          If FHTTPSend.HTTPMethod('GET', LBaseUrl) Then
          Begin
            FHTTPSend.Document.Position := 0;

            Try
              LDataResp := TMemoryStream.Create;
              LDataResp.LoadFromStream(FHTTPSend.Document);

              LDataResp.Position := 0;
              LResposta := UTF8ToString(ReadStrFromStream(LDataResp, LDataResp.Size));

              If FHTTPSend.ResultCode <> 200 Then
              Begin
                Raise Exception.Create(LResposta);
              End;

            Finally
              FreeAndNil(LDataResp);
            End;

          End;


          AiCartoes.EstabelecimentoAtual := AChaveSelecionada.Estabelecimento;
          AiCartoes.TipoDoArquivo := 'PAGAMENTOS';
          AiCartoes.TipoExtrato := EXTRATO[LTipoExtrato];
          AiCartoes.pAdicionaLinha(LResposta);

          LPagina := AiCartoes.ProximaPagina;
        Until (LPagina.IsEmpty);
      End;

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

procedure TPagSeguroAPI.FormOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
    TForm(Sender).Perform(40,0,0);
end;

function TPagSeguroAPI.fRetUltimaData: String;
  Var
    qryDados: IDataSet;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.SQL := 'SELECT MAX(PAG_DTAPAG) AS DTAPAG FROM PAG_APPGTO';
  qryDados.Open;

  Result := 'Nenhuma';
  If qryDados.FieldByName('DTAPAG').AsString <> '' Then
    Result := qryDados.FieldByName('DTAPAG').AsString;
end;

function TPagSeguroAPI.GetRestResponseError: THTTPSend;
begin
  Result := FHTTPSend; // Response get registros
end;

function TPagSeguroAPI.OnException(var AAutorizado: Boolean;
                                  var AMsgErro: String; Var AContador: Integer;
                                  AChaveSelecionada: TChavesPagSeguro; AMensagem : String): Boolean;
begin
  AAutorizado := GetRestResponseError.ResultCode <> 401;

  if GetRestResponseError.ResultCode = 400 Then
  Begin
    AMsgErro := 'Requisição incorreta. Verifique o Ponto de venda (Estabelecimento) está incorreto para a empresa ' + AChaveSelecionada.Empresa + '.';
  End
  Else If GetRestResponseError.ResultCode = 401 Then
  Begin
    If AContador <= 4 Then
    Begin
      Inc(AContador);
      lblInform.Caption := 'Revalidando chaves de autorização para a empresa ' + AChaveSelecionada.Empresa + '.';
    End
    Else
      AMsgErro := 'Token de acesso e/ou Ponto de Venda (Estabelecimento) estão incorretos ou não liberado utilização no ambiente de ' + FAmbiente + '!' + #13 +
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

      AMsgErro :='Ocorreu um erro ao conectar-se ao serviço da PagSeguro.' + #13 +
                             'Tente novamente mais tarde!' + #13 +
                             'Código do erro: ' + GetRestResponseError.ResultCode.ToString + '-' +
                                                  AMensagem;

      Case GetRestResponseError.ResultCode Of
        404 : AMsgErro := 'O serviço da PagSeguro não encontrou o Ponto de Venda (Estabelecimento) ou a data informada.!' + #13 +
                          'Ponto de Venda: ' + AChaveSelecionada.Estabelecimento + ' - Empresa: ' +  AChaveSelecionada.Empresa + #13 +
                          'Erro código 404.';

        503 : AMsgErro := 'O serviço da PagSeguro está com problemas no funcionamento. Tente novamente mais tarde!' + #13 +
                           AMensagem + #13 +
                           'Erro código 503.';

        500 : AMsgErro :='Ocorreu um erro interno no serviço da PagSeguro. ' + AMensagem + #13 +
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

procedure TPagSeguroAPI.btnSairClick(Sender: TObject);
Begin
  frmForm.Close;
End;

function TPagSeguroAPI.Autorizado(AAutorizado: Boolean; AContador: Integer): Boolean;
begin
  Result := True;

  If Not AAutorizado Then // Não fui autorizado a importar pela api ainda ?
  Begin
    If AContador <= 5 Then Result := False; // continuo tentando importar até 5x
  End;

end;

procedure TPagSeguroAPI.btnConfClick(Sender: TObject);
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
                                  'A importação da PagSeguro é feita através da Internet, dependendo da quantidade ' +
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

procedure TPagSeguroAPI.ProcessaDownload;
  Var
    LiCartoes: TPagSeguroAPIPgto;

    LMensagem: String;

    LChavesPagSeguro: TChavesPagSeguro;

    LContador: Integer;

    LOcorreuErro,
    LPararNoErro: Boolean;
    LDataSelecionada: TDate;
begin
  Try
    pValidaLibsWebService;

    LiCartoes := TPagSeguroAPIPgto.Create;

    If FListaChaves.Count = 0 Then
    Begin
      objFunctions.fIMensagem('ATENÇÃO','Não existem empresas configuradas com a chave de Autorização da PagSeguro. Operação cancelada!',['&OK']);
      Exit;
    End;

    LOcorreuErro := False;
    LPararNoErro := False;

    //Correndo os dias para efetuar o download
    LDataSelecionada := edtDtaIni.Date;
    While (LDataSelecionada <= edtDtaFin.Date) Do
    Begin
      LContador := 0;

      For LChavesPagSeguro In FListaChaves Do
      Begin
        Inc(LContador);

        lblInform.Caption := 'Aguarde... Efetuando o download do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                            ' da Empresa ' + LChavesPagSeguro.Empresa;

        Application.ProcessMessages;

        Try
          DownloadDataSelecionada(LChavesPagSeguro,
                                  LDataSelecionada,
                                  LiCartoes);

          lblInform.Caption := 'Aguarde... Gravando os lançamentos do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                              ' da Empresa ' + LChavesPagSeguro.Empresa;

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
    If TPagSeguroAPIPgto(LiCartoes).ImportouRegistro Then
    Begin
      If Not LOcorreuErro Then
      Begin
        LMensagem := 'Dados importados com sucesso';
        If Not TPagSeguroAPIPgto(LiCartoes).ImportouPagamento Then
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

procedure TPagSeguroAPI.pDisableControls(blnDisable: Boolean);
begin
  pnlFund.Enabled    := not blnDisable;
  edtDtaIni.Enabled  := not blnDisable;
  edtDtaFin.Enabled  := not blnDisable;
end;

procedure TPagSeguroAPI.pSelecionaFonte;
  Var
    lblDtaIni,
    lblDtaFin: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;
Begin

  frmForm := TForm.Create(Self);

  frmForm.BorderStyle  := bsSingle;
  frmForm.Caption      := 'Importação de Registros (PagSeguro API)';
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

function TPagSeguroAPI.RetiraZerosEsquerda(AString: String): String;
begin

  While AString[1] = '0' do
    Delete(AString,1,1);

  Result := AString;
end;

function TPagSeguroAPI.RetornaToken(AEstabelecimento,
  AToken: String): String;
  Var
    LBase64: TBase64Encoding;
begin
  Result := '';

  If AEstabelecimento.IsEmpty Then
    Exit;

  If AToken.IsEmpty Then
    Exit;

  Try
    LBase64 := TBase64Encoding.Create(0);

    Result := 'Bearer ' + LBase64.Encode(AEstabelecimento + ':' + AToken);
  Finally
    FreeAndNil(LBase64);
  End;

end;

function TPagSeguroAPI.RetornaLinkFormatado(ALinkOriginal: String;
                                            AChaveSelecionada: TChavesPagSeguro;
                                            ADataMovimento: TDateTime;
                                            ATipoMovimento: String;
                                            APagina: String): String;
begin
  Result := StringReplace(ALinkOriginal, '[DATA_MOVIMENTO]',FormatDateTime('YYYY-MM-DD', ADataMovimento), [rfReplaceAll]);
  Result := StringReplace(Result, '[TIPO_MOVIMENTO]', ATipoMovimento,[]);
  Result := StringReplace(Result, '[NUMERO_PAGINA]', APagina, []);
end;

function TPagSeguroAPI.RetornaListaDeChavesPagSeguro: TList<TChavesPagSeguro>;
  Var
    LDados: IDataset;
    LChavesPagSeguro: TChavesPagSeguro;
    LToken: String;
begin
  Result := TList<TChavesPagSeguro>.Create;

  LDados := objFunctions.fGetDataSet;
  LDados.Close;

  LDados.SQL := 'SELECT                            '+
                '  SIS_VALCFG,                     '+
                '  SIS_CODEMP                      '+
                'FROM                              '+
                '  CFGSIS                          '+
                'WHERE (                           '+
                '    SIS_CODCFG IN ("CFG_PAGEST", "CFG_PAGLNK") '+
                '    AND SIS_VALCFG IS NOT NULL    '+
                '    AND TRIM(SIS_VALCFG) <> ""    '+
                '  )                               '+
                'ORDER BY SIS_CODEMP               ';

  LDados.Open;

  While Not LDados.Eof Do
  Begin
    LToken := fRetornaValorConfiguracao('CFG_PAGTKN', LDados.FieldByName('SIS_CODEMP').AsString);
    If Not LToken.IsEmpty Then
    Begin
      LChavesPagSeguro := TChavesPagSeguro.Create;
      LChavesPagSeguro.Empresa         := LDados.FieldByName('SIS_CODEMP').AsString;
      LChavesPagSeguro.Estabelecimento := LDados.FieldByName('SIS_VALCFG').AsString;
      LChavesPagSeguro.Authorization   := RetornaToken(RetiraZerosEsquerda(LChavesPagSeguro.Estabelecimento),LToken);
      Result.Add(LChavesPagSeguro);
    End;

    LDados.Next;
  End;

end;

end.
