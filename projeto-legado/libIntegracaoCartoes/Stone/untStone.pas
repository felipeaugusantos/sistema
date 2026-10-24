{**************************************************}
{* Importação de arquivos com RESTClient da STONE *}
{***********************************************AJ*}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{****************************************AJ*}
unit untStone;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Vcl.Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  ComCtrls, cxCalendar, IPPeerClient, DateUtils, System.Generics.Collections,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  IdHTTP, idComponent, idAntiFreeze, IdSSLOpenSSL,HTTPSend, blcksock, synautil, ssl_openssl,
  System.ZLib, IdCompressorZlib,untStoneMigracao, Json;

Type
  TStone = Class(TComponent)
  Private
    frmForm   : TForm;
    pgbProg   : TProgressBar;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    StringBuilderXMLDoc : TStringBuilder;
    lblInform : TLabel;
    pnlFund   : TPanel;

    FAplicacao: HWND;

    FListaChaves: TList<TChavesStone>;

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

    function RetornaListaDeChavesStone: TList<TChavesStone>;

    procedure CriarComponentesRequisicao;
    procedure DestroiComponentesRequisicao;
    procedure ProcessaDownload;
    procedure DownloadDataSelecionadaV2(AChaveSelecionada: TChavesStone;
                                        ADataImportacao: TDateTime);
    function ObterToken: string;
  Public
    property Aplicacao: HWND read FAplicacao write FAplicacao;
    procedure pSelecionaFonte;

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  protected
    FHTTPSend: THTTPSend;

    FChavesStone: TStringList;
  End;

implementation

uses untFuncoes, untIDataSet, untStonePgto;

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

  FHTTPSend.Sock.SetTimeout( 90000 );
  FHTTPSend.Sock.ConnectionTimeout   := 90000;
  FHTTPSend.Sock.InterPacketTimeout  := False;
  FHTTPSend.Sock.NonblockSendTimeout := 90000;
  FHTTPSend.Sock.SocksTimeout        := 90000;
  FHTTPSend.Sock.HTTPTunnelTimeout   := 90000;
  FHTTPSend.Sock.SocksType := TSocksType.ST_Socks4;
end;

procedure TStone.DestroiComponentesRequisicao;
begin
  If Assigned(FHTTPSend) Then
    FreeAndNil(FHTTPSend);
end;

destructor TStone.Destroy;
begin
  inherited;
  FreeAndNil(FListaChaves);

  DestroiComponentesRequisicao;

  If Assigned(StringBuilderXMLDoc) Then
    FreeAndNil(StringBuilderXMLDoc);
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
    FreeAndNil(MSO);
    FreeAndNil(ZLib);
  end;
end;


procedure TStone.FormOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
    TForm(Sender).Perform(40,0,0);
end;

function TStone.fRetUltimaData: String;
  Var
    qryDados: IDataSet;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.SQL := 'SELECT MAX(STO_DTAPAG) AS DTAPAG FROM STO_STPGTO';
  qryDados.Open;
  If qryDados.FieldByName('DTAPAG').AsString <> '' Then
    Result := qryDados.FieldByName('DTAPAG').AsString
  Else
    Result := 'Nenhuma';
end;

procedure TStone.btnSairClick(Sender: TObject);
Begin
  frmForm.Close;
End;

procedure TStone.btnConfClick(Sender: TObject);
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
  If (edtDtaFin.Date - edtDtaIni.Date) >= 10 Then
  Begin
    objFunctions.fIMensagem('ATENÇÃO','A quantidade de dias do período não pode ser maior que 10!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 5 Then
  Begin
    If objFunctions.fIMensagem('','A quantidade de dias do período é maior 5 dias. ' +
                                  'A importação da Stone é feita através da Internet, dependendo da quantidade ' +
                                  'de registros a operação pode demorar. Deseja realmente continuar?',['&Sim','&Não']) = 2 Then
      Exit;
  End;

  pDisableControls(True);
  ProcessaDownload;
  pDisableControls(False);
End;

procedure TStone.ProcessaDownload;
  Var
    LDataSelecionada: TDate;

    LiCartoes: TStonePgto;

    LMensagem: String;

    LChavesStone: TChavesStone;

    LContador: Integer;

    LOcorreuErro,
    LPararNoErro: Boolean;

    LStoneMigracao: TStoneMigracao;
begin
  Try
    pValidaLibsWebService;

    LiCartoes := TStonePgto.Create;

    If FListaChaves.Count = 0 Then
    Begin
      objFunctions.fIMensagem('','Não existem empresas configuradas com a chave de Autorização da Stone. Operação cancelada!',['&OK']);
      Exit;
    End;

    LOcorreuErro := False;
    LPararNoErro := False;

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

          SetLength(FRegStoneCred, 0);
          SetLength(FRegStonePgto, 0);
          Inc(LContador);

          lblInform.Caption := 'Aguarde... Efetuando o download do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                              ' da Empresa ' + LChavesStone.Empresa;
          Application.ProcessMessages;


          FClientId           := fRetornaValorConfiguracao('CFG_STOCID', LChavesStone.Empresa);
          FClientSecret       := fRetornaValorConfiguracao('CFG_STOCSC', LChavesStone.Empresa);
          FUsername           := fRetornaValorConfiguracao('CFG_STOUSU', LChavesStone.Empresa);
          FPassword           := fRetornaValorConfiguracao('CFG_STOPAS', LChavesStone.Empresa);
          FUrlToken           := fRetornaValorConfiguracao('CFG_STOTKN', LChavesStone.Empresa);
          FUrlConsultaExtrato := fRetornaValorConfiguracao('CFG_STOCOE', LChavesStone.Empresa);

          If LChavesStone.Token = '' Then
            LChavesStone.Token := ObterToken;

          DownloadDataSelecionadaV2(LChavesStone,
                                    LDataSelecionada);

          LiCartoes.pAdicionaLinha(StringBuilderXMLDoc.ToString);

          lblInform.Caption := 'Aguarde... Gravando os lançamentos do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                              ' da Empresa ' + LChavesStone.Empresa;
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
    objFunctions.fIMensagem('ATENÇÃO', LMensagem,['&OK']);

  Finally
    pDisableControls(False);
  End;

  frmForm.Close;
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
Begin

  frmForm := TForm.Create(Self);
  With frmForm Do
  Begin
    BorderStyle  := bsSingle;
    Caption      := 'Importação de Registros (STONE)';
    ClientHeight := 102;
    ClientWidth  := 402;
    Color        := 16770261;
    Position     := poScreenCenter;
    BorderIcons  := [biSystemMenu];
    KeyPreview   := True;
    OnKeyDown    := FormOnKeyDown;
    Icon.LoadFromResourceName(HInstance, 'AUTCOM1');  //utilizando recurso para adicionar o icone AJ
  End;

  lblDtaIni := TLabel.Create(frmForm);
  With lblDtaIni Do
  Begin
    Parent   := frmForm;
    Top      := 12;
    AutoSize := True;
    Caption  := 'Data Inicial:';
    Left     := Round(frmForm.Width / 2) - Width - 95 - 5;
  End;

  edtDtaIni := TcxDateEdit.Create(frmForm);
  With edtDtaIni Do
  Begin
    Parent   := frmForm;
    Left     := lblDtaIni.Left + lblDtaIni.Width + 2;
    Top      := 8;
    Height   := 21;
    TabOrder := 0;
    Width    := 90;
    Text     := DateToStr(Yesterday);
   //DELPHI 2007
   {$IF Defined(VER185) Or Defined(VER180)}
    Properties.ButtonGlyph.LoadFromResourceName(HInstance, 'CALENDARIO');
   {$ELSE}
    Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);
   {$ENDIF}
  End;

  lblDtaFin := TLabel.Create(frmForm);
  With lblDtaFin Do
  Begin
    Parent   := frmForm;
    Left     := edtDtaIni.Left + edtDtaIni.Width + 15 + 5;
    Top      := 12;
    AutoSize := True;
    Caption  := 'Data Final:';
  End;

  edtDtaFin := TcxDateEdit.Create(frmForm);
  With edtDtaFin Do
  Begin
    Parent   := frmForm;
    Left     := lblDtaFin.Left + lblDtaFin.Width + 2;
    Top      := 8;
    Height   := 21;
    TabOrder := 1;
    Width    := 90;
    Text     := DateToStr(Yesterday);
   //DELPHI 2007 
   {$IF Defined(VER185) Or Defined(VER180)}
    Properties.ButtonGlyph.LoadFromResourceName(HInstance, 'CALENDARIO');
   {$ELSE}
    Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);
   {$ENDIF}
  End;

  lblInform := TLabel.Create(frmForm);
  With lblInform Do
  Begin
    Parent   := frmForm;
    Left     := 0;
    Top      := 42;
    AutoSize := False;
    Width    := frmForm.Width;
    Alignment:= taCenter;
    Caption  := 'Digite o período para realizar a importação. Última data importada: ' + fRetUltimaData;
  End;

  StringBuilderXMLDoc := TStringBuilder.Create;

  pnlFund := TPanel.Create(frmForm);
  With pnlFund Do
  Begin
    Parent   := frmForm;
    Align    := alBottom;
    Height   := 28;
    Color    := clGray;
    TabOrder := 2;
  End;

  pgbProg := TProgressBar.Create(frmForm);
  With pgbProg Do
  Begin
    Parent   := frmForm;
    Align    := alBottom;
    Height   := 10;
    Position := 0;
  End;

  btnSair := TBitBtnLocked.Create(frmForm);
  With btnSair Do
  Begin
    Parent   := pnlFund;
    Left     := 327;
    Top      := 2;
    Width    := 72;
    Height   := 24;
    TabOrder := 1;
    OnClick  := btnSairClick;
    Kind     := bkClose;
    Caption  := '&Sair';
    Cancel   := True;
    Glyph    := TBitmap.Create;
  End;

  btnConf := TBitBtnLocked.Create(frmForm);
  With btnConf Do
  Begin
    Parent   := pnlFund;
    Left     := 4;
    Top      := 2;
    Width    := 72;
    Height   := 24;
    TabOrder := 0;
    OnClick  := btnConfClick;
    Default  := False;
    Caption  := '&Importar';
    Glyph    := TBitmap.Create;
  End;

  frmForm.ShowModal;

  FreeAndNil(frmForm);
End;

function TStone.RetornaListaDeChavesStone: TList<TChavesStone>;
  Var
    LDados: IDataset;

    LChavesStone: TChavesStone;

    LEstabelecimento,
    LEstabelecimentoLink: String;
begin
  Result := TList<TChavesStone>.Create;

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := ' SELECT                             '+
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
    LEstabelecimento := fRetornaValorConfiguracao('CFG_STOEST', LDados.FieldByName('SIS_CODEMP').AsString);
    If Not LEstabelecimento.IsEmpty Then
    Begin
      LChavesStone := TChavesStone.Create;
      LChavesStone.Empresa := LDados.FieldByName('SIS_CODEMP').AsString;
      LChavesStone.Estabelecimento := LEstabelecimento;
      LChavesStone.Authorization := 'Bearer ' + LowerCase(LDados.FieldByName('SIS_VALCFG').AsString);
      LChavesStone.SHA512 := fRetornaHMACSHA512Stone(LChavesStone.Empresa, 'Citel Software');
      LChavesStone.Documento := TStoneMigracao.fTiraCaracEspeciaisPonto(LDados.FieldByName('EMP_C_G_C_').AsString);

      Result.Add(LChavesStone);
    End;

    LEstabelecimentoLink := fRetornaValorConfiguracao('CFG_STOLNK', LDados.FieldByName('SIS_CODEMP').AsString);
    If Not LEstabelecimentoLink.IsEmpty Then
    Begin
      LChavesStone := TChavesStone.Create;
      LChavesStone.Empresa := LDados.FieldByName('SIS_CODEMP').AsString;
      LChavesStone.Estabelecimento := LEstabelecimentoLink;
      LChavesStone.Authorization := 'Bearer ' + LowerCase(LDados.FieldByName('SIS_VALCFG').AsString);
      LChavesStone.SHA512 := fRetornaHMACSHA512Stone(LChavesStone.Empresa, 'Citel Software');
      LChavesStone.Documento := TStoneMigracao.fTiraCaracEspeciaisPonto(LDados.FieldByName('EMP_C_G_C_').AsString);

      Result.Add(LChavesStone);
    End;

    LDados.Next;
  End;
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

            If (fTime() <= StrToTime('05:00:00')) Then
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
    LHTTPSend.MimeType := 'application/x-www-form-urlencoded';
    LHTTPSend.Protocol := '1.1';

    LHTTPSend.Sock.SSL.SSLType := LT_all;

    LHTTPSend.Sock.SetTimeout(30000);
    LHTTPSend.Sock.ConnectionTimeout := 30000;
    LHTTPSend.Sock.InterPacketTimeout := False;
    LHTTPSend.Sock.NonblockSendTimeout := 30000;
    LHTTPSend.Sock.SocksTimeout := 30000;
    LHTTPSend.Sock.HTTPTunnelTimeout := 30000;

    try
      LDadosRequisicao := 'username=' + FUsername +
                          '&password=' + FPassword +
                          '&grant_type=password' +
                          '&client_id=' + FClientId +
                          '&client_secret=' + FClientSecret;

      LHTTPSend.Headers.Clear;
      LHTTPSend.Headers.Add('Content-Type: application/x-www-form-urlencoded');

      try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosRequisicao)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      finally
        FreeAndNil(LFDataReq);
      end;

      if LHTTPSend.HTTPMethod('POST', FUrlToken) then
      begin
        LHTTPSend.Document.Position := 0;

        try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          if LHTTPSend.ResultCode <> 200 then
          begin
            raise Exception.Create(LHTTPSend.ResultCode.ToString + ' - ' + LResposta);
          end;

          LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
          try
            if Assigned(LJsonObject) then
            begin
              Result := LJsonObject.GetValue<string>('id_token');
            end
            else
              raise Exception.Create('Resposta não é um JSON válido');
          finally
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
