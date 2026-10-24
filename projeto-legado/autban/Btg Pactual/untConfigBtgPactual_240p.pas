unit untConfigBtgPactual_240p;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, Uni, AppEvnts, ComboBoxFocus,
  BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, strutils,
  dxBarBuiltInMenu, cxPC, MaskEditFocus, cxDropDownEdit;

type
  TfrmConfigBtgPactual_240p = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    pnlAtivo: TPanel;
    lblCodCart: TLabel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    lbl2: TLabel;
    lblCodAgenc: TLabel;
    Label5: TLabel;
    ColorLabel1: TColorLabel;
    Label18: TLabel;
    Label16: TLabel;
    lblmulta: TLabel;
    Label17: TLabel;
    edtDiasProt: TEditFocus;
    edtCodCar: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtInstrucao1: TEditFocus;
    edtInstrucao2: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtInfAdi: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    edtCodAgencia: TEditFocus;
    edtDigAgencia: TEditFocus;
    edtResp: TEditFocus;
    cmbTipoMulta: TComboBoxFocus;
    edtDiasMora: TEditFocus;
    edtValMulta: TEditFocus;
    cmbCodigoOcorrencia: TComboBoxFocus;
    lblContCorr: TLabel;
    edtContaCorr: TEditFocus;
    edtDigCtaCor: TEditFocus;
    edtNumConvenio: TEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    edtProAce: TEditFocus;
    ColorLabel3: TColorLabel;
    Label24: TLabel;
    ColorLabel4: TColorLabel;
    edtUsaSac: TEditFocus;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label2: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    edtDesBen: TEditFocus;
    edtEndBen: TEditFocus;
    edtCompBen: TEditFocus;
    edtBaiBen: TEditFocus;
    edtCidBen: TEditFocus;
    edtEstBen: TEditFocus;
    edtCepBen: TMaskEditFocus;
    edtCgcBen: TMaskEditFocus;
    Label19: TLabel;
    cmbCodProt: TComboBoxFocus;
    Label25: TLabel;
    edtDigVerAgCta: TEditFocus;
    Label26: TLabel;
    cmbTipoCadastramento: TComboBoxFocus;
    Label27: TLabel;
    cmbTipoDoc: TComboBoxFocus;
    Label28: TLabel;
    cmbEspDoc: TComboBoxFocus;
    Label29: TLabel;
    Label30: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    CmbTpJuros: TComboBoxFocus;
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure tabCarteiraChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCodProtChange(Sender: TObject);
  private
    { Private declarations }
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pCarregaCodigoProtesto;
    procedure CarregaTipoJuros;
    procedure pCarregaTipoCadastramento;
    procedure pCarregaTipoDocumento;
    function fRetStrCfg(stlCfg: TStringList): String;
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBtgPactual_240p: TfrmConfigBtgPactual_240p;

implementation

uses  untfuncoesSimples,  untPesqAux,  untFuncoes,
  untCfgGenericas_AutBan, untConsultas;

{$R *.dfm}

procedure TfrmConfigBtgPactual_240p.pCarregaCodigoProtesto;
begin

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODPROT', '')) Then
  Begin

    Case StrToInt(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODPROT', '')) Of
      1 : cmbCodProt.ItemIndex := 0;  //  1 - PROTESTAR DIAS CORRIDOS
      2 : cmbCodProt.ItemIndex := 1;  //  2 - PROTESTAR DIAS ÚTEIS
      3 : cmbCodProt.ItemIndex := 2;  //  3 - NÃO PROTESTAR
      4 : cmbCodProt.ItemIndex := 3;  //  4 - PROTESTAR FIM FALIMENTAR - DIAS ÚTEIS
      5 : cmbCodProt.ItemIndex := 4;  //  5 - PROTESTAR FIM FALIMENTAR - DIAS CORRIDOS
      8 : cmbCodProt.ItemIndex := 5;  //  8 - NEGATIVAÇÃO SEM PROTESTO
      9 : cmbCodProt.ItemIndex := 6;  //  9 - CANCELAMENTO PROTESTO AUTOMÁTICO
    End;
  End
  Else
    cmbCodProt.ItemIndex := -1;

  if Copy(cmbCodProt.Text, 1, 1) = '3' then
     edtDiasProt.Enabled := False
  else
     edtDiasProt.Enabled := True;

End;

procedure TfrmConfigBtgPactual_240p.pCarregaTipoCadastramento;
begin

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPOCAD', '')) Then
  Begin

    Case StrToInt(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPOCAD', '')) Of
      1 : cmbTipoCadastramento.ItemIndex := 0;  // 1 - Com Cadastramento (Cobrança Registrada)
      2 : cmbTipoCadastramento.ItemIndex := 1;  // 2 - Sem Cadastramento (Cobrança sem Registro)
      3 : cmbTipoCadastramento.ItemIndex := 2;  // 3 - Com Cadastramento / Recusa do Débito Automático
    End;

  End
  Else
    cmbTipoCadastramento.ItemIndex := -1;

End;

procedure TfrmConfigBtgPactual_240p.pCarregaTipoDocumento;
begin

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPODOC', '')) Then
  Begin

    Case StrToInt(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPODOC', '')) Of
      1 : cmbTipoDoc.ItemIndex := 0;  // 1 - Tradicional
      2 : cmbTipoDoc.ItemIndex := 1;  // 2 - Escritural
    End;

  End
  Else
    cmbTipoDoc.ItemIndex := -1;

End;

procedure TfrmConfigBtgPactual_240p.CarregaTipoJuros;
  Var
    LOpcao : Integer;
begin
  Try
    LOpcao := StrToInt(LeftSTr(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'TPJUROS', ''),1));

    Case LOpcao Of
      1: cmbTpJuros.ItemIndex := 0;
      2: cmbTpJuros.ItemIndex := 1;
      3: cmbTpJuros.ItemIndex := 2;
    End;

  Except
    cmbTpJuros.ItemIndex := -1;
  End;
end;

procedure TfrmConfigBtgPactual_240p.cmbCodProtChange(Sender: TObject);
begin
  inherited;
  if Copy(cmbCodProt.Text, 1, 1) = '3' then
  Begin
    edtDiasProt.Enabled := False;
    edtDiasProt.Text    := '0';
  End
  else
    edtDiasProt.Enabled := True;
end;

procedure TfrmConfigBtgPactual_240p.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
  edtContaCorr.Text      := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgencia.Text     := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');

  edtDigVerAgCta.Text    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGCT', '');

  edtNumConvenio.Text    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '');
  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  fraPlanoDeContas.MskCodCta.Text         := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtInstrucao1.Text     := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '');
  edtInstrucao2.Text     := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '');
  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  cmbTipoMulta.ItemIndex := StrToInt(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', '0'));
  edtDiasMora.Text       := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', '');
  edtValMulta.Text       := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');

  Try
    Case StrToInt(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODOCOR', '')) Of
      01: cmbCodigoOCorrencia.ItemIndex := 0;
      02: cmbCodigoOCorrencia.ItemIndex := 1;
      04: cmbCodigoOCorrencia.ItemIndex := 2;
      05: cmbCodigoOCorrencia.ItemIndex := 3;
      06: cmbCodigoOCorrencia.ItemIndex := 4;
      07: cmbCodigoOCorrencia.ItemIndex := 5;
      08: cmbCodigoOCorrencia.ItemIndex := 6;
      09: cmbCodigoOCorrencia.ItemIndex := 7;
      10: cmbCodigoOCorrencia.ItemIndex := 8;
      18: cmbCodigoOCorrencia.ItemIndex := 9;
      47: cmbCodigoOCorrencia.ItemIndex := 10;
    end;
  except
     cmbCodigoOCorrencia.ItemIndex := -1;
  end;

  fraPathRemessa.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetorno.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  edtProAce.Text         := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');

  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');

  //Dados Beneficiário
  edtUsaSac.Text        := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text        := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtEndBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''), '');
  edtBaiBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text       := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtCgcBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');

  fValidaCampos(edtUsaSac);

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  pCarregaCodigoProtesto;

  CarregaTipoJuros;

  cmbEspDoc.ItemIndex := cmbEspDoc.Items.IndexOf(fGetBancoConfig(0,'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1),'ESPDOC_', '02 - DM  Duplicata Mercantil'));

  pCarregaTipoCadastramento();

  pCarregaTipoDocumento();

end;

procedure TfrmConfigBtgPactual_240p.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;
  pSetFocus(edtProxNumArqRem);

  pSetFocus(btnEditar);

  if blnNaoEditar then
  begin
     pnlAtivo.Enabled := False;
     pnlComplemento.Enabled := pnlAtivo.Enabled;
     btnConfigurar.Enabled := False;
     btnConfigurar.Visible := False;
     btnGravar.Enabled     := True;
     btnEditar.Visible     := False;
     pSetFocus(btnGravar);
  end;

end;

procedure TfrmConfigBtgPactual_240p.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo.Enabled  := True;
    pnlComplemento.Enabled := pnlAtivo.Enabled;
    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(edtCodCar);

  end;

end;

procedure TfrmConfigBtgPactual_240p.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;

  If fVerificaCampos Then
  Begin
    Try
      If blnNaoEditar Then
      Begin
        Close;
        ModalResult := mrOk;
        Exit;
      End;

      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text   );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text   );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGCT', edtDigVerAgCta.Text  );

      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtNumConvenio.Text   );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text       );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', edtInstrucao1.Text   );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', edtInstrucao2.Text   );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOC_', cmbEspDoc.Text);
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );

      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', IntToStr(cmbTipoMulta.ItemIndex));
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', edtDiasMora.Text     );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtValMulta.Text     );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'TPJUROS', LeftStr(CmbTpJuros.Text,1));
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODOCOR', LeftStr(cmbCodigoOcorrencia.Text,2));
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );

      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text    );

      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text       );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text       );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', edtEndBen.Text       );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text       );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text      );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text       );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text       );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text       );
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text       );

      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'CODPROT', LeftStr(cmbCodProt.Text,1));
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPOCAD', LeftStr(cmbTipoCadastramento.Text,1));
      fGetBancoConfig(1, 'CONFIG208-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPODOC', LeftStr(cmbTipoDoc.Text,1));

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        pnlAtivo.Enabled  := False;
        pnlComplemento.Enabled := pnlAtivo.Enabled;
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

    FreeAndNil(stlCfgAnt);
  End;

end;

procedure TfrmConfigBtgPactual_240p.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
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

function TfrmConfigBtgPactual_240p.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve conter um valor!'+strMensagemConfig,['&O K']);
        Result := False;
      End

      Else If StrToInt(edtProxNumArqRem.Text) <= 0 Then
      Begin
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve ser maior que zero!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtInstrucao1) Then
    Begin

      If fEmptyStr(edtInstrucao1.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&O K']);
        Result := False;
      End

    End

    Else If (Sender = edtInstrucao2) Then
    Begin

      If fEmptyStr(edtInstrucao2.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&O K']);
        Result := False;
      End

    End

    Else If Sender = fraPathRemessa Then
    Begin

      If fEmptyStr(fraPathRemessa.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Remessa'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = fraPathRetorno Then
    Begin

      If fEmptyStr(fraPathRetorno.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Retorno'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodCar) Then
    Begin

      If fEmptyStr(edtCodCar.Text) Then
      Begin
         fMensagem('ATENÇÃO!','O Campo código da carteira deve ser preenchido! ', ['&OK']);
         Result := False;
      End;

    End

    Else If (Sender = edtContaCorr) Then
    Begin

      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Número Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If Length(edtContaCorr.Text) <> edtContaCorr.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O Número Conta Corrente deve ter 7 caracteres!',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCtaCor) Then
    Begin

      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agência deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumConvenio) Then
    Begin

      If fEmptyStr(edtNumConvenio.text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo código do convênio deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'B') And (edtResp.Text <> 'E') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser B ou E!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodPorRem) Then
    Begin
        If (edtCodPorRem.Text <> EmptyStr) Then
        Begin
          pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);
          If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(edtCodPorRem.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPorRem.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End;
          End
          Else If (Not fPortadorPermiteBaixa(edtCodPorRem.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End;
        End
        Else
          edtDescPorRem.Clear;
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
        Else If (Length(fTiraCaracEspeciaisPonto(edtCgcBen.Text)) < 14) Or (Not fValidaCnpjCpf(edtCgcBen.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve conter um número válido!' ,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodPor) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!'+strMensagemConfig,['&O K']);
        edtDesPor.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(edtCodPor.Text, edtDesPor);
        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If (Not fPortadorPermiteBaixa(edtCodPor.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig,['&O K']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False;
      End;
    End;

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigBtgPactual_240p.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigBtgPactual_240p.edtCodPorRemKeyPress(Sender: TObject;
  var Key: Char);
var
 ArrSel: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPorRem, edtDescPorRem, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPorRem, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigBtgPactual_240p.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmConfigBtgPactual_240p.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  fraPlanoDeContas.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmConfigBtgPactual_240p.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigBtgPactual_240p.tabCarteiraChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if btnCancelar.Visible then
  begin
    btnCancelar.Click;
    if btnCancelar.Visible then
      AllowChange := False;
  end;

  inherited;

end;

procedure TfrmConfigBtgPactual_240p.FormCreate(Sender: TObject);
begin
  inherited;
  pCarKeyAutBan;
  qryCadPor := fCriaQuery(Self);
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigBtgPactual_240p.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigBtgPactual_240p.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo.Enabled    := False;
    pnlComplemento.Enabled := pnlAtivo.Enabled;
    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;

end;

procedure TfrmConfigBtgPactual_240p.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '208';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBtgPactual_240p.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\246400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\246400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBtgPactual_240p.pCarregaCfg(Var stlCampos: TStringList);
begin

  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Cód. Conta Corr.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dig. Conta Corr.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Cód. Agencia      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Dig. Agencia      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Dig. Ag./Conta    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGCT', ''));
  stlCampos.Add('Cód. Convenio     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  stlCampos.Add('Cód. Carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Cód. Instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. Instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Espécie do Docto. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOC_', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Tipo Multa        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', ''));
  stlCampos.Add('Tipo Juros        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TPJUROS', ''));
  stlCampos.Add('Dias de Mora      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', ''));
  stlCampos.Add('Valor Multa       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Código da Ocorr.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODOCOR', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Protocolo Aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Resp. por Emissão de Boletos:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Envia Sac/Avalista:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('Nome beneficiário :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  stlCampos.Add('Endereço          :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  stlCampos.Add('Bairro            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  stlCampos.Add('Complemento       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  stlCampos.Add('Cidade            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  stlCampos.Add('Estado            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  stlCampos.Add('CEP               :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  stlCampos.Add('CNPJ              :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));
  stlCampos.Add('Código Protesto   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODPROT', ''));
end;

function TfrmConfigBtgPactual_240p.fRetStrCfg(stlCfg : TStringList) : String;
Var
  intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
      Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

procedure TfrmConfigBtgPactual_240p.pGravaLogCarteira(stlCfgAnt : TStringList);
Var
  stlCfgAtu: TStringList;
  strCmpAlt: String;
  intCont,
  intIndice: Integer;
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
    pGravaLogAtb('208', 'BTGPACTUAL', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
