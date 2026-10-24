unit untCadEmbalagens;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, untIteBar,
  Uni, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, ComCtrls, frxClass,
  frxExportCSVTestabilidade, ComboBoxFocus, cxGridCitel, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, QColorLabel,
  Produto.GS1CNP.Interfaces.Cadastro, System.StrUtils,
  Produto.GS1CNP.Interfaces.Atualiza, Produto.GS1CNP.Inconsistencia.View,
  Produto.GS1CNP.Shared.Types, Produto.GS1CNP.Shared.Exception, System.Variants;

type
  TfrmCadEmbalagens = class(TfrmPai)
    pnlEmbala: TPanel;
    cxgEmbala: TcxGridCitel;
    cxgEmbalaView: TcxGridDBTableViewCitel;
    cxgEmbalaCodBar: TcxGridDBColumn;
    cxgEmbalaDescri: TcxGridDBColumn;
    cxgEmbalaEmbala: TcxGridDBColumn;
    cxgEmbalaPreVen: TcxGridDBColumn;
    cxgEmbalaPrinci: TcxGridDBColumn;
    cxgEmbalaCompra: TcxGridDBColumn;
    cxgEmbalaViewBAR_ALTURA: TcxGridDBColumn;
    cxgEmbalaViewBAR_LARGUR: TcxGridDBColumn;
    cxgEmbalaViewBAR_PROFUN: TcxGridDBColumn;
    cxgEmbalaViewBAR_LASTRO: TcxGridDBColumn;
    cxgEmbalaViewBAR_CAMADA: TcxGridDBColumn;
    cxgEmbalaViewBAR_EMPMAX: TcxGridDBColumn;
    cxgEmbalaViewBAR_PESOBR: TcxGridDBColumn;
    cxgEmbalaViewBAR_PESOLQ: TcxGridDBColumn;
    cxgEmbalaLevel1: TcxGridLevel;
    pnlTitulo: TPanel;
    cxgEmbalaExbFat: TcxGridDBColumn;
    shpAcesso: TShape;
    pnlVendas: TPanel;
    lblPreVen: TLabel;
    lblDescri: TLabel;
    lblAviso: TLabel;
    lblAvisoTabPre: TLabel;
    lblTabPer: TLabel;
    edtPreven: TEditFocus;
    edtDescri: TEditFocus;
    cmbTabPre: TComboBoxFocus;
    Panel2: TPanel;
    Label168: TLabel;
    Label169: TLabel;
    lblCliFor: TLabel;
    edtCodbar: TEditFocus;
    chkPrinci: TCheckBox;
    chkCompra: TCheckBox;
    chkBarAut: TCheckBox;
    chkExbFat: TCheckBox;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    Panel1: TPanel;
    btnAdiBar: TBitBtnLocked;
    btnCanBar: TBitBtnLocked;
    edtEmbala: TEditFocus;
    cxgEmbalaCODFOR: TcxGridDBColumn;
    pnlWMS: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtAltura: TEditFocus;
    edtLargur: TEditFocus;
    edtProfun: TEditFocus;
    edtPesoBR: TEditFocus;
    edtPesoLQ: TEditFocus;
    edtLastro: TEditFocus;
    edtCamada: TEditFocus;
    edtEmpMax: TEditFocus;
    btnCadAtuGS1CNP: TBitBtnLocked;
    edtDtaCadGS1: TEditFocus;
    lblDtaCadGS1: TLabel;
    edtDtaAtuGS1: TEditFocus;
    lblDtaAtuGS1: TLabel;
    lblStatusGTIN: TLabel;
    cmbStatusGTIN: TComboBoxFocus;
    lblProCadGS1: TLabel;
    edtProCadGS1: TEditFocus;
    lblProCadGS1Color: TColorLabel;
    chkEanTrb: TCheckBox;
    cxgEmbalaStatus: TcxGridDBColumn;
    cxgEmbalaViewBAR_EANTRB: TcxGridDBColumn;
    cxgEmbalaFOR_NOMFOR: TcxGridDBColumn;
    btnSelecionar: TBitBtnLocked;
    cxgEmbalaMASTER: TcxGridDBColumn;
    procedure btnCanBarClick(Sender: TObject);
    procedure chkPrinciClick(Sender: TObject);
    procedure cxgEmbalaViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnAdiBarClick(Sender: TObject);
    procedure cxgEmbalaPrinciPropertiesChange(Sender: TObject);
    procedure cxgEmbalaCompraPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbTabPreChange(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure btnCadAtuGS1CNPClick(Sender: TObject);
    procedure cxgEmbalaFOR_NOMFORGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure btnSelecionarClick(Sender: TObject);
    procedure cxgEmbalaMASTERPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    intPESBRU,
    intPESLIQ: Integer;

    arrForne: TConsultasArray;

    function fExibeLabelTabPer: Boolean;
    procedure pCarregaComboTabPre(intTabPre: Integer = 0);
    procedure pAjustaDadosIteBar;
    procedure pCarregaDadosAdicionais;
    procedure pSetaTipoPrecoEmbalagem;
    function fCodigoDeBarrasEan13CadastradoGS1(const blnEanTrb: Boolean): Boolean;
    procedure pSetaRetornoCadastroProdutoGS1CNP(const ARetorno: IRetornoGS1CNPCadastro);
    procedure pMostrarInconsistenciasCadastroProdutoGS1CNP(const ARetorno: IRetornoGS1CNPCadastro);
    procedure pSetaRetornoAtualizaProdutoGS1CNP(const ARetorno: IRetornoGS1CNPAtualiza);
    procedure pMostrarInconsistenciasAtualizaProdutoGS1CNP(const ARetorno: IRetornoGS1CNPAtualiza);
    procedure pExecCadastroProdutoGS1CNP;
    procedure pExecAtualizaCadastroProdutoGS1CNP;
    function fCadastrarProdutoGS1CNP: Boolean;
    procedure pMostrarInconsistenciasProdutoGS1CNP(const AValidations: TArrayValidations);
    function fRetornaStatusGTIN: String;
    function fValidationError(const AResponseError: TResponseError): TArrayValidations;
  public
    { Public declarations }
    objIteBar: TIteBar;
    intTabPreVal: Integer;
    fltQtdIte: Double;



    Procedure pCarregaTelaIteBar;
    Procedure pLimpaTelaIteBar;

  protected
    procedure pProximoControle(Sender: TObject);  override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadEmbalagens: TfrmCadEmbalagens;

implementation

uses SysUtils, Forms, untConstantes, untFuncoesSimples, untPaiCad,
    untFuncoesConsulta, untConsultas, untGravando, Produto.GS1CNP.Auth,
    Produto.GS1CNP.Model, Produto.GS1CNP.Shared.Constants;

{$R *.dfm}

procedure TfrmCadEmbalagens.pProximoControle(Sender: TObject);
begin
  If (Sender As TWinControl).Tag = 99 Then
  Begin
    If (fValidaCampos(TWinControl(Sender))) And (blnMudarFoco) Then
      SelectNext(TWinControl(Sender), True, True);
  End
  Else
    SelectNext(TWinControl(Sender), True, True);
  blnMudarFoco := True;
end;

procedure TfrmCadEmbalagens.pSetaRetornoAtualizaProdutoGS1CNP(const ARetorno: IRetornoGS1CNPAtualiza);
begin
  If (ARetorno.GetResponseCode = '200') Then //200 - sucesso
  Begin
    objIteBar.pAtualizaCadIteProdutoCadastradoGS1CNP(False);

    edtDtaAtuGS1.Text  := FormatDateTime('dd/mm/yyyy', VS_Date);
    cmbStatusGTIN.ItemIndex := cmbStatusGTIN.Items.IndexOf(ARetorno.GetResponseSuccess.product.gtinStatusCode);

    fMensagem('Atenção', 'Código de barras atualizado com sucesso', ['&Ok']);

    btnAdiBar.Click;
  End;
end;

procedure TfrmCadEmbalagens.pSetaRetornoCadastroProdutoGS1CNP(
  const ARetorno: IRetornoGS1CNPCadastro);
begin
  If (ARetorno.GetResponseCode = '200') And (ARetorno.GetResponseSuccess.result = 'SUCCESS') Then //200 - sucesso
  Begin
    If (edtProCadGS1.Text = 'N') Then
    Begin
      objIteBar.pAtualizaCadIteProdutoCadastradoGS1CNP(True);

      edtProCadGS1.Text := 'S';
      edtDtaCadGS1.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
      edtDtaAtuGS1.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
    End;

    edtCodbar.Text := ARetorno.GetResponseSuccess.product.gs1TradeItemIdentificationKey.gtin;
    cmbStatusGTIN.ItemIndex := cmbStatusGTIN.Items.IndexOf(ARetorno.GetResponseSuccess.product.gtinStatusCode);

    fMensagem('Atenção', 'Código de barras cadastrado com sucesso', ['&Ok']);

    btnAdiBar.Click;
  End;
end;

procedure TfrmCadEmbalagens.pSetaTipoPrecoEmbalagem;
begin
  If fCfgSis('PREEMB', VarString) = '1' Then
  Begin
    lblPreVen.Caption := 'Preço de Venda:';
    edtPreVen.Visible := True;
    cmbTabPre.Visible := False;

    cxgEmbalaPreVen.Caption := 'Preço de Venda';
    cxgEmbalaPreVen.DataBinding.FieldName := 'BAR_PREVEN';
    cxgEmbalaPreVen.HeaderAlignmentHorz := taRightJustify;
    lblAvisoTabPre.Visible := False;
    lblTabPer.Visible := False;
  End
  Else
  Begin
    pCarregaComboTabPre(intTabPreVal);

    lblPreVen.Caption := 'Tabela de Preço:';
    edtPreVen.Visible := False;
    cmbTabPre.Visible := True;
    If cmbTabPre.ItemIndex = -1 Then
      cmbTabPre.ItemIndex := intTabPreVal;

    cxgEmbalaPreVen.Caption := 'Tabela de Preço';
    cxgEmbalaPreVen.DataBinding.FieldName := 'BAR_TABPRE';
    cxgEmbalaPreVen.HeaderAlignmentHorz := taLeftJustify;
    lblAvisoTabPre.Visible := True;
    lblTabPer.Visible := fExibeLabelTabPer;
  End;
end;

procedure TfrmCadEmbalagens.btnAdiBarClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodbar.Text) Then
  Begin

    If chkBarAut.Checked Then
    Begin
      If Not fValidaCampos(edtEmbala, True) Then
        Exit;

      edtCodbar.Text := objIteBar.fGeraCodBarAuto(fStrToFloat(edtEmbala.Text));

    End Else
    Begin
      pSetFocus(edtCodbar);

      Exit;
    End;

  End;

  If fVerificaCampos Then
  Begin

    If objIteBar.fFornecedorDuplicado(edtCodbar.Text, edtCodFor.Text) Then
    Begin

      pMensagemOk('Já existe um código de barras para esse fornecedor!');

    End Else
    Begin

      objIteBar.pIncluiCodigo(edtCodbar.Text, fStrToFloat(edtEmbala.Text),
                              chkPrinci.Checked, chkCompra.Checked, chkExbFat.Checked,
                              IIF(edtPreVen.Visible, fStrToFloat(edtPreVen.Text), 0),
                              edtDescri.Text,
                              cmbTabPre.Text,
                              edtCodFor.Text,
                              fStrToFloat(edtAltura.Text),
                              fStrToFloat(edtLargur.Text),
                              fStrToFloat(edtProfun.Text),
                              StrToIntDef(edtLastro.Text, 0),
                              StrToIntDef(edtCamada.Text, 0),
                              StrToIntDef(edtEmpMax.Text, 0),
                              fStrToFloat(edtPesoBR.Text),
                              fStrToFloat(edtPesoLQ.Text),
                              False,
                              IIF(cmbStatusGTIN.Visible, cmbStatusGTIN.Text, ''),
                              IIF(chkEanTrb.Visible, IIF(chkEanTrb.Checked, 'S', 'N'), ''));

      objIteBar.pAjustaPrincipalCompra;
      objIteBar.pRetCodBarPrincipal;

      pLimpaTelaIteBar;

    End;
  End;
end;

procedure TfrmCadEmbalagens.btnCadAtuGS1CNPClick(Sender: TObject);
begin
  inherited;
  If Not fCodigoDeBarrasEan13CadastradoGS1(chkEanTrb.Checked) Then
  Begin
    fMensagem('Atenção', 'Para solicitar a geração de um código de barras tributável (EAN14),' + #13#10 + 'é preciso ter um EAN13 cadastrado na GS1.', ['&Ok']);
    Exit;
  End;

  If chkEanTrb.Checked And (fStrToFloat(edtEmbala.Text) = 0) Then
  Begin
    fMensagem('Atenção', 'Código de barras tributável se refere à caixa fechada, ' + #13#10 + ' e a quantidade é sempre maior que 0!', ['&Ok']);
    Exit;
  End;

  case fCadastrarProdutoGS1CNP of
    True  : TfrmGravando.fExecutarModal(pExecCadastroProdutoGS1CNP, 'Realizando cadastro produto GS1/CNP...', '');
    False : TfrmGravando.fExecutarModal(pExecAtualizaCadastroProdutoGS1CNP, 'Atualizando cadastro produto GS1/CNP...', '');
  end;
end;

procedure TfrmCadEmbalagens.btnCanBarClick(Sender: TObject);
begin
  inherited;

  pLimpaTelaIteBar;

end;

procedure TfrmCadEmbalagens.btnSelecionarClick(Sender: TObject);
begin
  inherited;
  objIteBar.fltQtdIte := objIteBar.cdsIteBar.FieldByName('BAR_EMBALA').AsFloat;
  btnSair.Click;
end;

procedure TfrmCadEmbalagens.chkPrinciClick(Sender: TObject);
begin
  inherited;

  pAjustaDadosIteBar;
end;

procedure TfrmCadEmbalagens.cmbTabPreChange(Sender: TObject);
begin
  lblTabPer.Visible := fExibeLabelTabPer;
end;

procedure TfrmCadEmbalagens.cxgEmbalaCompraPropertiesChange(Sender: TObject);
begin
  inherited;

  objIteBar.pAjustaPrincipalCompra;
  objIteBar.pRetCodBarPrincipal;
end;

procedure TfrmCadEmbalagens.cxgEmbalaFOR_NOMFORGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText:= fRetNomFornecedor(VarToStr(cxgEmbalaView.DataController.Values[ARecord.RecordIndex, cxgEmbalaCODFOR.Index]));
end;

procedure TfrmCadEmbalagens.cxgEmbalaPrinciPropertiesChange(Sender: TObject);
begin
  inherited;

  objIteBar.pAjustaPrincipalCompra;
  objIteBar.pRetCodBarPrincipal;
end;

procedure TfrmCadEmbalagens.cxgEmbalaViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: Begin
                 pCarregaTelaIteBar;
                 pSetFocus(edtCodbar);
               End;
    VK_DELETE: Begin
                 pLimpaTelaIteBar;
               End;
  End;

end;

procedure TfrmCadEmbalagens.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor, edtNomFor, arrForne, fRetNomFornecedor, nil, 'do Fornecedor');

end;

procedure TfrmCadEmbalagens.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrForne) Then
  Begin
    If fValidaCampos(edtCodFor, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCadEmbalagens.fCadastrarProdutoGS1CNP: Boolean;
begin
  Result := True;

  If Trim(edtProCadGS1.Text) = 'N' Then
    Exit;

  If fEmptyStr(cmbStatusGTIN.Text) then
    Exit;

  Result := False;
end;

function TfrmCadEmbalagens.fCodigoDeBarrasEan13CadastradoGS1(
  const blnEanTrb: Boolean): Boolean;
begin
  Result := True;

  If Not blnEanTrb Then
    Exit;

  If objIteBar.fRetornaEan13CadastradoGS1(objIteBar.strCodIte) Then
    Exit;

  Result := False;
end;

function TfrmCadEmbalagens.fExibeLabelTabPer: Boolean;
begin
  If SameText(cmbTabPre.Text, 'F') Or fEmptyStr(cmbTabPre.Text) Then
    Result := False
  Else
    Result := (Not fEmptyStr(cmbTabPre.Text))         And
              (Not SameText(cmbTabPre.Text, 'F'))     And
              (fCfgSis('PRVEMB', VarBoolean))         And
              (SameText(VS_strTabVen[StrToIntDef(cmbTabPre.Text, 1)], 'N'));
end;

procedure TfrmCadEmbalagens.FormCreate(Sender: TObject);
begin
  inherited;
  intPESBRU := fCfgSis('DECBRU', varInteger);
  intPESLIQ := fCfgSis('DECLIQ', varInteger);

  pnlWMS.Visible := (fUsaRotinaWMS Or (fArqIni(0, 'GERAL', 'INFEMB', '') = 'S')) And (fCfgSis('TPLREC', varString) = 'L');

  cxgEmbalaViewBAR_ALTURA.Visible := pnlWMS.Visible;
  cxgEmbalaViewBAR_LARGUR.Visible := pnlWMS.Visible;
  cxgEmbalaViewBAR_PROFUN.Visible := pnlWMS.Visible;
  cxgEmbalaViewBAR_PESOBR.Visible := pnlWMS.Visible;
  cxgEmbalaViewBAR_PESOLQ.Visible := pnlWMS.Visible;
  cxgEmbalaViewBAR_LASTRO.Visible := pnlWMS.Visible;
  cxgEmbalaViewBAR_CAMADA.Visible := pnlWMS.Visible;
  cxgEmbalaViewBAR_EMPMAX.Visible := pnlWMS.Visible;
  If not pnlWMS.Visible Then
    pnlEmbala.Height := pnlEmbala.Height - pnlWMS.Height;

  blnFecharComEscape := False;
  intTabPreVal       := 0;

  If fCfgSis('TIPBAR', varString) = '2' Then
    edtCodbar.MaxLength := 43;

  edtPesoBR.EditFormat := fMskDigitos(intPESBRU);
  edtPesoLQ.EditFormat := fMskDigitos(intPESLIQ);

  cxgEmbalaMASTER.Visible := fCfgSis('EMBMAS', VarBoolean);
end;

procedure TfrmCadEmbalagens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: If blnFecharComEscape Then
                 Close;
    VK_F10: If btnSelecionar.Visible Then
                 btnSelecionar.Click;
  End;

end;

procedure TfrmCadEmbalagens.FormShow(Sender: TObject);
begin
  inherited;

  If objIteBar.opcCriaca <> opcConsulta Then
    WindowState := wsMaximized;

  cxgEmbalaView.DataController.DataSource := objIteBar.dtsIteBar;
  edtEmbala.EditFormat    := fMskDigitos(DEC_EMBALAGEM);
  edtPreVen.EditFormat    := fMskDigitos(2);

  If Not fCfgSis('PRVEMB', VarBoolean) Then
  Begin
    pnlVendas.Visible := False;
    cxgEmbalaDescri.Visible := False;
    cxgEmbalaPreVen.Visible := False;
    pnlEmbala.Height  := pnlEmbala.Height - pnlVendas.Height;
  End
  Else
    pSetaTipoPrecoEmbalagem;

  If objIteBar.cdsIteBar.Active Then
    pCarregaDadosAdicionais;
end;

function TfrmCadEmbalagens.fRetornaStatusGTIN: String;
begin
  Result := IIF(fEmptyStr(cmbStatusGTIN.Text), STATUS_GTIN_ACTIVE, cmbStatusGTIN.Text);
end;

function TfrmCadEmbalagens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

  function fGetUltimaPagina(pgcDados : TPageControl): TTabSheet;
    Var
      intPage: Integer;
  begin
    Result := Nil;
    For intPage := 0 To pgcDados.PageCount -1 Do
      If pgcDados.Pages[intPage].TabVisible Then
        Result := pgcDados.Pages[intPage];
  end;

  procedure pProximaPagina(pgcDados : TPageControl);
  begin
    If pgcDados.ActivePage <> fGetUltimaPagina(pgcDados) Then
    Begin
      pgcDados.SelectNextPage(True);
      blnMudarFoco := False;
    End
    Else
    Begin
      blnMudarFoco := False;

      if (pgcDados.Parent <> Nil) And (pgcDados.Parent is TfrmPaiCad) Then
        pSetFocus(TfrmPaiCad(pgcDados.Parent).btnGravar);

    End;
  End;


begin
  Result := True;
  blnMudarFoco := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodbar) Then
    Begin

      If Not fEmptyStr(edtCodbar.Text) Then
      Begin

        If blnBuscaPorChave Then
          chkBarAut.Checked := False;

        If Not objIteBar.fValidaCodBar(edtCodbar.Text) Then
        Begin
          Result := False;
        End

        Else If blnBuscaPorChave Then
        Begin

          If objIteBar.cdsIteBar.Locate('BAR_CODBAR', edtCodbar.Text, []) Then
          Begin
            pCarregaTelaIteBar;
          End Else
          Begin
            If Not objIteBar.cdsIteBar.Locate('BAR_PRINCI', 1, []) Then
              chkPrinci.Checked := True;

            If Not objIteBar.cdsIteBar.Locate('BAR_COMPRA', 1, []) Then
              chkCompra.Checked := True;

          End;

        End

      End Else
      Begin

        If Not chkBarAut.Checked Then
        Begin
          btnCanBar.Click;

          If (Self.Parent <> Nil) And (Self.Parent.Parent <> Nil) And (Self.Parent.Parent is TPageControl) Then
            pProximaPagina(TPageControl(Self.Parent.Parent))
          Else
            pSetFocus(btnCanBar);

          blnMudarFoco := False;
        End;

      End;

    End

    Else If (Sender = edtEmbala) Then
    Begin
      edtEmbala.Text := FormatFloat(fMskDigitos(DEC_EMBALAGEM), fStrToFloat(edtEmbala.Text));

      If fStrToFloat(edtEmbala.Text) <= 0 Then
      Begin
        pMensagemOk('A quantidade da embalagem deve ser maior que zero!');
        Result := False;
      End;
    End

    Else If (Sender = edtPreVen) And edtPreVen.Visible Then
    Begin
      edtPreVen.Text := FormatFloat('#0.00', fStrToFloat(edtPreVen.Text));

      If fStrToFloat(edtPreVen.Text) < 0 Then
      Begin
        pMensagemOk('O preço de venda deve ser maior ou igual à zero!');
        Result := False;
      End;
    End

    Else If (Sender = cmbTabPre) And pnlVendas.Visible And cmbTabPre.Visible Then
    Begin
      If cmbTabPre.ItemIndex = -1 Then
      Begin
        pMensagemOk('Defina a tabela de preço da embalagem!');
        Result := False;
      End
      Else
      Begin
        If lblTabPer.Visible Then
        Begin
          pMensagemOk('Tabela de preço não permitida. A empresa logada está configurado para não trabalhar com esta tabela de preço!');
          Result := False;
        End;
      End;
    End

    Else If (Sender = chkCompra) Then
    Begin

    End

    Else If (Sender = edtCodFor) Then
    Begin

      If fEmptyStr(edtCodFor.Text) Then
      Begin

        edtNomFor.Clear;

      End Else
      Begin
        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

        If fEmptyStr(edtNomFor.Text) Then
        Begin
          pMensagemOk('Fornecedor ' + edtCodFor.Text + ' não encontrado!');
          Result := False;
        End;

      End;

    End

    Else If (Sender = chkExbFat) Then
    Begin

      If (Not fEmptyStr(edtCodbar.Text)) And (not pnlVendas.Visible) And (Not pnlWms.Visible) Then
      Begin
        pSetFocus(btnAdiBar);
        blnMudarFoco := False;
      End;

    End

    Else
    If (Sender = edtAltura) And pnlWms.Visible Then
    Begin
      If fStrToFloat( edtAltura.Text ) < 0 Then
      Begin
        Result := fMensagem('', 'A Altura deve ser Maior ou Igual a Zero!', ['&Ok']) = -1;
      End;
    End

    Else
    If (Sender = edtLargur) And pnlWms.Visible Then
    Begin
      If fStrToFloat( edtLargur.Text ) < 0 Then
      Begin
        Result := fMensagem('', 'A Largura deve ser Maior ou Igual a Zero!', ['&Ok']) = -1;
      End;
    End

    Else
    If (Sender = edtProfun) And pnlWms.Visible Then
    Begin
      If fStrToFloat( edtProfun.Text ) < 0 Then
      Begin
        Result := fMensagem('', 'A Profundidade deve ser Maior ou Igual a Zero!', ['&Ok']) = -1;
      End;
    End

    Else
    If (Sender = edtLastro) And pnlWms.Visible Then
    Begin
      If fStrToFloat( edtLastro.Text ) < 0 Then
      Begin
        Result := fMensagem('', 'O Lastro deve ser Maior ou Igual a Zero!', ['&Ok']) = -1;
      End;
    End

    Else
    If (Sender = edtCamada) And pnlWms.Visible Then
    Begin
      If fStrToFloat( edtCamada.Text ) < 0 Then
      Begin
        Result := fMensagem('', 'A Camada deve ser Maior ou Igual a Zero!', ['&Ok']) = -1;
      End;
    End

    Else
    If (Sender = edtEmpMax) And pnlWms.Visible Then
    Begin
      If fStrToFloat( edtEmpMax.Text ) < 0 Then
      Begin
        Result := fMensagem('', 'O Epilhamento Máximo deve ser Maior ou Igual a Zero!', ['&Ok']) = -1;
      End;
    End

    Else
    If (Sender = edtPesoBR) And pnlWms.Visible Then
    Begin
      If fStrToFloat( edtPesoBR.Text ) < 0 Then
      Begin
        Result := fMensagem('', 'O Peso Bruto deve ser Maior ou Igual a Zero!', ['&Ok']) = -1;
      End;
    End

    Else
    If (Sender = edtPesoLQ) And pnlWms.Visible Then
    Begin
      If fStrToFloat( edtPesoLQ.Text ) < 0 Then
      Begin
        Result := fMensagem('', 'O Peso Líquido deve ser Maior ou Igual a Zero!', ['&Ok']) = -1;
      End;
    End;


  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadEmbalagens.fValidationError(
  const AResponseError: TResponseError): TArrayValidations;
begin
  Result := AResponseError.data.validations;

  If Length(AResponseError.data.validations) > 0 Then
    Exit;

  SetLength(Result, 1);

  Result[Length(Result) - 1].messageValidations := TConvertCamposObrigatorios.GetMessage(AResponseError.messageError);
end;

Procedure TfrmCadEmbalagens.pLimpaTelaIteBar;
Begin
  edtCodbar.Clear;
  edtEmbala.Clear;
  edtPreVen.Clear;
  edtDescri.Clear;
  cmbTabPre.ItemIndex := 0;
  chkPrinci.Checked := False;
  chkCompra.Checked := False;
  chkExbFat.Checked := False;
  lblTabPer.Visible := False;

  edtAltura.Text := '0,00';
  edtLargur.Text := '0,00';
  edtProfun.Text := '0,00';
  edtLastro.Text := '0';
  edtCamada.Text := '0';
  edtEmpMax.Text := '0';
  edtPesoBR.Text := FormatFloat(fMskDigitos(intPESBRU), 0);
  edtPesoLQ.Text := FormatFloat(fMskDigitos(intPESLIQ), 0);


  chkBarAut.Checked := Not fEmptyStr(objIteBar.strCodIte);

  edtCodFor.Clear;
  edtNomFor.Clear;

  If cmbStatusGTIN.Visible Then
    cmbStatusGTIN.ItemIndex := -1;

  If chkEanTrb.Visible Then
    chkEanTrb.Checked := False;

  pAjustaDadosIteBar;

  pSetFocus(edtCodbar);
End;

procedure TfrmCadEmbalagens.pMostrarInconsistenciasAtualizaProdutoGS1CNP(
  const ARetorno: IRetornoGS1CNPAtualiza);
begin
  if (ARetorno.GetResponseCode = '400') then // 400 - error
    pMostrarInconsistenciasProdutoGS1CNP(fValidationError(ARetorno.GetResponseError));

  if (ARetorno.GetResponseCode = '200') And (Length(ARetorno.GetResponseSuccess.validations) > 0) then // Successo mas tem validacoes
    pMostrarInconsistenciasProdutoGS1CNP(ARetorno.GetResponseSuccess.validations);

  TProdutoGS1CNPModel.GravarGS1JsonResponse(objIteBar.strCodIte, ARetorno.GetJsonResponse, Self.Name, 'Atualizar');
end;

procedure TfrmCadEmbalagens.pMostrarInconsistenciasCadastroProdutoGS1CNP(
  const ARetorno: IRetornoGS1CNPCadastro);
begin
  if (ARetorno.GetResponseCode = '400') then // 400 - error
    pMostrarInconsistenciasProdutoGS1CNP(fValidationError(ARetorno.GetResponseError));

  if (ARetorno.GetResponseCode = '200') And (Length(ARetorno.GetResponseSuccess.validations) > 0) then // Successo mas tem validacoes
    pMostrarInconsistenciasProdutoGS1CNP(ARetorno.GetResponseSuccess.validations);

  TProdutoGS1CNPModel.GravarGS1JsonResponse(objIteBar.strCodIte, ARetorno.GetJsonResponse, Self.Name, 'Cadastrar');
end;

procedure TfrmCadEmbalagens.pMostrarInconsistenciasProdutoGS1CNP(
  const AValidations: TArrayValidations);
begin
  Try
    pCriarFormularios(TProdutoGS1CNPInconsistenciaView, ProdutoGS1CNPInconsistenciaView);
    ProdutoGS1CNPInconsistenciaView.Validations := AValidations;
    ProdutoGS1CNPInconsistenciaView.ShowModal;
  Finally
    pFreeAndNil(ProdutoGS1CNPInconsistenciaView);
  End;
end;

procedure TfrmCadEmbalagens.pCarregaComboTabPre(intTabPre: Integer = 0);
begin
  cmbTabPre.Items.Clear;
  cmbTabPre.Items.Add('F');

  If (Copy(VS_strTabVen,1,1) = 'S') Or (intTabPre = 1) Then
    cmbTabPre.Items.Add('1');
  If (Copy(VS_strTabVen,2,1) = 'S') Or (intTabPre = 2) Then
    cmbTabPre.Items.Add('2');
  If (Copy(VS_strTabVen,3,1) = 'S') Or (intTabPre = 3) Then
    cmbTabPre.Items.Add('3');
  If (Copy(VS_strTabVen,4,1) = 'S') Or (intTabPre = 4) Then
    cmbTabPre.Items.Add('4');
  If (Copy(VS_strTabVen,5,1) = 'S') Or (intTabPre = 5) Then
    cmbTabPre.Items.Add('5');
  If (Copy(VS_strTabVen,6,1) = 'S') Or (intTabPre = 6) Then
    cmbTabPre.Items.Add('6');
  If (Copy(VS_strTabVen,7,1) = 'S') Or (intTabPre = 7) Then
    cmbTabPre.Items.Add('7');
end;

procedure TfrmCadEmbalagens.pCarregaDadosAdicionais;
  Var
    qryEmbalagem : TUniQuery;
begin
    qryEmbalagem := fCriaQuery;
  With qryEmbalagem Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT ');
    SQL.Add('   ITE_PREVE1, ');
    SQL.Add('   ITE_PREVE2, ');
    SQL.Add('   ITE_PREVE3, ');
    SQL.Add('   ITE_PREVE4, ');
    SQL.Add('   ITE_PREVE5, ');
    SQL.Add('   ITE_PREVE6, ');
    SQL.Add('   ITE_PREVE7  ');
    SQL.Add(' FROM  ');
    SQL.Add('   ITEGER '  );
    SQL.Add(' WHERE ');
    SQL.Add(' ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');

    ParamByName('CODITE').AsString := objIteBar.cdsIteBar.FieldByName('BAR_CODITE').AsString;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

  End;

  FreeAndNil(qryEmbalagem);
end;

Procedure TfrmCadEmbalagens.pCarregaTelaIteBar;
Begin
  With objIteBar.cdsIteBar Do
  Begin
    edtCodbar.Text    := FieldByName('BAR_CODBAR').AsString;
    edtDescri.Text    := FieldByName('BAR_DESCRI').AsString;
    edtEmbala.Text    := FormatFloat(fMskDigitos(DEC_EMBALAGEM), FieldByName('BAR_EMBALA').AsFloat);
    edtPreVen.Text    := FormatFloat('#0.00', FieldByName('BAR_PREVEN').AsFloat);

    edtAltura.Text := FormatFloat('#0.00', FieldByName('BAR_ALTURA').AsFloat);
    edtLargur.Text := FormatFloat('#0.00', FieldByName('BAR_LARGUR').AsFloat);
    edtProfun.Text := FormatFloat('#0.00', FieldByName('BAR_PROFUN').AsFloat);

    edtLastro.Text := FieldByName('BAR_LASTRO').AsString;
    edtCamada.Text := FieldByName('BAR_CAMADA').AsString;
    edtEmpMax.Text := FieldByName('BAR_EMPMAX').AsString;

    edtPesoBR.Text := FormatFloat(fMskDigitos(intPESBRU), FieldByName('BAR_PESOBR').AsFloat);
    edtPesoLQ.Text := FormatFloat(fMskDigitos(intPESLIQ), FieldByName('BAR_PESOLQ').AsFloat);

    edtCodFor.Text    := FieldByName('BAR_CODFOR').AsString;

    If fEmptyStr(edtCodFor.Text) Then
      edtNomFor.Text := ''
    Else
      edtNomFor.Text := fRetNomFornecedor(FieldByName('BAR_CODFOR').AsString);

    If SameText(FieldByName('BAR_TABPRE').AsString, 'F') Then
      cmbTabPre.ItemIndex := 0
    Else
    Begin
      If cmbTabPre.Items.IndexOf(FieldByName('BAR_TABPRE').AsString) = -1 Then
      Begin
        pCarregaComboTabPre(StrToIntDef(FieldByName('BAR_TABPRE').AsString, 0));
        cmbTabPre.ItemIndex := cmbTabPre.Items.IndexOf(FieldByName('BAR_TABPRE').AsString);
      End
      Else
        cmbTabPre.ItemIndex := cmbTabPre.Items.IndexOf(FieldByName('BAR_TABPRE').AsString);
    End;

    lblTabPer.Visible := fExibeLabelTabPer;

    chkPrinci.Checked := FieldByName('BAR_PRINCI').AsInteger = 1;
    chkCompra.Checked := FieldByName('BAR_COMPRA').AsInteger = 1;
    chkExbFat.Checked := FieldByName('BAR_EXBFAT').AsString  = 'S';

    If cmbStatusGTIN.Visible Then
      cmbStatusGTIN.ItemIndex := cmbStatusGTIN.Items.IndexOf(FieldByName('BAR_STGTIN').AsString);

    If chkEanTrb.Visible Then
      chkEanTrb.Checked := FieldByName('BAR_EANTRB').AsString = 'S';

  End;
  pCarregaDadosAdicionais;
  pAjustaDadosIteBar;
End;

procedure TfrmCadEmbalagens.pExecAtualizaCadastroProdutoGS1CNP;
var
  LRetorno: IRetornoGS1CNPAtualiza;
  LAccessToken: String;
  LStatusGTIN: String;
begin
  If fEmptyStr(edtCodBar.Text) Then
    Exit;

  LAccessToken := TProdutoGS1CNPAuth.GetAcessToken;

  LStatusGTIN := fRetornaStatusGTIN;

  LRetorno := objIteBar.fAtualizarProdutoGS1CNP(edtCodbar.Text, chkEanTrb.Checked, LAccessToken, LStatusGTIN);
  pMostrarInconsistenciasAtualizaProdutoGS1CNP(LRetorno);
  pSetaRetornoAtualizaProdutoGS1CNP(LRetorno);
end;

procedure TfrmCadEmbalagens.pExecCadastroProdutoGS1CNP;
var
  LRetorno: IRetornoGS1CNPCadastro;
  LAccessToken: String;
  LStatusGTIN: String;
begin
  LAccessToken := TProdutoGS1CNPAuth.GetAcessToken;

  LStatusGTIN := fRetornaStatusGTIN;

  LRetorno := objIteBar.fCadastrarProdutoGS1CNP(edtCodbar.Text, chkEanTrb.Checked, LAccessToken, LStatusGTIN);
  pMostrarInconsistenciasCadastroProdutoGS1CNP(LRetorno);
  pSetaRetornoCadastroProdutoGS1CNP(LRetorno);
end;

procedure TfrmCadEmbalagens.pAjustaDadosIteBar;
Begin
  edtEmbala.ReadOnly := chkPrinci.Checked;
  edtEmbala.TabStop  := Not edtEmbala.ReadOnly;

  If chkPrinci.Checked Then
    edtEmbala.Text := FormatFloat(fMskDigitos(DEC_EMBALAGEM), 1);
End;

procedure TfrmCadEmbalagens.cxgEmbalaMASTERPropertiesChange(Sender: TObject);
begin
  objIteBar.pAjustaEmbalagemMaster;
end;

end.

