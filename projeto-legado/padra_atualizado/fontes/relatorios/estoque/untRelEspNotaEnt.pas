unit untRelEspNotaEnt;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils, Menus,
  QColorLabel, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, AppEvnts,
  untEspelhoNota, untGnre, BitBtnLockedIncrem, ComboBoxFocus,
  untEntFreConLista, untEntVendor, untEntOutrasDespesas,
  frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmRelEspNotaEnt = class(TfrmPaiRelatorio)
    lbl1: TLabel;
    mskDtaIni: TMaskEditFocus;
    lbl2: TLabel;
    lbl3: TLabel;
    mskDtaFin: TMaskEditFocus;
    lbl4: TLabel;
    lbl5: TLabel;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    lbl6: TLabel;
    lbl7: TLabel;
    edtSerie: TEditFocus;
    lbl8: TLabel;
    edtCodFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpb1: TGroupBox;
    ColorLabel2: TColorLabel;
    edtCalc: TEditFocus;
    chkNFTransf: TCheckBox;
    rdgVariacao: TRadioGroup;
    gpbImpMarca: TGroupBox;
    ColorLabel3: TColorLabel;
    edtImpMarca: TEditFocus;
    rdgOrdemProd: TRadioGroup;
    rdgOrdem: TRadioGroup;
    rdgVisualizacao: TRadioGroup;
    chkVariacao: TCheckBox;
    chkQtdCmp: TCheckBox;
    rdgExibirCfop: TRadioGroup;
    GroupBox1: TGroupBox;
    chkPreVen: TCheckBox;
    cmbTabPre: TComboBoxFocus;
    Label1: TLabel;
    cmbComCus: TComboBoxFocus;
    lblTabPreco: TLabel;
    rdgValUni: TRadioGroup;
    edtProdutos: TEditFocus;
    Label3: TLabel;
    edtDesProduto: TEditFocus;
    Label2: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    chkObsCom: TCheckBox;
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure pCarregaEmpresa(Var qryCadEmp: TUniQuery);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgVisualizacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkPreVenClick(Sender: TObject);
    procedure edtCalcChange(Sender: TObject);
    procedure rdgVariacaoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    objEspNota : TEspNota;
    objGNRE    : TGnre;
    blnLotPre,
    blnEntMer,
    blnDevolu  : Boolean;
    strCodPro,
    strCodFor: String;
    strNumDoc: String;
    strEspDoc: String;
    strSerie: String;
    strCndPag: String;
    strDtaEnt: String;
    strDtaDoc: String;
    strCodOpe: String;
    strNomOpe: String;
    strDatIni: String;
    strDatFim: String;
    objLisFre: TFreConLista;
    objVendor: TEntVendor;
    objOutDes: TEntOutrasDespesas;
    arrProduto,
    arrFornec,
    arrGruCmp: TConsultasArray;
    procedure pVerNotaFiscal;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses untFuncoesSimples, untConsultas, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmRelEspNotaEnt.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFornecedor,edtDesFornecedor,arrFornec,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelEspNotaEnt.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEspNotaEnt.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmRelEspNotaEnt.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEspNotaEnt.chkPreVenClick(Sender: TObject);
begin
  inherited;

  cmbComCus.Enabled := chkPreVen.Checked And (rdgVariacao.ItemIndex <> 2);
  cmbTabPre.Enabled := chkPreVen.Checked Or chkQtdCmp.Checked or (rdgVariacao.ItemIndex = 2);

  If (cmbTabPre.Enabled) And
     (cmbTabPre.ItemIndex = -1) And
     (cmbTabPre.Items.Count > 0) Then
  Begin
    cmbTabPre.ItemIndex := 0;
  End;

 (*
  If (Sender = chkPreVen) Then
  Begin
    If chkPreVen.Checked Then
      chkQtdCmp.Checked := not chkPreVen.Checked;
  End
  Else
  Begin
    If chkQtdCmp.Checked Then
      chkPreVen.Checked := not chkQtdCmp.Checked;
  End;
 *)
end;

procedure TfrmRelEspNotaEnt.edtCalcChange(Sender: TObject);
begin
  inherited;
(*  If edtCalc.Text = 'P' Then
    rdgVariacao.Enabled := False
  Else
    rdgVariacao.Enabled := True;
*)    
end;

procedure TfrmRelEspNotaEnt.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;

end;

procedure TfrmRelEspNotaEnt.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEspNotaEnt.pCarregaEmpresa(Var qryCadEmp: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodEmpresa.Text)) Then
    edtDesEmpresa.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString
  Else
    edtDesEmpresa.Text := '';
End;

procedure TfrmRelEspNotaEnt.pVerNotaFiscal;
begin
  objEspNota := TEspNota.Create(Self);
  btnImprimir.Click;
end;

procedure TfrmRelEspNotaEnt.FormShow(Sender: TObject);
begin

  edtEspecie.Text    := 'NF';
  edtEspecie.Enabled := True;

  If (Not blnEntMer) Then
  Begin
    objEspNota := TEspNota.Create(Self);

    mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
    mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
    edtCodEmpresa.Text := VS_strCodEmp;
    edtCodEmpresaExit(Sender);
    If blnLotPre Then
    Begin
      mskDtaIni.Text        := Iif(fEmptyStr(strDatIni), DateToStr(VS_Date), strDatIni);
      mskDtaFin.Text        := Iif(fEmptyStr(strDatFim), DateToStr(VS_Date), strDatFim);
      edtDocumento.Text     := strNumDoc;
      edtEspecie.Text       := strEspDoc;
      edtSerie.Text         := strSerie;
      edtCodFornecedor.Text := strCodFor;
      edtCodEmpresa.Text    := VS_strCodEmp;
      edtCodFornecedorExit(edtCodFornecedor);
      edtCodEmpresaExit(edtCodEmpresa);
    End;


  End
  Else
  Begin
    mskDtaIni.Enabled        := False;
    mskDtaFin.Enabled        := False;
    edtDocumento.Enabled     := False;
    edtEspecie.Enabled       := False;
    edtSerie.Enabled         := False;
    edtCodFornecedor.Enabled := False;
    edtCodEmpresa.Enabled    := False;

    mskDtaIni.Text        := Iif(fEmptyStr(strDatIni), DateToStr(VS_Date), strDatIni);
    mskDtaFin.Text        := Iif(fEmptyStr(strDatFim), DateToStr(VS_Date), strDatFim);
    edtDocumento.Text     := strNumDoc;
    edtEspecie.Text       := strEspDoc;
    edtSerie.Text         := strSerie;
    edtCodFornecedor.Text := strCodFor;
    edtCodEmpresa.Text    := VS_strCodEmp;

    edtCodFornecedorExit(edtCodFornecedor);
    edtCodEmpresaExit(edtCodEmpresa);

    If (edtCalc.CanFocus) Then
      pSetFocus(edtCalc)
    Else
      pSetFocus(rdgVisualizacao);
  End;

  rdgVisualizacao.ItemIndex := 2;

  If (fCfgSis('ATUNMD') = 'I') Then
  Begin
    rdgVariacao.ItemIndex := 1;
  End;

  edtDocumento.TamCampo  := fTamNumDoc();
  edtDocumento.MaxLength := edtDocumento.TamCampo;


  If blnEntMer Then
    rdgVariacao.items.Add('Preço de Últ. Compra + Impostos (Entrada atual) x Preço de Últ. Compra + Impostos (Cadastro Prod.)');

  inherited;
end;

function TfrmRelEspNotaEnt.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtImpMarca) Then
    Begin
      If (Pos(edtImpMarca.Text,'MR') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Imprimir Marca/Referência deve conter M ou R!',['&O K']);
        Result := False;
      End;
    End

    Else
    {***************************************}
    {* VALIDA OPCAO DE CALCULO DA VARIAÇÃO *}
    {************************************LU*}
    If (Sender = edtCalc) Then
    Begin
      If (edtCalc.Text <> 'C') And (edtCalc.Text <> 'P') Then
      Begin
        fMensagem('','O campo Cálculo da Variação deve ter C ou P!',['&O K'],0);
        Result := False;
      End;
    End

    Else If (Sender = cmbTabPre) Then
    Begin
      If (chkPreVen.Checked And fEmptyStr(cmbTabPre.Text)) Or
         (chkQtdCmp.Checked And fEmptyStr(cmbTabPre.Text)) OR
         ((rdgVariacao.ItemIndex = 2) and fEmptyStr(cmbTabPre.Text)) Then
      Begin
        fMensagem('','Selecione uma Tabela de Preço!',['&O K'],0);
        Result := False;
      End;
    End;
    
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelEspNotaEnt.btnImprimirClick(Sender: TObject);
Var
  blnVazia: Boolean;
begin
  inherited;

  Try
    If blnImprime Then
    Begin
      objEspNota.intOpcUnit     := rdgValUni.ItemIndex;
      objEspNota.strDestino     := edtDestino.Text; //3 T
      objEspNota.strTipImp      := strTipImp;
      objEspNota.strNomImp      := strNomImp;
      objEspNota.strImpMarca    := edtImpMarca.Text;
      objEspNota.intVisualiz    := rdgVisualizacao.ItemIndex;
      objEspNota.strTipCalc     := edtCalc.Text; //3 T
      objEspNota.strOrdenar     := IIF(rdgOrdem.ItemIndex = 0, 'D', 'F'); //3 t
      objEspNota.strOrdenarProd := IIF(rdgOrdemProd.ItemIndex = 0, 'G', 'D'); //3 t
      objEspNota.strCodOpe      := strCodOpe;
      objEspNota.strNomOpe      := strNomOpe;
      objEspNota.intOpcVariacao := rdgVariacao.ItemIndex;
      objEspNota.intOpccFOP     := rdgExibirCfop.ItemIndex;
      objEspNota.arrProduto     := arrProduto;
      objEspNota.edtProduto     := edtProdutos;

      // Tratativa para imprimir relatório de espelho de nota com mais de um fornecedor,
      // uma vez que classe TEspNota é utilizada em mais outras 3 units:
      // untCancelamentoDocumentos, untEspelhoNotaDevolucao e untRelEspNotaEntDev
      if Length(arrFornec) > 1 then
      begin
        objEspNota.arrFornec := arrFornec;
        objEspNota.edtFornec := edtCodFornecedor;
      end
      else
      begin
        objEspNota.arrFornec := nil;
        objEspNota.edtFornec := nil;
      end;

      If Length(arrGruCmp) > 1 then
      Begin
        objEspNota.arrGruCmp := arrGruCmp;
        objEspNota.edtGruCmp := edtGruCmp;
      End
      Else
      Begin
        objEspNota.arrGruCmp := nil;
        objEspNota.edtGruCmp := nil;
      End;

      If (Not blnEntMer) Then
      Begin
        blnVazia := objEspNota.fMontaRelEspNotEnt(1,
                                                  mskDtaIni.Text,
                                                  mskDtaFin.Text,
                                                  edtCodEmpresa.Text,
                                                  edtCodFornecedor.Text,
                                                  edtDocumento.Text,
                                                  edtEspecie.Text,
                                                  edtSerie.Text,
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  edtGruCmp.Text,
                                                  True,
                                                  Nil,
                                                  chkNFTransf.Checked,
                                                  False,
                                                  chkPreVen.Checked,
                                                  cmbTabPre.Text,
                                                  Nil,
                                                  Nil,
                                                  Nil,
                                                  chkVariacao.Checked,
                                                  chkQtdCmp.Checked,
                                                  cmbComCus,
                                                  False,
                                                  chkObsCom.Checked);

      End
      Else
      Begin

        blnVazia := objEspNota.fMontaRelEspNotEnt(3,
                                                  '',
                                                  '',
                                                  VS_strCodEmp,
                                                  strCodFor,
                                                  strNumDoc,
                                                  strEspDoc,
                                                  strSerie,
                                                  strCndPag,
                                                  '',
                                                  strDtaEnt,
                                                  strDtaDoc,
                                                  edtGruCmp.Text,
                                                  False,
                                                  objGNRE,
                                                  chkNFTransf.Checked,
                                                  False,
                                                  chkPreVen.Checked,
                                                  cmbTabPre.Text,
                                                  objLisFre,
                                                  objVendor,
                                                  objOutDes,
                                                  chkVariacao.Checked,
                                                  chkQtdCmp.Checked,
                                                  cmbComCus, 
                                                  blnDevolu,
                                                  chkObsCom.Checked);

      End;

      If Not blnVazia Then
      Begin
       pTabelaVazia;
      End;

    End;
  Except
    On E: Exception Do
     Begin
      pMensagensErro(E.Message,'[TfrmRelEspNotaEnt.btnImprimirClick]');
     End;
  End;

  btnImprimir.Enabled := True;

  pSetFocus(mskDtaIni);

end;

procedure TfrmRelEspNotaEnt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

//  If (ActiveControl Is TRadioButton) Then
//    Self.SelectNext(ActiveControl, True, True);

end;

procedure TfrmRelEspNotaEnt.rdgVariacaoClick(Sender: TObject);
begin
  inherited;
  chkPreVenClick(Sender);
  edtCalc.Enabled := rdgVariacao.ItemIndex <> 2;
end;

procedure TfrmRelEspNotaEnt.rdgVisualizacaoClick(Sender: TObject);
begin
  inherited;
  If (rdgVisualizacao.ItemIndex = 2) Then
  Begin
    edtImpMarca.Text    := 'M';
    edtImpMarca.Enabled := False;
  End
  Else
  Begin
    edtImpMarca.Text    := 'R';
    edtImpMarca.Enabled := True;
  End;

end;

procedure TfrmRelEspNotaEnt.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEspNotaEnt.FormCreate(Sender: TObject);
begin
  inherited;
  blnEntMer  := False;
  blnLotPre  := False;
  objGNRE    := Nil;
  cmbTabPre.Items.Clear;
  If Copy(VS_strTabPrc,1,1) = 'S' Then
    cmbTabPre.Items.Add('1');
  If Copy(VS_strTabPrc,2,1) = 'S' Then
    cmbTabPre.Items.Add('2');
  If Copy(VS_strTabPrc,3,1) = 'S' Then
    cmbTabPre.Items.Add('3');
  If Copy(VS_strTabPrc,4,1) = 'S' Then
    cmbTabPre.Items.Add('4');
  If Copy(VS_strTabPrc,5,1) = 'S' Then
    cmbTabPre.Items.Add('5');
  If Copy(VS_strTabPrc,6,1) = 'S' Then
    cmbTabPre.Items.Add('6');
  If Copy(VS_strTabPrc,7,1) = 'S' Then
    cmbTabPre.Items.Add('7');

  pCarregaComposicaoCusto(cmbComCus);
end;

procedure TfrmRelEspNotaEnt.edtProdutosExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtProdutos,edtDesProduto,arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmRelEspNotaEnt.edtProdutosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fvalidaCampos(edtProdutos,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;


end.

