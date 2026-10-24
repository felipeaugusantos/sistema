unit untConfigCredisisAPI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, QColorLabel, ComCtrls, ShellApi, Uni,
  AppEvnts, MaskEditFocus, cxContainer, cxEdit, cxGroupBox, cxPC,
  cxControls, ComboBoxFocus, BitBtnLockedIncrem, cxPCdxBarPopupMenu, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxBarBuiltInMenu, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, dxScreenTip, cxClasses, dxCustomHint, cxHint,
  StrUtils, cxTextEdit, cxMaskEdit, cxButtonEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, Datasnap.DBClient,
  System.Generics.Collections, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  Vcl.DBCtrls, DBEditFocus, DBMemoFocus, MemoFocus,
  untFramePlanoDeContasMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox;

type
  TfrmConfigCredisisAPI = class(TfrmPai)
    pnlDados: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    HintControler: TcxHintStyleController;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    pnlAtivo1: TPanel;
    Label6: TLabel;
    lblCodCart: TLabel;
    lblDiasProt: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label25: TLabel;
    edtNumConvenio: TEditFocus;
    edtDiasProt: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtPerMul: TEditFocus;
    cmbCodCar: TComboBoxFocus;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    Label15: TLabel;
    edtProAce: TEditFocus;
    ColorLabel3: TColorLabel;
    edtDigCtaCor: TEditFocus;
    edtContaCorr: TEditFocus;
    lblContCorr: TLabel;
    edtDigAgencia: TEditFocus;
    edtCodAgencia: TEditFocus;
    lblCodAgenc: TLabel;
    cxTabDadosBaixa: TcxTabSheet;
    pnlAtivo2: TPanel;
    gpbSimples: TcxGroupBox;
    Label4: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    fraPlanoDeContasBai: TfraPlanoDeContasMskEdit;
    Label7: TLabel;
    cmbTpDiaProt: TcxComboBox;
    Label8: TLabel;
    CmbTpMulta: TcxComboBox;
    Label16: TLabel;
    CmbTpJuros: TcxComboBox;
    Label18: TLabel;
    cmbOrgaoNegativ: TcxComboBox;
    tabAvalista: TcxTabSheet;
    Panel1: TPanel;
    Label2: TLabel;
    ColorLabel10: TColorLabel;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    edtDesBen: TEditFocus;
    edtEndBen: TEditFocus;
    edtCompBen: TEditFocus;
    edtBaiBen: TEditFocus;
    edtCidBen: TEditFocus;
    edtEstBen: TEditFocus;
    edtCepBen: TMaskEditFocus;
    edtCgcBen: TMaskEditFocus;
    edtUsaSac: TEditFocus;
    Label3: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    cmbAmbiente: TcxComboBox;
    cmbTptitulo: TcxComboBox;
    edtToken: TMemoFocus;
    Label17: TLabel;
    edtNumBen: TEditFocus;
    procedure pCarregadados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure lblValidaOcoMouseLeave(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtQtdDiasDataLimiteRecExit(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure edtPerMulExit(Sender: TObject);
    procedure edtQtdDiasNegaExit(Sender: TObject);
    procedure edtDiasProtEnter(Sender: TObject);
    procedure edtDiasProtExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure cmbContaCaucaoMouseEnter(Sender: TObject);
    procedure cmbContaCaucaoEnter(Sender: TObject);
    procedure cmbContaCaucaoMouseLeave(Sender: TObject);
    procedure cmbContaCaucaoExit(Sender: TObject);

  private

    qryCadPor : TUniQuery;
    qryCadEmp : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pHideHint;
    procedure pAlteraHint(edtEdit: TEditFocus; strNovoHint: String);
    procedure pLimpaCampos;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    function fRetStrCfg(stlCfg : TStringList) : String;
    procedure CarregaCodigoDaCarteira;
    //procedure CarregaAmbiente;
    procedure CarregaTipoTitulo;
    procedure CarregaTipoDiasProtesto;
    procedure CarregaTipoMulta;
    procedure CarregaTipoJuros;
    function PortadorValido(ACodigo: TEdit; ADescricao: TEdit):Boolean;
    function PlanoDeContaValido(ACodigo: TMaskEdit; ADescricao: TEdit):Boolean;
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;

    { Private declarations }
  public
    { Public declarations }
    blnNaoEditar : Boolean;
    strConfig    : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;

  end;

var
  frmConfigCredisisAPI: TfrmConfigCredisisAPI;

implementation

uses  untfuncoesSimples, untPesqAux, untFuncoes,
     untCfgGenericas_AutBan, untConsultas,untTBancoDoBrasilAPI;

{$R *.dfm}

{ TfrmPai1 }

procedure TfrmConfigCredisisAPI.pCarregadados;
begin
  pLimpaCampos;

  edtNumConvenio.Text          := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '');
  edtContaCorr.Text            := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text            := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtCodAgencia.Text           := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgencia.Text           := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtObservacao1.Text          := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text          := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text          := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text          := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text          := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  edtDiasProt.Text             := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtDiasCred.Text             := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtPerMul.Text               := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtPerMul.Text               := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtCodPor.Text               := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');

  edtToken.Clear;
  If (fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TOKEN', '') <> '') Then
     edtToken.Text     := 'Token cadastrado';

  edtProAce.Text               := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtUsaSac.Text               := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text               := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  cmbOrgaoNegativ.Text          := fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'ORGAONEGAT','');

  edtDesBen.Text               := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtEndBen.Text               := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''), '');
  edtBaiBen.Text               := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text              := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text               := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text               := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text               := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtNumBen.Text               := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUM_BEN', ''), '');
  edtCgcBen.Text               := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');

  CarregaCodigoDaCarteira;
  //CarregaAmbiente;
  CarregaTipoTitulo;
  CarregaTipoDiasProtesto;
  CarregaTipoMulta;
  CarregaTipoJuros;

  pCarregaPortador(edtCodPor.Text, edtDesPor);
  pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);

  fValidaCampos(edtUsaSac);

end;


procedure TfrmConfigCredisisAPI.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;

  pnlAtivo1.Enabled := False;
  pnlAtivo2.Enabled := False;
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

procedure TfrmConfigCredisisAPI.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo1.Enabled := True;
    pnlAtivo2.Enabled := True;
    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;
    pSetFocus(cmbCodCar);
  end;
end;


procedure TfrmConfigCredisisAPI.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;
  If fVerificaCampos Then
  Begin

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', 'E');
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', cmbCodCar.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtNumConvenio.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text);

      If Not MatchStr(edtToken.Text, ['', 'Token cadastrado']) Then
        fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TOKEN', edtToken.Text);

      //**********************************************************************************************************************//
      //Desabilitado pq conforme o manual, se o cliente configurar API e gerar a chave automaticamente estara em homologação; //
      //**********************************************************************************************************************//
      //fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPAMBIENTE', cmbAmbiente.Text);             [

      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPTITULO', cmbTpTitulo.text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPDIAPROT', LeftStr(CmbTpDiaProt.Text,1));

      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', LeftStr(CmbTpMulta.Text,1));
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPJUROS', LeftStr(CmbTpJuros.Text,1));

      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'ORGAONEGAT', cmbOrgaoNegativ.text);

      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text );
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', edtEndBen.Text );
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text );
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text );
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text );
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text );
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUM_BEN', edtNumBen.Text );
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text );

      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text);
      fGetBancoConfig(1, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContasBai.mskCodCta.Text);

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        pSetFocus(cmbCodCar);
        cxPaginas.ActivePage :=  tbsGeral;
        pnlAtivo1.Enabled := False;
        pnlAtivo2.Enabled := False;

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
      pCarregaDados;

    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;

    FreeAndNil(stlCfgAnt);
  End;
end;


procedure TfrmConfigCredisisAPI.CarregaCodigoDaCarteira;
begin
  Try
    Case StrToInt(fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
      11: cmbCodCar.ItemIndex := 0;
      12: cmbCodCar.ItemIndex := 1;
      16: cmbCodCar.ItemIndex := 2;
      17: cmbCodCar.ItemIndex := 3;
      18: cmbCodCar.ItemIndex := 4;
      31: cmbCodCar.ItemIndex := 5;
      51: cmbCodCar.ItemIndex := 6;
    End;
  Except
    cmbCodCar.ItemIndex := -1;
  End;
end;

{
procedure TfrmConfigCredisisAPI.CarregaAmbiente;
  Var
    LOpcao : Integer;
begin
  Try
    LOpcao := StrToInt(LeftSTr(fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPAMBIENTE', ''),1));

    Case LOpcao Of
      1: cmbAmbiente.ItemIndex := 0;
      2: cmbAmbiente.ItemIndex := 1;
    End;

  Except
    cmbAmbiente.ItemIndex := -1;
  End;
end; }

procedure TfrmConfigCredisisAPI.CarregaTipoTitulo;
  Var
    LOpcao : Integer;
begin
  Try
    LOpcao := StrToInt(LeftSTr(fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPTITULO', ''),2));

    Case LOpcao Of
      03: cmbTpTitulo.ItemIndex := 0;
      05: cmbTpTitulo.ItemIndex := 1;
      12: cmbTpTitulo.ItemIndex := 2;
      17: cmbTpTitulo.ItemIndex := 3;
      20: cmbTpTitulo.ItemIndex := 4;
      21: cmbTpTitulo.ItemIndex := 5;
      23: cmbTpTitulo.ItemIndex := 6;
    End;

  Except
    cmbTpTitulo.ItemIndex := -1;
  End;
end;

procedure TfrmConfigCredisisAPI.CarregaTipoDiasProtesto;
  Var
    LOpcao : Integer;
begin
  Try
    LOpcao := StrToInt(LeftSTr(fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPDIAPROT', ''),1));

    Case LOpcao Of
      1: cmbTpDiaProt.ItemIndex := 0;
      2: cmbTpDiaProt.ItemIndex := 1;
    End;

  Except
    cmbTpDiaProt.ItemIndex := -1;
  End;
end;

procedure TfrmConfigCredisisAPI.CarregaTipoMulta;
  Var
    LOpcao : Integer;
begin
  Try
    LOpcao := StrToInt(LeftSTr(fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', ''),1));

    Case LOpcao Of
      1: cmbTpMulta.ItemIndex := 0;
      2: cmbTpMulta.ItemIndex := 1;
    End;

  Except
    cmbTpMulta.ItemIndex := -1;
  End;
end;

procedure TfrmConfigCredisisAPI.CarregaTipoJuros;
  Var
    LOpcao : Integer;
begin
  Try
    LOpcao := StrToInt(LeftSTr(fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPJUROS', ''),1));

    Case LOpcao Of
      1: cmbTpJuros.ItemIndex := 0;
      2: cmbTpJuros.ItemIndex := 1;
    End;

  Except
    cmbTpJuros.ItemIndex := -1;
  End;
end;

procedure TfrmConfigCredisisAPI.cmbContaCaucaoEnter(Sender: TObject);
begin
  inherited;
  //ShowHintComboBox(cmbContaCaucao,'');
end;

procedure TfrmConfigCredisisAPI.cmbContaCaucaoExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCredisisAPI.cmbContaCaucaoMouseEnter(Sender: TObject);
begin
  inherited;
  //ShowHintComboBox(cmbContaCaucao,'');
end;

procedure TfrmConfigCredisisAPI.cmbContaCaucaoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

function TfrmConfigCredisisAPI.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strMensagemConfig: String;
begin

  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!'
  else
     strMensagemConfig := '';

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodPor) And gpbSimples.Enabled Then
        Result := PortadorValido(edtCodPor,edtDesPor)
    Else
    If (Sender = fraPlanoDeContasBai.MskCodCta) Then
        Result := PlanoDeContaValido(fraPlanoDeContasBai.MskCodCta,fraPlanoDeContasBai.edtDesCta)
    Else

    If (Sender = cmbCodCar) Then
    Begin
      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Carteira deve ser informado!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumConvenio) Then
    Begin
      If fEmptyStr(edtNumConvenio.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número do Convênio deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 100) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 100!'+strMensagemConfig,['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = edtToken) Then
    Begin
      If fEmptyStr(edtToken.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Chave APP deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número da Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else If edtContaCorr.Text <> fRetSomenteNumeros(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número da Conta Corrente deve possuir apenas números!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agencia deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'SN') <= 0 Then
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

    Else If Sender = edtNumBen Then
    Begin
      If (fEmptyStr(edtNumBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo número do beneficiário deve ser preenchido!' ,['&O K']);
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
    End;

  End;

  If Not Result Then
  begin
    if not blnNaoEditar then
    begin
      cxPaginas.ActivePage := RetornaAbaDoComponete(Sender);
      pSetFocus(Sender);
    end;
  end;


end;

procedure TfrmConfigCredisisAPI.lblValidaOcoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCredisisAPI.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregadados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigCredisisAPI.tabCarteiraChanging(Sender: TObject;
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


procedure TfrmConfigCredisisAPI.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodPor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigCredisisAPI.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred, 'Informar quantidade de dias ' + #13+#10 +
                           'do intervalo entre a efetuação ' + #13+#10 +
                           'do pagamento e o crédito na ' + #13+#10 +
                           'conta corrente.');

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigCredisisAPI.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;


procedure TfrmConfigCredisisAPI.edtDiasProtEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasProt, 'Quantidade de dias após a data de vencimento ' + #13+#10 +
                           'do boleto para iniciar o processo de cobrança ' + #13+#10 +
                           'através de protesto.' + #13+#10 +
                           '(3 a 5 dias ÚTEIS ou 6 a 29, 35, 40 ou 45 dias CORRIDOS)');


  pShowHint(edtDiasProt, 'Dias para Protesto');
end;

procedure TfrmConfigCredisisAPI.edtDiasProtExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCredisisAPI.edtPerMulExit(Sender: TObject);
begin
  inherited;
   If Not fEmptyStr(edtPerMul.Text) Then
    edtPerMul.Text := FormatFloat('#,##0.00', StrToFloat(edtPerMul.Text));
end;

procedure TfrmConfigCredisisAPI.edtQtdDiasDataLimiteRecExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCredisisAPI.edtQtdDiasNegaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCredisisAPI.pAlteraHint(edtEdit: TEditFocus;
  strNovoHint: String);
begin
  edtEdit.Hint := strNovoHint;
end;

procedure TfrmConfigCredisisAPI.pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
begin
  If Not fEmptyStr(strCtaBai) Then
  Begin
    pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
    edtLabel.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
  End
  Else
    edtLabel.Clear;
end;

procedure TfrmConfigCredisisAPI.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  edtLabel.Clear;
  If Not fEmptyStr(strCodPor) Then
  Begin
    pPesquisaCadPor(Nil, qryCadPor, strCodPor);
    edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
  End
end;

procedure TfrmConfigCredisisAPI.pHideHint;
begin
  HintControler.HideHint;
end;

function TfrmConfigCredisisAPI.PlanoDeContaValido(ACodigo: TMaskEdit;
  ADescricao: TEdit): Boolean;
  var
    strMensagemConfig: String;
begin
  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!';

  Result := True;
  If fEmptyStr(ACodigo.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
    ADescricao.Clear;
    Result := False;
  End
  Else
  Begin
    pCarregaCentroCusto(ACodigo.Text, ADescricao);
    If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
      Result := False;
    End;
  End;
end;

procedure TfrmConfigCredisisAPI.pLimpaCampos;
var
  i: Integer;
begin
  for i := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[i] is TEditFocus) then
      (Self.Components[i] as TEditFocus).text := '';

    if (Self.Components[i] is TMaskEditFocus) then
      (Self.Components[i] as TMaskEditFocus).text := '  /  /    ';

    if (Self.Components[i] is TCheckBox) then
      (Self.Components[i] as TCheckBox).Checked := False;

    if (Self.Components[i] is TComboBoxFocus) then
      (Self.Components[i] as TComboBoxFocus).ItemIndex := -1;
  end;

end;


function TfrmConfigCredisisAPI.PortadorValido(ACodigo: TEdit; ADescricao: TEdit): Boolean;
  var
    strMensagemConfig: String;
begin
  Result := True;

  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!';

  If fEmptyStr(ACodigo.Text) Then
  Begin
    fMensagem('ATENCÃO', 'O código do portador deve ser informado!'+strMensagemConfig, ['&Ok']);
    Result := False;
  End
  Else
  Begin
    pCarregaPortador(ACodigo.Text, ADescricao);

    If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
    Begin
      fMensagem('', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
      Result := False;
    End
    {*REQ*145940**********RP*}
    Else If Not fEmpresaTemAcessoPortador(ACodigo.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
      Result := False;
    End
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      If (Pos(ACodigo.Text, strPortadoresOperador) <= 0) Then
      Begin
        If Not fEmptyStr(ACodigo.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
      End;

    End
    Else If (Not fPortadorPermiteBaixa(ACodigo.Text)) Then
    Begin
      fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
      Result := False;
    End;
  End;
end;

procedure TfrmConfigCredisisAPI.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

function TfrmConfigCredisisAPI.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigCredisisAPI.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigCredisisAPI.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigCredisisAPI.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCredisisAPI.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    cxPaginas.ActivePage :=  tbsGeral;
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo1.Enabled := False;
    pnlAtivo2.Enabled := False;
    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigCredisisAPI.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '097';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigCredisisAPI.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Código Carteira           :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', ''));
  stlCampos.Add('Número Convênio           :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  stlCampos.Add('Num. C. Corrente          :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Díg. C. Corrente          :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Código Agência            :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Dígito Agência            :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Observação 1              :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2              :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3              :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4              :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5              :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto          :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito           :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Percentual Multa          :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Protocolo Aceite          :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Token                     :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TOKEN', ''));
  //stlCampos.Add('Ambiente                  :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPAMBIENTE', ''));
  stlCampos.Add('Sacador Avalista          :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('Tipo Título               :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPTITULO', ''));
  stlCampos.Add('Tipo Dias p/ protesto     :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPDIAPROT', ''));
  stlCampos.Add('Tipo Multa                :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', ''));
  stlCampos.Add('Tipo Juros                :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'TPJUROS', ''));
  stlCampos.Add('Instituição Negativação   :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'ORGAONEGAT', ''));
  stlCampos.Add('Nome beneficiário         :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  stlCampos.Add('Endereço                  :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  stlCampos.Add('Bairro                    :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  stlCampos.Add('Complemento               :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  stlCampos.Add('Cidade                    :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  stlCampos.Add('Estado                    :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  stlCampos.Add('CEP                       :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  stlCampos.Add('Número                    :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUM_BEN', ''));
  stlCampos.Add('CNPJ                      :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));

  stlCampos.Add('Portador Cob. Simples     :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Pla. Contas Cob. Simples  :' + fGetBancoConfig(0, 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));

end;

function TfrmConfigCredisisAPI.fRetStrCfg(stlCfg : TStringList) : String;
Var
  intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

procedure TfrmConfigCredisisAPI.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('097', 'CREDISIS [Online]', 'CONFIG097API-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;


end.
