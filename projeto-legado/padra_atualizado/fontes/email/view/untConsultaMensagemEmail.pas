unit untConsultaMensagemEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, cxProgressBar,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel, cxGrid, Vcl.Grids,
  EditFocus, untFuncoesSimples, untTEnvioEmail, untEditorHtml, cxSplitter, Datasnap.DBClient, UniClientDataSet, DBAccess, Uni, Datasnap.Provider,
  UniDataSetProvider, System.ImageList, Vcl.ImgList, untTEmaEnv, untTEmaEnvRepository, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, DateEditFocus, System.Generics.Collections, IdMessage, untTypesSistema, IdText, cxImageComboBox,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConsultaMensagemEmail = class(TfrmPai)
    grbEnviadas: TGroupBox;
    grbMensagem: TGroupBox;
    grdEnviadasLevel1: TcxGridLevel;
    grdEnviadasTableView1: TcxGridDBTableViewCitel;
    grdEnviadas: TcxGridCitel;
    pnlDadosMensagem: TPanel;
    lblAssunto: TLabel;
    lblPara: TLabel;
    lblComCopia: TLabel;
    lblComCopiaOculta: TLabel;
    edtAssunto: TEditFocus;
    edtPara: TEditFocus;
    edtComCopia: TEditFocus;
    edtComCopiaOculta: TEditFocus;
    pnlEditor: TPanel;
    grbAnexos: TGroupBox;
    lsbAnexos: TListBox;
    btnNovo: TBitBtnLocked;
    btnEncaminhar: TBitBtnLocked;
    popAnexos: TPopupMenu;
    Abriranexo1: TMenuItem;
    sptSeparador: TcxSplitter;
    cdsEmailsEnviados: TUniClientDataSet;
    dtsEmailsEnviados: TUniDataSource;
    grdEnviadasTableView1Column1: TcxGridDBColumn;
    grdEnviadasTableView1Column2: TcxGridDBColumn;
    grdEnviadasTableView1Column3: TcxGridDBColumn;
    grdEnviadasTableView1Column4: TcxGridDBColumn;
    grdEnviadasTableView1Column5: TcxGridDBColumn;
    imgIcones: TImageList;
    grdEnviadasTableView1Column6: TcxGridDBColumn;
    grdEnviadasTableView1Column7: TcxGridDBColumn;
    pnlPeriodo: TPanel;
    lblPeriodo: TLabel;
    dteInicial: TDateEditFocus;
    lblAte: TLabel;
    dteFinal: TDateEditFocus;
    chkTodos: TCheckBox;
    btnAtualizar: TBitBtnLocked;
    tmrConsulta: TTimer;
    Label1: TLabel;
    edtDestinatario: TEditFocus;
    edtPesqAssunto: TEditFocus;
    Label2: TLabel;
    lblOperad: TLabel;
    edtOperad: TEditFocus;
    ckbTotOpe: TCheckBox;
    procedure btnNovoClick(Sender: TObject);
    procedure Abriranexo1Click(Sender: TObject);
    procedure btnEncaminharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkTodosClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure grdEnviadasTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrConsultaTimer(Sender: TObject);
    procedure grdEnviadasTableView1CellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ckbTotOpeClick(Sender: TObject);
  private
    { Private declarations }
    FEditorHtml: TfrmEditorHtml;
    anexos     : TArrayDadosAnexos;
    mensagem   : TIdMessage;
    arquivoHtml, strDiretorioHtml, strAssunto: String;
    strPara, strComCopia, strComCopiaOculta, strAnexos: TStringArray;
    dteInicio: TDateTime;

    procedure CriarClientDataset;
    procedure AtualizarGrid;
    function CarregarPreviewMensagem(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCarregarPreviewMensagem;
    procedure LimparPainelPreview;
    procedure ApagarAnexosMensagemAnterior;

    function ProcuraMensagemEnvioEmailFixo(Var AArquivoHtml: String;
                                           Var AContaDiferente: Boolean;
                                           Var AContaOperador: String):TIdMessage;

    procedure pSalvarArquivoEmailTemp(const ADiretorioEmail: String);
  public
    { Public declarations }
  end;

implementation
{$R *.dfm}

uses untGravando, untTCadOpeRepository, untTCadOpe;

procedure TfrmConsultaMensagemEmail.Abriranexo1Click(Sender: TObject);
  Var
    i: Integer;
begin
  inherited;

  If (lsbAnexos.ItemIndex <> - 1) Then Begin
    For i := 0 To Length(anexos) - 1 Do
      If (anexos[i].nomeArquivo = Copy(lsbAnexos.Items[lsbAnexos.ItemIndex], 5, Length(lsbAnexos.Items[lsbAnexos.ItemIndex]))) Then
        pExecArquivo(strDiretorioHtml + anexos[i].nomeArquivo, Handle);
  End;
end;

procedure TfrmConsultaMensagemEmail.btnAtualizarClick(Sender: TObject);
begin
  inherited;

  AtualizarGrid();
  LimparPainelPreview();
  pSetFocus(grdEnviadas);
end;

procedure TfrmConsultaMensagemEmail.btnEncaminharClick(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(strAssunto)) Then Begin
    TEnvioEmail.EnviarEmail(Self,
                            strLoginUsuarioLogado,
                            strAssunto,
                            strPara,
                            strComCopia,
                            strComCopiaOculta,
                            [],
                            strAnexos,
                            True,
                            cdsEmailsEnviados.FieldByName('IMPORTANTE').AsBoolean);

    AtualizarGrid();
    LimparPainelPreview();
  End Else
    fMensagem('ATENÇÃO!', 'Selecione uma mensagem para realizar o encaminhamento!', ['&Ok']);
end;

procedure TfrmConsultaMensagemEmail.btnNovoClick(Sender: TObject);
begin
  inherited;

  If (TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, '', [], [], [], [], [])) Then Begin
    AtualizarGrid();
    LimparPainelPreview();
  End;
end;

function TfrmConsultaMensagemEmail.CarregarPreviewMensagem(pgbProgresso: TcxProgressBar): Boolean;
  Var
    i: Integer;
    contaDiferente: Boolean;
    mensagemHtml: TStringList;
    objEmaEnvRep: TEmaEnvRepository;
    diretorioEmail, contaOperador: String;

    strCodOpe: String;

  procedure AtualizaCaptionFormGravando(mensagem: String; tempo: Word);
  begin
    frmGravando.lblGravando.Caption := mensagem;
    Application.ProcessMessages;
    Sleep(tempo);
  end;
begin
  contaDiferente := False;

  Try
    Application.ProcessMessages;

    If (Assigned(mensagem)) Then
      mensagem.Clear();

    ApagarAnexosMensagemAnterior();
    LimparPainelPreview();

    If (Not cdsEmailsEnviados.IsEmpty) And
       (ValidarDiretorioEmail(diretorioEmail, cdsEmailsEnviados.FieldByName('OPERADOR').AsString)) Then
    Begin
      arquivoHtml      := StringReplace(cdsEmailsEnviados.FieldByName('NOMEARQUIVOZIP').AsString,
        '.zip', '', [rfReplaceAll]);

      strDiretorioHtml := diretorioEmail + arquivoHtml + '\';

      strCodOpe := cdsEmailsEnviados.FieldByName('OPERADOR').AsString;

      if not FileExists(diretorioEmail + cdsEmailsEnviados.FieldByName('NOMEARQUIVOZIP').AsString) then
      begin
        pSalvarArquivoEmailTemp(diretorioEmail);

        if (not FileExists(diretorioEmail + cdsEmailsEnviados.FieldByName('NOMEARQUIVOZIP').AsString)) and (ValidarDiretorioEmail(diretorioEmail, '999')) then
        begin
          strCodOpe := '999';
          strDiretorioHtml := diretorioEmail + arquivoHtml + '\';
        end;
      end;

      If (Not DirectoryExists(strDiretorioHtml)) Then
        MkDir(strDiretorioHtml);

      AtualizaCaptionFormGravando('Buscando mensagem no servidor...', 300);

      mensagem := TEnvioEmail.BuscarZipMensagemServidor(Self, arquivoHtml, strCodOpe);

      If (Not Assigned(mensagem)) Then
      Begin
        AtualizaCaptionFormGravando('Mensagem não encontrada no servidor.', 750);

        AtualizaCaptionFormGravando('Buscando mensagem no provedor de e-mail...', 300);

        mensagem := TEnvioEmail.BuscarMensagemProvedor(Self,
          cdsEmailsEnviados.FieldByName('DE').AsString,
          cdsEmailsEnviados.FieldByName('PARA').AsString,
          cdsEmailsEnviados.FieldByName('ASSUNTO').AsString,
          arquivoHtml,
          contaDiferente,
          contaOperador);

        If Not Assigned(mensagem) Then
          mensagem := ProcuraMensagemEnvioEmailFixo(arquivoHtml,contaDiferente,contaOperador);

        If (contaDiferente) Then
        Begin
          untFuncoesSimples.fMensagem('Alerta', 'Mensagem não pode ser recuperada no servidor de e-Mail.' + #13#10 +
              'A mensagem solicitada foi enviada utilizando a conta de e-Mail ''' + cdsEmailsEnviados.FieldByName('DE').AsString + '''' + #13#10 +
              'e o Operador está utilizando a conta ''' + contaOperador + ''' ' + #13#10 +
              'para o envio de mensagens.', ['&Ok']);
        End;

        If (Assigned(mensagem)) Then
        Begin
          AtualizaCaptionFormGravando('Mensagem encontrada no provedor.', 750);

          AtualizaCaptionFormGravando('Gravando mensagem no servidor...', 300);

          TEnvioEmail.GravarZipMensagem(mensagem, diretorioEmail, arquivoHtml);
        End;
      End;

      If (Assigned(mensagem)) Then
      Begin
        AtualizaCaptionFormGravando('Processando mensagem...', 300);

        //criar arquivos anexos
        anexos := TEnvioEmail.CriarAnexosZipMensagem(arquivoHtml + '.zip', mensagem);

        //inicializar atributos da mensagem
        strAssunto := mensagem.Subject;

        For i := 0 To mensagem.Recipients.Count - 1 Do
        Begin
          SetLength(strPara, Length(strPara) + 1);
          strPara[Length(strPara) - 1] := mensagem.Recipients.Items[i].Address;
        End;

        For i := 0 To mensagem.CCList.Count - 1 Do
        Begin
          SetLength(strComCopia, Length(strComCopia) + 1);
          strComCopia[Length(strComCopia) - 1] := mensagem.CCList.Items[i].Address;
        End;

        For i := 0 To mensagem.BCCList.Count - 1 Do
        Begin
          SetLength(strComCopiaOculta, Length(strComCopiaOculta) + 1);
          strComCopiaOculta[Length(strComCopiaOculta) - 1] := mensagem.BCCList.Items[i].Address;
        End;

        //criar arquivo HTML da mensagem
        mensagemHtml := TStringList.Create();

        Try
          if (mensagem.MessageParts.Count > 1) and (mensagem.MessageParts.Items[1] is TIdText) then
            mensagemHtml.Text := TIdText(mensagem.MessageParts.Items[1]).Body.Text;

          //trocar e-mails enviados com estilos de paragrafos fixos para o estilo responsivo...
          mensagemHtml.Text := StringReplace(mensagemHtml.Text,
             '<STYLE>P {line-height: 0.9;} .P1 {line-height: 0.1; font-size:x-small;}</STYLE>',
             '<STYLE>P {line-height: 1.5+0.5vw;}</STYLE>',
             [rfReplaceAll]);

          mensagemHtml.Text := StringReplace(mensagemHtml.Text,
             '<STYLE>P {line-height: 1.0;} .P1 {line-height: 0.5; font-size:x-small;}</STYLE>',
             '<STYLE>P {line-height: 1.5+0.5vw;}</STYLE>',
             [rfReplaceAll]);
          //...trocar e-mails enviados com estilos de paragrafos fixos para o estilo responsivo

          //verificação de imagem de assinatura na mensagem
          If (Length(anexos) > 0) Then
          Begin
            For i := 0 To Length(anexos) - 1 Do
            Begin
              If (anexos[i].ContentId = '<assinatura' + Copy(arquivoHtml, 19, 18) + '>') Then
              Begin
                mensagemHtml.Text := StringReplace(mensagemHtml.Text,
                                                   'cid:assinatura' + Copy(arquivoHtml, 19, 18),
                                                   strDiretorioHtml + anexos[i].nomeArquivo,
                                                   [rfReplaceAll]);
              End;

              If (anexos[i].ContentId = '<imagemCorpoEmail_' + FormatFloat('###000', i) + '_' + Copy(arquivoHtml, 19, 18) + '>') Then
              Begin
                mensagemHtml.Text := StringReplace(mensagemHtml.Text,
                                                   'cid:imagemCorpoEmail_' + FormatFloat('###000', i) + '_' + Copy(arquivoHtml, 19, 18),
                                                   strDiretorioHtml + anexos[i].nomeArquivo,
                                                   [rfReplaceAll]);
              End;
            End;
          End;

          If (Not DirectoryExists(strDiretorioHtml)) Then
            MkDir(strDiretorioHtml);

          mensagemHtml.SaveToFile(strDiretorioHtml + arquivoHtml + '.html', TEncoding.UTF8);
        Finally
          FreeAndNil(mensagemHtml);
        End;

        AtualizaCaptionFormGravando('Processando anexos da mensagem...', 300);

        //adiciona os anexos identificados na listagem
        lsbAnexos.Clear();

        For i := 0 To Length(anexos) - 1 Do
          If (anexos[i].contentID <> '<assinatura' + Copy(arquivoHtml, 19, 18) + '>')
            And (anexos[i].contentID <> '<imagemCorpoEmail_' + FormatFloat('###000', i) + '_' + Copy(arquivoHtml, 19, 18) + '>') Then
            lsbAnexos.Items.Add('...\' + anexos[i].nomeArquivo);

        //define o caminho dos arquivos anexos
        //o primeiro arquivo será o corpo da mensagem (HTML)
        //que será utilizado pela tela de envio de email para montar a mensagem
        SetLength(strAnexos, Length(strAnexos) + 1);
        strAnexos[Length(strAnexos) - 1] := strDiretorioHtml + arquivoHtml + '.html';

        For i := 0 To Length(anexos) - 1 Do Begin
          If (anexos[i].contentID <> '<assinatura' + Copy(arquivoHtml, 19, 18) + '>')
            And (anexos[i].contentID <> '<imagemCorpoEmail_' + FormatFloat('###000', i) + '_' + Copy(arquivoHtml, 19, 18) + '>') Then
          Begin
            SetLength(strAnexos, Length(strAnexos) + 1);
            strAnexos[Length(strAnexos) - 1] := strDiretorioHtml + anexos[i].nomeArquivo;
          End;
        End;

        //preencher dados da mensagem no painel
        edtAssunto.Text := strAssunto;

        edtPara.Text := '';
        For i := 0 To Length(strPara) - 1 Do
          edtPara.Text := edtPara.Text + strPara[i] + '; ';
        If Pos(cdsEmailsEnviados.FieldByName('PARA').AsString ,edtPara.Text) <= 0 Then
          edtPara.Text := cdsEmailsEnviados.FieldByName('PARA').AsString + '; ';

        edtComCopia.Text := '';
        For i := 0 To Length(strComCopia) - 1 Do
          edtComCopia.Text := edtComCopia.Text + strComCopia[i] + '; ';

        edtComCopiaOculta.Text := '';
        For i := 0 To Length(strComCopiaOculta) - 1 Do
          edtComCopiaOculta.Text := edtComCopiaOculta.Text + strComCopiaOculta[i] + '; ';

        //carregar tela do editor
        FEditorHtml.strArquivoFisicoHtml := strDiretorioHtml + arquivoHtml + '.html';
        FEditorHtml.AtualizarCorpoMensagem();

        //torna visível o painel com o editor
        grbMensagem.Visible := True;
      End
      Else
      Begin
        If (Not contaDiferente) And (fMensagem('ATENÇÃO!',
          'Mensagem de e-mail não foi encontrada. Deseja apagar o registro?', ['&Sim','&Não'], 2) = 1) Then Begin
          objEmaEnvRep := TEmaEnvRepository.Create();
          try
            objEmaEnvRep.pDelete(cdsEmailsEnviados.FieldByName('ID').AsLargeInt);
          finally
            FreeAndNil(objEmaEnvRep);
          end;

          btnAtualizar.Click();
        End;
      End;
      Application.ProcessMessages();
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConsultaMensagemEmail.pCarregarPreviewMensagem]');
    End;
  End;

  Result := True;
end;

procedure TfrmConsultaMensagemEmail.pSalvarArquivoEmailTemp(const ADiretorioEmail: String);
var
  qryEmaEnv: TUniQuery;
begin
  qryEmaEnv := fCriaQuery;
  try
    qryEmaEnv.Close;
    qryEmaEnv.SQL.Text :=
    ' SELECT '+
    '   ENV_ARQZIP '+
    ' FROM '+
    '   EMAENV '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC';

    qryEmaEnv.ParamByName('AUTINC').AsString := cdsEmailsEnviados.FieldByName('AUTOINCREM').AsString;
    qryEmaEnv.Open;

    if not fEmptyStr(qryEmaEnv.FieldByName('ENV_ARQZIP').AsString) then
      TBlobField(qryEmaEnv.FieldByName('ENV_ARQZIP')).SaveToFile(ADiretorioEmail + cdsEmailsEnviados.FieldByName('NOMEARQUIVOZIP').AsString);
  finally
    FreeAndNIl(qryEmaEnv);
  end;
end;

procedure TfrmConsultaMensagemEmail.chkTodosClick(Sender: TObject);
begin
  inherited;

  if (chkTodos.Checked) then begin
    dteInicial.Clear;
    dteInicial.Enabled := False;
    dteFinal.Clear;
    dteFinal.Enabled   := False;
  end
  else begin
    dteInicial.Date    := Trunc(fNow() - 7);
    dteInicial.Enabled := True;
    dteFinal.Date      := Trunc(fNow());
    dteFinal.Enabled   := True;
  end;
end;

procedure TfrmConsultaMensagemEmail.ckbTotOpeClick(Sender: TObject);
begin
  inherited;
  if (ckbTotOpe.Checked) then
  begin
    edtOperad.Clear;
    edtOperad.Enabled := False;
  end
  else
  begin
    edtOperad.Enabled := True;
  end;
end;

procedure TfrmConsultaMensagemEmail.CriarClientDataset;
begin
  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ID';
    DataType := ftLargeInt;
  end;

  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DATA';
    DataType := ftDateTime;
  end;

  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'HORA';
    DataType := ftString;
  end;

  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'PARA';
    DataType := ftString;
    Size     := 150;
  end;

  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DE';
    DataType := ftString;
    Size     := 150;
  end;


  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ASSUNTO';
    DataType := ftString;
    Size     := 250;
  end;

  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ANEXOS';
    DataType := ftBoolean;
  end;

  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'IMPORTANTE';
    DataType := ftBoolean;
  end;

  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'OPERADOR';
    DataType := ftString;
    Size     := 3;
  end;

  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMEARQUIVOZIP';
    DataType := ftString;
    Size     := 250;
  end;

  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMAILOPERADOR';
    DataType := ftString;
    Size     := 150;
  end;

  With cdsEmailsEnviados.FieldDefs.AddFieldDef Do
  begin
    Name     := 'AUTOINCREM';
    DataType := ftString;
    Size     := 20;
  end;

  cdsEmailsEnviados.CreateDataSet;
end;

procedure TfrmConsultaMensagemEmail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  ApagarAnexosMensagemAnterior();
  Application.ProcessMessages();

  If (Assigned(FEditorHtml)) Then
  Begin
    FEditorHtml.Close();
    FEditorHtml.Release();
    FreeAndNil(FEditorHtml);
  End;
end;

procedure TfrmConsultaMensagemEmail.FormCreate(Sender: TObject);
begin
  inherited;

  dteInicial.Date := Trunc(fNow()) - 7;
  dteFinal.Date   := Trunc(fNow());
  dteInicio       := 0;

  tmrConsulta.Enabled := False;
  grbMensagem.Visible := False;

  SetLength(anexos, 0);
  mensagem := nil;
  arquivoHtml := '';
  strDiretorioHtml := '';

  lblOperad.Visible := fVerificaAcessoSistema('MSGFILOPE');
  edtOperad.Visible := lblOperad.Visible;
  ckbTotOpe.Visible := lblOperad.Visible;
end;

procedure TfrmConsultaMensagemEmail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape: btnSair.Click();
  End;
end;

procedure TfrmConsultaMensagemEmail.FormShow(Sender: TObject);
begin
  inherited;

  CriarClientDataset();
  AtualizarGrid();

  pCriarFormularios(TfrmEditorHtml, FEditorHtml);
  FEditorHtml.Dock(pnlEditor, pnlEditor.BoundsRect);
  FEditorHtml.Align               := alClient;
  FEditorHtml.blnConsultaEmail    := True;
  FEditorHtml.strArquivoFisicoHtml:= '';
  FEditorHtml.Show();
end;

procedure TfrmConsultaMensagemEmail.grdEnviadasTableView1CellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pCarregarPreviewMensagem();
end;

procedure TfrmConsultaMensagemEmail.grdEnviadasTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  Const
    RowMovementKeys = [VK_UP, VK_PRIOR, VK_DOWN, VK_NEXT, VK_HOME, VK_END];
begin
  inherited;

  If (Key In RowMovementKeys) Then Begin
    tmrConsulta.Enabled := True;
    dteInicio := fNow();
    grbMensagem.Visible := False;
  End;

  Case Key Of
    VK_Escape: btnSair.Click();
  End;
end;

procedure TfrmConsultaMensagemEmail.LimparPainelPreview;
begin
  edtAssunto.Text        := '';
  edtPara.Text           := '';
  edtComCopia.Text       := '';
  edtComCopiaOculta.Text := '';
  lsbAnexos.Clear();

  strAssunto  := '';
  arquivoHtml := '';
  strDiretorioHtml := '';

  strPara           := [];
  strAnexos         := [];
  strComCopia       := [];
  strComCopiaOculta := [];

  FEditorHtml.strArquivoFisicoHtml := '';
  FEditorHtml.AtualizarCorpoMensagem();
  grbMensagem.Visible := False;
end;

procedure TfrmConsultaMensagemEmail.pCarregarPreviewMensagem;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.lblGravando.Caption := 'Pesquisando mensagem de e-mail...';
    frmGravando.fExecutarAcao := CarregarPreviewMensagem;
    frmGravando.ShowModal;
    Self.Repaint();
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConsultaMensagemEmail.pCarregarPreviewMensagem]');
    End;
  End;

  pFreeAndNil(frmGravando);
end;

function TfrmConsultaMensagemEmail.ProcuraMensagemEnvioEmailFixo(Var AArquivoHtml: String;
                                                                 Var AContaDiferente: Boolean;
                                                                 Var AContaOperador: String): TIdMessage;
  Var
    LCfgEma :TUniQuery;
    LDadosAutenticacao: TAutenticacaoEmail;
begin
  Result := Nil;

  Try
    LCfgEma := fCriaQuery(Nil);
    Try
      LCfgEma.Close;
      LCfgEma.SQL.Text := 'SELECT                           '+
                          '  *                              '+
                          'FROM                             '+
                          '  CFGEMA                         '+
                          '  INNER JOIN CADPRV              '+
                          '    ON PRV_CODPRV = CFG_CODPRV   '+
                          'WHERE CFG_EMAIL_ = :REMETENTE    '+
                          'GROUP BY CFG_EMAIL_,             '+
                          '  CFG_SENEMA,                    '+
                          '  CFG_CODPRV                     ';

      LCfgEma.ParamByName('REMETENTE').AsString := cdsEmailsEnviados.FieldByName('DE').AsString;
      LCfgEma.Open;

      While Not LCfgEma.Eof Do
      Begin
        LDadosAutenticacao := TAutenticacaoEmail.Create(strLoginUsuarioLogado,
                                     LCfgEma.FieldByName('CFG_EMAIL_').AsString,
                                     LCfgEma.FieldByName('CFG_EMALOG').AsString, '',
                                     CriptografarSenhaEmail(LCfgEma.FieldByName('CFG_SENEMA').AsString),
                                     LCfgEma.FieldByName('PRV_CODPRV').AsInteger,
                                     Not LCfgEma.FieldByName('PRV_USAOA2').AsString.Equals('S'));

        Result := TEnvioEmail.BuscarMensagemProvedor(Self,
                                                     cdsEmailsEnviados.FieldByName('DE').AsString,
                                                     cdsEmailsEnviados.FieldByName('PARA').AsString,
                                                     cdsEmailsEnviados.FieldByName('ASSUNTO').AsString,
                                                     AArquivoHtml,
                                                     AContaDiferente,
                                                     AContaOperador,
                                                     LDadosAutenticacao);
        If Assigned(LDadosAutenticacao) Then
          FreeAndNil(LDadosAutenticacao);

        Application.ProcessMessages;

        If Assigned(Result) Then
          Break;

        LCfgEma.Next;
      End;

    Except
    On E:Exception Do
      Begin

        If (Pos('username and password not accepted', LowerCase(E.Message)) > 0) And
           (Pos('.gmail.com', LDadosAutenticacao.servidorSmtp.ToLower) > 0) Then
        Begin
          fMensagem('ALERTA!', 'Houve um erro ao validar os dados da conta de e-mail. Os dados de autenticação (login e senha) não foram aceitos.' + #13 +
                               'Verifique se sua conta do Gmail está com a "Verificação em duas etapas" ativada e se ' +
                               'foi criada a senha para app!', ['&Ok']);
          Exit;
        End;

        If (Pos('username and password not accepted', LowerCase(E.Message)) > 0) or
           (Pos('authentication failed', LowerCase(E.Message)) > 0) or
           (Pos('incorrect username or password', LowerCase(E.Message)) > 0) or
           (Pos('authentication failure', LowerCase(E.Message)) > 0) Then
        Begin
          fMensagem('ALERTA!', 'Houve um erro ao validar os dados da conta de E-Mail '+
                      #13#10 + ' Verifique os dados informados e tente novamente!', ['&Ok']);
        End;

        Exit;
      End;
    End;
  Finally
    FreeAndNil(LCfgEma);
    If Assigned(LDadosAutenticacao) Then
      FreeAndNil(LDadosAutenticacao);
  End;
end;

procedure TfrmConsultaMensagemEmail.tmrConsultaTimer(Sender: TObject);
begin
  inherited;

  If ((fNow() - dteInicio) >= EncodeTime(0, 0, 0, 750)) Then Begin
    tmrConsulta.Enabled := False;
    pCarregarPreviewMensagem();
  End;
end;

procedure TfrmConsultaMensagemEmail.ApagarAnexosMensagemAnterior;
  var
    j: Integer;
begin
  If (FileExists(strDiretorioHtml + arquivoHtml + '.html')) Then
    DeleteFile(strDiretorioHtml + arquivoHtml + '.html');

  For j := 0 To Length(anexos) - 1 Do
    If (FileExists(strDiretorioHtml + anexos[j].nomeArquivo)) Then
      DeleteFile(strDiretorioHtml + anexos[j].nomeArquivo);

  If (DirectoryExists(strDiretorioHtml)) Then
    RemoveDir(strDiretorioHtml);

  SetLength(anexos, 0);
end;

procedure TfrmConsultaMensagemEmail.AtualizarGrid;
  Var
    i: Integer;
    lstEmaEnv   : TList<TEmaEnv>;
    objEmaEnvRep: TEmaEnvRepository;

    LExibirEmailAutomatico: Boolean;

    LOperador: TCadOpe;
    LOperadorDaBusca: String;
begin
  objEmaEnvRep := TEmaEnvRepository.Create();
  cdsEmailsEnviados.EmptyDataSet;
  cdsEmailsEnviados.AfterScroll := nil;

  Try
    LOperador := TCadOpeRepository.Create().fRetOperadorByCodOpe(strLoginUsuarioLogado);
    LExibirEmailAutomatico := LOperador.OPE_EMAAUT = 'S';

    if ckbTotOpe.Checked then
    begin
      LOperadorDaBusca := EmptyStr;
    end
    else
    begin
      if fEmptyStr(edtOperad.Text) then
      begin
        LOperadorDaBusca := strLoginUsuarioLogado;
      end
      else
      begin
        LOperadorDaBusca := edtOperad.Text;
      end;
    end;

    If (Not chkTodos.Checked) Then
      lstEmaEnv := objEmaEnvRep.fRetEmailByPeriodo(Trunc(dteInicial.Date),
                                                   Trunc(dteFinal.Date),
                                                   LOperadorDaBusca,
                                                   LExibirEmailAutomatico)
    Else
      lstEmaEnv := objEmaEnvRep.fRetEmailByCodOpe(LOperadorDaBusca,
                                                  LExibirEmailAutomatico);

    If (Assigned(lstEmaEnv)) Then
    Begin
      For i := 0 To lstEmaEnv.Count - 1 Do
      Begin
        cdsEmailsEnviados.Append;
        cdsEmailsEnviados.FieldByName('ID').AsLargeInt           := lstEmaEnv[i].ENV_CODEMA;
        cdsEmailsEnviados.FieldByName('DATA').AsDateTime         := lstEmaEnv[i].ENV_EMADTA;
        cdsEmailsEnviados.FieldByName('HORA').AsString           := FormatDateTime('hh:nn:ss', lstEmaEnv[i].ENV_EMAHOR);
        cdsEmailsEnviados.FieldByName('IMPORTANTE').AsBoolean    := Boolean(lstEmaEnv[i].ENV_EMAIMP);
        cdsEmailsEnviados.FieldByName('ANEXOS').AsBoolean        := Boolean(lstEmaEnv[i].ENV_ANEXOS);
        cdsEmailsEnviados.FieldByName('DE').AsString             := lstEmaEnv[i].ENV_EMAREM;
        cdsEmailsEnviados.FieldByName('PARA').AsString           := lstEmaEnv[i].ENV_EMADES;
        cdsEmailsEnviados.FieldByName('ASSUNTO').AsString        := lstEmaEnv[i].ENV_EMASTO;
        cdsEmailsEnviados.FieldByName('OPERADOR').AsString       := lstEmaEnv[i].ENV_CODOPE;
        cdsEmailsEnviados.FieldByName('NOMEARQUIVOZIP').AsString := lstEmaEnv[i].ENV_ZIPNOM;
        cdsEmailsEnviados.FieldByName('EMAILOPERADOR').AsString  := LOperador.OPE_E_MAIL;
        cdsEmailsEnviados.FieldByName('AUTOINCREM').AsString     := lstEmaEnv[i].AUTOINCREM;
        cdsEmailsEnviados.Post;
      End;

      cdsEmailsEnviados.Filtered := False;
      If not fEmptyStr(edtDestinatario.Text) Or Not fEmptyStr(edtPesqAssunto.Text) Then
      Begin
        cdsEmailsEnviados.Filter := 'PARA LIKE '+QuotedStr('%'+edtDestinatario.Text+'%') +
                                    'AND ASSUNTO LIKE '+QuotedStr('%'+edtPesqAssunto.Text+'%');
        cdsEmailsEnviados.Filtered := True;
      End;

    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmConsultaMensagemEmail.AtualizarGrid]');
  End;

  cdsEmailsEnviados.Last();
  grdEnviadasTableView1.ViewData.Expand(True);
  grdEnviadasTableView1.ApplyBestFit();

  cdsEmailsEnviados.First;
end;

end.
