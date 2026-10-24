{*****************************************************}
{* Importação de arquivos com RESTClient da KONCILIA *}
{**************************************************AJ*}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{****************************************AJ*}
unit untKoncilia;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Vcl.Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  ComCtrls, cxCalendar, IPPeerClient, REST.Client, Rest.Types, DateUtils,EditFocus,
  HTTPSend, blcksock, synautil, ssl_openssl;


Type
  TKoncilia = Class(TComponent)
    frmForm   : TForm;
    pgbProg   : TProgressBar;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    memXMLDoc : TMemo;
    lblInform : TLabel;
    pnlFund   : TPanel;
    edtIDConciliacao: TEditFocus;
  Private

    FAplicacao: HWND;
    FCancelarImportacao: Boolean ;
    FImportando : Boolean;

    FstrAmbiente: String;
    FLinkApi:String;

    dtaDtaIni,
    dtaDtaFin: TDate;

    procedure pDisableControls(blnDisable: Boolean);
    procedure pDownload(strAutKey, strCodEmp: String;
                        intPosicaoAtual: Integer);
    procedure pProcessaDownload;
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function fRetUltimaData: String;
    Procedure DefineUrl;
    function RetornaLinkFormatado(APagina:Integer;ADataInicio,ADataFim:TDateTime;ACodConciliacao:String): String;
    procedure CriarComponetesRequisicao;
  Public
    property Aplicacao: HWND read FAplicacao write FAplicacao;
    property strAmbiente: String read FstrAmbiente write FstrAmbiente;
    procedure pSelecionaFonte;

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  protected
    FHTTPSend: THTTPSend;
  End;

implementation

uses untFuncoes, untIDataSet, untKonciliaPgto;

{ TKoncilia }

constructor TKoncilia.Create(Owner: TComponent);
begin
  inherited;
  FCancelarImportacao := False;
  FImportando := False;
end;

procedure TKoncilia.CriarComponetesRequisicao;
begin

  If Assigned(FHTTPSend) Then
    FreeAndNil(FHTTPSend);

  FHTTPSend :=THTTPSend.Create;
  FHTTPSend.MimeType  := 'application/json; charset=utf-8';
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

  FHTTPSend.Headers.Add('Accept: application/json');
  FHTTPSend.Headers.Add('Content-Type: application/json');
end;

procedure TKoncilia.DefineUrl;
begin
  FLinkAPI := 'https://api-sandbox.koncili.com/externalapi/orderextract/unresolveds?offset=[PAGINA]&initDate=[INICIO]&endDate=[FIM]&limit=100';
  If FstrAmbiente = 'N' Then
    FLinkAPI := 'https://api.koncili.com/externalapi/orderextract/unresolveds?offset=[PAGINA]&initDate=[INICIO]&endDate=[FIM]&limit=100';
end;

destructor TKoncilia.Destroy;
begin

  inherited;
end;

procedure TKoncilia.FormOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
    TForm(Sender).Perform(40,0,0);

  If Key = VK_ESCAPE Then
  Begin
    If FImportando Then
    Begin
      If (objFunctions.fIMensagem('ATENÇÃO','Deseja Realmente cancelar a importaçao?',['&Sim','&Não'])  = 1) Then
      Begin
        FImportando := False;
        FCancelarImportacao := True;
      End;
    End
  End;
end;

function TKoncilia.fRetUltimaData: String;
  Var
    qryDados: IDataSet;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.SQL := 'SELECT MAX(KON_DTAPAG) AS DTAPAG FROM KON_KOPGTO';
  qryDados.Open;
  If qryDados.FieldByName('DTAPAG').AsString <> '' Then
    Result := qryDados.FieldByName('DTAPAG').AsString
  Else
    Result := 'Nenhuma';
end;

procedure TKoncilia.btnSairClick(Sender: TObject);
Begin
  frmForm.Close;
End;

procedure TKoncilia.btnConfClick(Sender: TObject);
Begin
  If (edtDtaIni.Date = 0) Or (edtDtaFin.Date = 0) Then
  Begin
    objFunctions.fIMensagem('ATENÇÃO','É necessário digitar a data inicial e a data final!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date > edtDtaFin.Date) Then
  Begin
    objFunctions.fIMensagem('ATENÇÃO','A data inicial deve ser menor que data final!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 20 Then
  Begin
    If objFunctions.fIMensagem('ATENÇÃO','A quantidade de dias do período é maior que 20 dias. ' +
                                         'A importação da Koncili é feita através da Internet, dependendo da quantidade ' +
                                         'de registros a operação pode demorar. Deseja realmente continuar?',['&Sim','&Não']) = 2 Then
      Exit;
  End;

  pDisableControls(True);
  pProcessaDownload;
  pDisableControls(False);
End;

procedure TKoncilia.pDownload(strAutKey, strCodEmp: String;
                              intPosicaoAtual: Integer);
  Var
    LFimDoLoop: Boolean;
    LFDataResp: TMemoryStream;
    LResposta: String;
    LLink: String;
Begin
  LFimDoLoop := False;
  Repeat
    CriarComponetesRequisicao;
    Try
      LLink := RetornaLinkFormatado(intPosicaoAtual,dtaDtaIni,dtaDtaFin,edtIDConciliacao.Text);

      FHTTPSend.Headers.Add('gumgaToken: '+strAutKey);

      FHTTPSend.HTTPMethod('GET', LLink);
      Application.ProcessMessages;

      LFDataResp := TMemoryStream.Create;
      LFDataResp.LoadFromStream(FHTTPSend.Document);

      LFDataResp.Position := 0;
      LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));


      If Pos('NO_TOKEN', LResposta) > 0 Then
         Raise Exception.Create('NO_TOKEN')
      Else If (RightStr(LResposta, 12) = 'content":[]}') Then
        lblInform.Caption := 'Não foram encontrados registros no período selecionado.';

      If FCancelarImportacao Then
        Exit;

      If FHTTPSend.ResultCode = 429 Then
      Begin
        Sleep(1000);
        LFimDoLoop := False;
        Continue;
      End;

      If FHTTPSend.ResultCode <> 200 Then
        Raise Exception.Create(LResposta);


      memXMLDoc.Lines.Clear;
      memXMLDoc.Lines.Add(LResposta);
      LFimDoLoop := True;
    Except
      On E: Exception Do
      Begin
        If Pos('NO_TOKEN', LResposta) > 0 Then
          lblInform.Caption := 'Chave de Autorização Koncili da empresa ' + strCodEmp +
                               ' está incorreta.'
        Else If (Pos('TIME OUT', UpperCase(LResposta)) > 0) Or
                (Pos('500', UpperCase(LResposta)) > 0) Or
                (E.Message = 'Time Out') Then
          lblInform.Caption := 'Problemas com o serviço da Koncili. Tente novamente mais tarde! '
        Else
          lblInform.Caption := 'Ocorreu um erro: ' + E.Message;

        frmForm.Update;

        Raise Exception.Create(lblInform.Caption + #13 +' Erro: ' +  E.Message);
      End;
    End;

    FreeAndNil(LFDataResp);
  Until LFimDoLoop;
End;

procedure TKoncilia.pProcessaDownload;
  Var
    qryDados   : IDataSet;
    itrCartoes : TKonciliaPgto;

    intTotalRegistros,
    intPosicaoCount,
    intPosicaoAtual  : Integer;

    blnPossuiRegistros: Boolean;
    LExibirMensagem : Boolean;
begin
  FCancelarImportacao := False;
  Try
    if fEmptyStr(fRetornaVersao(ExtractFilePath(Application.ExeName) + 'ssleay32.dll')) then
      raise Exception.Create('O arquivo ssleay32.dll não foi encontrado.' + #13 +
                             'Entre em contato com a Citel para realizar a atualização do arquivo.')
    Else if fEmptyStr(fRetornaVersao(ExtractFilePath(Application.ExeName) + 'libeay32.dll')) then
      raise Exception.Create('O arquivo libeay32.dll não foi encontrado.' + #13 +
                             'Entre em contato com a Citel para realizar a atualização do arquivo.')
    Else If fRetornaVersao(ExtractFilePath(Application.ExeName) + 'libeay32.dll') = '0.9.8.6' then
      raise Exception.Create('A versão do arquivo libeay32.dll está desatualizada.' + #13 +
                             'Entre em contato com a Citel para realizar a atualização do arquivo.');

    blnPossuiRegistros := False;
    LExibirMensagem := True;

    itrCartoes := TKonciliaPgto.Create;
    //Pegando os dados das empresas que possuem ID da Koncilia
    qryDados := objFunctions.fGetDataSet;
    qryDados.Close;
    qryDados.SQL := 'SELECT SIS_VALCFG, SIS_CODEMP FROM CFGSIS    ' +
                    ' WHERE SIS_CODCFG="CFG_KONKEY" AND           ' +
                    ' SIS_VALCFG IS NOT NULL AND SIS_VALCFG <> "" ' +
                    ' ORDER BY SIS_CODEMP                         ';
    qryDados.Open;
    If qryDados.RecordCount = 0 Then
    Begin
      qryDados.Close;
      objFunctions.fIMensagem('ATENÇÃO','Não existem empresas configuradas com a chave de Autorização da Koncili. Operação cancelada!',['&OK']);
      Exit;
    End;

    dtaDtaIni := edtDtaIni.Date;
    dtaDtaFin := edtDtaFin.Date;

    //correndo as empresas para fazer o download
    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      FstrAmbiente := fRetornaAmbienteKoncilia(qryDados.FieldByName('SIS_CODEMP').AsString);
      DefineUrl;

      SetLength(FRegKonPgto, 0);
      intPosicaoAtual   := 0;
      intTotalRegistros := 1;
      itrCartoes.strEmpresaAtual := qryDados.FieldByName('SIS_CODEMP').AsString;

      While (intPosicaoAtual <> -1) And (intPosicaoAtual < intTotalRegistros) Do
      Begin
        If intPosicaoAtual = 0 Then
          lblInform.Caption := 'Aguarde... Contando e efetuando o download dos registros ' +
                               ' da Empresa ' + qryDados.FieldByName('SIS_CODEMP').AsString
        Else
          lblInform.Caption := 'Aguarde... Efetuando o download dos registros ' +
                               IIF(intPosicaoAtual + 100 < intTotalRegistros, (intPosicaoAtual + 100).ToString, intTotalRegistros.ToString) +
                               ' de ' + intTotalRegistros.ToString + ' da Empresa ' + qryDados.FieldByName('SIS_CODEMP').AsString;

        If LExibirMensagem Then
        Begin
          If (intTotalRegistros >= 1000) Then
          Begin
            objFunctions.fIMensagem('AVISO','Por conta das limitações da API da Koncili a importação poderá levar alguns minutos.',['&OK']);
            LExibirMensagem := False;
          End;
        End;

        frmForm.Update;
        FImportando := True;
        pDownload(qryDados.FieldByName('SIS_VALCFG').AsString,
                  qryDados.FieldByName('SIS_CODEMP').AsString,
                  intPosicaoAtual);

        If FCancelarImportacao Then
        Begin
          lblInform.Caption := '';
          Exit;
        End;

        intPosicaoCount   := Pos('count', memXMLDoc.Text) + 7;
        intTotalRegistros := StrToInt(Copy(memXMLDoc.Text, intPosicaoCount, Pos('},', memXMLDoc.Text) - intPosicaoCount));

        If intTotalRegistros = 0 Then
          Break
        Else
          blnPossuiRegistros := True;

        Inc(intPosicaoAtual, 100);

        memXMLDoc.Text := '{' + Copy(memXMLDoc.Text, Pos('content', memXMLDoc.Text) - 1, Length(memXMLDoc.Text));
        itrCartoes.pAdicionaLinha(memXMLDoc.Text);
      End;

      If intTotalRegistros > 0 Then
      Begin
        lblInform.Caption := 'Aguarde... Gravando os lançamentos da Empresa ' + qryDados.FieldByName('SIS_CODEMP').AsString;
        frmForm.Update;
        itrCartoes.pGravarRegistros(pgbProg);
      End;

      qryDados.Next;

      If Not qryDados.Eof Then
        pgbProg.Position := 0;
      frmForm.Update;
    End;

    If blnPossuiRegistros Then
      objFunctions.fIMensagem('AVISO','Dados importados com sucesso!',['&OK']);
    
  Except
    On E: Exception Do
    Begin
      objFunctions.fIMensagem('ERRO', E.Message, ['&OK']);
      pDisableControls(False);
      Exit;
    End;
  End;

  If blnPossuiRegistros Then
    frmForm.Close
  Else
    pDisableControls(False);

  FImportando := False;
end;

procedure TKoncilia.pDisableControls(blnDisable: Boolean);
begin
  pnlFund.Enabled    := not blnDisable;
  edtDtaIni.Enabled  := not blnDisable;
  edtDtaFin.Enabled  := not blnDisable;
  edtIDConciliacao.Enabled := not blnDisable;
end;

procedure TKoncilia.pSelecionaFonte;
  Var
    lblDtaIni,
    lblDtaFin,
    lblIdCodCon: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;
Begin

  frmForm := TForm.Create(Self);
  With frmForm Do
  Begin
    BorderStyle  := bsSingle;
    Caption      := 'Importação de Registros (KONCILI)';
    ClientHeight := 115;
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
    Top      := 58;
    AutoSize := False;
    Width    := frmForm.Width;
    Alignment:= taCenter;
    Caption  := 'Digite o período para realizar a importação. Última data importada: ' + fRetUltimaData;
  End;

  memXMLDoc := TMemo.Create(frmForm);
  With memXMLDoc Do
  Begin
    Parent   := frmForm;
    Left     := 8;
    Top      := 42;
    Visible  := False;
  End;

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

  edtIDConciliacao := TEditFocus.Create(frmForm);
  edtIDConciliacao.Parent   := frmForm;
  edtIDConciliacao.Left := edtDtaIni.Left;
  edtIDConciliacao.Top := edtDtaIni.Top + 25;
  edtIDConciliacao.Width := edtDtaIni.Width;
  edtIDConciliacao.Height := 22;
  edtIDConciliacao.Alignment := taLeftJustify;
  edtIDConciliacao.MaxLength := 20;
  edtIDConciliacao.TabOrder := 2;
  edtIDConciliacao.Visible := True;
  edtIDConciliacao.FocusColor := clInfoBk;
  edtIDConciliacao.RequeridoColor := clRed;
  edtIDConciliacao.Requerido := False;
  edtIDConciliacao.CompZeros := False ;
  edtIDConciliacao.TamCampo := 20;
  edtIDConciliacao.TipoTexto := ttNumerico;

  lblIdCodCon := TLabel.Create(frmForm);
  lblIdCodCon.Parent   := frmForm;
  lblIdCodCon.Left     := 22;
  lblIdCodCon.Top      := lblDtaIni.Top + 25;
  lblIdCodCon.AutoSize := True;
  lblIdCodCon.Caption  := 'Cod. Conciliação:';


  frmForm.ShowModal;

  FreeAndNil(frmForm);
End;

function TKoncilia.RetornaLinkFormatado(APagina: Integer; ADataInicio,
  ADataFim: TDateTime; ACodConciliacao:String): String;
begin
  Result := FLinkApi;
  Result := Result.Replace('[PAGINA]',APagina.ToString);
  Result := Result.Replace('[INICIO]',FormatDateTime('yyyy-mm-dd', ADataInicio));
  Result := Result.Replace('[FIM]',FormatDateTime('yyyy-mm-dd', ADataFim));

  If Not fEmptyStr(ACodConciliacao) Then
    Result := Result + '&conciliationId=' + ACodConciliacao;
end;

end.
