unit untCadBocaCaixa;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, DBGridCitel, DBGrids, Mask, MaskEditFocus, EditFocus, CheckLst, DB, Uni, UniClientDataSet,
  untBocaCaixa, AppEvnts, BitBtnLockedIncrem, Grids, frxClass,
  frxExportCSVTestabilidade, untTypesSistema;
type
  TfrmCadBocaCaixa = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlDadosItem: TPanel;
    Label4: TLabel;
    lblComiss: TLabel;
    lblTitCom: TLabel;
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
    dbgItens: TDBGridCitel;
    clbEmpresa: TCheckListBox;
    dtsBcaCai: TDataSource;
    btnDelIte: TBitBtnLocked;
    btnExcluirVarias: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    chkLimparCampos: TCheckBox;
    lblOpSele: TLabel;
    popOpSele: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    N1: TMenuItem;
    InverterSeleo1: TMenuItem;
    btnImportarPlanilha: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtDescriIniExit(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure clbEmpresaExit(Sender: TObject);
    procedure clbEmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnDelIteClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirVariasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
    procedure lblOpSeleClick(Sender: TObject);
    procedure pOpcaoSelecao(strOpcao: Char);
    procedure dbgItensEnter(Sender: TObject);
    procedure dbgItensExit(Sender: TObject);
    procedure btnImportarPlanilhaClick(Sender: TObject);
  private
    { Private declarations }
    objBcaCai: TBcaCai; // cria um objeto da Classe TBcaCai - untBocaCaixa
    qryCadUni: TUniQuery;
    strOpcCom: String;
    procedure pGravar;
  protected
    procedure pEscapePressed; override;
    procedure pInicializaIndices; override;
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  public
    { Public declarations }
    arrLinGru,
    arrCodPro,
    arrCodMar,
    arrCodFor: TConsultasArray;

    strEmpSel : String;
    strOperac : String;
    procedure pLimpaComponentes; // Limpa os componentes da tela
    procedure pCarregaGrupo(Var qryCadGru: TUniQuery);
    procedure pCarregaEmpresa;
    procedure pAtualizaLst;
    procedure pSelecionaLst; // seleciona todas as empresas da lista
  end;


implementation

uses SysUtils, StrUtils, untfuncoesSimples, untPai, untConsultas, untExcBocaCaixa,
  untFuncoesConsulta, untGravando, untImportarPlanilhaBocaCaixa;

{$R *.dfm}

function TfrmCadBocaCaixa.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtPreMin) Then
  Begin
    If fStrToFloat(edtPreMin.Text) < 0 Then
    Begin
      fMensagem('','O Campo Preço Mínimo deve ser maior que zero!',['&OK']);
      Result := False;
    End;
  End

  Else If (Sender = edtComVar) Then
  Begin
    If fStrToFloat(edtComVar.Text) < 0 Then
    Begin
      fMensagem('','O Campo Comissão deve ser maior que zero!',['&OK']);
      Result := False;
    End
    Else If (strOpcCom = '%') And (fStrToFloat(edtComVar.Text) > 100.0000) Then
    Begin
      fMensagem('','O Percentual da Comissão não deve ultrapassar 100.0000 %', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtUnidade) Then
  Begin
    If (not fEmptyStr(edtUnidade.Text)) and (fEmptyStr(fRetNomUnidade(edtUnidade.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadBocaCaixa.pOpcaoSelecao(strOpcao: Char);
Var
   intIndex  : Integer;

begin
  // strOpcao
  // S - Marcar Todos
  // N - Desmarcar Todos
  // I - Inverter Seleção;

  if strOpcao = 'S' then
  begin
    for intIndex := 0 to clbEmpresa.Count -1 do
      clbEmpresa.Checked[intIndex] := true;
  end
  else if strOpcao = 'N' then
  begin
    for intIndex := 0 to clbEmpresa.Count -1 do
       clbEmpresa.Checked[intIndex] := false;
  end
  else if strOpcao = 'I' then
  begin
     for intIndex := 0 to clbEmpresa.Count -1 do
       if clbEmpresa.Checked[intIndex] then
         clbEmpresa.Checked[intIndex] := false
       else
         clbEmpresa.Checked[intIndex] := true;
  end;
end;

procedure TfrmCadBocaCaixa.InverterSeleo1Click(Sender: TObject);
begin
  inherited;
   pOpcaoSelecao('I');
end;

procedure TfrmCadBocaCaixa.lblOpSeleClick(Sender: TObject);
  Var
    intQtdSel : Integer;
    curPos    : TPoint;
    intIndex  : Integer;

begin
  inherited;
  intQtdSel := 0;
  if not btnGravar.Enabled then
    exit;
  for intIndex := 0 to clbEmpresa.Count -1 do
  begin
      if clbEmpresa.Checked[intIndex] then
      begin
          intQtdSel :=  intQtdSel + 1;
      end;
  end;

  MarcarTodos1.Enabled    := (intQtdSel < clbEmpresa.Count);
  DesmarcarTodos1.Enabled := (intQtdSel > 0);

  GetCursorPos(curPos);
  popOpSele.Popup(curPos.X + 2, curPos.Y + 2);
end;

procedure TfrmCadBocaCaixa.MarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pOpcaoSelecao('S');
end;


procedure TfrmCadBocaCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objBcaCai);
  FreeAndNil(qryCadUni);
end;

procedure TfrmCadBocaCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  objBcaCai := TBcaCai.Create(Self);

  dtsBcaCai.DataSet := objBcaCai.cdsBcaCai;
  dbgItens.DataSource := dtsBcaCai;

  strNomeTabela := 'CADBCA';
  strNomeCampo  := 'BCA_CODITE';
  qryTabela     := objBcaCai.qryBcaCai;
  qryCadUni     := fCriaQuery(Self);

  SetLength(arrCamposChave, 1);
end;

procedure TfrmCadBocaCaixa.pLimpaComponentes;
Var
  intContador : Integer;
Begin
  For intContador := 0 To Self.ComponentCount - 1 Do
  Begin
    If Components[intContador] is TMaskEdit Then
      TMaskEdit(Self.Components[intContador]).Clear;
    If Components[intContador] is TEditFocus Then
      TEditFocus(Self.Components[intContador]).Clear;
  End;

  arrLinGru := nil;
  arrCodPro := nil;
  arrCodMar := nil;
  arrCodFor := nil;

End;

procedure TfrmCadBocaCaixa.pInicializaIndices;
begin
  inherited;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('ITE_DESITE');
  stlCamInd.Add('BCA_CODITE');
  stlCamInd.Add('BCA_CODEMP+ITE_DESITE');
  stlCamInd.Add('BCA_CODEMP+BCA_CODITE');
  stlCamInd.Add('C.ITE_CODGRU+ITE_DESITE');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
  stlDesInd.Add('Empresa/Descrição');
  stlDesInd.Add('Empresa/Código');
  stlDesInd.Add('Grupo/Descrição');
end;

procedure TfrmCadBocaCaixa.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlDadosItem) Then
  Begin
    pnlDadosItem.Enabled := False;
    dbgItens.Enabled     := False;
  End
  Else
    inherited;
end;

procedure TfrmCadBocaCaixa.pCarregaGrupo(Var qryCadGru: TUniQuery);
Begin
  If Not (fEmptyStr(mskLinhaGrupo.Text)) Then
    edtDesGrupo.Text := qryCadGru.FieldByName('GRU_DESGRU').AsString
  Else
    edtDesGrupo.Text := '';

End;

procedure TfrmCadBocaCaixa.mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
begin

  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadBocaCaixa.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo, edtDesGrupo, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmCadBocaCaixa.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin

  inherited;
  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrCodPro, False, nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadBocaCaixa.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtDesIte, arrCodPro, nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmCadBocaCaixa.edtMarcaKeyPress(Sender: TObject; var Key: Char);
begin

  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrCodMar, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadBocaCaixa.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca, edtDesMarca, arrCodMar, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmCadBocaCaixa.edtFornecedorKeyPress(Sender: TObject; var Key: Char);
begin

  inherited;

  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrCodFor, False) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadBocaCaixa.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrCodFor, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmCadBocaCaixa.edtDescriIniExit(Sender: TObject);
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

procedure TfrmCadBocaCaixa.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
var
  chrKey: Char;
  arrUnidades: TConsultasArray;
  
begin
  inherited;

  {*****************************}
  {* NOVA CONSULTA DE UNIDADES *}
  {**************************AC*}
  chrKey := Key;
  if fPesqUnidade(Self, edtUnidade, Nil, Nil, qryCadUni, chrKey, arrUnidades) then
  begin
    If fValidaCampos(edtUnidade, True) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmCadBocaCaixa.pCarregaEmpresa;
Var
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen, SQL Do
    Begin
      clbEmpresa.Items.Clear;
      Clear;
      Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP');
      Open;
      First;
      While Not Eof Do
      Begin
        clbEmpresa.Items.Add(FieldByName('EMPNOM').AsString);
        Next;
      End;
      Close;
    End;

    pSelecionaLst;

  Finally
    FreeAndNil(qryGen);
  End;

End;

procedure TfrmCadBocaCaixa.pSelecionaLst;
Var
  intContador : Integer;
Begin
  {********************************}
  {* SELECIONA TODAS AS EMPRESAS  *}
  {*****************************LU*}
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    clbEmpresa.Checked[intContador] := True;
  End;
End;

procedure TfrmCadBocaCaixa.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaEmpresa;
  clbEmpresa.Enabled    := False;
  mskLinhaGrupo.Enabled := False;

  objBcaCai.pCriaTemporaria;

  strOpcCom := fCfgSis('COMBCA', varString);

  If (strOpcCom = '%') Then
  Begin

    lblComiss.Caption := '( ' +  strOpcCom + ' ) ' + lblComiss.Caption;
    dbgItens.Columns[7].Title.Caption := strOpcCom + dbgItens.Columns[7].Title.Caption;  
  End
  Else
  Begin
    lblComiss.Caption := 'Valor da ' + lblComiss.Caption;
  end;

  pSetaCodIte( edtCodIte );

end;

procedure TfrmCadBocaCaixa.clbEmpresaExit(Sender: TObject);
Var
  intContador : Integer;
begin
  inherited;
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If clbEmpresa.Checked[intContador] Then
      exit;
  End;
  fMensagem('AVISO','Selecionar ao menos uma empresa para a promoção.', ['&O K']);
  pSetFocus(clbEmpresa);
end;

procedure TfrmCadBocaCaixa.clbEmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
    SelectNext(ActiveControl,True,True);
end;

procedure TfrmCadBocaCaixa.btnImportarPlanilhaClick(Sender: TObject);
var
  frmImportarPlanilha : TfrmImportarPlanilhaBocaCaixa;
begin
  inherited;
  pCriarFormularios(TfrmImportarPlanilhaBocaCaixa, frmImportarPlanilha);

  Try
    frmImportarPlanilha.cdsFormBocaCaixa := objBcaCai.cdsBcaCai;

    if frmImportarPlanilha.ShowModal = mrOk then
    begin
      dbgItens.Enabled := True;
      dbgItens.Refresh;
    end;
  Finally
    pFreeAndNil(frmImportarPlanilha);
  End;
end;

procedure TfrmCadBocaCaixa.btnIncluirClick(Sender: TObject);
begin
  inherited;
  strOperac := 'I';
  clbEmpresa.Enabled    := True;
  mskLinhaGrupo.Enabled := True;
  pSelecionaLst;
  objBcaCai.cdsBcaCai.EmptyDataSet;
  pnlDadosItem.Enabled := True;
  pLimpaComponentes;
  If qryTabela.State = dsInsert Then
    pSetFocus(mskLinhaGrupo);
  edtPreMin.Text := '0,00';
  edtComVar.Text := '0,00';
end;

procedure TfrmCadBocaCaixa.btnPesquisaClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrKey : Char;

begin

  chrKey := '/';

  If fPesqBocaCx(Self, qryTabela, chrKey, arrSel) Then
  Begin
    pLimpaComponentes;
    objBcaCai.cdsBcaCai.EmptyDataSet;
    objBcaCai.strCodPro := qryTabela.fieldbyname('BCA_CODITE').AsString;
    objBcaCai.strCodEmp := qryTabela.fieldbyname('BCA_CODEMP').AsString;
    objBcaCai.strDtaCad := qryTabela.fieldbyname('BCA_DTACAD').AsString;
    pAtualizaLst;
    objBcaCai.pAdicionaItem('A',
                            mskLinhaGrupo,
                            edtCodIte,
                            edtMarca,
                            edtFornecedor);

    pSetFocus(btnAlterar);
  End
  Else
  Begin
    pLimpaComponentes;
    pSelecionaLst;
    objBcaCai.cdsBcaCai.EmptyDataSet;
    pSetFocus(btnIncluir);
  End;

end;

procedure TfrmCadBocaCaixa.btnAlterarClick(Sender: TObject);
begin
  If Not objBcaCai.cdsBcaCai.IsEmpty Then
  Begin
    inherited;
    If qryTabela.State = dsEdit Then
    Begin
      clbEmpresa.Enabled    := True;
      dbgItens.Enabled := True;
      pnlDadosItem.Enabled := True;
      edtCodIte.Text := objBcaCai.cdsBcaCai.fieldbyname('CODITE').AsString;
      edtDesIte.Text := objBcaCai.cdsBcaCai.fieldbyname('DESITE').AsString;
      edtPreMin.Text := FormatFloat('#.#,0',objBcaCai.cdsBcaCai.fieldbyname('PREMIN').Asfloat);
      edtComVar.Text := FormatFloat('#.#,0',objBcaCai.cdsBcaCai.fieldbyname('COMVAR').AsFloat);
      edtCodIte.Enabled := False;
      edtDesIte.Enabled := False;
      strOperac := 'A';
      pSetFocus(edtPreMin);
    End;
  End
  Else
  Begin
    fMensagem('','Não há itens para serem alterados!',['&O K'],0);
    Exit;
  End;
end;

procedure TfrmCadBocaCaixa.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  if chkLimparCampos.Checked then
  begin
    pLimpaComponentes;
    edtPreMin.Text := '0,00';
    edtComVar.Text := '0,00';
  end;

  If strOperac <> 'I' Then
    pSelecionaLst;

  If (pnlDadosItem.Enabled) Then
    pSetFocus(mskLinhaGrupo);

end;

procedure TfrmCadBocaCaixa.btnConfirmarClick(Sender: TObject);
begin

  inherited;

  If fVerificaCampos Then
  Begin

    Try

      objBcaCai.strCodGru := mskLinhaGrupo.Text;
      objBcaCai.strCodPro := edtCodIte.Text;
      objBcaCai.strCodMar := edtMarca.Text;
      objBcaCai.strCodFor := edtFornecedor.Text;

      objBcaCai.strCodUni := edtUnidade.Text;
      objBcaCai.strDesIni := edtDescriIni.Text;
      objBcaCai.strDesFin := edtDescriFin.Text;
      objBcaCai.strRefere := edtRefere.Text;
      objBcaCai.strPreMin := edtPreMin.Text;
      objBcaCai.strComVar := edtComVar.Text;

      {Arrays para as funções de Multi-Seleção}
      objBcaCai.arrLinGru := arrLinGru;
      objBcaCai.arrCodPro := arrCodPro;
      objBcaCai.arrCodMar := arrCodMar;
      objBcaCai.arrCodFor := arrCodFor;

      If strOperac <> 'A' Then
      Begin
        objBcaCai.cdsBcaCai.DisableControls;
        pnlInfo.Caption := 'Aguarde inclusão dos itens...';
        objBcaCai.pAdicionaItem('G',
                                mskLinhaGrupo,
                                edtCodIte,
                                edtMarca,
                                edtFornecedor);
        pnlInfo.Caption := '';
        objBcaCai.cdsBcaCai.EnableControls;
      End
      Else
      Begin
        objBcaCai.cdsBcaCai.Edit;
        objBcaCai.cdsBcaCai.FieldByName('PREMIN').AsFloat  := fStrToFloat(edtPreMin.text);
        objBcaCai.cdsBcaCai.FieldByName('COMVAR').AsFloat  := fStrToFloat(edtComVar.text);
        objBcaCai.cdsBcaCai.Post;
      End;

    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;

    objBcaCai.strCodGru := EmptyStr;
    objBcaCai.strCodPro := EmptyStr;
    objBcaCai.strCodMar := EmptyStr;
    objBcaCai.strCodFor := EmptyStr;
    objBcaCai.strCodUni := EmptyStr;
    objBcaCai.strDesIni := EmptyStr;
    objBcaCai.strDesFin := EmptyStr;
    objBcaCai.strRefere := EmptyStr;
    objBcaCai.strPreMin := EmptyStr;
    objBcaCai.strComVar := EmptyStr;

    dbgItens.Enabled := True;
    dbgItens.Refresh;

    If strOperac <> 'A' Then
      btnCancelaItem.Click
    Else
      pSetFocus(btnGravar);

  End;

end;

procedure TfrmCadBocaCaixa.btnCancelaClick(Sender: TObject);
begin
  qryTabela.Insert;
  inherited;
  objBcaCai.cdsBcaCai.EmptyDataSet;
  pLimpaComponentes;
  pSelecionaLst;
  pnlDadosItem.Enabled  := False;
  dbgItens.Enabled      := False;
  clbEmpresa.Enabled    := False;
  mskLinhaGrupo.Enabled := False;
end;

procedure TfrmCadBocaCaixa.btnGravarClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModalA(pGravar, 'Aguarde... Gravando boca de caixa.', '');
end;

procedure TfrmCadBocaCaixa.pGravar;
Var
  intContador: Integer;
  strEmpresa : String;
begin
  pnlInfo.Caption := 'Gravando registro! Aguarde....';
  pnlInfo.Repaint;

  If Not Assigned(objBcaCai.cdsBcaCai) Then
  Begin
    fMensagem('','Não há itens para serem inclusos!',['&O K'],0);
    Exit;
  End
  Else
  Begin
    Try
      fStartTransaction;
      objBcaCai.cdsBcaCai.DisableControls;
      {*********************************************************}
      {* INCLUI OS ITENS DO GRID PARA CADA EMPRESA SELECIONADA *}
      {******************************************************LU*}
      For intContador := 0 To clbEmpresa.Items.Count -1 Do
      Begin
        strEmpresa := LeftStr(clbEmpresa.Items[intContador],3);
        If clbEmpresa.Checked[intContador] Then
          objBcaCai.pGravaBcaCaixa(strEmpresa)
        Else
          objBcaCai.pGravaBcaCaixa(strEmpresa, True)
      End;
      objBcaCai.cdsBcaCai.EnableControls;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[btnGravarClick]');
      End;
    End;

    pnlDadosItem.Enabled := False;
    qryTabela.Cancel;
    pSetButton(qryTabela, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisa, btnSair);
    pEnabled(Self, False);
    clbEmpresa.Enabled    := False;
    mskLinhaGrupo.Enabled := False;
  End;

  pnlInfo.Caption := '';
end;

procedure TfrmCadBocaCaixa.pAtualizaLst;
Var
  intContador: Integer;
  intFocus   : Integer;
  qryEmpresas: TUniQuery;
  strCodEmp  : String;
begin
  intFocus := -1;
  strEmpSel := qryTabela.fieldbyname('BCA_CODEMP').AsString;

  qryEmpresas := fCriaQuery;
  try
    qryEmpresas.SQL.Add('SELECT BCA_CODEMP');
    qryEmpresas.SQL.Add('FROM CADBCA');
    qryEmpresas.SQL.Add('WHERE BCA_CODITE = :CODITE');
    qryEmpresas.SQL.Add('  AND BCA_DTACAD = :DTACAD');
    qryEmpresas.SQL.Add('  AND BCA_PREMIN = :PREMIN');
    qryEmpresas.SQL.Add('  AND BCA_COMVAR = :COMVAR');

    qryEmpresas.ParamByName('CODITE').AsString := qryTabela.fieldbyname('BCA_CODITE').AsString;
    qryEmpresas.ParamByName('DTACAD').AsDateTime := qryTabela.fieldbyname('BCA_DTACAD').AsDateTime;
    qryEmpresas.ParamByName('PREMIN').AsFloat := qryTabela.fieldbyname('BCA_PREMIN').AsFloat;
    qryEmpresas.ParamByName('COMVAR').AsFloat := qryTabela.fieldbyname('BCA_COMVAR').AsFloat;
    qryEmpresas.Open;

    For intContador := 0 To clbEmpresa.Items.Count -1 Do
    Begin
      strCodEmp := LeftStr(clbEmpresa.Items[intContador],3);

      If strCodEmp = strEmpSel Then
      Begin
        intFocus := intContador;
        clbEmpresa.Checked[intContador] := True;
      End
      Else
      If qryEmpresas.Locate('BCA_CODEMP', strCodEmp, []) then
        clbEmpresa.Checked[intContador] := True
      Else
        clbEmpresa.Checked[intContador] := False;
    End;
  finally
    FreeAndNil(qryEmpresas);
  end;

  clbEmpresa.ItemIndex := intFocus;
end;

procedure TfrmCadBocaCaixa.btnExcluirClick(Sender: TObject);
begin
  If Not objBcaCai.cdsBcaCai.IsEmpty Then
  Begin
    If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
    Begin
      objBcaCai.pDeletaItem(objBcaCai.cdsBcaCai.fieldbyname('CODITE').AsString, strEmpSel);
      objBcaCai.cdsBcaCai.EmptyDataSet;
      pLimpaComponentes;
      pSelecionaLst;
      pSetFocus(btnPesquisa);
    End;
  End
  Else
  Begin
    fMensagem('','Não há Boca de Caixa para serem excluída!',['&O K'],0);
    Exit;
  End;
end;

procedure TfrmCadBocaCaixa.btnDelIteClick(Sender: TObject);
begin
  inherited;
  If (Not objBcaCai.cdsBcaCai.IsEmpty) Then
  Begin
    If (fMensagem('AVISO', 'Confirma a exclusão do item?', ['&Sim', '&Não']) = 1) Then
    Begin
      objBcaCai.cdsBcaCai.Delete;
    End;
  End
  Else
  Begin
    fMensagem('','Não há Itens para serem excluídos!',['&O K'],0);
    Exit;
  End;
end;

procedure TfrmCadBocaCaixa.dbgItensEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'Para selecionar os registros do Grid, utilize CTRL + Click';
end;

procedure TfrmCadBocaCaixa.dbgItensExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadBocaCaixa.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE : btnDelIte.Click;
    VK_F11    : btnExcluirVarias.Click;
  End;

end;

procedure TfrmCadBocaCaixa.DesmarcarTodos1Click(Sender: TObject);
begin
  inherited;
   pOpcaoSelecao('N');
end;

procedure TfrmCadBocaCaixa.btnExcluirVariasClick(Sender: TObject);
Var
  qryAux, qryAuxLog: TUniQuery;
  intLinha: integer;
begin

  If fMensagem('', 'Excluir Várias de ... ', ['&Grid', '&Boca de Caixa'], 2) = 1 Then
  Begin

    If (fMensagem('AVISO', 'Confirma a exclusão dos itens selecionados no Grid?', ['&Sim', '&Não']) = 1) Then
    Begin

      If (Not objBcaCai.cdsBcaCai.IsEmpty) Then
      Begin

        objBcaCai.cdsBcaCai.DisableControls;
        objBcaCai.cdsBcaCai.First;

        For intLinha := 0 to dbgItens.SelectedRows.Count - 1 do
        Begin
          objBcaCai.cdsBcaCai.GotoBookMark(Pointer(dbgItens.SelectedRows.Items[intLinha]));
          objBcaCai.cdsBcaCai.Delete;
        End;

        objBcaCai.cdsBcaCai.First;
        objBcaCai.cdsBcaCai.EnableControls;

      End
      Else
      Begin
        fMensagem('','Não há Itens para serem excluídos!',['&O K'],0);
        Exit;
      End;

    End;

  End
  Else
  Begin

    Try
      pCriarFormularios(TfrmExcBocaCaixa, frmExcBocaCaixa);
      frmExcBocaCaixa.Caption := 'Excluir Boca de Caixa';
      frmExcBocaCaixa.ShowModal;
      If (frmExcBocaCaixa.ModalResult = mrOk) Then
      Begin
        qryAux := fCriaQuery(Self);
        qryAuxLog:= fCriaQuery(Self);
        Try
          fStartTransaction;

          qryAuxLog.SQL.Clear;
          qryAuxLog.SQL.Add('SELECT * FROM CADBCA WHERE AUTOINCREM IN (');
          qryAuxLog.SQL.Add(frmExcBocaCaixa.stlListSelecao.CommaText + ')');
          qryAuxLog.Open;
          qryAuxLog.First;

          while not qryAuxLog.Eof do
          begin
            fVerificaIntegridade(Self.Name, 'CADBCA', qryAuxLog, True);
            qryAuxLog.Next;
          end;

          qryAux.SQL.Clear;
          qryAux.SQL.Add('DELETE FROM CADBCA WHERE AUTOINCREM IN (');
          qryAux.SQL.Add(frmExcBocaCaixa.stlListSelecao.CommaText + ')');
          qryAux.ExecSQL;
          fCommit;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
            fRollBack;
          End;
        End;
        FreeAndNil(qryAux);
        FreeAndNil(qryAuxLog);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
        fRollBack;
      End;
    End;
    pFreeAndNil(frmExcBocaCaixa);

  End;
end;

end.

