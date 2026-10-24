unit untFiltrosProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, ComboBoxFocus, untTypesSistema;

type
  TfrmFiltrosProdutos = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblDescricao: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtDesIni: TEditFocus;
    edtRefere: TEditFocus;
    edtCodUni: TEditFocus;
    edtDesFin: TEditFocus;
    lblQtdIte: TLabel;
    edtQtdIte: TEditFocus;
    pnlOpcoes: TPanel;
    pnlAddPro: TPanel;
    chkAddPro: TCheckBox;
    Label2: TLabel;
    cmbBrinde: TComboBoxFocus;
    Label3: TLabel;
    cmbTabPre: TComboBoxFocus;
    Label5: TLabel;
    cmbOperad: TComboBoxFocus;
    Label6: TLabel;
    cmbTipDes: TComboBoxFocus;
    lblValDes: TLabel;
    edtValDes: TEditFocus;
    edtDesUni: TEditFocus;
    chkAddPAt: TCheckBox;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbBrindeChange(Sender: TObject);
    procedure cmbTipDesChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodUniExit(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
  private
    intDecQtd: Integer;
    procedure pAjustaTela;
    procedure pAjustaCombos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    tipTipPro: TTipProCombo;
    blnTemPro: Boolean;
    arrSelIte: TConsultasArray;
    arrSelMar: TConsultasArray;
    arrSelFor: TConsultasArray;
    arrSelUni: TConsultasArray;
    arrSelGru: TConsultasArray;
  end;

var
  frmFiltrosProdutos: TfrmFiltrosProdutos;

implementation

{$R *.dfm}

uses untObservacao, untFuncoesSimples, untConsultas, untFuncoes,
  untFuncoesConsulta;

{ TfrmFiltrosProdutos }

procedure TfrmFiltrosProdutos.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDesIte,arrSelIte, nil, fRetNomProduto,'do Produto');
end;

procedure TfrmFiltrosProdutos.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrSelIte, False, nil, 'Consulta de Itens', '1') then
    Begin
      If fValidaCampos(edtCodIte, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFiltrosProdutos.btnConfirmaClick(Sender: TObject);
begin
  If (Not chkAddPro.Checked) And
     (blnTemPro)             And
     (fMensagem('ATENÇÃO!', 'A Opção de "' + chkAddPro.caption + '"' + #13#10 + 'está desmarcada e os produtos existentes serão removidos, confirma? ', ['&S i m', '&N ã o'], 2) = 2) Then
    Exit;


  modalResult := mrOk;
  inherited;

end;

procedure TfrmFiltrosProdutos.cmbBrindeChange(Sender: TObject);
begin
  inherited;
  If (cmbBrinde.ItemIndex = 0) Then
  Begin
    cmbTabPre.ItemIndex := -1;
    cmbOperad.ItemIndex := -1;
    cmbTipDes.ItemIndex := -1;

    edtValDes.Text := '0,00';

    cmbTabPre.Enabled := False;
    cmbOperad.Enabled := False;
    cmbTipDes.Enabled := False;
    edtValDes.Enabled := False;
  End
  Else
  Begin
    cmbTabPre.Enabled := True;
    cmbOperad.Enabled := True;
    cmbTipDes.Enabled := True;
    edtValDes.Enabled := True;
  End;
end;

procedure TfrmFiltrosProdutos.cmbTipDesChange(Sender: TObject);
begin
  inherited;
  If (cmbTipDes.ItemIndex = 1) Then
    lblValDes.Caption := 'Valor Desc.:'
  Else
    lblValDes.Caption := 'Perc. Desc.:';
end;

procedure TfrmFiltrosProdutos.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtNomFor, arrSelFor, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmFiltrosProdutos.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrSelFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltrosProdutos.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrSelMar, fRetNomeMarca, nil, 'da Marca');
end;

procedure TfrmFiltrosProdutos.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrSelMar, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltrosProdutos.edtCodUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni, edtDesUni, arrSelUni, fRetNomUnidade, Nil, 'da Unidade');
end;

procedure TfrmFiltrosProdutos.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  {*****************************}
  {* NOVA CONSULTA DE UNIDADES *}
  {**************************AC*}
  if fPesqUnidade(Self, edtCodUni, edtDesUni, Nil, Nil, Key, arrSelUni, False) then
  begin
    If fValidaCampos(edtCodUni, True) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmFiltrosProdutos.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
end;

procedure TfrmFiltrosProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  blnTemPro := False;
end;

procedure TfrmFiltrosProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
    btnConfirma.Click;
end;

procedure TfrmFiltrosProdutos.FormShow(Sender: TObject);
begin
  inherited;
  intDecQtd := fCfgSis('DECQTD', varInteger);
  pAjustaCombos;
  pAjustaTela;

  pSetaCodIte( edtCodIte );

end;

function TfrmFiltrosProdutos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin
      pDesmarcaLista(edtCodIte,arrSelIte);
    End

    Else If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru, arrSelGru,'',6);
    End

    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, arrSelMar);
    End

    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrSelFor);
    End

    Else If (Sender = edtDesIni) Then
    Begin
      If fEmptyStr(edtDesIni.Text) Then
        edtDesFin.Enabled := False
      Else
        edtDesFin.Enabled := True;
    End

    Else If (Sender = edtDesFin) Then
    Begin
      If Not fEmptyStr(edtDesIni.Text) Then
      Begin
        If fEmptyStr(edtDesFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A descrição final deve ser preenchida!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodUni) Then
    Begin
      pDesmarcaLista(edtCodUni, arrSelUni);
    End

    Else If (Sender = edtQtdIte) And (edtQtdIte.Visible) Then
    Begin
      If (fEmptyStr(edtQtdIte.Text)) Then
        edtQtdIte.Text := '0,00';

      edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtd), fstrToFloat(edtQtdIte.Text));

      If (fStrToFloat(edtQtdIte.Text) <= 0) Then
      Begin
        fMensagem('', 'A Quantidade deve ser maior que zero!', ['&OK']);
        edtQtdIte.SelectAll;
        Result := False;
      End;
    End

    Else If (Sender = cmbBrinde) Then
    Begin
      If (pnlOpcoes.Visible) And (cmbBrinde.ItemIndex = -1) Then
      Begin
        fMensagem('', 'Favor informar se o Produto será Brinde!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbTabPre) Then
    Begin
      If (pnlOpcoes.Visible) And (cmbTabPre.Enabled) And (cmbTabPre.ItemIndex = -1) Then
      Begin
        fMensagem('', 'Favor informar a Tabela de Preço!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbOperad) Then
    Begin
      If (pnlOpcoes.Visible) And (cmbOperad.Enabled) And (cmbOperad.ItemIndex = -1) Then
      Begin
        fMensagem('', 'Favor informar o Operador!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbTipDes) Then
    Begin
      If (pnlOpcoes.Visible) And (cmbTipDes.Enabled) And (cmbTipDes.ItemIndex = -1) Then
      Begin
        fMensagem('', 'Favor informar o Tipo de Desconto!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtValDes) Then
    Begin
      If (pnlOpcoes.Visible) And (edtValDes.Enabled) Then
      Begin
        If (fEmptyStr(edtValDes.Text)) Then
          edtValDes.Text := FormatFloat('#,##0.00', 0)
        Else
          edtValDes.Text := FormatFloat('#,##0.00', fStrToFloat(edtValDes.Text));

        If (fStrToFloat(edtValDes.Text) < 0) Then
        Begin
          fMensagem('', 'O Valor do Desconto deve ser maior ou igual a zero!', ['&OK']);
          edtValDes.SelectAll;
          Result := False;
        End;
      End
      Else
        edtValDes.Text := FormatFloat('#,##0.00', 0);
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFiltrosProdutos.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru,edtDesGru,arrSelGru,fRetNomeLinhaGrupo,Nil,'da Linha/Grupo',6);
end;

procedure TfrmFiltrosProdutos.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrSelGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFiltrosProdutos.pAjustaCombos;
Var
  intContador: Integer;
begin
  cmbTabPre.Clear;

  cmbTabPre.Items.Add('FAT');

  For intContador := 1 To Length(VS_strTabPrc) Do
  Begin
    If (VS_strTabPrc[intContador] = 'S' ) Then
      cmbTabPre.Items.Add(intToStr(intContador));
  End;

  cmbBrinde.ItemIndex := -1;
  cmbTabPre.ItemIndex := -1;
  cmbOperad.ItemIndex := -1;
  cmbTipDes.ItemIndex := -1;
end;

procedure TfrmFiltrosProdutos.pAjustaTela;
begin
  If (tipTipPro in [pcoAtivacao, pcoSimilar]) Then
  Begin
    If (tipTipPro = pcoSimilar) Then
    Begin
      lblQtdIte.Visible := False;
      edtQtdIte.Visible := False;
    End;
    if tipTipPro = pcoAtivacao then
      chkAddPAt.visible := false
    else chkAddPAt.visible := true;

    pnlOpcoes.Visible := False;
    Self.Height := Self.Height - pnlOpcoes.Height + 3;
  End;
end;

end.
