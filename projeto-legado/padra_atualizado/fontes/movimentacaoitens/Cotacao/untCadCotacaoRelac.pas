unit untCadCotacaoRelac;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ComCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, EditFocus, untFuncoesSimples, untTypesSistema,
  untFuncoesConsulta, untRelacProdutoFornecedor;

type
  TfrmCadCotacaoRelac = class(TfrmPaiConfirma)
    pgcRelac: TPageControl;
    tbsRelPro: TTabSheet;
    tbsRelFor: TTabSheet;
    Panel2: TPanel;
    cxvFornecedores: TcxGridDBTableViewCitel;
    cxgFornecedoresLevel1: TcxGridLevel;
    cxgFornecedores: TcxGridCitel;
    cxgProdutos: TcxGridCitel;
    cxvProdutos: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    cxvFornecedoresColumn1: TcxGridDBColumn;
    cxvFornecedoresColumn2: TcxGridDBColumn;
    cxvProdutosColumn1: TcxGridDBColumn;
    cxvProdutosColumn2: TcxGridDBColumn;
    Panel3: TPanel;
    lblCodIte: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    lblCodFor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    btnIncPro: TBitBtnLocked;
    cxvProdutosColumn3: TcxGridDBColumn;
    cxvProdutosColumn4: TcxGridDBColumn;
    cxvProdutosColumn5: TcxGridDBColumn;
    lblCodFor2: TLabel;
    edtCodFor2: TEditFocus;
    edtNomFor2: TEditFocus;
    Panel1: TPanel;
    btnExcFor: TBitBtnLocked;
    Panel4: TPanel;
    btnExcProd: TBitBtnLocked;
    btnIncLot: TBitBtnLocked;
    Panel5: TPanel;
    rdgTipLay: TRadioGroup;
    lblCodIte2: TLabel;
    edtCodIte2: TEditFocus;
    edtDesIte2: TEditFocus;
    btnIncPro2: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    edtRefere: TEditFocus;
    edtDesMar: TEditFocus;
    edtSigUni: TEditFocus;
    btnPesquisa: TBitBtnLocked;
    lblMarca: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar2: TEditFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFor2Exit(Sender: TObject);
    procedure edtCodFor2KeyPress(Sender: TObject; var Key: Char);
    procedure rdgTipLayClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnIncProClick(Sender: TObject);
    procedure btnExcForClick(Sender: TObject);
    procedure btnExcProdClick(Sender: TObject);
    procedure edtCodIte2Exit(Sender: TObject);
    procedure edtCodIte2KeyPress(Sender: TObject; var Key: Char);
    procedure btnIncPro2Click(Sender: TObject);
    procedure btnIncLotClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
  private
    { Private declarations }

    tlyTipLay: TTipoLayout;

    objRelac: TRelacProdutoFornecedor;

    arrCodIte,
    arrFornec,
    arrMarca_: TConsultasArray;

    Procedure pSalvaDados;

    Procedure pIniciaDados;

    Procedure pHabilitaInclusaoProduto(blnHabilita: Boolean);
    Procedure pHabilitaInclusaoFornecedor(blnHabilita: Boolean);

    Function fVerificaItemMarca(strCodIte, strCodMar: String): Boolean;
    Function fSQLIteMar: String;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadCotacaoRelac: TfrmCadCotacaoRelac;

implementation

{$R *.dfm}

Uses
  Uni,
  untConsultas, untIncProdRelac;

procedure TfrmCadCotacaoRelac.btnExcForClick(Sender: TObject);
begin
  inherited;

  objRelac.pExcluiDado;
end;

procedure TfrmCadCotacaoRelac.btnExcProdClick(Sender: TObject);
begin
  inherited;

  objRelac.pExcluiDado;
end;

procedure TfrmCadCotacaoRelac.btnIncProClick(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodFor.Text) Then
  Begin
    objRelac.pIncluiDado(edtCodIte.Text, edtCodFor.Text, objRelac.qryCadIte.FieldByName('CODMAR').AsString);
    pSetFocus(edtCodFor);
  End;

  edtCodFor.Clear;
  edtNomFor.Clear;
end;

procedure TfrmCadCotacaoRelac.btnPesquisaClick(Sender: TObject);
  Var
    qryPesquisa: TUniQuery;
    arrSel: TConsultasArray;
begin
  inherited;

  qryPesquisa := Nil;

  If fPesqRelacProdutoFornecedor(Self, qryPesquisa, arrSel) Then
  Begin

   Case rdgTipLay.ItemIndex Of
      0: Begin
           edtCodIte.Text := qryPesquisa.FieldByName('REL_CODITE').AsString;

           If fvalidaCampos(edtCodIte, True) Then
             Self.SelectNext(ActiveControl, True, True);
         End;

      1: Begin
           edtCodFor2.Text := qryPesquisa.FieldByName('REL_CODFOR').AsString;

           If fValidaCampos(edtCodFor2, True) Then
             SelectNext(ActiveControl, True, True);
         End;
    End;

    If Assigned(qryPesquisa) Then
      FreeAndNil(qryPesquisa);
  End;

end;

procedure TfrmCadCotacaoRelac.edtCodMarExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMar, edtDesMar2, arrMarca_, fRetNomeMarca, Nil, 'da Marca');
end;

procedure TfrmCadCotacaoRelac.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar2, Nil, Key, arrMarca_, True) Then
  Begin

    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);

  End;
end;

procedure TfrmCadCotacaoRelac.btnIncLotClick(Sender: TObject);
begin
  inherited;

  pCriarFormularios(TfrmIncProdRelac, frmIncProdRelac);

  frmIncProdRelac.edtCodFor2.Text := edtCodFor2.Text;
  frmIncProdRelac.edtNomFor2.Text := edtNomFor2.Text;

//  frmIncProdRelac.edt

  frmIncProdRelac.objRelac := objRelac;

  frmIncProdRelac.ShowModal;

  pFreeAndNil(frmIncProdRelac);
end;

procedure TfrmCadCotacaoRelac.btnIncPro2Click(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodIte2.Text) Then
  Begin
    If (Not fVerificaItemMarca(edtCodIte2.Text, edtCodMar.Text)) Then
    Begin
      pMensagemOk('Permitido apenas produtos da marca ' + fRetNomeMarca(edtCodMar.Text) + '!');
    End
    Else
    Begin
      objRelac.pIncluiDado(edtCodIte2.Text, edtCodFor2.Text, edtCodMar.Text);
    End;

    pSetFocus(edtCodIte2);
  End;

  edtCodIte2.Clear;
  edtDesIte2.Clear;
end;

procedure TfrmCadCotacaoRelac.edtCodFor2Exit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor2, edtNomFor2, arrFornec, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmCadCotacaoRelac.edtCodFor2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor2, edtNomFor2, Nil, Key, arrFornec, True) Then
  Begin

    If fValidaCampos(edtCodFor2, True) Then
      SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmCadCotacaoRelac.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, Nil, 'do Fornecedor');

end;

procedure TfrmCadCotacaoRelac.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If edtCodFor.ReadOnly Then
    Exit;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCotacaoRelac.edtCodIte2Exit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodIte2, edtDesIte2, arrCodIte, nil, fRetNomProduto, 'do Produto');

end;

procedure TfrmCadCotacaoRelac.edtCodIte2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If edtCodIte2.ReadOnly Then
    Exit;

  If fPesqItem(conIteSimples, Self, edtCodIte2, edtDesIte2, nil, Key, arrCodIte, True, nil, 'Consulta de Itens', '1') Then
  Begin
    If fvalidaCampos(edtCodIte2, False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCotacaoRelac.edtCodIteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodIte, edtDesIte, arrCodIte, nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmCadCotacaoRelac.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If edtCodIte.ReadOnly Then
    Exit;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrCodIte, True, nil, 'Consulta de Itens', '1') Then
  Begin

    If fvalidaCampos(edtCodIte, True) Then
      Self.SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmCadCotacaoRelac.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    pSalvaDados;

    Action := caNone;

  End Else
  begin

    If (objRelac.ChangeCount > 0) Or
       ((tlyTipLay = layProduto) And edtCodIte.ReadOnly) Or
       ((tlyTipLay = layFornecedor) And edtCodFor2.ReadOnly) Then
    Begin

      If fPergunta('Deseja abandonar a tarefa?') Then
        pIniciaDados;

      Action := caNone;

    End;

  End;

end;

procedure TfrmCadCotacaoRelac.FormCreate(Sender: TObject);
begin
  inherited;

  objRelac := TRelacProdutoFornecedor.Create(Self);

  cxvFornecedores.DataController.DataSource := objRelac.dtsSource;
  cxvProdutos.DataController.DataSource     := objRelac.dtsSource;
end;

procedure TfrmCadCotacaoRelac.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F5:  If pgcRelac.ActivePage = tbsRelFor Then
              btnIncLot.Click;

    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmCadCotacaoRelac.FormShow(Sender: TObject);
begin
  inherited;

  edtCodIte.TamCampo   := fTamCodIte;
  edtCodIte.MaxLength  := fTamCodIte;

  edtCodIte2.TamCampo  := fTamCodIte;
  edtCodIte2.MaxLength := fTamCodIte;

  edtCodMar.TamCampo   := fTamCodMar;
  edtCodMar.MaxLength  := fTamCodMar;

  rdgTipLayClick(Nil);
end;

procedure TfrmCadCotacaoRelac.rdgTipLayClick(Sender: TObject);
begin
  inherited;

  tbsRelPro.TabVisible := rdgTipLay.ItemIndex = 0;
  tbsRelFor.TabVisible := rdgTipLay.ItemIndex = 1;

  Case rdgTipLay.ItemIndex Of
    0: tlyTipLay := layProduto;
    1: tlyTipLay := layFornecedor;
  End;

  If (objRelac.ChangeCount > 0) Then
  Begin
    If fPergunta('Deseja salvar as alterações?') Then
      objRelac.fSalvaDados;
  End;

  pIniciaDados;

end;

Procedure TfrmCadCotacaoRelac.pSalvaDados;
Begin

  If (objRelac.ChangeCount > 0) Then
  Begin
    If Not fPergunta('Confirma as alterações realizadas?') Then
      Exit;
  End;

  objRelac.fSalvaDados;

  Case rdgTipLay.ItemIndex Of
    0: pHabilitaInclusaoProduto(False);
    1: pHabilitaInclusaoFornecedor(False);
  End;

End;

Procedure TfrmCadCotacaoRelac.pIniciaDados;
Begin

  Case rdgTipLay.ItemIndex Of
    0: pHabilitaInclusaoProduto(False);
    1: pHabilitaInclusaoFornecedor(False);
  End;

End;

Procedure TfrmCadCotacaoRelac.pHabilitaInclusaoProduto(blnHabilita: Boolean);
Begin
  If blnHabilita Then
  Begin
    edtCodIte.ReadOnly    := True;
    edtCodIte.Color       := $00FFDFB8;
    edtCodIte.NormalColor := $00FFDFB8;

    lblCodFor.Enabled  := True;
    edtCodFor.ReadOnly := False;
    btnIncPro.Enabled  := True;

    objRelac.fCarregaDados(tlyTipLay, edtCodIte.Text);
  End Else
  Begin
    objRelac.Close;

    edtCodIte.ReadOnly     := False;
    edtCodIte.Color       := clWhite;
    edtCodIte.NormalColor := clWhite;



    lblCodFor.Enabled  := False;
    edtCodFor.ReadOnly := True;
    btnIncPro.Enabled  := False;

    edtCodIte.Clear;
    edtDesIte.Clear;
    edtCodFor.Clear;
    edtNomFor.Clear;

    edtDesMar.Clear;
    edtRefere.Clear;
    edtSigUni.Clear;

    pSetFocus(edtCodIte);
  End;

  edtCodFor.Clear;
  edtNomFor.Clear;
End;

Procedure TfrmCadCotacaoRelac.pHabilitaInclusaoFornecedor(blnHabilita: Boolean);
Begin
  If blnHabilita Then
  Begin
    edtCodFor2.ReadOnly    := True;
    edtCodFor2.Color       := $00FFDFB8;
    edtCodFor2.NormalColor := $00FFDFB8;

    edtCodMar.ReadOnly     := True;
    edtCodMar.Color        := $00FFDFB8;
    edtCodMar.NormalColor  := $00FFDFB8;

    lblCodIte2.Enabled  := True;
    edtCodIte2.ReadOnly := False;
    btnIncPro2.Enabled  := True;
    btnIncLot.Enabled   := True;

    objRelac.fCarregaDados(tlyTipLay, edtCodFor2.Text, edtCodMar.Text);
  End Else
  Begin
    objRelac.Close;

    edtCodFor2.ReadOnly    := False;
    edtCodFor2.Color       := clWhite;
    edtCodFor2.NormalColor := clWhite;

    edtCodMar.ReadOnly     := False;
    edtCodMar.Color        := clWhite;
    edtCodMar.NormalColor  := clWhite;

    lblCodIte2.Enabled  := False;
    edtCodIte2.ReadOnly := True;
    btnIncPro2.Enabled  := False;
    btnIncLot.Enabled   := False;

    edtCodFor2.Clear;
    edtNomFor2.Clear;
    edtCodMar.Clear;
    edtDesMar2.Clear;
    edtCodIte2.Clear;
    edtDesIte2.Clear;

    pSetFocus(edtCodFor2);
  End;

  edtCodIte2.Clear;
  edtDesIte2.Clear;
End;

function TfrmCadCotacaoRelac.fSQLIteMar: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT *                   ';
  strSQL := strSQL + ' FROM CADITE                ';
  strSQL := strSQL + ' WHERE ITE_CODITE = :CODIGO ';
  strSQL := strSQL + ' AND ITE_CODMAR = :MARCA    ';

  Result := strSQL;
end;

function TfrmCadCotacaoRelac.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtCodIte Then
    Begin

      If blnBuscaPorChave And (Not edtCodIte.ReadOnly) Then
      Begin

        If fEmptyStr(edtCodIte.Text) Then
        Begin
          pMensagemOk('Informe o código do Produto!');
          Result := False;
        End Else
        Begin
          pHabilitaInclusaoProduto(True);

          If objRelac.qryCadIte.IsEmpty Then
          Begin
            edtDesMar.Clear;
            edtRefere.Clear;
            edtSigUni.Clear;
          End Else
          Begin
            edtDesMar.Text := objRelac.qryCadIte.FieldByName('DESMAR').AsString;
            edtRefere.Text := objRelac.qryCadIte.FieldByName('REFERE').AsString;
            edtSigUni.Text := objRelac.qryCadIte.FieldByName('SIGUNI').AsString;
          End;

        End;

      End;

    End

    Else If Sender = edtCodFor2 Then
    Begin

      If blnBuscaPorChave And (Not edtCodFor2.ReadOnly) Then
      Begin

        If fEmptyStr(edtCodFor2.Text) Then
        Begin
          pMensagemOk('Informe o código do Fornecedor!');
          Result := False;
        End

        Else
        Begin

          If (Not fEmptyStr(edtCodMar.Text)) then
          Begin

            pHabilitaInclusaoFornecedor(True);

          End
          Else
          Begin

            Sender := edtCodMar;
            Result := False;

          End;

        End;

      End;

    End

    Else If Sender = edtCodMar Then
    Begin

      If blnBuscaPorChave And (Not edtCodMar.ReadOnly) Then
      Begin

        If fEmptyStr(edtCodMar.Text) Then
        Begin
          pMensagemOk('Informe o código da Marca!');
          Result := False;
        End

        Else
        Begin

          If (Not fEmptyStr(edtCodFor2.Text)) Then
          Begin

            pHabilitaInclusaoFornecedor(True);

          End
          Else
          Begin

            Sender := edtCodFor2;
            Result := False;

          End;

        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

End;

function TfrmCadCotacaoRelac.fVerificaItemMarca(strCodIte,
  strCodMar: String): Boolean;
  Var
    qryIteMar: TUniQuery;
begin
  Result := True;

  Try
    qryIteMar := fCriaQuery(Self);
    qryIteMar.SQL.Text := fSQLIteMar;

    qryIteMar.ParamByName('CODIGO').AsString := strCodIte;
    qryIteMar.ParamByName('MARCA').AsString  := strCodMar;

    qryIteMar.Open;

    If qryIteMar.IsEmpty Then
      Result := False;
  Finally

  End;
end;

end.
