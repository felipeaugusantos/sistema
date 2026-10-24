unit untStone;

interface

uses  System.Classes, Vcl.Forms, System.SysUtils, System.StrUtils,

      cxProgressBar, Uni,

      untStonePgto, untTStoneFuncoes, untIStoneIntegracaoLibCartoes,

      BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
      Vcl.Controls, Windows, Graphics, Buttons,
      ComCtrls, cxCalendar, IPPeerClient, DateUtils, System.Generics.Collections,
      REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
      IdHTTP, idComponent, idAntiFreeze, IdSSLOpenSSL,HTTPSend, blcksock, synautil, ssl_openssl,
      System.ZLib, IdCompressorZlib,untStoneMigracao, Json;


Type
  TStone = Class(TComponent)
  Private
    frmFormularioImportacao   : TForm;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    StringBuilderXMLDoc : TStringBuilder;
    lblInform : TLabel;
    pnlFund   : TPanel;

    FAplicacao: HWND;
     LCodEmp: String;
    
    FListaChaves: TObjectList<TChavesStone>;

    FClientId: string;
    FClientSecret: string;
    FUsername: string;
    FPassword: string;
    FUrlToken: string;
    FUrlConsultaExtrato: string;

    function fDecodeGZIPContent(ARetorno: TMemoryStream): String;

    procedure pDisableControls(blnDisable: Boolean);
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function fRetUltimaData: String;
    function ExisteImportacao(Adata: Tdate; AEstabelecimento:string): Boolean;
    function FormataData(AData: string): Tdate;

    function RetornaListaDeChavesStone: TObjectList<TChavesStone>;

    procedure CriarComponentesRequisicao;
    procedure DestroiComponentesRequisicao;
    function ProcessaDownload(prgStatus: TcxProgressBar): Boolean;
    procedure DownloadDataSelecionadaV2(AChaveSelecionada: TChavesStone;
                                        ADataImportacao: TDateTime);
    function ObterToken: string;
  Public
    property Aplicacao: HWND read FAplicacao write FAplicacao;
    property Empresa: String read LCodEmp write LCodEmp;
    procedure pSelecionaFonte;

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  protected
    FHTTPSend: THTTPSend;

    FChavesStone: TStringList;
  End;

implementation

{ TStone }

constructor TStone.Create(Owner: TComponent);
begin
  inherited;
  FListaChaves := RetornaListaDeChavesStone;
end;

procedure TStone.CriarComponentesRequisicao;
begin
  FHTTPSend :=THTTPSend.Create;
  FHTTPSend.MimeType  := 'multipart/form-data';
  FHTTPSend.UserAgent := 'Mozilla/4.0';
  FHTTPSend.Protocol  := '1.1';
  FHTTPSend.KeepAlive := True;

  FHTTPSend.Sock.SSL.SSLType:= LT_TLSv1_2;

  FHTTPSend.Sock.SetTimeout( 30000 );
  FHTTPSend.Sock.ConnectionTimeout   := 30000;
  FHTTPSend.Sock.InterPacketTimeout  := False;
  FHTTPSend.Sock.NonblockSendTimeout := 30000;
  FHTTPSend.Sock.SocksTimeout        := 30000;
  FHTTPSend.Sock.HTTPTunnelTimeout   := 30000;
  FHTTPSend.Sock.SocksType := TSocksType.ST_Socks4;
end;

procedure TStone.DestroiComponentesRequisicao;
begin
  FreeAndNil(FHTTPSend);
end;

destructor TStone.Destroy;
begin
  If Assigned(FListaChaves) Then
    FreeAndNil(FListaChaves);

  If Assigned(FChavesStone) Then
    FreeAndNil(FChavesStone);

  DestroiComponentesRequisicao;

  If Assigned(StringBuilderXMLDoc) Then
    FreeAndNil(StringBuilderXMLDoc);

  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  inherited;
end;

procedure TStone.DownloadDataSelecionadaV2(AChaveSelecionada: TChavesStone;
                                           ADataImportacao: TDateTime);
const
  MAX_TENTATIVAS = 5;
  LAYOUT_PADRAO = 'XML2_2';
var
  LContador: Integer;
  LAutorizado: Boolean;
  LMensagem: String;
  LResposta: String;
  I: Integer;
  LUrlPrincipal: String;
  LDataStr: String;
  LMemoryStream: TMemoryStream;
begin
  LAutorizado := False;
  LContador := 0;

  try
    CriarComponentesRequisicao;

    FHTTPSend.Headers.Add('Authorization: Bearer ' + AChaveSelecionada.Token);

    while (LContador < MAX_TENTATIVAS) and (not LAutorizado) do
    begin
      try
        LResposta := '';
        LDataStr := FormatDateTime('yyyyMMdd', ADataImportacao);

        LUrlPrincipal := Format(FUrlConsultaExtrato,
          [AChaveSelecionada.Estabelecimento, LDataStr, LAYOUT_PADRAO]);

        if FHTTPSend.HTTPMethod('GET', LUrlPrincipal) then
        begin
          // Tratamento de redirecionamento (se necessário)
          if FHTTPSend.ResultCode = 307 then
          begin
            for I := 0 to FHTTPSend.Headers.Count - 1 do
            begin
              if UpperCase(Copy(FHTTPSend.Headers[I], 1, 8)) = 'LOCATION' then
              begin
                LUrlPrincipal := Copy(FHTTPSend.Headers[I], 11, Length(FHTTPSend.Headers[I]) - 10);

                FHTTPSend.Headers.Clear;
                FHTTPSend.HTTPMethod('GET', LUrlPrincipal);
                Break;
              end;
            end;
          end;

          LMemoryStream := TMemoryStream.Create;
          try
            LMemoryStream.LoadFromStream(FHTTPSend.Document);
            LMemoryStream.Position := 0;

            For i := 0 to FHTTPSend.Headers.Count -1 do
            begin
              If UpperCase(Copy(FHTTPSend.Headers[I], 1, 16)) = 'CONTENT-ENCODING' then
              Begin
                If (UpperCase(Copy(FHTTPSend.Headers[I], 19, Length(FHTTPSend.Headers[I]) - 10)) = 'GZIP') Then
                Begin
                  LResposta := fDecodeGZIPContent(LMemoryStream);
                  Break;
                End;
              End;
            end;

            If LResposta = '' Then
              LResposta := UTF8ToString(ReadStrFromStream(LMemoryStream, LMemoryStream.Size));

            If FHTTPSend.ResultCode <> 200 Then
              raise Exception.Create('HTTP ' + IntToStr(FHTTPSend.ResultCode) + ': ' + LResposta);

            StringBuilderXMLDoc.Clear;
            StringBuilderXMLDoc.Append(LResposta);
            LAutorizado := True;
          finally
            If Assigned(LMemoryStream) Then
              FreeAndNil(LMemoryStream);
          end;
        end;

        Inc(LContador);
      except
        On E: Exception Do
        Begin
          LAutorizado := FHTTPSend.ResultCode <> 401;

          if FHTTPSend.ResultCode = 400 Then
          Begin

            If (Pos('is older than min conciliation date',LResposta) > 0) Then
              Exit;

            LMensagem := 'Requisição incorreta. O Stone Code (Estabelecimento) está incorreto para a empresa ' + AChaveSelecionada.Empresa;

            If (TStoneFuncoes.fTime() <= StrToTime('05:00:00')) Then
              LMensagem := LMensagem + ' ou a data da importação ainda não está disponível. Tente novamente após às 05:00:00';

            LMensagem := LMensagem + '.';
            Raise Exception.Create(LMensagem);
          End
          Else If FHTTPSend.ResultCode = 401 Then
          Begin
            If LContador < 4 Then
            Begin
              Inc(LContador);
              lblInform.Caption := 'Revalidando chaves de autorização para a empresa ' + AChaveSelecionada.Empresa + '.';
            End
            Else
              Raise Exception.Create('Chaves de autorização, Stone Code (Estabelecimento) incorretas ou não liberado para importação!' + #13 +
                                     'Stone Code: ' + AChaveSelecionada.Estabelecimento + ' - Empresa: ' +  AChaveSelecionada.Empresa + #13 +
                                     'Erro código 401.');
          End
          Else
          Begin
            LAutorizado := False;

            If LContador < 4 Then
            Begin
              Inc(LContador);
              lblInform.Caption := 'Erro ao realizar a importação. Nova tentativa após 5 segundos.';
              Application.ProcessMessages;

              Sleep(5000);
            End
            Else
            Begin
              LMensagem := 'Em momentos de pico de requisições, podem causar instabilidades no serviço.';

              If FHTTPSend.ResultCode = 404 Then
                Raise Exception.Create('O serviço da Stone não encontrou o Stone Code (Estabelecimento) ou a data informada.!' + #13 +
                                       'Stone Code: ' + AChaveSelecionada.Estabelecimento + ' - Empresa: ' +  AChaveSelecionada.Empresa + #13 +
                                       'Erro código 404.')
              Else If MatchStr(FHTTPSend.ResultCode.ToString, ['502', '503']) Then
                Raise Exception.Create('O serviço da Stone está com problemas no funcionamento. Tente novamente mais tarde!' + #13 +
                                       LMensagem + #13 +
                                       'Erro código 503.')
              Else If FHTTPSend.ResultCode = 500 Then
                Raise Exception.Create('Ocorreu um erro interno no serviço da Stone. ' + LMensagem + #13 +
                                       'Tente novamente mais tarde!' + #13 +
                                       'Erro código ' + FHTTPSend.ResultCode.ToString + '.')
              Else If FHTTPSend.ResultCode = 0 Then
                Raise Exception.Create('Ocorreu um erro ao realizar a importação: 0 - ' + E.Message)
              Else
                Raise Exception.Create('Ocorreu um erro ao conectar-se ao serviço da Stone. ' + LMensagem + #13 +
                                       'Tente novamente mais tarde!' + #13 +
                                       'Código do erro: ' + FHTTPSend.ResultCode.ToString + '-' +
                                                            LResposta);
            End;
          End;

          If LContador > 0 Then
          Begin
            lblInform.Caption := 'Aguarde... Nova tentativa de download do dia ' + FormatDateTime('dd/mm/yyyy', ADataImportacao) +
                                 ' da Empresa ' + AChaveSelecionada.Empresa;
            Application.ProcessMessages;
          End;
        End;
      end;
    end;

  finally
    DestroiComponentesRequisicao;
  end;
end;


function TStone.fDecodeGZIPContent(ARetorno: TMemoryStream): String;
var
  MSO: TStringStream;
  ZLib: TIdCompressorZlib;
begin
  Result := '';

  if not Assigned(ARetorno) then
    raise Exception.Create('Stream de entrada não informado');

  if ARetorno.Size = 0 then
    raise Exception.Create('Stream de entrada vazio');

  MSO := nil;
  ZLib := nil;
  Try
    try
      MSO := TStringStream.Create('', TEncoding.UTF8);
      ZLib := TIdCompressorZlib.Create(nil);

      ARetorno.Position := 0;
      ZLib.DecompressGZipStream(ARetorno, MSO);

      MSO.Position := 0;
      Result := MSO.DataString;
    except
      on E: Exception do
        raise Exception.Create('Erro ao descomprimir GZIP: ' + E.Message);
    End;
  finally
    If Assigned(MSO) Then
      FreeAndNil(MSO);

    If Assigned(ZLib) THen
      FreeAndNil(ZLib);
  end;
end;

function TStone.FormataData(AData: string): Tdate;
var
  FormatSettings: TFormatSettings;
begin
  // Substitui as barras por hífens para garantir o formato yyyy-mm-dd
  AData := StringReplace(AData, '/', '-', [rfReplaceAll]);

  // Configura o formato esperado para a data
  FormatSettings.DateSeparator := '-';  // Define o separador como '-' para o formato yyyy-mm-dd
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd';  // Especifica o formato da data

  // Converte a string para TDateTime usando o formato correto
  Result := StrToDate(AData, FormatSettings);
end;

procedure TStone.FormOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
    TForm(Sender).Perform(40,0,0);
end;

function TStone.fRetUltimaData: String;
var
  LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT MAX(STO_DTAPAG) AS DTAPAG FROM STO_STPGTO';
    LConsulta.Open;
    Result := 'Nenhuma';
    if LConsulta.FieldByName('DTAPAG').AsString <> '' then
      Result := LConsulta.FieldByName('DTAPAG').AsString;
  finally
    TStoneFuncoes.FreeAndNilDatasets(LConsulta);
  end;
end;

procedure TStone.btnSairClick(Sender: TObject);
Begin
  frmFormularioImportacao.Close;
End;

procedure TStone.btnConfClick(Sender: TObject);
Begin
  If (edtDtaIni.Date >= Date) Or (edtDtaFin.Date >= Date) Then
  Begin
    TStoneFuncoes.fMensagem('','As datas para importação não podem ser maiores ou iguais a data atual!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date = 0) Or (edtDtaFin.Date = 0) Then
  Begin
    TStoneFuncoes.fMensagem('','É necessário digitar a data inicial e a data final!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date > edtDtaFin.Date) Then
  Begin
    TStoneFuncoes.fMensagem('','A data inicial deve ser menor que data final!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) >= 10 Then
  Begin
    TStoneFuncoes.fMensagem('ATENÇÃO','A quantidade de dias do período não pode ser maior que 10!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 5 Then
  Begin
    If TStoneFuncoes.fMensagem('','A quantidade de dias do período é maior 5 dias. ' +
                                  'A importação da Stone é feita através da Internet, dependendo da quantidade ' +
                                  'de registros a operação pode demorar. Deseja realmente continuar?',['&Sim','&Não']) = 2 Then
      Exit;
  End;

   Try
    pDisableControls(True);
    TStoneFuncoes.ExecutaAguarde(ProcessaDownload, 'Aguarde... Importando registros.');
  Finally
    pDisableControls(False);
  End;

End;

function TStone.ExisteImportacao(Adata: Tdate;AEstabelecimento:string): Boolean;
var
  LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT COUNT(*) AS RecordCount FROM STO_STCRED WHERE '+
                          ' STO_CODEST = :Estabelecimento AND STO_DTAVEN = :DataVenda';

    LConsulta.Params.ParamByName('DataVenda').AsDate := Adata;
    LConsulta.Params.ParamByName('Estabelecimento').asstring := AEstabelecimento;

    LConsulta.Open;

    Result := LConsulta.FieldByName('RecordCount').AsInteger > 0;
  finally
    TStoneFuncoes.FreeAndNilDatasets(LConsulta);
  end;
end;

function TStone.ProcessaDownload(prgStatus: TcxProgressBar): Boolean;
Var
  LDataSelecionada,
  LDataVendaImp: TDate;

  LiCartoes: ICartoes;

  LMensagem,LDataVenda: String;

  LChavesStone: TChavesStone;

  LContador,
  LContadorData: Integer;

  LOcorreuErro,
  LPararNoErro: Boolean;
  LStoneMigracao: TStoneMigracao;
begin
  Result := False;
  Try
    TStoneFuncoes.pValidaLibsWebService;

    LiCartoes := TStonePgto.Create;

    If FListaChaves.Count = 0 Then
    Begin
      TStoneFuncoes.fMensagem('','Não existem empresas configuradas com a chave de Autorização da Stone. Operação cancelada!',['&OK']);
      Exit;
    End;

    TStoneFuncoes.FreeAndNilDatasets(VS_RegistrosJaImportados);

    LOcorreuErro := False;
    LPararNoErro := False;

    TStonePgto(LiCartoes).DataInicioImportacao := edtDtaIni.Date;
    TStonePgto(LiCartoes).DataFinalImportacao := edtDtaFin.Date;

    //Correndo os dias para efetuar o download
    LDataSelecionada := edtDtaIni.Date;
    While (LDataSelecionada <= edtDtaFin.Date) Do
    Begin
      LContador := 0;

      For LChavesStone In FListaChaves Do
      Begin

        Try

          Try
            LStoneMigracao := TStoneMigracao.Create(LChavesStone);
            If Not LStoneMigracao.ExecutarMigracao Then
              Continue;
          Finally
            FreeAndNil(LStoneMigracao);
          End;

          Inc(LContador);

          lblInform.Caption := 'Aguarde... Efetuando o download do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                            ' da Empresa ' + LChavesStone.Empresa;
          Application.ProcessMessages;

          FClientId           := TStoneFuncoes.RetornaValorCfg('CFG_STOCID', LChavesStone.Empresa);
          FClientSecret       := TStoneFuncoes.RetornaValorCfg('CFG_STOCSC', LChavesStone.Empresa);
          FUsername           := TStoneFuncoes.RetornaValorCfg('CFG_STOUSU', LChavesStone.Empresa);
          FPassword           := TStoneFuncoes.RetornaValorCfg('CFG_STOPAS', LChavesStone.Empresa);
          FUrlToken           := TStoneFuncoes.RetornaValorCfg('CFG_STOTKN', LChavesStone.Empresa);
          FUrlConsultaExtrato := TStoneFuncoes.RetornaValorCfg('CFG_STOCOE', LChavesStone.Empresa);

          If LChavesStone.Token = '' Then
            LChavesStone.Token := ObterToken;

          DownloadDataSelecionadaV2(LChavesStone,
                                    LDataSelecionada);


          LiCartoes.pAdicionaLinha(StringBuilderXMLDoc.ToString);

          lblInform.Caption := 'Aguarde... Gravando os lançamentos do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                              ' da Empresa ' + LChavesStone.Empresa;
          Application.ProcessMessages;

          LiCartoes.pGravarRegistros(prgStatus);

          //Correndo lista de datas das vendas para efetuar o download
          for LContadorData := 0 to TStonePgto(LiCartoes).FDataVendasParaDownload.Count - 1 do
          begin
            LDataVenda := TStonePgto(LiCartoes).FDataVendasParaDownload[LContadorData];
            LDataVendaImp :=FormataData(LDataVenda);

            if not ExisteImportacao(LDataVendaImp, LChavesStone.Estabelecimento) then
            begin
              DownloadDataSelecionadaV2(LChavesStone,
                                        LDataVendaImp);


              LiCartoes.pAdicionaLinha(StringBuilderXMLDoc.ToString);

              lblInform.Caption := 'Aguarde... Gravando os lançamentos complementares do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                                  ' da Empresa ' + LChavesStone.Empresa + '. Lançamento ' + inttostr(LContadorData) + '/' + inttostr(TStonePgto(LiCartoes).FDataVendasParaDownload.Count) ;
              Application.ProcessMessages;

              LiCartoes.pGravarRegistros(prgStatus);
            end;
          end;

          Application.ProcessMessages;

        Except
          On E: Exception Do
          Begin
            LOcorreuErro := True;

            If (LContador = FListaChaves.Count) And (LDataSelecionada = edtDtaFin.Date) Then
              TStoneFuncoes.fMensagem('ERRO', E.Message, ['&OK'])
            Else
              LPararNoErro := TStoneFuncoes.fMensagem('ERRO', E.Message + #13 +
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
    If TStonePgto(LiCartoes).ImportouRegistro Then
    Begin
      If Not LOcorreuErro Then
      Begin
        LMensagem := 'Dados importados com sucesso';
        If Not TStonePgto(LiCartoes).ImportouPagamento Then
          LMensagem := LMensagem + ', porém não possui registros de pagamentos no período selecionado';

        LMensagem := LMensagem + '!';
      End
      Else
        LMensagem := 'Registros foram importados, porém ocorreu algum erro durante a importação.';
    End;
    TStoneFuncoes.fMensagem('ATENÇÃO', LMensagem,['&OK']);

  Finally
    Result := True;
    pDisableControls(False);
  End;

   frmFormularioImportacao.Close;
end;

procedure TStone.pDisableControls(blnDisable: Boolean);
begin
  pnlFund.Enabled    := not blnDisable;
  edtDtaIni.Enabled  := not blnDisable;
  edtDtaFin.Enabled  := not blnDisable;
end;

procedure TStone.pSelecionaFonte;
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
  frmFormularioImportacao.Caption      := 'Importação de Registros (STONE API)';
  frmFormularioImportacao.ClientHeight := 102;
  frmFormularioImportacao.ClientWidth  := 402;
  frmFormularioImportacao.Color        := 16770261;
  frmFormularioImportacao.Position     := poScreenCenter;
  frmFormularioImportacao.BorderIcons  := [biSystemMenu];
  frmFormularioImportacao.KeyPreview   := True;
  frmFormularioImportacao.OnKeyDown    := FormOnKeyDown;
  frmFormularioImportacao.Icon := TStoneFuncoes.FIconeAplicacao;

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
    edtDtaIni.Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);

    lblDtaFin := TLabel.Create(frmFormularioImportacao);
    lblDtaFin.Parent   := frmFormularioImportacao;
    lblDtaFin.Left     := edtDtaIni.Left + edtDtaIni.Width + 15 + 5;
    lblDtaFin.Top      := 12;
    lblDtaFin.AutoSize := True;
    lblDtaFin.Caption  := 'Data Final:';

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

    StringBuilderXMLDoc := TStringBuilder.Create;

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

function TStone.RetornaListaDeChavesStone: TObjectList<TChavesStone>;
Var
  LDados: TUniQuery;
  LChavesStone: TChavesStone;
  LEstabelecimento,
  LEstabelecimentoLink: String;
  LListaEstabelecimentos: TStringList;
begin
  Result := TObjectList<TChavesStone>.Create;

  LListaEstabelecimentos := Nil;
  LDados := Nil;
  Try
    LListaEstabelecimentos := TStringList.Create;
    LListaEstabelecimentos.Delimiter := ',';
    LListaEstabelecimentos.StrictDelimiter := True;

    LDados := VS_FuncoesExternas.fICriaQuery;
    LDados.SQL.text :=' SELECT                             '+
                      '  SIS_VALCFG,                       '+
                      '  SIS_CODEMP,                       '+
                      '  EMP_C_G_C_,                       '+
                      '  EMP_EMAIL_                        '+
                      'FROM                                '+
                      '  CFGSIS                            '+
                      '  LEFT JOIN CADEMP                  '+
                      '    ON EMP_CODEMP = SIS_CODEMP      '+
                      'WHERE SIS_CODCFG = "CFG_STOAUT"     '+
                      '  AND SIS_VALCFG IS NOT NULL        '+
                      '  AND SIS_VALCFG <> ""              '+
                      'ORDER BY SIS_CODEMP                 ';
    LDados.Open;

    While Not LDados.Eof Do
    Begin
      // Processa múltiplos estabelecimentos separados por vírgula
      LListaEstabelecimentos.DelimitedText := TStoneFuncoes.RetornaValorCfg('CFG_STOEST', LDados.FieldByName('SIS_CODEMP').AsString);

      If Not LListaEstabelecimentos.DelimitedText.IsEmpty Then
      Begin
        For LEstabelecimento In LListaEstabelecimentos Do
        Begin
          LChavesStone := TChavesStone.Create;
          LChavesStone.Empresa := LDados.FieldByName('SIS_CODEMP').AsString;
          LChavesStone.Estabelecimento := LEstabelecimento;
          LChavesStone.Authorization := 'Bearer ' + LowerCase(LDados.FieldByName('SIS_VALCFG').AsString);
          LChavesStone.SHA512 := TStoneFuncoes.fRetornaHMACSHA512Stone(LChavesStone.Empresa, 'Citel Software');
          LChavesStone.Documento := TStoneFuncoes.fTiraCaracEspeciaisPonto(LDados.FieldByName('EMP_C_G_C_').AsString);
          Result.Add(LChavesStone);
        End;
      End;

      // Processa estabelecimento link (único)
      LEstabelecimentoLink := TStoneFuncoes.RetornaValorCfg('CFG_STOLNK', LDados.FieldByName('SIS_CODEMP').AsString);
      If Not LEstabelecimentoLink.IsEmpty Then
      Begin
        LChavesStone := TChavesStone.Create;
        LChavesStone.Empresa := LDados.FieldByName('SIS_CODEMP').AsString;
        LChavesStone.Estabelecimento := LEstabelecimentoLink;
        LChavesStone.Authorization := 'Bearer ' + LowerCase(LDados.FieldByName('SIS_VALCFG').AsString);
        LChavesStone.SHA512 := TStoneFuncoes.fRetornaHMACSHA512Stone(LChavesStone.Empresa, 'Citel Software');
        LChavesStone.Documento := TStoneFuncoes.fTiraCaracEspeciaisPonto(LDados.FieldByName('EMP_C_G_C_').AsString);
        Result.Add(LChavesStone);
      End;

      LDados.Next;
    End;
  Finally
    TStoneFuncoes.FreeAndNilDatasets(LDados);

    If Assigned(LListaEstabelecimentos) Then
      FreeAndNil(LListaEstabelecimentos);
  End;
end;


function TStone.ObterToken: string;
var
  LHTTPSend: THTTPSend;
  LFDataResp: TMemoryStream;
  LFDataReq: TMemoryStream;
  LResposta: string;
  LDadosRequisicao: string;
  LJsonObject: TJSONObject;
begin
  Result := '';

  LHTTPSend := THTTPSend.Create;
  try
    // Configurar mime type e protocolo
    LHTTPSend.MimeType := 'application/x-www-form-urlencoded';
    LHTTPSend.Protocol := '1.1';

    // Configurar SSL
    LHTTPSend.Sock.SSL.SSLType := LT_all;

    // Configurar timeouts
    LHTTPSend.Sock.SetTimeout(30000);
    LHTTPSend.Sock.ConnectionTimeout := 30000;
    LHTTPSend.Sock.InterPacketTimeout := False;
    LHTTPSend.Sock.NonblockSendTimeout := 30000;
    LHTTPSend.Sock.SocksTimeout := 30000;
    LHTTPSend.Sock.HTTPTunnelTimeout := 30000;

    try
      // Montar parâmetros da requisição
      LDadosRequisicao := 'username=' + FUsername +
                          '&password=' + FPassword +
                          '&grant_type=password' +
                          '&client_id=' + FClientId +
                          '&client_secret=' + FClientSecret;

      // Configurar headers
      LHTTPSend.Headers.Clear;
      LHTTPSend.Headers.Add('Content-Type: application/x-www-form-urlencoded');

      // Preparar corpo da requisição
      try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosRequisicao)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      finally
        FreeAndNil(LFDataReq);
      end;

      // Realizar requisição POST
      if LHTTPSend.HTTPMethod('POST', FUrlToken) then
      begin
        LHTTPSend.Document.Position := 0;

        try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          // Verificar código de resposta
          if LHTTPSend.ResultCode <> 200 then
          begin
            raise Exception.Create(LHTTPSend.ResultCode.ToString + ' - ' + LResposta);
          end;

          // Processar resposta JSON
          LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
          try
            if Assigned(LJsonObject) then
            begin
              Result := LJsonObject.GetValue<string>('id_token');
            end
            else
              raise Exception.Create('Resposta não é um JSON válido');
          finally
            If Assigned(LJsonObject) Then
              FreeAndNil(LJsonObject);
          end;
        finally
          FreeAndNil(LFDataResp);
        end;
      end
      else
        raise Exception.Create('Falha na requisição HTTP');

    except
      on E: Exception do
      begin
        raise Exception.Create('Erro de autenticação: ' + E.Message);
      end;
    end;

  finally
    FreeAndNil(LHTTPSend);
  end;
end;

end.
