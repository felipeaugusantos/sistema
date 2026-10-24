unit untAtualizacaoMargemParaFranquias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  untFuncoesConsulta, untConsultas, untTypesSistema, untFuncoesSimples, untZClient,
  cxCurrencyEdit, cxContainer, cxProgressBar, System.StrUtils, untGeraExcelHtml,
  Vcl.ComCtrls, Uni, untTValidaExcel, untParCalculaPrecoCusto, untAtualizacaoMargemParaFranquiasConfirma,
  untTConfiguracao;

type
  TfrmAtualizacaoMargemParaFranquias = class(TfrmPai)
    Panel1: TPanel;
    Label14: TLabel;
    edtCodDep: TEditFocus;
    edtDesCodDep: TEditFocus;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    Label15: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte2: TEditFocus;
    Label2: TLabel;
    edtDescri: TEditFocus;
    grpFiltrosDiv: TGroupBox;
    chkSimples: TCheckBox;
    chkPresumido: TCheckBox;
    chkReal: TCheckBox;
    Label3: TLabel;
    cxvDados: TcxGridDBTableViewCitel;
    cxldados: TcxGridLevel;
    cxgDados: TcxGridCitel;
    dtsDados: TDataSource;
    cxvPRODUTO: TcxGridDBColumn;
    cxvITE_CODEMP: TcxGridDBColumn;
    cxvITE_REGTRI: TcxGridDBColumn;
    cxvITE_MARBR1: TcxGridDBColumn;
    cxvITE_MARBR2: TcxGridDBColumn;
    cxvITE_MARBR3: TcxGridDBColumn;
    cxvITE_MARBR4: TcxGridDBColumn;
    cxvITE_MARBR5: TcxGridDBColumn;
    cxvITE_MARBR6: TcxGridDBColumn;
    cxvITE_MARBR7: TcxGridDBColumn;
    cxvITE_PREVE1: TcxGridDBColumn;
    cxvITE_PREVE2: TcxGridDBColumn;
    cxvITE_PREVE3: TcxGridDBColumn;
    cxvITE_PREVE4: TcxGridDBColumn;
    cxvITE_PREVE5: TcxGridDBColumn;
    cxvITE_PREVE6: TcxGridDBColumn;
    cxvITE_PREVE7: TcxGridDBColumn;
    btnExport: TSpeedButton;
    BtnImport: TSpeedButton;
    opDialog: TOpenDialog;
    prgTela: TProgressBar;
    btnFiltar: TBitBtnLocked;
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnFiltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

    arrCodDep,
    arrProduto,
    arrLinFor,
    arrLinMar,
    arrGruCmp,
    arrLinGru: TConsultasArray;

    strProduto,
    strCodDep ,
    strLinFor ,
    strLinMar ,
    strGruCmp ,
    strLinGru : String;
    qryDados: TZClient;
    qryDadosImportacao: TZClient;
    qryDadosImportacaoItem: TuniQuery;
    objValidaExcel: TValidadorExcel;
    FcpcParams: TParCalculaPrecoCusto;

    procedure pAbreQry;
    procedure pMontaSQL;
    function fRetFiltroRegimeTrib: string;
    function fRemoverTodosCaracteresPercentual(Value: String): String;
    function fTemAoMenosUmFiltro: Boolean;
    procedure pExportaArquivo;
    Function fExportaArquivoAux(pgbProgresso: TcxProgressBar): Boolean;
    procedure pSetaVisibilidadeCampo(blnVisible: Boolean; cxCampoMargem: TcxGridDBColumn = NIL; cxCampoVenda: TcxGridDBColumn = NIL);
    procedure pImportaArquivo;
    function fImportaArquivo: Boolean;
    function fRetDesRegTri(strRegTri: string): String;

    Function fImportaArquivoAux(pgbProgresso: TcxProgressBar): Boolean;
    procedure pMontaSQLDadosImportacao(qry: TUniQuery; blnNoResul: Boolean);
    procedure pMontaSQLDadosImportacaoItem(qry: TUniQuery);
    procedure pCalculaPrecoDeVenda(intTabPre: integer);
    function fRetComissao(intTabPre: integer): Double;
    procedure pCalculaCusto;
    procedure pGravaMargem;
    Function fGravamargemAux(pgbProgresso: TcxProgressBar): Boolean;
    const
       cDesEmpresaMatriz = 'Empresa Matriz';
       cDesCodIte        = 'Código do Item';
       cDesRegimeTributario = 'Regime Tributario';
       cDesMargemBruta1 = 'Margem Bruta 1';
       cDesMargemBruta2 = 'Margem Bruta 2';
       cDesMargemBruta3 = 'Margem Bruta 3';
       cDesMargemBruta4 = 'Margem Bruta 4';
       cDesMargemBruta5 = 'Margem Bruta 5';
       cDesMargemBruta6 = 'Margem Bruta 6';
       cDesMargemBruta7 = 'Margem Bruta 7';

       cEmpresaMatriz = 'A';
       cCodIte        = 'B';
       cRegimeTributario = 'C';
       cMargemBruta1 = 'D';
       cMargemBruta2 = 'E';
       cMargemBruta3 = 'F';
       cMargemBruta4 = 'G';
       cMargemBruta5 = 'H';
       cMargemBruta6 = 'I';
       cMargemBruta7 = 'J';

  public
    { Public declarations }
  end;

var
  frmAtualizacaoMargemParaFranquias: TfrmAtualizacaoMargemParaFranquias;

implementation

uses
  untGravando;

{$R *.dfm}

procedure TfrmAtualizacaoMargemParaFranquias.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesCodDep, arrCodDep, fRetNomDep, nil, 'do Departamento');

end;

procedure TfrmAtualizacaoMargemParaFranquias.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesCodDep, nil, key, arrCodDep, False) Then
  Begin
    if fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAtualizacaoMargemParaFranquias.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtDesIte2, arrProduto, nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmAtualizacaoMargemParaFranquias.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, nil, nil, Key, arrProduto, True, nil, 'Consulta de Itens', '1') Then
    If fValidaCampos(edtCodIte) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmAtualizacaoMargemParaFranquias.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrLinFor, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmAtualizacaoMargemParaFranquias.edtFornecedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrLinFor, False) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAtualizacaoMargemParaFranquias.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmAtualizacaoMargemParaFranquias.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAtualizacaoMargemParaFranquias.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca, edtDesMarca ,arrLinMar, fRetNomMarca, nil, 'da Marca');

end;

procedure TfrmAtualizacaoMargemParaFranquias.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrLinMar, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAtualizacaoMargemParaFranquias.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodIte.TamCampo := fTamCodIte;
  edtMarca.TamCampo := fTamCodMar;
  FcpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

end;

procedure TfrmAtualizacaoMargemParaFranquias.FormDestroy(Sender: TObject);
begin
  inherited;
  pFreeAndNil(FcpcParams);
  If Assigned(qryDados) Then
    pFreeAndNil(qryDados);

end;

procedure TfrmAtualizacaoMargemParaFranquias.FormShow(Sender: TObject);
var i: integer;
begin
  inherited;
  pSetFocus(edtCodIte);

  For i := 1 To Length(VS_strTabPrc) Do
  Begin
    case i of
      1: pSetaVisibilidadeCampo(VS_strTabPrc[1] = 'S', cxvITE_MARBR1);
      2: pSetaVisibilidadeCampo(VS_strTabPrc[2] = 'S', cxvITE_MARBR2);
      3: pSetaVisibilidadeCampo(VS_strTabPrc[3] = 'S', cxvITE_MARBR3);
      4: pSetaVisibilidadeCampo(VS_strTabPrc[4] = 'S', cxvITE_MARBR4);
      5: pSetaVisibilidadeCampo(VS_strTabPrc[5] = 'S', cxvITE_MARBR5);
      6: pSetaVisibilidadeCampo(VS_strTabPrc[6] = 'S', cxvITE_MARBR6);
      7: pSetaVisibilidadeCampo(VS_strTabPrc[7] = 'S', cxvITE_MARBR7);
    End;
  End;


end;

function TfrmAtualizacaoMargemParaFranquias.fRemoverTodosCaracteresPercentual(
  Value: String): String;
begin
  Result := StringReplace(Value, '%', '', [rfReplaceAll]);
end;

function TfrmAtualizacaoMargemParaFranquias.fRetFiltroRegimeTrib: string;
var strFilter: String;
begin
  Result := '';
  strFilter := ('("S""R""P")');
  If Not chkSimples.Checked then
    strFilter := StringReplace(strFilter, '"S"', '', []);
  If Not chkReal.Checked then
    strFilter := StringReplace(strFilter, '"R"', '', []);
  If Not chkPresumido.Checked then
    strFilter := StringReplace(strFilter, '"P"', '', []);

    strFilter := StringReplace(strFilter, '""', '","', [rfReplaceAll]);

  If strFilter <> '()' Then
    Result := 'AND ITE_REGTRI IN ' + strFilter ;
end;

function TfrmAtualizacaoMargemParaFranquias.fTemAoMenosUmFiltro: Boolean;
var strFiltros: String;
begin

  strFiltros := edtCodDep.Text +
                edtCodIte.Text +
                edtFornecedor.Text +
                edtMarca.Text +
                edtGruCmp.Text +
                mskLinhaGrupo.Text +
                edtDescri.Text;
  Result :=  Not fEmptyStr(strFiltros)

  {}
end;

procedure TfrmAtualizacaoMargemParaFranquias.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinGru, fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmAtualizacaoMargemParaFranquias.mskLinhaGrupoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAtualizacaoMargemParaFranquias.pAbreQry;
begin
  If Assigned(qryDados) Then
    FreeAndNil(qryDados);

  qryDados := TZClient.Create(Self);

  pMontaSQL;

  qryDados.fAbreClient(False, '[TfrmAtualizacaoMargemParaFranquias.pAbreQry]');
  dtsDados.DataSet := qryDados;
  If qryDados.IsEmpty Then
    pMensagemOk('Sem dados para exibir!');

end;

procedure TfrmAtualizacaoMargemParaFranquias.pMontaSQL;
begin
  qryDados.qryQuery.SQL.Add('SELECT CAST(CASE ITE_REGTRI');
  qryDados.qryQuery.SQL.Add('          WHEN "R" THEN "3 - Lucro Real"');
  qryDados.qryQuery.SQL.Add('          WHEN "P" THEN "2 - Lucro Presumido"');
  qryDados.qryQuery.SQL.Add('          WHEN "S" THEN "1 - Simples Nacional"');
  qryDados.qryQuery.SQL.Add('       END AS CHAR(20)) AS COD_REGTRI   ,');
  qryDados.qryQuery.SQL.Add('       CAST(CONCAT(I.ITE_CODITE, "-", I.ITE_DESITE) AS CHAR(100))PRODUTO,');
  qryDados.qryQuery.SQL.Add('       I.ITE_CODITE, ');
  qryDados.qryQuery.SQL.Add('       F.ITE_CODEMP,');
  qryDados.qryQuery.SQL.Add('       F.ITE_REGTRI,');
  qryDados.qryQuery.SQL.Add('       F.ITE_IPIENT,');
  qryDados.qryQuery.SQL.Add('       F.ITE_ICMENT,');
  qryDados.qryQuery.SQL.Add('       F.ITE_SUBSTI,');
  qryDados.qryQuery.SQL.Add('       F.ITE_DESADB,');
  qryDados.qryQuery.SQL.Add('       F.ITE_SUBFED,');
  qryDados.qryQuery.SQL.Add('       F.ITE_PRECUS,');
  qryDados.qryQuery.SQL.Add('       F.ITE_IMPFED,');
  qryDados.qryQuery.SQL.Add('       F.ITE_ICMSAI,');
  qryDados.qryQuery.SQL.Add('       F.ITE_MARBR1,');
  qryDados.qryQuery.SQL.Add('       F.ITE_PREVE1,');
  qryDados.qryQuery.SQL.Add('       F.ITE_MARBR2,');
  qryDados.qryQuery.SQL.Add('       F.ITE_PREVE2,');
  qryDados.qryQuery.SQL.Add('       F.ITE_MARBR3,');
  qryDados.qryQuery.SQL.Add('       F.ITE_PREVE3,');
  qryDados.qryQuery.SQL.Add('       F.ITE_MARBR4,');
  qryDados.qryQuery.SQL.Add('       F.ITE_PREVE4,');
  qryDados.qryQuery.SQL.Add('       F.ITE_MARBR5,');
  qryDados.qryQuery.SQL.Add('       F.ITE_PREVE5,');
  qryDados.qryQuery.SQL.Add('       F.ITE_MARBR6,');
  qryDados.qryQuery.SQL.Add('       F.ITE_PREVE6,');
  qryDados.qryQuery.SQL.Add('       F.ITE_MARBR7,');
  qryDados.qryQuery.SQL.Add('       F.ITE_PREVE7,');
  qryDados.qryQuery.SQL.Add('       F.ITE_ULTALT,');
  qryDados.qryQuery.SQL.Add('       F.ITE_OPEALT');
  qryDados.qryQuery.SQL.Add('  FROM CADITE I');
  qryDados.qryQuery.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE');
  qryDados.qryQuery.SQL.Add(' INNER JOIN ITERFI F ON F.ITE_CODITE  = G.ITE_CODITE AND F.ITE_CODEMP = G.ITE_CODEMP');
  qryDados.qryQuery.SQL.Add(' WHERE TRUE');

  qryDados.qryQuery.SQL.Add(fStrLocate(edtCodIte,     arrProduto, 'I.ITE_CODITE', 'CODITE'));
  qryDados.qryQuery.SQL.Add(fStrLocate(edtCodDep,     arrCodDep , 'I.ITE_CODDEP', 'CODDEP'));
  qryDados.qryQuery.SQL.Add(fStrLocate(edtFornecedor, arrLinFor , 'I.ITE_CODFOR', 'CODFOR'));
  qryDados.qryQuery.SQL.Add(fStrLocate(edtMarca,      arrLinMar , 'I.ITE_CODMAR', 'CODMAR'));
  qryDados.qryQuery.SQL.Add(fStrLocate(edtGruCmp,     arrGruCmp , 'I.ITE_GRUCMP', 'GRUCMP'));
  If not fEmptyStr(fRemoverTodosCaracteresPercentual(edtDescri.Text)) Then
  qryDados.qryQuery.SQL.Add(' AND I.ITE_DESITE LIKE :DESITE ');
  qryDados.qryQuery.SQL.Add(fRetFiltroRegimeTrib);
  qryDados.qryQuery.SQL.Add(' AND G.ITE_CODEMP = "'+VS_StrCodEmp+'"');

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
    qryDados.qryQuery.SQL.Add(fStrLocateLinGru(mskLinhaGrupo, arrLinGru, 'ITE_CODGRU','CODGRU'));

  pSetaParam(edtCodIte.Text,     arrProduto, strProduto, 'CODITE', qryDados.qryQuery);
  pSetaParam(edtCodDep.Text,     arrCodDep , strCodDep , 'CODDEP', qryDados.qryQuery);
  pSetaParam(edtFornecedor.Text, arrLinFor , strLinFor , 'CODFOR', qryDados.qryQuery);
  pSetaParam(edtMarca.Text,      arrLinMar , strLinMar , 'CODMAR', qryDados.qryQuery);
  pSetaParam(edtGruCmp.Text,     arrGruCmp , strGruCmp , 'GRUCMP', qryDados.qryQuery);
  pSetaParam(mskLinhaGrupo.Text, arrLinGru , strLinGru , 'CODGRU', qryDados.qryQuery);

  If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtDescri.Text)) Then
    qryDados.qryQuery.ParamByName('DESITE').AsString := '%' + edtDescri.Text + '%';
end;

procedure TfrmAtualizacaoMargemParaFranquias.pSetaVisibilidadeCampo(
  blnVisible: Boolean; cxCampoMargem, cxCampoVenda: TcxGridDBColumn);
begin
  If assigned(cxCampoMargem) Then
    cxCampoMargem.Visible := blnVisible;
  if Assigned(cxCampoVenda) Then
    cxCampoVenda.Visible  := blnVisible;

end;

procedure TfrmAtualizacaoMargemParaFranquias.pExportaArquivo;
var frmGravando: TfrmGravando;
Begin

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Exportando arquivo';
    frmGravando.fExecutarAcao := fExportaArquivoAux;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
End;

procedure TfrmAtualizacaoMargemParaFranquias.pGravaMargem;
var frmGravaMargem: TFrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravaMargem);
  Try
    frmGravaMargem.lblGravando.Caption := 'Gravando as margens.';
    frmGravaMargem.fExecutarAcao := fGravamargemAux;
    frmGravaMargem.ShowModal;
  Finally
    pFreeAndNil(frmGravaMargem);
  End;
end;

procedure TfrmAtualizacaoMargemParaFranquias.pImportaArquivo;
begin
  qryDadosImportacao := TZClient.Create(Self);
  qryDadosImportacaoItem:= fCriaQuery;
  Try
    pMontaSQLDadosImportacao(qryDadosImportacao.qryQuery, True);
    pMontaSQLDadosImportacaoItem(qryDadosImportacaoItem);
    qryDadosImportacao.fAbreClient(False, '[TfrmAtualizacaoMargemParaFranquias.pImportaArquivo]');

    objValidaExcel := TValidadorExcel.Create(opDialog.FileName, 10, 'A', '');
    Try
      objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesEmpresaMatriz, cEmpresaMatriz, 3, False, True, 'CADEMP', 'EMP_CODEMP', True));
      objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCodIte, cCodIte, fTamCodite, False, True, 'CADITE', 'ITE_CODITE', True));
      objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesRegimeTributario, cRegimeTributario, 1, True, True, '', ''));
      objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMargemBruta1, cMargemBruta1));
      objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMargemBruta2, cMargemBruta2));
      objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMargemBruta3, cMargemBruta3));
      objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMargemBruta4, cMargemBruta4));
      objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMargemBruta5, cMargemBruta5));
      objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMargemBruta6, cMargemBruta6));
      objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMargemBruta7, cMargemBruta7));
      If Not objValidaExcel.fValidaCampos(True) Then
        exit;

      If fImportaArquivo Then
      Begin
        qryDadosImportacao.First;
        pCriarFormularios(TfrmAtualizacaoMargemParaFranquiasConfirma, frmAtualizacaoMargemParaFranquiasConfirma);
        Try
          frmAtualizacaoMargemParaFranquiasConfirma.dtsDados.DataSet := qryDadosImportacao;
          frmAtualizacaoMargemParaFranquiasConfirma.Showmodal;
          If frmAtualizacaoMargemParaFranquiasConfirma.blnConfirma Then
            pGravaMargem;
        Finally
          FreeAndNil(frmAtualizacaoMargemParaFranquiasConfirma);
        End;
      End;
    Finally
      FreeAndNil(objValidaExcel);
    End;

  Finally
    FreeAndNil(qryDadosImportacaoItem);
    FreeAndNil(qryDadosImportacao);
  End;
end;

procedure TfrmAtualizacaoMargemParaFranquias.pMontaSQLDadosImportacao(qry: TUniQuery; blnNoResul: Boolean);
var i: integer;
Begin
  qry.SQL.Add('SELECT G.ITE_PREDOL,');
  qry.SQL.Add('       CAST("" AS CHAR(20)) AS COD_REGTRI ,');
  qry.SQL.Add('       CAST("" AS CHAR(100))PRODUTO,');
  qry.SQL.Add('       I.ITE_CODITE,');
  qry.SQL.Add('       I.ITE_DESITE,');

  qry.SQL.Add('       F.ITE_CODEMP,');
  qry.SQL.Add('       F.ITE_REGTRI,');
  qry.SQL.Add('       G.ITE_PRECOM,');
  qry.SQL.Add('       G.ITE_DESF01,');
  qry.SQL.Add('       G.ITE_DESF02,');
  qry.SQL.Add('       G.ITE_DESF03,');
  qry.SQL.Add('       G.ITE_DESF04,');
  qry.SQL.Add('       G.ITE_DESF05,');
  qry.SQL.Add('       G.ITE_OUTVAL,');
  qry.SQL.Add('       G.ITE_DESF06,');
  qry.SQL.Add('       G.ITE_FREENT,');
  qry.SQL.Add('       G.ITE_ACRFIN,');
  qry.SQL.Add('       G.ITE_DESOPE,');
  qry.SQL.Add('       G.ITE_VALFRE,');
  qry.SQL.Add('       F.ITE_IPIENT,');
  qry.SQL.Add('       F.ITE_ICMENT,');
  qry.SQL.Add('       F.ITE_SUBSTI,');
  qry.SQL.Add('       F.ITE_DESADB,');
  qry.SQL.Add('       F.ITE_SUBFED,');
  qry.SQL.Add('       F.ITE_PRECUS,');
  qry.SQL.Add('       F.ITE_IMPFED,');
  qry.SQL.Add('       F.ITE_ICMSAI,');
  For i :=  1 To 7 Do
  Begin
    qry.SQL.Add('       F.ITE_MARBR'+i.tostring+',');
    qry.SQL.Add('       F.ITE_MARBR'+i.tostring+ ' AS ITE_MARBR'+i.tostring+'_NOV,');
    qry.SQL.Add('       F.ITE_PREVE'+i.tostring+',');
    qry.SQL.Add('       F.ITE_PREVE'+i.tostring+ ' AS ITE_PREVE'+i.tostring+'_NOV,');
    qry.SQL.Add('       G.ITE_COMTB'+i.tostring+',');
  End;
  qry.SQL.Add('       F.ITE_ULTALT,');
  qry.SQL.Add('       F.ITE_OPEALT,');
  qry.SQL.Add('       F.ITE_CUSREA');
  qry.SQL.Add('  FROM CADITE I');
  qry.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE');
  qry.SQL.Add(' INNER JOIN ITERFI F ON F.ITE_CODITE  = G.ITE_CODITE AND F.ITE_CODEMP = G.ITE_CODEMP');
  If blnNoResul Then
    qry.SQL.Add(' WHERE FALSE')
  Else
    qry.SQL.Add(' WHERE True');
End;

procedure TfrmAtualizacaoMargemParaFranquias.pMontaSQLDadosImportacaoItem(qry: TUniQuery);
Begin
  pMontaSQLDadosImportacao(qry, False);
  qry.SQl.Add('AND F.ITE_CODEMP = :CODEMP');
  qry.SQl.Add('AND F.ITE_CODITE = :CODITE');
  qry.SQl.Add('AND F.ITE_REGTRI = :REGTRI');
End;

procedure TfrmAtualizacaoMargemParaFranquias.btnExportClick(Sender: TObject);
begin
  inherited;
  If fPergunta('Deseja exportar os itens?') Then
    pExportaArquivo;
end;

procedure TfrmAtualizacaoMargemParaFranquias.btnFiltarClick(Sender: TObject);
begin
  inherited;

  If Not fTemAoMenosUmFiltro Then
  Begin
    pMensagemOk('Selecione ao menos um filtro!');
    Exit;
  End;
  btnExport.Enabled := False;
  pAbreQry;
  cxvITE_REGTRI.width := 116;
  cxvITE_CODEMP.width := 80;

  If Not qryDados.IsEmpty Then
    btnExport.Enabled := True;
end;

procedure TfrmAtualizacaoMargemParaFranquias.BtnImportClick(Sender: TObject);
begin
  inherited;
  If fPergunta('Deseja importar uma planilha?') Then
   If opDialog.Execute() Then
     pImportaArquivo;
end;

Function TfrmAtualizacaoMargemParaFranquias.fExportaArquivoAux(pgbProgresso: TcxProgressBar): Boolean;
var geraExcel : TGeraArquivo;
    FontFieldValues,
    FontFieldTitle: TFont;

begin
  qryDados.First;

  qryDados.DisableControls;
  geraExcel := TGeraArquivo.create(taHtml, qryDados, prgTela);
  Try
    FontFieldValues:= TGeraArquivo.fSetFont(10, [], clBlack);
    FontFieldTitle := TGeraArquivo.fSetFont(10, [], clWhite);

    geraExcel.AddCampo('ITE_CODEMP', cDesEmpresaMatriz    , FontFieldTitle, FontFieldValues, '', tahtmlUndef);
    geraExcel.AddCampo('ITE_CODITE', cDesCodIte           , FontFieldTitle, FontFieldValues, '', tahtmlUndef);
    geraExcel.AddCampo('ITE_REGTRI', cDesRegimeTributario , FontFieldTitle, FontFieldValues);
    If VS_strTabPrc[1] = 'S' Then
      geraExcel.AddCampo('ITE_MARBR1', cDesMargemBruta1, FontFieldTitle, FontFieldValues,'#0.00');
    If VS_strTabPrc[2] = 'S' Then
      geraExcel.AddCampo('ITE_MARBR2', cDesMargemBruta2, FontFieldTitle, FontFieldValues,'#0.00');
    If VS_strTabPrc[3] = 'S' Then
      geraExcel.AddCampo('ITE_MARBR3', cDesMargemBruta3, FontFieldTitle, FontFieldValues,'#0.00');
    If VS_strTabPrc[4] = 'S' Then
      geraExcel.AddCampo('ITE_MARBR4', cDesMargemBruta4, FontFieldTitle, FontFieldValues,'#0.00');
    If VS_strTabPrc[5] = 'S' Then
      geraExcel.AddCampo('ITE_MARBR5', cDesMargemBruta5, FontFieldTitle, FontFieldValues,'#0.00');
    If VS_strTabPrc[6] = 'S' Then
      geraExcel.AddCampo('ITE_MARBR6', cDesMargemBruta6, FontFieldTitle, FontFieldValues,'#0.00');
    If VS_strTabPrc[7] = 'S' Then
      geraExcel.AddCampo('ITE_MARBR7', cDesMargemBruta7, FontFieldTitle, FontFieldValues,'#0.00');

    If geraExcel.fGerarRelatorio(True) Then
      pMensagemOk('Arquivo gerado com sucesso!');

    Result := True;
  Finally
    qryDados.EnableControls;
    FreeAndNil(geraExcel);
  End
End;

function TfrmAtualizacaoMargemParaFranquias.fGravamargemAux(
  pgbProgresso: TcxProgressBar): Boolean;
  var qryComand: TUniQuery;
begin
  pgbProgresso.Properties.Max := qryDadosImportacao.RecordCount -1;
  qryDadosImportacao.First;
  qryComand := fCriaQuery;
  qryComand.SQL.Add('UPDATE ITERFI SET');
  qryComand.SQL.Add('ITE_MARBR1 = :MARBR1,');
  qryComand.SQL.Add('ITE_PREVE1 = :PREVE1,');
  qryComand.SQL.Add('ITE_MARBR2 = :MARBR2,');
  qryComand.SQL.Add('ITE_PREVE2 = :PREVE2,');
  qryComand.SQL.Add('ITE_MARBR3 = :MARBR3,');
  qryComand.SQL.Add('ITE_PREVE3 = :PREVE3,');
  qryComand.SQL.Add('ITE_MARBR4 = :MARBR4,');
  qryComand.SQL.Add('ITE_PREVE4 = :PREVE4,');
  qryComand.SQL.Add('ITE_MARBR5 = :MARBR5,');
  qryComand.SQL.Add('ITE_PREVE5 = :PREVE5,');
  qryComand.SQL.Add('ITE_MARBR6 = :MARBR6,');
  qryComand.SQL.Add('ITE_PREVE6 = :PREVE6,');
  qryComand.SQL.Add('ITE_MARBR7 = :MARBR7,');
  qryComand.SQL.Add('ITE_PREVE7 = :PREVE7,');
  qryComand.SQL.Add('ITE_ULTALT = :ULTALT,');
  qryComand.SQL.Add('ITE_OPEALT = :OPEALT,');
  qryComand.SQL.Add('ITE_PRECUS = :PRECUS,');
  qryComand.SQL.Add('ITE_CUSREA = :CUSREA ');
  qryComand.SQL.Add('WHERE ITE_CODITE = :CODITE');
  qryComand.SQL.Add('AND ITE_CODEMP =   :CODEMP');
  qryComand.SQL.Add('AND ITE_REGTRI =   :REGTRI');
  Try
    while not qryDadosImportacao.Eof do
    begin
      qryComand.ParamByName('MARBR1').AsFloat := qryDadosImportacao.FieldByName('ITE_MARBR1_NOV').AsFloat;
      qryComand.ParamByName('PREVE1').AsFloat := qryDadosImportacao.FieldByName('ITE_PREVE1_NOV').AsFloat;
      qryComand.ParamByName('MARBR2').AsFloat := qryDadosImportacao.FieldByName('ITE_MARBR2_NOV').AsFloat;
      qryComand.ParamByName('PREVE2').AsFloat := qryDadosImportacao.FieldByName('ITE_PREVE2_NOV').AsFloat;
      qryComand.ParamByName('MARBR3').AsFloat := qryDadosImportacao.FieldByName('ITE_MARBR3_NOV').AsFloat;
      qryComand.ParamByName('PREVE3').AsFloat := qryDadosImportacao.FieldByName('ITE_PREVE3_NOV').AsFloat;
      qryComand.ParamByName('MARBR4').AsFloat := qryDadosImportacao.FieldByName('ITE_MARBR4_NOV').AsFloat;
      qryComand.ParamByName('PREVE4').AsFloat := qryDadosImportacao.FieldByName('ITE_PREVE4_NOV').AsFloat;
      qryComand.ParamByName('MARBR5').AsFloat := qryDadosImportacao.FieldByName('ITE_MARBR5_NOV').AsFloat;
      qryComand.ParamByName('PREVE5').AsFloat := qryDadosImportacao.FieldByName('ITE_PREVE5_NOV').AsFloat;
      qryComand.ParamByName('MARBR6').AsFloat := qryDadosImportacao.FieldByName('ITE_MARBR6_NOV').AsFloat;
      qryComand.ParamByName('PREVE6').AsFloat := qryDadosImportacao.FieldByName('ITE_PREVE6_NOV').AsFloat;
      qryComand.ParamByName('MARBR7').AsFloat := qryDadosImportacao.FieldByName('ITE_MARBR7_NOV').AsFloat;
      qryComand.ParamByName('PREVE7').AsFloat := qryDadosImportacao.FieldByName('ITE_PREVE7_NOV').AsFloat;
      qryComand.ParamByName('PRECUS').AsFloat := qryDadosImportacao.FieldByName('ITE_PRECUS').AsFloat;
      qryComand.ParamByName('ULTALT').AsDateTime := fNow;
      qryComand.ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
      qryComand.ParamByName('CUSREA').AsFloat := qryDadosImportacao.FieldByName('ITE_CUSREA').AsFloat;
      qryComand.ParamByName('CODITE').AsString := qryDadosImportacao.FieldByName('ITE_CODITE').AsString;
      qryComand.ParamByName('CODEMP').AsString := qryDadosImportacao.FieldByName('ITE_CODEMP').AsString;
      qryComand.ParamByName('REGTRI').AsString := qryDadosImportacao.FieldByName('ITE_REGTRI').AsString;
      qryComand.ExecSQL;
      qryDadosImportacao.Next;
      pgbProgresso.Position := qryDadosImportacao.RecNo;
      Application.ProcessMessages;
    End;
    pMensagemOk('Gravação concluída com sucesso!');
  Finally
    FreeAndNil(qryComand);
  End;
  Result := True;
end;

function TfrmAtualizacaoMargemParaFranquias.fImportaArquivo: Boolean;
var frmImportando:TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmImportando);
  Try
    frmImportando.lblGravando.Caption := 'Importando Arquivo';
    frmImportando.fExecutarAcao := fImportaArquivoAux;
    frmImportando.ShowModal;
    Result := frmImportando.blnConfirma;
  Finally
    pFreeAndNil(frmImportando);
  End;
end;


function TfrmAtualizacaoMargemParaFranquias.fRetDesRegTri(strRegTri: string): String;
begin
  If strRegTri = 'R' Then
    Result := '3 - Lucro Real'
  Else If strRegTri = 'P' Then
    Result := '2 - Lucro Presumido'
  Else If strRegTri = 'S' Then
    Result := '1 - Simples Nacional'
End;


function TfrmAtualizacaoMargemParaFranquias.fImportaArquivoAux(
  pgbProgresso: TcxProgressBar): Boolean;
  var i,intLinha: Integer;
      strCodite: String;
      strRegTri: String;
      strCodEmp: String;

begin
  pgbProgresso.Properties.Max := objValidaExcel.ArquivoCSV.Count;
  pgbProgresso.Position := 0;
  for intLinha := 1 to objValidaExcel.ArquivoCSV.Count -1 Do
  Begin
    Try
      strCodEmp := objValidaExcel.fGetValueCSV(intLinha, cEmpresaMatriz);
    Except
      pMensagemOk(i.Tostring)
    End;
    strCodIte := objValidaExcel.fGetValueCSV(intLinha, cCodIte);
    strRegTri := objValidaExcel.fGetValueCSV(intLinha, cRegimeTributario);

    qryDadosImportacaoItem.Close;

    qryDadosImportacaoItem.ParamByName('CODEMP').AsString := strCodEmp;
    qryDadosImportacaoItem.ParamByName('CODITE').AsString := strCodIte;
    qryDadosImportacaoItem.ParamByName('REGTRI').AsString := strRegTri;

    qryDadosImportacaoItem.Open;

    If not qryDadosImportacaoItem.IsEmpty Then
    Begin
      qryDadosImportacao.Insert;
      for i := 0 to qryDadosImportacaoItem.FieldCount -1 do
        qryDadosImportacao.Fields[i].Value := qryDadosImportacaoItem.Fields[i].Value;

      qryDadosImportacao.FieldByName('PRODUTO').AsString := qryDadosImportacao.FieldByName('ITE_CODITE').AsString + '-' +
                                                            qryDadosImportacao.FieldByName('ITE_DESITE').AsString;
      qryDadosImportacao.FieldByName('COD_REGTRI').AsString :=  fRetDesRegTri(qryDadosImportacao.FieldByName('ITE_REGTRI').AsString);


      pCalculaCusto;

      qryDadosImportacao.FieldByName('ITE_MARBR1_NOV').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargemBruta1);
      pCalculaPrecoDeVenda(1);
      qryDadosImportacao.FieldByName('ITE_MARBR2_NOV').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargemBruta2);
      pCalculaPrecoDeVenda(2);
      qryDadosImportacao.FieldByName('ITE_MARBR3_NOV').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargemBruta3);
      pCalculaPrecoDeVenda(3);
      qryDadosImportacao.FieldByName('ITE_MARBR4_NOV').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargemBruta4);
      pCalculaPrecoDeVenda(4);
      qryDadosImportacao.FieldByName('ITE_MARBR5_NOV').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargemBruta5);
      pCalculaPrecoDeVenda(5);
      qryDadosImportacao.FieldByName('ITE_MARBR6_NOV').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargemBruta6);
      pCalculaPrecoDeVenda(6);
      qryDadosImportacao.FieldByName('ITE_MARBR7_NOV').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargemBruta7);
      pCalculaPrecoDeVenda(7);
      qryDadosImportacao.Post;
    End;
    pgbProgresso.Position := intLinha;
    Application.ProcessMessages;
  End;

  Result := True;

  qryDadosImportacaoItem.IndexFieldNames := 'PRODUTO';
end;

procedure TfrmAtualizacaoMargemParaFranquias.pCalculaCusto;
begin
  FcpcParams.curPreCom := qryDadosImportacao.FieldByName('ITE_PRECOM').AsFloat;
  FcpcParams.curDesF01 := qryDadosImportacao.FieldByName('ITE_DESF01').AsFloat;
  FcpcParams.curDesF02 := qryDadosImportacao.FieldByName('ITE_DESF02').AsFloat;
  FcpcParams.curDesF03 := qryDadosImportacao.FieldByName('ITE_DESF03').AsFloat;
  FcpcParams.curDesF04 := qryDadosImportacao.FieldByName('ITE_DESF04').AsFloat;
  FcpcParams.curDesF05 := qryDadosImportacao.FieldByName('ITE_DESF05').AsFloat;
  FcpcParams.curDesF06 := qryDadosImportacao.FieldByName('ITE_DESF06').AsFloat;
  FcpcParams.curICMSEnt:= qryDadosImportacao.FieldByName('ITE_ICMENT').AsFloat;
  FcpcParams.curIPIEnt := qryDadosImportacao.FieldByName('ITE_IPIENT').AsFloat;
  FcpcParams.curFrete  := qryDadosImportacao.FieldByName('ITE_FREENT').AsFloat;
  FcpcParams.curAcrFin := qryDadosImportacao.FieldByName('ITE_ACRFIN').AsFloat;
  FcpcParams.curSubsti := qryDadosImportacao.FieldByName('ITE_SUBSTI').AsFloat;
  FcpcParams.curValFre := qryDadosImportacao.FieldByName('ITE_VALFRE').AsFloat;
  FcpcParams.curDesAdb := qryDadosImportacao.FieldByName('ITE_DESADB').AsFloat;
  FcpcParams.curSubFed := qryDadosImportacao.FieldByName('ITE_SUBFED').AsFloat;
  FcpcParams.curTCIFCu := 0;
  FcpcParams.curTSCust := 0;
  FcpcParams.curDePiCo := 0;
  FcpcParams.curDeICMS := 0;
  FcpcParams.curFatReg := 0;
  qryDadosImportacao.FieldByName('ITE_PRECUS').AsFloat := FcpcParams.fCalculaPrecoCusto(qryDadosImportacao.FieldByName('ITE_PREDOL').AsString = 'S');
  qryDadosImportacao.FieldByName('ITE_CUSREA').AsFloat := fCalculaCustoReal(qryDadosImportacao.FieldByName('ITE_PRECUS').AsFloat,
                                                                  qryDadosImportacao.FieldByName('ITE_ICMSAI').AsFloat,
                                                                  qryDadosImportacao.FieldByName('ITE_IMPFED').AsFloat,
                                                                  qryDadosImportacao.FieldByName('ITE_DESOPE').AsFloat,
                                                                  qryDadosImportacao.FieldByName('ITE_OUTVAL').AsFloat);
End;

procedure TfrmAtualizacaoMargemParaFranquias.pCalculaPrecoDeVenda(intTabPre: integer);
Begin
  qryDadosImportacao.FieldByName('ITE_PREVE' + intTabPre.ToString +'_NOV').AsFloat := fCalculaPrecoVenda(1,
                                                                                       qryDadosImportacao.FieldByName('ITE_PRECUS').AsFloat +
                                                                                       qryDadosImportacao.FieldByName('ITE_OUTVAL').AsFloat,
                                                                                       0,
                                                                                       qryDadosImportacao.FieldByName('ITE_MARBR' + intTabPre.ToString + '_NOV').AsFloat,
                                                                                       qryDadosImportacao.FieldByName('ITE_ICMSAI').AsFloat,
                                                                                       qryDadosImportacao.FieldByName('ITE_IMPFED').AsFloat,
                                                                                       qryDadosImportacao.FieldByName('ITE_DESOPE').AsFloat,
                                                                                       fRetComissao(intTabPre));

End;

function TfrmAtualizacaoMargemParaFranquias.fRetComissao(intTabPre: integer): Double;
begin
  Result := 0;
  case intTabPre of
   1: Result := qryDadosImportacao.FieldByName('ITE_COMTB1').AsFloat;
   2: Result := qryDadosImportacao.FieldByName('ITE_COMTB2').AsFloat;
   3: Result := qryDadosImportacao.FieldByName('ITE_COMTB3').AsFloat;
   4: Result := qryDadosImportacao.FieldByName('ITE_COMTB4').AsFloat;
   5: Result := qryDadosImportacao.FieldByName('ITE_COMTB5').AsFloat;
   6: Result := qryDadosImportacao.FieldByName('ITE_COMTB6').AsFloat;
   7: Result := qryDadosImportacao.FieldByName('ITE_COMTB7').AsFloat;
  End;
End;


end.
