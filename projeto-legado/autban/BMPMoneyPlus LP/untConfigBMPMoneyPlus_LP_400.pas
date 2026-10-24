unit untConfigBMPMoneyPlus_LP_400;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus,
  Buttons, ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts,
  BitBtnLockedIncrem, MaskEditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, frxClass, frxExportCSVTestabilidade, Uni, untTypesSistema,
  untFrameDirectoryEditFocus, dxBarBuiltInMenu, untFramePlanoDeContasMaskEdit,
  ComboBoxFocus, cxGroupBox, cxPC;

type
  TfrmConfigBMPMoneyPlus_LP_400 = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    pnlAtivo1: TPanel;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label50: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    tbsEncBan: TcxTabSheet;
    pnlAtivo2: TPanel;
    cxGroupBox1: TcxGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    cmbLancarTarifa: TComboBoxFocus;
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    Label5: TLabel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblIdentBanco: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    ColorLabel2: TColorLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    ColorLabel3: TColorLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    ColorLabel5: TColorLabel;
    Label15: TLabel;
    ColorLabel4: TColorLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label24: TLabel;
    ColorLabel6: TColorLabel;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtDigCtaCor: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodEmpBanco: TEditFocus;
    edtCodCar: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesCtaBai: TEditFocus;
    edtCtaBai: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtProAce: TEditFocus;
    edtDigAge: TEditFocus;
    edtExpBol: TEditFocus;
    edtExpRem: TEditFocus;
    edtPerMul: TEditFocus;
    edtInfAdi: TEditFocus;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    edtDesBen: TEditFocus;
    edtEndBen: TEditFocus;
    edtCompBen: TEditFocus;
    edtBaiBen: TEditFocus;
    edtCidBen: TEditFocus;
    edtEstBen: TEditFocus;
    edtCepBen: TMaskEditFocus;
    edtCgcBen: TMaskEditFocus;
    edtUsaSac: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    Label3: TLabel;
    edtCarteiraBoletoBanco: TEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCtaBaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtUsaSacExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure pGravaLogCarteira(stlCfgAnt: TStringList);
    procedure pCarregaCfg(var stlCampos: TStringList);
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBMPMoneyPlus_LP_400: TfrmConfigBMPMoneyPlus_LP_400;

implementation

uses untfuncoesSimples, untPesqAux, untFuncoes,
     untCfgGenericas_AutBan, untConsultas;

{$R *.dfm}

procedure TfrmConfigBMPMoneyPlus_LP_400.btnCancelarClick(Sender: TObject);
begin
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    cxPaginas.ActivePage :=  tbsGeral;
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo1.Enabled := False;

    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigBMPMoneyPlus_LP_400.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo1.Enabled := True;

    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;
    //edtValidaCartPro.OnChange(edtValidaCartPro);

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(edtExpRem);
  end;
end;

procedure TfrmConfigBMPMoneyPlus_LP_400.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;
  If fVerificaCampos Then
  Begin

    If blnNaoEditar Then
    Begin
      Close;
      ModalResult := mrOk;
      Exit;
    End;

    stlCfgAnt := TStringList.Create;
    pCarregaCfg(stlCfgAnt);

    Try
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', edtCodEmpBanco.Text   );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAge.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text     );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text     );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CARTBCO', edtCarteiraBoletoBanco.Text);
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text      );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text          );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text   );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text   );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text   );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text   );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text   );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.Text);
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.Text);
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', edtCtaBai.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text      );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', edtExpBol.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOREM', edtExpRem.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', edtEndBen.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text       );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text        );
      fGetBancoConfig(1, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text        );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);

        edtProxNumArqRem.Enabled := False;
        pSetFocus(edtCodCar);
        blnMudarFoco := True;
        cxPaginas.ActivePage :=  tbsGeral;
        pnlAtivo1.Enabled := False;
        btnGravar.Enabled := False;
        btnConfigurar.Enabled := False;
        btnEditar.Visible := True;
        btnCancelar.Visible := False;
        pSetFocus(btnEditar);
      End
      Else
      Begin
        Close;
        ModalResult := mrOk;
      End;

      pGravaLogCarteira(stlCfgAnt);
    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;

  End;

end;

procedure TfrmConfigBMPMoneyPlus_LP_400.pCarregaDados;
begin

  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
  edtCodEmpBanco.Text    := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', '');
  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtCarteiraBoletoBanco.Text := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CARTBCO', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  fraPathRemessa.edtDirectory.text := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetorno.edtDirectory.text := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCtaBai.Text         := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text         := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtDigAge.Text         := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtExpBol.Text         := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', '');
  edtExpRem.Text         := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOREM', '');
  edtPerMul.Text         := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');

  //Dados Beneficiário
  edtUsaSac.Text        := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text        := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtEndBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''), '');
  edtBaiBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text       := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtCgcBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');

  fValidaCampos(edtUsaSac);

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCtaBai.Text ) Then
    pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);

end;

procedure TfrmConfigBMPMoneyPlus_LP_400.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);  
  pCarregaDados;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtExpRem);

  pnlAtivo1.Enabled := False;
  pnlComplemento.Enabled := pnlAtivo1.Enabled;
  //pnlAtivo2.Enabled := False;

  pSetFocus(btnEditar);

  if blnNaoEditar then
  begin
     btnConfigurar.Enabled := False;
     btnConfigurar.Visible := False;
     btnGravar.Enabled     := True;
     btnEditar.Visible     := False;

     pSetFocus(btnGravar);
  end;

end;

function TfrmConfigBMPMoneyPlus_LP_400.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtProxNumArqRem Then
    Begin

      If fEmptyStr(edtProxNumArqRem.Text) Then
      Begin
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve conter um valor!',['&O K']);
        Result := False;
      End
      Else
      If StrToInt(edtProxNumArqRem.Text) <= 0 Then
      Begin
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve ser maior que zero!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtExpBol Then
    Begin
      If Pos(edtExpBol.Text, '1_2_') <= 0 Then
      Begin
        fMensagem('','O campo a ser exportado para o boleto deve ser preenchido com (1/2)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtExpRem Then
    Begin
      If Pos(edtExpRem.Text, '1_2_') <= 0 Then
      Begin
        fMensagem('','O campo a ser exportado para a remessa deve ser preenchido com (1/2)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = fraPathRemessa Then
    Begin

      If fEmptyStr(fraPathRemessa.edtDirectory.Text) Then
      Begin
        fMensagem('','Preencha o campo Path de remessa!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = fraPathRetorno Then
    Begin

      If fEmptyStr(fraPathRetorno.edtDirectory.Text) Then
      Begin
        fMensagem('','Preencha o campo Path de retorno!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodPor) Then
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
        End;
      End;
    End

    Else If (Sender = edtCtaBai) Then
    Begin

      If fEmptyStr(edtCtaBai.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Centro de Custo deve ser preenchido!', ['&Ok']);
        edtDesCtaBai.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&Ok']);
          Result := False;
        End

        {Else
        If not fCentroCustoAtivo(edtCtaBai.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está ativo!', ['&Ok']);
          Result := False;
        End; }

      End;

    End

    Else If (Sender = edtContaCorr) Then
    Begin

      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Número Conta Corrente deve ser preenchido!',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCtaCor) Then
    Begin

      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Dígito da Conta Corrente deve ser preenchido!',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 100) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 100!',['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = edtCodCar) Then
    Begin
      If Length(Trim(edtCodCar.Text)) < 2 Then
      begin
        fMensagem('ATENÇÃO','O campo código da carteira deve possuir 2 dígitos!',['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = edtCarteiraBoletoBanco) Then
    Begin
      If fEmptyStr(edtCarteiraBoletoBanco.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo carteira do boleto no banco deve ser preenchido!',['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtUsaSac Then
    Begin
      If Pos(edtUsaSac.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Sacador/Avalista deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;

      grpBeneficiario.Enabled := edtUsaSac.Text = 'S';
    End

    Else If Sender = edtDesBen Then
    Begin
      If (fEmptyStr(edtDesBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtEndBen Then
    Begin
      If (fEmptyStr(edtEndBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Endereço do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtBaiBen Then
    Begin
      If (fEmptyStr(edtBaiBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Bairro do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtCidBen Then
    Begin
      If (fEmptyStr(edtCidBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Cidade do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtEstBen Then
    Begin
      If (fEmptyStr(edtEstBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Estado do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtCepBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fRetSomenteNumeros(edtCepBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If Length(fRetSomenteNumeros(edtCepBen.Text)) < 8 Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido com 8 números!' ,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtCgcBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciaisPonto(edtCgcBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If (Length(fTiraCaracEspeciaisPonto(edtCgcBen.Text)) < 14) Or (Not fTestaCgc(edtCgcBen.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve conter um número válido!' ,['&O K']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

End;

procedure TfrmConfigBMPMoneyPlus_LP_400.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigBMPMoneyPlus_LP_400.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strSQL : String;
    ArrSel: TConsultasArray;
begin
  inherited;

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  POR_CODPOR AS "Código", ';
    strSQL := strSQL + '  POR_NOMPOR AS "Nome", ';
    strSQL := strSQL + '  AUTOINCREM  ';
    strSQL := strSQL + 'FROM  ';
    strSQL := strSQL + '  CADPOR  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE  ';


  If fEntraCons(Key) Then
  Begin
    Key := #0;


    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, qryCadPor, Key, arrSel) then
    Begin
      edtCodPor.Text := qryCadPor.FieldByName('POR_CODPOR').AsString;
      pCarregaPortador(edtCodPor.Text, edtDesPor);
      Self.SelectNext(ActiveControl, True, True);
    End;

  End;

end;

procedure TfrmConfigBMPMoneyPlus_LP_400.edtCtaBaiKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, edtCtaBai, edtDesCtaBai, Nil, Key, arrCentroCusto, True, False, '', False, False) Then
    if fValidaCampos(edtCtaBai) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigBMPMoneyPlus_LP_400.edtUsaSacExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtUsaSac);
end;

procedure TfrmConfigBMPMoneyPlus_LP_400.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtDesCtaBai.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigBMPMoneyPlus_LP_400.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;                   

procedure TfrmConfigBMPMoneyPlus_LP_400.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
end;

procedure TfrmConfigBMPMoneyPlus_LP_400.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try

    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '274';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBMPMoneyPlus_LP_400.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\881400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\274400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBMPMoneyPlus_LP_400.pGravaLogCarteira(stlCfgAnt : TStringList);
Var
  intCont,
  intIndice: Integer;
  stlCfgAtu: TStringList;
  strCmpAlt: String;

  function fRetStrCfg(stlCfg : TStringList) : String;
  Var
    intCont : Integer;
  begin
    Result := '';

    For intCont := 0 To stlCfg.Count - 1 Do
      Result := Result + stlCfg.Strings[intCont] + #13+#10;
  end;

begin
  stlCfgAtu := TStringList.Create;
  pCarregaCfg(stlCfgAtu);
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
    pGravaLogAtb('274', 'BMP MONEY PLUS', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigBMPMoneyPlus_LP_400.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa       : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Cód. Emp. Banco    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', ''));
  stlCampos.Add('Código Carteira    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Código Agência     : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Num. C. Corrente   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dig. C Corrente    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Carteira do Boleto no Banco: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CARTBCO', ''));
  stlCampos.Add('Dias p/ protesto   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Resp. Emissão Bol  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Observação 1       : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2       : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3       : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4       : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5       : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Arquivo Remessa    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Portador Baixa     : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Conta Baixa        : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Dias para Crédito  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Imp. Prot. Aceite  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Digito Agência     : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('P/ Bol. Exportar   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', ''));
  stlCampos.Add('P/ Rem. Exportar   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXPOREM', ''));
  stlCampos.Add('Percentual Multa   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Info. Adicional    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Env. Sac./Aval.    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('Nome Beneficiário  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  stlCampos.Add('End. Beneficiário  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  stlCampos.Add('Bairro Beneficiário: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  stlCampos.Add('Comp. Beneficiário : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  stlCampos.Add('Cid. Beneficiário  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  stlCampos.Add('UF Beneficiário    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  stlCampos.Add('CEP Beneficiário   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  stlCampos.Add('CNPJ Beneficiário  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));

end;

end.
