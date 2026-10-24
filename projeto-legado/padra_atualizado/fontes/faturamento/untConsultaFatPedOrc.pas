unit untConsultaFatPedOrc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB, Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons,
  Grids, DBGridCitel, DBGrids, Mapi, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaFatPedOrc = class(TfrmConsultaComp)
    Panel2: TPanel;
    btnEnviarEmail: TBitBtnLocked;
    btnGerarPDF: TBitBtnLocked;
    btnBaixaPedido: TBitBtnLocked;
    btnItensPend: TBitBtnLocked;
    shpFatPar: TShape;
    lblOrdPro: TLabel;
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnBaixaPedidoClick(Sender: TObject);
    procedure btnItensPendClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    procedure pDesabilitaColunas;
    function EnviarEMail(const De, Para, Assunto, Texto, Arquivo: AnsiString; Confirma: Boolean): Integer;
    procedure pBaixaPedido(strNumDoc, strEspDoc, strCodEmp, strMotBai: String);
    procedure pMostraItensPendentes;

  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
    strEspFil: String;
    blnUltPed: Boolean;
    strOpcDoc: String;
  end;

var
  frmConsultaFatPedOrc: TfrmConsultaFatPedOrc;

implementation

uses untfuncoesSimples, untConsulta, untFatGorEmail,
  untDigEmailPedOrc, untMostraItensPendentes, untGeraPDFPedOrc;

{$R *.dfm}

Const
  COR_FATPARCIAL = clLtGray;

procedure TfrmConsultaFatPedOrc.btnEnviarEmailClick(Sender: TObject);
  Var
    strArqHtml          : String;
    strTexto            : String;
    strAssunto          : String;
    strDestinatario     : String;
    strEmailDestinatario: String;
    strOrdem : String;
    strTipExp: String;
    blnComPre,
    blnComMar,
    blnLocFis: Boolean;
    strModo  : String;
begin
  inherited;
  blnComPre := False;
  blnComMar := False;
  blnLocFis := False;
  strAssunto := '';
  strDestinatario      := qryConsulta.FieldByName('Nome').AsString;
  strEmailDestinatario := qryConsulta.FieldByName('CLI_EMAIL_').AsString;

  Try
    pCriarFormularios(TfrmDigEmailPedOrc, frmDigEmailPedOrc);
    frmDigEmailPedOrc.edtEmail.Text   := strEmailDestinatario;
    frmDigEmailPedOrc.edtContato.Text := strDestinatario;
    blnConfirma := (frmDigEmailPedOrc.ShowModal = mrOk);

    If (blnConfirma) Then
    Begin
      strDestinatario      := frmDigEmailPedOrc.edtContato.Text;
      strEmailDestinatario := frmDigEmailPedOrc.edtEmail.Text;
      blnComPre            := frmDigEmailPedOrc.blnComPre;
      blnComMar            := frmDigEmailPedOrc.chkMarca.Checked;
      blnLocFis            := frmDigEmailPedOrc.chkLocFis.Checked;
      strTipExp            := frmDigEmailPedOrc.strTipExp;
      strOrdem             := frmDigEmailPedOrc.edtOrdem.Text;
      strModo              := frmDigEmailPedOrc.edtModo.Text;
    End;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmConsultaFatPedOrc.btnEnviarEmailClick]');
    End;
  End;
  pFreeAndNil(frmDigEmailPedOrc);

  If (Not blnConfirma) Then
    Exit;

  {*******************************************}
  {* RETORNA A VARIAVEL strNomeArquivo       *}
  {****************************************AC*}
  Try
    pCriarFormularios(TfrmFatGorEmail, frmFatGorEmail);
    strArqHtml := frmFatGorEmail.fGeraEmail(qryConsulta.FieldByName('Documento').AsString,
                                            qryConsulta.FieldByName('Especie').AsString,
                                            blnComPre,
                                            blnComMar,
                                            strTipExp,
                                            strModo,
                                            strOrdem,
                                            qryConsulta.FieldByName('Empresa').AsString,
                                            blnLocFis,
                                            'R',
                                            qryConsulta.FieldByName('FGO_CODCLI').AsString);
  Finally
    pDestroiModulo(frmFatGorEmail);
  End;

  If (Not fEmptyStr(strArqHtml)) Then
  Begin

    {************************************************}
    {* AQUI É GERADO O EMAIL E EXPORTADO EM PDF     *}
    {*********************************************AC*}
    If (qryConsulta.FieldByName('Especie').AsString = 'PD') Then
    Begin
      strAssunto := 'Pedido Nº: ';
      strTexto := 'Segue em anexo Pedido.';
    End
    Else
    Begin
      strAssunto := 'Orçamento Nº: ';
      strTexto := 'Segue em anexo Orçamento.';
    End;

    If strTipExp = 'P' Then
    Begin
      strTexto := strTexto + #13#10 + #13#10;
      strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
      strTexto := strTexto + 'acesse o link e faça o download: www.adobe.com';
    End;

    strAssunto := fRetNomeEmpresa + ' - ' + strAssunto + qryConsulta.FieldByName('Documento').AsString;

    EnviarEMail('', AnsiString(strEmailDestinatario), AnsiString(strAssunto), AnsiString(strTexto), AnsiString(strArqHtml), True);
    SetForegroundWindow(Handle);
  End
  Else
    fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);

end;

procedure TfrmConsultaFatPedOrc.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaFatPedOrc.pDesabilitaColunas;
begin
  If qryConsulta.Active Then
  Begin
    qryConsulta.FieldByName('CLI_EMAIL_').Visible := False;

    If blnUltPed Then
    Begin
      qryConsulta.FieldByName('FGO_NUMDOC').Visible := False;
      qryConsulta.FieldByName('FGO_NOMCON').Visible := False;
      qryConsulta.FieldByName('CLI_NOMCLI').Visible := False;
      qryConsulta.FieldByName('FGO_CODVEN').Visible := False;
      qryConsulta.FieldByName('FGO_DTAENT').Visible := False;
      qryConsulta.FieldByName('TRA_NOMTRA').Visible := False;
      qryConsulta.FieldByName('CID_NOMCID').Visible := False;
      qryConsulta.FieldByName('FGO_PEDSIT').Visible := False;
    End;

    {******************************}
    {* VERIFICA SE O CAMPO EXISTE *}
    {***************************DP*}
    If qryConsulta.FindField('Status Dep. Financeiro') <> Nil Then
      If strEspFil <> 'PD' Then
        qryConsulta.FieldByName('Status Dep. Financeiro').Visible := False;

    If (qryConsulta.FieldByName('Especie').AsString = 'OR') Then
      btnBaixaPedido.Caption := '[F10] Baixar Orçamentos que não serão entregues';

    btnBaixaPedido.Visible := (qryConsulta.FieldByName('Especie').AsString = 'PD') Or
                              (Pos(strOpcDoc, 'TE_OU') > 0);
    btnItensPend.Visible := btnBaixaPedido.Visible;
  End;
end;

procedure TfrmConsultaFatPedOrc.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaFatPedOrc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F9) Then
    btnEnviarEmail.Click;
  If (Key = VK_F8) Then
    btnGerarPDF.Click;
  If (Key = VK_F10) Then
    btnBaixaPedido.Click;
  If (Key = VK_F11) Then
    btnItensPend.Click;
end;

procedure TfrmConsultaFatPedOrc.btnConfirmaClick(Sender: TObject);
begin
  inherited;
end;

{***********************************************}
{* FUNÇÃO QUE ABRE O OUTLOOK E ANEXO O ARQUIVO *}
{********************************************AC*}
function TfrmConsultaFatPedOrc.EnviarEMail(const De, Para, Assunto, Texto, Arquivo: AnsiString; Confirma: Boolean): Integer;
var
  Msg: TMapiMessage;
  lpSender, lpRecepient: TMapiRecipDesc;
  FileAttach: TMapiFileDesc;
  SM: TFNMapiSendMail;
  MAPIModule: HModule;
  Flags: Cardinal;
begin
  // cria propriedades da mensagem
  FillChar(Msg, SizeOf(Msg), 0);
  with Msg do
    begin
      if (Assunto <> '') then
        lpszSubject := PAnsiChar(Assunto);
       if (Texto <> '') then
        lpszNoteText := PAnsiChar(Texto);

      // remetente
      if (De <> '') then
        begin
          lpSender.ulRecipClass := MAPI_ORIG;
          lpSender.lpszName     := AnsiLower(PAnsiChar(De));
          lpSender.lpszAddress  := AnsiLower(PAnsiChar(De));
          lpSender.ulReserved   := 0;
          lpSender.ulEIDSize    := 0;
          lpSender.lpEntryID    := nil;
          lpOriginator          := @lpSender;
        end;

      // destinatário
      if (Para <> '') then
        begin
          lpRecepient.ulRecipClass := MAPI_TO;
          lpRecepient.lpszName     := AnsiLower(PAnsiChar(Para));
          lpRecepient.lpszAddress  := PAnsiChar('SMTP:' + AnsiString(AnsiLowerCase(String(Para))));
          lpRecepient.ulReserved   := 0;
          lpRecepient.ulEIDSize    := 0;
          lpRecepient.lpEntryID    := nil;
          nRecipCount              := 1;
          lpRecips                 := @lpRecepient;
        end
      else
        lpRecips := nil;

      // arquivo anexo
      if (Arquivo = '') then
        begin
          nFileCount := 0;
          lpFiles    := nil;
        end
      else
        begin
          {*******************************************}
          {* ANEXA A IMAGEM TAMBÉM SE NECESSARIO     *}
          {* SÓ É PRECISO CRIAR UMA NOVA VARIÁVEL    *}
          {* FileAttach E ACRESCENTAR MAIS UM        *)
          {* PARÂMETRO Arquivo NA FUNÇÃO             *)
          {****************************************AC*}
          FillChar(FileAttach, SizeOf(FileAttach), 0);
          FileAttach.nPosition    := Cardinal($FFFFFFFF);
          FileAttach.lpszPathName := PAnsiChar(Arquivo);
          nFileCount              := 1;
          lpFiles                 := @FileAttach;
        end;
    end;
  // carrega dll e o método para envio do email
  MAPIModule := LoadLibrary(PChar(MAPIDLL));
  if MAPIModule = 0 then
    Result := -1
  else
    try
      if Confirma then
        Flags := MAPI_DIALOG or MAPI_LOGON_UI
      else
        Flags := 0;
      @SM := GetProcAddress(MAPIModule, 'MAPISendMail');
      if @SM <> nil then
        Result := SM(0, Application.Handle, Msg, Flags, 0)
      else
        Result := 1;
    finally
      FreeLibrary(MAPIModule);
    end;
end;

procedure TfrmConsultaFatPedOrc.btnGerarPDFClick(Sender: TObject);
Var
  strArquivo: String;
  strOrdem  : String;
  blnComMar : Boolean;
  blnLocFis : Boolean;
  strModo   : String;
begin
  blnLocFis := False;
  blnComMar := False;
  inherited;
  Try
    pCriarFormularios(TfrmGeraPDFPedOrc, frmGeraPDFPedOrc);
    blnConfirma := (frmGeraPDFPedOrc.ShowModal = mrOk);

    If (blnConfirma) Then
    Begin
      strOrdem  := frmGeraPDFPedOrc.edtOrdem.Text;
      blnComMar := frmGeraPDFPedOrc.chkMarca.Checked;
      blnLocFis := frmGeraPDFPedOrc.chkLocFis.Checked;
      strModo   := frmGeraPDFPedOrc.edtModo.Text;
    End;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmConsultaFatPedOrc.btnGerarPDFClick]');
    End;
  End;
  pFreeAndNil(frmGeraPDFPedOrc);

  If (Not blnConfirma) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatGorEmail, frmFatGorEmail);

    strArquivo := frmFatGorEmail.fGeraEmail(qryConsulta.FieldByName('Documento').AsString,
                                            qryConsulta.FieldByName('Especie').AsString,
                                            True,
                                            blnComMar,
                                            'P',
                                            strModo,
                                            strOrdem,
                                            qryConsulta.FieldByName('Empresa').AsString,
                                            blnLocFis,
                                            'R',
                                            qryConsulta.FieldByName('FGO_CODCLI').AsString);
  Finally
    pDestroiModulo(frmFatGorEmail);
  End;

  If (Not fEmptyStr(strArquivo)) Then
    pExecArquivo(strArquivo, Handle);
end;

procedure TfrmConsultaFatPedOrc.btnBaixaPedidoClick(Sender: TObject);
  Var
    strMotivo: String;
begin
  inherited;

  If (Not btnBaixaPedido.Visible) Then
    Exit;

  If (qryConsulta.IsEmpty) Then
    Exit;

  If Not fVerificaAcessoSistema('BAIPDV', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  strMotivo := InputBox('Favor Digitar o Motivo da Baixa','Motivo : ','');

  If fEmptyStr(strMotivo) Then
    Exit;

  fStartTransaction;

  Try
    pBaixaPedido(qryConsulta.FieldByName('Documento').AsString,
                 qryConsulta.FieldByName('Especie').AsString,
                 qryConsulta.FieldByName('Empresa').AsString,
                 strMotivo);

    fCommit;

    edtFiltro1Change(edtFiltro1);
    
    If qryConsulta.FieldByName('Especie').AsString = 'PD' Then
      fMensagem('', 'Pedido baixado com sucesso!', ['&Ok'])
    Else
      fMensagem('', 'Orçamento baixado com sucesso!', ['&Ok']);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[Baixar Pedidos]');
    End;
  End;

end;

procedure TfrmConsultaFatPedOrc.pBaixaPedido(strNumDoc, strEspDoc, strCodEmp,
  strMotBai: String);
  Var
    qryUpdate: TUniQuery;
    strMotAju: String;

    function fAjustaMotivoBaixa(strMotBai: String): String;
    Begin
      Result := '';
      Result := Result + 'DADOS BAIXA: ' + FormatDateTime('DD/MM/YYYY', VS_Date) + ' - ' +
                                           FormatDateTime('HH:MM:SS', Time)      + ' '   +
                                           'OPE: ' + strLoginUsuarioLogado       + ' '   +
                                           'MOTIVO: ' + strMotBai;
    End;

begin

  strMotAju := fAjustaMotivoBaixa(strMotBai);

  qryUpdate := fCriaQuery(Self);
  qryUpdate.SQL.Add('UPDATE ');
  qryUpdate.SQL.Add('  FATGOR ');
  qryUpdate.SQL.Add('SET ');
  qryUpdate.SQL.Add('  FGO_JAFATU = 1, ');
  qryUpdate.SQL.Add('  FGO_MOTBAI = :MOTBAI ');
  qryUpdate.SQL.Add('WHERE ');
  qryUpdate.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
  qryUpdate.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
  qryUpdate.SQL.Add('  FGO_CODEMP = :CODEMP ');

  qryUpdate.ParamByName('MOTBAI').AsString := strMotAju;

  qryUpdate.ParamByName('NUMDOC').AsString := strNumDoc;
  qryUpdate.ParamByName('ESPDOC').AsString := strEspDoc;
  qryUpdate.ParamByName('CODEMP').AsString := strCodEmp;

  qryUpdate.ExecSQL;

  qryUpdate.SQL.Clear;
  qryUpdate.SQL.Add('UPDATE ');
  qryUpdate.SQL.Add('  FATDOR ');
  qryUpdate.SQL.Add('SET ');
  qryUpdate.SQL.Add('  FDO_JAFATU = 1 ');
  qryUpdate.SQL.Add('WHERE ');
  qryUpdate.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryUpdate.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryUpdate.SQL.Add('  FDO_CODEMP = :CODEMP ');

  qryUpdate.ParamByName('NUMDOC').AsString := strNumDoc;
  qryUpdate.ParamByName('ESPDOC').AsString := strEspDoc;
  qryUpdate.ParamByName('CODEMP').AsString := strCodEmp;

  qryUpdate.ExecSQL;

  FreeAndNil(qryUpdate);
end;

procedure TfrmConsultaFatPedOrc.pMostraItensPendentes;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  FDO_CODITE AS PCD_CODITE, ');
  qryAux.SQL.Add('  FDO_DESCRI AS PCD_DESITE, ');
  qryAux.SQL.Add('  UNI_SIGUNI AS UNI_SIGUNI, ');
  qryAux.SQL.Add('  FORMAT(FDO_QTDITE, ' + fCfgSis('DEQTPC') + ')  AS PCD_QTDITE, ');
  qryAux.SQL.Add('  FORMAT(FDO_QTDBAI, ' + fCfgSis('DEQTPC') + ')  AS PCD_QTDBAI, ');
  qryAux.SQL.Add('  FORMAT(IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI), 2) AS PCD_QTDRES ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  FATDOR ');
  qryAux.SQL.Add('  JOIN CADITE ON ITE_CODITE = FDO_CODITE ');
  qryAux.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FDO_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI) > 0 ');
  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  FDO_DESCRI ');

  qryAux.ParamByName('NUMDOC').AsString := qryConsulta.FieldByName('Documento').AsString;
  qryAux.ParamByName('ESPDOC').AsString := qryConsulta.FieldByName('Especie').AsString;
  qryAux.ParamByName('CODEMP').AsString := qryConsulta.FieldByName('Empresa').AsString;

  qryAux.Open;

  Try
    pCriarFormularios(TfrmMostraItensPendentes, frmMostraItensPendentes);
    frmMostraItensPendentes.dtsPedido.DataSet := qryAux;
    frmMostraItensPendentes.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmConsultaFatPedOrc.pMostraItensPendentes]');
  End;

  pFreeAndNil(frmMostraItensPendentes);
  qryAux.Close;
  FreeAndNil(qryAux);

end;

procedure TfrmConsultaFatPedOrc.btnItensPendClick(Sender: TObject);
begin
  inherited;
  If (Not btnItensPend.Enabled) Or (Not btnItensPend.Visible) Then
    Exit;

  If (qryConsulta.IsEmpty) Then
    Exit;

  pMostraItensPendentes;
end;

procedure TfrmConsultaFatPedOrc.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  {***************************************}
  {* FAZ A VERIFICACAO SE EXISTE O CAMPO *}
  {************************************DP*}
  If qryConsulta.FindField('QTDABE') <> nil Then
    If qryConsulta.FieldByName('QTDABE').AsInteger > 0 Then
      dbgConsulta.Canvas.Brush.Color := COR_FATPARCIAL;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmConsultaFatPedOrc.FormShow(Sender: TObject);
begin
  inherited;
  shpFatPar.Brush.Color := COR_FATPARCIAL;
  shpFatPar.Pen.Color   := clBlack;
end;

end.

