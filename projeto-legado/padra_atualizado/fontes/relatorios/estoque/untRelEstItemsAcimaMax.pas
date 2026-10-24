unit untRelEstItemsAcimaMax;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, untRelGeraOr,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni, DB,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  Menus, Windows, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, AppEvnts,
  untFuncoesSimples, untFuncoesRel, BitBtnLockedIncrem,
  untZClient, cxHint, ComboBoxFocus, untTypesSistema, frxExportCSVTestabilidade,
  RLReport;

type
  TfrmRelEstItemsAcimaMax = class(TfrmPaiRelatorio)
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDescri: TEditFocus;
    lblDescricao: TLabel;
    edtRefere: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtUnidade: TEditFocus;
    Label3: TLabel;
    mskLinhaGrupo2: TMaskEditFocus;
    GroupBox1: TGroupBox;
    edtOpcao: TEditFocus;
    ColorLabel2: TColorLabel;
    edtDesGrupo: TEditFocus;
    edtDesGrupo2: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDesMarca: TEditFocus;
    rdgStatus: TRadioGroup;
    rdgSaldo: TRadioGroup;
    chkImpRef: TCheckBox;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    chkGerOrc: TCheckBox;
    Label15: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    chkInativoCompra: TCheckBox;
    gpbPreco: TGroupBox;
    edtExiPre: TEditFocus;
    ColorLabel3: TColorLabel;
    shpPreco: TShape;
    cmbTipPre: TComboBoxFocus;
    Label4: TLabel;
    Label5: TLabel;
    lblEmpresaAbastecer: TLabel;
    edtCodEmpresaAbastecer: TEditFocus;
    edtDesEmpresaAbastecer: TEditFocus;
    Label14: TLabel;
    edtCodDep: TEditFocus;
    edtDesCodDep: TEditFocus;
    rdgSaldoProduto: TRadioGroup;
    Label6: TLabel;
    edtSitPro: TEditFocus;
    edtDesPro: TEditFocus;
    frxReportJ: TfrxReport;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupo2Exit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupo2KeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaFornecedor(Var qryCadFor: TUniQuery);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaMarca(Var qryCadMar: TUniQuery);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtUnidadeExit(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkGerOrcClick(Sender: TObject);
    procedure edtCodEmpresaAbastecerExit(Sender: TObject);
    procedure edtCodEmpresaAbastecerKeyPress(Sender: TObject; var Key: Char);
    procedure chkGerOrcExit(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtSitProExit(Sender: TObject);
    procedure edtSitProKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FCFGTRITTE: Boolean;
    objGeraOR: TRelGeraOR;

    strLinFor: String;
    strLinMar: String;
    strLinEmp: String;
    strLinEmpAbs: String;
    strLinUni: String;
    strGruCmp: String;
    strCodDep: String;
    strSitPro: String;

    arrGruCmp,
    arrCodDep,
    arrSitPro: TConsultasArray;
    qryRelatorio: TUniQuery;

    function fGetSqlItens(strCodEmp: String): String;
    procedure pGeraExcel;
    procedure pGeraExcelHTML;
    function onTrataValorQuebra(DataSet: TDataSet; AValor, AFieldName: String): String;

    procedure pAbreQueryItens(strCodEmp: String; qryItens: TZClient; strCodEmpCD: String='');

    procedure pCriaQryRelatorio;
    Function fEmpSelecionadaIgualEmpLogada: Boolean;
    function fTabelasComFiltros(blnEmpDis: boolean = False): string;
    Procedure pSetarParametros(qry: TUniQuery);
    function fRetWhereSaldoEmpAbastecida: String;
    function fTitEmpresa(strEmp: String): String;
    procedure pCampoEmpresaDefault;
    function fRetSaldo(strAliasIteger, strAliasCadite: string): string;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    fGravaFatGor : TfGravaFatGor;
    fGravaFatDor : TfGravaFatDor;

    // VARIAVEIS UTILIZADOS PELA GERACAO DO PEDIDO
    strEspDoc : String;
    strMen001 : String;
    strMen002 : String;
    strCodTra : String;
    fltValFre : Double;
    strTipFre : String;
    strTipPed : String;
    strEntFat : String;

    arrLinFor: TConsultasArray;
    arrLinMar: TConsultasArray;
    arrLinEmp: TConsultasArray;
    arrLinEmpAbs: TConsultasArray;
    arrLinUni: TConsultasArray;
  end;


implementation

uses untFuncoesConsulta, untExcel, untConsultas, untMsgValidacaoGeracaoOrcPed,
     untGeraExcelHtml;

{$R *.dfm}

procedure TfrmRelEstItemsAcimaMax.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);
    If fEmptyStr(edtDesGrupo.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo.Clear;
      pSetFocus(mskLinhaGrupo);
    End;
  End;
end;

procedure TfrmRelEstItemsAcimaMax.mskLinhaGrupo2Exit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo2.Text) Then
    edtDesGrupo2.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo2.Text := fRetNomeLinhaGrupo(mskLinhaGrupo2.Text);
    If fEmptyStr(edtDesGrupo2.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo2.Clear;
      pSetFocus(mskLinhaGrupo2);
    End;
  End;
end;

procedure TfrmRelEstItemsAcimaMax.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelEstItemsAcimaMax.onTrataValorQuebra(DataSet: TDataSet; AValor,
  AFieldName: String): String;
  var strCodigo: String;
begin
  Result := AValor;
  If AFieldName = 'GRUPO' Then
  Begin
    strCodigo := LeftStr(DataSet.FieldByName('GRUPO').AsString,3) + '.' + RightStr(DataSet.FieldByName('GRUPO').AsString,3);
    Result := strCodigo + '-' + fRetNomeLinhaGrupo(DataSet.FieldByName('GRUPO').AsString);
  End;
  If AFieldName = 'LINHA' Then
  Begin
    strCodigo := LeftStr(DataSet.FieldByName('LINHA').AsString, 3) + '.000';
    Result := strCodigo + '-' + fRetNomeLinhaGrupo(DataSet.FieldByName('LINHA').AsString + '000');
  End;
  If AFieldName = 'DESMAR' Then
    Result := 'MARCA: ' + AValor;
end;

procedure TfrmRelEstItemsAcimaMax.mskLinhaGrupo2KeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fPesqGrupo(Self, mskLinhaGrupo2, edtDesGrupo2, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(mskLinhaGrupo2, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAcimaMax.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrLinFor, fRetNomFornecedor, Nil, 'do Produto');
end;

procedure TfrmRelEstItemsAcimaMax.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrLinFor, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAcimaMax.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmRelEstItemsAcimaMax.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAcimaMax.pAbreQueryItens(strCodEmp: String; qryItens: TZClient; strCodEmpCD: String='');
begin

  With qryItens, qryQuery Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSqlItens(strCodEmp));

    pSetaParam(edtFornecedor.Text, arrLinFor, strLinFor, 'CODFOR', qryQuery);
    pSetaParam(edtMarca.Text,      arrLinMar, strLinMar, 'CODMAR', qryQuery);
    pSetaParam(edtCodDep.Text,     arrCodDep, strCodDep, 'CODDEP', qryQuery);
    pSetaParam(edtUnidade.Text,    arrLinUni, strLinUni, 'CODUNI', qryQuery);
    pSetaParam(edtSitPro.Text,     arrSitPro, strSitPro, 'SITPRO', qryQuery);
    {*****************************************}
    { PARAMETRO DO FILTRO "GRUPO DE COMPRAS" *}
    {15/08/2012****************************CI*}
    pSetaParam(edtGruCmp.Text,     arrGruCmp, strGruCmp, 'GRUCMP', qryQuery);

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;
    End;

    If Not fEmptyStr(mskLinhaGrupo2.Text) Then
    Begin
      ParamByName('CODGRU2').AsString := mskLinhaGrupo2.Text;
    End;

    If Not fEmptyStr(edtDescri.Text) Then
    Begin
      ParamByName('DESITE').AsString := edtDescri.Text + '%';
    End;

    If Not fEmptyStr(edtRefere.Text) Then
    Begin
      ParamByName('REFERE').AsString := edtRefere.Text + '%';
    End;

    fAbreClient(True, 'TfrmRelEstItemsAcimaMax.pAbreQueryItens');
  End;
end;

procedure TfrmRelEstItemsAcimaMax.pCampoEmpresaDefault;
begin
  lblEmpresa.Caption := 'Empresa';
  edtCodEmpresaAbastecer.Clear;
  edtDesEmpresaAbastecer.Clear;
  lblEmpresaAbastecer.Visible := False;
  edtCodEmpresaAbastecer.Visible := False;
  edtDesEmpresaAbastecer.Visible := False;
  edtDesEmpresa.Width := edtDesGruCmp.Width;
  edtCodEmpresa.Enabled := True;
end;

procedure TfrmRelEstItemsAcimaMax.pCarregaFornecedor(Var qryCadFor: TUniQuery);
Begin
  If Not fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := qryCadFor.FieldByName('FOR_NOMFOR').AsString
  Else
    edtDesFornecedor.Text := '';
End;

procedure TfrmRelEstItemsAcimaMax.edtMarcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtMarca, edtDesMarca ,arrLinMar, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmRelEstItemsAcimaMax.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrLinMar, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAcimaMax.edtSitProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtSitPro, edtDesPro, arrSitPro, fRetNomSituacaoProduto, nil, 'da Situação do Produto');
end;

procedure TfrmRelEstItemsAcimaMax.edtSitProKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqSituacaoProduto(Self, edtSitPro, edtDesPro, nil, key, arrSitPro, False) Then
  Begin
    if fValidaCampos(edtSitPro, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstItemsAcimaMax.pCarregaMarca(Var qryCadMar: TUniQuery);
Begin
  If Not fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := qryCadMar.FieldByName('MAR_DESMAR').AsString
  Else
    edtDesFornecedor.Text := '';
End;

procedure TfrmRelEstItemsAcimaMax.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;


end;

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmRelEstItemsAcimaMax.fRetWhereSaldoEmpAbastecida: String;
begin
  Result := ' FALSE ';
  If Not fEmptyStr(edtCodEmpresaAbastecer.Text) Then
    Result := 'X.ITE_CODEMP = '+QuotedStr(edtCodEmpresaAbastecer.Text)+ ' AND X.ITE_CODITE = G.ITE_CODITE ';
end;

function TfrmRelEstItemsAcimaMax.fTitEmpresa(strEmp: String): String;
begin
  Result := '';
  If chkGerOrc.Checked Then
    Result := ' '+strEmp;
end;

function TfrmRelEstItemsAcimaMax.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intIndex: Integer;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtOpcao) Then
    Begin
      If (edtOpcao.Text <> 'A') And (edtOpcao.Text <> 'L') And (edtOpcao.Text <> 'M') Then
      Begin
        fMensagem('','O campo opcao deve ter A, L ou M!',['&O K'],0);
        Result := False;
      End;
    End
    Else

    If (Sender = mskLinhaGrupo) Then
    Begin
      mskLinhaGrupo2.Enabled := Not fEmptyStr(mskLinhaGrupo.Text);
    End

    Else If (Sender = edtFornecedor) Then
    Begin
      pDesmarcaLista(edtFornecedor, arrLinFor);
    End

    Else If (Sender = edtMarca) Then
    Begin
      pDesmarcaLista(edtMarca, arrLinMar);
    End

    {******************************}
    {* VALIDA GRUPO DE COMPRA     *}
    {15/08/2012*****************CI*}
    Else If (Sender = edtGruCmp) Then
    Begin
      pDesmarcaLista(edtGruCmp,arrGruCmp);
    End

    Else If (Sender = edtUnidade) Then
    Begin
      pDesmarcaLista(edtUnidade, arrLinUni);
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
    End

    {**************************}
    {* VERIFICA CAMPO EMPRESA *}
    {***********************LU*}
    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If (edtCodEmpresa.Text <> '000') Then
          edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não cadastrada!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Length(arrLinEmp) > 0 Then
          Begin
            For intIndex := Low(arrLinEmp) To High(arrLinEmp) Do
              If Pos(arrLinEmp[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
              Begin
                fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrLinEmp[intIndex].strCodigo + '!', ['&O k']);
                Break;
                Result := False;
              End;
          End
          Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else pDesmarcaLista(edtCodEmpresa, arrLinEmp);

    End

    Else If (Sender = edtCodEmpresaAbastecer) And (edtCodEmpresaAbastecer.Visible) Then
    Begin
      If Not fEmptyStr(edtCodEmpresaAbastecer.Text) Then
      Begin
        If fEmptyStr(fRetNomeEmpresaSelec(edtCodEmpresaAbastecer.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não cadastrada!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Pos(edtCodEmpresaAbastecer.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End;
        End;
      End
//      Else
//      Begin
//        fMensagem('ATENÇÃO!', 'Informe a empresa a ser abastecida!', ['&O k']);
//        Result := False;
//      End;
    End

    Else
    if (Sender = edtExiPre) Then
    Begin
      cmbTipPre.Enabled := (edtExiPre.Text = 'S');
      cmbTipPre.TabStop := (edtExiPre.Text = 'S');
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmRelEstItemsAcimaMax.fEmpSelecionadaIgualEmpLogada: Boolean;
  Var
    intCont: Integer;
Begin
  Result := False;

  If Not fEmptyStr(edtCodEmpresaAbastecer.Text) Then
  Begin
    If (Length(arrLinEmpAbs) > 0) Then
    Begin
      For intCont := Low(arrLinEmpAbs) To High(arrLinEmpAbs) Do
      Begin
        If SameText(arrLinEmpAbs[intCont].strCodigo, VS_strCodEmp) Then
        Begin
          Result := True;
          Break;
        End;
      End;
    End;
  End;
End;


function TfrmRelEstItemsAcimaMax.fTabelasComFiltros(blnEmpDis: boolean = False): string;
Begin
    Result := Result + 'FROM ';
    Result := Result + '  CADITE I ';
    Result := Result + '  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
    Result := Result + '  INNER JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
    Result := Result + '  INNER JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
    Result := Result + '  LEFT  JOIN CADGRU L ON L.GRU_CODGRU = CONCAT(LEFT(I.ITE_CODGRU, 3),"000") ';
    Result := Result + '  LEFT  JOIN CADGRU R ON R.GRU_CODGRU = I.ITE_CODGRU ';
    Result := Result + 'WHERE ';
    Result := Result + '  TRUE ';

    if FCFGTRITTE then
      Result := Result + ' AND IFNULL(I.ITE_TRITTE, "N") = "S" ';

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin

      If RightStr(mskLinhaGrupo.Text,2) = '000' Then
      Begin

        If Not fEmptyStr(mskLinhaGrupo2.Text) Then
        Begin

          If RightStr(mskLinhaGrupo2.Text,3) = '000' Then
            Result := Result + '  AND LEFT(I.ITE_CODGRU,3) BETWEEN LEFT(:CODGRU,3) AND LEFT(:CODGRU2,3) '
          Else
            Result := Result + '  AND I.ITE_CODGRU BETWEEN CONCAT(LEFT(:CODGRU,3),"000") AND :CODGRU2 ';

        End
        Else
        Begin
          Result := Result + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:CODGRU,3) ';
        End;

      End
      Else
      Begin

        If Not fEmptyStr(mskLinhaGrupo2.Text) Then
        Begin

          If RightStr(mskLinhaGrupo2.Text,3) = '000' Then
            Result := Result + '  AND I.ITE_CODGRU BETWEEN :CODGRU AND CONCAT(LEFT(:CODGRU2,3),"099") '
          Else
            Result := Result + '  AND I.ITE_CODGRU BETWEEN :CODGRU AND :CODGRU2 ';

        End
        Else
        Begin
          Result := Result + '  AND I.ITE_CODGRU = :CODGRU ';
        End;

      End;

    End;

    If blnEmpDis Then
    Begin
      Result := Result + ' AND G.ITE_CODEMP <> "' + edtCodEmpresa.Text + '"';
      Result := Result + ' AND LOCATE(G.ITE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End
    Else
      Result := Result + fStrLocate(edtCodEmpresa, arrLinEmp, 'G.ITE_CODEMP', 'CODEMP');
    Result := Result + fStrLocate(edtFornecedor, arrLinFor, 'I.ITE_CODFOR', 'CODFOR');
    Result := Result + fStrLocate(edtMarca,      arrLinMar, 'I.ITE_CODMAR', 'CODMAR');
    Result := Result + fStrLocate(edtCodDep,     arrCodDep, 'I.ITE_CODDEP', 'CODDEP');
    Result := Result + fStrLocate(edtUnidade,    arrLinUni, 'I.ITE_CODUNI', 'CODUNI');
    Result := Result + fStrLocate(edtSitPro,     arrSitPro, 'I.ITE_SITPRO', 'SITPRO');
    {*****************************}
    { FILTRO "GRUPO DE COMPRAS"  *}
    {15/08/2012****************CI*}
    Result := Result + fStrLocate(edtGruCmp,     arrGruCmp, 'I.ITE_GRUCMP', 'GRUCMP');

    If Not fEmptyStr(edtDescri.Text) Then
    Begin
      Result := Result + '  AND I.ITE_DESITE LIKE :DESITE ';
    End;

    If Not fEmptyStr(edtRefere.Text) Then
    Begin
      Result := Result + '  AND I.ITE_REFERE LIKE :REFERE ';
    End;

    //*****************************************//
    // FILTRAR STATUS (ATIVO, INATIVO , TODOS)*//
    // DO PRODUTO                             *//
    //***************************************RL//
    If rdgStatus.ItemIndex = 0 Then
      Result := Result + ' AND I.ITE_ITEATI = ' + QuotedStr('S') + ' '
    Else If rdgStatus.ItemIndex = 1 Then
      Result := Result + ' AND I.ITE_ITEATI = ' + QuotedStr('N') + ' ';

    {******************************************************}
    {* FILTRO PARA EXCLUIR INATIVOS DE COMPRA DA LISTAGEM *}
    {************************************************ GB **}
    If not chkInativoCompra.Checked Then
      Result := Result + '  AND I.ITE_ATICOM = "S" ';

end;

Procedure TfrmRelEstItemsAcimaMax.pSetarParametros(qry: TUniQuery);
begin

  pSetaParam(edtFornecedor.Text, arrLinFor, strLinFor, 'CODFOR', qry);
  pSetaParam(edtMarca.Text,      arrLinMar, strLinMar, 'CODMAR', qry);
  pSetaParam(edtCodDep.Text,     arrCodDep, strCodDep, 'CODDEP', qry);
  pSetaParam(edtCodEmpresa.Text, arrLinEmp, strLinEmp, 'CODEMP', qry);
  pSetaParam(edtUnidade.Text,    arrLinUni, strLinUni, 'CODUNI', qry);
  pSetaParam(edtSitPro.Text,     arrSitPro, strSitPro, 'SITPRO', qry);
  {*****************************************}
  { PARAMETRO DO FILTRO "GRUPO DE COMPRAS" *}
  {15/08/2012****************************CI*}
  pSetaParam(edtGruCmp.Text,     arrGruCmp, strGruCmp, 'GRUCMP', qryRelatorio);

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
    qry.ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

  If Not fEmptyStr(mskLinhaGrupo2.Text) Then
    qry.ParamByName('CODGRU2').AsString := mskLinhaGrupo2.Text;

  If Not fEmptyStr(edtDescri.Text) Then
    qry.ParamByName('DESITE').AsString := edtDescri.Text + '%';

  If Not fEmptyStr(edtRefere.Text) Then
    qry.ParamByName('REFERE').AsString := edtRefere.Text + '%';
End;

function TfrmRelEstItemsAcimaMax.fRetSaldo(strAliasIteger, strAliasCadite: string): string;
var
  strSALDO_FISICO,
  strSALDO_SALREG,
  strSALDO_QTPD_V,
  strSALDO_QTPD_E,
  strSALDO_QTPD_P,
  strSALDO_SDPDBF,
  strSALDO_SALEXT,
  strSALDO_QTEF_P,
  strSALDO_QTEF_F,
  strSALDO_QTEF_A: string;

  intCALSAL: Integer;

  blnORDPRO,
  blnUTIWMS,
  blnESTEXT,
  blnENTFUT,
  blnBEFTRG,
  blnPEDBEF: Boolean;
begin
  Result := '';

  intCALSAL := fCfgSis('CALSAL', varInteger);

  blnORDPRO := fCfgSis('ORDPRO', varBoolean);
  blnUTIWMS := fCfgSis('UTIWMS', varBoolean);
  blnESTEXT := fCfgSis('ESTEXT', varBoolean);
  blnENTFUT := fCfgSis('ENTFUT', varBoolean);
  blnBEFTRG := fCfgSis('BEFTRG', varBoolean);
  blnPEDBEF := fUsaPedidoBaixaEntregaFutura;

  strSALDO_FISICO := 'IFNULL(' + strAliasIteger + '.ITE_SALDOS + IF(IFNULL(' + strAliasCadite + '.ITE_CNV_ML, 0) > 0, ' + strAliasIteger + '.ITE_SAL_ML / ' + strAliasCadite + '.ITE_CNV_ML, 0),0) + ' + IfThen(blnENTFUT, '(IFNULL(' + strAliasIteger + '.ITE_QTEF_A,0) + IFNULL(' + strAliasIteger + '.ITE_QTEF_F,0) + IFNULL(' + strAliasIteger + '.ITE_QTEF_P,0))', '0');
  strSALDO_SALREG := 'IFNULL(IFNULL(' + strAliasIteger + '.ITE_SALREG,0),0)';
  strSALDO_QTPD_V := '(IFNULL(' + strAliasIteger + '.ITE_QTPD_V,0)+IFNULL(' + strAliasIteger + '.ITE_QTPD_F,0))';
  strSALDO_QTPD_E := 'IFNULL(IFNULL(' + strAliasIteger + '.ITE_QTPD_E,0),0)';
  strSALDO_QTPD_P := IfThen(blnORDPRO, 'IFNULL(' + strAliasIteger + '.ITE_QTPD_P,0)', '0');
  strSALDO_SDPDBF := IfThen((not blnUTIWMS) and (not blnBEFTRG) and (intCALSAL <> 2) and (blnENTFUT) and (blnPEDBEF), 'IFNULL(' + strAliasIteger + '.ITE_SDPDBF, 0)', '0');
  strSALDO_SALEXT := IfThen(blnESTEXT, 'IFNULL(' + strAliasIteger + '.ITE_SALEXT,0)', '0');
  strSALDO_QTEF_P := IfThen(blnENTFUT, 'IFNULL(' + strAliasIteger + '.ITE_QTEF_P,0)', '0');
  strSALDO_QTEF_F := IfThen(blnENTFUT, 'IFNULL(' + strAliasIteger + '.ITE_QTEF_F,0)', '0');
  strSALDO_QTEF_A := IfThen(blnENTFUT, 'IFNULL(' + strAliasIteger + '.ITE_QTEF_A,0)', '0');

  if (rdgSaldoProduto.ItemIndex = 0) then
    Result := Result + strAliasIteger + '.ITE_SALDOS'
  else
  begin
    case intCALSAL of
      1: Result := (strSALDO_FISICO) + ' - ' + (strSALDO_SALREG) + ' - ' + (strSALDO_QTPD_V) + ' - ' + (strSALDO_QTPD_E) + ' - ' + (strSALDO_QTPD_P) + ' - ' + (strSALDO_SDPDBF) + ' - ' + (strSALDO_SALEXT);
      2: Result := (strSALDO_FISICO) + ' - ' + (strSALDO_SALREG) + ' - ' + (strSALDO_QTPD_V) + ' - ' + (strSALDO_QTPD_E) + ' - ' + (strSALDO_QTPD_P) + ' - ' + (strSALDO_QTEF_P) + ' - ' + (strSALDO_QTEF_F) + ' - ' + (strSALDO_QTEF_A) + ' - ' + (strSALDO_SALEXT);
      3: Result := (strSALDO_FISICO) + ' - ' + (strSALDO_SALREG) + ' - ' + (strSALDO_QTPD_V) + ' - ' + (strSALDO_QTPD_E) + ' - ' + (strSALDO_QTPD_P) + ' - ' + (strSALDO_QTEF_P) + ' - ' + (strSALDO_QTEF_A) + ' - ' + (strSALDO_SDPDBF) + ' - ' + (strSALDO_SALEXT);
      4: Result := (strSALDO_FISICO) + ' - ' + (strSALDO_SALREG) + ' - ' + (strSALDO_QTPD_V) + ' - ' + (strSALDO_QTPD_E) + ' - ' + (strSALDO_QTPD_P) + ' - ' + (strSALDO_QTEF_F) + ' - ' + (strSALDO_SDPDBF) + ' - ' + (strSALDO_SALEXT);
      5: Result := (strSALDO_FISICO) + ' - ' + (strSALDO_SALREG) + ' - ' + (strSALDO_QTPD_V) + ' - ' + (strSALDO_QTPD_E) + ' - ' + (strSALDO_QTPD_P) + ' - ' + (strSALDO_QTEF_P) + ' - ' + (strSALDO_SDPDBF) + ' - ' + (strSALDO_SALEXT);
    end;
  end;

end;

procedure TfrmRelEstItemsAcimaMax.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    qryEmpresasDestino :  TZClient;
    blnDistribuirExcedente: Boolean;
    frxReport: TfrxReport;

  Function fRetValUni : String;
  Begin
    Case cmbTipPre.ItemIndex Of
      0: Result := 'ITE_PRECUS';
      1: Result := 'ITE_PREULT';
      2: Result := 'ITE_IMPULT';
      3: Result := 'ITE_PREMED';
    End;
  End;

begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  qryEmpresasDestino := TZClient.Create(Nil);

  If Not chkGerOrc.Checked And edtCodEmpresaAbastecer.Visible then
  Begin
    pCampoEmpresaDefault;
  End;

  If blnImprime Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  LEFT(I.ITE_CODGRU,3) AS LINHA, ';
    strSQL := strSQL + '  L.GRU_DESGRU AS DESLIN, ';
    strSQL := strSQL + '  I.ITE_CODGRU AS GRUPO,  ';
    strSQL := strSQL + '  R.GRU_DESGRU AS DESGRU, ';
    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  I.ITE_CODUNI AS UNIDAD, ';
    strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';
    strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '  " "          AS COMPRA, ';
    strSQL := strSQL + '  SUM(' + fRetSaldo('G', 'I') + ') AS SALDOS, ';
    strSQL := strSQL + '  SUM(G.ITE_ESTMAX) AS ESTMAX, ';
    strSQL := strSQL + '  SUM(' + fRetSaldo('G', 'I') + ' - G.ITE_ESTMAX) AS SALMAX, ';
    strSQL := strSQL + '  SUM(G.ITE_SALDOS - G.ITE_ESTMAX) AS SALUSO, ';

    strSQL := strSQL + '  (SELECT SUM(' + fRetSaldo('X', 'Y') + ') FROM ITEGER X JOIN CADITE Y ON X.ITE_CODITE = Y.ITE_CODITE WHERE '+fRetWhereSaldoEmpAbastecida+') AS SALDOSABS, ';
    strSQL := strSQL + '  (SELECT SUM(X.ITE_ESTMAX) FROM ITEGER X WHERE '+fRetWhereSaldoEmpAbastecida+') AS ESTMAXABS, ';
    strSQL := strSQL + '  (SELECT SUM(' + fRetSaldo('X', 'Y') + ' - X.ITE_ESTMAX) FROM ITEGER X JOIN CADITE Y ON X.ITE_CODITE = Y.ITE_CODITE WHERE '+fRetWhereSaldoEmpAbastecida+') AS SALMAXABS, ';

    if edtExiPre.Text = 'S' Then
    Begin
      strSQL := strSQL + fRetValUni + ' AS VALUNI, ';
      strSQL := strSQL + fRetValUni + ' * SUM(G.ITE_SALDOS - G.ITE_ESTMAX) AS VALTOT  ';
    End
    Else
    Begin
      strSQL := strSQL + ' 0.00 AS VALUNI, ';
      strSQL := strSQL + ' 0.00 AS VALTOT  ';
    End;

    strSQl :=  strSQL + fTabelasComFiltros(False);

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  G.ITE_CODITE ';

    strSQL := strSQL + 'HAVING ';
   //*********************************************//
   // SE SOMA DO SALDO EST. MAIS EST. MAX         //
   // FOR MAIOR QUE ZERO, ENTÃO IMPRIMI REGISTRO, //
   // SENÃO NÃO IMPRIMI
   //******************************************RL*//
    strSQL := strSQL + ' (SALDOS + ESTMAX) > 0 AND ';
    strSQL := strSQL + ' (SALDOS >= ESTMAX) ';

    Case rdgSaldo.ItemIndex Of
      0: strSQL := strSQL + '  AND ROUND((SALDOS - ESTMAX), 2) > 0 ';
      1: strSQL := strSQL + '  AND ROUND((SALDOS - ESTMAX), 2) = 0 ';
    End;


    strSQL := strSQL + 'ORDER BY ';

    If edtOpcao.Text = 'L' Then
    Begin
      strSQL := strSQL + '  I.ITE_CODGRU, ';
    End
    Else
    If edtOpcao.Text = 'M' Then
    Begin
      strSQL := strSQL + ' MAR_DESMAR, ';
    End;

    strSQL := strSQL + '  I.ITE_DESITE ';


    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      pSetarParametros(qryRelatorio);

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin

      If edtDestino.Text = 'E' Then
      Begin
        If fCfgSis('RACEXT', varBoolean) Then
          pGeraExcelHTML
        Else
          pGeraExcel;
      End
      Else
      Begin
        blnDistribuirExcedente := chkGerOrc.Checked And fEmptyStr(edtCodEmpresaAbastecer.Text);

        If blnDistribuirExcedente  Then
        Begin
          qryEmpresasDestino.qryQuery.SQL.Add('');

          qryEmpresasDestino.qryQuery.SQL.Add('SELECT CONCAT(G.ITE_CODEMP , "-", I.ITE_DESITE) AS EMPRESA, ');
          qryEmpresasDestino.qryQuery.SQL.Add('       G.ITE_CODEMP, G.ITE_CODITE AS CODITE, I.ITE_DESITE AS DESITE,G.ITE_SALDOS, G.ITE_ESTMAX, 0 AS ITE_SALTRA, 0 AS ITE_SALUSO ');

          qryEmpresasDestino.qryQuery.SQL.Add(fTabelasComFiltros(True));

          pSetarParametros(qryEmpresasDestino.qryQuery);

          qryEmpresasDestino.fAbreClient(True, '[TfrmRelEstItemsAcimaMax.btnImprimirClick]');
        End

        Else
        Begin


          Try
            frxRelatorio.DataSet := qryRelatorio;
            frxReport := frxReportJ;

            frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
            frxReport.Script.Variables['NOMREL'] := 'RELATORIO DE PRODUTOS COM SALDO ACIMA DO MAXIMO';

            {*********************}
            {* HEADER FORNECEDOR *}
            {******************JZ*}
            If Not fEmptyStr(edtFornecedor.Text) Then
              frxReport.Script.Variables['FORNECEDOR'] := 'FORNECEDOR: ' + edtFornecedor.Text + ' - ' + edtDesFornecedor.Text
            Else
              frxReport.Script.Variables['FORNECEDOR'] := 'FORNECEDOR: TODOS';

            {******************}
            {* HEADER GRUPO 1 *}
            {***************JZ*}
            If Not fEmptyStr(mskLinhaGrupo2.Text) Then
              frxReport.Script.Variables['LINHAGRUPO_INICIAL'] := 'LINHA/GRUPO INICIAL: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text
            Else
              frxReport.Script.Variables['LINHAGRUPO_INICIAL'] := 'LINHA/GRUPO INICIAL: TODOS';

            {******************}
            {* HEADER GRUPO 2 *}
            {***************JZ*}
            If Not fEmptyStr(mskLinhaGrupo2.Text) Then
              frxReport.Script.Variables['LINHAGRUPO_FINAL'] := 'LINHA/GRUPO FINAL: ' + mskLinhaGrupo2.Text + ' - ' + edtDesGrupo2.Text
            Else
              frxReport.Script.Variables['LINHAGRUPO_FINAL'] := 'LINHA/GRUPO FINAL: TODOS';

            {****************}
            {* HEADER MARCA *}
            {*************JZ*}
            If Not fEmptyStr(edtMarca.Text) Then
              frxReport.Script.Variables['MARCA'] := 'MARCA: ' + edtMarca.Text + ' - ' + edtDesMarca.Text
            Else
              frxReport.Script.Variables['MARCA'] := 'MARCA: TODAS';

            {******************}
            {* HEADER UNIDADE *}
            {***************JZ*}
            If Not fEmptyStr(edtUnidade.Text) Then
              frxReport.Script.Variables['UNIDADE'] := 'UNIDADE: ' + edtUnidade.Text
            Else
              frxReport.Script.Variables['UNIDADE'] := 'UNIDADE: TODAS';

            {*****************}
            {* HEADER DESCRI *}
            {**************JZ*}
            If Not fEmptyStr(edtDescri.Text) Then
              frxReport.Script.Variables['DESCRICAO'] := 'DESCRICAO: ' + edtDescri.Text
            Else
              frxReport.Script.Variables['DESCRICAO'] := 'DESCRICAO: TODAS';

            {*********************}
            {* HEADER REFERENCIA *}
            {******************JZ*}
            If Not fEmptyStr(edtRefere.Text) Then
              frxReport.Script.Variables['REFERENCIA'] := 'REFERENCIA: ' + edtRefere.Text
            Else
              frxReport.Script.Variables['REFERENCIA'] := 'REFERENCIA: TODAS';

            {***************************}
            {* HEADER GRUPO DE COMPRAS *}
            {15/08/2012**************JZ*}
            frxReport.Script.Variables['GRUPO_COMPRAS'] := fStrTitulo(edtGruCmp.Text, edtDesGruCmp, arrGruCmp, strGruCmp, 'GRUPO DE COMPRAS');

            {*********************}
            {* HEADER PREÇOS     *}
            {******************JZ*}
            if edtExiPre.Text = 'N' Then
              frxReport.Script.Variables['PRECOS'] := 'PREÇOS: NÃO EXIBIR '
            Else
              frxReport.Script.Variables['PRECOS'] := 'PREÇOS: ' + cmbTipPre.Text;

            if edtExiPre.Text = 'N' Then
              frxReport.Script.Variables['EXIBIR_PRECOS'] := 'N'
            Else
              frxReport.Script.Variables['EXIBIR_PRECOS'] := 'S';

            {*********************}
            {* HEADER EMPRESA    *}
            {******************JZ*}
            frxReport.Script.Variables['EMPRESA'] := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrLinEmp, strLinEmp, 'EMPRESA');
            frxReport.Script.Variables['EMPRESA_ABASTECEDORA'] := '';

            {********************************}
            {* HEADER EMPRESA ABASTECEDORA  *}
            {*****************************JZ*}
            If chkGerOrc.Checked Then
            Begin
              frxReport.Script.Variables['EMPRESA'] := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrLinEmp, strLinEmp, 'EMPRESA ABASTECEDORA');
              frxReport.Script.Variables['EMPRESA_ABASTECEDORA'] := fStrTitulo(edtCodEmpresaAbastecer.Text, edtDesEmpresaAbastecer, arrLinEmpAbs, strLinEmpAbs, 'EMPRESA ABASTECIDA');

              frxReport.Script.Variables['EMPRESA_CODIGO'] := edtCodEmpresa.Text;
              frxReport.Script.Variables['ABASTECEDORA_CODIGO'] := edtCodEmpresaAbastecer.Text;
            End;

            frxReport.Script.Variables['IMPRIMIR_REFERENCIA'] := IIF(chkImpRef.Checked, 'S', 'N');
            frxReport.Script.Variables['OPCAO'] := edtOpcao.Text;

            If frxReport.FindObject('mmoZebra') <> Nil Then
             TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clSilver);

            pPreviewReport(Self.Name, Self.Caption, frxReport);

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
            End;
          End;
          // pFreeAndNil(frxReport);
        End;
      End;

      {*************************}
      {* GERANDO OS ORÇAMENTOS *}
      {**********************RV*}
      If chkGerOrc.Checked Then
      Begin
        objGeraOr.tpTipoMultiplo := tpmlIndefinido;
        objGeraOR.strEmpCd_ext := edtCodEmpresa.Text;
        objGeraOR.pGeraOrcamento('', edtCodEmpresaAbastecer, arrLinEmpAbs, False, opcAcimaMax, nil, QryEmpresasDestino);
      End;

    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;

  mskLinhaGrupo2.Clear;
  edtDesGrupo2.Text := '';

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';

  FreeAndNil(qryEmpresasDestino);

end;

procedure TfrmRelEstItemsAcimaMax.edtUnidadeExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(fRetNomUnidade(edtUnidade.Text)) And (Not fEmptyStr(edtUnidade.Text))  Then
  Begin
    fMensagem('AVISO','Código da Unidade não encontrado.', ['&O K']);
    edtUnidade.Clear;
    pSetFocus(edtUnidade);
  End;

end;

procedure TfrmRelEstItemsAcimaMax.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, arrSel) Then
  Begin
    fValidaCampos(edtUnidade, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelEstItemsAcimaMax.fGetSqlItens(strCodEmp: String): String;
  Var
    strUnitar,
    strSQL: String;
Begin
  strUnitar := TRelGeraOR.fSQLUnitario(VS_StrCodEmp, strCodEmp);

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  I.AUTOINCREM,  ';
  strSQL := strSQL + '  "D" AS MARDES,  ';
  strSQL := strSQL + '  LEFT(I.ITE_CODGRU,3) AS LINHA, ';
  strSQL := strSQL + '  I.ITE_CODGRU AS GRUPO,         ';
  strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
  strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  I.ITE_CODUNI AS UNIDAD, ';
  strSQL := strSQL + '  U.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
  strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  " "          AS COMPRA, ';
  strSQL := strSQL + '  SUM(' + fRetSaldo('G', 'I') + ') AS SALDOS, ';
  strSQL := strSQL + '  SUM(G.ITE_ESTMAX) AS ESTMAX, ';
  strSQL := strSQL + '  SUM(G.ITE_SALDOS - G.ITE_ESTMAX) AS NECCOM, ';
  strSQL := strSQL + '  CONCAT(F.FOR_NOMFOR, "-", M.MAR_DESMAR, "-", I.ITE_REFERE) AS FORMAR, ';
  strSQL := strSQL + '  SUM(G.ITE_SALDOS - G.ITE_ESTMAX) AS SALUSO, ';
  strSQL := strSQL + '  (SELECT SUM(' + fRetSaldo('X', 'Y') + ') FROM ITEGER X JOIN CADITE Y ON X.ITE_CODITE = Y.ITE_CODITE WHERE '+fRetWhereSaldoEmpAbastecida+') AS SALDOSABS, ';
  strSQL := strSQL + '  (SELECT SUM(X.ITE_ESTMAX) FROM ITEGER X WHERE '+fRetWhereSaldoEmpAbastecida+') AS ESTMAXABS, ';

  strSQL := strSQL + '  CD.' + strUnitar + ' AS UNITAR, ';
  strSQL := strSQL + '  CD.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '  CD.ITE_PREMED AS PREMED, ';
  strSQL := strSQL + '  CD.ITE_ICMSAI AS ICMSAI, ';
  strSQL := strSQL + '  CD.ITE_IPISAI AS IPISAI, ';
  strSQL := strSQL + '  CD.ITE_SUBSTI AS SUBSTI, ';

  strSQL := strSQL + '  CAST("" AS CHAR(30)) AS NUMLOT, ';
  strSQL := strSQL + '  G.ITE_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  0.000 AS PESTOT, ';
  strSQL := strSQL + '  0.00  AS NECTOT, ';

  strSQL := strSQL + '  IF(IFNULL((SELECT COUNT(*)                                   ';
  strSQL := strSQL + '    FROM CADLOT                                                 ';
  strSQL := strSQL + '    WHERE     LOT_CODITE = G.ITE_CODITE                         ';
  strSQL := strSQL + '          AND LOT_CODEMP = G.ITE_CODEMP                         ';
  strSQL := strSQL + '          ), 0) > 0, "S", "N") AS TEMLOT,                       ';

  strSQL := strSQL + '  I.ITE_PESOIT AS PESOIT, ';
  strSQL := strSQL + '  I.ITE_INCPIS AS INCPIS  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';

  strSQL := strSQL + '  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';

  strSQL := strSQL + '  JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';

  strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';

  strSQL := strSQL + '  INNER JOIN ITEGER CD ON CD.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '                      AND CD.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  strSQL := strSQL + '  LEFT JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + 'TRUE  ';

  if FCFGTRITTE then
    strSQL := strSQL + ' AND IFNULL(I.ITE_TRITTE, "N") = "S" ';

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin

    If RightStr(mskLinhaGrupo.Text,3) = '000' Then
    Begin

      If Not fEmptyStr(mskLinhaGrupo2.Text) Then
      Begin

        If RightStr(mskLinhaGrupo2.Text,3) = '000' Then
          strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU,3) BETWEEN LEFT(:CODGRU,3) AND LEFT(:CODGRU2,3) '
        Else
          strSQL := strSQL + '  AND I.ITE_CODGRU BETWEEN CONCAT(LEFT(:CODGRU,3),"000") AND :CODGRU2 ';

      End
      Else
      Begin
        strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:CODGRU,3) ';
      End;

    End
    Else
    Begin

      If Not fEmptyStr(mskLinhaGrupo2.Text) Then
      Begin

        If RightStr(mskLinhaGrupo2.Text,3) = '000' Then
          strSQL := strSQL + '  AND I.ITE_CODGRU BETWEEN :CODGRU AND CONCAT(LEFT(:CODGRU2,3),"099") '
        Else
          strSQL := strSQL + '  AND I.ITE_CODGRU BETWEEN :CODGRU AND :CODGRU2 ';

      End
      Else
      Begin
        strSQL := strSQL + '  AND I.ITE_CODGRU = :CODGRU ';
      End;

    End;

  End;

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + ' AND G.ITE_CODEMP = ' + QuotedStr(strCodEmp);

  strSQL := strSQL + fStrLocate(edtFornecedor, arrLinFor, 'I.ITE_CODFOR', 'CODFOR');
  strSQL := strSQL + fStrLocate(edtMarca, arrLinMar, 'I.ITE_CODMAR', 'CODMAR');
  strSQL := strSQL + fStrLocate(edtCodDep, arrCodDep, 'I.ITE_CODDEP', 'CODDEP');
  strSQL := strSQL + fStrLocate(edtUnidade, arrLinUni, 'I.ITE_CODUNI', 'CODUNI');
  strSQL := strSQL + fStrLocate(edtSitPro, arrSitPro, 'I.ITE_SITPRO', 'SITPRO');

  If Not fEmptyStr(edtDescri.Text) Then
  Begin
    strSQL := strSQL + '  AND I.ITE_DESITE LIKE :DESITE ';
  End;

  If Not fEmptyStr(edtRefere.Text) Then
  Begin
    strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';
  End;

  If rdgStatus.ItemIndex = 0 Then
    strSQL := strSQL + ' AND I.ITE_ITEATI = ' + QuotedStr('S') + ' '
  Else If rdgStatus.ItemIndex = 1 Then
    strSQL := strSQL + ' AND I.ITE_ITEATI = ' + QuotedStr('N') + ' ';

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  G.ITE_CODITE ';

  strSQL := strSQL + 'HAVING ';

  strSQL := strSQL + ' (SALDOS + ESTMAX) > 0 AND ';
  strSQL := strSQL + ' (SALDOS >= ESTMAX) ';

  Case rdgSaldo.ItemIndex Of
    0: strSQL := strSQL + '  AND ROUND((SALDOS - ESTMAX), 2) > 0 ';
    1: strSQL := strSQL + '  AND ROUND((SALDOS - ESTMAX), 2) = 0 ';
  End;

  strSQL := strSQL + 'ORDER BY ';

  If edtOpcao.Text = 'L' Then
  Begin
    strSQL := strSQL + '  I.ITE_CODGRU, ';
  End;

  strSQL := strSQL + '  I.ITE_DESITE ';

  Result := strSQL;
end;

procedure TfrmRelEstItemsAcimaMax.chkGerOrcClick(Sender: TObject);
begin
  inherited;

  If chkGerOrc.Checked Then
  Begin
    lblEmpresa.Caption := 'Empresa abastecedora';
    lblEmpresaAbastecer.Visible := True;
    edtCodEmpresaAbastecer.Visible := True;
    edtDesEmpresaAbastecer.Visible := True;
    edtDesEmpresa.Width := edtDesEmpresaAbastecer.Width;

    If (Not fEmptyStr(edtCodEmpresa.Text)) And (edtCodEmpresa.Text <> Vs_strCodEmp) Then
      fMensagem('ATENÇÃO','A empresa abastecedora poderá ser somente a empresa logada!',['&OK']);

    edtCodEmpresa.Text := Vs_strCodEmp;
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);
    edtCodEmpresa.Enabled := False;

    pSetFocus(edtCodEmpresaAbastecer);
  End
  Else
  Begin
    pCampoEmpresaDefault;
  End;
end;

procedure TfrmRelEstItemsAcimaMax.chkGerOrcExit(Sender: TObject);
begin
  inherited;

  If Not chkGerOrc.Checked And edtCodEmpresaAbastecer.Visible then
  Begin
    pCampoEmpresaDefault;
  End;
end;

procedure TfrmRelEstItemsAcimaMax.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesCodDep, arrCodDep, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmRelEstItemsAcimaMax.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesCodDep, nil, key, arrCodDep, False) Then
  Begin
    if fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstItemsAcimaMax.edtCodEmpresaAbastecerExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresaAbastecer, edtDesEmpresaAbastecer, arrLinEmpAbs, Nil, fRetNomeEmpresaSelec, 'da Empresa');

  If (chkGerOrc.Checked) And (Not fEmptyStr(edtCodEmpresaAbastecer.Text)) Then
    chkGerOrc.Checked := TfrmMsgValidacaoGeraOrdOp.fMsgValidacaoGeracaoOrcPed(veValidaSomenteEmp, edtCodEmpresaAbastecer.Text, fEmpSelecionadaIgualEmpLogada);
end;

procedure TfrmRelEstItemsAcimaMax.edtCodEmpresaAbastecerKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresaAbastecer, edtDesEmpresaAbastecer, Nil, Key, arrLinEmpAbs, True, True) Then
  Begin
    If fValidaCampos(edtCodEmpresaAbastecer, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAcimaMax.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrLinEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmRelEstItemsAcimaMax.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrLinEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAcimaMax.FormShow(Sender: TObject);
begin
  inherited;

  pCriaQryRelatorio;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresaExit(Sender);

  chkGerOrc.Checked  := False;
  If fCfgSis('ORTEMX', varBoolean) Then
    chkGerOrc.Visible := True;

  shpMultSel.Visible := True;

  objGeraOR := TRelGeraOR.Create(Self, fGravaFatGor, fGravaFatDor, pAbreQueryItens);
end;

procedure TfrmRelEstItemsAcimaMax.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskLinhaGrupo);
end;

procedure TfrmRelEstItemsAcimaMax.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objGeraOR);

end;

procedure TfrmRelEstItemsAcimaMax.FormCreate(Sender: TObject);
begin
  inherited;
  fGravaFatGor := Nil;
  fGravaFatDor := Nil;

  if fVerificaAcessoSistema('SAMPRE') Then
  Begin
    edtExiPre.Enabled := True;
    edtExiPre.TabStop := True;
    cmbTipPre.ItemIndex := 0;
    shpPreco.Brush.Color := clGreen;

  End;
  FCFGTRITTE:= fCfgSis('TRITTE', varBoolean);
end;

procedure TfrmRelEstItemsAcimaMax.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstItemsAcimaMax.pGeraExcelHTML;
var objGeraExcel: TGeraArquivo;
    FontFieldValues,
    FontFieldTitle: TFont;

begin
  objGeraExcel := TGeraArquivo.create(taHtml, qryRelatorio, nil);
  Try
    objGeraExcel.blnShowFrmGravando := true;

    objGeraExcel.protegeEstrutura := false;
    objGeraExcel.DesbloquerTodasAsColunas  := True;

    objGeraExcel.pAddTitulo(fRetNomeEmpresa, TGeraArquivo.fSetFont());
    objGeraExcel.pAddTitulo('RELATÓRIO DE PRODUTOS COM SALDO ACIMA DO MÁXIMO', TGeraArquivo.fSetFont());
    objGeraExcel.pAddTitulo('LINHA/GRUPO INICIAL: ' + IIF(fEmptyStr(mskLinhaGrupo.Text), 'TODOS', mskLinhaGrupo.Text + '-' + edtDesGrupo.Text), TGeraArquivo.fSetFont());
    objGeraExcel.pAddTitulo('LINHA/GRUPO FINAL: ' + IIF(fEmptyStr(mskLinhaGrupo2.Text), 'TODOS', mskLinhaGrupo2.Text + '-' + edtDesGrupo2.Text), TGeraArquivo.fSetFont());
    objGeraExcel.pAddTitulo('FORNECEDOR: ' + IIF(fEmptyStr(edtFornecedor.Text), 'TODOS', edtFornecedor.Text + '-' + edtDesFornecedor.Text), TGeraArquivo.fSetFont());
    objGeraExcel.pAddTitulo('MARCA: ' + IIF(fEmptyStr(edtMarca.Text), 'TODAS', edtMarca.Text + '-' + edtDesMarca.Text), TGeraArquivo.fSetFont());

    objGeraExcel.pAddTitulo(fStrTitulo(edtGruCmp.Text, edtDesGruCmp, arrGruCmp, strGruCmp, 'GRUPO DE COMPRAS'), TGeraArquivo.fSetFont());

    objGeraExcel.pAddTitulo('UNIDADE: ' + IIF(fEmptyStr(edtUnidade.Text), 'TODAS', edtUnidade.Text), TGeraArquivo.fSetFont());
    objGeraExcel.pAddTitulo('EMPRESA: ' + IIF(fEmptyStr(edtCodEmpresa.Text), 'TODAS', edtCodEmpresa.Text + '-' + edtDesEmpresa.Text), TGeraArquivo.fSetFont());
    objGeraExcel.pAddTitulo('SITUAÇÂO DO PRODUTO: ' + IIF(fEmptyStr(edtSitPro.Text), 'TODAS', edtSitPro.Text + '-' + edtDesPro.Text), TGeraArquivo.fSetFont());

    if edtExiPre.Text = 'N' Then
      objGeraExcel.pAddTitulo('PREÇOS: NÃO EXIBIR', TGeraArquivo.fSetFont())
    Else
      objGeraExcel.pAddTitulo('PREÇOS: ' + cmbTipPre.Text, TGeraArquivo.fSetFont());

    objGeraExcel.pAddTitulo('OPÇÃO: ' + IIF(edtOpcao.Text = 'L', 'LINHA/GRUPO', 'ALFABÉTICA'), TGeraArquivo.fSetFont());

    If chkGerOrc.Checked Then
    Begin
      objGeraExcel.pAddTitulo(fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrLinEmp, strLinEmp, 'EMPRESA ABASTECEDORA'), TGeraArquivo.fSetFont());
      objGeraExcel.pAddTitulo(fStrTitulo(edtCodEmpresaAbastecer.Text, edtDesEmpresaAbastecer, arrLinEmpAbs, strLinEmpAbs, 'EMPRESA ABASTECIDA'), TGeraArquivo.fSetFont());
    End;


    FontFieldValues:= TGeraArquivo.fSetFont(10, [], clBlack);
    FontFieldTitle := TGeraArquivo.fSetFont(10, [], clWhite);


    objGeraExcel.AddCampo('CODITE', 'CÓDIGO', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
    If edtOpcao.Text = 'L' Then
    Begin
      objGeraExcel.AddCampo('LINHA' , 'LINHA', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False, -9999999, -9999999, '', True, onTrataValorQuebra, True);
      objGeraExcel.AddCampo('GRUPO' , 'GRUPO', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False, -9999999, -9999999, '', True, onTrataValorQuebra, True);
    End;
    objGeraExcel.AddCampo('DESITE', 'DESCRIÇÃO', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
    objGeraExcel.AddCampo('UNIDAD', 'UNID.', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
    If chkImpRef.Checked Then
      objGeraExcel.AddCampo('REFERE', 'REFERÊNCIA', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
    If edtOpcao.Text <> 'M' Then
      objGeraExcel.AddCampo('DESMAR', 'MARCA', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False)
    Else
      objGeraExcel.AddCampo('DESMAR', 'MARCA', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False, -9999999, -9999999, '', True, onTrataValorQuebra, True);
    objGeraExcel.AddCampo('ESTMAX', 'EST.MAX.'+fTitEmpresa(edtCodEmpresa.Text), FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
    objGeraExcel.AddCampo('SALDOS', 'SALDO'+fTitEmpresa(edtCodEmpresa.Text), FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
    objGeraExcel.AddCampo('SALMAX', 'SAL.MAX.'+fTitEmpresa(edtCodEmpresa.Text), FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);

    If chkGerOrc.Checked Then
    Begin
      objGeraExcel.AddCampo('ESTMAXABS', 'EST.MAX.'+fTitEmpresa(edtCodEmpresaAbastecer.Text), FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
      objGeraExcel.AddCampo('SALDOSABS', 'SALDO'+fTitEmpresa(edtCodEmpresaAbastecer.Text), FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
      objGeraExcel.AddCampo('SALMAXABS', 'SAL.MAX.'+fTitEmpresa(edtCodEmpresaAbastecer.Text), FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
    End
    Else
    Begin
      If edtExiPre.Text = 'N' Then
        objGeraExcel.AddCampo('COMPRA', 'COMPRAS'+fTitEmpresa(edtCodEmpresaAbastecer.Text), FontFieldTitle, FontFieldValues, '', tahtmlUndef, False)
      Else
      Begin
        objGeraExcel.AddCampo('VALUNI', 'VALOR', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objGeraExcel.AddCampo('VALTOT', 'TOTAL', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
      End;
    End;

    If objGeraExcel.fGerarRelatorio(True) Then
      pMensagemOk('Arquivo gerado com sucesso!');


  Finally
    FreeAndNil(objGeraExcel);
  End;

end;


procedure TfrmRelEstItemsAcimaMax.pGeraExcel;
  var
    arrSintetico: Array Of Array [1..2] Of String;

    intCont: Integer;
    intQtdCol : Integer;
    intQtdFil : Integer;
    strUltCol : String;
    strLinAnt : String;
    strGruAnt : String;
    strGruMsk : String;
    objExcel  : TExcel;

    procedure pAddCampo(strTitul, strCampo: String);
    begin
      SetLength(arrSintetico, Length(arrSintetico)+1);
      arrSintetico[Length(arrSintetico)-1][01] := strTitul;
      arrSintetico[Length(arrSintetico)-1][02] := strCampo;
    end;

begin

  pAddCampo('GRUPO',      'GRUPO');
  pAddCampo('CÓDIGO',     'CODITE');
  pAddCampo('DESCRIÇÃO',  'DESITE');
  pAddCampo('UNID.',      'UNIDAD');
  If chkImpRef.Checked Then
   pAddCampo('REFERÊNCIA','REFERE');
  If edtOpcao.Text <> 'M' Then
   pAddCampo('MARCA',      'DESMAR');
  pAddCampo('EST.MAX.'+fTitEmpresa(edtCodEmpresa.Text),'ESTMAX');
  pAddCampo('SALDO'+fTitEmpresa(edtCodEmpresa.Text),   'SALDOS');
  pAddCampo('SAL.MAX.'+fTitEmpresa(edtCodEmpresa.Text),'SALMAX');

  If chkGerOrc.Checked Then
  Begin
    pAddCampo('EST.MAX.'+fTitEmpresa(edtCodEmpresaAbastecer.Text),'ESTMAXABS');
    pAddCampo('SALDO'+fTitEmpresa(edtCodEmpresaAbastecer.Text),   'SALDOSABS');
    pAddCampo('SAL.MAX.'+fTitEmpresa(edtCodEmpresaAbastecer.Text),'SALMAXABS');
  End
  Else
  Begin
    If edtExiPre.Text = 'N' Then
    Begin
      pAddCampo('COMPRAS'+fTitEmpresa(edtCodEmpresaAbastecer.Text),'COMPRA')
    End
    Else
    Begin
      pAddCampo('VALOR','VALUNI');
      pAddCampo('TOTAL','VALTOT');
    End;
  End;

  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin

    PintarTudo(Branco);
    DefinirFonte(CourierNew, 10);

    LinhaAtual := 1;
    intQtdCol  := Length(arrSintetico) - 1; // a Posição 0 sempre sera vazia.
    strUltCol  := fGetLetraAlfa(intQtdCol);

    pnlInfo.Caption := 'Aguarde... Gerando Arquivo!';

    intQtdFil := IIF(chkGerOrc.Checked, 14, 12);

    For intCont := 1 To intQtdFil Do // Quantidade de Filtros. Fazendo o Merge antes porque no LibreOffice Da erro Mesclar com Valor. UntGeraExcel já corridido.
    Begin
      Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
      Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
      Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
    End;

    Escrever(ProximaLinha,01, fRetNomeEmpresa);
    Escrever(ProximaLinha,01, 'RELATÓRIO DE PRODUTOS COM SALDO ACIMA DO MÁXIMO');
    Escrever(ProximaLinha,01, 'LINHA/GRUPO INICIAL: ' + IIF(fEmptyStr(mskLinhaGrupo.Text), 'TODOS', mskLinhaGrupo.Text + '-' + edtDesGrupo.Text));
    Escrever(ProximaLinha,01, 'LINHA/GRUPO FINAL: ' + IIF(fEmptyStr(mskLinhaGrupo2.Text), 'TODOS', mskLinhaGrupo2.Text + '-' + edtDesGrupo2.Text));
    Escrever(ProximaLinha,01, 'FORNECEDOR: ' + IIF(fEmptyStr(edtFornecedor.Text), 'TODOS', edtFornecedor.Text + '-' + edtDesFornecedor.Text));
    Escrever(ProximaLinha,01, 'MARCA: ' + IIF(fEmptyStr(edtMarca.Text), 'TODAS', edtMarca.Text + '-' + edtDesMarca.Text));

    {***************************}
    {* HEADER GRUPO DE COMPRAS *}
    {15/08/2012**************CI*}
    Escrever(ProximaLinha,01, fStrTitulo(edtGruCmp.Text, edtDesGruCmp, arrGruCmp, strGruCmp, 'GRUPO DE COMPRAS'));

    Escrever(ProximaLinha,01, 'UNIDADE: ' + IIF(fEmptyStr(edtUnidade.Text), 'TODAS', edtUnidade.Text));
    Escrever(ProximaLinha,01, 'EMPRESA: ' + IIF(fEmptyStr(edtCodEmpresa.Text), 'TODAS', edtCodEmpresa.Text + '-' + edtDesEmpresa.Text));

    if edtExiPre.Text = 'N' Then
      Escrever(ProximaLinha,01, 'PREÇOS: NÃO EXIBIR')
    Else
      Escrever(ProximaLinha,01, 'PREÇOS: ' + cmbTipPre.Text);

    Escrever(ProximaLinha,01, 'OPÇÃO: ' + IIF(edtOpcao.Text = 'L', 'LINHA/GRUPO', 'ALFABÉTICA'));

    If chkGerOrc.Checked Then
    Begin
     Escrever(ProximaLinha,01, fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrLinEmp, strLinEmp, 'EMPRESA ABASTECEDORA'));
     Escrever(ProximaLinha,01, fStrTitulo(edtCodEmpresaAbastecer.Text, edtDesEmpresaAbastecer, arrLinEmpAbs, strLinEmpAbs, 'EMPRESA ABASTECIDA'));
    End;

    With qryRelatorio Do
    Begin

      CorFundo('A2', strUltCol + '3', Cinza);
      Bordas('A2', strUltCol + '3',True,True,True,True);

      ProximaLinha;

      For intCont := 1 To intQtdCol Do
      Begin
        Escrever(LinhaAtual, intCont, arrSintetico[intCont, 01]);
        Negrito(LinhaAtual, intCont, True);

        If FieldByName(arrSintetico[intCont, 02]).DataType = ftFloat Then
          Alinhamento(LinhaAtual,intCont, Direita)
        Else
          Alinhamento(LinhaAtual,intCont, Esquerda);

      End;

      CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
      CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      First;

      If edtOpcao.Text = 'L' Then
      Begin

        While Not Eof Do
        Begin

          strLinAnt := FieldByName('LINHA').AsString;

          Escrever(ProximaLinha, 01, strLinAnt + '.000 - ' + fRetNomeLinhaGrupo(strLinAnt + '000'));
          Negrito(LinhaAtual, 01, True);

          Mesclar('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
          CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
          Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

          While (Not Eof) And (FieldByName('LINHA').AsString = strLinAnt) Do
          Begin

            strGruAnt := FieldByName('GRUPO').AsString;
            strGruMsk := LeftStr(FieldByName('GRUPO').AsString,2) + '.' + RightStr(FieldByName('GRUPO').AsString,2);

            Escrever(ProximaLinha, 01, '   ' + strGruMsk + ' - ' + fRetNomeLinhaGrupo(strGruAnt));
            Negrito(LinhaAtual, 01, True);

            Mesclar('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
            CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
            CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
            Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

            While (Not Eof) And (FieldByName('GRUPO').AsString = strGruAnt) Do
            Begin

              ProximaLinha;

              For intCont := 1 To intQtdCol Do
              Begin

                If FieldByName(arrSintetico[intCont, 02]).DataType = ftFloat Then
                Begin
                  Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrSintetico[intCont, 02]).AsFloat));
                  Alinhamento(LinhaAtual, intCont, Direita);
                End
                Else
                Begin
                  Escrever(LinhaAtual, intCont, '''' + FieldByName(arrSintetico[intCont, 02]).AsString);
                  Alinhamento(LinhaAtual, intCont, Esquerda);
                End;

              End;

              Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              If LinhaAtual Mod 2 = 0 Then
                CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);

              Next;
            End;

          End;

        End;

      End
      Else
      Begin

        strLinAnt := '';
        While Not Eof Do
        Begin

          If (edtOpcao.Text = 'M') And (strLinAnt <> FieldByName('DESMAR').AsString) Then
          Begin

            Escrever(ProximaLinha, 01, 'MARCA: ' + FieldByName('DESMAR').AsString);
            Negrito(LinhaAtual, 01, True);

            Mesclar('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
            CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
            CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
            Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

          End;

          ProximaLinha;

          For intCont := 1 To intQtdCol Do
          Begin

            If FieldByName(arrSintetico[intCont, 02]).DataType = ftFloat Then
            Begin
              Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrSintetico[intCont, 02]).AsFloat));
              Alinhamento(LinhaAtual, intCont, Direita);
            End
            Else
            Begin
              Escrever(LinhaAtual, intCont, '''' + FieldByName(arrSintetico[intCont, 02]).AsString);
              Alinhamento(LinhaAtual, intCont, Esquerda);
            End;

          End;

          Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          If LinhaAtual Mod 2 = 0 Then
            CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);

          strLinAnt := FieldByName('DESMAR').AsString;

          Next;
        End;

      End;

      OrientacaoPagina(Retrato);

      CongelarPaines('A'+IntToStr(intQtdFil+2));

      AutoAjuste;
      SalvarArquivo;
      FecharArquivo;

      pnlInfo.Caption := '';

      fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);
    End;
  End;

  FreeAndNil(objExcel);

end;

procedure TfrmRelEstItemsAcimaMax.edtDestinoExit(Sender: TObject);
begin
//  inherited;
end;

end.


