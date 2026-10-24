unit untConsultaPedCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, untTypesSistema;

type
  TfrmConsultaPedCompra = class(TfrmPaiConfirma)
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    mskEmissaoDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskEmissaoDtaFin: TMaskEditFocus;
    mskEntregaDtaIni: TMaskEditFocus;
    Label1: TLabel;
    mskEntregaDtaFin: TMaskEditFocus;
    Label2: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    edtCodFornecedor: TEditFocus;
    Label12: TLabel;
    edtDesFornecedor: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    Label3: TLabel;
    edtDesGrupo: TEditFocus;
    edtProdutos: TEditFocus;
    Label4: TLabel;
    edtDesProduto: TEditFocus;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtGruCmp: TEditFocus;
    Label7: TLabel;
    edtDesGruCmp: TEditFocus;
    edtCodCmp: TEditFocus;
    edtDesCmp: TEditFocus;
    Label8: TLabel;
    rdgSituacao: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtCodCmpExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCmpKeyPress(Sender: TObject; var Key: Char);
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  private
    { Private declarations }
    function fValidaCamposData(Sender: TWinControl; mskDtaIni: TMaskEditFocus; mskDtaFin: TMaskEditFocus): Boolean;
  public
    { Public declarations }
    arrCodIte,
    arrLinhaGrupo,
    arrMarca,
    arrGruCmp,
    arrCodFornec,
    arrEmpresa,
    arrCodCmp: TConsultasArray;

    strLinhaProdu,
    strLinhaGrupo,
    strMarca,
    strGruCmp,
    strCodFornec,
    strEmpresa,
    strCodCmp: string;
  end;

var
  frmConsultaPedCompra: TfrmConsultaPedCompra;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesConsulta, untConsultas;

procedure TfrmConsultaPedCompra.FormShow(Sender: TObject);
begin
  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresa.OnExit(Sender);
  pSetFocus(mskEmissaoDtaIni);
  pSetaCodIte(edtProdutos);
end;
  
function TfrmConsultaPedCompra.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskEmissaoDtaIni) Or (Sender = mskEmissaoDtaFin) Then
      Result := fValidaCamposData(Sender, mskEmissaoDtaIni, mskEmissaoDtaFin)
    Else If (Sender = mskEntregaDtaIni) Or (Sender = mskEntregaDtaFin) Then
      Result := fValidaCamposData(Sender, mskEntregaDtaIni, mskEntregaDtaFin)
    Else If (Sender = edtCodEmpresa) And (fEmptyStr(edtCodEmpresa.Text)) Then
      pDesmarcaLista(edtCodEmpresa, arrEmpresa)
    Else If (Sender = edtCodFornecedor) And (fEmptyStr(edtCodFornecedor.Text)) Then
      pDesmarcaLista(edtCodFornecedor, arrCodFornec)
    Else If (Sender = mskLinhaGrupo) And (fEmptyStr(mskLinhaGrupo.Text)) Then
      pDesmarcaLista(mskLinhaGrupo, arrLinhaGrupo)
    Else If (Sender = edtProdutos) And (fEmptyStr(edtProdutos.Text)) Then
      pDesmarcaLista(edtProdutos, arrCodIte)
    Else If (Sender = edtMarca) And (fEmptyStr(edtMarca.Text)) Then
      pDesmarcaLista(edtMarca, arrMarca)
    Else If (Sender = edtGruCmp) And (fEmptyStr(edtGruCmp.Text)) Then
      pDesmarcaLista(edtGruCmp, arrGruCmp)
    Else If (Sender = edtCodCmp) And (fEmptyStr(edtCodCmp.Text)) Then
      pDesmarcaLista(edtCodCmp, arrCodCmp)
  end;

  If not Result Then
    pSetFocus(Sender);
end;

function TfrmConsultaPedCompra.fValidaCamposData(Sender: TWinControl; mskDtaIni, mskDtaFin: TMaskEditFocus): Boolean;
begin
  Result := True;
  If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    mskDtaFin.Clear;
    mskDtaFin.Enabled := False;
  End
  Else
  Begin
    mskDtaFin.Enabled := True;
    If (Sender = mskDtaFin) Then
    Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
        edtCodEmpresa.Enabled := False;
        edtCodEmpresa.Clear;
        edtDesEmpresa.Clear;
      End
      Else
      Begin
        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
          Result := False;
          edtCodEmpresa.Enabled := False;
          edtCodEmpresa.Clear;
          edtDesEmpresa.Clear;
        End;
      End;
    End;
  End;
end;

procedure TfrmConsultaPedCompra.edtCodCmpExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodCmp, edtDesCmp, arrCodCmp, fRetNomeOperador, nil, 'do Comprador');
end;

procedure TfrmConsultaPedCompra.edtCodCmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodCmp, edtDesCmp, Nil, Key, arrCodCmp,
                   True, True, True, False, False, True) Then
  Begin
    If fValidaCampos(edtCodCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedCompra.edtCodEmpresaExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmpresa,fRetNomeEmpresa,nil,'da Empresa');
end;

procedure TfrmConsultaPedCompra.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedCompra.edtCodFornecedorExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodFornecedor,edtDesFornecedor,arrCodFornec,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmConsultaPedCompra.edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrCodFornec) Then
  Begin
    fValidaCampos(edtCodFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedCompra.edtGruCmpExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmConsultaPedCompra.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedCompra.edtMarcaExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtMarca, edtDesMarca, arrMarca, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmConsultaPedCompra.edtMarcaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedCompra.mskLinhaGrupoExit(Sender: TObject);
begin
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmConsultaPedCompra.mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo) Then
  Begin
    fvalidaCampos(mskLinhaGrupo,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedCompra.edtProdutosExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtProdutos,edtDesProduto,arrCodIte,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmConsultaPedCompra.edtProdutosKeyPress(Sender: TObject; var Key: Char);
begin
  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, nil, Key, arrCodIte, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fvalidaCampos(edtProdutos,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

end.

