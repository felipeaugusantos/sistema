unit untCadPromocaoBrindesFiltro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.Mask, MaskEditFocus,
  Vcl.StdCtrls, EditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, untPromocaoBrindes;

type
  TfrmCadPromocaoBrindesFiltro = class(TfrmPaiConfirma)
    pnlDadosItem: TPanel;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblDescricao: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lblQtdPon: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
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
    edtQtdPon: TEditFocus;
    lblQtdBri: TLabel;
    edtQtdBri: TEditFocus;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
  public
    { Public declarations }
    objPromocaoBrindes: TPromocaoBrindes;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmCadPromocaoBrindesFiltro.edtCodIteExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodIte.Text) Then
  Begin
    edtDesIte.Text := 'TODOS';
    edtUnidade.Text := '';
  End
  Else
  Begin
    edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
    edtUnidade.Text := fRetUnidadeItem(edtCodIte.Text);
  End;

  edtDesIte.Enabled := False;

  If fEmptyStr(edtDesIte.Text) And (Not fEmptyStr(edtCodIte.Text))  Then
  Begin
    fMensagem('AVISO', 'Código do Produto não encontrado.', ['&O K']);
    edtCodIte.Clear;
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmCadPromocaoBrindesFiltro.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocaoBrindesFiltro.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

  edtDesFornecedor.Enabled := False;

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtFornecedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtFornecedor.Clear;
    pSetFocus(edtFornecedor);
  End;
end;

procedure TfrmCadPromocaoBrindesFiltro.edtFornecedorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocaoBrindesFiltro.edtMarcaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := 'TODOS'
  Else
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);

  edtDesMarca.Enabled := False;

  If fEmptyStr(edtDesMarca.Text) And (Not fEmptyStr(edtMarca.Text))  Then
  Begin
    fMensagem('AVISO','Código da marca não encontrado.', ['&O K']);
    edtMarca.Clear;
    pSetFocus(edtMarca);
  End;
end;

procedure TfrmCadPromocaoBrindesFiltro.edtMarcaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrMarca : TConsultasArray;
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocaoBrindesFiltro.edtUnidadeKeyPress(Sender: TObject; Var Key: Char);
  Var
    arrUnidades: TConsultasArray;
begin
  inherited;
  If fPesqUnidade(Self, edtUnidade, Nil, Nil, nil, Key, arrUnidades) Then
  Begin
    If fValidaCampos(edtUnidade, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocaoBrindesFiltro.FormActivate(Sender: TObject);
begin
  inherited;
  lblQtdPon.Visible := objPromocaoBrindes.TipoItem = itemVenda;
  edtQtdPon.Visible := objPromocaoBrindes.TipoItem = itemVenda;

  lblQtdBri.Visible := objPromocaoBrindes.TipoItem = itemBrinde;
  edtQtdBri.Visible := objPromocaoBrindes.TipoItem = itemBrinde;

  If (objPromocaoBrindes.TipoItem = itemBrinde) Then
  Begin
    lblQtdBri.Top := lblQtdPon.Top;
    edtQtdBri.Top := edtQtdPon.Top;
  End
  Else
    Self.Height := Self.Height - edtQtdBri.Height;

  If Not fEmptyStr(objPromocaoBrindes.strCodigoItem) Then
  Begin
    edtCodIte.Text := objPromocaoBrindes.strCodigoItem;
    If fValidaCampos(edtCodIte, True) Then
    Begin
      mskLinhaGrupo.Enabled := False;
      edtCodIte.Enabled     := False;
      edtMarca.Enabled      := False;
      edtFornecedor.Enabled := False;
      edtDescriIni.Enabled  := False;
      edtDescriFin.Enabled  := False;
      edtRefere.Enabled     := False;
      edtUnidade.Enabled    := False;
    End;
  End;

  Self.SelectFirst;
end;

procedure TfrmCadPromocaoBrindesFiltro.FormShow(Sender: TObject);
begin
  inherited;
  pSetaCodIte( edtCodIte );
end;

function TfrmCadPromocaoBrindesFiltro.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strPromocoes: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtUnidade) Then
    Begin
      If Not fEmptyStr(edtUnidade.Text) Then
      Begin
        If fEmptyStr(fRetNomUnidade(edtUnidade.Text)) Then
        Begin
          fMensagem('', 'Unidade Inválida!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodIte) Then
    Begin

      If (fEmptyStr(edtCodIte.Text)) Then  // se for branco carrega todos na descricao
        edtDesIte.Text := 'TODOS'
      Else
      Begin
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

        If (fEmptyStr(edtDesIte.Text)) Then // caso nao seja encontrado
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If (objPromocaoBrindes.TipoItem = itemBrinde) And
                (fCampoTabela('ITE_USABON', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'N') Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não pode ser bonificado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (objPromocaoBrindes.TipoItem = itemVenda) And
             (objPromocaoBrindes.fItemCadastradoPromocaoBrindes(edtCodIte.Text, strPromocoes)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item já está em outra promoção!' + #10#13 + strPromocoes, ['&Ok']);
            Result := False;
          End;
        End;

      End;

    End

    Else If (Sender = edtDescriIni) Then
    Begin
      If fEmptyStr(edtDescriIni.Text) Then
        edtDescriFin.Enabled := False
      Else
        edtDescriFin.Enabled := True;
    End

    Else If (Sender = edtDescriFin) Then
    Begin
      If Not fEmptyStr(edtDescriIni.Text) Then
      Begin
        If fEmptyStr(edtDescriFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Descrição Final deve ser preenchida!',
            ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtQtdPon) And edtQtdPon.Visible Then
    Begin
      If fStrToFloat(edtQtdPon.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A quantidade de pontos deve ser maior que zero!!', ['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtQtdBri) And edtQtdBri.Visible Then
    Begin
      If fStrToFloat(edtQtdBri.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A quantidade de brindes deve ser maior que zero!!', ['&O K']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadPromocaoBrindesFiltro.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);

  edtDesGrupo.Enabled := False;

  If fEmptyStr(edtDesGrupo.Text) And (Not fEmptyStr(mskLinhaGrupo.Text))  Then
  Begin
    fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
    mskLinhaGrupo.Clear;
    pSetFocus(mskLinhaGrupo);
  End;
end;

procedure TfrmCadPromocaoBrindesFiltro.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.
