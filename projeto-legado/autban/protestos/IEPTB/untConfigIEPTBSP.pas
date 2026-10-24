unit untConfigIEPTBSP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, EditFocus, cxTextEdit,
  cxMaskEdit, cxButtonEdit, DirectoryEditFocus, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Uni, untTypesSistema, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit;

type
  TfrmConfigIEPTBSP = class(TfrmPai)
    lblPathArquivosRem: TLabel;
    fraPathRemessa: TfraDirectoryEditFocus;
    lblPathArquivosRet: TLabel;
    fraPathRetorno: TfraDirectoryEditFocus;
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    pnlTopo: TPanel;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    pnlAtivo: TPanel;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;

    procedure pCarregaDados;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfigurarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    function fCarregaCfg(Var stlCampos: TStringList): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  public
    { Public declarations }
    blnNaoEditar: Boolean;
  end;

var
  frmConfigIEPTBSP: TfrmConfigIEPTBSP;

implementation

uses untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan,
     untConsultas, SysUtils;

{$R *.dfm}

{ TfrmConfigIEPTBSP }

procedure TfrmConfigIEPTBSP.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
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

procedure TfrmConfigIEPTBSP.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try

    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := 'IEP';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;
end;

procedure TfrmConfigIEPTBSP.btnEditarClick(Sender: TObject);
begin
  inherited;
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo.Enabled      := True;
    btnGravar.Enabled     := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible     := False;
    btnCancelar.Visible   := true;
    btnSair.Enabled       := False;
    pSetFocus(fraPathRemessa);
  end;
end;

procedure TfrmConfigIEPTBSP.btnGravarClick(Sender: TObject);
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
  If fVerificaCampos Then
  Begin
    Try
      stlCfgAnt := TStringList.Create;
      strCfgAnt := fCarregaCfg(stlCfgAnt);
      fGetBancoConfig(1, 'CONFIGIEPTBSP', 'PATHREM', fraPathRemessa.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIGIEPTBSP', 'PATHRET', fraPathRetorno.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIGIEPTBSP', 'PORBAI_', edtCodPor.Text        );
      fGetBancoConfig(1, 'CONFIGIEPTBSP', 'CTABAI_', fraPlanoDeContas.MskCodCta.Text        );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        pnlAtivo.Enabled  := False;
        btnGravar.Enabled := False;
        btnConfigurar.Enabled := False;
        btnEditar.Visible := True;
        btnCancelar.Visible := False;
        btnSair.Enabled   := True;
        pSetFocus(btnEditar);
      End
      Else
      Begin
        Close;
        ModalResult := mrOk;
      End;

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
        pGravaLogAtb('IEP', 'IEPTBSP-SP CENTRAL DE PROTESTO', 'CONFIGIEPTBSP' + '-' + VS_StrCodEmp,
                     strLoginUsuarioLogado, VS_StrCodEmp, strCfgAnt, strCfgAtu, strCmpAlt);
    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;
  end;
end;

procedure TfrmConfigIEPTBSP.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPor, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigIEPTBSP.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
end;

procedure TfrmConfigIEPTBSP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
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

procedure TfrmConfigIEPTBSP.FormShow(Sender: TObject);
begin
  inherited;
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;

  pSetFocus(btnEditar);

  if blnNaoEditar then
  begin
     pnlAtivo.Enabled := False;
     btnConfigurar.Enabled := False;
     btnConfigurar.Visible := False;
     btnGravar.Enabled     := True;
     btnEditar.Visible     := False;
     pSetFocus(btnGravar);
  end;

end;

procedure TfrmConfigIEPTBSP.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigIEPTBSP.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPor) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!', ['&Ok']);
        edtDesPor.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(edtCodPor.Text, edtDesPor);
        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!', ['&Ok']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmConfigIEPTBSP.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigIEPTBSP.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigIEPTBSP.pCarregaDados;
begin
  edtDesPor.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';

  fraPathRemessa.edtDirectory.text := fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PATHREM', '');
  fraPathRetorno.edtDirectory.text := fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PATHRET', '');
  edtCodPor.Text      := fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PORBAI_', '');
  fraPlanoDeContas.MskCodCta.Text      := fGetBancoConfig(0, 'CONFIGIEPTBSP', 'CTABAI_', '');

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
end;

function TfrmConfigIEPTBSP.fCarregaCfg(Var stlCampos: TStringList): String;
begin
  Result := '';
  Result := Result + 'Arquivo remessa   :' + fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PATHREM', '') + #13+#10;
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PATHREM', ''));
  Result := Result + 'Arquivo retorno   :' + fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PATHRET', '') + #13+#10;
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PATHRET', ''));
  Result := Result + 'Portador de baixa :' + fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PORBAI_', '') + #13+#10;
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PORBAI_', ''));
  Result := Result + 'Conta de baixa    :' + fGetBancoConfig(0, 'CONFIGIEPTBSP', 'CTABAI_', '') + #13+#10;
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, 'CONFIGIEPTBSP', 'CTABAI_', ''));
END;

end.
