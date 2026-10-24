unit untRelEstSemMov;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, DB,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, windows, untTypesSistema,
  AppEvnts, ComCtrls, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  untClassPanelCx, untIFuncoes, untExcel, untGeraExcel;

type
  TfrmRelEstSemMov = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label12: TLabel;
    edtFornecedor: TEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    Label10: TLabel;
    edtProdutos: TEditFocus;
    edtMarca: TEditFocus;
    Label11: TLabel;
    edtDesFornecedor: TEditFocus;
    edtDesGrupo: TEditFocus;
    edtDesProduto: TEditFocus;
    edtDesMarca: TEditFocus;
    gpbItens: TGroupBox;
    ColorLabel2: TColorLabel;
    edtIteAti: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbOpcao: TGroupBox;
    lbl1: TColorLabel;
    edtOpcao: TEditFocus;
    pbProgresso: TProgressBar;
    chkSalZer: TCheckBox;
    chkImpRef: TCheckBox;
    chkAjusteEstoque: TCheckBox;
    chkTransfEstoque: TCheckBox;
    Label1: TLabel;
    mskCadIni: TMaskEditFocus;
    mskCadFin: TMaskEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtCodGruCmp: TEditFocus;
    Label18: TLabel;
    edtDesGruCmp: TEditFocus;
    lblDepartamento: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    chkCFOPVen: TCheckBox;
    chkIteNMov: TCheckBox;
    GroupBox1: TGroupBox;
    ColorLabel3: TColorLabel;
    edtImprimeLista: TEditFocus;
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodGruCmpExit(Sender: TObject);
    procedure edtCodGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoEnter(Sender: TObject);

  private
    { Private declarations }
    qryUltCom: TUniQuery;
    qryUltVen: TUniQuery;
    qryRelatorio: TUniQuery;

    strProduto,
    strMarca,
    strEmp,
    strLinhaGrupo,
    strFornecedor,
    strGruCmp,
    strDepart: String;

    arrProduto,
    arrMarca,
    arrEmp,
    arrLinhaGrupo,
    arrFornecedor,
    arrGrupoCompra,
    arrDepart      :TConsultasArray;

    Function fSQLUltimaCompra: String;
    Function fSQLUltimaVenda : String;

    Function fRetUltimaCompra(dtsDados: TDataSet): String;
    Function fRetUltimaVenda(dtsDados: TDataSet): String;
    Function fRetDiasNaoVende(dtsDados: TDataSet): String;

    Procedure pUltimaCompra(dataSet: TDataSet);
    Procedure pUltimaVenda(dataSet: TDataSet);
    procedure pCriaQryRelatorio;
    Procedure pAfterSroll(dataSet: TDataSet);

    procedure pGeraExcelNovo(DataSet : TDataSet);

    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    function fMovDet: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }

  end;

var
  frmRelEstSemMov: TfrmRelEstSemMov;

implementation

uses untfuncoesFactory, untQckEstSemMov, untPai, untConstantes;

{$R *.dfm}

procedure TfrmRelEstSemMov.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelEstSemMov.edtFornecedorKeyPress(Sender: TObject;
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

procedure TfrmRelEstSemMov.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
  edtProdutos.Clear;
  edtDesProduto.Text := '';
  pDesmarcaLista(edtProdutos,arrProduto);
end;

procedure TfrmRelEstSemMov.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelEstSemMov.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstSemMov.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte: TUniQuery;
begin
  inherited;

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    Key := #0;
    Exit;
  End;

  qryGenIte := fCriaQuery(nil);

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrProduto, False, nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(edtProdutos, True) Then
      SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryGenIte);
end;

procedure TfrmRelEstSemMov.edtProdutosExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtProdutos,edtDesProduto,arrProduto,nil,fRetNomProduto,'do Produto');
end;

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmRelEstSemMov.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intIndex: Integer;
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
    Else If (Sender = edtImprimeLista) Then
    Begin
       If Not (pos(edtImprimeLista.Text, 'SNT') > 0) Then
       Begin
         fMensagem('','O valor para o campo Imprime Lista Individual deve ser "S", "N" ou "T".',['&O K']);
         Result := False
       End;
    End
    {****************************}
    {* VALIDA DATAS DE CADASTRO *}
    {*************************LU*}
    Else If (Sender = mskCadFin) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) And
         (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) Then
      Begin
        If StrToDate(mskCadIni.Text) > StrToDate(mskCadFin.Text) Then
        Begin
          fMensagem('','A data inicial (cadastro de produto) deve ser menor que a data final!',['&O K']);
          Result := False;
        End;
      End;

    End
    Else If (Sender = mskLinhaGrupo) Then
    Begin
      if (fEmptyStr(mskLinhaGrupo.Text)) then
        pDesmarcaLista(mskLinhaGrupo,arrLinhaGrupo,'',6);
    End
    Else If (Sender = edtFornecedor) Then
    Begin
      if (fEmptyStr(edtFornecedor.Text)) then
        pDesmarcaLista(edtFornecedor,arrFornecedor);
    End
    Else If (Sender = edtProdutos) Then
    Begin
      if (fEmptyStr(edtProdutos.Text)) then
        pDesmarcaLista(edtProdutos,arrProduto);
    End
    Else If (Sender = edtMarca) Then
    Begin
      if (fEmptyStr(edtMarca.Text)) then
        pDesmarcaLista(edtMarca,arrMarca);
    End
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
	      If Length(arrEmp) > 0 Then
        Begin
          For intIndex := Low(arrEmp) To High(arrEmp) Do
          Begin
            If Pos(arrEmp[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrEmp[intIndex].strCodigo + '!', ['&O k']);
              Result := False;
              Break;
            End;
          End;
        End
        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

      If (fEmptyStr(edtCodEmpresa.Text)) Then
        pDesmarcaLista(edtCodEmpresa, arrEmp);
    End
    Else If (Sender = edtCodGruCmp) Then
    Begin
      if (fEmptyStr(edtCodGruCmp.Text)) then
        pDesmarcaLista(edtCodGruCmp,arrGrupoCompra);
    End
    Else If (Sender = edtCodDep) Then
    Begin
      if (fEmptyStr(edtCodDep.Text)) then
        pDesmarcaLista(edtCodDep,arrDepart);
    End
    Else If (Sender = edtOpcao) Then
    Begin

      If (edtOpcao.Text <> 'G') And (edtOpcao.Text <> 'F') Then
      Begin
        fMensagem('','O campo Opção deve ter G ou F!',['&O K'],0);
        Result := False;
      End;

    End
    Else If (Sender = edtIteAti) Then
    Begin

      If Pos(edtIteAti.Text, 'A_I_T_') <= 0 Then
      Begin
        fMensagem('','O campo Itens deve ter A, I ou T!',['&O K'],0);
        Result := False;
      End;

    End
    Else If (Sender = edtDestino) Then
    Begin

      If Pos(edtDestino.Text, 'V_I_E_') <= 0 Then
      Begin
        fMensagem('','O campo Destino deve ter V, I ou E!',['&O K'],0);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelEstSemMov.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;

    strSQLLinGru,
    strLinGru :String;
    intCnt: Integer;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  btnImprimir.Enabled := False;

  If blnImprime Then
  Begin
    strSQL := 'SELECT SQL_NO_CACHE                ';
    strSQL := strSQL + '  NULL         AS ULTCOM, ';
    strSQL := strSQL + '  NULL         AS ULTVEN, ';
    strSQL := strSQL + '  I.ITE_CODGRU AS GRUPO,  ';
    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '    UNI_SIGUNI AS UNIDAD, ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
    Begin
      strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
      strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS, ';

      strSQL := strSQL + '  (G.ITE_PRECUS * G.ITE_SALDOS) AS TOTCUS, ';

      strSQL := strSQL + '  G.ITE_PREVE1 AS PREVEN, ';

      strSQL := strSQL + '  (G.ITE_PREVE1 * G.ITE_SALDOS) AS TOTVEN, ';
    End
    Else
    Begin
      strSQL := strSQL + '  SUM(IF(G.ITE_CODEMP = ' + VS_strCodEmp + ', IFNULL(G.ITE_PRECUS, 0),0)) AS PRECUS, ';
      strSQL := strSQL + '  SUM(IFNULL(G.ITE_SALDOS, 0)) AS SALDOS, ';

      strSQL := strSQL + '  (SUM(IF(G.ITE_CODEMP = ' + VS_strCodEmp + ', IFNULL(G.ITE_PRECUS, 0),0)) * ';
      strSQL := strSQL + '  SUM(IFNULL(G.ITE_SALDOS, 0))) AS TOTCUS, ';

      strSQL := strSQL + '  SUM(IF(G.ITE_CODEMP = ' + VS_strCodEmp + ', IFNULL(G.ITE_PREVE1, 0),0)) AS PREVEN, ';

      strSQL := strSQL + '  (SUM(IF(G.ITE_CODEMP = ' + VS_strCodEmp + ', IFNULL(G.ITE_PREVE1, 0),0)) * ';
 			strSQL := strSQL + '  SUM(IFNULL(G.ITE_SALDOS, 0))) AS TOTVEN, ';
    End;

    strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '  IF(IFNULL(G.ITE_DTAUVE,"") = "",0,DATEDIFF(:DTAFIN,G.ITE_DTAUVE)) AS DIASEM, ';
    strSQL := strSQL + '  CONCAT(I.ITE_CODGRU," - ",GRU_DESGRU) AS GRU_DESGRU, ';
    strSQL := strSQL + '  CONCAT(I.ITE_CODFOR," - ",FOR_NOMFOR) AS FOR_NOMFOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';

    {**************************************************}
    {* ACRESCENTOU NOME DO GRUPO E NOME DO FORNECEDOR *}
    {***********************************************DP*}
    strSQL := strSQL + '  JOIN CADGRU ON I.ITE_CODGRU = GRU_CODGRU ';
    strSQL := strSQL + '  LEFT OUTER JOIN CADFOR ON I.ITE_CODFOR = FOR_CODFOR ';

    strSQL := strSQL + '  LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

    strSQL := strSQL + ' WHERE TRUE ';

    If (Not chkIteNMov.Checked) Then
    Begin
      strSQL := strSQL + ' AND ITE_DTAULT IS NULL ';
      strSQL := strSQL + ' AND ITE_DTAUVE IS NULL ';
    End;

    If Not SameText(edtImprimeLista.Text, 'T') Then
      strSQL := strSQL + ' AND G.ITE_IMPLIS = '+ QuotedStr(edtImprimeLista.Text);

    strSQL := strSQL + ' AND I.ITE_CODITE NOT IN ' + fMovDet;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'G.ITE_CODEMP', 'CODEMP');

    If (Length(arrLinhaGrupo) > 1) Then
    Begin
      For intCnt := Low(arrLinhaGrupo) To High(arrLinhaGrupo) Do
      Begin
        If Not fEmptyStr(arrLinhaGrupo[intCnt].strCodigo) Then
        Begin
          If Not fEmptyStr(strSQLLinGru) Then
          Begin
            strSQLLinGru := strSQLLinGru + ' OR ';
            strLinGru := strLinGru + '_';
          End;

          strLinGru := strLinGru + arrLinhaGrupo[intCnt].strCodigo;

          If RightStr(arrLinhaGrupo[intCnt].strCodigo,3) = '000' Then
            strSQLLinGru := strSQLLinGru + ' (LEFT(I.ITE_CODGRU,3) = ' + QuotedStr(LeftStr(arrLinhaGrupo[intCnt].strCodigo,3)) + ')'
          Else
            strSQLLinGru := strSQLLinGru + ' (I.ITE_CODGRU = ' + QuotedStr(arrLinhaGrupo[intCnt].strCodigo) + ')';
        End;
      End;
    End
    Else
    Begin
      If (Length(arrLinhaGrupo) = 1) Or (Not fEmptyStr(mskLinhaGrupo.Text)) Then
      begin
        If RightStr(mskLinhaGrupo.Text,3) = '000' Then
          strSQL := strSQL + '  AND (LOCATE(LEFT(I.ITE_CODGRU,3), LEFT(:CODGRU,3)) > 0 ) '
        Else
          strSQL := strSQL + '  AND (LOCATE(I.ITE_CODGRU, :CODGRU) > 0 ) ';
      End;
    End;

    If (Not fEmptyStr(strSQLLinGru)) Then
      strSQL := strSql + ' AND ( ' + strSQLLinGru + ' ) ';

    If Not fEmptyStr(edtProdutos.Text) Then
      strSQL := strSQL + fStrLocate(edtProdutos, arrProduto, 'I.ITE_CODITE', 'CODITE');

    If Not fEmptyStr(edtFornecedor.Text) Then
      strSQL := strSQL + fStrLocate(edtFornecedor, arrFornecedor, 'I.ITE_CODFOR', 'CODFOR');

    If Not fEmptyStr(edtMarca.Text) Then
      strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'I.ITE_CODMAR', 'CODMAR');

    strSql := strSQL + fStrLocate(edtCodGruCmp, arrGrupoCompra, 'I.ITE_GRUCMP', 'GRUCMP');
    strSql := strSQL + fStrLocate(edtCodDep, arrDepart, 'I.ITE_CODDEP', 'CODDEP');

    If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
      strSQL := strSQL + '  AND I.ITE_DTACAD >= :CADINI ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) Then
      strSQL := strSQL + '  AND I.ITE_DTACAD <= :CADFIN ';

    If (edtIteAti.Text = 'A') Then
      strSQL := strSQL + '  AND I.ITE_ITEATI = "S" '

    Else If (edtIteAti.Text = 'I') Then
      strSQL := strSQL + '  AND I.ITE_ITEATI = "N" ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  I.ITE_CODITE ';

    If (Not chkSalZer.Checked) Then
      strSQL := strSQL + '  HAVING SALDOS > 0.0 ';
    
    strSQL := strSQL + 'ORDER BY ';

    If edtOpcao.Text = 'G' Then
      strSQL := strSQL + '  I.ITE_CODGRU, '
    Else
      strSQL := strSQL + '  I.ITE_CODFOR, ';

    strSQL := strSQL + '  I.ITE_DESITE ';

    With qryRelatorio Do
    Begin
      AfterScroll := pAfterSroll;
      
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text, arrEmp, strEmp, 'CODEMP', qryRelatorio);

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLinhaGrupo,'CODGRU',qryRelatorio);

      If Not fEmptyStr(edtProdutos.Text)   Then
        pSetaParam(edtProdutos.Text, arrProduto, strProduto, 'CODITE', qryRelatorio);

      If Not fEmptyStr(edtFornecedor.Text) Then
        pSetaParam(edtFornecedor.Text, arrFornecedor, strFornecedor, 'CODFOR', qryRelatorio);

      If Not fEmptyStr(edtMarca.Text)      Then
        pSetaParam(edtMarca.Text, arrMarca, strMarca, 'CODMAR', qryRelatorio);

      pSetaParam(edtCodGruCmp.Text, arrGrupoCompra, strGruCmp, 'GRUCMP', qryRelatorio);
      pSetaParam(edtCodDep.Text, arrDepart, strDepart, 'CODDEP', qryRelatorio);

      If Not fEmptyStr(mskDtaIni.Text)     Then
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);

      If Not fEmptyStr(mskDtaFin.Text)     Then
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
        ParamByName('CADINI').AsDate := StrToDate(mskCadIni.Text);

      If Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) Then
        ParamByName('CADFIN').AsDate := StrToDate(mskCadFin.Text);

      If chkCFOPVen.Checked Then
      Begin
        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLADEV').AsString := VS_strClaDev;
      End;

      Try
        Screen.Cursor := crSQLWait;
        Open;
      Finally
        Screen.Cursor := crDefault;
      End;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      {***************************}
      {* MUDOU PARA NOVO FORMATO *}
      {************************DP*}
      If (edtDestino.Text = 'E') Then
          pGeraExcelNovo( qryRelatorio)
      Else
      Begin
        Try
          pCriarFormularios(TfrmQckEstSemMov,frmQckEstSemMov);
          frmQckEstSemMov.dtaDtaFin := StrToDate(mskDtaFin.Text);

          frmQckEstSemMov.dtsRelatorio.DataSet := qryRelatorio;

          frmQckEstSemMov.qryUltCom := qryUltCom;
          frmQckEstSemMov.qryUltVen := qryUltVen;

          If strTipImp = 'M' Then
          Begin
            frmQckEstSemMov.qckPagina.DefaultFilter := rldFiltro;
          End
          Else
          Begin
            frmQckEstSemMov.qckPagina.DefaultFilter := Nil;
          End;

          frmQckEstSemMov.rllItensNMov.Caption := AnsiUpperCase(chkIteNMov.Caption) + ': ' + IfThen(chkIteNMov.Checked, 'SIM', IfThen(strTipImp = 'M', 'NAO', 'NÃO'));
          frmQckEstSemMov.rllFornecedor.Caption    := fStrTitulo(edtFornecedor, edtDesFornecedor, arrFornecedor, strFornecedor, 'FORNECEDOR');
          frmQckEstSemMov.rllLinhaGrupoOrd.Caption := fStrTitulo(mskLinhaGrupo.Text, edtDesGrupo, arrLinhaGrupo, strLinhaGrupo, 'LINHA/GRUPO');
          frmQckEstSemMov.rllGrupo.Caption         := fStrTitulo(mskLinhaGrupo.Text, edtDesGrupo, arrLinhaGrupo, strLinhaGrupo, 'LINHA/GRUPO');
          frmQckEstSemMov.rllMarcaOrd.Caption      := fStrTitulo(edtMarca, edtDesMarca, arrMarca, strMarca, 'MARCA');
          frmQckEstSemMov.rllGrupoCompra.Caption   := fStrTitulo(edtCodGruCmp.Text, edtDesGruCmp, arrGrupoCompra, strGruCmp, 'GRUPO DE COMPRA');
          frmQckEstSemMov.rllCodDep.Caption        := fStrTitulo(edtCodDep.Text, edtDesDep, arrDepart, strDepart, 'DEPARTAMENTO');
          frmQckEstSemMov.rllProdutoOrd.Caption    := fStrTitulo(edtProdutos, edtDesProduto, arrProduto, strProduto, 'PRODUTO');
          frmQckEstSemMov.rllEmpresa.Caption       := fStrTitulo(edtCodEmpresa, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA');
          frmQckEstSemMov.rllCFOPVen.Caption       := 'CONSIDERAR APENAS CFOP DE VENDA: ' + IfThen(chkCFOPVen.Checked, 'SIM', IfThen(strTipImp = 'M', 'NAO', 'NÃO'));
          frmQckEstSemMov.rllImprimeLista.Caption  := 'IMPRIME LISTA INDIVIDUAL? ' + edtImprimeLista.Text;

          frmQckEstSemMov.rllDtaPer.Caption := 'PERÍODO DE  ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          If (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) And
                 (fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) Then
            frmQckEstSemMov.rllCadPer.Caption := 'PRODUTOS CADASTRADOS A PARTIR DE ' + mskCadIni.Text
          Else
          If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And
                 (fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
            frmQckEstSemMov.rllCadPer.Caption := 'PRODUTOS CADASTRADOS ATÉ ' + mskCadFin.Text
          Else
          If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And
             (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
            frmQckEstSemMov.rllCadPer.Caption := 'PRODUTOS CADASTRADOS DE ' + mskCadIni.Text + ' A ' + mskCadFin.Text
          Else
            frmQckEstSemMov.rllCadPer.Caption := '';

          If Not chkImpRef.Checked Then
          Begin
            With frmQckEstSemMov Do
            Begin
              rdbDescriLin.Width := rdbDescriLin.Width + rdbRefereLin.Width;

              rllReferencia.Visible := False;
              rdbRefereLin.Visible  := False;
            End;
          End;

          If edtOpcao.Text = 'F' Then
          Begin
            frmQckEstSemMov.rlbGrupo.Visible  := False;
            frmQckEstSemMov.rlbGrupo1.Visible := True;
          End;

          Case edtIteAti.Text[1] of
            'A' : frmQckEstSemMov.rllItens.Caption := 'ITENS: ATIVOS';
            'I' : frmQckEstSemMov.rllItens.Caption := 'ITENS: INATIVOS';
            'T' : frmQckEstSemMov.rllItens.Caption := 'ITENS: TODOS';
          End;

          If edtDestino.Text = 'V' Then
            frmQckEstSemMov.qckPagina.PreviewModal
          Else
            frmQckEstSemMov.qckPagina.Print;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckEstSemMov);
      End;
    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  qryRelatorio.AfterScroll := Nil;
end;

procedure TfrmRelEstSemMov.FormShow(Sender: TObject);
begin
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  chkAjusteEstoque.Visible := True;

  inherited;

  shpMultSel.Visible := True;
  pSetFocus(mskDtaIni);
  pCriaQryRelatorio;
end;

procedure TfrmRelEstSemMov.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelEstSemMov.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstSemMov.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: if ActiveControl Is TRadioButton Then
                 Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstSemMov.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrDepart, fRetDescDepartamento, Nil, 'do departamento');
end;

procedure TfrmRelEstSemMov.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepart, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstSemMov.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelEstSemMov.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstSemMov.edtCodGruCmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodGruCmp, edtDesGruCmp, arrGrupoCompra, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmRelEstSemMov.edtCodGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  {************************************}
  {* NOVA CONSULTA DE GRUPO DE COMPRA *}
  {*********************************RM*}
  If fPesqGrupoCompra(Self, edtCodGruCmp, edtDesGruCmp, Nil, Key, arrGrupoCompra, False) Then
  Begin
    If fValidaCampos(edtCodGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelEstSemMov.FormActivate(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmRelEstSemMov.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

   qryRelatorio.AfterScroll := Nil;
end;

procedure TfrmRelEstSemMov.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtProdutos);
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  qryUltCom := fCriaQuery(Self);
  qryUltVen := fCriaQuery(Self);
end;

procedure TfrmRelEstSemMov.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

(*
procedure TfrmRelEstSemMov.pGeraExcel;
  var
    arrSintetico: Array [1..10] Of Array [1..2] Of String;
    intCont   : Integer;
    intQtdCol : Integer;
    strUltCol : String;
    strLinAnt : String;
    strLinAtu : String;
    objExcel  : TExcel;
    dtaUltVen : TDate;
begin
  pbProgresso.Max      := qryRelatorio.RecordCount;
  pbProgresso.Position := 0;
  pbProgresso.Visible  := True;

  arrSintetico[01][01] := 'CODIGO';
  arrSintetico[02][01] := 'DESCRICAO';
  arrSintetico[03][01] := 'REFERENCIA';
  arrSintetico[04][01] := 'UNID.';
  arrSintetico[05][01] := 'ULT.COMPRA';
  arrSintetico[06][01] := 'ULT.VENDA';
  arrSintetico[07][01] := 'ESTOQUE';
  arrSintetico[08][01] := 'PR.CUSTO';

  If (rdgMostrar.ItemIndex = 1) Then
    arrSintetico[09][01] := 'CUST.EST'
  Else
    arrSintetico[09][01] := 'PR.VENDA';

  arrSintetico[10][01] := 'DIAS QUE NAO VENDE';

  arrSintetico[01][02] := 'CODITE';
  arrSintetico[02][02] := 'DESITE';
  arrSintetico[03][02] := 'REFERE';
  arrSintetico[04][02] := 'UNIDAD';
  arrSintetico[05][02] := 'ULTCOM';
  arrSintetico[06][02] := 'ULTVEN';
  arrSintetico[07][02] := 'SALDOS';
  arrSintetico[08][02] := 'PRECUS';
  arrSintetico[09][02] := 'PREVEN';
  arrSintetico[10][02] := 'DIASEM';

  objExcel := TExcel.Create;

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
    intQtdCol  := Length(arrSintetico);
    strUltCol  := fGetLetraAlfa(intQtdCol);

    pnlInfo.Caption := 'Aguarde... Gerando Arquivo!';

    Escrever(ProximaLinha, 01, fRetNomeEmpresa);
    Escrever(ProximaLinha, 01, 'RELATORIO DE PRODUTOS SEM MOVIMENTACAO DE ESTOQUE');
    Escrever(ProximaLinha, 01, 'REFERENTE AO PERIODO DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)));
    Escrever(ProximaLinha, 01, 'FORNECEDOR: ' + ifthen(fEmptyStr(edtFornecedor.Text), 'TODOS', edtFornecedor.Text + '-' + edtDesFornecedor.Text));
    Escrever(ProximaLinha, 01, 'LINHA / GRUPO: ' + ifthen(fEmptyStr(mskLinhaGrupo.Text), 'TODOS', mskLinhaGrupo.Text + '-' + edtDesGrupo.Text));
    Escrever(ProximaLinha, 01, 'PRODUTOS: ' + ifthen(fEmptyStr(edtProdutos.Text), 'TODOS', edtProdutos.Text + '-' + edtDesProduto.Text));
    Escrever(ProximaLinha, 01, 'MARCA: ' + ifthen(fEmptyStr(edtMarca.Text), 'TODAS', edtMarca.Text + '-' + edtDesMarca.Text));

    With qryRelatorio Do
    Begin

      For intCont := 1 To LinhaAtual Do
      Begin
        Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
        Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
        Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
      End;

      CorFundo('A2', strUltCol + '3', Cinza);
      Bordas('A2', strUltCol + '3',True,True,True,True);

      ProximaLinha;

      For intCont := 1 To intQtdCol Do
      Begin
        If (arrSintetico[intCont][02] = 'DIASEM') Then
        Begin
          dtaUltVen := StrToDateDef(LeftStr(qryUltVen.FieldByName('ULTVEN').AsString, 10), 0);

          If dtaUltVen > 0 Then
            Escrever(LinhaAtual, intCont, '''' + IntToStr(Trunc(VS_Date - dtaUltVen)))
          Else
            Escrever(LinhaAtual, intCont, '');

          Alinhamento(LinhaAtual, intCont, Direita);
        End

        Else If (arrSintetico[intCont][02] = 'ULTCOM') Then
        Begin

          Escrever(LinhaAtual, intCont, '''' + qryUltCom.FieldByName('ULTCOM').AsString);

        End
        Else If (arrSintetico[intCont][02] = 'ULTVEN') Then
        Begin

          Escrever(LinhaAtual, intCont, '''' + qryUltVen.FieldByName('ULTVEN').AsString);

        End Else
        Begin

          If (arrSintetico[intCont][02] = 'REFERE') And Not chkImpRef.Checked Then
            Continue;

          Escrever(LinhaAtual, intCont, arrSintetico[intCont, 01]);
          Negrito(LinhaAtual, intCont, True);

          If (FieldByName(arrSintetico[intCont, 02]).DataType = ftFloat) Then
            Alinhamento(LinhaAtual, intCont, Direita)
          Else
            Alinhamento(LinhaAtual, intCont, Esquerda);

        End;

      End;

      CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
      CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      First;

      While Not Eof Do
      Begin
        Application.ProcessMessages;

        If (edtOpcao.Text = 'F') Then
        Begin
          strLinAnt := FieldByName('CODFOR').AsString;
          strLinAtu := FieldByName('CODFOR').AsString;
          Escrever(ProximaLinha, 01, strLinAnt + ' - ' + fRetNomFornecedor(strLinAnt));
        End
        Else
        Begin
          strLinAnt := FieldByName('GRUPO').AsString;
          strLinAtu := FieldByName('GRUPO').AsString;
          Escrever(ProximaLinha, 01, strLinAnt + ' - ' + fRetNomeLinhaGrupo(strLinAnt));
        End;

        Negrito(LinhaAtual, 01, True);

        Mesclar('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

        While (Not Eof) And (strLinAtu = strLinAnt) Do
        Begin
          pbProgresso.Position := RecNo;
          Application.ProcessMessages;

          ProximaLinha;

          For intCont := 1 To intQtdCol Do
          Begin
            If (arrSintetico[intCont][02] <> 'DIASEM') Then
            Begin
              If (arrSintetico[intCont][02] = 'REFERE') And Not chkImpRef.Checked Then
                Continue;
                
              If (FieldByName(arrSintetico[intCont, 02]).DataType = ftFloat) Then
              Begin
                Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrSintetico[intCont, 02]).AsFloat));
                Alinhamento(LinhaAtual, intCont, Direita);
              End
              Else
              Begin
                Escrever(LinhaAtual, intCont, '''' + FieldByName(arrSintetico[intCont, 02]).AsString);
                Alinhamento(LinhaAtual, intCont, Esquerda);
              End;
            End
            Else
            Begin
              If FieldByName('ITE_DTAUVE').IsNull Or ((StrToDate(mskDtaFin.Text) - FieldByName('ITE_DTAUVE').AsDateTime) < 0) Then
                Escrever(LinhaAtual, intCont, '0')
              Else
                Escrever(LinhaAtual, intCont, '''' + FloatToStr(StrToDate(mskDtaFin.Text) - FieldByName('ITE_DTAUVE').AsDateTime));

              Alinhamento(LinhaAtual, intCont, Direita);
            End;
          End;

          Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          If LinhaAtual Mod 2 = 0 Then
            CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);

          Next;
          If (edtOpcao.Text = 'F') Then
            strLinAtu := FieldByName('CODFOR').AsString
          Else
            strLinAtu := FieldByName('GRUPO').AsString;
        End;

      End;
      OrientacaoPagina(Retrato);

      CongelarPaines('A10');
      AutoAjuste;
      SalvarArquivo;
      FecharArquivo;

      pnlInfo.Caption := '';

      fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);
    End;
  End;

  pbProgresso.Visible  := False;
  FreeAndNil(objExcel);
end;
*)

procedure TfrmRelEstSemMov.edtDestinoExit(Sender: TObject);
begin
  //inherited;
end;

{********************************************}
{* GERACAO DE EXCEL, UTILIZANDO NOVO OBJETO *}
{*****************************************DP*}
procedure TfrmRelEstSemMov.pGeraExcelNovo(DataSet : TDataSet);
Var
  ObjExcel : TGeraExcel;
begin

  ObjExcel := TGeraExcel.Create(DataSet, pbProgresso);

  ObjExcel.strNomRel := 'RELATÓRIO DE PRODUTOS SEM MOVIMENTAÇÃO DE ESTOQUE';

  ObjExcel.AddFiltro(fStrTitulo(edtFornecedor, edtDesFornecedor, arrFornecedor, strFornecedor, 'FORNECEDOR'));
  ObjExcel.AddFiltro(fStrTitulo(mskLinhaGrupo.Text, edtDesGrupo, arrLinhaGrupo, strLinhaGrupo, 'LINHA/GRUPO'));
  ObjExcel.AddFiltro(fStrTitulo(edtMarca, edtDesMarca, arrMarca, strMarca, 'MARCA'));
  ObjExcel.AddFiltro(fStrTitulo(edtProdutos, edtDesProduto, arrProduto, strProduto, 'PRODUTO'));
  ObjExcel.AddFiltro(fStrTitulo(edtCodEmpresa, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA'));
  ObjExcel.AddFiltro(fStrTitulo(edtCodGruCmp.Text, edtDesGruCmp, arrGrupoCompra, strGruCmp, 'GRUPO DE COMPRA'));
  ObjExcel.AddFiltro(fStrTitulo(edtCodDep.Text, edtDesDep, arrDepart, strDepart, 'DEPARTAMENTO'));
  ObjExcel.AddFiltro('CONSIDERAR APENAS CFOP DE VENDA: ' + IfThen(chkCFOPVen.Checked, 'SIM', 'NÃO'));
  ObjExcel.AddFiltro(AnsiUpperCase(chkIteNMov.Caption) + ': ' + IfThen(chkIteNMov.Checked, 'SIM', 'NÃO'));
  ObjExcel.AddFiltro('IMPRIME LISTA INDIVIDUAL? ' + edtImprimeLista.Text);
  ObjExcel.AddFiltro('PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

  If (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) And
         (fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) Then
    ObjExcel.AddFiltro('PRODUTOS CADASTRADOS A PARTIR DE ' + mskCadIni.Text)
  Else
  If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And
         (fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
    ObjExcel.AddFiltro('PRODUTOS CADASTRADOS ATÉ ' + mskCadFin.Text)
  Else
  If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
    ObjExcel.AddFiltro('PRODUTOS CADASTRADOS DE ' + mskCadIni.Text + ' A ' + mskCadFin.Text);

  {***********}
  {* CAMPOS  *}
  {********DP*}
  ObjExcel.AddCampo('CODITE','CÓDIGO');
  ObjExcel.AddCampo('DESITE','DESCRIÇÃO');
  ObjExcel.AddCampo('REFERE','REFERÊNCIA');
  ObjExcel.AddCampo('UNIDAD','UNIDADE');

  ObjExcel.AddCampo(fRetUltimaCompra, 'ULTCOM', 'ULT.COMPRA');
  ObjExcel.AddCampo(fRetUltimaVenda,  'ULTVEN', 'ULT.VENDA');

  ObjExcel.AddCampo('SALDOS','ESTOQUE');
  ObjExcel.AddCampo('PRECUS','PR.CUSTO');
  ObjExcel.AddCampo('TOTCUS','TOT.CUSTO');
  ObjExcel.AddCampo('PREVEN','PR.VENDA');
  ObjExcel.AddCampo('TOTVEN','TOT.VENDA');

  ObjExcel.AddCampo(fRetDiasNaoVende, 'DIASEM', 'DIAS SEM VENDA');

  {***********}
  {* QUEBRAS *}
  {********DP*}
  If edtOpcao.Text = 'G' Then
    ObjExcel.AddQuebra('GRU_DESGRU','Grupo ')
  else
    ObjExcel.AddQuebra('FOR_NOMFOR','Fornecedor ');

  ObjExcel.OnMontaResumo := pMontaResumo;
	ObjExcel.OnSomaResumo  := pSomaTotais;

  If objExcel.fGerarRelatorio Then
    fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

  FreeAndNil(ObjExcel);

end;

procedure TfrmRelEstSemMov.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
var
	strLetra: String;
begin
	With Excel Do
  Begin
    ProximaLinha;
    strLetra := Campos.ColunaPorNome['PRECUS'].Letra;

    if Quebra.NomeCampo = 'GRU_DESGRU' then
      Escrever(LinhaAtual, 1, 'VALOR DO ESTOQUE DO GRUPO:')
    else if Quebra.NomeCampo = 'FOR_NOMFOR' then
      Escrever(LinhaAtual, 1, 'VALOR DO ESTOQUE DO FORNECEDOR:')
    else
      Escrever(LinhaAtual, 1, 'VALOR DO ESTOQUE TOTAL:');

    Mesclar('A'+IntToStr(LinhaAtual), strLetra+IntToStr(LinhaAtual));
    Alinhamento(LinhaAtual, 1, Direita);
    Negrito(LinhaAtual, 1, True);

    Bordas('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

    Negrito(LinhaAtual, Campos.ColunaPorNome['TOTCUS'].Coluna, True);
    Negrito(LinhaAtual, Campos.ColunaPorNome['TOTVEN'].Coluna, True);
    Negrito(LinhaAtual, Campos.ColunaPorNome['PREVEN'].Coluna, True);
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTCUS'].Coluna, Quebra.Totais['fltTotCus']);
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTVEN'].Coluna, Quebra.Totais['fltTotVen']);
    Escrever(LinhaAtual, Campos.ColunaPorNome['PREVEN'].Coluna, Quebra.Totais['fltVen']);
    FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['TOTCUS'].Coluna);
    FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['TOTVEN'].Coluna);
    FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['PREVEN'].Coluna);
  end;
end;

procedure TfrmRelEstSemMov.pSomaTotais(var Totais: TTotais; Dados: TDataSet);
begin
  With Dados Do
  Begin
    Totais['fltTotCus'] := Totais['fltTotCus'] + FieldByName('TOTCUS').AsFloat;
    Totais['fltTotVen'] := Totais['fltTotVen'] + FieldByName('TOTVEN').AsFloat;
    Totais['fltVen'] 		:= Totais['fltVen']    + FieldByName('PREVEN').AsFloat;
  End;
end;

Function TfrmRelEstSemMov.fSQLUltimaCompra: String;
  Var
    strSqlTmp: String;
    strSqlAux: String;
Begin
  strSqlTmp := EmptyStr;
  strSqlTmp := strSqlTmp + 'SELECT SQL_NO_CACHE ';
  strSqlTmp := strSqlTmp + '  DET_CODEMP AS CODEMP, MAX(DET_DTAENT) AS ULTCOM ';
  strSqlTmp := strSqlTmp + 'FROM ';
  strSqlTmp := strSqlTmp + '  MOVDET ';
  strSqlTmp := strSqlTmp + 'WHERE ';
  strSqlTmp := strSqlTmp + '  LOCATE(DET_CLAFIS, :CLACOM) > 0 AND ';
  strSqlTmp := strSqlTmp + '  DET_TIP_FC = "F"                AND ';
  strSqlTmp := strSqlTmp + '  DET_CODITE = :CODITE            AND ';
  strSqlTmp := strSqlTmp + '  DET_ESPDOC <> "TM"              AND ';
  strSqlTmp := strSqlTmp + '  DET_ESPDOC <> "DF"              AND ';
  strSqlTmp := strSqlTmp + '  DET_FILKAR = FALSE                  ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSqlTmp := strSqlTmp + ' AND DET_CODEMP = :CODEMP ';

  If chkCFOPVen.Checked Then
  Begin
    strSqlTmp := strSqlTmp + ' AND DET_PROEMB <> "S" AND ';
    strSqlTmp := strSqlTmp + '      DET_TIP_FC = "C"  AND ';
    strSqlTmp := strSqlTmp + '      DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSqlTmp := strSqlTmp + '      ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

    If fCfgSis('ENTBRF', varBoolean) Then
      strSqlTmp := strSqlTmp + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSqlTmp := strSqlTmp + ') ';
  End;

  If Not chkAjusteEstoque.Checked Then
    strSqlTmp := strSqlTmp + ' AND DET_ESPDOC <> "AJ" ';

  If Not chkTransfEstoque.Checked Then
    strSqlTmp := strSqlTmp + ' AND LOCATE(DET_CODFOR, '+ QuotedStr(fRetForFilialTodos) +') = 0 ';

  strSqlTmp := strSqlTmp + 'GROUP BY DET_CODEMP    ';

  strSqlTmp := strSqlTmp + 'ORDER BY ULTCOM DESC LIMIT 1  ';
  strSqlAux := strSqlTmp;

  strSqlTmp := EmptyStr;
  strSqlTmp := strSqlTmp + ' SELECT SQL_NO_CACHE ';
  strSqlTmp := strSqlTmp + '   CONCAT(DATE_FORMAT(ULTCOM, "%d/%m/%Y"), "-", CODEMP) AS ULTCOM ';
  strSqlTmp := strSqlTmp + 'FROM ( ';

  strSqlTmp := strSqlTmp + strSqlAux;

  strSqlTmp := strSqlTmp + ') AS TABCMP ';

  Result := strSqlTmp;
End;

Function TfrmRelEstSemMov.fSQLUltimaVenda: String;
  Var
    strSqlTmp: String;
    strSqlAux: String;
Begin
  strSqlTmp := EmptyStr;
  strSqlTmp := strSqlTmp + 'SELECT SQL_NO_CACHE ';
  strSqlTmp := strSqlTmp + '  DET_CODEMP AS CODEMP, MAX(DET_DTAENT) AS ULTVEN ';
  strSqlTmp := strSqlTmp + 'FROM ';
  strSqlTmp := strSqlTmp + '  MOVDET ';
  strSqlTmp := strSqlTmp + 'WHERE ';
  strSqlTmp := strSqlTmp + '  DET_TIP_FC = "C"   AND ';
  strSqlTmp := strSqlTmp + '  DET_CODITE = :CODITE      AND ';
  strSqlTmp := strSqlTmp + '  DET_ESPDOC <> "TM"        AND ';
  strSqlTmp := strSqlTmp + '  DET_ESPDOC <> "DF"        AND ';
  strSqlTmp := strSqlTmp + '  DET_FILKAR = FALSE        AND ';
  strSqlTmp := strSqlTmp + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) OR (DET_ESPDOC = "ML" AND DET_ORIDOC="V")) ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSqlTmp := strSqlTmp + ' AND DET_CODEMP = :CODEMP ';

  strSqlTmp := strSqlTmp + 'GROUP BY DET_CODEMP    ';

  strSqlTmp := strSqlTmp + 'ORDER BY ULTVEN DESC LIMIT 1  ';
  strSqlAux := strSqlTmp;

  strSqlTmp := EmptyStr;
  strSqlTmp := strSqlTmp + ' SELECT SQL_NO_CACHE ';
  strSqlTmp := strSqlTmp + '   CONCAT(DATE_FORMAT(ULTVEN, "%d/%m/%Y"), "-", CODEMP) AS ULTVEN ';
  strSqlTmp := strSqlTmp + 'FROM ( ';

  strSqlTmp := strSqlTmp + strSqlAux;

  strSqlTmp := strSqlTmp + ') AS TABCMP ';

  Result := strSqlTmp;
End;

Procedure TfrmRelEstSemMov.pUltimaCompra(dataSet: TDataSet);
Begin
  With qryUltCom Do
  Begin
    Close;
    SQL.Text := fSQLUltimaCompra;
    ParamByName('CODITE').AsString := dataSet.FieldByName('CODITE').AsString;
    ParamByName('CLACOM').AsString := VS_strClaCom;

    If chkCFOPVen.Checked Then
    Begin
      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;
    End;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    Open;
  End;
End;

Procedure TfrmRelEstSemMov.pUltimaVenda(dataSet: TDataSet);
Begin
  With qryUltVen Do
  Begin
    Close;
    SQL.Text := fSQLUltimaVenda;
    ParamByName('CODITE').AsString := dataSet.FieldByName('CODITE').AsString;
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    Open;
  End;
End;

Procedure TfrmRelEstSemMov.pAfterSroll(dataSet: TDataSet);
Begin
  pUltimaCompra(dataSet);
  pUltimaVenda(dataSet);
End;

procedure TfrmRelEstSemMov.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

Function TfrmRelEstSemMov.fRetUltimaCompra(dtsDados: TDataSet): String;
Begin
  Result := qryUltCom.FieldByName('ULTCOM').AsString;
End;

Function TfrmRelEstSemMov.fRetUltimaVenda(dtsDados: TDataSet): String;
Begin
  Result := qryUltVen.FieldByName('ULTVEN').AsString;
End;

Function TfrmRelEstSemMov.fRetDiasNaoVende(dtsDados: TDataSet): String;
  Var
    dtaUltVen, dtaDtaFin: TDate;
Begin
  dtaDtaFin := StrToDateTime(mskDtaFin.Text);
  dtaUltVen := StrToDateDef(LeftStr(qryUltVen.FieldByName('ULTVEN').AsString, 10), 0);

  If dtaUltVen > 0 Then
    Result := IntToStr(Trunc(dtaDtaFin - dtaUltVen))
  Else
    Result := '-';
End;

Function TfrmRelEstSemMov.fMovDet : String;
Begin
  Result := Result + ' ( SELECT DET_CODITE ';
  Result := Result + '     FROM MOVDET D ';
  Result := Result + '    WHERE D.DET_CODITE = I.ITE_CODITE AND ';
  Result := Result + '          D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  Result := Result + '          D.DET_FILKAR = FALSE AND ';

  If Not chkAjusteEstoque.Checked Then
    Result := Result + '        D.DET_ESPDOC NOT IN ("TM", "DF", "AJ") '
  Else
    Result := Result + '        D.DET_ESPDOC NOT IN ("TM", "DF") ';

  If Not chkTransfEstoque.Checked Then
  Begin
    Result := Result + ' AND (D.DET_CODCLI IS NULL OR D.DET_CODCLI NOT IN ('+ VS_strCliFil +')) ';
    Result := Result + ' AND (D.DET_CODFOR IS NULL OR LOCATE(D.DET_CODFOR, '+ QuotedStr(fRetForFilialTodos) +') = 0) ';
  End;

  If chkCFOPVen.Checked Then
  Begin
    Result := Result + ' AND D.DET_PROEMB <> "S" AND ';
    Result := Result + '      D.DET_TIP_FC = "C"  AND ';
    Result := Result + '      D.DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    Result := Result + '      ((LOCATE(D.DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(D.DET_CLAFIS, :CLADEV) > 0)';

    If fCfgSis('ENTBRF', varBoolean) Then
      Result := Result + ' OR (D.DET_ESPDOC = "BR") OR LOCATE(D.DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      Result := Result + ') ';
  End;

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    Result := Result + fStrLocate(edtCodEmpresa, arrEmp, 'D.DET_CODEMP', 'CODEMP');

  Result := Result + ')';
End;

end.

