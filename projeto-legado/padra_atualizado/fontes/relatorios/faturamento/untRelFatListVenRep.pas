unit untRelFatListVenRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, StdCtrls, Mask, MaskEditFocus, RLFilters,
  RLDraftFilter, Menus, EditFocus, QColorLabel, Buttons, ExtCtrls, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts, ComObj, untTypesSistema,
  untRelGeraOr, untfuncoesSimples, BitBtnLockedIncrem, TypesRel,
  untExcel, untZClient, cxHint, ComCtrls, dxScreenTip, cxClasses, dxCustomHint,
  untFuncoesRel, frxExportCSVTestabilidade, DateUtils;

type
  TfrmRelFatListVenRep = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    lblEmpresa: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtProdutos: TEditFocus;
    edtFornecedor: TEditFocus;
    edtVendedor: TEditFocus;
    edtMarca: TEditFocus;
    lstClaFis: TMemo;
    gpbTipo: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTipo: TEditFocus;
    edtEmpresa: TEditFocus;
    edtDesGrupo: TEditFocus;
    edtDesProduto: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label1: TLabel;
    edtCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    lblDescricao: TLabel;
    Label4: TLabel;
    Label13: TLabel;
    edtDescri: TEditFocus;
    edtRefere: TEditFocus;
    edtUnidade: TEditFocus;
    gpbOrdenar: TGroupBox;
    lblOrdena: TColorLabel;
    edtOrdena: TEditFocus;
    gbpEspecie: TGroupBox;
    edtEspecie: TEditFocus;
    svdExcel: TSaveDialog;
    chkSupEst: TCheckBox;
    chkSalMat: TCheckBox;
    chkGerOrc: TCheckBox;
    chkIncBon: TCheckBox;
    rdgEmpresa: TRadioGroup;
    Label16: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    HintControler: TcxHintStyleController;
    prgProBar: TProgressBar;
    chkAbaMul: TCheckBox;
    btnAltOrc: TBitBtnLocked;
    rdgLocFis: TRadioGroup;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    Label14: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    chkCodFab: TCheckBox;
    rdgSaldo: TRadioGroup;
    chkIncluirFiliais: TCheckBox;
    chkEntFut: TCheckBox;
    Label18: TLabel;
    edtCodGruPro: TEditFocus;
    edtDesGruPro: TEditFocus;
    rdgGirEst: TRadioGroup;
    chkMesAtu: TCheckBox;
    rdgSaldoProduto: TRadioGroup;
    Label8: TLabel;
    Label15: TLabel;
    mskHorIni: TMaskEditFocus;
    mskHorFin: TMaskEditFocus;
    frxReportJ: TfrxReport;
    chkPedCompraAberto: TCheckBox;
    chkItensAbaixoMinimo: TCheckBox;
    edtDesDepartamento: TEditFocus;
    edtDepartamento: TEditFocus;
    Label17: TLabel;
    chkExbDep: TCheckBox;
    procedure pCarregaGrupo(Var qryCadGru: TUniQuery);
    procedure pCarregaMarca(Var qryCadMar: TUniQuery);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure pAtualizaClafis;
    procedure FormShow(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoEnter(Sender: TObject);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtVendedorExit(Sender: TObject);
    procedure edtVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtUnidadeExit(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure btnAltOrcClick(Sender: TObject);
    procedure edtTipoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure chkAbaMulEnter(Sender: TObject);
    procedure chkAbaMulExit(Sender: TObject);
    procedure chkGerOrcClick(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGruProExit(Sender: TObject);
    procedure edtCodGruProKeyPress(Sender: TObject; var Key: Char);
    procedure rdgGirEstClick(Sender: TObject);
    procedure edtDepartamentoExit(Sender: TObject);
    procedure edtDepartamentoKeyPress(Sender: TObject; var Key: Char);
  private
    qryGenMar: TUniQuery;
    qryGenUni: TUniQuery;
    qryGenGru: TUniQuery;
    objGeraOR: TRelGeraOR;
    cdsItens : TZClient;

    arrLinhaClien,
    arrRede,
    arrLinhaGrupo,
    arrProduto,
    arrDepartamento,
    arrMarca,
    arrVendedor,
    arrUnidade,
    arrFornecedor,
    arrEmpresa,
    arrGruCmp,
    arrGrupoPro: TConsultasArray;

    strEmpresas,

    strLinhaClien,
    strRede,
    strLinhaGrupo,
    strProduto,
    strDepartamento,
    strMarca,
    strVendedor,
    strUnidade,
    strFornecedor,
    strEmpresa,
    strGruCmp,
    strGrpPro: String;

    procedure pSetaParametros(qryItens: TUniQuery; blnOpcOrc: Boolean; strCodEmpCD: String='');

    procedure pExportaExcel;
    procedure pCabecExcel(objExcel: TExcel);
    procedure pFormataExcel(objExcel: TExcel);
    Procedure pAbreQueryItens(strEmpresas: String; qryItens: TZClient; strCodEmpCD: String='');

    Function fRetSql(strOpcTab: String; blnOpcOrc: Boolean = False): String;
    Function fRetSqlRel(blnOpcOrc: Boolean = False; strEmpresas: String = ''; strCodEmpCD: String = ''): String;
    function fGetSqlPesoLitroKilo(strCampo: String; strTipUni: String): String;
    function fGetLetra: Char;
    function fRetSqlSaldo(strCodigo: String; blnOpcOrc: Boolean): String;
    function fRetSqlEstMin(strCodigo: String; blnOpcOrc: Boolean): String;
    function fRetSalDis(strAliasIteger, strAliasCadite: string): string;
    function fRetTipSal(strTipoSaldo: string): string;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    fGravaFatGor     : TfGravaFatGor;
    fGravaFatDor     : TfGravaFatDor;
    blnBEFTRG        : Boolean;
    strEmpCD         : string;
  end;

var
  frmRelFatListVenRep: TfrmRelFatListVenRep;

implementation

uses DB, untConsultas, untSaldoPedidoCompra,
     untFuncoesConsulta, untFuncTinta, untConstantes, untMsgValidacaoGeracaoOrcPed, untITintasDeMaquina;

{$R *.dfm}

procedure TfrmRelFatListVenRep.FormShow(Sender: TObject);
begin
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtEmpresa.Text := VS_strCodEmp;
  edtEmpresaExit(Sender);

  objGeraOR := TRelGeraOR.Create(Self, fGravaFatGor, fGravaFatDor, pAbreQueryItens);

  shpMultSel.Visible := True;

  psetFocus(mskDtaIni);

  inherited;
end;

procedure TfrmRelFatListVenRep.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelFatListVenRep.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    fValidaCampos(mskLinhaGrupo,False);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatListVenRep.pCarregaGrupo(Var qryCadGru: TUniQuery);
begin

  If Not (fEmptyStr(mskLinhaGrupo.Text)) Then
    edtDesGrupo.Text := qryCadGru.FieldByName('GRU_DESGRU').AsString
  Else
    edtDesGrupo.Text := '';

end;

procedure TfrmRelFatListVenRep.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
  edtProdutos.Clear;
  edtDesProduto.Text := '';
  pDesmarcaLista(edtProdutos,arrProduto)
end;

procedure TfrmRelFatListVenRep.edtProdutosExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtProdutos,edtDesProduto,arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmRelFatListVenRep.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte: TUniQuery;
begin
  inherited;

  qryGenIte := fCriaQuery(nil);

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryGenIte);

end;

procedure TfrmRelFatListVenRep.edtMarcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelFatListVenRep.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatListVenRep.pCarregaMarca(Var qryCadMar: TUniQuery);
begin

  If Not fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := qryCadMar.FieldByName('MAR_DESMAR').AsString
  Else
    edtDesFornecedor.Text := '';

end;

procedure TfrmRelFatListVenRep.edtClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCliente,edtDesCliente,arrLinhaClien,nil,fRetNomCliente,'do cliente');

  If Not fEmptyStr(edtCliente.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetFocus(edtFornecedor);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmRelFatListVenRep.edtClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliente, edtDesCliente, Nil, Key, arrLinhaClien, False) Then
  Begin
    If fValidaCampos(edtCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatListVenRep.edtCodGruProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGruPro,edtDesGruPro,arrGrupoPro,fRetNomeGrupoProduto,nil,'do Grupo de Produtos',edtCodGruPro.MaxLength);
end;

procedure TfrmRelFatListVenRep.edtCodGruProKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupoProduto(Self, edtCodGruPro, edtDesGruPro, Nil, Key, arrGrupoPro, False) Then
  Begin
    If fValidaCampos(edtCodGruPro, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatListVenRep.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelFatListVenRep.edtCodRedeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatListVenRep.pCarregaCliente(Var qryCadCli: TUniQuery);
begin

  If Not (fEmptyStr(edtCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';

end;

procedure TfrmRelFatListVenRep.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornecedor,fRetNomFornecedor,Nil ,'do forncedor');
end;

procedure TfrmRelFatListVenRep.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornecedor, False) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatListVenRep.edtGruCmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmRelFatListVenRep.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatListVenRep.edtVendedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtVendedor, edtDesVendedor, arrVendedor, fRetNomVendRep,nil, 'do Vendedor');
end;

procedure TfrmRelFatListVenRep.edtVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtVendedor, edtDesVendedor, nil, Key, arrVendedor, False) Then
  Begin
    If fValidaCampos(edtVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelFatListVenRep.fGetLetra: Char;
Begin
  If (edtTipo.Text = 'A') Then
    Result := 'F'
  Else
  Begin
    If chkCodFab.Checked and chkExbDep.Checked Then
      Result := 'I'
    Else If chkCodFab.Checked or chkExbDep.Checked Then
      Result := 'H'
    Else
      Result := 'G';
  End;
end;

function TfrmRelFatListVenRep.fGetSqlPesoLitroKilo(strCampo,
  strTipUni: String): String;
begin
  Result := ' IF(COALESCE(IF(TRIM(UNI_KILLIT) = "", "L", UNI_KILLIT), "L") = "' + strTipUni + '", ' + strCampo + ', 0) ';
end;

procedure TfrmRelFatListVenRep.edtEmpresaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtEmpresa, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelFatListVenRep.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatListVenRep.pCabecExcel(objExcel: TExcel);
Begin
  With objExcel Do
  Begin
    LinhaAtual := 01;

    Escrever(LinhaAtual, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

    If edtTipo.Text = 'A' Then
    Begin

      If edtOrdena.Text = 'G' Then
        Escrever(ProximaLinha, 01, 'RELATORIO DE VENDAS PARA REPOSICAO - GRUPO + ALFA - ANALITICO **')
      Else If edtOrdena.Text = 'F' Then
        Escrever(ProximaLinha, 01, 'RELATORIO DE VENDAS PARA REPOSICAO - FORNECEDOR + ALFA - ANALITICO **')
      Else
        Escrever(ProximaLinha, 01, 'RELATORIO DE VENDAS PARA REPOSICAO - ALFABETICO - ANALITICO **');

    End
    Else
    Begin

      If edtOrdena.Text = 'G' Then
        Escrever(ProximaLinha, 01, 'RELATORIO DE VENDAS PARA REPOSICAO - GRUPO + ALFA - SINTETICO **')
      Else If edtOrdena.Text = 'F' Then
        Escrever(ProximaLinha, 01, 'RELATORIO DE VENDAS PARA REPOSICAO - FORNECEDOR + ALFA - SINTETICO **')
      Else
        Escrever(ProximaLinha, 01, 'RELATORIO DE VENDAS PARA REPOSICAO - ALFABETICO - SINTETICO **');

    End;

    Escrever(ProximaLinha, 01, 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

    Escrever(ProximaLinha, 01, fStrTitulo(mskLinhaGrupo.Text, edtDesGrupo, arrLinhaGrupo, strLinhaGrupo, 'LINHA/GRUPO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtProdutos.Text, edtDesProduto, arrProduto, strProduto, 'PRODUTO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtDepartamento.Text, edtDesDepartamento, arrDepartamento, strDepartamento, 'DEPARTAMENTO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtMarca.Text, edtDesMarca, arrMarca, strMarca, 'MARCA'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtGruCmp.Text, edtDesGruCmp, arrGruCmp, strGruCmp, 'GRUPO DE COMPRAS'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCliente.Text, edtDesCliente, arrLinhaClien, strLinhaClien, 'CLIENTE'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtFornecedor.Text, edtDesFornecedor, arrFornecedor, strFornecedor, 'FORNECEDOR'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtVendedor.Text, edtDesVendedor, arrVendedor, strVendedor, 'VENDEDOR'));

    If Not fEmptyStr(edtDescri.Text) Then
      Escrever(ProximaLinha, 01, 'DESCRICAO: ' + edtDescri.Text)
    Else
      Escrever(ProximaLinha, 01, 'DESCRICAO: TODOS ');

    If Not fEmptyStr(edtRefere.Text) Then
      Escrever(ProximaLinha, 01, 'REFERENCIA: ' + edtRefere.Text)
    Else
      Escrever(ProximaLinha, 01, 'REFERENCIA: TODOS ');

    Escrever(ProximaLinha, 01, fStrTitulo(edtUnidade.Text, nil, arrUnidade, strUnidade, 'UNIDADE'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA'));

    case rdgSaldo.ItemIndex of
      0 : Escrever(ProximaLinha, 01, 'SALDO: POSITIVO ');
      1 : Escrever(ProximaLinha, 01, 'SALDO: NEGATIVO ');
      2 : Escrever(ProximaLinha, 01, 'SALDO: ZERO ');
      3 : Escrever(ProximaLinha, 01, 'SALDO: TODOS ');
    end;

    If Not fEmptyStr(edtEspecie.Text) Then
      Escrever(ProximaLinha, 01, 'ESPECIE: ' + edtEspecie.Text)
    Else
      Escrever(ProximaLinha, 01, 'ESPECIE: TODOS ');

    If edtTipo.Text = 'A' Then
    Begin
      ProximaLinha;

      Escrever(LinhaAtual, 01, 'DATA DOC');
      Escrever(LinhaAtual, 02, 'DOCUMENTO');
      Escrever(LinhaAtual, 03, 'CODIGO / NOME CLIENTE');
      Escrever(LinhaAtual, 04, 'EMPRESA');
      Escrever(LinhaAtual, 05, 'VENDEDOR');
      Escrever(LinhaAtual, 06, 'QTD. VENDIDA');
    End

    Else
    Begin
      ProximaLinha;

      Escrever(LinhaAtual, 01, 'CÓDIGO');
      Escrever(LinhaAtual, 02, 'DESCRIÇÃO');
      Escrever(LinhaAtual, 03, 'SALDO');
      Escrever(LinhaAtual, 04, 'UNIDADE');
      Escrever(LinhaAtual, 05, 'MARCA');

      ColunaAtual := 06;

      if chkExbDep.Checked then
      begin
        Escrever(LinhaAtual, ColunaAtual, 'DEPARTAMENTO');
        ColunaAtual := Succ(ColunaAtual);
      end;

      If chkCodFab.Checked Then
      Begin
        Escrever(LinhaAtual, ColunaAtual, 'CÓD.FAB.');
        ColunaAtual := Succ(ColunaAtual);
      End;

      Escrever(LinhaAtual, ColunaAtual, 'QTD. TOTAL VENDIDA');
      ColunaAtual := Succ(ColunaAtual);
      Escrever(LinhaAtual, ColunaAtual, 'KGS/LTS');
      ColunaAtual := Succ(ColunaAtual);
    End;
  End;

End;

procedure TfrmRelFatListVenRep.pFormataExcel(objExcel: TExcel);
  Var
    strLetra : Char;
Begin
  strLetra := fGetLetra;

  With objExcel Do
  Begin
    {********************************}
    {* MESCLA AS COLUNAS            *}
    {*****************************LA*}

    Mesclar('A1',strLetra + '1');
    Mesclar('A2',strLetra + '2');
    Mesclar('A3',strLetra + '3');
    Mesclar('A4',strLetra + '4');
    Mesclar('A5',strLetra + '5');
    Mesclar('A6',strLetra + '6');
    Mesclar('A7',strLetra + '7');
    Mesclar('A8',strLetra + '8');
    Mesclar('A9',strLetra + '9');
    Mesclar('A10',strLetra + '10');
    Mesclar('A11',strLetra + '11');
    Mesclar('A12',strLetra + '12');
    Mesclar('A13',strLetra + '13');
    Mesclar('A14',strLetra + '14');
    Mesclar('A15',strLetra + '15');
    Mesclar('A16',strLetra + '16');
    Mesclar('A17',strLetra + '17');
    Mesclar('A18',strLetra + '18');

    {**************************************************}
    {* COLOCA EM NEGRITO E ALINHA AO CENTRO DA CELULA *}
    {***********************************************LA*}
    Alinhamento('A1',strLetra + '18', Centro);
    Negrito('A1',strLetra + '18', True);

    {*************************************}
    {* COLORE O FUNDO DA CELULA P/ CINZA *}
    {**********************************LA*}
    CorFundo('A1',strLetra + '2', Cinza);

    {********************************}
    {* INSERE BORDAS NA CELULA      *}
    {*****************************LA*}
    Bordas('A1',strLetra + '2');
    Bordas('A3',strLetra + '18');

    Bordas('A19',strLetra + '19');
    CorFundo('A19',strLetra + '19', Cinza);
  End;
End;

procedure TfrmRelFatListVenRep.pExportaExcel;
  Var
    objExcel : TExcel;
    fltQtdIte: Double;
    fltQtdAna: Double;
    fltTotKgs: Double;
    fltTotLts: Double;
    strCodIte: String;
    strLetra: String;
    intColLe: Integer;
    strLetraQtd: String;
    intColLeQtd: Integer;

    Procedure pTotalItem;
    Begin
      With objExcel Do
      Begin
        Escrever(LinhaAtual, 01, 'QUANTIDADE VENDIDA:');
        Mesclar('A' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 06, FloatToStrF(fltQtdAna, ffFixed, 12, 2));
        CorFundo('A' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual), Cinza);
        Alinhamento(LinhaAtual, 06, Direita);
        ProximaLinha;
        ProximaLinha;
      End;
    End;

Begin
  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  Begin
    FreeAndNil(objExcel);
    Exit;
  End;

  pCabecExcel(objExcel);
  pFormataExcel(objExcel);

  fltQtdIte := 0;
  fltQtdAna := 0;
  fltTotKgs := 0;
  fltTotLts := 0;
  strCodIte := '';

  With objExcel Do
  Begin
    With cdsItens Do
    Begin
      First;
      ProximaLinha;

      While (Not Eof) Do
      Begin

        If edtTipo.Text = 'A' Then
        Begin

          If strCodIte <> LeftStr(FieldByName('CODITE').AsString, 13) Then
          Begin
            If Not fEmptyStr(strCodIte) Then
              pTotalItem;

            Mesclar('B' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
            Escrever(LinhaAtual, 01, 'PRODUTO:');
            Escrever(LinhaAtual, 02, FieldByName('CODITE').AsString);
            CorFundo('A' + IntToStr(LinhaAtual),'F' + IntToStr(LinhaAtual), Cinza);
            ProximaLinha;

            fltQtdAna := 0;

          End;

          strCodIte := LeftStr(FieldByName('CODITE').AsString, 13);

          Escrever(LinhaAtual, 01, FieldByName('DTADOC').AsString);
          Escrever(LinhaAtual, 02, FieldByName('NUMDOC').AsString);
          Escrever(LinhaAtual, 03, FieldByName('CODCLI').AsString);
          Escrever(LinhaAtual, 04, FieldByName('CODEMP').AsString);
          Escrever(LinhaAtual, 05, FieldByName('CODVEN').AsString);
          Escrever(LinhaAtual, 06, FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 2));
          Alinhamento(LinhaAtual, 06, Direita);
        End
        Else
        Begin
          Escrever(LinhaAtual, 01, LeftStr(FieldByName('CODITE').AsString, 13));
          Escrever(LinhaAtual, 02, Copy(FieldByName('CODITE').AsString, 13, Length(FieldByName('CODITE').AsString) - 12));
          Escrever(LinhaAtual, 03, FloatToStrF(FieldByName('SALDOS').AsFloat, ffFixed, 12, 2));
          Alinhamento(LinhaAtual, 03, Direita);
          Escrever(LinhaAtual, 04, FieldByName('UNIDAD').AsString);
          Escrever(LinhaAtual, 05, FieldByName('CODMAR').AsString);

          ColunaAtual := 06;

          if chkExbDep.Checked then
          begin
            Escrever(LinhaAtual, ColunaAtual, FieldByName('CODDEP').AsString);
            ColunaAtual := Succ(ColunaAtual);
          end;

          If chkCodFab.Checked Then
          Begin
            Escrever(LinhaAtual, ColunaAtual, FieldByName('CODFAB').AsString);
            ColunaAtual := Succ(ColunaAtual);
          End;

          Escrever(LinhaAtual, ColunaAtual, FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 2));
          Alinhamento(LinhaAtual, ColunaAtual, Direita);
          ColunaAtual := Succ(ColunaAtual);

          Escrever(LinhaAtual, ColunaAtual, FloatToStrF(FieldByName('LITROS').AsFloat, ffFixed, 12, 4));
          Alinhamento(LinhaAtual, ColunaAtual, Direita);
          ColunaAtual := Succ(ColunaAtual);
        End;

        fltQtdIte := fltQtdIte + FieldByName('QTDITE').AsFloat;
        fltQtdAna := fltQtdAna + FieldByName('QTDITE').AsFloat;

        fltTotKgs := fltTotKgs + FieldByName('TOTKIL').AsFloat;
        fltTotLts := fltTotLts + FieldByName('TOTLIT').AsFloat;

        ProximaLinha;

        Next;
      End;

      If edtTipo.Text = 'A' Then
        pTotalItem
      Else
        ProximaLinha;

      strLetra:=fGetLetra;
      intColLe:=fGetPosLetraAlfa(strLetra);

      If edtTipo.Text = 'S' Then
      Begin
        strLetraQtd:=fGetLetraAlfaAnterior(strLetra);
        intColLeQtd:=fGetPosLetraAlfa(strLetraQtd);;
      End
      Else
      Begin
        strLetraQtd:=strLetra;
        intColLeQtd:=intColLe;
      End;

      Escrever(LinhaAtual, 01, 'QUANTIDADE VENDIDA GERAL:');
      Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfaAnterior(strLetraQtd) + IntToStr(LinhaAtual));
      Escrever(LinhaAtual, intColLeQtd, FloatToStrF(fltQtdIte, ffFixed, 12, 2));
      CorFundo('A' + IntToStr(LinhaAtual), strLetraQtd + IntToStr(LinhaAtual), Cinza);
      Alinhamento(LinhaAtual, intColLeQtd, Direita);

      If edtTipo.Text = 'S' Then
      Begin
        ProximaLinha;
        Escrever(LinhaAtual, 01, 'TOTAL LITROS:');
        Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfaAnterior(strLetra) + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, intColLe, FloatToStrF(fltTotLts, ffFixed, 12, 2));
        CorFundo('A' + IntToStr(LinhaAtual),strLetra + IntToStr(LinhaAtual), Cinza);
        Alinhamento(LinhaAtual, intColLe, Direita);

        ProximaLinha;
        Escrever(LinhaAtual, 01, 'TOTAL KILOS:');
        Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfaAnterior(strLetra) + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, intColLe, FloatToStrF(fltTotKgs, ffFixed, 12, 2));
        CorFundo('A' + IntToStr(LinhaAtual),strLetra + IntToStr(LinhaAtual), Cinza);
        Alinhamento(LinhaAtual, intColLe, Direita);
      End;
    End;

    CongelarPaines('A19');

    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

    fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);

  End;

  FreeAndNil(objExcel);
End;

Function TfrmRelFatListVenRep.fRetSql(strOpcTab: String; blnOpcOrc: Boolean = False): String;
var
  strSQL   : String;
  tintas   : ITintasDeMaquina;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

  If blnOpcOrc Then
  Begin
    strSQL := strSQL + '  ' + strOpcTab + '.DET_CODITE AS CODITE, ';
    strSQL := strSQL + '  ' + strOpcTab + '.DET_DESCRI AS DESCRI, ';
    strSQL := strSQL + '  ' + strOpcTab + '.DET_CODEMP AS CODEMP, ';
  End
  Else
  Begin
    strSQL := strSQL + '  ' + strOpcTab + '.DET_CODITE AS CODIGO, ';
    strSQL := strSQL + '  CONCAT(CONCAT(LEFT(ITE_CODGRU,3),".",RIGHT(ITE_CODGRU,3),".",' + strOpcTab + '.DET_CODITE),"-",' + strOpcTab + '.DET_DESCRI) AS CODITE, ';
    strSQL := strSQL + '  ITE_CODSIM AS CODSIM, ';
    strSQL := strSQL + '  ' + strOpcTab + '.DET_DESCRI AS DESCRI, ';
    strSQL := strSQL + '  ' + strOpcTab + '.DET_CODITE AS CODPRO, ';
    strSQL := strSQL + '  ITE_CODGRU AS CODGRU, ';
    strSQL := strSQL + '  CONCAT(MAR_CODMAR,"-",MAR_DESMAR) AS CODMAR, ';
    strSQL := strSQL + '  ' + strOpcTab + '.DET_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  CONCAT(' + strOpcTab + '.DET_NUMDOC,"-",' + strOpcTab + '.DET_ESPDOC) AS NUMDOC, ';
    strSQL := strSQL + '  CONCAT(' + strOpcTab + '.DET_CODCLI,"-",CLI_NOMCLI) AS CODCLI, ';
    strSQL := strSQL + '  ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  F.FOR_NOMFOR AS NOMFOR, ';
    strSQL := strSQL + '  CONCAT(' + strOpcTab + '.DET_CODVEN,"-",OPE_NOMOPE) AS CODVEN, ';
    strSQL := strSQL + '  ' + strOpcTab + '.DET_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  ' + strOpcTab + '.DET_DTADOC AS DTADOC, ';
    strSQL := strSQL + '  UNI_SIGUNI AS UNIDAD, ';
    strSQL := strSQL + '  ' + strOpcTab + '.DET_REFERE AS REFERE, ';
    strSQL := strSQL + '  ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '  CONCAT(DEP_CODIGO, "-", DEP_DESCRI) AS CODDEP, ';

    If chkSupEst.Checked Then
    Begin
      strSQL := strSQL + '  ITE_LOCFIS AS LOCFIS, ';
      strSQL := strSQL + '  ITE_LOCSUP AS LOCSUP, ';
    End;
  End;

  strSQL := strSQL + '  SUM(IF(LEFT('+ '  ' + strOpcTab + '.DET_CLAFIS, 1) < 5, -('+ '  ' + strOpcTab + '.DET_QTDITE), '+ '  ' + strOpcTab + '.DET_QTDITE) * ' + fStrRelFatorLit(strOpcTab + '.') + ') AS LITROS, ';

  {******************************************************}
  {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
  {****************************************************FC}
  strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('(IF(LEFT('+ '  ' + strOpcTab + '.DET_CLAFIS,1) < 5, -('+ '  ' + strOpcTab + '.DET_QTDITE), '+ '  ' + strOpcTab + '.DET_QTDITE) * ' + fStrRelFatorLit(strOpcTab + '.') + ')', 'L') + ') AS TOTLIT, ';
  strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('(IF(LEFT('+ '  ' + strOpcTab + '.DET_CLAFIS,1) < 5, -('+ '  ' + strOpcTab + '.DET_QTDITE), '+ '  ' + strOpcTab + '.DET_QTDITE) * ' + fStrRelFatorLit(strOpcTab + '.') + ')', 'K') + ') AS TOTKIL, ';

  strSQL := strSQL + '  SUM(IF(LEFT(' + strOpcTab + '.DET_CLAFIS,1) < 5, -(' + strOpcTab + '.DET_QTDITE), ' + strOpcTab + '.DET_QTDITE) / IF(ITE_CNV_ML > 0, ITE_CNV_ML, 1)) AS QTDITE ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET NOR ';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON NOR.DET_CODVEN = OPE_CODOPE     ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI     = NOR.DET_CODCLI ';

  If SameText(strOpcTab, 'ML') Then
  Begin
    strSQL := strSQL + '  INNER JOIN MOVDET ML ON                ';
    strSQL := strSQL + '    ML.DET_CODCLI = NOR.DET_CODCLI AND   ';
    strSQL := strSQL + '    ML.DET_NUMFAT = NOR.DET_NUMDOC AND   ';
    strSQL := strSQL + '    ML.DET_TIPFAT = NOR.DET_ESPDOC AND   ';
    strSQL := strSQL + '    ML.DET_EMPFAT = NOR.DET_CODEMP AND   ';
    strSQL := strSQL + '    ML.DET_ESPDOC = "ML"                 ';
  End;

  strSQL := strSQL + '  LEFT JOIN CADITE I ON I.ITE_CODITE = ' + strOpcTab + '.DET_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADMAR ON ITE_CODMAR     = MAR_CODMAR     ';
  strSQL := strSQL + '  LEFT JOIN CADDEP ON ITE_CODDEP     = DEP_CODIGO     ';

  strSQL := strSQL + '   LEFT JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN ITEGER G ON (G.ITE_CODITE = ' + strOpcTab + '.DET_CODITE AND ';
  strSQL := strSQL + '                          G.ITE_CODEMP = ' + strOpcTab + '.DET_CODEMP) ';

  strSQL := strSQL + '  LEFT JOIN CADUNI ON ' + strOpcTab + '.DET_UNIDAD = UNI_CODUNI ';

  If rdgLocFis.ItemIndex in [0,1] Then
    strSQL := strSQL + '  LEFT JOIN CADLOT ON LOT_CODITE = I.ITE_CODITE ';

  strSQL := strSQL + ' LEFT JOIN MOVTRI TRI ON TRI.DET_SEQGER = NOR.AUTOINCREM ';

  strSQL := strSQL + ' WHERE ';

  If fEmptyStr(edtEspecie.Text) Then
  Begin
    strSQL := strSQL + cnsFiltroFFDVTR;
  End;

  If (VS_strUsaTmq = 'S') Then
  Begin
    tintas := fGetTintasdeMaquina;
    strSQL := strSQL + '  ((NOR.DET_IDEPRO = "NOR") OR (LOCATE(NOR.DET_IDEPRO,"' + tintas.fGetImobiliarias + '") > 0)) AND ';
  End;

  IF Not(chkIncluirFiliais.Checked) Then
    strSQL := strSQL + '  NOR.DET_CODCLI NOT IN (' + VS_strCliFil + ') AND '; {EDUARDO}

  strSQL := strSQL + '  NOR.DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '  NOR.DET_TIP_FC =  "C" AND ';
  strSQL := strSQL + '  NOR.DET_ESPDOC <> "AJ" AND ';
  strSQL := strSQL + '  NOR.DET_ESPDOC <> "BR" AND ';
  strSQL := strSQL + '  (LOCATE(NOR.DET_CLAFIS, :CLAFIS) > 0) AND ';
  strSQL := strSQL + '  NOR.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskHorIni.Text, True, False, False, True)) And Not fEmptyStr(fTiraCaracEspeciais(mskHorFin.Text, True, False, False, True)) Then
    strSQL := strSQL + '  AND NOR.DET_HORENT BETWEEN :HORINI AND :HORFIN ';

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
    strSQL := strSQL + fSQLIn(mskLinhaGrupo, arrLinhaGrupo, 'ITE_CODGRU', 'CODGRU');

  If Not fEmptyStr(edtProdutos.Text) Then
    strSQL := strSQL + fSQLIn(edtProdutos, arrProduto, strOpcTab + '.DET_CODITE', 'CODITE');

  If Not fEmptyStr(edtDepartamento.Text) Then
    strSQL := strSQL + fSQLIn(edtDepartamento, arrDepartamento, 'ITE_CODDEP', 'CODDEP');

  If Not fEmptyStr(edtCodGruPro.Text) Then
    strSQL := strSQL + fSQLIn(edtCodGruPro, arrGrupoPro, 'I.ITE_PRDGRU', 'PRDGRU');

  If Not fEmptyStr(edtMarca.Text) Then
    strSQL := strSQL + fSQLIn(edtMarca, arrMarca, 'ITE_CODMAR', 'CODMAR');

  If Not fEmptyStr(edtGruCmp.Text) Then
    strSQL := strSQL + fSQLIn(edtGruCmp, arrGruCmp, 'I.ITE_GRUCMP', 'CODCOM');

  If Not fEmptyStr(edtCliente.Text) Then
    strSQL := strSQL + fSQLIn(edtCliente, arrLinhaClien, 'CLI_CODCLI', 'CODCLI');

  {****************************}
  {* FILTRO REDE DE LOJAS     *}
  {*************************DP*}
  strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

  If Not fEmptyStr(edtFornecedor.Text) Then
    strSQL := strSQL + fSQLIn(edtFornecedor, arrFornecedor, 'ITE_CODFOR', 'CODFOR');

  If Not fEmptyStr(edtVendedor.Text) Then
    strSQL := strSQL + fSQLIn(edtVendedor, arrVendedor, 'OPE_CODOPE', 'CODVEN');

  {**********************************************}
  {* EMPRESA DE FATURAMENTO / EMRPESA DE ORIGEM *}
  {*******************************************DP*}

  If blnOpcOrc Then
  Begin

    If fEmptyStr(strEmpresas) Then
    Begin

      Case rdgEmpresa.ItemIndex Of
        0:strSQL := strSQL + '  AND LOCATE(NOR.DET_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
        1:strSQL := strSQL + '  AND LOCATE(TRI.DET_EMPORI, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
      End;

    End Else
    Begin

      Case rdgEmpresa.ItemIndex Of
        0:strSQL := strSQL + '  AND NOR.DET_CODEMP IN (' + fCommaTextToQuoted(strEmpresas) + ') ';
        1:strSQL := strSQL + '  AND TRI.DET_EMPORI IN (' + fCommaTextToQuoted(strEmpresas) + ') ';
      End;

    End;

  End Else
  Begin

    If Not fEmptyStr(edtEmpresa.Text) Then
    Begin

      Case rdgEmpresa.ItemIndex Of
        0: strSQL := strSQL + fSQLIn(edtEmpresa, arrEmpresa, 'NOR.DET_CODEMP', 'CODEMP');
        1: strSQL := strSQL + fSQLIn(edtEmpresa, arrEmpresa, 'TRI.DET_EMPORI', 'CODEMP');
      End;

    End
    Else
    Begin

      Case rdgEmpresa.ItemIndex Of
        0:strSQL := strSQL + '  AND LOCATE(NOR.DET_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
        1:strSQL := strSQL + '  AND LOCATE(TRI.DET_EMPORI, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
      End;

    End;

  End;

  If Not fEmptyStr(edtRefere.Text) Then
    strSQL := strSQL + ' AND ' + strOpcTab + '.DET_REFERE LIKE :REFERE ';

  If Not fEmptyStr(edtDescri.Text) Then
    strSQL := strSQL + ' AND ' + strOpcTab + '.DET_DESCRI LIKE :DESCRI ';

  If Not fEmptyStr(edtUnidade.Text) Then
    strSQL := strSQL + fSQLIn(edtUnidade, arrUnidade, strOpcTab + '.DET_UNIDAD', 'UNIDAD');

  If SameText(strOpcTab, 'NOR') Then
  Begin
    If Not fEmptyStr(edtEspecie.Text) Then
      strSQL := strSQL + ' AND NOR.DET_ESPDOC = :ESPDOC ';
  End;

  If chkSupEst.Checked Then
  Begin
    strSQL := strSQL + '  AND G.ITE_LOCSUP <> ""  ';
    strSQL := strSQL + '  AND G.ITE_LOCSUP IS NOT NULL ';
  End;

  If chkSalMat.Checked Then
  Begin
    strSQL := strSQL + ' AND (SELECT G.ITE_SALDOS FROM ITEGER G     ';
    strSQL := strSQL + '      WHERE  G.ITE_CODITE = ' + strOpcTab + '.DET_CODITE AND  ';
    strSQL := strSQL + '             G.ITE_CODEMP = :EMPMAT) > 0    ';
  End;

  If (blnBEFTRG) Then
  Begin
    //mostrar as vendas de entrega futura
    If chkEntFut.Checked Then
      strSQL := strSQL + ' AND (DET_FILKAR = FALSE OR DET_ENTFUT = "S") AND DET_DOCFUT IS NULL '
    Else
      strSQL := strSQL + ' AND (DET_FILKAR = FALSE) ';
  End
  Else
  Begin
    //mostrar as vendas de entrega futura
    If chkEntFut.Checked Then
      strSQL := strSQL + ' AND ' + strOpcTab + '.DET_FILKAR = FALSE '
    Else
      strSQL := strSQL + ' AND (' + strOpcTab + '.DET_FILKAR = FALSE OR (' + strOpcTab + '.DET_FILKAR = TRUE AND ' + strOpcTab + '.DET_DOCFUT IS NOT NULL)) ';
  End;

  //mostrar as baixas de entrega futura
  If Not chkEntFut.Checked Then
  Begin
    strSQL := strSQL + '  AND ((' + strOpcTab + '.DET_ENTFUT <> "S") OR (' + strOpcTab + '.DET_PROEMB = "S")) ';

    If fCfgSis('EFTEST') = '2' Then
      strSQL := strSQL + '  AND ' + strOpcTab + '.DET_BXSBIT <> "S" ';
  End;

  {***************************************}
  { LOCALIZAÇÃO FÍSICA: SIM, NÃO E TODOS  }
  {************************************AL*}
  Case rdgLocFis.ItemIndex Of
    0: strSQL := strSQL + '  AND IFNULL(IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS), "") <> "" ';
    1: strSQL := strSQL + '  AND IFNULL(IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS), "") =  "" ';
  End;

  strSQL := strSQL + 'GROUP BY ';

  If blnOpcOrc Then
    strSQL := strSQL + '  CODEMP, ';

  If edtTipo.Text = 'A' Then
    strSQL := strSQL + '  CODITE, NUMDOC '
  Else
    strSQL := strSQL + '  CODITE ';

  Result := strSQL;
End;

function TfrmRelFatListVenRep.fRetTipSal(strTipoSaldo: string): string;
begin
  case AnsiIndexStr(strTipoSaldo, ['FISICO', 'SALREG', 'QTPD_V', 'QTPD_E', 'QTPD_P', 'QTEF_P', 'QTEF_F', 'QTEF_A']) of
    0 : Result := 'IFNULL(ITEGER.ITE_SALDOS + IF(IFNULL(CADITE.ITE_CNV_ML, 0) > 0, ITEGER.ITE_SAL_ML / CADITE.ITE_CNV_ML, 0),0) + ' + IIF(fCfgSis('ENTFUT', varBoolean), '(IFNULL(ITEGER.ITE_QTEF_A,0) + IFNULL(ITEGER.ITE_QTEF_F,0) + IFNULL(ITEGER.ITE_QTEF_P,0))', '0');
    1 : Result := 'IFNULL(IFNULL(ITEGER.ITE_SALREG,0),0)';
    2 : Result := '(IFNULL(ITEGER.ITE_QTPD_V,0)+IFNULL(ITEGER.ITE_QTPD_F,0))';
    3 : Result := 'IFNULL(IFNULL(ITEGER.ITE_QTPD_E,0),0)';
    4 : Result := IIF(fCfgSis('ORDPRO', varBoolean), 'IFNULL(ITEGER.ITE_QTPD_P,0)', '0');
    5 : Result := IIF(fCfgSis('ENTFUT', varBoolean), 'IFNULL(ITEGER.ITE_QTEF_P,0)', '0');
    6 : Result := IIF(fCfgSis('ENTFUT', varBoolean), 'IFNULL(ITEGER.ITE_QTEF_F,0)', '0');
    7 : Result := IIF(fCfgSis('ENTFUT', varBoolean), 'IFNULL(ITEGER.ITE_QTEF_A,0)', '0');
  end;
end;

function TfrmRelFatListVenRep.fRetSalDis(strAliasIteger, strAliasCadite: string): string;
begin
  case fCfgSis('CALSAL', varInteger) of
    1 : Result := '(' + fRetTipSal('FISICO') + ') - (' + fRetTipSal('SALREG') + ') - (' + fRetTipSal('QTPD_V') + ') - (' + fRetTipSal('QTPD_E') + ') - (' + fRetTipSal('QTPD_P') + ')';
    2 : Result := '(' + fRetTipSal('FISICO') + ') - (' + fRetTipSal('SALREG') + ') - (' + fRetTipSal('QTPD_V') + ') - (' + fRetTipSal('QTPD_E') + ') - (' + fRetTipSal('QTPD_P') + ') - (' + fRetTipSal('QTEF_P') + ') - (' + fRetTipSal('QTEF_F') + ') - (' + fRetTipSal('QTEF_A') + ')';
    3 : Result := '(' + fRetTipSal('FISICO') + ') - (' + fRetTipSal('SALREG') + ') - (' + fRetTipSal('QTPD_V') + ') - (' + fRetTipSal('QTPD_E') + ') - (' + fRetTipSal('QTPD_P') + ') - (' + fRetTipSal('QTEF_P') + ') - (' + fRetTipSal('QTEF_A') + ')';
    4 : Result := '(' + fRetTipSal('FISICO') + ') - (' + fRetTipSal('SALREG') + ') - (' + fRetTipSal('QTPD_V') + ') - (' + fRetTipSal('QTPD_E') + ') - (' + fRetTipSal('QTPD_P') + ') - (' + fRetTipSal('QTEF_F') + ')';
    5 : Result := '(' + fRetTipSal('FISICO') + ') - (' + fRetTipSal('SALREG') + ') - (' + fRetTipSal('QTPD_V') + ') - (' + fRetTipSal('QTPD_E') + ') - (' + fRetTipSal('QTPD_P') + ') - (' + fRetTipSal('QTEF_P') + ')';
  end;
  Result := AnsiReplaceStr(AnsiReplaceStr(Result, 'ITEGER', strAliasIteger), 'CADITE', strAliasCadite);
end;

Function TfrmRelFatListVenRep.fRetSqlSaldo(strCodigo: String; blnOpcOrc: Boolean) : String;
var strSQL : String;
Begin
  strSQL := '';
  strSQL := strSQL + '  (SELECT SUM(' + IIF(rdgSaldoProduto.ItemIndex = 0, 'ITEGER.ITE_SALDOS', fRetSalDis('ITEGER', 'CADITE')) + ') FROM ITEGER ';
  strSQL := strSQL + '  LEFT JOIN CADITE ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '  WHERE ITEGER.ITE_CODITE = ' + strCodigo;

  If blnOpcOrc Then
  Begin

    If fEmptyStr(strEmpresas) Then
    Begin

      strSQL := strSQL + '  AND LOCATE(ITEGER.ITE_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    End Else
    Begin

      strSQL := strSQL + '  AND ITEGER.ITE_CODEMP IN (' + fCommaTextToQuoted(strEmpresas) + ') ';

    End;

  End Else
  Begin

    If Not fEmptyStr(edtEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtEmpresa, arrEmpresa, 'ITEGER.ITE_CODEMP','CODEMP');

  End;

  strSQL := strSQL + '  ) ';

  result := strSQL;
End;

Function TfrmRelFatListVenRep.fRetSqlEstMin(strCodigo: String; blnOpcOrc: Boolean) : String;
var strSQL : String;
Begin
  strSQL := '';
  strSQL := strSQL + '  (SELECT SUM(ITEGER.ITE_ESTMIN) FROM ITEGER ';
  strSQL := strSQL + '  LEFT JOIN CADITE ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '  WHERE ITEGER.ITE_CODITE = ' + strCodigo;

  If blnOpcOrc Then
  Begin

    If fEmptyStr(strEmpresas) Then
    Begin

      strSQL := strSQL + '  AND LOCATE(ITEGER.ITE_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    End Else
    Begin

      strSQL := strSQL + '  AND ITEGER.ITE_CODEMP IN (' + fCommaTextToQuoted(strEmpresas) + ') ';

    End;

  End Else
  Begin

    If Not fEmptyStr(edtEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtEmpresa, arrEmpresa, 'ITEGER.ITE_CODEMP','CODEMP');

  End;

  strSQL := strSQL + '  ) ';

  result := strSQL;
End;

Function TfrmRelFatListVenRep.fRetSqlRel(blnOpcOrc: Boolean = False; strEmpresas: String = ''; strCodEmpCD: String = ''): String;
  Var
    strSQL  : String;
    strUnion: String;
    strUnitar: String;
    strDeqTpc: String;
    strLibPcm: String;
    strPdcPro: String;
    strUsaDig: String;

  function fRetMes(intMes: Integer): string;
  begin
    Result := fStrZero(IntToStr(IIF((MonthOf(VS_Date) - intMes) > 0, (MonthOf(VS_Date) - intMes), (12 + (MonthOf(VS_Date) - intMes)))), 2);
  end;

  function fRetAno(intMes: Integer): string;
  begin
    Result := fStrZero(IntToStr(IIF((MonthOf(VS_Date) - intMes) > 0, YearOf(VS_Date), YearOf(VS_Date) - 1)), 4);
  end;

  function fRetSQLSaldoFisico: String;
  Begin
    Result := '';

    Result := Result + '  (IFNULL(CD.ITE_SALDOS + IF(IFNULL(I.ITE_CNV_ML, 0) > 0, CD.ITE_SAL_ML / I.ITE_CNV_ML, 0),0) ' ;

    if (fCfgSis('ENTFUT', varBoolean)) then
      Result := Result + '  + (IFNULL(CD.ITE_QTEF_A,0) + IFNULL(CD.ITE_QTEF_F,0) + IFNULL(CD.ITE_QTEF_P,0)) ';

    if (fUsaRotinaWMS) and (not fCfgSis('BEFTRG', varBoolean)) and (fCfgSis('CALSAL', varInteger) <> 2)
      and (fCfgSis('PEDBEF', varBoolean)) then
      Result := Result + '  +  IFNULL(CD.ITE_QTPDBF, 0) ';

    Result := Result + ' ) ';
  End;

  function fRetSQLSALREG: String;
  Begin
    Result := ' IFNULL(IFNULL(CD.ITE_SALREG,0),0) ' ;
  End;

  function fRetSQLQTDPD_V: String;
  Begin
    Result := ' (IFNULL(CD.ITE_QTPD_V,0)+IFNULL(CD.ITE_QTPD_F,0)) ' ;
  End;

  function fRetSQLQTDPD_E: String;
  Begin
    Result := ' IFNULL(CD.ITE_QTPD_E,0) ' ;
  End;

  function fRetSQLQTDPD_P: String;
  Begin
    Result := ' 0 ';

    if (fCfgSis('ORDPRO', varBoolean)) then
      Result := ' IFNULL(CD.ITE_QTPD_P,0) ' ;
  End;

  function fRetSQLSaldoExterno: String;
  Begin
    Result := ' 0 ';

    if (fCfgSis('ESTEXT', varBoolean)) then
      Result := ' IFNULL(CD.ITE_SALEXT,0) ' ;
  End;

  function fRetSQLQTEF_P: String;
  Begin
    Result := ' 0 ';

    if (fCfgSis('ENTFUT', varBoolean)) then
      Result := ' IFNULL(CD.ITE_QTEF_P,0) ' ;
  End;

  function fRetSQLQTEF_F: String;
  Begin
    Result := ' 0 ';

    if (fCfgSis('ENTFUT', varBoolean)) then
      Result := ' IFNULL(CD.ITE_QTEF_F,0) ' ;
  End;

  function fRetSQLQTEF_A: String;
  Begin
    Result := ' 0 ';

    if (fCfgSis('ENTFUT', varBoolean)) then
      Result := ' IFNULL(CD.ITE_QTEF_A,0) ' ;
  End;

Begin

  strDeqTpc := IIF(fCfgSis('DEQTPC', varString) = '', '2', fCfgSis('DEQTPC', varString));
  strLibPcm := fCfgSis('LIBPCM', varString);
  strPdcPro := fCfgSis('PDCPRO', varString);
  strUsaDig := fCfgSis('USADIG', varString);

  strSQL := fRetSql('NOR', blnOpcOrc) + ' UNION ALL ' + fRetSql('ML', blnOpcOrc);

  If (fEmptyStr(edtEspecie.Text)) Then
    strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL,['NOR.']);

  strUnion := strSQL;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

  if (rdgGirEst.ItemIndex > 0) then
  begin
    if(chkMesAtu.Checked) then
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(0)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(0)) + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';

    strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(1)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(1))  + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
    strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(2)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(2))  + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
    strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(3)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(3))  + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';

    if rdgGirEst.ItemIndex > 1 then
    begin
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(4)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(4))  + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(5)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(5))  + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(6)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(6))  + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
    end;

    if rdgGirEst.ItemIndex > 2 then
    begin
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(7)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(7))  + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(8)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(8))  + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(9)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(9))  + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(10) + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(10)) + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(11) + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(11)) + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetMes(12) + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetAno(12)) + ' ' + IfThen(not fEmptyStr(edtEmpresa.Text), fStrLocate(edtEmpresa, arrEmpresa, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
    end;
  end;
  strSQL := strSQL + '  0 AS GIRITE, ';

  If fCfgSis('EXIAPL', varBoolean) Then
    strSQL := strSQL + ' I.ITE_APLICA AS APLICA, ';

  If blnOpcOrc Then
  Begin
    strUnitar := TRelGeraOR.fSQLUnitarioAlias('CD.', IfThen(fEmptyStr(strCodEmpCD), fCfgSis('EMPMAT', varString), strCodEmpCD));

    (********************************************************************************************)
    (*  QUANDO ALTERAR O SELECT ABAIXO ATENTAR PARA O FATO QUE O RELATORIO DE ESTOQUE           *)
    (*  TfrmRelEstItemsAbaixoMin TAMBEM UTILIZA O MESMO OBJETO TRelGeraOR PARA GERAR ORÇAMENTOS *)
    (*****************************************************************************************LA*)
    strSQL := strSQL + '   I.AUTOINCREM,           ';
    strSQL := strSQL + '   "D"          AS MARDES, ';
    strSQL := strSQL + '   CAST("N" AS CHAR(1)) AS EXCLUIR,  ';
    strSQL := strSQL + '   I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '   I.ITE_CODSIM AS CODSIM, ';
    strSQL := strSQL + '   I.ITE_CODGRU AS GRUPO,  ';
    strSQL := strSQL + '   I.ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '   I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '   I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '   I.ITE_CODUNI AS UNIDAD, ';
    strSQL := strSQL + '   U.UNI_SIGUNI AS SIGUNI, ';
    strSQL := strSQL + '   I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '   0.000 AS PESTIT, ';

    strSQL := strSQL + '   ' + strUnitar + ' AS UNITAR, ';
    strSQL := strSQL + '   CD.ITE_PRECUS AS PRECUS, ';
    strSQL := strSQL + '   CD.ITE_PREMED AS PREMED, ';

    strSQL := strSQL + '   CD.ITE_LOCFIS AS LOCFIS, ';
    strSQL := strSQL + '   CD.ITE_LOCSUP AS LOCSUP, ';

    strSQL := strSQL + '   G.ITE_LOCFIS AS FISEMP, ';
    strSQL := strSQL + '   G.ITE_LOCSUP AS SUPEMP, ';

    strSQL := strSQL + '   CAST("" AS CHAR(20)) AS NUMLOT, ';
    strSQL := strSQL + '   G.ITE_CODEMP AS CODEMP, ';
    strSQL := strSQL + '   0.000 AS PESTOT, ';
    strSQL := strSQL + '   0.00  AS NECTOT, ';

    strSQL := strSQL + '   IF(IFNULL((SELECT COUNT(*)                                   ';
    strSQL := strSQL + '    FROM CADLOT                                                 ';
    strSQL := strSQL + '    WHERE     LOT_CODITE = G.ITE_CODITE                         ';
    strSQL := strSQL + '          AND LOT_CODEMP = G.ITE_CODEMP                         ';
    strSQL := strSQL + '          ), 0) > 0, "S", "N") AS TEMLOT,                       ';

    strSQL := strSQL + '   I.ITE_INCPIS AS INCPIS, ';
    strSQL := strSQL + '   I.ITE_PESOIT AS PESOIT, ';
    strSQL := strSQL + '   ' + IIF(rdgSaldoProduto.ItemIndex = 0, 'G.ITE_SALDOS', fRetSalDis('G', 'I')) + IIF(chkPedCompraAberto.Checked, ' + IFNULL(PD.PEN_QTDPEN, 0) ', '') + ' AS SALDOS, ';

    strSQL := strSQL + '   I.ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '   CONCAT(D.DEP_CODIGO, "-", D.DEP_DESCRI) AS CODDEP, ';
    strSQL := strSQL + '   IF(IFNULL(ITE_CNV_ML, 0) > 0, G.ITE_SALDOS * ITE_CNV_ML + G.ITE_SAL_ML, 0) AS SALMLG, ';

    strSQL := strSQL + '  SUM(ROUND(IFNULL((SELECT SUM(ITEGER.ITE_SALDOS - ' + fSQLSalResAbaixoMin(chkSalMat, False, 'ITEGER') + ')  * ((100 - ' + ReplaceStr(fCfgSis('PEREAM', varString), ',', '.') +  ')/100)' ;
    strSQL := strSQL + '          FROM ITEGER ';
    strSQL := strSQL + '          WHERE ITEGER.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '                ITEGER.ITE_CODEMP = ' + QuotedStr(strEmpCD) + ') ' ;

    If fUsaRotinaWMS Then
    Begin
      strSQL := strSQL + ' - IFNULL( ( SELECT SUM(LOT_SALDOS)                                       ';
      strSQL := strSQL + '             FROM CADLOT                                                  ';
      strSQL := strSQL + '             WHERE LOT_CODITE = G.ITE_CODITE                              ';
      strSQL := strSQL + '               AND LOT_CODEMP = ' + QuotedStr(strEmpCD)                    ;
      strSQL := strSQL + '               AND LOT_ABSAUT  = "N" ) ,0)                                ';
    End;
    strSQL := strSQL + '  ,0))) AS SALDIS, ';

    strSQL := strSQL + '   G.ITE_ESTMIN AS ESTMIN, ';
    strSQL := strSQL + '   G.ITE_ESTMAX AS ESTMAX, ';
    strSQL := strSQL + '   IFNULL(G.ITE_ABAMLT, "N") AS ABAMLT, ';
    strSQL := strSQL + '   IF(IFNULL(ITE_MLTCOM, 0) <= 0, 1, ITE_MLTCOM) AS MLTCOM, ';
    strSQL := strSQL + '   I.ITE_EMBALA AS EMBALA, ';
    strSQL := strSQL + '   F.FOR_NOMFOR AS NOMFOR, ';
    strSQL := strSQL + '   M.MAR_DESMAR AS DESMAR, ';
    strSQL := strSQL + '   CONCAT(IFNULL(F.FOR_NOMFOR, ""), "-", IFNULL(M.MAR_DESMAR, ""), "-", IFNULL(I.ITE_REFERE, "")) AS FORREF, ';

    strSQL := strSQL +     fSQLQuantidadePendenteCompra('I.ITE_CODITE', fCommaTextToQuoted(strEmpresas), False, False) + ' AS QTDPEN, ';
    strSQL := strSQL + '   TR.TRA_QTDRES AS TEPEND, ';

    strSQL := strSQL + '  IFNULL((SELECT SQL_NO_CACHE SUM(ITEGER.ITE_SALDOS) ';
    strSQL := strSQL + '          FROM ITEGER ';
    strSQL := strSQL + '          WHERE ITEGER.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '                ITEGER.ITE_CODEMP = :EMPSALDOCD), 0) AS SALDCD, ';

    strSQL := strSQL + '  ' + fRetSQLSaldoFisico + ' AS SALFIS, ';

    strSQL := strSQL + '  ROUND(( ' ;

    Case fCfgSis('CALSAL', varInteger) Of
      1: strSQL := strSQL + (fRetSQLSaldoFisico) + ' - ' + (fRetSQLSALREG) + ' - ' + (fRetSQLQTDPD_V) + ' - ' + (fRetSQLQTDPD_E) + ' - ' + (fRetSQLQTDPD_P) + ' - ' + (fRetSQLSaldoExterno);
      2: strSQL := strSQL + (fRetSQLSaldoFisico) + ' - ' + (fRetSQLSALREG) + ' - ' + (fRetSQLQTDPD_V) + ' - ' + (fRetSQLQTDPD_E) + ' - ' + (fRetSQLQTDPD_P) + ' - ' + (fRetSQLQTEF_P) + ' - ' + (fRetSQLQTEF_F) + ' - ' + (fRetSQLQTEF_A) + ' - ' + (fRetSQLSaldoExterno);
      3: strSQL := strSQL + (fRetSQLSaldoFisico) + ' - ' + (fRetSQLSALREG) + ' - ' + (fRetSQLQTDPD_V) + ' - ' + (fRetSQLQTDPD_E) + ' - ' + (fRetSQLQTDPD_P) + ' - ' + (fRetSQLQTEF_P) + ' - ' + (fRetSQLQTEF_A) + ' - ' + (fRetSQLSaldoExterno) ;
      4: strSQL := strSQL + (fRetSQLSaldoFisico) + ' - ' + (fRetSQLSALREG) + ' - ' + (fRetSQLQTDPD_V) + ' - ' + (fRetSQLQTDPD_E) + ' - ' + (fRetSQLQTDPD_P) + ' - ' + (fRetSQLQTEF_F) + ' - ' + (fRetSQLSaldoExterno) ;
      5: strSQL := strSQL + (fRetSQLSaldoFisico) + ' - ' + (fRetSQLSALREG) + ' - ' + (fRetSQLQTDPD_V) + ' - ' + (fRetSQLQTDPD_E) + ' - ' + (fRetSQLQTDPD_P) + ' - ' + (fRetSQLQTEF_P) + ' - ' + (fRetSQLSaldoExterno) ;
    End;
    strSQL := strSQL + ')  ,2) AS REALCD, ';

    strSQL := strSQL + '  IFNULL(U.UNI_PESLIT,0) AS PESUNT, ';
    strSQL := strSQL + '  SUM(LITROS) AS LITROS, ';
    strSQL := strSQL + '  SUM(TOTLIT) AS TOTLIT, ';
    strSQL := strSQL + '  SUM(TOTKIL) AS TOTKIL, ';

    strSQL := strSQL + '  SUM(QTDITE) AS NECCOM,  ';

    strSQL := strSQL + ' "  " AS LIMSAL ';
  End
  Else
  Begin
    strSQL := strSQL + '  CODIGO,           ';
    strSQL := strSQL + '  CODITE,           ';
    strSQL := strSQL + '  CODSIM,           ';
    strSQL := strSQL + '  CODGRU,           ';
    strSQL := strSQL + '  CODMAR,           ';
    strSQL := strSQL + '  ESPDOC,           ';
    strSQL := strSQL + '  NUMDOC,           ';
    strSQL := strSQL + '  CODCLI,           ';
    strSQL := strSQL + '  CODFOR,           ';
    strSQL := strSQL + '  CODVEN,           ';
    strSQL := strSQL + '  CODEMP,           ';
    strSQL := strSQL + '  DESCRI,           ';
    strSQL := strSQL + '  DTADOC,           ';
    strSQL := strSQL + '  UNIDAD,           ';
    strSQL := strSQL + '  REFERE,           ';
    strSQL := strSQL + '  NOMFOR,           ';
    strSQL := strSQL + '  CODFAB,           ';
    strSQL := strSQL + '  CODDEP,           ';

    If chkSupEst.Checked Then
    Begin
      strSQL := strSQL + '  LOCFIS,         ';
      strSQL := strSQL + '  LOCSUP,         ';
    End;

    strSQL := strSQL + '  SUM(LITROS) AS LITROS, ';
    strSQL := strSQL + '  SUM(TOTLIT) AS TOTLIT, ';
    strSQL := strSQL + '  SUM(TOTKIL) AS TOTKIL, ';

    strSQL := strSQL + '  SUM(QTDITE) AS QTDITE, ';

    strSQL := strSQL + fRetSqlSaldo('CODIGO', blnOpcOrc) + IIF(chkPedCompraAberto.Checked, ' + IFNULL(PD.PEN_QTDPEN, 0) ', '') + ' AS SALDOS, ';
    strSQL := strSQL + fRetSqlEstMin('CODIGO', blnOpcOrc) + ' AS ESTMIN, ';
    strSQL := strSQL + '  TR.TRA_QTDRES AS TEPEND, ';

    strSQL := strSQL + ' (SELECT ITE_SALDOS FROM ITEGER         ';
    strSQL := strSQL + '  WHERE ITE_CODITE = CODIGO AND         ';
    strSQL := strSQL + '        ITE_CODEMP = :EMPMAT) AS SALMAT ';
  End;

  strSQL := strSQL + 'FROM (';

  strSQL := strSQL +  strUnion;

  strSQL := strSQL + ') AS TAB ';

  If blnOpcOrc Then
  Begin
    strSQL := strSQL + ' LEFT JOIN ITEGER G ON G.ITE_CODITE = CODITE  ';
    strSQL := strSQL + '                    AND G.ITE_CODEMP = CODEMP  ';

    strSQL := strSQL + ' LEFT JOIN CADITE I ON I.ITE_CODITE = CODITE       ';

    strSQL := strSQL + ' LEFT JOIN ITEGER CD ON CD.ITE_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '                     AND CD.ITE_CODEMP = ' + QuotedStr(IfThen(fEmptyStr(strCodEmpCD), fCfgSis('EMPMAT', varString), strCodEmpCD));

    strSQL := strSQL + ' LEFT JOIN CADUNI U ON U.UNI_CODUNI = ITE_CODUNI   ';

    strSQL := strSQL + ' LEFT  JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';

    strSQL := strSQL + ' LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
    strSQL := strSQL + ' LEFT  JOIN CADDEP D ON D.DEP_CODIGO = I.ITE_CODDEP ';
  End
  Else
  Begin
    strSQL := strSQL + ' LEFT JOIN CADITE I ON I.ITE_CODITE = CODPRO       ';
  End;

  // Considerar pedidos de compra pendentes (em aberto)
  If chkPedCompraAberto.Checked Then
  Begin

    strSQL := strSQL + ' LEFT JOIN ( ';

    strSQL := strSQL + '   SELECT ';
    strSQL := strSQL + '     CODITE AS PEN_CODITE, ';
    strSQL := strSQL + '     CODEMP AS PEN_CODEMP, ';
    strSQL := strSQL + '     SUM(QTDPEN) AS PEN_QTDPEN ';
    strSQL := strSQL + '   FROM ( ';

    // FORNECEDOR FILIAL - NÃO LIBERADOS
    strSQL := strSQL + '     SELECT ';
    strSQL := strSQL + '       PCD_CODITE AS CODITE, ';
    strSQL := strSQL + '       IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) AS CODEMP, ';
    strSQL := strSQL + '   	   SUM(ROUND(IF(PC.PCD_QTDBAI > PC.PCD_QTDITE, 0, PC.PCD_QTDITE - PC.PCD_QTDBAI) * IF((PC.PCD_EMBALA IS NULL) OR (PC.PCD_EMBALA = 0), 1, PC.PCD_EMBALA), ' + strDeqTpc + ')) AS QTDPEN ';
    strSQL := strSQL + '   	 FROM PCMDET PC ';
    strSQL := strSQL + '   	   JOIN PCMGER ON PCG_NUMPED = PC.PCD_NUMPED ';
    strSQL := strSQL + '   			          AND PCG_CODEMP = PC.PCD_CODEMP ';
    strSQL := strSQL + '   			          AND PCG_ESPDOC = PC.PCD_ESPDOC ';
    strSQL := strSQL + '   	   LEFT JOIN CADFOR ON FOR_CODFOR = PCD_CODFOR ';
    strSQL := strSQL + '   	   LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ';
    strSQL := strSQL + '   	   LEFT JOIN CADUNI ON UNI_CODUNI = PCD_CODUNI ';
    strSQL := strSQL + '   	   LEFT JOIN CADITE ON ITE_CODITE = PCD_CODITE ';
    strSQL := strSQL + '   	 WHERE TRUE ';
    // strSQL := strSQL + '       AND IF(' + QuotedStr(strPdcPro) + ' = "T", LOCATE(IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES), ' + QuotedStr(strEmpAcessoUsuarioLogado) + '), IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) = ' + QuotedStr(VS_strCodEmp) + ') ';
    If blnOpcOrc Then
    Begin
      If fEmptyStr(strEmpresas) Then
        strSQL := strSQL + '  AND LOCATE(IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES), ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') '
      Else
        strSQL := strSQL + '  AND IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) IN (' + fCommaTextToQuoted(strEmpresas) + ') ';
    End
    Else
    Begin
      If Not fEmptyStr(edtEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtEmpresa, arrEmpresa, 'IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES)','CODEMP');
    End;
    strSQL := strSQL + '   	   AND PC.PCD_BAIXAD = 0 ';
    strSQL := strSQL + '   	   AND PC.PCD_NUMCTN = 0 ';
    strSQL := strSQL + '   	   AND PCG_NUMCTN = 0 ';
    strSQL := strSQL + '   	   AND PC.PCD_ESPDOC = "PD" ';
    strSQL := strSQL + '   	   AND LOCATE(PCD_CODFOR, ' + QuotedStr(fRetForFilialTodos) + ') ';
    strSQL := strSQL + '   	   AND (' + QuotedStr(strLibPcm) + ' = "S" AND (PCG_PEDLIB IS NULL)) ';
    strSQL := strSQL + '   	 GROUP BY PCD_CODITE, ';
    strSQL := strSQL + '   	   IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) ';

    strSQL := strSQL + '     UNION ALL ';

    // NÃO FORNECEDOR FILIAL - LIBERADOS (ok)
    strSQL := strSQL + '     SELECT ';
    strSQL := strSQL + '       PCD_CODITE AS CODITE, ';
    strSQL := strSQL + '       IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) AS CODEMP, ';
    strSQL := strSQL + '   	   SUM(ROUND(IF(PC.PCD_QTDBAI > PC.PCD_QTDITE, 0, PC.PCD_QTDITE - PC.PCD_QTDBAI) * IF((PC.PCD_EMBALA IS NULL) OR (PC.PCD_EMBALA = 0), 1, PC.PCD_EMBALA), ' + strDeqTpc + ')) AS QTDPEN ';
    strSQL := strSQL + '     FROM PCMDET PC ';
    strSQL := strSQL + '   	   JOIN PCMGER ON PCG_NUMPED = PC.PCD_NUMPED ';
    strSQL := strSQL + '   		   	        AND PCG_CODEMP = PC.PCD_CODEMP ';
    strSQL := strSQL + '   			          AND PCG_ESPDOC = PC.PCD_ESPDOC ';
    strSQL := strSQL + '   	   LEFT JOIN CADFOR ON FOR_CODFOR = PCD_CODFOR ';
    strSQL := strSQL + '   	   LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ';
    strSQL := strSQL + '   	   LEFT JOIN CADUNI ON UNI_CODUNI = PCD_CODUNI ';
    strSQL := strSQL + '   	   LEFT JOIN CADITE ON ITE_CODITE = PCD_CODITE ';
    strSQL := strSQL + '     WHERE TRUE ';
    // strSQL := strSQL + '       AND IF(' + QuotedStr(strPdcPro) + ' = "T", LOCATE(IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES), ' + QuotedStr(strEmpAcessoUsuarioLogado) + '), IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) = ' + QuotedStr(VS_strCodEmp) + ') ';
    If blnOpcOrc Then
    Begin
      If fEmptyStr(strEmpresas) Then
        strSQL := strSQL + '  AND LOCATE(IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES), ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') '
      Else
        strSQL := strSQL + '  AND IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) IN (' + fCommaTextToQuoted(strEmpresas) + ') ';
    End
    Else
    Begin
      If Not fEmptyStr(edtEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtEmpresa, arrEmpresa, 'IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES)','CODEMP');
    End;
    strSQL := strSQL + '   	   AND PC.PCD_BAIXAD = 0 ';
    strSQL := strSQL + '   	   AND PC.PCD_NUMCTN = 0 ';
    strSQL := strSQL + '   	   AND PCG_NUMCTN = 0 ';
    strSQL := strSQL + '   	   AND PC.PCD_ESPDOC = "PD" ';
    strSQL := strSQL + '   	   AND (NOT LOCATE(PCD_CODFOR, ' + QuotedStr(fRetForFilialTodos) + ')) ';
    strSQL := strSQL + '   	   AND ((' + QuotedStr(strLibPcm) + ' = "N") OR (PCG_PEDLIB IS NOT NULL)) ';
    strSQL := strSQL + '     GROUP BY PCD_CODITE, ';
    strSQL := strSQL + '   	   IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) ';

    strSQL := strSQL + '     UNION ALL ';

    // NÃO FORNECEDOR FILIAL - NÃO LIBERADOS
    strSQL := strSQL + '     SELECT ';
    strSQL := strSQL + '       PCD_CODITE AS CODITE, ';
    strSQL := strSQL + '       IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) AS CODEMP, ';
    strSQL := strSQL + ' 	     SUM(ROUND(IF(PC.PCD_QTDBAI > PC.PCD_QTDITE, 0, PC.PCD_QTDITE - PC.PCD_QTDBAI) * IF((PC.PCD_EMBALA IS NULL) OR (PC.PCD_EMBALA = 0), 1, PC.PCD_EMBALA), ' + strDeqTpc + ')) AS QTDPEN ';
    strSQL := strSQL + ' 	   FROM PCMDET PC ';
    strSQL := strSQL + ' 	     JOIN PCMGER ON PCG_NUMPED = PC.PCD_NUMPED ';
    strSQL := strSQL + ' 			            AND PCG_CODEMP = PC.PCD_CODEMP ';
    strSQL := strSQL + ' 			            AND PCG_ESPDOC = PC.PCD_ESPDOC ';
    strSQL := strSQL + ' 	     LEFT JOIN CADFOR ON FOR_CODFOR = PCD_CODFOR ';
    strSQL := strSQL + ' 	     LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ';
    strSQL := strSQL + ' 	     LEFT JOIN CADUNI ON UNI_CODUNI = PCD_CODUNI ';
    strSQL := strSQL + ' 	     LEFT JOIN CADITE ON ITE_CODITE = PCD_CODITE ';
    strSQL := strSQL + ' 	   WHERE TRUE ';
    // strSQL := strSQL + '       AND IF(' + QuotedStr(strPdcPro) + ' = "T", LOCATE(IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES), ' + QuotedStr(strEmpAcessoUsuarioLogado) + '), IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) = ' + QuotedStr(VS_strCodEmp) + ') ';
    If blnOpcOrc Then
    Begin
      If fEmptyStr(strEmpresas) Then
        strSQL := strSQL + '  AND LOCATE(IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES), ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') '
      Else
        strSQL := strSQL + '  AND IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) IN (' + fCommaTextToQuoted(strEmpresas) + ') ';
    End
    Else
    Begin
      If Not fEmptyStr(edtEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtEmpresa, arrEmpresa, 'IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES)','CODEMP');
    End;
    strSQL := strSQL + ' 	     AND PC.PCD_BAIXAD = 0 ';
    strSQL := strSQL + ' 	     AND PC.PCD_NUMCTN = 0 ';
    strSQL := strSQL + ' 	     AND PCG_NUMCTN = 0 ';
    strSQL := strSQL + ' 	     AND PC.PCD_ESPDOC = "PD" ';
    strSQL := strSQL + ' 	     AND (NOT LOCATE(PCD_CODFOR, ' + QuotedStr(fRetForFilialTodos) + ')) ';
    strSQL := strSQL + ' 	     AND (' + QuotedStr(strLibPcm) + ' = "S" AND (PCG_PEDLIB IS NULL)) ';
    strSQL := strSQL + ' 	   GROUP BY PCD_CODITE, ';
    strSQL := strSQL + ' 	     IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) ';

    strSQL := strSQL + '   ) AS TAB ';
    strSQL := strSQL + '   GROUP BY ';
    strSQL := strSQL + '     CODITE ';
    If blnOpcOrc Then
      strSQL := strSQL + '     , CODEMP  ';

    strSQL := strSQL + ' ) AS PD ON I.ITE_CODITE = PD.PEN_CODITE ';
    If blnOpcOrc Then
      strSQL := strSQL + '      AND G.ITE_CODEMP = PD.PEN_CODEMP ';

  End;

  // Considerar transferência de estoque em andamento
  If True Then
  Begin

    strSQL := strSQL + ' LEFT JOIN ( ';

    strSQL := strSQL + '   SELECT ';
    strSQL := strSQL + '     CODITE AS TRA_CODITE, ';
    strSQL := strSQL + '     CODEMP AS TRA_CODEMP, ';
    strSQL := strSQL + '     SUM(QTDRES) AS TRA_QTDRES ';
    strSQL := strSQL + '   FROM ( ';

    strSQL := strSQL + '     SELECT ';
    strSQL := strSQL + '       FDO_CODITE AS CODITE, ';
    strSQL := strSQL + '       E.EMP_CODEMP AS CODEMP, ';
    strSQL := strSQL + '       FDO_QTDITE - IFNULL(FDO_QTDBAI,0) AS QTDRES ';
    strSQL := strSQL + '     FROM FATDOR F ';
    strSQL := strSQL + '       LEFT JOIN CADEMP E ON (SELECT EMP_CODEMP FROM CADEMP WHERE EMP_CLIFIL = FDO_CODCLI LIMIT 1) = E.EMP_CODEMP ';
    strSQL := strSQL + '       INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE ';
    strSQL := strSQL + '       LEFT JOIN EXTGOR X ON X.FGO_SEQFGO = F.FDO_SEQGER ';
    strSQL := strSQL + '     WHERE TRUE ';
    If blnOpcOrc Then
    Begin
      If fEmptyStr(strEmpresas) Then
        strSQL := strSQL + '  AND LOCATE(E.EMP_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') '
      Else
        strSQL := strSQL + '  AND E.EMP_CODEMP IN (' + fCommaTextToQuoted(strEmpresas) + ') ';
    End
    Else
    Begin
      If Not fEmptyStr(edtEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtEmpresa, arrEmpresa, 'E.EMP_CODEMP','CODEMP');
    End;
    strSQL := strSQL + '       AND FDO_QTDITE - IFNULL(FDO_QTDBAI,0) > 0 ';
    strSQL := strSQL + '       AND FDO_VLRCON > 0 ';
    strSQL := strSQL + '       AND FDO_ESPDOC = "PD" ';
    strSQL := strSQL + '       AND FDO_JAFATU = 0 ';
    strSQL := strSQL + '       AND LOCATE(FDO_CODCLI, ' + QuotedStr(fRetClientesFilial) + ') ';

    strSQL := strSQL + '     UNION ALL ';

    strSQL := strSQL + '     SELECT ';
    strSQL := strSQL + '       DET_CODITE AS CODITE, ';
    strSQL := strSQL + '       E.EMP_CODEMP AS CODEMP, ';
    strSQL := strSQL + '       DET_QTDITE AS QTDRES ';
    strSQL := strSQL + '     FROM PCMGER ';
    strSQL := strSQL + '       INNER JOIN MOVGER G ON GER_NUMDOC = SUBSTRING(PCG_DOCORI,1,12) ';
    strSQL := strSQL + '                          AND GER_ESPDOC = SUBSTRING(PCG_DOCORI,13,2) ';
    strSQL := strSQL + '                          AND GER_CODEMP = SUBSTRING(PCG_DOCORI,15,3) ';
    strSQL := strSQL + '                          AND GER_ESPDOC = "TE" ';
    strSQL := strSQL + '       LEFT JOIN CADEMP E ON (SELECT EMP_CODEMP FROM CADEMP WHERE EMP_CLIFIL = GER_CODCLI LIMIT 1) = E.EMP_CODEMP ';
    strSQL := strSQL + '       INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + '       LEFT JOIN MOVOBS ON MOV_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + '       LEFT JOIN CADOPE ON OPE_CODOPE = IFNULL(GER_CODDIG, GER_CODVEN) ';
    strSQL := strSQL + '     WHERE TRUE ';
    If blnOpcOrc Then
    Begin
      If fEmptyStr(strEmpresas) Then
        strSQL := strSQL + '  AND LOCATE(E.EMP_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') '
      Else
        strSQL := strSQL + '  AND E.EMP_CODEMP IN (' + fCommaTextToQuoted(strEmpresas) + ') ';
    End
    Else
    Begin
      If Not fEmptyStr(edtEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtEmpresa, arrEmpresa, 'E.EMP_CODEMP','CODEMP');
    End;
    strSQL := strSQL + '       AND IF(' + QuotedStr(strUsaDig) + ' = "S", OPE_CODOPE IS NOT NULL, TRUE) ';
    strSQL := strSQL + '       AND PCG_BAIXAD = 0 ';
    strSQL := strSQL + '       AND PCG_ESPDOC = "PD" ';
    strSQL := strSQL + '       AND PCG_DOCORI IS NOT NULL ';
    strSQL := strSQL + '       AND PCG_DOCORI <> "" ';
    strSQL := strSQL + '       AND LOCATE(GER_CODCLI, ' + QuotedStr(fRetClientesFilial) + ') ';

    strSQL := strSQL + '     UNION ALL ';

    strSQL := strSQL + '     SELECT ';
    strSQL := strSQL + '       DET_CODITE AS CODITE, ';
    strSQL := strSQL + '       E.EMP_CODEMP AS CODEMP, ';
    strSQL := strSQL + '       DET_QTDITE AS QTDRES ';
    strSQL := strSQL + '     FROM PCMGER ';
    strSQL := strSQL + '       INNER JOIN MOVGER G ON GER_NUMDOC = SUBSTRING(PCG_DOCORI,1,12) ';
    strSQL := strSQL + '                          AND GER_ESPDOC = SUBSTRING(PCG_DOCORI,13,2) ';
    strSQL := strSQL + '                          AND GER_CODEMP = SUBSTRING(PCG_DOCORI,15,3) ';
    strSQL := strSQL + '                          AND (GER_ESPDOC = "NF" OR GER_ESPDOC = "EL") ';
    strSQL := strSQL + '       LEFT JOIN CADEMP E ON (SELECT EMP_CODEMP FROM CADEMP WHERE EMP_CLIFIL = GER_CODCLI LIMIT 1) = E.EMP_CODEMP ';
    strSQL := strSQL + '       INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + '       LEFT JOIN MOVOBS ON MOV_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + '       LEFT JOIN CADOPE ON OPE_CODOPE = IFNULL(GER_CODDIG, GER_CODVEN) ';
    strSQL := strSQL + '     WHERE TRUE ';
    If blnOpcOrc Then
    Begin
      If fEmptyStr(strEmpresas) Then
        strSQL := strSQL + '  AND LOCATE(E.EMP_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') '
      Else
        strSQL := strSQL + '  AND E.EMP_CODEMP IN (' + fCommaTextToQuoted(strEmpresas) + ') ';
    End
    Else
    Begin
      If Not fEmptyStr(edtEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtEmpresa, arrEmpresa, 'E.EMP_CODEMP','CODEMP');
    End;
    strSQL := strSQL + '       AND IF(' + QuotedStr(strUsaDig) + ' = "S", OPE_CODOPE IS NOT NULL, TRUE) ';
    strSQL := strSQL + '       AND PCG_BAIXAD = 0 ';
    strSQL := strSQL + '       AND PCG_ESPDOC = "PD" ';
    strSQL := strSQL + '       AND PCG_DOCORI IS NOT NULL ';
    strSQL := strSQL + '       AND PCG_DOCORI <> "" ';
    strSQL := strSQL + '       AND LOCATE(GER_CODCLI, ' + QuotedStr(fRetClientesFilial) + ') ';

    strSQL := strSQL + '     UNION ALL ';

    strSQL := strSQL + '     SELECT ';
    strSQL := strSQL + '       PRE_CODITE AS CODITE, ';
    strSQL := strSQL + '       PRE_EMPDES AS CODEMP, ';
    strSQL := strSQL + '       PRE_QTDITE AS QTDRES ';
    strSQL := strSQL + '     FROM PREPTE ';
    strSQL := strSQL + '       INNER JOIN CADITE C ON C.ITE_CODITE = PRE_CODITE ';
    strSQL := strSQL + '     WHERE TRUE ';
    If blnOpcOrc Then
    Begin
      If fEmptyStr(strEmpresas) Then
        strSQL := strSQL + '  AND LOCATE(PRE_EMPDES, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') '
      Else
        strSQL := strSQL + '  AND PRE_EMPDES IN (' + fCommaTextToQuoted(strEmpresas) + ') ';
    End
    Else
    Begin
      If Not fEmptyStr(edtEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtEmpresa, arrEmpresa, 'PRE_EMPDES','CODEMP');
    End;
    strSQL := strSQL + '       AND PRE_LIBERA = "S" ';
    strSQL := strSQL + '       AND PRE_NUMDOC IS NULL ';

    strSQL := strSQL + '   ) AS TAB ';
    strSQL := strSQL + '   GROUP BY ';
    strSQL := strSQL + '     CODITE ';
    If blnOpcOrc Then
      strSQL := strSQL + '     , CODEMP  ';

    strSQL := strSQL + ' ) AS TR ON I.ITE_CODITE = TR.TRA_CODITE ';
    If blnOpcOrc Then
      strSQL := strSQL + '      AND G.ITE_CODEMP = TR.TRA_CODEMP ';

  End;

  If blnOpcOrc Then
  Begin
    strSQL := strSQL + ' WHERE TRUE ';

    If Not fEmptyStr(strEmpresas) Then
      strSQL := strSQL + ' AND CODEMP IN (' + fCommaTextToQuoted(strEmpresas) + ') ';

    {**************************************}
    {* FILTRO POR SALDO:(+)(-)(0) e TODOS *}
    {***********************************RM*}
    Case rdgSaldo.ItemIndex Of
      0: strSQL := strSQL + '  AND ' + IIF(rdgSaldoProduto.ItemIndex = 0, 'G.ITE_SALDOS', fRetSalDis('G', 'I')) + ' > 0 ';
      1: strSQL := strSQL + '  AND ' + IIF(rdgSaldoProduto.ItemIndex = 0, 'G.ITE_SALDOS', fRetSalDis('G', 'I')) + ' < 0 ';
      2: strSQL := strSQL + '  AND ' + IIF(rdgSaldoProduto.ItemIndex = 0, 'G.ITE_SALDOS', fRetSalDis('G', 'I')) + ' = 0 ';
    End;
  End
  Else
  Begin
    strSQL := strSQL + ' WHERE TRUE ';

    {**************************************}
    {* FILTRO POR SALDO:(+)(-)(0) e TODOS *}
    {***********************************RM*}
    Case rdgSaldo.ItemIndex Of
      0: strSQL := strSQL + '  AND ' + fRetSqlSaldo('CODIGO', blnOpcOrc) +  ' > 0 ';
      1: strSQL := strSQL + '  AND ' + fRetSqlSaldo('CODIGO', blnOpcOrc) +  ' < 0 ';
      2: strSQL := strSQL + '  AND ' + fRetSqlSaldo('CODIGO', blnOpcOrc) +  ' = 0 '; // MUDAR
    End;
  End;

  strSQL := strSQL + ' GROUP BY ';

  If blnOpcOrc Then
    strSQL := strSQL + '  CODEMP, ';

  If edtTipo.Text = 'A' Then
    strSQL := strSQL + '  CODITE, NUMDOC '
  Else
    strSQL := strSQL + '  CODITE ';

  strSQL := strSQL + ' HAVING TRUE  ';

  If chkItensAbaixoMinimo.Checked Then
    strSQL := strSQL + ' AND SALDOS < ESTMIN ';

  If blnOpcOrc Then
  Begin
    strSQL := strSQL + ' AND ROUND(NECCOM, 2) > 0 ';
  End Else
  Begin

    strSQL := strSQL + 'ORDER BY ';

    If edtOrdena.Text = 'G' Then
    Begin
      strSQL := strSQL + '  CODITE ';

      If blnOpcOrc Then
        strSQL := strSQL + ', CODEMP ';

    End

    Else If edtOrdena.Text = 'F' Then
    Begin
      strSQL := strSQL + '  NOMFOR, DESCRI ';

      If blnOpcOrc Then
        strSQL := strSQL + ', CODITE, CODEMP ';

    End

    Else
    begin
      strSQL := strSQL + '  DESCRI ';

      If blnOpcOrc Then
        strSQL := strSQL + ', CODITE, CODEMP ';
    End;

  End;

  Result := StrSQL;
End;

procedure TfrmRelFatListVenRep.pSetaParametros(qryItens: TUniQuery; blnOpcOrc: Boolean; strCodEmpCD: String='');
Begin
  With qryItens Do
  Begin
    If Params.FindParam('LITGAL') <> Nil Then
    Begin
      If SameText(fCfgSis('LITGAL'), 'L') Then
        ParamByName('LITGAL').AsFloat := 1
      Else
        ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
    End;

    If (Not blnOpcOrc) or (rdgGirEst.ItemIndex > 0) Then
    Begin

      If Not fEmptyStr(edtEmpresa.Text) Then
        pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryItens);

    End;

    {*****************}
    {* REDE DE LOJAS *}
    {**************DP*}
    pSetaParamOR(edtCodRede,arrRede,'CODRED', qryItens);

    If Params.FindParam('EMPMAT') <> Nil Then
      ParamByName('EMPMAT').AsString := fCfgSis('EMPMAT', varString);

    If Params.FindParam('EMPSALDOCD') <> Nil Then
      ParamByName('EMPSALDOCD').AsString := IfThen(fEmptyStr(strCodEmpCD), fCfgSis('EMPMAT', varString), strCodEmpCD);

    ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

    If Not fEmptyStr(fTiraCaracEspeciais(mskHorIni.Text, True, False, False, True)) And Not fEmptyStr(fTiraCaracEspeciais(mskHorFin.Text, True, False, False, True)) Then
    Begin
      ParamByName('HORINI').AsTime := StrToTime(mskHorIni.Text);
      ParamByName('HORFIN').AsTime := StrToTime(mskHorFin.Text);
    End;

    If chkIncBon.Checked Then
      ParamByName('CLAFIS').AsString := VS_strClaVen + '5910_6910_'
    Else
      ParamByName('CLAFIS').AsString := VS_strClaVen;

    If Not fEmptyStr(edtCliente.Text) Then
      pSetaParam(edtCliente.Text, arrLinhaClien, strLinhaClien, 'CODCLI', qryItens);

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
      pSetaParam(mskLinhaGrupo.Text, arrLinhaGrupo, strLinhaGrupo, 'CODGRU', qryItens);

    If Not fEmptyStr(edtProdutos.Text) Then
      pSetaParam(edtProdutos.Text, arrProduto, strProduto, 'CODITE', qryItens);

    If Not fEmptyStr(edtDepartamento.Text) Then
      pSetaParam(edtDepartamento.Text, arrDepartamento, strDepartamento, 'CODDEP', qryItens);

    If Not fEmptyStr(edtCodGruPro.Text) Then
      pSetaParam(edtCodGruPro.Text, arrGrupoPro, strGrpPro, 'PRDGRU', qryItens);

    If Not fEmptyStr(edtFornecedor.Text) Then
      pSetaParam(edtFornecedor.Text, arrFornecedor, strFornecedor, 'CODFOR', qryItens);

    If Not fEmptyStr(edtVendedor.Text) Then
      pSetaParam(edtVendedor.Text, arrVendedor, strVendedor, 'CODVEN', qryItens);

    If Not fEmptyStr(edtMarca.Text) Then
      pSetaParam(edtMarca.Text, arrMarca, strMarca, 'CODMAR', qryItens);

    If Not fEmptyStr(edtGruCmp.Text) Then
      pSetaParam(edtGruCmp.Text, arrGruCmp, strGruCmp, 'CODCOM', qryItens);

    If Not fEmptyStr(edtDescri.Text) Then
      ParamByName('DESCRI').AsString := edtDescri.Text + '%';

    If Not fEmptyStr(edtRefere.Text) Then
      ParamByName('REFERE').AsString := edtRefere.Text + '%';

    If Not fEmptyStr(edtUnidade.Text) Then
      pSetaParam(edtUnidade.Text, arrUnidade, strUnidade, 'UNIDAD', qryItens);

    If Not fEmptyStr(edtEspecie.Text) Then
      ParamByName('ESPDOC').AsString := edtEspecie.Text;
  End;
End;

procedure TfrmRelFatListVenRep.rdgGirEstClick(Sender: TObject);
begin
  inherited;
  chkMesAtu.Enabled := rdgGirEst.ItemIndex <> 0;
end;

procedure TfrmRelFatListVenRep.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    qryGenRep: TUniQuery;
    frxReport: TfrxReport;
    strRelTipo, strRelQuebra : String;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  qryGenRep := fCriaQuery(Self);

  inherited;

  If blnImprime Then
  Begin

    strSQL := fRetSqlRel;

    With cdsItens, qryQuery Do
    Begin

      SQL.Clear;
      SQL.Add(strSQL);

      pSetaParametros(qryQuery, False);

      fAbreClient(True, 'TfrmRelFatListVenRep.btnImprimirClick');

    End;

    If Not cdsItens.IsEmpty Then
    Begin
      If edtDestino.Text = 'E' Then
        pExportaExcel
      Else
      Begin
        Try
          frxRelatorio.DataSet := cdsItens;
          frxReport := frxReportJ;

          frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

          strRelTipo := '';
          if edtTipo.Text = 'A' then
            strRelTipo := 'ANALITICO'
          else if edtTipo.Text = 'S' then
            strRelTipo := 'SINTETICO';

          strRelQuebra := '';
          if edtOrdena.Text = 'A' then
            strRelQuebra := 'ALFABETICO'
          else if edtOrdena.Text = 'G' then
            strRelQuebra := 'GRUPO + ALFA'
          else if edtOrdena.Text = 'F' then
            strRelQuebra := 'FORNECEDOR + ALFA';

          frxReport.Script.Variables['NOMREL'] := 'RELATORIO DE VENDAS PARA REPOSICAO - ' + strRelQuebra + ' - ' + strRelTipo + '**';
          frxReport.Script.Variables['TIPO'] := edtTipo.Text;
          frxReport.Script.Variables['ORDENA'] := edtOrdena.Text;

          If chkIncBon.Checked Then
            frxReport.Script.Variables['INC_BONIFICACOES'] := 'INCLUIR BONIFICACOES: SIM'
          Else
            frxReport.Script.Variables['INC_BONIFICACOES'] := 'INCLUIR BONIFICACOES: NAO';

          frxReport.Script.Variables['LINHAGRUPO'] := fStrTitulo(mskLinhaGrupo.Text, edtDesGrupo, arrLinhaGrupo, strLinhaGrupo, 'LINHA/GRUPO');
          frxReport.Script.Variables['VENDEDOR'] := fStrTitulo(edtVendedor.Text, edtDesVendedor, arrVendedor, strVendedor, 'VENDEDOR');
          frxReport.Script.Variables['GRUPO_PRODUTOS'] := fStrTitulo(edtCodGruPro.Text, edtDesGruPro, arrGrupoPro, strGrpPro, 'GRUPO DE PRODUTOS');
          frxReport.Script.Variables['PRODUTO'] := fStrTitulo(edtProdutos.Text, edtDesProduto, arrProduto, strProduto, 'PRODUTO');
          frxReport.Script.Variables['DEPARTAMENTO'] := fStrTitulo(edtDepartamento.Text, edtDesDepartamento, arrDepartamento, strDepartamento, 'DEPARTAMENTO');

          If Not fEmptyStr(edtDescri.Text) Then
            frxReport.Script.Variables['DESCRICAO'] := 'DESCRICAO: ' + edtDescri.Text
          Else
            frxReport.Script.Variables['DESCRICAO'] := 'DESCRICAO: TODOS ';

          frxReport.Script.Variables['MARCA'] := fStrTitulo(edtMarca.Text, edtDesMarca, arrMarca, strMarca, 'MARCA');

          If Not fEmptyStr(edtRefere.Text) Then
            frxReport.Script.Variables['REFERENCIA'] := 'REFERENCIA: ' + edtRefere.Text
          Else
            frxReport.Script.Variables['REFERENCIA'] := 'REFERENCIA: TODOS ';

          frxReport.Script.Variables['GRUPO_COMPRAS'] := fStrTitulo(edtGruCmp.Text, edtDesGruCmp, arrGruCmp, strGruCmp, 'GRUPO DE COMPRAS');

          frxReport.Script.Variables['UNIDADE'] := fStrTitulo(edtUnidade.Text, nil, arrUnidade, strUnidade, 'UNIDADE');
          frxReport.Script.Variables['CLIENTE'] := fStrTitulo(edtCliente.Text, edtDesCliente, arrLinhaClien, strLinhaClien, 'CLIENTE');

          If rdgEmpresa.ItemIndex = 0 Then
            frxReport.Script.Variables['EMPRESA'] := fStrTitulo(edtEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA (FATURAMENTO)')
          Else
            frxReport.Script.Variables['EMPRESA'] := fStrTitulo(edtEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA (ORIGEM)');

          frxReport.Script.Variables['FORNECEDOR'] := fStrTitulo(edtFornecedor.Text, edtDesFornecedor, arrFornecedor, strFornecedor, 'FORNECEDOR');

          If Not fEmptyStr(edtEspecie.Text) Then
            frxReport.Script.Variables['ESPECIE'] := 'ESPECIE: ' + edtEspecie.Text
          Else
            frxReport.Script.Variables['ESPECIE'] := 'ESPECIE: TODOS ';

          frxReport.Script.Variables['REDE_LOJAS'] := fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS');

          case rdgSaldo.ItemIndex of
            0 : frxReport.Script.Variables['SALDO'] := 'SALDO: POSITIVO';
            1 : frxReport.Script.Variables['SALDO'] := 'SALDO: NEGATIVO';
            2 : frxReport.Script.Variables['SALDO'] := 'SALDO: ZERO';
            3 : frxReport.Script.Variables['SALDO'] := 'SALDO: TODOS';
          end;

          frxReport.Script.Variables['DATA_INICIAL'] := mskDtaIni.Text;
          frxReport.Script.Variables['DATA_FINAL']   := mskDtaFin.Text;

          frxReport.Script.Variables['GIRO'] := '';
          if rdgGirEst.ItemIndex > 0 then
          begin
            frxReport.Script.Variables['GIRO'] := 'GIRO ' + IIF(rdgGirEst.ItemIndex = 1, '3', IIF(rdgGirEst.ItemIndex = 2, '6', '12')) + ' MESES:';
          end;

          frxReport.Script.Variables['EXB_SUPEST'] := IIF(chkSupEst.Checked, 'S', 'N');
          frxReport.Script.Variables['EXB_CODFAB'] := IIF(chkCodFab.Checked, 'S', 'N');
          frxReport.Script.Variables['EXB_CODDEP'] := IIF(chkExbDep.Checked, 'S', 'N');

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frxReport)
          Else
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[frmRelFatListVenRep.btnImprimirClick]');
          End;
        End;

      End;

      If chkGerOrc.Checked Then
      Begin
        If chkAbaMul.Checked Then
          objGeraOr.tpTipoMultiplo := tpmlCompra
        Else
          objGeraOr.tpTipoMultiplo := tpmlIndefinido;

        objGeraOR.strEmpresas := fArrCodigosToLista(edtEmpresa.Text, arrEmpresa, False);
        objGeraOR.strEmpresas_ext := fArrCodigosToLista(edtEmpresa.Text, arrEmpresa, False);

        objGeraOr.blnLimSal := False;
        objGeraOR.pGeraOrcamento(edtEmpresa.Text, edtEmpresa, arrEmpresa, False, opcVendaReposicao, Nil, Nil, rdgGirEst.ItemIndex <> 0, IIF(rdgGirEst.ItemIndex = 0, 0, IIF(rdgGirEst.ItemIndex = 1, 3, IIF(rdgGirEst.ItemIndex = 2, 6, 12))));
      End;

    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

  FreeAndNil(qryGenRep);

end;

procedure TfrmRelFatListVenRep.chkAbaMulEnter(Sender: TObject);
begin
  inherited;

  If (chkAbaMul.Enabled) And (chkAbaMul.Focused) Then
  Begin
    HintControler.ShowHint(Self.Left + chkAbaMul.Left,
                           Self.Top + chkAbaMul.Top + 50,
       'Considerar abastecimento com múltiplo de compra',
       'Apenas para os itens que estão com a configuração: ' + #13#10 +
       '"No Abastecimento das Filiais, abastecer com Múltiplo de Compras" = "SIM"');
  End;

end;

procedure TfrmRelFatListVenRep.chkAbaMulExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmRelFatListVenRep.chkGerOrcClick(Sender: TObject);
begin
 chkAbaMul.Enabled := chkGerOrc.Checked;
  If chkAbaMul.Enabled Then
    chkAbaMul.Checked := False;
end;

function TfrmRelFatListVenRep.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  Var
    intContador: Integer;
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

    Else If (Sender = mskHorIni) Or (Sender = mskHorFin) Then
    Begin

      If (Sender = mskHorIni) Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskHorIni.Text, True, False, False, True)) Then
        Begin
          Try
            StrToTime(mskHorIni.Text);
            mskHorFin.Enabled := True;
          Except
            fMensagem('', 'O campo Hora Inicial deve ser preenchido corretamente!', ['&O k']);
            Result := False;
          End;
        End
        Else
        Begin
          mskHorFin.Clear;
          mskHorFin.Enabled := False;
        End;
      End
      Else
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskHorFin.Text, True, False, False, True)) Then
        Begin
          Try
            StrToTime(mskHorFin.Text);
          Except
            fMensagem('', 'O campo Hora Final deve ser preenchido corretamente!', ['&O k']);
            Result := False;
          End;
        End
        Else If Not fEmptyStr(fTiraCaracEspeciais(mskHorIni.Text, True, False, False, True)) Then
        Begin
            fMensagem('', 'O campo Hora Final também deve ser preenchido!', ['&O k']);
            Result := False;
        End;
      End;

      If Result Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskHorIni.Text, True, False, False, True)) And Not fEmptyStr(fTiraCaracEspeciais(mskHorFin.Text, True, False, False, True)) Then
        Begin
          If StrToTime(mskHorIni.Text) > StrToTime(mskHorFin.Text) Then
          Begin
            fMensagem('','A Hora Inicial deve ser menor ou igual que a Hora Final!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = mskLinhaGrupo) Then
    Begin
      If fEmptyStr(mskLinhaGrupo.Text) Then
        edtProdutos.Enabled := True
      Else
        edtProdutos.Enabled := False;

      pDesmarcaLista(mskLinhaGrupo,arrLinhaGrupo,'',6);
    End

    Else If (Sender = edtProdutos) Then
    Begin
      pDesmarcaLista(edtProdutos, arrProduto);
    End

    Else If (Sender = edtDepartamento) Then
    Begin
      pDesmarcaLista(edtDepartamento, arrDepartamento);
    End

    Else If (Sender = edtMarca) Then
    Begin
      pDesmarcaLista(edtMarca, arrMarca);
    End

    Else If (Sender = edtGruCmp) Then
    Begin
      pDesmarcaLista(edtGruCmp, arrGruCmp);
    End

    Else If (Sender = edtCliente) Then
    Begin
      pDesmarcaLista(edtCliente, arrLinhaClien);
    End

    Else If (Sender = edtCodRede) Then
    Begin
      pDesmarcaLista(edtCodRede, arrRede);
    End

    Else If (Sender = edtFornecedor) Then
    Begin
      pDesmarcaLista(edtFornecedor, arrFornecedor);
    End

    Else If (Sender = edtVendedor) Then
    Begin
      pDesmarcaLista(edtVendedor, arrVendedor);
    End

    Else If (Sender = edtUnidade) Then
    Begin
      pDesmarcaLista(edtUnidade, arrUnidade);
    End

    Else
    If (Sender = edtTipo) Then
    Begin
      If (edtTipo.Text <> 'A') And (edtTipo.Text <> 'S') Then
      Begin
        fMensagem('','O campo tipo deve ter A ou S!',['&O K'],0);
        Result := False;
      End;
    End

    Else
    If (Sender = edtOrdena) Then
    Begin
      If (edtTipo.Text = 'A') Then
      Begin
        If (edtOrdena.Text <> 'G') And (edtOrdena.Text <> 'A') Then
        Begin
          fMensagem('','O campo ordena deve ter G ou A!',['&O K'],0);
          Result := False;
        End;
      End
      Else
      Begin
        If (edtOrdena.Text <> 'G') And (edtOrdena.Text <> 'A') And (edtOrdena.Text <> 'F') Then
        Begin
          fMensagem('','O campo ordena deve ter G, F ou A!',['&O K'],0);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtEmpresa) Then
    Begin
      If Not fEmptyStr(edtEmpresa.Text) Then
      Begin
        If (edtEmpresa.Text <> '000') Then
          edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não cadastrada!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Length(arrEmpresa) > 0 Then
          Begin
            For intContador := Low(arrEmpresa) To High(arrEmpresa) Do
            Begin
              If Pos(arrEmpresa[intContador].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
              Begin
                fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso em algumas das empresas selecionadas!', ['&O k']);
                Result := False;
                Break;
              End;
            End;
          End
          Else
          Begin
            If Pos(edtEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
              Result := False;
            End;
          End;
        End;
      End
      Else
        pDesmarcaLista(edtEmpresa, arrEmpresa);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelFatListVenRep.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtProdutos);
  qryGenMar := fCriaQuery(Self);
  qryGenGru := fCriaQuery(Self);
  qryGenUni := fCriaQuery(Self);
  pAtualizaClaFis;
  fGravaFatGor := Nil;
  fGravaFatDor := Nil;

  cdsItens := TZClient.Create(Self);

  blnBEFTRG := fCfgSis('BEFTRG', VarBoolean);
  chkEntFut.Checked := Not blnBEFTRG;
  chkEntFut.Visible := Not blnBEFTRG;
end;

procedure TfrmRelFatListVenRep.pAtualizaClafis;
  Var
    strClaFis: String;
begin

  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;

end;

procedure TfrmRelFatListVenRep.edtUnidadeExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtUnidade,nil,arrUnidade,fRetNomUnidade,Nil,'da Unidade');
end;

procedure TfrmRelFatListVenRep.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, arrUnidade, False) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatListVenRep.edtDepartamentoExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtDepartamento,edtDesDepartamento,arrDepartamento,fRetNomDep,nil,'do Departamento');
end;

procedure TfrmRelFatListVenRep.edtDepartamentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqDepartamento(Self, edtDepartamento, edtDesDepartamento, nil, key, arrDepartamento, False) Then
  Begin
    if fValidaCampos(edtDepartamento, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatListVenRep.edtDestinoExit(Sender: TObject);
begin
//  inherited;

  If fEmptyStr(edtDestino.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
    pSetFocus(edtDestino);
  End
  Else If Pos(edtDestino.Text, 'V_I_E_') <= 0 Then
  Begin
    pSetFocus(edtDestino);
  End;
end;

procedure TfrmRelFatListVenRep.btnAltOrcClick(Sender: TObject);
begin
  inherited;

  objGeraOR.pAlteraOrcamento;
end;

procedure TfrmRelFatListVenRep.edtTipoExit(Sender: TObject);
begin
  inherited;

  chkGerOrc.Enabled := edtTipo.Text = 'S';
  chkAbaMul.Enabled := edtTipo.Text = 'S';
  chkCodFab.Enabled := edtTipo.Text = 'S';
  chkExbDep.Enabled := edtTipo.Text = 'S';

  If Not chkCodFab.Enabled Then
    chkCodFab.Checked := False;

  If Not chkExbDep.Enabled Then
    chkExbDep.Checked := False;

  If Not chkGerOrc.Enabled Then
  Begin
    chkGerOrc.Checked := False;
    chkAbaMul.Checked := False;
  End;

  If (edtTipo.Text = 'A') Then
    lblOrdena.Caption := '(G)rupo + Alfabético   (A)lfabético'
  Else
    lblOrdena.Caption := '(G)rupo + Alfabético   (F)ornecedor + Alfabético   (A)lfabético';
  lblOrdena.Repaint;
end;

Procedure TfrmRelFatListVenRep.pAbreQueryItens(strEmpresas: String; qryItens: TZClient; strCodEmpCD: String='');
Begin
  With qryItens, qryQuery Do
  Begin
    Self.strEmpresas := strEmpresas;

    Close;
    SQL.Clear;
    SQL.Add(fRetSqlRel(True, strEmpresas, strCodEmpCD));

    pSetaParametros(qryQuery, True, strCodEmpCD);

    fAbreClient(True, 'TfrmRelFatListVenRep.pAbreQueryItens');
  End;
End;

procedure TfrmRelFatListVenRep.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objGeraOR);
end;

end.

