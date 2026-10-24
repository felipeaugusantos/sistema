unit untRelEstGirEstCompra;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  untExcel, untGeraExcel, Dialogs, StdCtrls, untPaiRelatorio, Menus, RLFilters, RLDraftFilter,
  QColorLabel, EditFocus, Buttons, ExtCtrls, CheckLst, Mask, Uni,
  MaskEditFocus, StrUtils, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, ComObj,untClassPanelCx,
  AppEvnts, BitBtnLockedIncrem {Qt}, untFuncoesFactory, untTypesSistema,
  frxExportCSVTestabilidade, untIFuncoes, ComboBoxFocus, Vcl.ComCtrls, DB,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxCheckBox, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, untIMesesGiro, DateUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRelEstGirEstCompra = class(TfrmPaiRelatorio)
    gpbOrdem: TGroupBox;
    edtOpcao: TEditFocus;
    ColorLabel2: TColorLabel;
    edtUnidade: TEditFocus;
    Label2: TLabel;
    edtDescri: TEditFocus;
    edtRefere: TEditFocus;
    Label1: TLabel;
    lblDescricao: TLabel;
    edtMarca: TEditFocus;
    Label11: TLabel;
    edtFornecedor: TEditFocus;
    Label10: TLabel;
    edtProdutos: TEditFocus;
    Label3: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    Label9: TLabel;
    edtDesGrupo: TEditFocus;
    edtDesProduto: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDesMarca: TEditFocus;
    rdgStatus: TRadioGroup;
    GroupBox4: TGroupBox;
    ColorLabel4: TColorLabel;
    edtFilGir: TEditFocus;
    grbRefere: TGroupBox;
    chkReferencia: TCheckBox;
    dlgExcel: TSaveDialog;
    rdgLocFis: TRadioGroup;
    rdgExibir: TRadioGroup;
    Label5: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    cmbTipRel: TComboBoxFocus;
    Label6: TLabel;
    prgProgresso: TProgressBar;
    pnlMeses: TPanel;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensAno: TcxGridDBColumn;
    cxgItensMES: TcxGridDBColumn;
    cxgItensSEL: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    Panel1: TPanel;
    chkExiAtu: TCheckBox;
    edtGrupoProd: TLabel;
    edtGrpPrd: TEditFocus;
    edtDesGrpPrd: TEditFocus;
    rdgQuebraFornec: TRadioGroup;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoEnter(Sender: TObject);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure pAtualizaLst;
    procedure btnImprimirClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbTipRelChange(Sender: TObject);
    procedure cxgItensSELPropertiesChange(Sender: TObject);
    procedure edtGrpPrdKeyPress(Sender: TObject; var Key: Char);
    procedure edtOpcaoChange(Sender: TObject);
  private
    { Private declarations }
    cdsMeses: IMesesGiro;

    arrGruCmp: TConsultasArray;
    strLinGru            : String;
    arrLinGru            : TConsultasArray;

    qryRelatorio: TUniQuery;
    fltSugest: Double;

    procedure pCriaQryRelatorio;

    procedure pGeraExcel;
    procedure pMontaTitGru(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);

    procedure pGeraExcelNovo;
    Function fRetSigla(dtsDados: TDataSet): String;
    Function fRetSugest(dtsDados: TDataSet): Double;

    Function fRetMedia(dtsDados: TDataSet): Double;


    function fMedia(dtsDados: TDataSet): Double;
  public
    { Public declarations }
    strMes1    : String;
    strMes2    : String;
    strMes3    : String;
    strMes4    : String;

    strAno     : String;
    strAno1    : String;
    strAno2    : String;
    strAno3    : String;
    strAno4    : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelEstGirEstCompra: TfrmRelEstGirEstCompra;

implementation

uses  untQckEstGirEstCompra, untModuloSPR;

{$R *.dfm}

procedure TfrmRelEstGirEstCompra.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo, edtDesGrupo, arrLinGru, fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelEstGirEstCompra.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstGirEstCompra.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
  edtProdutos.Clear;
end;

procedure TfrmRelEstGirEstCompra.edtProdutosExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtProdutos.Text) Then
    edtDesProduto.Text := 'TODOS'
  Else
    edtDesProduto.Text := fRetNomProduto(edtProdutos.Text);


  If fEmptyStr(edtDesProduto.Text) And (Not fEmptyStr(edtProdutos.Text))  Then
  Begin
    fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End;

end;

procedure TfrmRelEstGirEstCompra.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte: TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;
  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    Key := #0;
    Exit;
  End;

  qryGenIte := fCriaQuery(nil);

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
    SelectNext(ActiveControl, True, True);

  FreeAndNil(qryGenIte);

end;

procedure TfrmRelEstGirEstCompra.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtFornecedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtFornecedor.Clear;
    pSetFocus(edtFornecedor);
  End;

end;

procedure TfrmRelEstGirEstCompra.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

{***********************}
{  "GRUPO DE COMPRAS"  *}
{14/08/2012**********CI*}

procedure TfrmRelEstGirEstCompra.edtGrpPrdKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrGrpPrd : TConsultasArray;
begin
  inherited;
  fPesqGrupoProduto(Self, edtGrpPrd, edtDesGrpPrd, nil, key, arrGrpPrd);
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstGirEstCompra.edtGruCmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmRelEstGirEstCompra.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupoCompra(Self, edtGruCmp, Nil, Nil, Key, arrGruCmp) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstGirEstCompra.edtMarcaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := 'TODOS'
  Else
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);


  If fEmptyStr(edtDesMarca.Text) And (Not fEmptyStr(edtMarca.Text))  Then
  Begin
    fMensagem('AVISO','Código da marca não encontrado.', ['&O K']);
    edtMarca.Clear;
    pSetFocus(edtMarca);
  End;

end;

procedure TfrmRelEstGirEstCompra.edtMarcaKeyPress(Sender: TObject;
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

procedure TfrmRelEstGirEstCompra.edtOpcaoChange(Sender: TObject);
begin
  inherited;
  rdgQuebraFornec.Enabled := AnsiMatchStr(edtOpcao.Text, ['A', 'F']) and (cmbTipRel.ItemIndex = 0);
  rdgQuebraFornec.ItemIndex := StrToInt(IfThen(not rdgQuebraFornec.Enabled, '1', IntToStr(rdgQuebraFornec.ItemIndex)));
end;

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmRelEstGirEstCompra.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtOpcao) Then
    Begin
      If (Pos(edtOpcao.Text, 'A_L_F_') <= 0) Then
      Begin
        fMensagem('','O campo opcao deve ter A, L ou F!',['&O K'],0);
        Result := False;
      End;
    End

    Else If Sender = edtGrpPrd Then
    Begin
      If fEmptyStr(edtGrpPrd.Text) Then
        edtDesGrpPrd.Text := 'TODOS'
      Else
        edtDesGrpPrd.Text := fRetNomeGrupoProduto(edtGrpPrd.Text);
    End
    {**************************}
    {* VERIFICA CAMPO DESTINO *}
    {***********************LU*}
    Else If (Sender = edtDestino) Then
    Begin
      If (edtDestino.Text <> 'I') And (edtDestino.Text <> 'V') And (edtDestino.Text <> 'E') Then
      Begin
        fMensagem('','O campo Destino deve ser V, I ou E!',['&O K'],0);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelEstGirEstCompra.pAtualizaLst;
Begin
  cdsMeses := fgetMesesGiro(Self, 3);
  cdsMeses.intQtdMes := 3;
  cdsMeses.pMarcaMesesIniciais;

  cxgItensView.DataController.DataSource := cdsMeses.fGetDataSource;
  cxgItensView.NavigatorButtons.First.Click;
End;

procedure TfrmRelEstGirEstCompra.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelEstGirEstCompra.btnImprimirClick(Sender: TObject);
  Var
    intContador: Integer;
    intMes     : Integer;
    strAno     : String;
    strSQL     : String;
    strSalUti  : String;
begin
  If Not cdsMeses.fValidaMeses(3) Then
  Begin
    fMensagem('','Selecione 3 meses de giro!',['&O K']);
    pSetFocus(cxgItens);
    Exit;
  End;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin
    strSalUti := fCfgSis('SALGIR');

    If fEmptyStr(strSalUti) Then
      strSalUti := 'SALDOS';

    cdsMeses.pMontaDatas;

    strMes4 := fStrZero(IntToStr(MonthOf(VS_Date)), 2);
    strAno4 := IntToStr(YearOf(VS_Date));

    strMes3 := cdsMeses.fStrMes(3);
    strAno3 := cdsMeses.fStrAno(3);

    strMes2 := cdsMeses.fStrMes(2);
    strAno2 := cdsMeses.fStrAno(2);

    strMes1 := cdsMeses.fStrMes(1);
    strAno1 := cdsMeses.fStrAno(1);

    If cdsMeses.fSelecionouMesAtual then
      chkExiAtu.Checked := False;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    If cmbTipRel.ItemIndex = 1 Then
    Begin
      strSQL := strSQL + ' SUM( IFNULL((SELECT SQL_NO_CACHE GIR_QENT' + strMes4 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno4) + '),0)) AS MES004, ';
      strSQL := strSQL + ' SUM( IFNULL((SELECT SQL_NO_CACHE GIR_QENT' + strMes3 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno3) + '),0)) AS MES003, ';
      strSQL := strSQL + ' SUM( IFNULL((SELECT SQL_NO_CACHE GIR_QENT' + strMes2 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno2) + '),0)) AS MES002, ';
      strSQL := strSQL + ' SUM( IFNULL((SELECT SQL_NO_CACHE GIR_QENT' + strMes1 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno1) + '),0)) AS MES001, ';
    End
    Else
    Begin
      strSQL := strSQL + '  I.ITE_CODITE AS CODIGO, ';
      strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
      strSQL := strSQL + '  IFNULL((SELECT SQL_NO_CACHE GIR_QENT' + strMes4 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno4) + '),0) AS MES004, ';
      strSQL := strSQL + '  IFNULL((SELECT SQL_NO_CACHE GIR_QENT' + strMes3 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno3) + '),0) AS MES003, ';
      strSQL := strSQL + '  IFNULL((SELECT SQL_NO_CACHE GIR_QENT' + strMes2 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno2) + '),0) AS MES002, ';
      strSQL := strSQL + '  IFNULL((SELECT SQL_NO_CACHE GIR_QENT' + strMes1 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno1) + '),0) AS MES001, ';
    End;

    If cmbTipRel.ItemIndex = 0 Then
    Begin
      strSQL := strSQL + '  LEFT(I.ITE_CODGRU,3) AS LINHA, ';
      strSQL := strSQL + '  I.ITE_CODGRU AS GRUPO,  ';
      strSQL := strSQL + '  I.ITE_CODITE AS CODIGO, ';
      strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
      strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
      strSQL := strSQL + '  I.ITE_CODUNI AS UNIDAD, ';
      strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
      strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';
      strSQL := strSQL + '  IFNULL(I.ITE_CODFOR, ''00000000'') AS CODFOR, ';

      strSQL := strSQL + '  IFNULL(F.FOR_NOMFOR, ''NÃO CADASTRADO'') AS R_SOCIAL, ';

      strSQL := strSQL + '  IF(G.ITE_' + strSalUti + ' IS NULL, 0, G.ITE_' + strSalUti + ') AS SALDOS, ';

      strSQL := strSQL + '  G.ITE_PRECOM AS PRECOM, ';
      strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS,  ';
      strSQL := strSQL + '  IF(G.ITE_PREULT IS NULL, 0, G.ITE_PREULT) AS PREULT, ';
      strSQL := strSQL + '  G.ITE_DTAULT AS DTAULT, ';
      strSQL := strSQL + '  IF(G.ITE_PREVE1 IS NULL, 0, G.ITE_PREVE1) AS PREVEN, ';
      strSQL := strSQL + '  IF(G.ITE_MARBR1 IS NULL, 0, G.ITE_MARBR1) AS PRELUC  ';
    End
    Else
    begin
      strSQL := strSQL + ' IFNULL(I.ITE_CODFOR, ''00000000'') AS CODFOR, ';
      strSQL := strSQL + ' IFNULL(F.FOR_NOMFOR, ''NÃO CADASTRADO'') AS R_SOCIAL, ';
      strSQL := strSQL + ' ITE_ACOOBJ ';
    end;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
    strSQL := strSQL + '  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
    strSQL := strSQL + '                     AND G.ITE_CODEMP = :CODEMP      ';

    strSQL := strSQL + '  LEFT  JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';

    strSQL := strSQL + 'WHERE TRUE ';

    strSQL := strSQL + fStrLocateLinGru(mskLinhaGrupo, arrLinGru, 'I.ITE_CODGRU', 'CODGRU');

    If (rdgLocFis.ItemIndex = 1) Then
      strSQL := strSQL + '  AND IFNULL(G.ITE_LOCFIS, "") <> "" '
    Else If (rdgLocFis.ItemIndex = 2) Then
      strSQL := strSQL + '  AND IFNULL(G.ITE_LOCFIS, "")  = "" ';

    If Not fEmptyStr(edtFornecedor.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODFOR = :CODFOR ';

    If Not fEmptyStr(edtProdutos.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODITE = :CODITE ';

    If Not fEmptyStr(edtMarca.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODMAR = :CODMAR ';

    {*****************************}
    { FILTRO "GRUPO DE COMPRAS"  *}
    {14/08/2012****************CI*}

    If Not fEmptyStr(edtGruCmp.Text) Then
      strSQL := strSQL + '  AND I.ITE_GRUCMP = :GRUCMP ';

    If Not fEmptyStr(edtDescri.Text) Then
      strSQL := strSQL + '  AND (LOCATE(:DESITE, I.ITE_DESITE) >0 ) ';

    If Not fEmptyStr(edtRefere.Text) Then
      strSQL := strSQL + '  AND I.ITE_REFERE = :REFERE ';

    If Not fEmptyStr(edtUnidade.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODUNI = :CODUNI ';
    If Not fEmpTyStr(edtGrpPrd.Text) Then
      strSQL := strSQL + '  AND I.ITE_PRDGRU = :PRDGRU ';

    {*****************************************}
    { FILTRAR STATUS (ATIVO, INATIVO , TODOS)*}
    { DO PRODUTO                             *}
    {**************************************AF*}
    Case rdgStatus.ItemIndex Of
      0: strSQL := strSQL + ' AND I.ITE_ITEATI = "S" ';
      1: strSQL := strSQL + ' AND I.ITE_ITEATI = "N" ';
    End;

    If cmbTipRel.ItemIndex = 1 Then
      strSQL := strSQL + ' GROUP BY ITE_ACOOBJ ';

    If (edtFilGir.Text = 'C') Then
      strSQL := strSQL + 'HAVING MES001 + MES002 + MES003 + MES004 > 0 '
    Else If (edtFilGir.Text = 'S') Then
      strSQL := strSQL + 'HAVING MES001 + MES002 + MES003 + MES004 <= 0 ';

    strSQL := strSQL + 'ORDER BY ';

    if (rdgQuebraFornec.ItemIndex = 0) and (edtOpcao.Text <> 'F') then
      strSQL := strSQL + '  F.FOR_NOMFOR, I.ITE_CODFOR, ';

    If edtOpcao.Text = 'L' Then
      strSQL := strSQL + '  I.ITE_CODGRU, '
    Else If edtOpcao.Text = 'F' Then
      strSQL := strSQL + '  F.FOR_NOMFOR, I.ITE_CODFOR, ';

    If cmbTipRel.ItemIndex > 0 Then
      strSQL := strSQL + '  ITE_ACOOBJ, ';

    strSQL := strSQL + '  I.ITE_DESITE ';

    With  qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      pSetaParam(mskLinhaGrupo.Text, arrLinGru, strLinGru, 'CODGRU', qryRelatorio);

      If Not fEmptyStr(edtProdutos.Text) Then
        ParamByName('CODITE').AsString := edtProdutos.Text;

      If Not fEmptyStr(edtFornecedor.Text) Then
        ParamByName('CODFOR').AsString := edtFornecedor.Text;

      If Not fEmptyStr(edtMarca.Text) Then
        ParamByName('CODMAR').AsString := edtMarca.Text;

      {*****************************************}
      { PARAMETRO DO FILTRO "GRUPO DE COMPRAS" *}
      {14/08/2012****************************CI*}

      If Not fEmptyStr(edtGruCmp.Text) Then
        ParamByName('GRUCMP').AsString := edtGruCmp.Text;

      If Not fEmptyStr(edtDescri.Text) Then
        ParamByName('DESITE').AsString := edtDescri.Text;

      If Not fEmptyStr(edtRefere.Text) Then
        ParamByName('REFERE').AsString := edtRefere.Text;

      If Not fEmptyStr(edtUnidade.Text) Then
        ParamByName('CODUNI').AsString := edtUnidade.Text;

      If Not fEmptyStr(edtGrpPrd.Text) Then
        ParamByName('PRDGRU').AsString := edtGrpPrd.Text;

      Open;
    End;

    If Not  qryRelatorio.IsEmpty Then
    Begin

      If edtDestino.Text = 'E' Then
        pGeraExcel
      Else
      Begin

        Try
          pCriarFormularios(TfrmQckEstGirEstCompra,frmQckEstGirEstCompra);

          frmQckEstGirEstCompra.dtsRelatorio.DataSet := qryRelatorio;

          frmQckEstGirEstCompra.rlbGrupoFornec.Visible  := (rdgQuebraFornec.ItemIndex = 0) and (cmbTipRel.ItemIndex = 0);
          frmQckEstGirEstCompra.rlbTotaisFornec.Visible := (rdgQuebraFornec.ItemIndex = 0) and (cmbTipRel.ItemIndex = 0);
          frmQckEstGirEstCompra.blnQuebraFornec         := (rdgQuebraFornec.ItemIndex = 0) and (cmbTipRel.ItemIndex = 0);

          {*********************}
          {* HEADER FORNECEDOR *}
          {******************AF*}
          If Not fEmptyStr(edtFornecedor.Text) Then
            frmQckEstGirEstCompra.rllFornecedor.Caption := 'FORNECEDOR: ' + edtFornecedor.Text + ' - ' + edtDesFornecedor.Text
          Else
            frmQckEstGirEstCompra.rllFornecedor.Caption := 'FORNECEDOR: TODOS';

          If Not fEmptyStr(edtGrpPrd.Text) Then
            frmQckEstGirEstCompra.rllGrpPrd.Caption := 'GRUPO DE PRODUTO: ' + edtGrpPrd.Text + ' - ' + edtDesGrpPrd.Text
          Else
            frmQckEstGirEstCompra.rllGrpPrd.Caption := 'GRUPO DE PRODUTO: TODOS';

          {******************}
          {* HEADER PRODUTO *}
          {***************AF*}
          If Not fEmptyStr(edtProdutos.Text) Then
            frmQckEstGirEstCompra.rllProduto.Caption := 'PRODUTO: ' + edtProdutos.Text + ' - ' + edtDesProduto.Text
          Else
            frmQckEstGirEstCompra.rllProduto.Caption := 'PRODUTO: TODOS';

          {******************}
          {* HEADER GRUPO 1 *}
          {***************AF*}
          If Not fEmptyStr(mskLinhaGrupo.Text) Then
            frmQckEstGirEstCompra.rllLinhaGrupo.Caption := 'LINHA/GRUPO: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text
          Else
            frmQckEstGirEstCompra.rllLinhaGrupo.Caption := 'LINHA/GRUPO: TODOS';

          {******************}
          {* HEADER UNIDADE *}
          {***************AF*}
          If Not fEmptyStr(edtUnidade.Text) Then
            frmQckEstGirEstCompra.rllUnidade.Caption := 'UNIDADE: ' + edtUnidade.Text
          Else
            frmQckEstGirEstCompra.rllUnidade.Caption := 'UNIDADE: TODAS';

          {****************}
          {* HEADER MARCA *}
          {*************AF*}
          If Not fEmptyStr(edtMarca.Text) Then
            frmQckEstGirEstCompra.rllMarcaHeader.Caption := 'MARCA: ' + edtMarca.Text + ' - ' + edtDesMarca.Text
          Else
            frmQckEstGirEstCompra.rllMarcaHeader.Caption := 'MARCA: TODAS';

          {***************************}
          {* HEADER GRUPO DE COMPRAS *}
          {14/08/2012**************CI*}
          If Not fEmptyStr(edtGruCmp.Text) Then
            frmQckEstGirEstCompra.rllGruCmp.Caption := 'GRUPO DE COMPRAS: ' + edtGruCmp.Text + ' - ' + edtDesGruCmp.Text
          Else
            frmQckEstGirEstCompra.rllGruCmp.Caption := 'GRUPO DE COMPRAS: TODOS';

          {*****************}
          {* HEADER DESCRI *}
          {**************AF*}
          If Not fEmptyStr(edtDescri.Text) Then
            frmQckEstGirEstCompra.rllDescricao.Caption := 'DESCRICAO: ' + edtDescri.Text
          Else
            frmQckEstGirEstCompra.rllDescricao.Caption := 'DESCRICAO: TODAS';

          {*********************}
          {* HEADER REFERENCIA *}
          {******************AF*}
          If Not fEmptyStr(edtRefere.Text) Then
            frmQckEstGirEstCompra.rllReferencia.Caption := 'REFERENCIA: ' + edtRefere.Text
          Else
            frmQckEstGirEstCompra.rllReferencia.Caption := 'REFERENCIA: TODAS';

          frmQckEstGirEstCompra.strOrdem := 'REFERENTE AO MESES DE: ' + IfThen(chkExiAtu.Checked, strMes4 + '/' + strAno4 + ', ', '') +
                                             strMes3 + '/' + strAno3 + ', ' + strMes2 + '/' + strAno2 + ', ' + strMes1 + '/' + strAno1;

          If Not chkExiAtu.Checked Then
          Begin
            frmQckEstGirEstCompra.rllMes04.Visible          := False;
            frmQckEstGirEstCompra.rdbMes4Grupo.Visible      := False;
            frmQckEstGirEstCompra.rdbMes4AcoObj.Visible     := False;
            frmQckEstGirEstCompra.rdbMes4Alfa.Visible       := False;
            frmQckEstGirEstCompra.rllTotFornecMes04.Visible := False;
          End;

          frmQckEstGirEstCompra.strMes04 := strMes4 + '/' + strAno4;
          frmQckEstGirEstCompra.strMes03 := strMes3 + '/' + strAno3;
          frmQckEstGirEstCompra.strMes02 := strMes2 + '/' + strAno2;
          frmQckEstGirEstCompra.strMes01 := strMes1 + '/' + strAno1;

          {*********************************************}
          {* VERIFICA SE EXIBE A REFERENCIA DO PRODUTO *}
          {******************************************JB*}
          If Not chkReferencia.Checked Then
          Begin
            frmQckEstGirEstCompra.rllDescri.Width      := frmQckEstGirEstCompra.rllDescri.Width       + frmQckEstGirEstCompra.rdbRefereGrupo.Width;
            frmQckEstGirEstCompra.rdbDescriGrupo.Width := frmQckEstGirEstCompra.rdbDescriGrupo.Width  + frmQckEstGirEstCompra.rdbRefereGrupo.Width;
            frmQckEstGirEstCompra.rdbDescriAlfa.Width  := frmQckEstGirEstCompra.rdbDescriAlfa.Width   + frmQckEstGirEstCompra.rdbRefereGrupo.Width;

            frmQckEstGirEstCompra.rllRefere.Visible      := False;
            frmQckEstGirEstCompra.rdbRefereGrupo.Visible := False;
            frmQckEstGirEstCompra.rdbRefereAlfa.Visible  := False;

          End;

          If cmbTipRel.ItemIndex > 0 Then
          Begin
            With frmQckEstGirEstCompra Do
            Begin
              rllLucro.Visible            := False;
              rllValVenda.Visible         := False;
              rllDataUltCom.Visible       := False;
              rllValUltCom.Visible        := False;
              rllSugestao.Visible         := False;
              rllEstoque.Visible          := False;

              rdbPorcLucroGrupo.Visible   := False;
              rdbPreVendaGrupo.Visible    := False;
              rdbDTUltComGrupo.Visible    := False;
              rdbPRUltComGrupo.Visible    := False;
              rllSugestGrupo.Visible      := False;
              rdbSaldosGrupo.Visible      := False;
              rdbPorcLucroGrupo.DataField := EmptyStr;
              rdbPreVendaGrupo.DataField  := EmptyStr;
              rdbDTUltComGrupo.DataField  := EmptyStr;
              rdbPRUltComGrupo.DataField  := EmptyStr;
              rdbSaldosGrupo.DataField    := EmptyStr;

              rdbPorcLucroAlfa.Visible    := False;
              rdbPreVendaAlfa.Visible     := False;
              rdbDTUltComAlfa.Visible     := False;
              rdbPRUltComAlfa.Visible     := False;
              rllSugestAlfa.Visible       := False;
              rdbSaldosAlfa.Visible       := False;
              rdbPorcLucroAlfa.DataField  := EmptyStr;
              rdbPreVendaAlfa.DataField   := EmptyStr;
              rdbDTUltComAlfa.DataField   := EmptyStr;
              rdbPRUltComAlfa.DataField   := EmptyStr;
              rdbSaldosAlfa.DataField     := EmptyStr;

              rllFornec.Visible           := False;
              rllMarca.Visible            := False;
              rllUnidad.Visible           := False;
              rllRefere.Visible           := False;
              rdbCodForAlfa.Visible       := False;
              rdbCodMarAlfa.Visible       := False;
              rdbUnidadeAlfa.Visible      := False;
              rdbRefereAlfa.Visible       := False;
              rdbCodForAlfa.DataField     := EmptyStr;
              rdbCodMarAlfa.DataField     := EmptyStr;
              rdbUnidadeAlfa.DataField    := EmptyStr;
              rdbRefereAlfa.DataField     := EmptyStr;

              rdbCodForGrupo.Visible      := False;
              rdbCodMarGrupo.Visible      := False;
              rdbUnidadeGrupo.Visible     := False;
              rdbRefereGrupo.Visible      := False;

              if cmbTipRel.ItemIndex = 1 Then
              Begin
                frmQckEstGirEstCompra.rllNomeRelatorio.Caption  := 'RELATORIO DO GIRO DE ESTOQUE - COMPRA - SINTÉTICO POR A.O.';
                rlbDetalhe.Visible := True;
                rlbResumo.Borders.DrawTop := True;

                rdbDescriAlfa.DataField := 'ITE_ACOOBJ';
                rdbCodigoAlfa.DataField := EmptyStr;

                rllDescri.Caption := 'ACORDO DE OBJETIVOS';
                rllCodigo.Visible := False;

                rdbDescriAlfa.Left := rdbCodigoGrupo.Left;
                rllDescri.Left := rdbCodigoGrupo.Left;

              End
              Else
              Begin
                frmQckEstGirEstCompra.rllNomeRelatorio.Caption  := 'RELATORIO DO GIRO DE ESTOQUE - COMPRA - ANALÍTICO POR A.O.';
                rllGrupoAO.Visible        := True;
              End;

            End;
          End
          Else
          Begin
              {*******************************}
              {* VERIFICA SE VAI QUEBRAR POR *}
              {* LINHA/GRUPO OU ALFABETICO   *}
              {****************************AF*}
              If (Pos(edtOpcao.Text, 'A_F_') > 0) Then
              Begin

                case rdgExibir.ItemIndex Of
                0: Begin
                     frmQckEstGirEstCompra.rllValVenda.Caption           := 'PR.VENDA';
                     frmQckEstGirEstCompra.rllLUcro.Caption              := '% LUCRO';
                     frmQckEstGirEstCompra.rdbPreVendaAlfa.DataFormula   := 'PREVEN';
                     frmQckEstGirEstCompra.rdbPorcLucroAlfa.DataFormula := 'PRELUC';
                   End;
                1: Begin
                     frmQckEstGirEstCompra.rllValVenda.Caption           := 'PR.COMP';
                     frmQckEstGirEstCompra.rllLUcro.Caption              := 'PR.CUST';
                     frmQckEstGirEstCompra.rdbPreVendaAlfa.DataFormula   := 'PRECOM';
                     frmQckEstGirEstCompra.rdbPorcLucroAlfa.DataFormula := 'PRECUS';
                   End;
                End;

                frmQckEstGirEstCompra.rlbDetalhe.Visible        := True;
                frmQckEstGirEstCompra.rlbResumo.Borders.DrawTop := True;

                If (edtOpcao.Text = 'A') Then
                  frmQckEstGirEstCompra.rllNomeRelatorio.Caption := 'RELATORIO DO GIRO DE ESTOQUE - COMPRA - ORDEM: ALFABETICA'
                Else If (edtOpcao.Text = 'F') Then
                  frmQckEstGirEstCompra.rllNomeRelatorio.Caption := 'RELATORIO DO GIRO DE ESTOQUE - COMPRA - ORDEM: FORNECEDOR';
              End
              Else
              Begin

                Case rdgExibir.ItemIndex Of
                0: Begin
                     frmQckEstGirEstCompra.rllValVenda.Caption           := 'PR.VENDA';
                     frmQckEstGirEstCompra.rllLUcro.Caption              := '% LUCRO';
                     frmQckEstGirEstCompra.rdbPreVendaGrupo.DataFormula  := 'PREVEN';
                     frmQckEstGirEstCompra.rdbPorcLucroGrupo.DataFormula := 'PRELUC';
                   End;
                1: Begin
                     frmQckEstGirEstCompra.rllValVenda.Caption           := 'PR.COMP';
                     frmQckEstGirEstCompra.rllLUcro.Caption              := 'PR.CUST';
                     frmQckEstGirEstCompra.rdbPreVendaGrupo.DataFormula  := 'PRECOM';
                     frmQckEstGirEstCompra.rdbPorcLucroGrupo.DataFormula := 'PRECUS';
                   End;
                End;

                frmQckEstGirEstCompra.rlbGrupo.Visible          := True;
                frmQckEstGirEstCompra.rlbResumo.Borders.DrawTop := False;
                frmQckEstGirEstCompra.rllNomeRelatorio.Caption  := 'RELATORIO DO GIRO DE ESTOQUE - COMPRA - ORDEM: LINHA/GRUPO';
              End;

              Case rdgLocFis.ItemIndex Of
                0: frmQckEstGirEstCompra.rllLocFis.Caption := 'LOCALIZACAO FISICA: TODOS';
                1: frmQckEstGirEstCompra.rllLocFis.Caption := 'LOCALIZACAO FISICA: COM LOCALIZAZAO FISICA';
                2: frmQckEstGirEstCompra.rllLocFis.Caption := 'LOCALIZACAO FISICA: SEM LOCALIZAZAO FISICA';
              End;
          End;

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frmQckEstGirEstCompra.qckPagina, frmQckEstGirEstCompra.rpsSetup)
          Else
            pPrintReport(Self.Name, Self.Caption, strNomImp, frmQckEstGirEstCompra.qckPagina);

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckEstGirEstCompra);

      End;

    End
    Else
      pTabelaVazia;

  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';

  cxgItensView.NavigatorButtons.First.Click;
end;

function TfrmRelEstGirEstCompra.fMedia(dtsDados: TDataSet): Double;
begin
  Result := 0;
  Result := Result + qryRelatorio.FieldByName('MES001').AsFloat;
  Result := Result + qryRelatorio.FieldByName('MES002').AsFloat;
  Result := Result + qryRelatorio.FieldByName('MES003').AsFloat;
  Result := Result / 3;
end;

procedure TfrmRelEstGirEstCompra.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskLinhaGrupo);
end;

procedure TfrmRelEstGirEstCompra.FormCreate(Sender: TObject);
begin
  inherited;
  pAtualizaLst;
  pSetaCodIte(edtProdutos);
end;

procedure TfrmRelEstGirEstCompra.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstGirEstCompra.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, arrSel) Then  
  Begin
    fvalidaCampos(edtUnidade,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstGirEstCompra.edtUnidadeExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(fRetNomUnidade(edtUnidade.Text)) And (Not fEmptyStr(edtUnidade.Text))  Then
  Begin
    fMensagem('AVISO','Código da Unidade não encontrado.', ['&O K']);
    edtUnidade.Clear;
    pSetFocus(edtUnidade);
  End;

end;

procedure TfrmRelEstGirEstCompra.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: If (ActiveControl.Parent = rdgStatus) Then
                 SelectNext(ActiveControl, True, True)
               Else If (ActiveControl Is TRadioButton) Then
                 SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstGirEstCompra.FormShow(Sender: TObject);
begin
  inherited;
  pCriaQryRelatorio;
end;

procedure TfrmRelEstGirEstCompra.pGeraExcelNovo;
  Var
    objExcel : TGeraExcel;
begin
  objExcel := TGeraExcel.Create(qryRelatorio, prgProgresso);

  With objExcel Do
  Begin

    if cmbTipRel.ItemIndex = 1 Then
      strNomRel := 'RELATORIO DO GIRO DE ESTOQUE - COMPRA - SINTÉTICO POR A.O.'
    Else
      strNomRel := 'RELATORIO DO GIRO DE ESTOQUE - COMPRA - ANALÍTICO POR A.O.';

    {*********************}
    {* HEADER FORNECEDOR *}
    {******************AF*}
    If Not fEmptyStr(edtFornecedor.Text) Then
      AddFiltro('FORNECEDOR: ' + edtFornecedor.Text + ' - ' + edtDesFornecedor.Text )
    Else
      AddFiltro('FORNECEDOR: TODOS');

    {******************}
    {* HEADER PRODUTO *}
    {***************AF*}
    If Not fEmptyStr(edtProdutos.Text) Then
      AddFiltro('PRODUTO: ' + edtProdutos.Text + ' - ' + edtDesProduto.Text)
    Else
      AddFiltro('PRODUTO: TODOS');

    {******************}
    {* HEADER GRUPO 1 *}
    {***************AF*}
    If Not fEmptyStr(mskLinhaGrupo.Text) Then
      AddFiltro('LINHA/GRUPO: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text)
    Else
      AddFiltro('LINHA/GRUPO: TODOS');

    {******************}
    {* HEADER UNIDADE *}
    {***************AF*}
    If Not fEmptyStr(edtUnidade.Text) Then
      AddFiltro('UNIDADE: ' + edtUnidade.Text)
    Else
      AddFiltro('UNIDADE: TODAS');

    {****************}
    {* HEADER MARCA *}
    {*************AF*}
    If Not fEmptyStr(edtMarca.Text) Then
      AddFiltro('MARCA: ' + edtMarca.Text + ' - ' + edtDesMarca.Text)
    Else
      AddFiltro('MARCA: TODAS');

    {*****************}
    {* HEADER DESCRI *}
    {**************AF*}
    If Not fEmptyStr(edtDescri.Text) Then
      AddFiltro('DESCRICAO: ' + edtDescri.Text)
    Else
      AddFiltro('DESCRICAO: TODAS');

    {*********************}
    {* HEADER REFERENCIA *}
    {******************AF*}
    If Not fEmptyStr(edtRefere.Text) Then
      AddFiltro('REFERENCIA: ' + edtRefere.Text)
    Else
      AddFiltro('REFERENCIA: TODAS');

    Case rdgLocFis.ItemIndex Of
      0: AddFiltro('LOCALIZACAO FISICA: TODOS');
      1: AddFiltro('LOCALIZACAO FISICA: COM LOCALIZAZAO FISICA');
      2: AddFiltro('LOCALIZACAO FISICA: SEM LOCALIZAZAO FISICA');
    End;

    AddFiltro('REFERENTE AOS MESES DE : ' + strMes4 + '/' + strAno4 + ',' + strMes3 + '/' + strAno3 + ','
                                          + strMes2 + '/' + strAno2 + ',' + strMes1 + '/' + strAno1);

    If cmbTipRel.ItemIndex = 1 then
    Begin
      AddCampo('ITE_ACOOBJ', 'ACORDO DE OBJETIVOS');
    End
    Else
    Begin
      AddQuebra( 'ITE_ACOOBJ' , 'Acordo de Objetivos: ');
      AddCampo('CODIGO', 'CÓDIGO');
      AddCampo('DESITE', 'DESCRIÇÃO');
    End;

    AddCampo('MES001', strMes1 + '/' + strAno1);
    AddCampo('MES002', strMes2 + '/' + strAno2);
    AddCampo('MES003', strMes3 + '/' + strAno3);

    If chkExiAtu.Checked Then
      AddCampo('MES004', strMes4 + '/' + strAno4);

    AddCampo(fMedia, 'MEDIA', 'MEDIA' );

    If fGerarRelatorio Then
      fMensagem('ATENÇÃO', 'Arquivo gerado com Sucesso!', ['&OK']);

  End;

end;

procedure TfrmRelEstGirEstCompra.pMontaTitGru(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; Quebra: TRecQuebras);
begin
  If Quebra.NomeCampo = 'LINHA' then
    Excel.Escrever(Excel.LinhaAtual, 01, '       Linha: ' + Dados.FieldByName('LINHA').AsString + '.000 - ' +
                                           fRetNomeLinhaGrupo( Dados.FieldByName('LINHA').AsString + '000'));
  If Quebra.NomeCampo = 'GRUPO' then
    Excel.Escrever(Excel.LinhaAtual, 01, '       Grupo: ' + Dados.FieldByName('GRUPO').AsString + ' - ' +
                                           fRetNomeLinhaGrupo( Dados.FieldByName('GRUPO').AsString));
end;

Function TfrmRelEstGirEstCompra.fRetSigla(dtsDados: TDataSet): String;
begin
  Result := fRetSiglaUnidade(dtsDados.FieldByName('UNIDAD').AsString);
End;

Function TfrmRelEstGirEstCompra.fRetSugest(dtsDados: TDataSet): Double;
begin
  Result := fltSugest;
End;

Function TfrmRelEstGirEstCompra.fRetMedia(dtsDados: TDataSet): Double;
begin
  Result := (dtsDados.FieldByName('MES001').AsFloat +
             dtsDados.FieldByName('MES002').AsFloat +
             dtsDados.FieldByName('MES003').AsFloat) / 3;

  If Result >  qryRelatorio.FieldByName('SALDOS').AsFloat Then
    fltSugest := Result -  dtsDados.FieldByName('SALDOS').AsFloat
  Else
    fltSugest := 0;
End;

procedure TfrmRelEstGirEstCompra.pGeraExcel;
  Var
    Excel    : TGeraExcel;
begin

  if cmbTipRel.ItemIndex > 0 Then
  Begin
    pGeraExcelNovo;
    Exit;
  End;

  chkReferencia.Checked := True;

  If dlgExcel.Execute Then
  Begin
    prgProgresso.Visible := True;
    Excel := TGeraExcel.Create(qryRelatorio, prgProgresso);
    Try
      Excel.strNomArq := dlgExcel.FileName;
      prgProgresso.Max := qryRelatorio.RecordCount;
      prgProgresso.Position := 0;

      {***********************}
      {* TITULO DO RELATORIO *}
      {********************LU*}
      If edtOpcao.Text = 'A' Then
        Excel.strNomRel := 'RELATORIO DO GIRO DE ESTOQUE - COMPRA - ORDEM: ALFABETICA'
      Else If edtOpcao.Text = 'F' Then
        Excel.strNomRel := 'RELATORIO DO GIRO DE ESTOQUE - COMPRA - ORDEM: FORNECEDOR'
      Else
        Excel.strNomRel := 'RELATORIO DO GIRO DE ESTOQUE - COMPRA - ORDEM: LINHA/GRUPO';

      {********************************}
      {* EMPRESA PADRAO DO SISTEMA    *}
      {*****************************LU*}
      Excel.AddFiltro(fRetNomeEmpresaSelec(VS_strCodEmp));

      {*********************}
      {* HEADER FORNECEDOR *}
      {******************LU*}
      If Not fEmptyStr(edtFornecedor.Text) Then
        Excel.AddFiltro('FORNECEDOR: ' + edtFornecedor.Text + ' - ' + edtDesFornecedor.Text)
      Else
        Excel.AddFiltro('FORNECEDOR: TODOS');

      {******************}
      {* HEADER PRODUTO *}
      {***************LU*}
      If Not fEmptyStr(edtProdutos.Text) Then
        Excel.AddFiltro('PRODUTO: ' + edtProdutos.Text + ' - ' + edtDesProduto.Text)
      Else
        Excel.AddFiltro('PRODUTO: TODOS');

      {******************}
      {* HEADER GRUPO 1 *}
      {***************LU*}
      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        Excel.AddFiltro('LINHA/GRUPO: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text)
      Else
        Excel.AddFiltro('LINHA/GRUPO: TODOS');

      {******************}
      {* HEADER UNIDADE *}
      {***************LU*}
      If Not fEmptyStr(edtUnidade.Text) Then
        Excel.AddFiltro('UNIDADE: ' + edtUnidade.Text)
      Else
        Excel.AddFiltro('UNIDADE: TODAS');

      {****************}
      {* HEADER MARCA *}
      {*************LU*}
      If Not fEmptyStr(edtMarca.Text) Then
        Excel.AddFiltro('MARCA: ' + edtMarca.Text + ' - ' + edtDesMarca.Text)
      Else
        Excel.AddFiltro('MARCA: TODAS');

      {***************************}
      {* HEADER GRUPO DE COMPRAS *}
      {14/08/2012**************CI*}
      If Not fEmptyStr(edtGruCmp.Text) Then
        Excel.AddFiltro('GRUPO DE COMPRAS: ' + edtGruCmp.Text + ' - ' + edtDesGruCmp.Text)
      Else
        Excel.AddFiltro('GRUPO DE COMPRAS: TODOS');

      {********************}
      {* HEADER DESCRICAO *}
      {*****************LU*}
      If Not fEmptyStr(edtDescri.Text) Then
        Excel.AddFiltro('DESCRICAO: ' + edtDescri.Text)
      Else
        Excel.AddFiltro('DESCRICAO: TODAS');

      {*********************}
      {* HEADER REFERENCIA *}
      {******************LU*}
      If Not fEmptyStr(edtRefere.Text) Then
        Excel.AddFiltro('REFERENCIA: ' + edtRefere.Text)
      Else
        Excel.AddFiltro('REFERENCIA: TODAS');

      {*****************************}
      {* HEADER LOCALIZAÇÃO FÍSICA *}
      {**************************PZ*}
      Case rdgLocFis.ItemIndex Of
        0: Excel.AddFiltro('LOCALIZACAO FISICA: TODOS');
        1: Excel.AddFiltro('LOCALIZACAO FISICA: COM LOCALIZAZAO FISICA');
        2: Excel.AddFiltro('LOCALIZACAO FISICA: SEM LOCALIZAZAO FISICA');
      End;

      {************************************}
      {* CABECALHO                        *}
      {*********************************LU*}
      Excel.AddCampo('CODIGO', 'CÓDIGO');
      Excel.AddCampo('DESITE', 'DESCRIÇÃO DO ITEM');
      Excel.AddCampo('REFERE', 'REFERENCIA');
      Excel.AddCampo(fRetSigla, 'UNIDAD', 'UN');
      Excel.AddCampo('DESMAR', 'MARCA');
      Excel.AddCampo('R_SOCIAL', 'FORNECEDOR');

      Excel.AddCampo('MES001', strMes1 + '/' + strAno1, 2);
      Excel.AddCampo('MES002', strMes2 + '/' + strAno2, 2);
      Excel.AddCampo('MES003', strMes3 + '/' + strAno3, 2);
      If chkExiAtu.Checked Then
        Excel.AddCampo('MES004', strMes4 + '/' + strAno4, 2);

      Excel.AddCampo(fRetMedia, 'MES004', 'MÉDIA', 2);
      Excel.AddCampo('SALDOS', 'EM ESTOQUE', 2);
      Excel.AddCampo(fRetSugest, 'SUGESTAO', 'SUGESTÃO', 2);
      Excel.AddCampo('PREULT', 'PR. ULT. COMP', 2);
      Excel.AddCampo('DTAULT', 'DT. ULT. COMP');


      Case rdgExibir.ItemIndex Of
      0: Begin
           Excel.AddCampo('PREVEN', 'PR. VENDA', 2);
           Excel.AddCampo('PRELUC', '% LUCRO', 2, True );
         End;
      1: Begin
           Excel.AddCampo('PRECOM', 'PR. COMPRA', 2);
           Excel.AddCampo('PRECUS', 'PR. CUSTO', 2);
         End;
      End;

      If (edtOpcao.Text = 'L')  Then
      Begin
        Excel.AddQuebra('LINHA', 'LINHA: ');
        Excel.AddQuebra('GRUPO', 'GRUPO: ');
      End;
      If (rdgQuebraFornec.ItemIndex = 0) And (rdgQuebraFornec.Enabled) Then
        Excel.AddQuebra('R_SOCIAL', 'FORNECEDOR: ');

      Excel.OnImpTitGrupo := pMontaTitGru;



      If Excel.fGerarRelatorio Then
        fMensagem('','Arquivo gerado com sucesso!', ['&OK']);
    Finally
      FreeAndNil(Excel);
      prgProgresso.Visible := false;
    End;
  End;

end;

procedure TfrmRelEstGirEstCompra.cmbTipRelChange(Sender: TObject);
begin
  inherited;

  if cmbTipRel.ItemIndex > 0 Then
  Begin
    edtOpcao.Text := 'A';
    chkReferencia.Checked := False;
  End;

  gpbOrdem.Enabled      := (cmbTipRel.ItemIndex = 0);
  edtOpcao.Enabled      := (cmbTipRel.ItemIndex = 0);
  grbRefere.Enabled     := (cmbTipRel.ItemIndex = 0);
  chkReferencia.Enabled := (cmbTipRel.ItemIndex = 0);

  rdgQuebraFornec.Enabled := AnsiMatchStr(edtOpcao.Text, ['A', 'F']) and (cmbTipRel.ItemIndex = 0);
  rdgQuebraFornec.ItemIndex := StrToInt(IfThen(not rdgQuebraFornec.Enabled, '1', IntToStr(rdgQuebraFornec.ItemIndex)));

end;

procedure TfrmRelEstGirEstCompra.cxgItensSELPropertiesChange(Sender: TObject);
begin
  inherited;

  cdsMeses.pPost;
end;

procedure TfrmRelEstGirEstCompra.edtDestinoExit(Sender: TObject);
begin
//  inherited;
end;

end.

