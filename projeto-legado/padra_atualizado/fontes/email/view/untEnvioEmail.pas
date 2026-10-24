unit untEnvioEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, untTEnvioEmail, ShlObj, EditFocus, untEditorHtml, MSHTML,
  untTypesSistema, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxListBox, untModulo, MemoFocus, System.SysUtils,
  System.StrUtils, System.Types;

type
  TfrmEnvioEmail = class(TfrmPai)
    grbRemetente: TGroupBox;
    grbDestinatarios: TGroupBox;
    grbAnexos: TGroupBox;
    grbMensagem: TGroupBox;
    edtNomeRem: TEditFocus;
    edtPara: TMemoFocus;
    edtComCopia: TMemoFocus;
    edtComCopiaOculta: TMemoFocus;
    lsbAnexos: TListBox;
    ppmAnexos: TPopupMenu;
    btnRemoverPop: TMenuItem;
    btnRemoverTodosPop: TMenuItem;
    btnEnviar: TBitBtnLocked;
    openDialog: TOpenDialog;
    pnlAssunto: TPanel;
    edtAssunto: TEditFocus;
    lblAssunto: TLabel;
    pnlEditor: TPanel;
    lblNomRem: TLabel;
    lblPara: TLabel;
    lblComCopia: TLabel;
    lblComCopiaOculta: TLabel;
    N1: TMenuItem;
    btnAbrirArquivo: TMenuItem;
    chkImportante: TCheckBox;
    pnlBotoesAnexos: TPanel;
    btnInserirAnexo: TSpeedButton;
    btnRemoverAnexos: TSpeedButton;
    btnCatPara: TSpeedButton;
    btnCatComCopia: TSpeedButton;
    btnCatComCopiaOculta: TSpeedButton;
    ppmInserir: TPopupMenu;
    btnArqvsOcorrenciaPop: TMenuItem;
    btnInserirPop: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure btnRemoverAnexosClick(Sender: TObject);
    procedure btnInserirAnexoClick(Sender: TObject);
    procedure btnRemoverPopClick(Sender: TObject);
    procedure btnRemoverTodosPopClick(Sender: TObject);
    procedure lsbAnexosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAbrirArquivoClick(Sender: TObject);
    procedure edtParaChange(Sender: TObject);
    procedure edtParaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCatParaClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnArqvsOcorrenciaPopClick(Sender: TObject);
    procedure btnInserirPopClick(Sender: TObject);
  private
    { Private declarations }
    objEmail                         : TEnvioEmail;
    strArqTmpHtmEmail,
    strPathTmpEmail,
    strPathDirAnexosOcorrencia    : String;
    FEditorHtml                   : TfrmEditorHtml;
    FblnHabilitaDivisaoAnexoPorEmail : Boolean;

    objListaContatos: TListaContatosEmail;

    FEmail,
    FLogin,
    FSenha,
    FRemetente,
    FTextoAssinatura: String;

    FProvedor: Integer;

    FImagemAssinatura: TMemoryStream;

    FImagemAssinaturaValida: Boolean;

    FCodOco : String;
    procedure LimparFormulario;
    procedure CarregarAssinaturaEmail();
    function  URLEncoded(const url: String): String;
    procedure AdicionarAnexo(arquivo: String);

    function fConfirmarEnvioEmailPorTamanhoAnexos(
      const intTamanhoReferenciaEmMB: Integer;
      var lstAnexosPorEmail: TStrings): Boolean;

    procedure pCarregaAnexosEmails(const intTamanhoReferenciaEmMB: Integer;
      var lstAnexosPorEmail: TStrings);

    procedure SetHabilitaDivisaoAnexoPorEmail(const Value: Boolean);
    procedure pCarregaDestinatarios;

    procedure EnviarMensagemPorDestinatarios;

    procedure RetonaEmailCampoDestinatarios(var AListaEmails: TStringList;
                                            ATotalDestinatarios: Integer;
                                            var ATotalSelecionados: Integer;
                                            ATipo: Integer);
    function ValidaDirAnexoOcorrencia : Boolean;
    procedure AbreDirWindows(ADirAnexosOcorrencia : Boolean);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strAssunto: String;
    arrPara, arrComCopia, arrComCopiaOculta, arrCorpoMensagem, arrAnexos: TStringArray;

    blnImportante, blnFinalizar, blnEnviado, blnVisualizar, blnAdicionaUmParagrafoPorLinha: Boolean;

    strEmail: TArrStrEmails;

    AThreadEmail: TThreadSincronizaEmails;
    FDuplicatasEnvio : TArrDupTabelaEmail;
    blnGravarAnexos: Boolean;
    blnIgnorarEmailsInvalidos: Boolean;

    //Para email fixo quando utilizar modelo
    property Email: String read FEmail write FEmail;
    property Login: String read FLogin write FLogin;
    property Senha: String read FSenha write FSenha;
    property Remetente: String read FRemetente write FRemetente;
    property TextoAssinatura: String read FTextoAssinatura write FTextoAssinatura;
    property Provedor: Integer read FProvedor write FProvedor;
    property ImagemAssinatura: TMemoryStream read FImagemAssinatura write FImagemAssinatura;
    property ImagemAssinaturaValida: Boolean read FImagemAssinaturaValida write FImagemAssinaturaValida Default False;

    property blnHabilitaDivisaoAnexoPorEmail : Boolean write SetHabilitaDivisaoAnexoPorEmail;
    property CodOco: String read FCodOco write FCodOco;
  end;

var
  frmEnvioEmail: TfrmEnvioEmail;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando, untConsultaContatosEmail;

procedure TfrmEnvioEmail.AbreDirWindows(ADirAnexosOcorrencia : Boolean);
var
  intContador: Integer;
  strAnexo : String;
begin
  If ADirAnexosOcorrencia Then
    openDialog.InitialDir := strPathDirAnexosOcorrencia
  Else
    openDialog.InitialDir := EmptyStr;

  If (openDialog.Execute) Then
  Begin
    For intContador:= 0 To Pred(openDialog.Files.Count) Do
    Begin
      strAnexo := openDialog.Files[intContador];
      If (lsbAnexos.Items.IndexOf(strAnexo) = -1) then
        AdicionarAnexo(strAnexo);
    End;
  End;
end;

procedure TfrmEnvioEmail.AdicionarAnexo(arquivo: String);
var
  anexoTmp: TAnexo;
begin
  anexoTmp:= TAnexo.Create(arquivo);

  If fEmptyStr(anexoTmp.arquivo) Then
    Exit;

  objEmail.mensagem.AdicionarAnexo(anexoTmp);

  If (objEmail.mensagem.anexos.arquivosAnexados.Count > 0) and
    (arquivo = objEmail.mensagem.anexos.
    arquivosAnexados[objEmail.mensagem.anexos.arquivosAnexados.Count - 1].arquivo) Then
      lsbAnexos.Items.Add(objEmail.mensagem.anexos.
        arquivosAnexados[objEmail.mensagem.anexos.arquivosAnexados.Count - 1].descricao);
end;

procedure TfrmEnvioEmail.btnAbrirArquivoClick(Sender: TObject);
  var
    i: Integer;
begin
  inherited;

  If (lsbAnexos.ItemIndex <> -1) Then Begin
    For i := 0 To objEmail.mensagem.anexos.arquivosAnexados.Count - 1 Do Begin
      If (lsbAnexos.Items[lsbAnexos.ItemIndex] = objEmail.mensagem.anexos.arquivosAnexados[i].descricao) Then
        pExecArquivo(objEmail.mensagem.anexos.arquivosAnexados[i].arquivo, Handle);
    End;
  End;
end;

procedure TfrmEnvioEmail.btnArqvsOcorrenciaPopClick(Sender: TObject);
begin
  inherited;
  AbreDirWindows(True);
end;

procedure TfrmEnvioEmail.btnCatParaClick(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtPara.Text)) And (Not fValidaCampos(edtPara, True)) Then
    Exit;

  If (Not fEmptyStr(edtComCopia.Text)) And (Not fValidaCampos(edtComCopia, True)) Then
    Exit;

  If (Not fEmptyStr(edtComCopiaOculta.Text)) And (Not fValidaCampos(edtComCopiaOculta, True)) Then
    Exit;

  Try
    pCriarFormularios(TfrmConsultaContatosEmail, frmConsultaContatosEmail);
    frmConsultaContatosEmail.strPara           := edtPara.Text;
    frmConsultaContatosEmail.strComCopia       := edtComCopia.Text;
    frmConsultaContatosEmail.strComCopiaOculta := edtComCopiaOculta.Text;
    frmConsultaContatosEmail.intTipoDestino    := IIF(TSpeedButton(Sender) = btnCatPara,
                                                      IDX_PARA,
                                                      IIF(TSpeedButton(Sender) = btnCatComCopia,
                                                          IDX_COM_COPIA,
                                                          IDX_COM_COPIA_OCULTA
                                                      )
                                                  );

    frmConsultaContatosEmail.ShowModal();

    edtPara.Text           := frmConsultaContatosEmail.strPara;
    edtComCopia.Text       := frmConsultaContatosEmail.strComCopia;
    edtComCopiaOculta.Text := frmConsultaContatosEmail.strComCopiaOculta;

    objListaContatos.pAtualizarListaContatos();
  Finally
    FreeAndNil(frmConsultaContatosEmail);
  End;
end;

procedure TfrmEnvioEmail.btnEnviarClick(Sender: TObject);
Var
  lstAnexosSeparadoEmails : TStrings;
  lstAnexos               : TStrings;
  intCount                : Integer;
  strAssuntoOriginal      : String;
  strArquivoAnexo         : String;

  Procedure ProcessarHtmlMensagem();
    var
      idx: Integer;
      HTMLImgElement: IHTMLImgElement;
      HTMLElementCollection: IHTMLElementCollection;

      LNomeArquivo: String;
  Begin
    objEmail.mensagem.corpoHtml := True;
    objEmail.mensagem.corpoMensagem.Text := FEditorHtml.WebBrowser.OleObject.Document.documentElement.innerHTML;

    HTMLElementCollection := (FEditorHtml.WebBrowser.Document as IHTMLDocument2).Images;

    for idx := 0 to HTMLElementCollection.Length - 1 do
    begin
      HTMLImgElement := (HTMLElementCollection.item(idx, 0) as IHTMLImgElement);

      If LeftStr(HTMLImgElement.src, 8) = 'file:///' Then
      Begin
        LNomeArquivo := URLEncoded(HTMLImgElement.src).Replace('file:///', EmptyStr).Replace('/', '\');
        If Not FileExists(LNomeArquivo) Then
        Begin
          fMensagem('ATENÇÃO',
                    'Uma imagem que foi adicionada no corpo do email não existe no caminho: ' +
                          LNomeArquivo + '.' + #13 +
                          'O email será enviado, mas essa imagem não será exibida.' + #13 +
                          'É necessário realizar a correção do modelo do email nas configurações.',
                    ['&Ok']);


          Continue;
        End;
      End;

      objEmail.mensagem.AdicionarImagemCorpoHtml(URLEncoded(HTMLImgElement.src));
    end
  End;

begin
  inherited;
  lstAnexosSeparadoEmails := Nil;
  lstAnexos               := Nil;

  If FblnHabilitaDivisaoAnexoPorEmail Then
  Begin
    If not fConfirmarEnvioEmailPorTamanhoAnexos(fCfgSis('TAMANX', varInteger), lstAnexosSeparadoEmails) Then
      Exit;
  End
  Else
    pCarregaAnexosEmails(0, lstAnexosSeparadoEmails);

  Self.Enabled := False;

  edtPara.Tag := 99;
  edtComCopia.Tag := 99;
  edtComCopiaOculta.Tag := 99;

  Try
    If (fVerificaCampos()) Then
    Begin
      //adiciona mensagem - criação do arquivo HTML
      ProcessarHtmlMensagem();

      //define se a mensagem é importante
      objEmail.importante       := chkImportante.Checked;
      objEmail.ThreadSincEmail  := AThreadEmail;
      objEmail.UsarAntiFreeze   := True;
      objEmail.DuplicatasEnvio  := FDuplicatasEnvio;

      strAssuntoOriginal        := objEmail.mensagem.assunto;
      lstAnexos                 := TStringList.Create;
      lstAnexos.Delimiter       := ';';
      lstAnexos.StrictDelimiter := True;

      objEmail.blnLimparDados := True;
      For intCount := 0 To Pred(lstAnexosSeparadoEmails.Count) Do
      Begin
        lstAnexos.Clear;
        If lstAnexosSeparadoEmails.Count > 1 Then
        Begin
          objEmail.mensagem.assunto := strAssuntoOriginal
                                     + ' - Email ' + (intCount+1).ToString
                                     + ' de ' + lstAnexosSeparadoEmails.Count.ToString;

          objEmail.mensagem.RemoverTodosAnexos;

          lstAnexos.DelimitedText := lstAnexosSeparadoEmails.Strings[intCount];
          If (lstAnexos.Count > 0) And
             (Not lstAnexos.Strings[0].IsEmpty) Then
          Begin
            For strArquivoAnexo In lstAnexos Do
            Begin
              objEmail.mensagem.AdicionarAnexo(TAnexo.Create(strArquivoAnexo));
              Application.ProcessMessages();
            End;
          End;

          objEmail.blnLimparDados := False;
        End;

        //envia mensagem
        Application.ProcessMessages();
        If objEmail.dadosAutenticacao.QuantidadeDestinatarios = 0 Then
          TfrmGravando.fExecutarModal(objEmail.EnviarMensagem, 'Aguarde, enviando e-Mail...', '')
        Else
          EnviarMensagemPorDestinatarios;
      End;

      If (objEmail.enviado) Then
      Begin
        fMensagem('Enviado', 'Mensagem enviada com sucesso!', ['&Ok']);
        LimparFormulario();
        blnEnviado := True;

        If (blnFinalizar) Then
          btnSair.Click();
      End;
    End;
  Finally
    Self.Enabled := True;

    If Assigned(lstAnexosSeparadoEmails) Then
      FreeAndNil(lstAnexosSeparadoEmails);

    If Assigned(lstAnexos) Then
      FreeAndNil(lstAnexos);
  End;
end;

procedure TfrmEnvioEmail.btnInserirAnexoClick(Sender: TObject);
var
  pntPosicao: TPoint;
begin
  If ValidaDirAnexoOcorrencia Then
  Begin
    pntPosicao :=  btnInserirAnexo.ClientToScreen(Point(0,0));
    ppmInserir.Popup(pntPosicao.X, pntPosicao.Y);
  End
  Else
    AbreDirWindows(False);
end;

procedure TfrmEnvioEmail.btnInserirPopClick(Sender: TObject);
begin
  inherited;
  AbreDirWindows(False);
end;

procedure TfrmEnvioEmail.btnRemoverAnexosClick(Sender: TObject);
begin
  inherited;

  btnRemoverPop.Click();
end;

procedure TfrmEnvioEmail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If (FileExists(strArqTmpHtmEmail)) Then
    DeleteFile(strArqTmpHtmEmail);

  objEmail.ApagarImagemAssinaturaEmail;

  If (Assigned(FEditorHtml)) Then
  Begin
    FEditorHtml.Close();
    FEditorHtml.Release();
    FreeAndNil(FEditorHtml);
  End;

  FreeAndNil(objEmail);

  inherited;
end;

procedure TfrmEnvioEmail.FormCreate(Sender: TObject);
begin
  inherited;

  FEditorHtml       := nil;
  strArqTmpHtmEmail := '';
  strPathTmpEmail   := '';

  blnVisualizar     := False;
  blnEnviado        := False;
  blnFinalizar      := False;
  blnImportante     := False;

  strAssunto        := '';
  arrPara           := [];
  arrComCopia       := [];
  arrComCopiaOculta := [];
  arrCorpoMensagem  := [];
  arrAnexos         := [];

  edtPara.OnKeyDown           := pOnKeyDownEdits;
  edtComCopia.OnKeyDown       := pOnKeyDownEdits;
  edtComCopiaOculta.OnKeyDown := pOnKeyDownEdits;

  blnAdicionaUmParagrafoPorLinha := True;
  blnGravarAnexos := False;
  FblnHabilitaDivisaoAnexoPorEmail := False;
end;

procedure TfrmEnvioEmail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) And (Assigned(objListaContatos)) And (objListaContatos.lsbContatos.Visible) Then Begin
    objListaContatos.pExibirListagem(False);
    Key := 0;
  End;

  If (Assigned(Self.ActiveControl)) And
     (objListaContatos.lsbContatos.Visible) And
     (
       ((Self.ActiveControl) = edtPara)     Or
       ((Self.ActiveControl) = edtComCopia) Or
       ((Self.ActiveControl) = edtComCopiaOculta)
     ) Then Begin
    If (Key = VK_ESCAPE) Then Begin
      objListaContatos.pExibirListagem(False);
      Key := 0;
    End Else If (Key = VK_RETURN) Then Begin
      If (Not fEmptyStr(objListaContatos.pSelecionarFiltroString(TEditFocus(Self.ActiveControl).Text))) Then Begin
        objListaContatos.pSelecionarContato(0); //seleciona o primeiro registro
        Key := 0;
      End Else Begin
        fValidaCampos(TEditFocus(Self.ActiveControl), True);
      End;
    End;
  End;

  inherited;

  If (Key = VK_F5) Then Begin
    If ((Self.ActiveControl) = edtPara) Then
      btnCatPara.Click();

    If ((Self.ActiveControl) = edtComCopia) Then
      btnCatComCopia.Click();

    If ((Self.ActiveControl) = edtComCopiaOculta) Then
      btnCatComCopiaOculta.Click();
  End;
end;

procedure TfrmEnvioEmail.FormPaint(Sender: TObject);
begin
  inherited;
  If Not blnVisualizar Then
    Self.Close;
end;

procedure TfrmEnvioEmail.pCarregaDestinatarios;
begin
  If (Length(arrPara) > 0) Then
  Begin
    edtPara.Text := String.Join('; ', arrPara);
    Application.ProcessMessages;
  End;

  If (Length(arrComCopia) > 0) Then
  Begin
    edtComCopia.Text := String.Join('; ', arrComCopia);
    Application.ProcessMessages;
  End;

  If (Length(arrComCopiaOculta) > 0) Then
  Begin
    edtComCopiaOculta.Text := String.Join('; ', arrComCopiaOculta);
    Application.ProcessMessages;
  End;
end;

procedure TfrmEnvioEmail.FormShow(Sender: TObject);
  Var
    i: Integer;
begin
  inherited;
  objEmail := TEnvioEmail.Create(Self, False, '', 0);
  objEmail.horaEnvio := fNow();

  If Not FEmail.IsEmpty Then
  Begin
    If FProvedor > 0 Then
    Begin
      objEmail.DefinirDadosAutenticacao(FProvedor,
                                        FLogin,
                                        FEmail,
                                        FSenha,
                                        FRemetente,
                                        strLoginUsuarioLogado);

      objEmail.dadosAutenticacao.textoAssinatura := TStringList.Create;
      objEmail.dadosAutenticacao.textoAssinatura.Text := FTextoAssinatura;
      objEmail.dadosAutenticacao.imagemAssinaturaValida := FImagemAssinaturaValida;

      If (FImagemAssinaturaValida) Then
      Begin
        objEmail.dadosAutenticacao.imagemAssinatura := TMemoryStream.Create;

        If FImagemAssinatura <> Nil Then
        Begin
          FImagemAssinatura.SaveToStream(objEmail.dadosAutenticacao.ImagemAssinatura);
          objEmail.dadosAutenticacao.ImagemAssinatura.Seek(0,soFromBeginning);
        End;
      End
      Else
        objEmail.dadosAutenticacao.ImagemAssinatura := nil;

      if objEmail.dadosAutenticacao.strRemetente.IsEmpty Then
        objEmail.dadosAutenticacao.strRemetente := FRemetente;
    End;
  End;

  edtPara.OnKeyDown           := pOnKeyDownEdits;
  edtComCopia.OnKeyDown       := pOnKeyDownEdits;
  edtComCopiaOculta.OnKeyDown := pOnKeyDownEdits;

  blnVisualizar := objEmail.dadosAutenticacao.EhValido();
  blnIgnorarEmailsInvalidos := False;

  If (blnVisualizar) Then
  Begin

    If Not fEmptyStr(objEmail.dadosAutenticacao.strRemetente) Then
      edtNomeRem.Text := objEmail.dadosAutenticacao.strRemetente + ' (' + objEmail.dadosAutenticacao.usuario + ')'
    Else
      edtNomeRem.Text := objEmail.dadosAutenticacao.nomeOpe + ' (' + objEmail.dadosAutenticacao.usuario + ')';

    If (ValidarDiretorioEmail(strPathTmpEmail)) Then
      objListaContatos := TListaContatosEmail.Create(Self, objEmail.dadosAutenticacao.codOpe, toMenuSuspenso)
    Else
    Begin
      blnVisualizar := False;
      fMensagem('Alerta', 'Diretório temporário para envio de e-Mail não foi encontrado ou não pode ser criado.'
        +#13#10+'Entre em contato com o suporte Citel.', ['&Ok']);
    End;

  End;

  CarregarAssinaturaEmail();

  objEmail.mensagem.blnGravarAnexosPath := blnGravarAnexos;
  objEmail.mensagem.blnIgnorarEmailsInvalidos := blnIgnorarEmailsInvalidos;

  If (Not fEmptyStr(strAssunto)) Then
    edtAssunto.Text := strAssunto;

  TfrmGravando.fExecutarModal(pCarregaDestinatarios, 'Aguarde, carregando tela de envio de e-mails...', '');

  If (Length(arrAnexos) > 0) Then
  Begin
    If objEmail.mensagem.anexos.limiteAnexos = 0 Then
      objEmail.mensagem.anexos.limiteAnexos := objEmail.dadosAutenticacao.limiteArq;

    For i := 0 to Length(arrAnexos) - 1 do
      AdicionarAnexo(arrAnexos[i]);
  End;

  chkImportante.Checked := blnImportante;

  If Not fEmptyStr(CodOco) Then
    strPathDirAnexosOcorrencia := ExtractFilePath(Application.ExeName)+ 'Arquivos_crm\' + CodOco;
end;

function TfrmEnvioEmail.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    i: Integer;
    strTextoMsg: String;
    destinatarios: TStringList;
    blnConexaoProvedor: Boolean;
begin
  Result        := True;
  destinatarios := TStringList.Create();

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtPara) Or (Sender = edtComCopia) Or (Sender = edtComCopiaOculta) Then
    Begin
      If (fEmptyStr(edtPara.Text))    And
        (fEmptyStr(edtComCopia.Text)) And
        (fEmptyStr(edtComCopiaOculta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Ao menos um destinatário deve ser informado!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Sender = edtPara) Then
        Begin
          destinatarios.Clear();

          //adiciona destinatário (para)
          If (Copy(Trim(edtPara.Text), Length(Trim(edtPara.Text)), 1) = ';') Or
            (Copy(Trim(edtPara.Text), Length(Trim(edtPara.Text)), 1) = ',') Then
            destinatarios.CommaText := StringReplace(Copy(Trim(edtPara.Text), 1,
                                                     Length(Trim(edtPara.Text)) - 1),
                                                     ';',
                                                     ',',
                                                     [rfReplaceAll])
          Else
            destinatarios.CommaText := StringReplace(Trim(edtPara.Text), ';', ',', [rfReplaceAll]);

          If (destinatarios.Count > 0) Then Begin
            objEmail.mensagem.LimparPara();

            For i := 0 To destinatarios.Count - 1 Do
              If (Not objEmail.mensagem.AdicionarPara(destinatarios[i])) Then
              Begin
                Result := False;
                Break;
              End;
          End;
        End

        Else If (Sender = edtComCopia) Then
        Begin
          destinatarios.Clear();

          //adiciona destinatário (com cópia)
          If (Copy(Trim(edtComCopia.Text), Length(Trim(edtComCopia.Text)), 1) = ';') Or
            (Copy(Trim(edtComCopia.Text), Length(Trim(edtComCopia.Text)), 1) = ',') Then
            destinatarios.CommaText := StringReplace(Copy(Trim(edtComCopia.Text), 1,
                                                     Length(Trim(edtComCopia.Text)) - 1),
                                                     ';',
                                                     ',',
                                                     [rfReplaceAll])
          Else
            destinatarios.CommaText := StringReplace(Trim(edtComCopia.Text), ';', ',', [rfReplaceAll]);

          If (destinatarios.Count > 0) Then Begin
            objEmail.mensagem.LimparComCopia();

            For i := 0 To destinatarios.Count - 1 Do
              If (Not objEmail.mensagem.AdicionarComCopia(destinatarios[i])) Then
              Begin
                Result := False;
                Break;
              End;
          End;
        End

        Else If (Sender = edtComCopiaOculta) Then
        Begin
          destinatarios.Clear();

          //adiciona destinatário (com cópia oculta)
          If (Copy(Trim(edtComCopiaOculta.Text), Length(Trim(edtComCopiaOculta.Text)), 1) = ';') Or
            (Copy(Trim(edtComCopiaOculta.Text), Length(Trim(edtComCopiaOculta.Text)), 1) = ',') Then
            destinatarios.CommaText := StringReplace(Copy(Trim(edtComCopiaOculta.Text), 1,
                                                     Length(Trim(edtComCopiaOculta.Text)) - 1),
                                                     ';',
                                                     ',',
                                                     [rfReplaceAll])
          Else
            destinatarios.CommaText := StringReplace(Trim(edtComCopiaOculta.Text), ';', ',', [rfReplaceAll]);

          If (destinatarios.Count > 0) Then Begin
            objEmail.mensagem.LimparComCopiaOculta();

            For i := 0 To destinatarios.Count - 1 Do
              If (Not objEmail.mensagem.AdicionarComCopiaOculta(destinatarios[i])) Then
              Begin
                Result := False;
                Break;
              End;
          End;
        End;
      End
    End

    Else If (Sender = edtAssunto) Then Begin
      If (Not objEmail.mensagem.AdicionarAssunto(edtAssunto.Text)) Then
        Result := False;
    End

    Else If (Sender = btnEnviar) Then 
    Begin
      strTextoMsg := (FEditorHtml.WebBrowser.DefaultInterface.Document As IHTMLDocument2).body.innerHTML;

      Application.ProcessMessages;
      If (Not TAutenticacaoEmail.ValidarAutenticacaoSmtpTelaEnvioEmail(Self, objEmail.dadosAutenticacao, blnConexaoProvedor)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Os dados de Provedor, e-Mail e Senha do Cadastro de Operadores, aba e-Mail, estão inválidos ou não configurados. Faça a devida manutenção do cadastro e tente novamente!', ['&OK']);
        Result := False;
      End

      Else If (fEmptyStr(strTextoMsg)) Or (SameText('<P>&nbsp;</P>', strTextoMsg)) Then 
      Begin
        fMensagem('ATENÇÃO!', 'O corpo da Mensagem não pode ser vazio!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  FreeAndNil(destinatarios);

  If (Not Result) Then Begin
    If (Not (Sender = btnEnviar)) Then
      pSetFocus(Sender)
    Else
      pSetFocus(edtAssunto);
  End;
end;

procedure TfrmEnvioEmail.LimparFormulario;
begin
  edtPara.Text           := '';
  edtComCopia.Text       := '';
  edtAssunto.Text        := '';
  edtComCopiaOculta.Text := '';
  btnRemoverTodosPop.Click();
  FEditorHtml.LimparEdicao();

  pSetFocus(edtPara);
end;

procedure TfrmEnvioEmail.lsbAnexosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_INSERT) Then
    btnInserirAnexo.Click()
  Else
    If (Key = VK_DELETE) Then
      btnRemoverPop.Click;
end;

procedure TfrmEnvioEmail.pCarregaAnexosEmails(
  const intTamanhoReferenciaEmMB: Integer; var lstAnexosPorEmail: TStrings);
var
  intIndice      : Integer;
  strAnexosEmail : String;
begin
  strAnexosEmail := EmptyStr;

  If not Assigned(lstAnexosPorEmail) Then
    lstAnexosPorEmail := TStringList.Create;

  If (intTamanhoReferenciaEmMB = 0) Or
     (lsbAnexos.Count = 0) Then
  Begin
    For intIndice := 0 To Pred(objEmail.mensagem.anexos.arquivosAnexados.Count) Do
    Begin
      If Not fEmptyStr(strAnexosEmail) Then
        strAnexosEmail := strAnexosEmail
                        + ';';

      strAnexosEmail := strAnexosEmail
                      + objEmail.mensagem.anexos.arquivosAnexados.Items[intIndice].arquivo;
    End;

    lstAnexosPorEmail.Add(strAnexosEmail);
  End;
end;

procedure TfrmEnvioEmail.RetonaEmailCampoDestinatarios(
  var AListaEmails: TStringList; ATotalDestinatarios: Integer;
  var ATotalSelecionados: Integer; ATipo: Integer);
begin
  If AListaEmails.Count = 0 Then
    Exit;

  If ATotalSelecionados >= ATotalDestinatarios Then
    Exit;

  If Not ATipo in [0, 1, 2] Then
    Raise Exception.Create('Tipo de destinatário selecionado de forma incorreta. Verifique');

  While (AListaEmails.Count > 0) Do
  Begin
    If ATipo = 0 Then
      objEmail.Mensagem.AdicionarPara(AListaEmails[0])
    Else If ATipo = 1 Then
      objEmail.Mensagem.AdicionarComCopia(AListaEmails[0])
    Else If ATipo = 2 Then
      objEmail.Mensagem.AdicionarComCopiaOculta(AListaEmails[0]);

    inc(ATotalSelecionados);

    AListaEmails.Delete(0);

    If ATotalSelecionados >= ATotalDestinatarios Then
      Break;
  End;
end;

procedure TfrmEnvioEmail.SetHabilitaDivisaoAnexoPorEmail(const Value: Boolean);
begin
  FblnHabilitaDivisaoAnexoPorEmail := Value;
end;

function TfrmEnvioEmail.URLEncoded(const url: String): String;
  var
    i: Integer;
    simbolos, encode: Array of String;
begin
  simbolos := ['''', '=', '´', '[', '~', ']', '\', ',', ';', '/', '"', '!', '@', '#', '$', '%', '¨', '&',
                '*', '(', ')', '+', '`', '{', '^', '}', '|', '<', '>', ':', '?', '¹', '²', '³', '£', '¢',
                '¬', '§', '°', 'ª', 'º', '°', '/', '*', '+', ' '];

  encode   := ['%27', '%3D', '%B4', '%5B', '%7E', '%5D', '%5C', '%2C', '%3B', '%2F', '%22', '%21', '%40',
               '%23', '%24', '%25', '%A8', '%26', '%2A', '%28', '%29', '%2B', '%60', '%7B', '%5E', '%7D',
               '%7C', '%3C', '%3E', '%3A', '%3F', '%B9', '%B2', '%B3', '%A3', '%A2', '%AC', '%A7', '%B0',
               '%AA', '%BA', '%B0', '%2F', '%2A', '%2B', '%20'];

  Result := url;

  for i := 0 to Length(simbolos) - 1 do
    if (Pos(simbolos[i], Result) > 0) and (simbolos[i] <> '%') then
      Result := StringReplace(Result, simbolos[i], encode[i], [rfReplaceAll]);

  for i := 0 to Length(encode) - 1 do
    if (Pos(encode[i], Result) > 0) then
      Result := StringReplace(Result, encode[i], simbolos[i], [rfReplaceAll]);
end;

function TfrmEnvioEmail.ValidaDirAnexoOcorrencia: Boolean;
begin
  Result := False;

  If DirectoryExists(strPathDirAnexosOcorrencia) Then
    Result := True;
end;

procedure TfrmEnvioEmail.btnRemoverPopClick(Sender: TObject);
begin
  inherited;

  If (lsbAnexos.ItemIndex <> -1) Then
  Begin
    objEmail.mensagem.RemoverAnexo(Trim(Copy(lsbAnexos.Items[lsbAnexos.ItemIndex], 1, Pos(' (', lsbAnexos.Items[lsbAnexos.ItemIndex]))));
		lsbAnexos.DeleteSelected;
  End;
end;

procedure TfrmEnvioEmail.btnRemoverTodosPopClick(Sender: TObject);
begin
  inherited;

  If (lsbAnexos.Count > 0) Then
  Begin
    lsbAnexos.Clear;
    objEmail.mensagem.RemoverTodosAnexos();
  End;
end;

procedure TfrmEnvioEmail.CarregarAssinaturaEmail;
  Var
    i: Integer;
    htmlEmail: TStringList;
Begin
  If (Length(arrAnexos) > 0) And (Length(arrCorpoMensagem) = 0) And (Pos('.html', arrAnexos[0]) > 0) Then
  Begin
    strArqTmpHtmEmail := arrAnexos[0]
  End
  Else 
  Begin
    htmlEmail := TStringList.Create();
    Try
      //inicia a criação do arquivo HTML para o corpo da mensagem no editor
      htmlEmail.Add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">');
      htmlEmail.Add('<HTML><HEAD MIME-Version: 1.0>');
      htmlEmail.Add('<META content="text/html; charset=utf-8" http-equiv="Content-Type" />');
      If blnAdicionaUmParagrafoPorLinha Then
        htmlEmail.Add('<STYLE>P {line-height: 1.5+0.5vw;}</STYLE>');
      htmlEmail.Add('</HEAD>');
      htmlEmail.Add('<BODY>');

      If blnAdicionaUmParagrafoPorLinha Then
      Begin
        For i := 0 To Length(arrCorpoMensagem) - 1 Do
          htmlEmail.Add('<P>' + arrCorpoMensagem[i] + '</P>');
      End
      Else
      Begin
        For i := 0 To Length(arrCorpoMensagem) - 1 Do
          htmlEmail.Add(arrCorpoMensagem[i]);
      End;

      htmlEmail.Add('<P>&nbsp;</P>');

      If (objEmail.dadosAutenticacao.textoAssinatura.Count > 0)
        Or (objEmail.dadosAutenticacao.imagemAssinaturaEhValida()) Then
        htmlEmail.Add('<HR><P><I><SMALL>');

      For i := 0 To objEmail.dadosAutenticacao.textoAssinatura.Count - 1 Do
        If (objEmail.dadosAutenticacao.textoAssinatura[i] = #13#10) Or
           (fEmptyStr(objEmail.dadosAutenticacao.textoAssinatura[i])) Then
          htmlEmail.Add('<BR>')
        Else
          htmlEmail.Add(objEmail.dadosAutenticacao.textoAssinatura[i] + '<BR>');

      htmlEmail.Add('</SMALL></I></P>');

      //criação do arquivo JPEG com a imagem da mmsImgAss do operador
      strArqTmpHtmEmail := strPathTmpEmail + 'Email-' + FormatDateTime('yyyymmdd_hhnnsszzz', objEmail.horaEnvio) + '.html';

      If (objEmail.dadosAutenticacao.imagemAssinaturaEhValida()) Then
      Begin
        objEmail.CriarArquivoImagemAssinaturaEmail;

        If (Not FileExists(strArqTmpHtmEmail)) Then
        Begin
          htmlEmail.Add('<IMG border=0 hspace=0 alt=""');
          htmlEmail.Add('src="' + objEmail.GetCaminhoImagemAssinaturaEmail + '"');
          htmlEmail.Add('align=baseline>');
        End;
      End;

      htmlEmail.Add('</BODY></HTML>');
      htmlEmail.SaveToFile(strArqTmpHtmEmail, TEncoding.UTF8);
    Finally
      FreeAndNil(htmlEmail);
    End;
  End;

  //abre o editor de HTML e acopla a tela de envio de e-mail
  pCriarFormularios(TfrmEditorHtml, FEditorHtml);
  FEditorHtml.Dock(pnlEditor, pnlEditor.BoundsRect);
  FEditorHtml.Align                := alClient;
  FEditorHtml.strArquivoFisicoHtml := strArqTmpHtmEmail;
  FEditorHtml.Show();
end;

procedure TfrmEnvioEmail.edtParaChange(Sender: TObject);
begin
  inherited;

  objListaContatos.pFiltrarContatos(TEditFocus(Sender).Text, TEditFocus(Sender), TEditFocus(Sender));
end;

procedure TfrmEnvioEmail.edtParaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DOWN) Then Begin
    objListaContatos.lsbContatos.ItemIndex := 0;
    pSetFocus(objListaContatos.lsbContatos);
  End
end;

procedure TfrmEnvioEmail.EnviarMensagemPorDestinatarios;
  Var
    LTotalDestinaratios,
    LQuantidadeDestEmail,
    LTotalSelecionados: Integer;

    LListaEmailsPara,
    LListaEmailsCopia,
    LListaEmailsCopiaOculta: TStringList;
begin
  LTotalDestinaratios := objEmail.dadosAutenticacao.QuantidadeDestinatarios;

  LListaEmailsPara := TStringList.Create;
  LListaEmailsPara.Text := objEmail.mensagem.para.Text;
  LListaEmailsCopia := TStringList.Create;
  LListaEmailsCopia.Text := objEmail.mensagem.comCopia.Text;
  LListaEmailsCopiaOculta := TStringList.Create;
  LListaEmailsCopiaOculta.Text := objEmail.mensagem.comCopiaOculta.Text;

  Try
    LQuantidadeDestEmail := LListaEmailsPara.Count +
                            LListaEmailsCopia.Count +
                            LListaEmailsCopiaOculta.Count;

    If LQuantidadeDestEmail > LTotalDestinaratios Then
      objEmail.ThreadSincEmail := Nil;

    While (LQuantidadeDestEmail > 0) Do
    Begin
      LTotalSelecionados := 0;

      objEmail.mensagem.LimparPara;
      objEmail.mensagem.LimparComCopia;
      objEmail.mensagem.LimparComCopiaOculta;

      RetonaEmailCampoDestinatarios(LListaEmailsPara, LTotalDestinaratios, LTotalSelecionados, 0);
      RetonaEmailCampoDestinatarios(LListaEmailsCopia, LTotalDestinaratios, LTotalSelecionados, 1);
      RetonaEmailCampoDestinatarios(LListaEmailsCopiaOculta, LTotalDestinaratios, LTotalSelecionados, 2);

      If LTotalSelecionados = 0 Then
        Exit;

      LQuantidadeDestEmail := LQuantidadeDestEmail - LTotalSelecionados;

      objEmail.blnLimparDados := LQuantidadeDestEmail <= 0;
      objEmail.horaEnvio := fNow;

      TfrmGravando.fExecutarModal(objEmail.EnviarMensagem, 'Aguarde, enviando e-Mail...', '');
    End;
  Finally
    FreeAndNil(LListaEmailsPara);
    FreeAndNil(LListaEmailsCopia);
    FreeAndNil(LListaEmailsCopiaOculta);
  End;
end;

function TfrmEnvioEmail.fConfirmarEnvioEmailPorTamanhoAnexos(
  const intTamanhoReferenciaEmMB: Integer;
  var lstAnexosPorEmail: TStrings): Boolean;
var
  intIndice         : Integer;
  intTamanhoTotal   : Integer;
  intTamanhoArquivo : Integer;
  strAnexosEmail    : String;
  intRefTamanhoKB   : Integer;
  strAnexoNomeArq   : String;
  strAnexosLogErr   : String;
begin
  Result := True;

  pCarregaAnexosEmails(intTamanhoReferenciaEmMB, lstAnexosPorEmail);

  if (lstAnexosPorEmail.Count = 1) And
     (fEmptyStr(lstAnexosPorEmail.Strings[0])) Then
    Exit(True);

  intTamanhoTotal := 0;
  strAnexosEmail  := EmptyStr;
  strAnexosLogErr := EmptyStr;
  intRefTamanhoKB := intTamanhoReferenciaEmMB * 1024;

  For intIndice := 0 To Pred(objEmail.mensagem.anexos.arquivosAnexados.Count) Do
  Begin
    objEmail.mensagem.anexos.arquivosAnexados.Items[intIndice].tamanhoComparacao :=
      fTamanhoArquivo(objEmail.mensagem.anexos.arquivosAnexados.Items[intIndice].arquivo, ttKByte);
  End;

  objEmail.mensagem.anexos.OrdenarPorTamanho;
  For intIndice := 0 To Pred(objEmail.mensagem.anexos.arquivosAnexados.Count) Do
  Begin
    intTamanhoArquivo := Trunc(objEmail.mensagem.anexos.arquivosAnexados.Items[intIndice].tamanhoComparacao);

    strAnexoNomeArq := objEmail.mensagem.anexos.arquivosAnexados.Items[intIndice].arquivo + ' (' + IntToStr(intTamanhoArquivo) + ' KB)';

    strAnexosLogErr := strAnexosLogErr + strAnexoNomeArq + ';';

    If intTamanhoArquivo > intRefTamanhoKB Then
    Begin
      fMensagem('ATENÇÃO!', 'O anexo '+strAnexoNomeArq+' tem um tamanho superior ao permitido (' + IntToStr(intRefTamanhoKB) + ' KB) e não poderá ser enviado!'+
                            IIF((intIndice > 0),#13+'Anexos: '+ strAnexosLogErr, ''), ['&Ok']);
      Exit(False)
    End;

    intTamanhoTotal := intTamanhoTotal
                     + intTamanhoArquivo;

    If intTamanhoTotal > intRefTamanhoKB Then
    Begin
      lstAnexosPorEmail.Add(strAnexosEmail);
      intTamanhoTotal := intTamanhoArquivo;
      strAnexosEmail  := EmptyStr;
    End;

    If Not fEmptyStr(strAnexosEmail) Then
      strAnexosEmail := strAnexosEmail
                      + ';';

    strAnexosEmail := strAnexosEmail
                    + objEmail.mensagem.anexos.arquivosAnexados.Items[intIndice].arquivo;
  End;
  lstAnexosPorEmail.Add(strAnexosEmail);

  If lstAnexosPorEmail.Count > 1 Then
    Result := fMensagem('', 'O tamanho total dos anexos supera o permitido. Deseja dividir os anexos em '+lstAnexosPorEmail.Count.ToString+' emails?', ['&Sim', '&Não'], 2) = 1
end;

end.
