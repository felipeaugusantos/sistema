unit untCadBocaCaixaAlt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, Grids, DBGridCitel, DBGrids, StdCtrls, ExtCtrls, Mask,
  MaskEditFocus, EditFocus, AppEvnts, Menus, Buttons,
  Uni, untBocaCaixa, DB, ComCtrls, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadBocaCaixaAlt = class(TfrmPaiEdit)
    pnlDadosItem: TPanel;
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
    edtComVar: TEditFocus;
    edtPreMin: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDescriIni: TEditFocus;
    edtRefere: TEditFocus;
    edtUnidade: TEditFocus;
    edtDescriFin: TEditFocus;
    Panel1: TPanel;
    rdgTipAlt: TRadioGroup;
    chkPreMin: TCheckBox;
    chkComiss: TCheckBox;
    dbgItens: TDBGridCitel;
    dtsBocCai: TDataSource;
    ProgressBar: TProgressBar;
    btnGravar: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescriIniExit(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure chkPreMinClick(Sender: TObject);
    procedure chkComissClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pnlDadosItemEnter(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    objBcaCai: TBcaCai; // cria um objeto da Classe TBcaCai - untBocaCaixa

    procedure pCarregar;
    procedure pLimpaTudo;

  public
    { Public declarations }
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  end;

var
  frmCadBocaCaixaAlt: TfrmCadBocaCaixaAlt;

implementation

uses untPai, untFuncoesSimples,
     untConsultas, untTypesSistema;

{$R *.dfm}

function TfrmCadBocaCaixaAlt.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesUnidade: String;
begin
  Result := True;

  If (Sender = edtCodIte) Then
  Begin
    edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

    If fEmptyStr(edtDesIte.Text) And (Not fEmptyStr(edtCodIte.Text))  Then
    Begin
      fMensagem('AVISO', 'Código do Produto não encontrado.', ['&O K']);
      edtCodIte.Clear;
      Result := False;
    End;
  End

  Else If (Sender = edtMarca) Then
  Begin
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);

    If fEmptyStr(edtDesMarca.Text) And (Not fEmptyStr(edtMarca.Text))  Then
    Begin
      fMensagem('AVISO','Código da marca não encontrado.', ['&O K']);
      edtMarca.Clear;
      Result := False;
    End;

  End

  Else If (Sender = edtFornecedor) Then
  Begin
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

    If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtFornecedor.Text))  Then
    Begin
      fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
      edtFornecedor.Clear;
      Result := False;
    End;

  End  

  Else If (Sender = edtUnidade) Then
  Begin
    strDesUnidade := fRetNomUnidade(edtUnidade.Text);

    If fEmptyStr(strDesUnidade) And (Not fEmptyStr(edtUnidade.Text))  Then
    Begin
      fMensagem('AVISO','Código da unidade não encontrado.', ['&O K']);
      edtUnidade.Clear;
      Result := False;
    End;

  End

  Else If (Sender = edtPreMin) And edtPreMin.Enabled Then
  Begin
    If fStrToFloat(edtPreMin.Text) <= 0 Then
    Begin
      fMensagem('','O Campo Preço Mínimo deve ser maior que zero!',['&OK']);
      Result := False;
    End;
  End

  Else If (Sender = edtComVar) Then
  Begin

    If edtComVar.Enabled Then
    Begin
      If fStrToFloat(edtComVar.Text) <= 0 Then
      Begin
        fMensagem('','O Campo Comissão deve ser maior que zero!',['&OK']);
        Result := False;
      End;
    End;

    If (Not blnBuscaPorChave) And (Not edtComVar.Enabled) And (Not edtPreMin.Enabled) Then
    Begin
      fMensagem('','Informe o Preço Mínimo ou a Comissão para a alteração!',['&OK']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadBocaCaixaAlt.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);
    If fEmptyStr(edtDesGrupo.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo.Clear;
      pSetFocus(mskLinhaGrupo);
    End;
  End;
end;

procedure TfrmCadBocaCaixaAlt.edtCodIteExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodIte.Text) Then
    edtDesIte.Text := 'TODOS'
  Else
    edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

end;

procedure TfrmCadBocaCaixaAlt.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadBocaCaixaAlt.edtMarcaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := 'TODOS'
  Else
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);

end;

procedure TfrmCadBocaCaixaAlt.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadBocaCaixaAlt.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

end;

procedure TfrmCadBocaCaixaAlt.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, nil, Key, arrSel) Then  
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadBocaCaixaAlt.edtDescriIniExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtDescriIni.Text) Then
  Begin
    edtDescriFin.Enabled := False;
    pSetFocus(edtRefere);
  End
  Else
  Begin
    edtDescriFin.Enabled := True;
    pSetFocus(edtDescriFin);
  End;
  
end;

procedure TfrmCadBocaCaixaAlt.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, arrSel) Then  
  Begin
    if fValidaCampos(edtUnidade, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadBocaCaixaAlt.chkPreMinClick(Sender: TObject);
begin
  inherited;

  edtPreMin.Enabled := chkPreMin.Checked;

  If Not edtPreMin.Enabled Then
    edtPreMin.Clear;

  dbgItens.Columns[3].Visible := edtPreMin.Enabled;
  dbgItens.Columns[4].Visible := edtPreMin.Enabled;
  dbgItens.Columns[3].Width   := 100;
  dbgItens.Columns[4].Width   := 100;
end;

procedure TfrmCadBocaCaixaAlt.chkComissClick(Sender: TObject);
begin
  inherited;

  edtComVar.Enabled := chkComiss.Checked;

  If Not edtComVar.Enabled Then
    edtComVar.Clear;

  dbgItens.Columns[5].Visible := edtComVar.Enabled;
  dbgItens.Columns[6].Visible := edtComVar.Enabled;
  dbgItens.Columns[5].Width   := 100;
  dbgItens.Columns[6].Width   := 100;

end;

procedure TfrmCadBocaCaixaAlt.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    pCarregar;
    pSetFocus(dbgItens);
  End;
end;

procedure TfrmCadBocaCaixaAlt.pCarregar;
Begin

  With objBcaCai Do
  Begin
    strCodGru := mskLinhaGrupo.Text;
    strCodPro := edtCodIte.Text;
    strCodMar := edtMarca.Text;
    strCodFor := edtFornecedor.Text;
    strCodUni := edtUnidade.Text;
    strDesIni := edtDescriIni.Text;
    strDesFin := edtDescriFin.Text;
    strRefere := edtRefere.Text;
    strPreMin := edtPreMin.Text;
    strComVar := edtComVar.Text;

    If fStrToFloat(strPreMin) = 0 Then
      strPreMin := '';

    If fStrToFloat(strComVar) = 0 Then
      strComVar := '';

    If rdgTipAlt.ItemIndex = 0 Then
      talTipAlt := talFator
    Else
      talTipAlt := talValor;

    If fCarregaItensAlteracao Then
    Begin
      If qryBcaCaiAlt.IsEmpty Then
        fMensagem('', 'Não há nenhum item na Boca de Caixa para essas condições!', ['&Ok']);
    End;

  End;

End;

procedure TfrmCadBocaCaixaAlt.pLimpaTudo;
begin

  mskLinhaGrupo.Clear;
  edtDesGrupo.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtMarca.Clear;
  edtDesMarca.Clear;
  edtFornecedor.Clear;
  edtDesFornecedor.Clear;
  edtDescriIni.Clear;
  edtDescriFin.Clear;
  edtRefere.Clear;
  edtUnidade.Clear;
  chkPreMin.Checked := False;
  chkComiss.Checked := False;
  edtPreMin.Clear;
  edtComVar.Clear;
  edtPreMin.Enabled := False;
  edtComVar.Enabled := False;
  rdgTipAlt.ItemIndex := 0;

  ProgressBar.Position := 0;

  pFreeAndNil(objBcaCai);

  objBcaCai := TBcaCai.Create(Self);
  dtsBocCai.DataSet := objBcaCai.qryBcaCaiAlt;

  pSetFocus(mskLinhaGrupo);
end;

procedure TfrmCadBocaCaixaAlt.FormCreate(Sender: TObject);
begin
  inherited;

  objBcaCai := TBcaCai.Create(Self);
  dtsBocCai.DataSet := objBcaCai.qryBcaCaiAlt;

end;

procedure TfrmCadBocaCaixaAlt.FormShow(Sender: TObject);
begin
  inherited;
  pSetaCodIte( edtCodIte );
end;

procedure TfrmCadBocaCaixaAlt.btnGravarClick(Sender: TObject);
begin
  inherited;

  If objBcaCai.qryBcaCaiAlt.Active And (Not objBcaCai.qryBcaCaiAlt.IsEmpty) And
     (fMensagem('', 'Confirma a alteração da Boca de Caixa?', ['&Sim', '&Não']) = 1) Then
  Begin
    pnlDadosItem.Enabled := False;

    If objBcaCai.fGravaAlteracao(ProgressBar) Then
      fMensagem('', 'Alteração realizada com sucesso!', ['&Ok']);

    pnlDadosItem.Enabled := True;
    pLimpaTudo;
  End;
end;

procedure TfrmCadBocaCaixaAlt.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If SameText(Column.FieldName, 'COMNOV') Or
     SameText(Column.FieldName, 'PRENOV') Then
  Begin
    dbgItens.Canvas.Brush.Color := clLtGray;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmCadBocaCaixaAlt.pnlDadosItemEnter(Sender: TObject);
begin
  inherited;

  objBcaCai.qryBcaCaiAlt.Close;
  
end;

procedure TfrmCadBocaCaixaAlt.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

end.

