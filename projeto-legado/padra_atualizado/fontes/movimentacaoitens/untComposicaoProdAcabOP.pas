unit untComposicaoProdAcabOP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, MemDS, DBAccess, Uni, untZClient, cxCheckBox, strUtils,
  cxLabel, System.ImageList, Vcl.ImgList,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmComposicaoProdAcabOP = class(TfrmPaiConfirma)
    cxgComposicaoLVL: TcxGridLevel;
    cxgComposicaoTBV: TcxGridDBTableViewCitel;
    cxgComposicao: TcxGridCitel;
    pnlSubProdutos: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    edtReferencia: TEditFocus;
    edtUnidade: TEditFocus;
    edtQtdIte: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    chbImprime: TCheckBox;
    cxgComposicaoTBVODC_IMP_OP: TcxGridDBColumn;
    cxgComposicaoTBVODC_CODITE: TcxGridDBColumn;
    cxgComposicaoTBVDESCRI: TcxGridDBColumn;
    cxgComposicaoTBVREFERE: TcxGridDBColumn;
    cxgComposicaoTBVUNIDAD: TcxGridDBColumn;
    cxgComposicaoTBVODC_QTDITE: TcxGridDBColumn;
    dtsOrdCom: TDataSource;
    pnlProdutoAcabado: TPanel;
    Label1: TLabel;
    edtDesAca: TEditFocus;
    edtCodAca: TEditFocus;
    imgLista: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionarClick(Sender: TObject);
    procedure cxgComposicaoTBVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgComposicaoTBVEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
  private
    qryConIte: TUniQuery;

    oleDataOrdCom : OleVariant;
    procedure pCarregaProduto;
    procedure pLimparDados;
    procedure pCarregaItemAlteracao;
    procedure pApagaItem;
    { Private declarations }
  published
    function fValidaCampos(Sender: TWinControl;
      blnValidaIndividual: Boolean): Boolean; override;
  public
    cdsOrdCom: TZClient;
    strSeqDet: String;

    { Public declarations }
  end;

var
  frmComposicaoProdAcabOP: TfrmComposicaoProdAcabOP;

implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncoesSimples, untPesqAux;

procedure TfrmComposicaoProdAcabOP.btnAdicionarClick(Sender: TObject);
begin
  If Not fVerificaCampos Then
  Begin
    pSetFocus(edtCodIte);
    Exit;
  End;

  if fEmptyStr(edtDesIte.Text) then
  begin
    pMensagemOk('Informe um produto válido!');
    pSetFocus(edtCodIte);
    exit;
  end;

  If not cdsOrdCom.Locate('ODC_CODITE', edtCodIte.Text, []) Then
  Begin
    cdsOrdCom.Insert;
    cdsOrdCom.FieldByName('ODC_SEQDET').AsString := strSeqDet;
    cdsOrdCom.FieldByName('ODC_CODITE').AsString := edtCodIte.Text;
    cdsOrdCom.FieldByName('COMPOSICAO').AsString := edtDesIte.Text;
    cdsOrdCom.FieldByName('REFERENCIA').AsString := edtReferencia.Text;
    cdsOrdCom.FieldByName('SIGUNIDADE').AsString := edtUnidade.Text;
    cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat  := fStrToFloat(edtQtdIte.Text);
    cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat  := 0;
    cdsOrdCom.FieldByName('ODC_VLRCUS').AsFloat  := 0;
    cdsOrdCom.FieldByName('ODC_TOTCUS').AsFloat  := 0;
    cdsOrdCom.FieldByName('ODC_IMP_OP').AsString := IfThen(chbImprime.Checked, 'S', 'N');
    cdsOrdCom.Post;
  End
  Else
  Begin
    cdsOrdCom.Edit;
    cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat   := fStrToFloat(edtQtdIte.Text);
    cdsOrdCom.FieldByName('ODC_IMP_OP').AsString  := IfThen(chbImprime.Checked, 'S', 'N');
    cdsOrdCom.Post;
  End;

  pLimparDados;
  pSetFocus(edtCodIte);
  btnConfirma.Enabled   := True;
  chbImprime.Checked := True;

end;

procedure TfrmComposicaoProdAcabOP.cxgComposicaoTBVEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cxgComposicaoTBVKeyDown(Sender,Key, Shift);
end;

procedure TfrmComposicaoProdAcabOP.cxgComposicaoTBVKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_RETURN: pCarregaItemAlteracao;
    VK_DELETE: pApagaItem;
    VK_ESCAPE: Begin
                 Key := 0;
                 pSetFocus(edtCodIte);
               End;
  End;

end;

procedure TfrmComposicaoProdAcabOP.pApagaItem;
begin
  If (Not cdsOrdCom.IsEmpty) Then
  begin
    if fMensagem('', 'Deseja realmente apagar o item?', ['&Sim', '&Não']) = 1 then
      cdsOrdCom.Delete;
  end;
end;

procedure TfrmComposicaoProdAcabOP.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Try
      //filtra por produto embalagem
      if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1',
                   '',0,False,False,0,cdrCodIte,'',False,'','',True,False,True,'',False, False, True) then
      Begin
        edtReferencia.Text := qryConIte.FieldByName('ITE_REFERE').AsString;
        edtUnidade.Text    := fRetSiglaUni(qryConIte.FieldByName('ITE_CODUNI').AsString);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmComposicaoProdAcabOP.edtCodIteKeyPress]');
      End;
    End;

  End;
end;

procedure TfrmComposicaoProdAcabOP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult <> mrOk Then
  begin
    cdsOrdCom.Data := oleDataOrdCom;
    cdsOrdCom.pSetProvider;
    cdsOrdCom.FieldByName('AUTOINCREM').ProviderFlags := [pfInKey, pfInWhere, pfInUpdate];
    cdsOrdCom.qryQuery.FieldByName('AUTOINCREM').ProviderFlags := [pfInKey, pfInWhere, pfInUpdate];
  end;
end;

procedure TfrmComposicaoProdAcabOP.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  qryConIte := fCriaQuery(Self);
  edtQtdIte.EditFormat := fMskDigitos(4);
  edtQtdIte.Text       := FormatFloat(edtQtdIte.EditFormat, 0);

  If (fCfgSis('MDORIN', varString) <> '6') Then
  Begin
    chbImprime.Visible := False;
    cxgComposicaoTBVODC_IMP_OP.Visible := False;
  End;

end;

procedure TfrmComposicaoProdAcabOP.FormShow(Sender: TObject);
begin
  inherited;
  dtsOrdCom.DataSet := cdsOrdCom;
  oleDataOrdCom := cdsOrdCom.Data;
  (cdsOrdCom.FieldByName('ODC_QTDITE') As TFloatField).DisplayFormat := edtQtdIte.EditFormat;
end;

procedure TfrmComposicaoProdAcabOP.pLimparDados;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtReferencia.Clear;
  edtUnidade.Clear;
  edtQtdIte.Clear;
  edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, 0);
end;

procedure TfrmComposicaoProdAcabOP.pCarregaProduto;
begin
  pPesquisaCadIte(qryConIte, qryConIte, edtCodIte.Text, '', False,False, True, True, False, True);

  edtDesIte.Text     := qryConIte.FieldByName('ITE_DESITE').AsString;
  edtReferencia.Text := qryConIte.FieldByName('ITE_REFERE').AsString;
  edtUnidade.Text    := fRetSiglaUni(qryConIte.FieldByName('ITE_CODUNI').AsString);
end;


function TfrmComposicaoProdAcabOP.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := inherited;

  If (Sender = edtCodIte) Then
  Begin

    If (fEmptyStr(edtCodIte.Text)) Then
      pLimparDados
    Else
    Begin

      If Not fEmptyStr(edtCodIte.Text) Then
        pCarregaProduto;

      If fEmptyStr(edtCodIte.Text) And (Not fEmptyStr(edtDesIte.Text))  Then
      Begin
        fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
        Result := False;
      End;

    End;

  End
  Else
  If (Sender = edtQtdIte) Then
  Begin

    If Not fEmptyStr(edtCodIte.Text) Then
    Begin

      If fEmptyStr(edtQtdIte.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite a quantidade do produto!',['&O K']);
        Result := False;
      End
      Else
      If fStrToFloat(edtQtdIte.Text) <= 0.00 Then
      Begin
        fMensagem('ATENÇÃO','A quantidade do produto deve ser maior que Zero !',['&O K']);
        Result := False;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmComposicaoProdAcabOP.pCarregaItemAlteracao;
begin

  If (Not cdsOrdCom.IsEmpty) Then
  Begin
    edtCodIte.Text     := cdsOrdCom.FieldByName('ODC_CODITE').AsString;
    pCarregaProduto;
    chbImprime.Checked := (cdsOrdCom.FieldByName('ODC_IMP_OP').AsString = 'S');

    edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat);
  End;

  pSetFocus(edtCodIte);
end;

end.
