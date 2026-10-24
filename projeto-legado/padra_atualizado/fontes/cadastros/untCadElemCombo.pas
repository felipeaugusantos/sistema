unit untCadElemCombo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxGridCustomView, cxGrid, EditFocus, cxGridCitel, untTypesSistema, Uni, UniClientDataSet,
  Vcl.Mask, MaskEditFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadElemCombo = class(TfrmPaiConfirma)
    Panel1: TPanel;
    pnlCabeca: TPanel;
    cxStyleRepository1: TcxStyleRepository;
    Label1: TLabel;
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    cxStyle1: TcxStyle;
    dtsElemen: TDataSource;
    cxgElemen: TcxGrid;
    cxgElemenDBTableView1: TcxGridDBTableViewCitel;
    CODIGO: TcxGridDBColumn;
    DESCRI: TcxGridDBColumn;
    cxgElemenLevel1: TcxGridLevel;
    Panel2: TPanel;
    Label2: TLabel;
    mskLinGru: TMaskEditFocus;
    Label3: TLabel;
    btnInserir: TBitBtnLocked;
    procedure cxgElemenDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnInserirClick(Sender: TObject);
  private
    procedure pAjustaTela;
    procedure pLimpaCampos;
    procedure pFocaCodigo;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    cdsElemen: TUniClientDataSet;
    tipTipEle: TTipEle;
  end;


implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples;

procedure TfrmCadElemCombo.btnInserirClick(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodigo.Text)) And (fEmptyStr(mskLinGru.Text)) Then
    Exit;

  With cdsElemen Do
  Begin
    If (edtCodigo.Visible) And (Locate('CODIGO', edtCodigo.Text, [])) Or
       (mskLinGru.Visible) And (Locate('CODIGO', mskLinGru.Text, [])) Then
      Edit
    Else
      Insert;

    If (mskLinGru.Visible) Then
      FieldByName('CODIGO').AsString := mskLinGru.Text
    Else
      FieldByName('CODIGO').AsString := edtCodigo.Text;

    FieldByName('DESCRI').AsString := edtDescri.Text;

    Post;
  End;

  pLimpaCampos;
end;

procedure TfrmCadElemCombo.cxgElemenDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  If ((Key = VK_DELETE) And (Not(cdsElemen.IsEmpty))) Then
    cdsElemen.Delete
  Else If (Key = VK_ESCAPE) And (cxgElemen.IsFocused) Then
    pFocaCodigo
  Else If (Key = VK_RETURN) Then
  Begin
    pLimpaCampos;
    pFocaCodigo;
  End
  Else
    inherited;
end;

procedure TfrmCadElemCombo.edtCodigoKeyPress(Sender: TObject; var Key: Char);
Var
  arrGenerico: TConsultasArray;
begin
  inherited;
  If (tipTipEle = telMarca) Then
  Begin
    {**************************}
    {* NOVA CONSULTA DE MARCA *}
    {***********************PZ*}
    If fPesqMarcas(Self, edtCodigo, edtDescri, Nil, Key, arrGenerico) Then
    Begin
      If fValidaCampos(edtCodigo, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else If (tipTipEle = telFornecedor) Then
  Begin
    {*******************************}
    {* NOVA CONSULTA DE FORNECEDOR *}
    {****************************PZ*}
    If fPesqFornecedor(conForSimples, Self, edtCodigo, edtDescri, Nil, Key, arrGenerico) Then
    Begin
      If fValidaCampos(edtCodigo, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else If (tipTipEle = telGrupoProd) Then
  Begin
    {*************************************}
    {* NOVA CONSULTA DE GRUPO DE PRODUTO *}
    {**********************************PZ*}
    If fPesqGrupoProduto(Self, edtCodigo, edtDescri, Nil, Key, arrGenerico) Then
    Begin
      If fValidaCampos(edtCodigo, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else If (tipTipEle = telGrupoPreco) Then
  Begin
    {************************************}
    {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
    {*********************************RV*}
    If fPesqGrupoPrecos(Self, edtCodigo, edtDescri, Nil, Key, arrGenerico) Then
    Begin
      If fValidaCampos(edtCodigo, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadElemCombo.FormActivate(Sender: TObject);
begin
  inherited;
  pFocaCodigo;
end;

procedure TfrmCadElemCombo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Not (ActiveControl <> edtCodigo) Or
     Not (ActiveControl <> mskLinGru) Then
    blnFecharComEscape := True
  Else
    blnFecharComEscape := False;

  inherited;

end;

procedure TfrmCadElemCombo.FormShow(Sender: TObject);
begin
  inherited;
  pAjustaTela;
  dtsElemen.DataSet := cdsElemen;
end;

function TfrmCadElemCombo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskLinGru) And (mskLinGru.Visible) Then
    Begin
      If (fEmptyStr(mskLinGru.Text)) Then
      Begin
        pSetFocus(cxgElemen);
        blnMudarFoco := False;
      End
      Else
      Begin
        edtDescri.Text := fRetNomeLinhaGrupo(mskLinGru.Text);

        If (fEmptyStr(edtDescri.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Linha/Grupo não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodigo) And (edtCodigo.Visible) Then
    Begin
      If (fEmptyStr(edtCodigo.Text)) Then
      Begin
        pSetFocus(cxgElemen);
        blnMudarFoco := False;
      End
      Else
      Begin
        If (tipTipEle = telMarca) Then
        Begin
          edtDescri.Text := fRetNomMarca(edtCodigo.Text);

          If (fEmptyStr(edtDescri.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa Marca não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else If (tipTipEle = telFornecedor) Then
        Begin
          edtDescri.Text := fRetNomFornecedor(edtCodigo.Text);

          If (fEmptyStr(edtDescri.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End
        Else If (tipTipEle = telGrupoProd) Then
        Begin
          edtDescri.Text := fRetNomeGrupoProduto(edtCodigo.Text);

          If fEmptyStr(edtDescri.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse grupo de produto não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End
        Else If (tipTipEle = telGrupoPreco) Then
        Begin
          edtDescri.Text := fRetNomeGrupoPrecos(edtCodigo.Text);

          If fEmptyStr(edtDescri.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse grupo de preços não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End;

  End;

end;

procedure TfrmCadElemCombo.mskLinGruKeyPress(Sender: TObject; var Key: Char);
Var
  arrLinGru: TConsultasArray;
begin
  inherited;
  If (tipTipEle = telLinhaGrupo) Then
  Begin
    {**********************************}
    {* NOVA CONSULTA DE LINHA E GRUPO *}
    {*******************************PZ*}
    If fPesqGrupo(Self, mskLinGru, edtDescri, Nil, Key, arrLinGru) Then
    Begin
      If fValidaCampos(mskLinGru, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadElemCombo.pAjustaTela;
begin
  mskLinGru.Visible := False;
  edtCodigo.Visible := True;

  If (tipTipEle = telLinhaGrupo) Then
  Begin
    mskLinGru.Visible := True;
    edtCodigo.Visible := False;
    Self.Caption := 'Linha / Grupo - Elementos para Indicação na Venda';
  End
  Else If (tipTipEle = telMarca) Then
  Begin
    Self.Caption := 'Marca - Elementos para Indicação na Venda';
    edtCodigo.MaxLength := 6;
    edtCodigo.TamCampo  := 6;
    edtCodigo.CompZeros := True;
  End
  Else If (tipTipEle = telFornecedor) Then
  Begin
    Self.Caption := 'Fornecedor - Elementos para Indicação na Venda';
    edtCodigo.MaxLength := 8;
    edtCodigo.TamCampo  := 8;
    edtCodigo.CompZeros := True;
  End
  Else If (tipTipEle = telGrupoProd) Then
  Begin
    Self.Caption := 'Grupo de Produto - Elementos para Indicação na Venda';
    edtCodigo.MaxLength := 5;
    edtCodigo.TamCampo  := 5;
    edtCodigo.CompZeros := True;
  End
  Else If (tipTipEle = telGrupoPreco) Then
  Begin
    Self.Caption := 'Grupo de Preço - Elementos para Indicação na Venda';
    edtCodigo.MaxLength := 6;
    edtCodigo.TamCampo  := 6;
    edtCodigo.CompZeros := True;
  End;
end;

procedure TfrmCadElemCombo.pFocaCodigo;
begin
  If (mskLinGru.Visible) Then
    pSetFocus(mskLinGru)
  Else
    pSetFocus(edtCodigo);
end;

procedure TfrmCadElemCombo.pLimpaCampos;
begin
  edtCodigo.Clear;
  edtDescri.Clear;
  mskLinGru.Clear;
  pFocaCodigo;
end;

end.
