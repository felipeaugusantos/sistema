unit untConfigSPC;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, DirectoryEditFocus,
  ComboBoxFocus, EditFocus, untFuncoesSimples, StrUtils, untFuncoes, untConstantes, 
  untFrameDirectoryEditFocus, QColorLabel;

type
  TfrmConfigSPC = class(TfrmPai)
    pnlTopo: TPanel;
    pnlAtivo: TPanel;
    lblProNum: TLabel;
    Label5: TLabel;
    lblCodAssociado: TLabel;
    Label4: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    edtProxNumArqRem: TEditFocus;
    edtCodEntidade: TEditFocus;
    edtCodAssociado: TEditFocus;
    cmbMotivoExclusao: TComboBoxFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    btnGravar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    Label1: TLabel;
    edtParciais: TEditFocus;
    ColorLabel8: TColorLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfigurarClick(Sender: TObject);
  private
    { Private declarations }
    function fCarregaCfg(Var stlCampos: TStringList): String;
  public
    { Public declarations }
    blnNaoEditar: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigSPC: TfrmConfigSPC;

implementation

uses untCfgOcorrenciaEvento;

{$R *.dfm}

procedure TfrmConfigSPC.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do SPC - Brasil?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    btnCancelar.Visible   := False;
    btnSair.Enabled       := True;
    btnEditar.Visible     := True;
    pnlAtivo.Enabled      := False;
    btnEditar.Visible     := True;
    btnGravar.Enabled     := False;
    btnConfigurar.Enabled := False;

    pSetFocus(btnEditar);
    pCarregaDados;
  end;

end;

procedure TfrmConfigSPC.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  TRY
    pCriarFormularios(tfrmCfgOcorrenciaEvento, frmCfgOcorrenciaEvento);
    frmCfgOcorrenciaEvento.strCodBco  := 'SPC';
    frmCfgOcorrenciaEvento.ShowModal;
  Finally
    FreeAndNil(frmCfgOcorrenciaEvento);
  End;
end;

procedure TfrmConfigSPC.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo.Enabled      := True;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    btnCancelar.Visible   := true;
    btnSair.Enabled       := False;
    btnConfigurar.Enabled := True;

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(edtCodEntidade);
  end;
end;

procedure TfrmConfigSPC.btnGravarClick(Sender: TObject);
Var
  strCfgAnt,
  strCfgAtu,
  strCmpAlt: String;
  stlCfgAnt,
  stlCfgAtu: TStringList;
  intCont,
  intIndice: Integer;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  Try
    stlCfgAnt := TStringList.Create;
    strCfgAnt := fCarregaCfg(stlCfgAnt);
    fGetBancoConfig(1, 'CONFIGSPC', 'PROXNUM', edtProxNumArqRem.Text  );
    fGetBancoConfig(1, 'CONFIGSPC', 'CODENTI', edtCodEntidade.Text    );
    fGetBancoConfig(1, 'CONFIGSPC', 'CODASSO', edtCodAssociado.Text   );
    fGetBancoConfig(1, 'CONFIGSPC', 'MOTISPC', cmbMotivoExclusao.Text );
    fGetBancoConfig(1, 'CONFIGSPC', 'PATHREM', fraPathRemessa.edtDirectory.text    );
    fGetBancoConfig(1, 'CONFIGSPC', 'PATHRET', fraPathRetorno.edtDirectory.text    );
    fGetBancoConfig(1, 'CONFIGSPC', 'PARCEXC', edtParciais.Text);

    pBackupCnfBco;
    fMensagem('', 'Dados salvos com sucesso.', ['&OK'], 1, True);
    edtProxNumArqRem.Enabled := False;
    pSetFocus(edtCodEntidade);

    pnlAtivo.Enabled  := False;
    btnGravar.Enabled := False;
    btnEditar.Visible := True;
    btnCancelar.Visible := False;
    btnConfigurar.Enabled := False;
    btnSair.Enabled   := True;
    pSetFocus(btnEditar);

    stlCfgAtu := TStringList.Create;
    strCfgAtu := fCarregaCfg(stlCfgAtu);
    strCmpAlt := '';

    For intCont := 0 To stlCfgAtu.Count - 1 Do
    Begin
      If stlCfgAnt.Strings[intCont] <> stlCfgAtu.Strings[intCont] Then
      Begin
        intIndice := Pos(':', stlCfgAnt.Strings[intCont]);

        If Not fEmptyStr(strCmpAlt) Then
          strCmpAlt := strCmpAlt + #13+#10;

        strCmpAlt := strCmpAlt + Copy(stlCfgAnt.Strings[intCont], 1, intIndice) +
                     ' Valor Anterior - ' + Copy(stlCfgAnt.Strings[intCont], intIndice + 1, Length(stlCfgAnt.Strings[intCont]) - intIndice) +
                     ' Valor Atual - ' + Copy(stlCfgAtu.Strings[intCont], intIndice + 1, Length(stlCfgAtu.Strings[intCont]) - intIndice);
      End;
    End;

    If Not fEmptyStr(strCmpAlt) Then
      pGravaLogAtb('SPC', 'SPC - BRASIL', 'CONFIGSPC-' + VS_StrCodEmp, strLoginUsuarioLogado, VS_StrCodEmp, strCfgAnt, strCfgAtu, strCmpAlt);

    pCarregaDados;
  Except
    On E:Exception Do
    Begin
      fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
    End;
  End;
end;

procedure TfrmConfigSPC.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) then
  begin
    if btnCancelar.Visible then
    begin
      btnCancelar.Click;
      if btnCancelar.Visible then
        SysUtils.Abort;
    end;
  end;

  inherited;

end;


procedure TfrmConfigSPC.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDados;

  pSetFocus(btnEditar);
  if blnNaoEditar then
  begin
    pnlAtivo.Enabled := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;
end;

procedure TfrmConfigSPC.pCarregaDados;
Var
  intCont : Integer;
begin
  If fEmptyStr(fGetBancoConfig(0, 'CONFIGSPC', 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIGSPC', 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(edtCodEntidade);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  fraPathRemessa.edtDirectory.text  := fGetBancoConfig(0, 'CONFIGSPC', 'PATHREM', '');
  fraPathRetorno.edtDirectory.text  := fGetBancoConfig(0, 'CONFIGSPC', 'PATHRET', '');
  edtCodAssociado.Text := fGetBancoConfig(0, 'CONFIGSPC', 'CODASSO', '');
  edtCodEntidade.Text  := fGetBancoConfig(0, 'CONFIGSPC', 'CODENTI', '');
  edtParciais.Text  := fGetBancoConfig(0, 'CONFIGSPC', 'PARCEXC', 'N');
  If fEmptyStr(edtParciais.Text) Then
    edtParciais.Text  := 'N';

  For intCont := Low(ARR_OCORRENCIA_SPCBRASIL) to High(ARR_OCORRENCIA_SPCBRASIL) Do
  begin
    cmbMotivoExclusao.Items.Add(ARR_OCORRENCIA_SPCBRASIL[intCont][1]);
  end;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIGSPC', 'MOTISPC', '01')) Then
  Begin
    Case StrToInt(Copy(fGetBancoConfig(0, 'CONFIGSPC', 'MOTISPC', '01'),1 ,02)) Of
      01 : cmbMotivoExclusao.ItemIndex := 0;
      02 : cmbMotivoExclusao.ItemIndex := 1;
      03 : cmbMotivoExclusao.ItemIndex := 2;
      04 : cmbMotivoExclusao.ItemIndex := 3;
      05 : cmbMotivoExclusao.ItemIndex := 4;
      06 : cmbMotivoExclusao.ItemIndex := 5;
      07 : cmbMotivoExclusao.ItemIndex := 6;
      08 : cmbMotivoExclusao.ItemIndex := 7;
      09 : cmbMotivoExclusao.ItemIndex := 8;
      10 : cmbMotivoExclusao.ItemIndex := 9;
      11 : cmbMotivoExclusao.ItemIndex := 10;
      12 : cmbMotivoExclusao.ItemIndex := 11;
      13 : cmbMotivoExclusao.ItemIndex := 12;
      95 : cmbMotivoExclusao.ItemIndex := 13;
      96 : cmbMotivoExclusao.ItemIndex := 14;
      97 : cmbMotivoExclusao.ItemIndex := 15;
      99 : cmbMotivoExclusao.ItemIndex := 16;
    End;
  End
  Else
    cmbMotivoExclusao.ItemIndex := 0;
end;


function TfrmConfigSPC.fCarregaCfg(Var stlCampos: TStringList): String;
begin
  Result := '';
  Result := Result + 'Seq. Remessa      :' + fGetBancoConfig(0, 'CONFIGSPC', 'PROXNUM', '') + #13+#10;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, 'CONFIGSPC', 'PROXNUM', ''));
  Result := Result + 'Cód. Entidade     :' + fGetBancoConfig(0, 'CONFIGSPC', 'CODENTI', '') + #13+#10;
  stlCampos.Add('Cód. Entidade     :' + fGetBancoConfig(0, 'CONFIGSPC', 'CODENTI', ''));
  Result := Result + 'Cód. Associado    :' + fGetBancoConfig(0, 'CONFIGSPC', 'CODASSO', '') + #13+#10;
  stlCampos.Add('Cód. Associado    :' + fGetBancoConfig(0, 'CONFIGSPC', 'CODASSO', ''));
  Result := Result + 'Motivo Exclusão   :' + fGetBancoConfig(0, 'CONFIGSPC', 'MOTISPC', '') + #13+#10;
  stlCampos.Add('Motivo Exclusão   :' + fGetBancoConfig(0, 'CONFIGSPC', 'MOTISPC', ''));
  Result := Result + 'Arquivo Remessa   :' + fGetBancoConfig(0, 'CONFIGSPC', 'PATHREM', '') + #13+#10;
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, 'CONFIGSPC', 'PATHREM', ''));
  Result := Result + 'Arquivo Retorno   :' + fGetBancoConfig(0, 'CONFIGSPC', 'PATHRET', '') + #13+#10;
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, 'CONFIGSPC', 'PATHRET', ''));
  Result := Result + 'Filtrar Dup. pagas parcialmente na exclusão:' + fGetBancoConfig(0, 'CONFIGSPC', 'PARCEXC', '') + #13+#10;
  stlCampos.Add('Filtrar Dup. pagas parcialmente na exclusão::' + fGetBancoConfig(0, 'CONFIGSPC', 'PARCEXC', ''));
end;

function TfrmConfigSPC.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
var
  strMensagemConfig: String;
Begin
  Result := True;

  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!'
  else
     strMensagemConfig := '';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtProxNumArqRem Then
    Begin

      If fEmptyStr(edtProxNumArqRem.Text) Then
      Begin
        fMensagem('', 'O Próximo Núm. Seq. Arq. Remessa deve conter um valor!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
      If StrToInt(edtProxNumArqRem.Text) < 0 Then
      Begin
        fMensagem('', 'O Próximo Núm. Seq. Arq. Remessa deve ser maior ou igual a zero!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEntidade) Then
    Begin

      If fEmptyStr(edtCodEntidade.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código da entidade deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAssociado) Then
    Begin

      If fEmptyStr(edtCodAssociado.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do associado deve ser informado!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtParciais) Then
    Begin

      If Not MatchStr(edtParciais.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Filtrar Dup. pagas parcialmente nas exclusões dese ser preenchido com "S" ou "N"!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);
End;

end.
