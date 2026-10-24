unit untCadAcessorioLocacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, Uni, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, MemoFocus, EditFocus, cxTextEdit,
  cxCurrencyEdit, CurrencyEditFocus, MaskEditFocus, untCadLote,
  QColorLabel, cadastro.Model.AcessorioLocacao, untLiberacao, untTypesLocEqu;

type
  TfrmCadAcessorioLocacao = class(TfrmPaiCad)
    lblCodigo: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeStatus: TDBEditFocus;
    lblStatus: TLabel;
    dbeDescri: TDBEditFocus;
    lblDescri: TLabel;
    dtsCadAcl: TDataSource;
    lblDtaAqu: TLabel;
    mskDtaAqu: TMaskEditFocus;
    edtValAqu: TCurrencyEditFocus;
    lblValAqu: TLabel;
    lblRpUlMn: TLabel;
    dbeRpUlMn: TDBEditFocus;
    lblModelo: TLabel;
    dbeModelo: TDBEditFocus;
    dbeLocFis: TDBEditFocus;
    lblCodIte: TLabel;
    edtDesIte: TEditFocus;
    mmoEspecf: TMemoFocus;
    lblEspecf: TLabel;
    lblDtUlMn: TLabel;
    mskDtUlMn: TMaskEditFocus;
    lblGarant: TLabel;
    dbeGarant: TDBEditFocus;
    dbeAnoFab: TDBEditFocus;
    lblAnoFab: TLabel;
    lblDtaVen: TLabel;
    mskDtaVen: TMaskEditFocus;
    Label1: TLabel;
    ColorLabel26: TColorLabel;
    DBECODITE: TDBEditFocus;
    btnHeranca: TBitBtnLocked;
    Label7: TLabel;
    edtVlrCau: TCurrencyEditFocus;
    lblValorAdicional: TLabel;
    edtVlrAdc: TCurrencyEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBECODITEKeyPress(Sender: TObject; var Key: Char);
    procedure dbeStatusExit(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryCadACL: TUniQuery;
    objCadLot: TCadLot;
    objAceLoc: TEquipamentoLocacaoAcessorio;
    objLiberacao: TLiberacao;
    strSitAnt: String;

    procedure pLimparCampos;
    procedure pIniciarInclusao;
    procedure pHabilitarComponentes(blnHabilitar: Boolean);
    procedure pCarregaDados;
    procedure pAbreCadastroProduto;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema, untFuncoesConsulta, untFuncoesLocEqu,
  untHerancaCadEqu, untCadProdutos;

{$R *.dfm}

procedure TfrmCadAcessorioLocacao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  {COMENTADA POIS NÃO HÁ NECESSIDADE DE VERIFICAÇÃO DE CAMPOS AO CLICAR EM ALTERAR - KM}
  {If (Not fVerificaCampos()) Then
    Exit;}

  If qryTabela.IsEmpty then
    Exit;

  pHabilitarComponentes(True);

  If (qryTabela.FieldByName('ACL_STATUS').AsString <> 'A') Then
  Begin
    If (fMensagem('CONFIRMAÇÃO!', 'O equipamento está ' +  fObtemDescricaoSitEquipamentoLocacao(qryTabela.FieldByName('ACL_STATUS').AsString) + ', para alterá-lo deverá ativá-lo novamente. Deseja prosseguir?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      qryTabela.FieldByName('ACL_STATUS').AsString := 'A';
      mskDtaVen.Text := '__/__/____';
      mskDtaVen.Enabled := False;
    End
    Else Begin
      btnCancela.Click();
      Exit;
    End;
  End;

  pHabilitaCodigo(dbeCodigo, dbeCodigo, False);

  dbeStatus.Enabled := fVerificaAcessoSistema('EQUSIT');
  pSetFocus(dbeDescri);

end;

procedure TfrmCadAcessorioLocacao.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pCarregaDados;

  pHabilitarComponentes(False);

end;

procedure TfrmCadAcessorioLocacao.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAcessorioLocacao.btnExcluirClick]');
    End;
  End;

  If (blnExcluiu) Then
  Begin
    fCommit;
    pLimparCampos;
    pHabilitarComponentes(False);
  End
  Else
    fRollBack;
end;

procedure TfrmCadAcessorioLocacao.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaAqu.Text))) Then
      qryTabela.FieldByName('ACL_DTAAQU').AsDateTime := StrToDate(mskDtaAqu.Text)
    Else
      qryTabela.FieldByName('ACL_DTAAQU').Clear();

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtUlMn.Text))) Then
      qryTabela.FieldByName('ACL_DTULMN').AsDateTime := StrToDate(mskDtUlMn.Text)
    Else
      qryTabela.FieldByName('ACL_DTULMN').Clear();

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaVen.Text))) Then
      qryTabela.FieldByName('ACL_DTAVEN').AsDateTime := StrToDate(mskDtaVen.Text)
    Else
      qryTabela.FieldByName('ACL_DTAVEN').Clear();

    qryTabela.FieldByName('ACL_VALAQU').AsFloat  := StringToFloat(edtValAqu.Text);
    qryTabela.FieldByName('ACL_ESPECF').AsString := mmoEspecf.Texto;
    qryTabela.FieldByName('ACL_VLRCAU').AsFloat  := StringToFloat(edtVlrCau.Text);
    qryTabela.FieldByName('ACL_VLRADC').AsFloat  := StringToFloat(edtVlrAdc.Text);

    inherited;

    If (blnGravou) Then
    Begin
      fCommit();
      pHabilitarComponentes(False);
      objAceLoc.AutInc := qryTabela.FieldByName('AUTOINCREM').AsString;
      objAceLoc.Codigo := qryTabela.FieldByName('ACL_CODIGO').AsString;
    End
    Else
      fRollBack;

  Except
    On E: Exception Do Begin
      fRollBack();
      pMensagensErro(E.Message, '[TfrmCadEquLocacao.btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadAcessorioLocacao.btnHerancaClick(Sender: TObject);
var
  frmHerancaCadEqu: TfrmHerancaCadEqu;
begin
  inherited;

  pCriarFormularios(TfrmHerancaCadEqu, frmHerancaCadEqu);
  Try
    frmHerancaCadEqu.tipoEquipamento := tpAcessorio;
    frmHerancaCadEqu.ShowModal;

    If frmHerancaCadEqu.blnConfirma Then
    Begin
      qryTabela.FieldByName('ACL_DESCRI').AsString := frmHerancaCadEqu.objHerAce.objEquAce.Descricao;
      qryTabela.FieldByName('ACL_RPULMN').AsString := frmHerancaCadEqu.objHerAce.objEquAce.ResponsavelUltimaManutencao;
      qryTabela.FieldByName('ACL_GARANT').AsFloat  := frmHerancaCadEqu.objHerAce.objEquAce.Garantia;
      qryTabela.FieldByName('ACL_ANOFAB').AsFloat  := frmHerancaCadEqu.objHerAce.objEquAce.AnoFabricacao;
      qryTabela.FieldByName('ACL_MODELO').AsString := frmHerancaCadEqu.objHerAce.objEquAce.Modelo;
      qryTabela.FieldByName('ACL_LOCFIS').AsString := frmHerancaCadEqu.objHerAce.objEquAce.LocalizacaoFisica;
      qryTabela.FieldByName('ACL_CODITE').AsString := frmHerancaCadEqu.objHerAce.objEquAce.CodigoItem;

      dbeStatus.Text := frmHerancaCadEqu.objHerAce.objEquAce.Status;
      mskDtaAqu.Text := DateTimeToStr(frmHerancaCadEqu.objHerAce.objEquAce.DataAquisicao);
      mskDtUlMn.Text := DateTimeToStr(frmHerancaCadEqu.objHerAce.objEquAce.DataUltimaManutencao);
      edtDesIte.Text := frmHerancaCadEqu.objHerAce.objEquAce.DescricaoItem;
      mmoEspecf.Lines.Text := frmHerancaCadEqu.objHerAce.objEquAce.Especificacao;
      edtValAqu.Text := FloatToStr(frmHerancaCadEqu.objHerAce.objEquAce.ValorAquisicao);
      edtVlrCau.Text := FloatToStr(frmHerancaCadEqu.objHerAce.objEquAce.ValorCaucao);
      edtVlrAdc.Text := FloatToStr(frmHerancaCadEqu.objHerAce.objEquAce.ValorAdicional);
    End;
  Finally
    pFreeAndNil(frmHerancaCadEqu);
  End;
end;

procedure TfrmCadAcessorioLocacao.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pIniciarInclusao;
end;

procedure TfrmCadAcessorioLocacao.btnPesquisaClick(Sender: TObject);
Var
  arrSel: TConsultasArray;
  chrKey: Char;
begin
  inherited;
  chrKey := '/';

  strSitAnt := EmptyStr;

  If fPesqAcessorioLocacao(Self, dbeCodigo, Nil, qryTabela, chrKey, arrSel) Then
  Begin
    If qryTabela.Active Then
    Begin
      pCarregaDados;
    End;

    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadAcessorioLocacao.DBECODITEKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrProduto: TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1',
     '', 0, False, False, 0, cdrCodIte, '', False, '', '', True, False, True, '', False, False, False, False, False, False, False, False, '', -1,
     False, '', True, '', '', '', '', '', '', True, False, False, Nil, Nil, '', '', '', '', '', '', '', '', False, True) Then
  Begin
    fValidaCampos(DBECODITE, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAcessorioLocacao.dbeStatusExit(Sender: TObject);
begin
  inherited;

  fValidaCampos(dbeStatus, False);
end;

procedure TfrmCadAcessorioLocacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objCadLot);
  FreeAndNil(objAceLoc);
  FreeAndNil(objLiberacao);

end;

procedure TfrmCadAcessorioLocacao.FormCreate(Sender: TObject);
Var
  strSQL: String;
begin
  inherited;

  pSetaCodIte(DBECODITE);
  strNomeTabela := 'CADACL';
  strNomeCampo  := 'ACL_CODIGO';

  strSQL        := 'SELECT * FROM CADACL ';
  qryCadACL     := fCriarQuery(strSQL, Self);
  qryTabela     := qryCadACL;
  dtsCadAcl.DataSet := qryTabela;

  objCadLot := TCadLot.Create(Self);

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  objAceLoc := TEquipamentoLocacaoAcessorio.Create;
  objLiberacao := TLiberacao.create;

  pHabilitarComponentes(False);
end;

procedure TfrmCadAcessorioLocacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_INSERT) Then
  Begin
    If dbeCodIte.Focused Then
      pAbreCadastroProduto;
  End;
end;

procedure TfrmCadAcessorioLocacao.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

function TfrmCadAcessorioLocacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  inherited;

  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = dbeDescri) Then
    Begin
      If (fEmptyStr(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Descrição deve ser informado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtValAqu) Then
    Begin
      If (fStrToFloat(edtValAqu.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Valor de Aquisição deve ser maior ou igual a 0 (zero)!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeGarant) Then
    Begin
      If (fStrToFloat(dbeGarant.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Garantia deve ser maior ou igual a 0 (zero)!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = DBECODITE) Then
    Begin
      If (fEmptyStr(DBECODITE.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Produto deve ser informado!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtDesIte.Text := fRetNomProduto(DBECODITE.Text);
        If (fEmptyStr(edtDesIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Produto informado é inválido!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          If Not(objAceLoc.fValidaItemLocacao(DBECODITE.Text))  Then
          Begin
            fMensagem('ATENÇÃO!', objAceLoc.Mensagem, ['&OK']);
            Result := False;
          End
          Else
          If (objCadLot.tplTipLot = tplArmazem) And (not objCadLot.fExisteLotePrincipalAluguelEquipamento(DBECODITE.Text, VS_strCodEmp)) Then
          Begin
            Result := fMensagem('', 'O produto não possui um armazem principal para locação de equipamentos! Cadastre o armazem antes de efetuar o cadastro do equipamento!', ['&OK']) = -1;
          End;
        End;
      End;
    End
    Else If (Sender = dbeAnoFab) Then
    Begin
      If (Not fEmptyStr(dbeAnoFab.Text)) And (StrToInt(dbeAnoFab.Text) > 0) And (StrToInt(dbeAnoFab.Text) < 1900) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Ano de Fabricação deve ser maior ou igual a 1900!', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = mskDtaVen) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaVen.Text))) And (dbeStatus.Text = 'A') Then
      Begin
        If (fMensagem('CONFIRMAÇÃO!', 'Uma Data de Venda foi informada, isso irá INATIVAR o equipamento. Deseja prosseguir?', ['&Sim', '&Não'], 2) = 1) Then
         Begin
          qryTabela.FieldByName('ACL_STATUS').AsString := 'I';
          pHabilitarComponentes(False);
        End
        Else Begin
          mskDtaVen.Text := '__/__/____';
        End;
      End;
    End

    Else If (Sender = dbeStatus) Then
    Begin
      If (fEmptyStr(dbeStatus.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Status deve ser informado!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If Pos(dbeStatus.Text, 'AIB') = 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Status precisa ser do tipo "A" - Ativo, "I" - Inativo ou "B" - Bloqueado!', ['&OK']);
          Result := False;
        End
        Else
        If (dbeStatus.Text <> 'A') Then
        Begin
          If strSitAnt <> dbeStatus.Text Then
          Begin
            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'EQUSIT';
            objLiberacao.strMsgSen    := 'Alterar situação de equipamentos e acessórios';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.objMsgLibera.pAddTexto('Permitir alterar situação de equipamentos e acessórios.');

            Result := objLiberacao.fLibera;

            If Result Then
              strSitAnt := dbeStatus.Text;
          End;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadAcessorioLocacao.pAbreCadastroProduto;
var
  frmCadProdutos: TfrmCadProdutos;
begin
  If Not fVerificaAcessoSistema('frmCadProdutos') Then
    Exit;

  pCriarFormularios(TfrmCadProdutos, frmCadProdutos);
  Try
    frmCadProdutos.strCodIteParaCarregar := dbeCodIte.Text;
    frmCadProdutos.ShowModal;
  Finally
    pFreeAndNil(frmCadProdutos);
  End;

end;

procedure TfrmCadAcessorioLocacao.pCarregaDados;
begin
  objAceLoc.pCarregaEquipamento(qryTabela.FieldByName('AUTOINCREM').AsString);
  If objAceLoc.DataAquisicao > 0 Then
    mskDtaAqu.Text := DateToStr(objAceLoc.DataAquisicao);
  If objAceLoc.DataUltimaManutencao > 0 Then
    mskDtUlMn.Text := DateToStr(objAceLoc.DataUltimaManutencao);
  If objAceLoc.DataVenda > 0 Then
    mskDtaVen.Text := DateToStr(objAceLoc.DataVenda);
  edtValAqu.Text := FormatFloat('#,##0.00', objAceLoc.ValorAquisicao);
  edtDesIte.Text := objAceLoc.DescricaoItem;
  mmoEspecf.Texto:= objAceLoc.Especificacao;
  edtVlrCau.Text  := FormatFloat('#,##0.00', objAceLoc.ValorCaucao);
  edtVlrAdc.Text  := FormatFloat('#,##0.00', objAceLoc.ValorAdicional);
end;

procedure TfrmCadAcessorioLocacao.pHabilitarComponentes(blnHabilitar: Boolean);
begin
  dbeCodigo.Enabled := blnHabilitar;
  dbeDescri.Enabled := blnHabilitar;
  edtValAqu.Enabled := blnHabilitar;
  dbeGarant.Enabled := blnHabilitar;
  dbeRpUlMn.Enabled := blnHabilitar;
  dbeModelo.Enabled := blnHabilitar;
  dbeAnoFab.Enabled := blnHabilitar;
  mmoEspecf.Enabled := blnHabilitar;
  dbeLocFis.Enabled := blnHabilitar;
  DBECODITE.Enabled := blnHabilitar;
  dbeStatus.Enabled := blnHabilitar;
  mskDtUlMn.Enabled := blnHabilitar;
  mskDtaAqu.Enabled := blnHabilitar;
  mskDtaVen.Enabled := blnHabilitar;
  btnHeranca.Enabled := blnHabilitar;
  edtVlrCau.Enabled := blnHabilitar;
  edtVlrAdc.Enabled := blnHabilitar;
end;

procedure TfrmCadAcessorioLocacao.pInicializaIndices;
begin
  inherited;

end;

procedure TfrmCadAcessorioLocacao.pIniciarInclusao;
begin
  pLimparCampos;

  objAceLoc.pLimpar;

  pHabilitarComponentes(True);
  pHabilitaCodigo(dbeCodigo, dbeCodigo, False);

  qryTabela.FieldByName('ACL_STATUS').AsString := 'A';

  dbeStatus.Enabled := fVerificaAcessoSistema('EQUSIT');

  pSetFocus(dbeDescri);
end;

procedure TfrmCadAcessorioLocacao.pLimparCampos;
begin
  inherited;

  mskDtaAqu.Clear;
  mskDtUlMn.Clear;
  mskDtaVen.Clear;
  edtValAqu.Clear;
  edtDesIte.Clear;
  mmoEspecf.Clear;
  edtVlrCau.Clear;
  edtVlrAdc.Clear;

end;

end.
