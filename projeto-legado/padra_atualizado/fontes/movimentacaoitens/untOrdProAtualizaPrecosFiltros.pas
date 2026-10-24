unit untOrdProAtualizaPrecosFiltros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus, untTOrdProAtualizaPrecos,
  Vcl.Mask, MaskEditFocus, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, untTypesSistema;

type
  TfrmOrdProAtualizaPrecosFiltros = class(TfrmPaiConfirma)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Panel1: TPanel;
    grpProdutoAcabado: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    edtLinGruProAca: TMaskEditFocus;
    edtDesLinGruProAca: TEditFocus;
    edtFornecProAca: TEditFocus;
    edtDesForProAca: TEditFocus;
    edtMarcaProAca: TEditFocus;
    edtDesMarcaProAca: TEditFocus;
    edtUnidadeProAca: TEditFocus;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtLinGruSubPro: TMaskEditFocus;
    edtDesLinGruSubPro: TEditFocus;
    edtFornecSubPro: TEditFocus;
    edtDesForSubPro: TEditFocus;
    edtMarcaSubPro: TEditFocus;
    edtDesMarcaSubPro: TEditFocus;
    edtUnidadeSubPro: TEditFocus;
    rdgCalculo: TRadioGroup;
    chkApenasExibir: TCheckBox;
    shpMultSel: TShape;
    edtDesProdutoPROACA: TEditFocus;
    edtProdutosPROACA: TEditFocus;
    Label7: TLabel;
    pnlSubProdutos: TPanel;
    edtDesProdutoSubGru: TEditFocus;
    edtProdutosSubPro: TEditFocus;
    Label8: TLabel;
    procedure mskLinhaGrupoGeralExit(Sender: TObject);
    procedure edtFornecedorGeralExit(Sender: TObject);
    procedure edtMarcaGeralExit(Sender: TObject);
    procedure edtUnidadeGeralExit(Sender: TObject);
    procedure mskLinhaGrupoGeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorGeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaGeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeGeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosPROACAKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosPROACAExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    arrCodIteAca,
    arrMarProAca,
    arrForProAca,

    arrLinGruProAca,
    arrUniProAca,

    arrCodIteSub,
    arrMarSubPro,
    arrForSubPro,
    arrLinGruSubPro,
    arrUniSubPro,

    arrCodIte,
    arrMar,
    arrFor,
    arrLinGru,
    arrUnidade : TConsultasArray;

    strLinGruProAca,
    strLinForProAca,
    strLinMarProAca,
    strLinUniProAca,
    strCodProProAca,

    strLinGruSubPro,
    strLinForSubPro,
    strLinMarSubPro,
    strLinUniSubPro,
    strCodProSubPro,

    strCodIte,
    strLinGru,
    strLinFor,
    strLinMar,
    strLinUni: string;

    edtMarca,
    edtDesMarca,
    edtFornecedor,
    edtDesFornecedor,
    edtUnidade,
    edtCodIte,
    edtDesProduto,
    edtDesGrupo:TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;

    procedure pDefiniComponentes(Sender: TObject);
    procedure pSetaValoresConsultas(Sender: TObject);
  public
    class function fGetOrdProAtualizaPrecosParams(): TOrdProAtualizaPrecosParams;
  end;

implementation

uses
  untFuncoesConsulta, untFuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmOrdProAtualizaPrecosFiltros.edtFornecedorGeralExit(Sender: TObject);
begin
  pDefiniComponentes(Sender);
  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrFor, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmOrdProAtualizaPrecosFiltros.edtFornecedorGeralKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pDefiniComponentes(Sender);
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFor, False) Then
  Begin
    pSetaValoresConsultas(Sender);
    If fValidaCampos(edtFornecedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmOrdProAtualizaPrecosFiltros.edtMarcaGeralExit(Sender: TObject);
begin
  inherited;
  pDefiniComponentes(Sender);
  pEdtCodSelectExit(edtMarca, edtDesMarca ,arrMar, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmOrdProAtualizaPrecosFiltros.edtMarcaGeralKeyPress(Sender: TObject; var Key: Char);
begin
  pDefiniComponentes(Sender);
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMar, False) Then
  Begin
    pSetaValoresConsultas(Sender);
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


function fRetNomProdutoLocal(strCodIte: String): String;
Begin
  Result := '';
  If fEmptyStr(strCodIte) Then
    Exit;
  Result := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte], False); //Para ler a descrição do buffer
End;


procedure TfrmOrdProAtualizaPrecosFiltros.edtProdutosPROACAExit(
  Sender: TObject);
begin
  inherited;
  pDefiniComponentes(Sender);
  pEdtCodSelectExit(edtCodIte, edtDesProduto, arrCodIte, fRetNomProdutoLocal, Nil, 'do Produto');
end;

procedure TfrmOrdProAtualizaPrecosFiltros.edtProdutosPROACAKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pDefiniComponentes(Sender);
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesProduto, Nil, Key, arrCodIte, False) Then
  Begin
    pSetaValoresConsultas(Sender);
    If fValidaCampos(edtCodIte, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmOrdProAtualizaPrecosFiltros.edtUnidadeGeralExit(Sender: TObject);
begin
  inherited;
  pDefiniComponentes(Sender);
  If fEmptyStr(fRetNomUnidade(edtUnidade.Text)) And (Not fEmptyStr(edtUnidade.Text))  Then
  Begin
    fMensagem('AVISO','Código da Unidade não encontrado.', ['&O K']);
    edtUnidade.Clear;
    pSetFocus(edtUnidade);
  End;
end;

procedure TfrmOrdProAtualizaPrecosFiltros.edtUnidadeGeralKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  pDefiniComponentes(Sender);
  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, arrUnidade, False) Then
  Begin
    pSetaValoresConsultas(Sender);
    fValidaCampos(edtUnidade, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure pAddFiltro(AFiltro: TPArrayOfString; AEditText: String; AConsultas: TConsultasArray);
Var
  LIndex: Integer;
begin
  SetLength(AFiltro^, 0);
  If (Length(AConsultas) = 0) And (Not fEmptyStr(AEditText)) Then
    pAddDados(AFiltro^, AEditText)
  Else
    For LIndex := Low(AConsultas) To High(AConsultas) Do
      pAddDados(AFiltro^, AConsultas[LIndex].strCodigo);
end;

class function TfrmOrdProAtualizaPrecosFiltros.fGetOrdProAtualizaPrecosParams: TOrdProAtualizaPrecosParams;
Var
  LForm: TfrmOrdProAtualizaPrecosFiltros;
begin
  Result := nil;
  pCriarFormularios(TfrmOrdProAtualizaPrecosFiltros, LForm);
  Try
    If (LForm.Showmodal = mrOk) Then
    Begin
      Result := TOrdProAtualizaPrecosParams.Create;

      Result.SomenteExibir := LForm.chkApenasExibir.Checked;

      case LForm.rdgCalculo.ItemIndex Of
        0: Result.TipoAtualizacao := opAtualizarPrecoVenda;
        1: Result.TipoAtualizacao := opAtualizarMargem;
        Else Raise Exception.Create('Opção inválida: TfrmOrdProAtualizaPrecosFiltros.rdgCalculo.ItemIndex');
      End;

      {* Filtros Estrutura *}
      pAddFiltro(@Result.FiltroEstrutura.LinhaGrupos  , LForm.edtLinGruProAca.Text   , LForm.arrLinGruProAca);
      pAddFiltro(@Result.FiltroEstrutura.Produtos     , LForm.edtProdutosPROACA.Text , LForm.arrCodIteAca);
      pAddFiltro(@Result.FiltroEstrutura.Fornecedores , LForm.edtFornecProAca.Text   , LForm.arrForProAca);
      pAddFiltro(@Result.FiltroEstrutura.Marcas       , LForm.edtMarcaProAca.Text    , LForm.arrMarProAca);
      pAddFiltro(@Result.FiltroEstrutura.Unidades     , LForm.edtUnidadeProAca.Text  , LForm.arrUniProAca);

      {* Filtros Sub-Itens *}
      pAddFiltro(@Result.FiltroSubItens.LinhaGrupos   , LForm.edtLinGruSubPro.Text   , LForm.arrLinGruSubPro);
      pAddFiltro(@Result.FiltroSubItens.Produtos      , LForm.edtProdutosSubPro.Text , LForm.arrCodIteSub);
      pAddFiltro(@Result.FiltroSubItens.Fornecedores  , LForm.edtFornecSubPro.Text   , LForm.arrForSubPro);
      pAddFiltro(@Result.FiltroSubItens.Marcas        , LForm.edtMarcaSubPro.Text    , LForm.arrMarSubPro);
      pAddFiltro(@Result.FiltroSubItens.Unidades      , LForm.edtUnidadeSubPro.Text  , LForm.arrUniSubPro);
    End
  Finally
    pFreeAndNil(LForm);
  End;

end;

procedure TfrmOrdProAtualizaPrecosFiltros.FormCreate(Sender: TObject);
begin
  inherited;

  If fCfgSis('VENMAR', varString) = 1 Then
    rdgCalculo.ItemIndex:= 0
  Else
    rdgCalculo.ItemIndex:= 1;

  pSetaCodIte(edtProdutosPROACA);
  pSetaCodIte(edtProdutosSubPro);
end;

procedure TfrmOrdProAtualizaPrecosFiltros.mskLinhaGrupoGeralExit(Sender: TObject);
begin
  inherited;
  pDefiniComponentes(Sender);
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinGru, fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmOrdProAtualizaPrecosFiltros.mskLinhaGrupoGeralKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pDefiniComponentes(Sender);
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    pSetaValoresConsultas(Sender);
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmOrdProAtualizaPrecosFiltros.pDefiniComponentes(Sender: TObject);
var blnProAca: Boolean;
begin
  blnProAca := (TWinControl(Sender).Parent = grpProdutoAcabado);
  If blnProAca Then
  Begin
    edtMarca         := edtMarcaProAca;
    edtDesMarca      := edtDesMarcaProAca;
    edtFornecedor    := edtFornecProAca;
    edtDesFornecedor := edtDesForProAca;
    edtUnidade       := edtUnidadeProAca;
    edtDesGrupo      := edtDesLinGruProAca;
    mskLinhaGrupo    := edtLinGruProAca;
    edtCodIte        := edtProdutosPROACA;
    edtDesProduto    := edtDesProdutoPROACA;
    arrMar           := arrMarProAca;
    arrFor           := arrForProAca;
    arrCodIte        := arrCodIteACA;
    arrLinGru        := arrLinGruProAca;
    arrUnidade       := arrUniProAca;
    strLinGru        := strLinGruProAca;
    strLinFor        := strLinForProAca;
    strLinMar        := strLinMarProAca;
    strLinUni        := strLinUniProAca;
    strCodIte        := strCodProProAca;
  End
  Else
  Begin
    edtMarca         := edtMarcaSubPro;
    edtDesMarca      := edtDesMarcaSubPro;
    edtFornecedor    := edtFornecSubPro;
    edtDesFornecedor := edtDesForSubPro;
    edtUnidade       := edtUnidadeSubPro;
    edtDesGrupo      := edtDesLinGruSubPro;
    edtCodIte        := edtProdutosSubPro;
    edtDesProduto    := edtDesProdutoSubGru;
    mskLinhaGrupo    := edtLinGruSubPro;
    arrMar           := arrMarSubPro;
    arrFor           := arrForSubPro;
    arrLinGru        := arrLinGruSubPro;
    arrUnidade       := arrUniSubPro;
    strLinGru        := strLinGruSubPro;
    strLinFor        := strLinForSubPro;
    strLinMar        := strLinMarSubPro;
    strLinUni        := strLinUniSubPro;
    strCodIte        := strCodProSubPro;
  End;
end;

procedure TfrmOrdProAtualizaPrecosFiltros.pSetaValoresConsultas(
  Sender: TObject);
var blnProAca: Boolean;
begin
  blnProAca := (TWinControl(Sender).Parent = grpProdutoAcabado);
  If blnProAca Then
  Begin
    edtMarca         := edtMarcaProAca;
    edtDesMarca      := edtDesMarcaProAca;
    edtFornecedor    := edtFornecProAca;
    edtDesFornecedor := edtDesForProAca;
    edtUnidade       := edtUnidadeProAca;
    edtDesGrupo      := edtDesLinGruProAca;
    mskLinhaGrupo    := edtLinGruProAca;
    arrMarProAca    := arrMar;
    arrForProAca    := arrFor;
    arrLinGruProAca := arrLinGru;
    arrUniProAca    := arrUnidade;
    strLinGruProAca := strLinGru;
    strLinForProAca := strLinFor;
    strLinMarProAca := strLinMar;
    strLinUniProAca := strLinUni;
  End
  Else
  Begin
    edtMarca         := edtMarcaSubPro;
    edtDesMarca      := edtDesMarcaSubPro;
    edtFornecedor    := edtFornecSubPro;
    edtDesFornecedor := edtDesForSubPro;
    edtUnidade       := edtUnidadeSubPro;
    edtDesGrupo      := edtDesLinGruSubPro;
    mskLinhaGrupo    := edtLinGruSubPro;
    arrMarSubPro     := arrMar;
    arrForSubPro     := arrFor;
    arrLinGruSubPro  := arrLinGru;
    arrUniSubPro     := arrUnidade;
    strLinGruSubPro  := strLinGru;
    strLinForSubPro  := strLinFor;
    strLinMarSubPro  := strLinMar;
    strLinUniSubPro  := strLinUni;
  End;
end;

end.
