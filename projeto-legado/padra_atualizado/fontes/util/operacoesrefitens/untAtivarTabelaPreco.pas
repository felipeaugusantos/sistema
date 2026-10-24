unit untAtivarTabelaPreco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, ComboBoxFocus, EditFocus, Vcl.Mask,
  MaskEditFocus, QColorLabel, untTypesSistema, untZClient, untAtivaTabelaPreco;

type
  TfrmAtivarTabelaPreco = class(TfrmPaiConfirma)
    pnlFiltro1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label167: TLabel;
    Label14: TLabel;
    Label50: TLabel;
    ColorLabel2: TColorLabel;
    Label31: TLabel;
    Label9: TLabel;
    lblCodGpr: TLabel;
    Label20: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtCodUni: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    rdgTipAltFor: TRadioGroup;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    edtIncPis: TEditFocus;
    rdgEstMin: TRadioGroup;
    cmbGiroEstoque: TComboBoxFocus;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    edtCodGpr: TEditFocus;
    edtDesGpr: TEditFocus;
    edtCodCom: TEditFocus;
    edtDesComp: TEditFocus;
    pnlFiltro2: TPanel;
    Label8: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    ColorLabel1: TColorLabel;
    Label13: TLabel;
    lbl50: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodAbr: TEditFocus;
    edtDesAbr: TEditFocus;
    edtClaIPI: TEditFocus;
    edtStatus: TEditFocus;
    edtExcIpi: TEditFocus;
    edtAbfPis: TEditFocus;
    edtDesPis: TEditFocus;
    edtAbfCof: TEditFocus;
    edtDesCof: TEditFocus;
    pnlTabAtu: TPanel;
    Label11: TLabel;
    edtTabAtu: TEditFocus;
    edtNomAtu: TEditFocus;
    pnlTabPre: TPanel;
    Label22: TLabel;
    Label23: TLabel;
    edtTabPre: TEditFocus;
    edtNomTab: TEditFocus;
    cbxPreVen: TComboBoxFocus;
    chkPreRev: TCheckBox;
    chkMarcaAtiva: TCheckBox;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn6: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewColumn5: TcxGridDBColumn;
    cxgItensMARCADO: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    shpMultSel: TShape;
    pnlCadMon: TPanel;
    lbl1: TLabel;
    edtCodMon: TEditFocus;
    edtDesMon: TEditFocus;
    chkArrMai: TCheckBox;
    edtDecUni: TEditFocus;
    rdgForPrin: TRadioGroup;
    grbGirFor: TGroupBox;
    chkForA: TCheckBox;
    chkForB: TCheckBox;
    chkForC: TCheckBox;
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtDesIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtRefereKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGprExit(Sender: TObject);
    procedure edtCodGprKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMonExit(Sender: TObject);
    procedure edtCodMonKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbrExit(Sender: TObject);
    procedure edtCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure edtAbfPisExit(Sender: TObject);
    procedure edtAbfPisKeyPress(Sender: TObject; var Key: Char);
    procedure edtAbfCofExit(Sender: TObject);
    procedure edtAbfCofKeyPress(Sender: TObject; var Key: Char);
    procedure edtTabAtuKeyPress(Sender: TObject; var Key: Char);
    procedure edtTabPreKeyPress(Sender: TObject; var Key: Char);
    procedure cbxPreVenChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtClaIPIKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodComExit(Sender: TObject);
    procedure edtCodComKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkArrMaiClick(Sender: TObject);
  private
    { Private declarations }
    arrAbfPis,
    arrAbfCof,
    arrLinhaGrupo,
    arrMarca,
    arrFornec,
    arrGrupoPro,
    arrGruCmp,
    arrCodGpr,
    arrCodDep,
    arrCodMon,
    arrCodAbr,
    arrCodUni,
    arrCodCom,
    arrClaIPI : TConsultasArray;

    cdsTabela: TZClient;

    strTabelas: String;

    intPreVen: Integer;

    objAtivaTabela: TAtivaTabelaPreco;

    procedure pCarregaTabelasPreco;
    function fRetListaTabelas: String;
    function fRetOpcForPrin(index: Integer): TopcFornecedorPrincipal;
    procedure pDecideRecalculo;

    Function fVerificaTabelasItens: Boolean;
    Function fVerificaTabelasFornecedores: Boolean;

  public
    { Public declarations }
    HandleOrigin: HWND;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmAtivarTabelaPreco: TfrmAtivarTabelaPreco;

implementation

{$R *.dfm}

Uses
  Uni,
  untFuncoesSimples,
  untConsultas,
  untFuncoesConsulta,
  untSelecionaTabPre,
  untItensDuplicados,
  untFornecDuplicados,
  untAtivaTabelaPrecoItens;

procedure TfrmAtivarTabelaPreco.pDecideRecalculo;
begin
  If fCfgSis('FORCAL', VarString) = 'P' Then
    rdgTipAltFor.ItemIndex := 0  // PRECO DE VENDA
  Else
    rdgTipAltFor.ItemIndex := 1; // MARGEM DE LUCRO
End;

function TfrmAtivarTabelaPreco.fRetListaTabelas: String;
Begin
  Result := '';
  cdsTabela.DisableControls;
  cdsTabela.First;
  While Not cdsTabela.Eof Do
  Begin

    If fEmptyStr(Result) Then
      Result := QuotedStr(cdsTabela.FieldByName('TAB_CODTAB').AsString)
    Else
      Result := Result + ', ' + QuotedStr(cdsTabela.FieldByName('TAB_CODTAB').AsString);

    cdsTabela.Next;
  End;
  cdsTabela.EnableControls;
End;

function TfrmAtivarTabelaPreco.fRetOpcForPrin(
  index: Integer): TopcFornecedorPrincipal;
begin
  case index of
    0 : Result := tocfopSim;
    1 : Result := tocfopNao;
  Else
    Result := tocfopTodos;
  End;
end;

procedure TfrmAtivarTabelaPreco.pCarregaTabelasPreco;
  Var
    intTabPre: Integer;
Begin
  cbxPreVen.Items.Clear;
  cbxPreVen.Items.Add('');
  cbxPreVen.ItemIndex := 0;

  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    If VS_strTabPrc[intTabPre] = 'S' Then
      cbxPreVen.Items.Add(IntToStr(intTabPre));
  End;

End;

procedure TfrmAtivarTabelaPreco.btnConfirmaClick(Sender: TObject);
var strCfgTBOFPC: String;
    strTabelasMsg: String;
    i: integer;
begin
//  inherited;

  If Not fVerificaCampos Then
    Exit;

  If Not fVerificaTabelasFornecedores Then
    Exit;

  If Not fVerificaTabelasItens Then
    Exit;
  strCfgTBOFPC := fCfgSis('TBOFPC');
  For i := 1 To 7 do
  Begin
    If strCfgTBOFPC[i] = 'S' Then
      strTabelasMsg := strTabelasMsg + IntToStr(i) + ',';
  End;

  strTabelasMsg := Copy(strTabelasMsg, 1,Length(strTabelasMsg) -1);
  objAtivaTabela.strTabelaPrecoVenda := 'NNNNNNN';
  objAtivaTabela.strTabelaPrecoVenda[intPreVen] := 'S';
  If (strCfgTBOFPC[StrToInt(cbxPreVen.Text)] = 'S') And
     (rdgForPrin.ItemIndex <> 0) Then
  Begin
    If fMensagem('Atenção', 'O(s) Preço(s) de Venda ' + strTabelasMsg  + ' estão com obrigatoriedade do Fornecedor Principal na ' + #13 +
                 'Configuração: CFG_TBOFPC(Obrigar que a Tabela de Preço do Fornecedor Ativa, ' + #13 +
                 'ou que será Ativada para o Custo, tenha o mesmo Fornecedor da Tabela de Preço, do Fornecedor Principal).' + #13 +
                 'Logo, o Fornecedor Principal será alterado, e as tabelas de preço ['+strTabelasMsg + '] serão ativadas. Deseja prosseguir?',
                 ['&Sim', '&Não'], 1, False, 1, 80, False, 0, False, False, False, 210, 650) <> 1 then
    Begin
      pSetFocus(rdgForPrin);
      Exit;
    End
    Else
      objAtivaTabela.strTabelaPrecoVenda := strCfgTBOFPC;
  End;

  If rdgTipAltFor.ItemIndex = 0 Then
    objAtivaTabela.opCalculo := opcPrecoVenda
  Else
    objAtivaTabela.opCalculo := opcMargem;

  objAtivaTabela.blnAtualizarPrecoRevista := chkPreRev.Checked;
  objAtivaTabela.blnMarcarAtiva           := chkMarcaAtiva.Checked;
  objAtivaTabela.strTabelasPreco          := strTabelas;

  objAtivaTabela.opcFornecedorPrincipal   := fRetOpcForPrin(rdgForPrin.ItemIndex);

  objAtivaTabela.OpcNivGir := [];
  If chkForA.Checked Then
    objAtivaTabela.OpcNivGir := objAtivaTabela.OpcNivGir + [nivGirA];
  If chkForB.Checked Then
    objAtivaTabela.OpcNivGir := objAtivaTabela.OpcNivGir + [nivGirB];
  If chkForC.Checked Then
    objAtivaTabela.OpcNivGir := objAtivaTabela.OpcNivGir + [nivGirC];

  If (rdgTipAltFor.ItemIndex = 0) And (chkArrMai.Checked) Then
    objAtivaTabela.intValArr := StrToIntDef(edtDecUni.Text,0);

  If Not objAtivaTabela.fCarregaDados Then
    Exit;

  If objAtivaTabela.cdsDados.IsEmpty Then
  Begin
    pMensagemOk('Nenhum produto com preço de compra encontrado para as condições informadas!');
    Exit;
  End;

  pCriarFormularios(TfrmAtivaTabelaPrecoItens, frmAtivaTabelaPrecoItens);
  frmAtivaTabelaPrecoItens.objAtivaTabela := objAtivaTabela;
  frmAtivaTabelaPrecoItens.ShowModal;
  FreeAndNil(frmAtivaTabelaPrecoItens);
end;

procedure TfrmAtivarTabelaPreco.cbxPreVenChange(Sender: TObject);
begin
  inherited;

  IntPreVen := StrToIntDef(cbxPreVen.Text, 0);
end;

procedure TfrmAtivarTabelaPreco.chkArrMaiClick(Sender: TObject);
begin
  inherited;
  edtDecUni.Enabled := chkArrMai.Checked;

  If Not edtDecUni.Enabled Then
    edtDecUni.Text := '0'
  Else
    edtDecUni.Text :=  fCfgSis('DECUNI');
end;

procedure TfrmAtivarTabelaPreco.edtAbfCofExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfCof, edtDesCof, arrAbfCof, fRetDesAbfCof, Nil, 'da abreviação de COFINS');
end;

procedure TfrmAtivarTabelaPreco.edtAbfCofKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCofSai(Self, edtAbfCof, edtDesCof, Nil, Key, arrAbfCof, False) Then
    If fValidaCampos(edtAbfCof, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtAbfPisExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfPis, edtDesPis, arrAbfPis, fRetDesAbfPis, Nil, 'da abreviação de PIS');
end;

procedure TfrmAtivarTabelaPreco.edtAbfPisKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPisSai(Self, edtAbfPis, edtDesPis, Nil, Key, arrAbfPis, False) Then
    If fValidaCampos(edtCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtClaIPIKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqClaIPI(Self, edtClaIPI, nil, Key, arrClaIPI,False) Then
    if fValidaCampos(edtClaIPI, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtCodAbrExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAbr, edtDesAbr, arrCodAbr, fRetDesAbfIcm, Nil, 'da Abreviação Fiscal');
end;

procedure TfrmAtivarTabelaPreco.edtCodAbrKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAbrevFiscal(Self, edtCodAbr, edtDesAbr, Nil, Key, arrCodAbr, False) Then
    If fValidaCampos(edtCodAbr, True) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmAtivarTabelaPreco.edtCodComExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCom, edtDesComp, arrCodCom, fRetDescricaoComposicao, nil, 'da Composição');
end;

procedure TfrmAtivarTabelaPreco.edtCodComKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqComposicao(Self,edtCodCom, edtDesComp, Nil, Key, arrCodCom) then
    if fValidaCampos(edtCodCom, True) then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmAtivarTabelaPreco.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrCodDep, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmAtivarTabelaPreco.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmAtivarTabelaPreco.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (Not edtCodFor.ReadOnly) And
     fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtCodGprExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGpr, edtDesGpr,    arrCodGpr, fRetNomeGrupoPrecos, Nil, 'do Grupo de Preço');
end;

procedure TfrmAtivarTabelaPreco.edtCodGprKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoPrecos(Self, edtCodGpr, edtDesGpr, Nil, Key, arrCodGpr, False) Then
    If fValidaCampos(edtCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmAtivarTabelaPreco.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtCodMonExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMon, edtDesMon, arrCodMon, fRetNomMontadora, nil, 'da Montadora');
end;

procedure TfrmAtivarTabelaPreco.edtCodMonKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMontadora(Self, edtCodMon, edtDesMon, Nil, Key, arrCodMon, False) Then
    If fValidaCampos(edtCodMon, True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtCodUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni, nil, arrCodUni ,fRetNomUnidade, Nil, 'da Unidade');
end;

procedure TfrmAtivarTabelaPreco.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtCodUni, nil, nil, nil, Key, arrCodUni, False) Then
    if fValidaCampos(edtCodUni, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtDesIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, nil, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
    pSetFocus(edtRefere);
end;

procedure TfrmAtivarTabelaPreco.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');

end;

procedure TfrmAtivarTabelaPreco.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGrupoPro, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;

procedure TfrmAtivarTabelaPreco.edtPrdGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGrupoPro, False) Then
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtivarTabelaPreco.edtRefereKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryTabela : TUniQuery;
    arrProduto: TConsultasArray;
begin
  inherited;

  qryTabela := fCriaQuery(Self);

  If fPesqItem(conIteSimples, Self, Nil, Nil, qryTabela, Key, arrProduto, True, nil, 'Consulta de Itens', '1') Then
  Begin
    edtRefere.Text := qryTabela.FieldByName('ITE_REFERE').AsString;
    self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryTabela)
end;

procedure TfrmAtivarTabelaPreco.edtTabAtuKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqTabelaPreco(Self, edtTabAtu, edtNomAtu, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtTabAtu, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAtivarTabelaPreco.edtTabPreKeyPress(Sender: TObject;
  var Key: Char);
var
  arrTabPre: TConsultasArray;
Begin
  If fPesqTabelaPreco(Self, edtTabPre, edtNomTab, nil, Key, arrTabPre, True) Then
  Begin
    If fValidaCampos(edtTabPre, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAtivarTabelaPreco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not (fCfgSis('TABPRD', varBoolean)) Then
  Begin
    If fPergunta('Deseja abandonar a tarefa?') Then
    begin
      postMessage(HandleOrigin, WM_CANCELOU_OPE_DLL, 0, 0);
      Application.ProcessMessages;
    End
    Else
      Action := caNone
  End;
end;

procedure TfrmAtivarTabelaPreco.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodAbr.MaxLength := IIf(fCfgSis('USASAN') = 'S', 7, 3);
  blnVerificaCampos := False;

  pDecideRecalculo;
  pCarregaTabelasPreco;

  edtCodFor.ReadOnly  := True;
  edtCodFor.TabStop   := False;
  edtCodFor.Color     := $00FFDFB8;

  objAtivaTabela := TAtivaTabelaPreco.Create(Self);

  cdsTabela := TZClient.Create(Self);
  cxgItensView.DataController.DataSource := cdsTabela.dtsSource;
end;

procedure TfrmAtivarTabelaPreco.mskLinGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinhaGrupo, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmAtivarTabelaPreco.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrLinhaGrupo, False) Then
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmAtivarTabelaPreco.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNomCam: String;
    strMasCam: String;
begin
  strNomCam := '';
  strMasCam := '';
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDesIte) Then
    Begin
    End

    Else If (Sender = edtRefere) Then
    Begin
    End

    Else If (Sender = edtTabAtu) And pnlTabAtu.Visible Then
    Begin

      If Not fEmptyStr(edtTabAtu.Text) Then
      Begin
        edtNomAtu.Text    := fRetNomeTabelaPreco(edtTabAtu.Text);
        If fEmptyStr(edtNomAtu.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Tabela de Preço não econtrada!', ['&O k']);
          Result := False;
        End;
      End

      Else edtNomAtu.Text := 'TODAS';

    End

    Else If (Sender = edtDecUni) Then
    Begin
      if chkArrMai.Checked then
      Begin
        if ( StrToIntDef(edtDecUni.Text,0) < 0 ) Or
           ( StrToIntDef(edtDecUni.Text,0) > fCfgSis('DECUNI', varInteger) ) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO', 'Valor indicado para arredondamento das casas decimais deve ser entre 0 e ' + fCfgSis('DECUNI', varString) + ' !', ['&OK']);
        End;

      End;

    End


    Else If (Sender = edtTabPre) And pnlTabPre.Visible Then
    Begin

      If fEmptyStr(edtTabPre.Text) Then
      Begin

        If cdsTabela.IsEmpty Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o Código da Tabela de Preço!', ['&O k']);
          Result := False;
        End Else
        Begin
          strTabelas := fRetListaTabelas;
          edtNomTab.Clear;
        End;

      End
      Else
      Begin

        edtNomTab.Text    := fRetNomeTabelaPreco(edtTabPre.Text);
        edtCodFor.Text    := fRetCodFornecedorTabelaPreco(edtTabPre.Text);
        edtNomFor.Text    := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtNomTab.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Tabela de Preço não econtrada!', ['&O k']);
          Result := False;
        End

        Else strTabelas := QuotedStr(edtTabPre.Text);

        If Result And cdsTabela.Active Then
          cdsTabela.EmptyDataSet;

      End;

    End

    Else If (Sender = cbxPreVen) And pnlTabPre.Visible Then
    Begin

      If fEmptyStr(cbxPreVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Infome o preço de Venda a ser alterado!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtExcIpi) Then
    Begin
      If Not fEmptyStr(edtExcIpi.Text) Then
        edtExcIpi.Text := fStrZero(edtExcIpi.Text, 3);
    End

    Else If Sender = edtStatus Then
    Begin

      If Pos(edtStatus.Text, 'S_N_T_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Ativo deve ser S, N ou T!', ['&O k']);
        Result := False;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmAtivarTabelaPreco.fVerificaTabelasItens: Boolean;
  Var
    qryTabela: TUniQuery;
    strItens: String;
Begin
  qryTabela := fCriaQuery(Self);

  With qryTabela, SQL Do
  Begin
    Clear;
    Add('SELECT ');
    Add('  F.ITE_CODITE, ');
    Add('  COUNT(*) AS QTDTAB');
    Add('FROM');
    Add('  ITEFOR F ');
    Add('INNER JOIN CADITE C ON C.ITE_CODITE = F.ITE_CODITE AND C.ITE_CODFOR = F.ITE_CODFOR ');
    Add('WHERE ');
    Add('  F.ITE_CODTAB IN (' + strTabelas + ')');
    Add('GROUP BY ');
    Add('  F.ITE_CODITE');
    Add('HAVING QTDTAB > 1');

    Open;

    If IsEmpty Then
    Begin
      Result := True;
    End Else
    Begin
      Result := False;

      strItens := '';

      While Not Eof Do
      Begin
        If fEmptyStr(strItens) Then
          strItens := QuotedStr(FieldByName('ITE_CODITE').AsString)
        Else
          strItens := strItens + ', ' + QuotedStr(FieldByName('ITE_CODITE').AsString);

        Next;
      End;

      Clear;
      Add('SELECT ');
      Add('  C.ITE_CODITE AS CODITE, ');
      Add('  C.ITE_DESITE AS DESITE, ');
      Add('  F.ITE_CODTAB AS CODTAB, ');
      Add('    TAB_NOMTAB AS NOMTAB  ');
      Add('FROM');
      Add('  ITEFOR F ');
      Add('INNER JOIN CADITE C ON C.ITE_CODITE = F.ITE_CODITE');
      Add('INNER JOIN TABPRE   ON   TAB_CODTAB = F.ITE_CODTAB');
      Add('WHERE ');
      Add('  F.ITE_CODITE IN (' + strItens + ') AND ');
      Add('  F.ITE_CODTAB IN (' + strTabelas + ')');

      Open;

      qryTabela.FieldByName('CODITE').Alignment := taCenter;
      qryTabela.FieldByName('CODTAB').Alignment := taCenter;

      pCriarFormularios(TfrmItensDuplicados, frmItensDuplicados);
      frmItensDuplicados.dtsItens.DataSet := qryTabela;
      frmItensDuplicados.ShowModal;
      pFreeAndNil(frmItensDuplicados);
    End;

  End;

  FreeAndNil(qryTabela);
End;

Function TfrmAtivarTabelaPreco.fVerificaTabelasFornecedores: Boolean;
  Var
    qryTabela: TUniQuery;
    strItens: String;
Begin
  qryTabela := fCriaQuery(Self);

  With qryTabela, SQL Do
  Begin
    Clear;
    Add('SELECT ');
    Add('  TAB_CODFOR, ');
    Add('  COUNT(*) AS QTDTAB');
    Add('FROM');
    Add('  TABPRE ');
    Add('WHERE ');
    Add('  TAB_CODTAB IN (' + strTabelas + ')');
    Add('GROUP BY ');
    Add('  TAB_CODFOR');
    Add('HAVING QTDTAB > 1');

    Open;

    If IsEmpty Then
    Begin
      Result := True;
    End Else
    Begin
      Result := False;

      strItens := '';

      While Not Eof Do
      Begin
        If fEmptyStr(strItens) Then
          strItens := QuotedStr(FieldByName('TAB_CODFOR').AsString)
        Else
          strItens := strItens + ', ' + QuotedStr(FieldByName('TAB_CODFOR').AsString);

        Next;
      End;

      Clear;
      Add('SELECT ');
      Add('  TAB_CODTAB AS CODTAB, ');
      Add('  TAB_CODFOR AS CODFOR, ');
      Add('  TAB_NOMTAB AS NOMTAB, ');
      Add('  FOR_NOMFOR AS NOMFOR  ');
      Add('FROM');
      Add('  TABPRE ');
      Add('INNER JOIN CADFOR ON TAB_CODFOR = FOR_CODFOR');
      Add('WHERE ');
      Add('  TAB_CODTAB IN (' + strTabelas + ') AND');
      Add('  TAB_CODFOR IN (' + strItens + ')');

      Open;

      qryTabela.FieldByName('CODTAB').Alignment := taCenter;
      qryTabela.FieldByName('CODFOR').Alignment := taCenter;

      pCriarFormularios(TfrmFornecDuplicados, frmFornecDuplicados);
      frmFornecDuplicados.dtsItens.DataSet := qryTabela;
      frmFornecDuplicados.ShowModal;
      pFreeAndNil(frmFornecDuplicados);
    End;

  End;

  FreeAndNil(qryTabela);
End;

end.
