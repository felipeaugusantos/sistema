unit untConfigSparti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus,
  Buttons, ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni,
  BitBtnLockedIncrem, MaskEditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, frxClass, frxExportCSVTestabilidade, untFrameDirectoryEditFocus;

type
  TfrmConfigSparti = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    pnlAtivo1: TPanel;
    Label5: TLabel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblIdentBanco: TLabel;
    lblNumAutBco: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    lblTipCob: TLabel;
    ColorLabel1: TColorLabel;
    ColorLabel2: TColorLabel;
    Label3: TLabel;
    Label4: TLabel;
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
    Label25: TLabel;
    ColorLabel6: TColorLabel;
    edtTipoCob: TEditFocus;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtNumAutBco: TEditFocus;
    edtDigCtaCor: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodEmpBanco: TEditFocus;
    edtCodCar: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtInstrucao1: TEditFocus;
    edtInstrucao2: TEditFocus;
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
    Label24: TLabel;
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
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCtaBaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtCodAgenciaExit(Sender: TObject);
    procedure edtContaCorrExit(Sender: TObject);
    procedure edtCodEmpBancoExit(Sender: TObject);
    procedure edtUsaSacExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    function fRetStrCfg(stlCfg: TStringList): String;
    procedure pGravaLogCarteira(stlCfgAnt: TStringList);
    procedure pCarregaCfg(var stlCampos: TStringList);
  public
    { Public declarations }
    blnNaoEditar: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigSparti: TfrmConfigSparti;

implementation

uses untfuncoesSimples, untPesqAux,
     untCfgGenericas_AutBan, untConsultas, untTypesSistema, untFuncoes;

{$R *.dfm}

procedure TfrmConfigSparti.btnEditarClick(Sender: TObject);
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

procedure TfrmConfigSparti.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;

  If blnNaoEditar Then
  Begin
    Close;
    ModalResult := mrOk;
    Exit;
  End;

  If fVerificaCampos Then
  Begin

    stlCfgAnt := TStringList.Create;
    pCarregaCfg(stlCfgAnt);

    Try
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', edtCodEmpBanco.Text   );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAge.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text     );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text     );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMAUTO', edtNumAutBco.Text     );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text      );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text          );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', edtInstrucao1.Text    );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', edtInstrucao2.Text    );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text   );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text   );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text   );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text   );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text   );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', edtTipoCob.Text       );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.Text);
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.Text);
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', edtCtaBai.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text      );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', edtExpBol.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOREM', edtExpRem.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', edtEndBen.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text       );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text        );
      fGetBancoConfig(1, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text        );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);

        edtProxNumArqRem.Enabled := False;
        pSetFocus(edtCodCar);
        blnMudarFoco := True;
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

procedure TfrmConfigSparti.pCarregaDados;
begin

  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
  edtCodEmpBanco.Text    := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', '');
  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtNumAutBco.Text      := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMAUTO', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  edtInstrucao1.Text     := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '');
  edtInstrucao2.Text     := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '');
  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  edtTipoCob.Text        := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCtaBai.Text         := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text         := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtDigAge.Text         := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtExpBol.Text         := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', '');
  edtExpRem.Text         := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOREM', '');
  edtPerMul.Text         := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');

  //Dados Beneficiário
  edtUsaSac.Text         := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text         := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text         := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtEndBen.Text         := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''), '');
  edtBaiBen.Text         := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text         := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text         := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text         := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtCgcBen.Text         := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');

  fraPathRemessa.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetorno.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');

  fValidaCampos(edtUsaSac);

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCtaBai.Text ) Then
    pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);

end;

procedure TfrmConfigSparti.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);  
  pCarregaDados;
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

function TfrmConfigSparti.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If Sender = edtTipoCob Then
    Begin

      If (edtTipoCob.Text <> 'S') And (edtTipoCob.Text <> 'D') Then
      Begin
        fMensagem('','O campo Tipo de Cobrança deve ser S ou D!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtInstrucao1) Then
    Begin

      If fEmptyStr(edtInstrucao1.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!',['&OK']);
        Result := False;
      End

    End

    Else If (Sender = edtInstrucao2) Then
    Begin

      If fEmptyStr(edtInstrucao2.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!',['&OK']);
        Result := False;
      End

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
        End;
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
        If (fEmptyStr(fTiraCaracEspeciais(edtCepBen.Text, True, True, True, True))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If Length(fTiraCaracEspeciais(edtCepBen.Text, True, True, True, True)) < 8 Then
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
        If (fEmptyStr(fTiraCaracEspeciais(edtCgcBen.Text, True, True, True, True))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If (Length(fTiraCaracEspeciais(edtCgcBen.Text, True, True, True, True)) < 14) Or (Not fValidaCnpjCpf('1', edtCgcBen.Text)) Then
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

procedure TfrmConfigSparti.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigSparti.edtCodAgenciaExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodAgencia.Text) <> '' then
  begin
    if Length(Trim(edtCodAgencia.Text)) < 4 then
      edtCodAgencia.Text := fPadL(edtCodAgencia.Text , 004, '0');
  end;    

end;

procedure TfrmConfigSparti.edtCodEmpBancoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodEmpBanco.Text) <> '' then
  begin
    if Length(Trim(edtCodEmpBanco.Text)) < 7 then
      edtCodEmpBanco.Text := fPadL(edtCodEmpBanco.Text , 007, '0');
  end;
end;

procedure TfrmConfigSparti.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
Var
  strSQL : String;
  arrSel: TConsultasArray;
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

    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, qryCadPor, Key, arrSel) Then
    Begin
      edtCodPor.Text := qryCadPor.FieldByName('POR_CODPOR').AsString;
      Self.SelectNext((Sender As TWinControl), True, True);
    End;

  End;
end;

procedure TfrmConfigSparti.edtContaCorrExit(Sender: TObject);
begin
  inherited;
  if Trim(edtContaCorr.Text) <> '' then
  begin
    if Length(Trim(edtContaCorr.Text)) < 7 then
      edtContaCorr.Text := fPadL(edtContaCorr.Text , 007, '0');
  end;
end;

procedure TfrmConfigSparti.edtCtaBaiKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, edtCtaBai, edtDesCtaBai, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(edtCtaBai) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigSparti.edtUsaSacExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtUsaSac);
end;

procedure TfrmConfigSparti.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtDesCtaBai.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigSparti.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;                   

procedure TfrmConfigSparti.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
end;

procedure TfrmConfigSparti.btnCancelarClick(Sender: TObject);
begin
  If fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 Then
  Begin
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo1.Enabled := False;

    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  End;
end;

procedure TfrmConfigSparti.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try

    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '982';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigSparti.BtnManualClick(Sender: TObject);
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
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\991400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

function TfrmConfigSparti.fRetStrCfg(stlCfg : TStringList) : String;
Var
  intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

procedure TfrmConfigSparti.pGravaLogCarteira(stlCfgAnt : TStringList);
Var
  intCont,
  intIndice: Integer;
  stlCfgAtu: TStringList;
  strCmpAlt: String;
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
    pGravaLogAtb('982', 'SPARTI', 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigSparti.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa       : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Cód. Emp. Banco    : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', ''));
  stlCampos.Add('Código Carteira    : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Código Agência     : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Num. C. Corrente   : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dig. C. Corrente   : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Num. Aut. Banco    : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMAUTO', ''));
  stlCampos.Add('Dias p/ protesto   : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Resp. Emissão Bol. : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Cód. Instrução 1   : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. Instrução 1   : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1       : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2       : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3       : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4       : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5       : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Tipo de Cobrança   : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', ''));
  stlCampos.Add('Portador de Baixa  : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Conta Baixa        : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Dias p/ Crédito    : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Imp. Prot. Aceite  : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Dígito Agência     : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('P/ Bol. Exportar   : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', ''));
  stlCampos.Add('P/ Rem. Exportar   : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOREM', ''));
  stlCampos.Add('Percentual Multa   : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Info. Adicional    : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Env. Sac./Aval.    : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('Nome Beneficiário  : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  stlCampos.Add('End. Beneficiário  : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  stlCampos.Add('Bairro Beneficiário: ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  stlCampos.Add('Comp. Beneficiário : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  stlCampos.Add('Cid. Beneficiário  : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  stlCampos.Add('UF Beneficiário    : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  stlCampos.Add('CEP Beneficiário   : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  stlCampos.Add('CNPJ Beneficiário  : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));
  stlCampos.Add('Arquivo Remessa    : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno    : ' + fGetBancoConfig(0, 'CONFIG982-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
end;

end.
