unit untConfigSofisa_LP_444;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, DirectoryEditFocus,
  EditFocus, QColorLabel, ComCtrls, ShellApi, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus, ComboBoxFocus, MaskEditFocus, dxBarBuiltInMenu,
  cxPC;

type
  TfrmConfigSofisa_LP_444 = class(TfrmPai)
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
    Label50: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    pnlAtivo: TPanel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    lblCodCart: TLabel;
    lblProNum: TLabel;
    Label7: TLabel;
    lblCodAgenc: TLabel;
    lblIdentBanco: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label12: TLabel;
    lbl1: TLabel;
    ColorLabel5: TColorLabel;
    lbl2: TLabel;
    Label18: TLabel;
    Label16: TLabel;
    lblmulta: TLabel;
    Label17: TLabel;
    Label24: TLabel;
    ColorLabel2: TColorLabel;
    Label25: TLabel;
    ColorLabel3: TColorLabel;
    lblContCorr: TLabel;
    edtResp: TEditFocus;
    edtDiasProt: TEditFocus;
    edtCodCar: TEditFocus;
    edtDigAgenciaCob: TEditFocus;
    edtCodAgenciaCob: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtInstrucao1: TEditFocus;
    edtInstrucao2: TEditFocus;
    edtCodEmpr: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesCtaBai: TEditFocus;
    edtCtaBai: TEditFocus;
    edtDiasCred: TEditFocus;
    edtUsoBan: TEditFocus;
    edtMandMsg: TEditFocus;
    edtInfAdi: TEditFocus;
    fraPathRemessaCXF: TfraDirectoryEditFocus;
    fraPathRetornoCXF: TfraDirectoryEditFocus;
    cmbTipoMulta: TComboBoxFocus;
    edtDiasMora: TEditFocus;
    edtValMulta: TEditFocus;
    cmbCodigoOcorrencia: TComboBoxFocus;
    edtUsaSac: TEditFocus;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label19: TLabel;
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
    edtProAce: TEditFocus;
    edtContaCorr: TEditFocus;
    Label26: TLabel;
    EdtNumOperacao: TEditFocus;
    Label27: TLabel;
    edtCarteiraBoletoBanco: TEditFocus;
    lblNumNos: TLabel;
    edtNumNos: TEditFocus;
    lblNumNos2: TColorLabel;

    procedure pCarregaDados;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCtaBaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    function fRetStrCfg(stlCfg: TStringList): String;
  public
    { Public declarations }
     blnNaoEditar: Boolean;
     strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigSofisa_LP_444: TfrmConfigSofisa_LP_444;

implementation

uses untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan, untFuncoesConsulta, untConsultas, untTypesSistema,
  untFuncoesGenerica;

{$R *.dfm}

{ TfrmConfigSofisa_LP_444 }

procedure TfrmConfigSofisa_LP_444.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************LB*}
  edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtIdentBanc.Text      := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', '');
  edtContaCorr.Text      := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtCodEmpr.Text        := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', '');
  edtNumOperacao.Text    := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMOPER', '');
  edtCodAgenciaCob.Text  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgenciaCob.Text  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtCarteiraBoletoBanco.Text := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CARTBCO', '');
  edtInstrucao1.Text     := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '');
  edtInstrucao2.Text     := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '');
  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  fraPathRemessaCXF.edtDirectory.text := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoCXF.edtDirectory.text := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  edtCtaBai.Text         := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtUsoBan.Text         := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'USOBANC', '');

  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtMandMsg.Text        := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDPAG', 'N');
  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');

  edtProAce.Text         := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  cmbTipoMulta.ItemIndex := StrToIntDef(IIF(fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', '0') = '', '0',
    fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', '0')), 0);
  edtDiasMora.Text       := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', '');
  edtValMulta.Text       := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtNumNos.Text         := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', '1');

  if fEmptyStr(edtDiasCred.Text) Then
    edtDiasCred.Text := '00';

  if fEmptyStr(edtDiasProt.Text) Then
    edtDiasProt.Text := '00';

  if fEmptyStr(edtDiasMora.Text) Then
    edtDiasMora.Text := '00';

  Try
    Case StrToInt(fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODOCOR', '')) Of
      01: cmbCodigoOCorrencia.ItemIndex := 0;
      02: cmbCodigoOCorrencia.ItemIndex := 1;
      04: cmbCodigoOCorrencia.ItemIndex := 2;
      05: cmbCodigoOCorrencia.ItemIndex := 3;
      06: cmbCodigoOCorrencia.ItemIndex := 4;
      09: cmbCodigoOCorrencia.ItemIndex := 5;
      10: cmbCodigoOCorrencia.ItemIndex := 6;
      18: cmbCodigoOCorrencia.ItemIndex := 7;
    end;
  Except
     cmbCodigoOCorrencia.ItemIndex := -1;
  End;

  edtUsaSac.Text  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text  := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtEndBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''), '');
  edtBaiBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtCgcBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');

  fValidaCampos(edtUsaSac);

  If Not fEmptyStr(edtCodPor.Text) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr(edtCtaBai.Text) Then
    pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);

end;

procedure TfrmConfigSofisa_LP_444.btnEditarClick(Sender: TObject);
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

procedure TfrmConfigSofisa_LP_444.btnGravarClick(Sender: TObject);
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


    Try
      if fEmptyStr(edtDiasCred.Text) Then
        edtDiasCred.Text := '00';

      if fEmptyStr(edtDiasProt.Text) Then
        edtDiasProt.Text := '00';

      if fEmptyStr(edtDiasMora.Text) Then
        edtDiasMora.Text := '00';

      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text  );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text         );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text      );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text      );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', edtCodEmpr.Text        );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMOPER', edtNumOperacao.Text    );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgenciaCob.Text  );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgenciaCob.Text  );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CARTBCO', edtCarteiraBoletoBanco.Text  );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', edtInstrucao1.Text     );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', edtInstrucao2.Text     );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text    );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text    );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text    );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text    );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text    );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text       );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text           );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaCXF.edtDirectory.text );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoCXF.edtDirectory.text );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text         );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', edtCtaBai.Text         );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'USOBANC', edtUsoBan.Text         );

      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text       );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDPAG', edtMandMsg.Text        );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text         );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', edtNumNos.Text         );

      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text);
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', IntToStr(cmbTipoMulta.ItemIndex));
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', edtDiasMora.Text      );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtValMulta.Text      );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODOCOR', Copy(cmbCodigoOcorrencia.Text,0,2));

      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text        );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text        );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', edtEndBen.Text        );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text        );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text       );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text        );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text        );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text        );
      fGetBancoConfig(1, 'CONFIG637LP444p-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text        );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        blnMudarFoco := True;
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

function TfrmConfigSofisa_LP_444.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strMensagemConfig: String;
begin

  Result := True;

  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!'
  else
     strMensagemConfig := '';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtProxNumArqRem) Then
    Begin

      If fEmptyStr(edtProxNumArqRem.Text) Then
      Begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve conter um valor!'+strMensagemConfig,['&O K']);
        Result := False;
      End

      Else
      If StrToInt(edtProxNumArqRem.Text) < 0 Then
      Begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve ser maior ou igual a zero!'+strMensagemConfig,['&O K']);
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

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo conta corrente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumOperacao) Then
    Begin
      If fEmptyStr(edtNumOperacao.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo numero da operação deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCar) Then
    Begin
      If fEmptyStr(edtCodCar.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo código da carteira deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCarteiraBoletoBanco) Then
    Begin
      If fEmptyStr(edtCarteiraBoletoBanco.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo código da carteira do boleto no banco deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgenciaCob) Then
    Begin
      If fEmptyStr(edtCodAgenciaCob.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo agência deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtNumNos Then
    Begin
      If Pos(edtNumNos.Text, '12') <= 0 Then
      Begin
        fMensagem('','O campo utilizar nosso número deve ser preenchido com (1 ou 2)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = fraPathRemessaCXF Then
    Begin

      If fEmptyStr(fraPathRemessaCXF.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Remessa'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = fraPathRetornoCXF Then
    Begin

      If fEmptyStr(fraPathRetornoCXF.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Retorno'+strMensagemConfig,['&O K']);
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
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este operador!'+strMensagemConfig,['&O K']);
            Result := False;
          End;
        End
        Else If (Not fPortadorPermiteBaixa(edtCodPor.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCtaBai) Then
    Begin

      If fEmptyStr(edtCtaBai.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig,['&O K']);
        edtDesCtaBai.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
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

    Else If Sender = edtUsaSac Then
    Begin
      If Pos(edtUsaSac.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Sacador/Avalista deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;

      grpBeneficiario.Enabled := edtUsaSac.Text = 'S';
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If (StrToIntDef(edtDiasProt.Text, -1) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade de Dias para Protesto precisa ser maior ou igual a zero!', ['&O K']);
        edtDiasProt.Clear;
        Result := False;
      End
    End

    Else If (Sender = edtDiasCred) Then
    Begin
      If (StrToIntDef(edtDiasCred.Text, -1) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade de Dias para Crédito precisa ser maior ou igual a zero!', ['&O K']);
        edtDiasCred.Clear;
        Result := False;
      End
    End

    Else If (Sender = edtDiasMora) Then
    Begin
      If (StrToIntDef(edtDiasMora.Text, -1) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade de Dias para Mora precisa ser maior ou igual a zero!', ['&O K']);
        edtDiasMora.Clear;
        Result := False;
      End
    End;

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);
end;

procedure TfrmConfigSofisa_LP_444.FormShow(Sender: TObject);
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

procedure TfrmConfigSofisa_LP_444.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigSofisa_LP_444.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigSofisa_LP_444.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigSofisa_LP_444.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigSofisa_LP_444.edtCtaBaiKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigSofisa_LP_444.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  edtDesCtaBai.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmConfigSofisa_LP_444.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmConfigSofisa_LP_444.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigSofisa_LP_444.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigSofisa_LP_444.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigSofisa_LP_444.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '637';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigSofisa_LP_444.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\637400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\637400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigSofisa_LP_444.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Identif. Banco    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', ''));
  stlCampos.Add('Cedente           :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Cód. empresa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', ''));
  stlCampos.Add('Num. Operação     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMOPER', ''));
  stlCampos.Add('Uso do banco      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USOBANC', ''));
  stlCampos.Add('Cód. agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Díg. agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Cart. boleto no banco:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CARTBCO', ''));
  stlCampos.Add('Cód. instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Envia mens. agrup.:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENVDPAG', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Aceite            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Nosso Numero      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', ''));
  stlCampos.Add('Tipo Multa        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', ''));
  stlCampos.Add('Dias Mora         :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', ''));
  stlCampos.Add('Valor Multa       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Codigo Ocorrencia :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODOCOR', ''));
  stlCampos.Add('Usa Sacador       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('Nome Beneficiario :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  stlCampos.Add('End. Beneficiario :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  stlCampos.Add('Bairro Benefic.   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  stlCampos.Add('Complt. Benefic.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  stlCampos.Add('Cidade Benefic.   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  stlCampos.Add('Estado Benefic.   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  stlCampos.Add('CEP Benefic.      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  stlCampos.Add('CNPJ Benefic.     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));
end;

function TfrmConfigSofisa_LP_444.fRetStrCfg(stlCfg : TStringList) : String;
Var
  intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

procedure TfrmConfigSofisa_LP_444.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('637', 'BANCO SOFISA 444p', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
