unit untIncProdRelac;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, EditFocus, Vcl.Mask,
  MaskEditFocus, untFuncoesSimples, untTypesSistema, untRelacProdutoFornecedor,
  untFuncoesConsulta;

type
  TfrmIncProdRelac = class(TfrmPaiConfirma)
    Panel3: TPanel;
    cxgProdutos: TcxGridCitel;
    cxvProdutos: TcxGridDBTableViewCitel;
    cxvProdutosColumn1: TcxGridDBColumn;
    cxvProdutosColumn2: TcxGridDBColumn;
    cxvProdutosColumn3: TcxGridDBColumn;
    cxvProdutosColumn4: TcxGridDBColumn;
    cxvProdutosColumn5: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    Panel1: TPanel;
    Label1: TLabel;
    edtCodFor2: TEditFocus;
    edtNomFor2: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    lblFornec: TLabel;
    lbl2: TLabel;
    Label167: TLabel;
    Label4: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtCodMar: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesGru: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    Label5: TLabel;
    edtCodUni: TEditFocus;
    btnExcProd: TBitBtnLocked;
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnExcProdClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    arrMarca,
    arrGruPro,
    arrGruCmp,
    arrFornec,
    arrLinha,
    arrUnidad: TConsultasArray;
  public
    { Public declarations }

    objRelac: TRelacProdutoFornecedor;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmIncProdRelac: TfrmIncProdRelac;

implementation

{$R *.dfm}

Uses
  untConsultas;

function TfrmIncProdRelac.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtGruCmp Then
    Begin

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
End;

procedure TfrmIncProdRelac.btnExcProdClick(Sender: TObject);
begin
  inherited;

  objRelac.pExcluiSelecao;
end;

procedure TfrmIncProdRelac.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');

end;

procedure TfrmIncProdRelac.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmIncProdRelac.edtCodMarExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, nil, 'da Marca');

end;

procedure TfrmIncProdRelac.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmIncProdRelac.edtCodUniExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodUni, Nil, arrUnidad, fRetNomUnidade, nil, 'da Unidade');

end;

procedure TfrmIncProdRelac.edtCodUniKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self,
                  edtCodUni,
                  Nil,
                  Nil,
                  Nil,
                  Key,
                  arrUnidad,
                  False) Then
  Begin
    if fvalidaCampos(edtCodUni,False) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmIncProdRelac.edtGruCmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');

  objRelac.fSelecionaItens(arrMarca, arrUnidad, arrFornec, arrGruPro, arrGruCmp, arrLinha, edtDesIte.Text, edtRefere.Text);
end;

procedure TfrmIncProdRelac.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmIncProdRelac.edtPrdGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGruPro, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);

end;

procedure TfrmIncProdRelac.edtPrdGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGruPro, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmIncProdRelac.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If modalResult = mrOk Then
  Begin

    If Not objRelac.fTransfere(edtCodFor2.Text, edtNomFor2.Text) Then
      Action := caNone;

  End Else
  Begin

    If Not objRelac.cdsSelecao.IsEmpty Then
      If Not fPergunta('Deseja abandonar a tafera?') Then
        Action := caNone;

  End;

end;

procedure TfrmIncProdRelac.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;

end;

procedure TfrmIncProdRelac.FormShow(Sender: TObject);
begin
  inherited;

  objRelac.cdsSelecao.Close;
  cxvProdutos.DataController.DataSource := objRelac.cdsSelecao.dtsSource;
end;

procedure TfrmIncProdRelac.mskLinGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinha, fRetNomeLinhaGrupo, Nil, 'da linha/grupo',6);
end;

procedure TfrmIncProdRelac.mskLinGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, nil, Key, arrLinha) Then
  Begin
    If fvalidaCampos(mskLinGru,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

end.
