unit untRelCatalogoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, RLFilters, RLDraftFilter, Vcl.ExtCtrls, untFuncoes,untFuncoesGenerica,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus,
  QColorLabel, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus,
  Data.DB, MemDS, DBAccess, Uni, untTypesSistema, untFuncoesImagem,
  ComboBoxFocus, frxPreview, cxProgressBar, Datasnap.DBClient, UniClientDataSet,
  Datasnap.Provider, UniDataSetProvider, vcl.printers, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, dxColorEdit, VCLTee.TeCanvas, System.UITypes,
  untIFuncoes, untClassPanelCx, System.StrUtils, untFuncoesSimples, untConsultas, untFuncoesConsulta,
  frxBarcode;

type
  TfrmRelCatalogoProduto = class(TfrmPaiRelatorio)
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblDescricao: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtFornecedor: TEditFocus;
    edtMarca: TEditFocus;
    edtDescri: TEditFocus;
    edtRefere: TEditFocus;
    edtUnidade: TEditFocus;
    edtDesGrupo: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDesMarca: TEditFocus;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    rdgExibirItens: TRadioGroup;
    frxRelJato: TfrxReport;
    frxProduto: TfrxDBDataset;
    dtsDepartamento: TDataSource;
    frxDepartamento: TfrxDBDataset;
    Label4: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    rdgOrientacao: TRadioGroup;
    cldPrincipal: TColorDialog;
    gpbCabecalho: TGroupBox;
    shpFundoCabecalho: TShape;
    shpFonteCabecalho: TShape;
    btnFundoCabecalho: TBitBtnLocked;
    btnFonteCabecalho: TBitBtnLocked;
    ColorLabel2: TColorLabel;
    gpbRodape: TGroupBox;
    shpFundoRodape: TShape;
    shpFonteRodape: TShape;
    btnFundoRodape: TBitBtnLocked;
    btnFonteRodape: TBitBtnLocked;
    gpbColunas: TGroupBox;
    cbxColunas: TcxComboBox;
    rdgImpLis: TRadioGroup;
    gpbPrecos: TGroupBox;
    chkExiPrecos: TCheckBox;
    chkConsiderarPromocao: TCheckBox;
    cbxTabPre: TComboBoxFocus;
    rdgExibir: TRadioGroup;
    rdgSaldoProduto: TRadioGroup;
    rdgDescricao: TRadioGroup;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbCamposAdicionais: TGroupBox;
    chkExbUni: TCheckBox;
    chkExbEmb: TCheckBox;
    gpbBuscarAgregados: TGroupBox;
    chkAgregados: TCheckBox;
    Label5: TLabel;
    mskDtaCadIni: TMaskEditFocus;
    rdgImagem: TRadioGroup;
    Label6: TLabel;
    edtPromoc: TEditFocus;
    edtDesPromoc: TEditFocus;
    rdgPromocao: TRadioGroup;
    rdgAtivoCompras: TRadioGroup;
    chkExbEmail: TCheckBox;
    chkExbVeiculo: TCheckBox;
    frxVeiculos: TfrxDBDataset;
    dtsVeiculos: TDataSource;
    Label7: TLabel;
    edtMarVei: TEditFocus;
    edtDescMarVei: TEditFocus;
    Label8: TLabel;
    edtModVei: TEditFocus;
    edtDescModVei: TEditFocus;
    mskDtaCadFin: TMaskEditFocus;
    chkCodBar: TCheckBox;
    rdgOrdena: TRadioGroup;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeExit(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function frxRelJatoUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure frxGenGetValue(const VarName: string; var Value: Variant);
    procedure btnFundoCabecalhoClick(Sender: TObject);
    procedure btnFonteCabecalhoClick(Sender: TObject);
    procedure btnFundoRodapeClick(Sender: TObject);
    procedure btnFonteRodapeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkExiPrecosClick(Sender: TObject);
    function fTabPreco: String;
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtPromocExit(Sender: TObject);
    procedure edtPromocKeyPress(Sender: TObject; var Key: Char);
    procedure chkConsiderarPromocaoClick(Sender: TObject);
    procedure chkExbVeiculoClick(Sender: TObject);
    procedure edtMarVeiKeyPress(Sender: TObject; var Key: Char);
    procedure edtModVeiKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarVeiExit(Sender: TObject);
    procedure edtModVeiExit(Sender: TObject);
  protected
  private

    qryDepartamento : TUniQuery;
    qryCodIte  : TUniQuery;
    qryVeiculos: TUniQuery;

    strDepart: String;
    arrDepart: TConsultasArray;
    strLinGru: String;
    arrLinGru: TConsultasArray;
    strProdut: String;
    arrProdut: TConsultasArray;
    strFornec: String;
    arrFornec: TConsultasArray;
    strMarca : String;
    arrMarca : TConsultasArray;
    strPromoc : String;
    arrPromoc : TConsultasArray;
    strUnidad: String;
    arrUnidad: TConsultasArray;
    strEmpresa: String;
    arrEmpresa: TConsultasArray;
    strMarVei : String;
    arrMarVei : TConsultasArray;
    strModVei : String;
    arrModVei : TConsultasArray;

    strEmpFone01 : String;
    strEmpEmail  : String;
    procedure pSelecionaCor(shpCor: TShape);
    function fRetornaSaldoDisponivelEmpresas(strCodIte: string): Double;
    function fRetornaLeftImagem: Double;
    function fRetornaWidthImagem: Double;
    function fTemVeiculo(strCodIte: String): Boolean;
    function fQuantVeiculo(strCodIte: String): Double;
    function Split(const strTexto: string; chrDelimitador: Char): TStringList;
    function fRetornaSQL(blnRetornaAgregados: Boolean = False; blnSetaCodAgregados: Boolean = False): string;
    function fRetOrdenacao: string;
    procedure pSetaAgregados;
    procedure pSetaFiltros(qryComponente: TUniQuery);
    function fSQLVeiculos: String;
    function fGetCaminhoFR3: String;
    function fGetCaminhoLogo: String;
    function fTemFR3: Boolean;
    function fTemLogo: Boolean;
    procedure pValidaImagensExternas;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelCatalogoProduto: TfrmRelCatalogoProduto;

implementation

{$R *.dfm}

function TfrmRelCatalogoProduto.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskDtaCadIni) Or (Sender = mskDtaCadFin) Then
    Begin
      If (Sender = mskDtaCadIni) Then
      Begin
        If not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
        Begin
          If Not fValidaDataStr(mskDtaCadIni.Text) Then
          Begin
            fMensagem('', 'Data de Cadastro Inicial não é válida!', ['&O k']);
            Result := False;
            Sender := mskDtaCadIni;
          End;
        End;
      End
      Else If (Sender = mskDtaCadFin) Then
      Begin
        If not fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) Then
        Begin
          If Not fValidaDataStr(mskDtaCadFin.Text) Then
          Begin
            fMensagem('', 'Data de Cadastro Final não é válida!', ['&O k']);
            Result := False;
            Sender := mskDtaCadFin;
          End;
        End;
      End;
      If Result Then
      Begin
        If (not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) And (not fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text))) Then
        Begin
          If StrToDate(mskDtaCadFin.Text) < StrToDate(mskDtaCadIni.Text) Then
          Begin
            fMensagem('', 'Data de Cadastro Final não pode ser menor que Data de Cadastro Inicial!', ['&O k']);
            Result := False;
            Sender := mskDtaCadFin;
          End;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelCatalogoProduto.btnFonteCabecalhoClick(Sender: TObject);
begin
  inherited;
  pSelecionaCor(shpFonteCabecalho);
end;

procedure TfrmRelCatalogoProduto.btnFonteRodapeClick(Sender: TObject);
begin
  inherited;
  pSelecionaCor(shpFonteRodape);
end;

procedure TfrmRelCatalogoProduto.btnFundoCabecalhoClick(Sender: TObject);
begin
  inherited;
  pSelecionaCor(shpFundoCabecalho);
end;

procedure TfrmRelCatalogoProduto.btnFundoRodapeClick(Sender: TObject);
begin
  inherited;
  pSelecionaCor(shpFundoRodape);
end;

procedure TfrmRelCatalogoProduto.pSelecionaCor(shpCor : TShape);
begin
  cldPrincipal.Color := shpCor.Brush.Color;
  if cldPrincipal.Execute then
    shpCor.Brush.Color := cldPrincipal.Color;
end;

function TfrmRelCatalogoProduto.fRetornaSQL(blnRetornaAgregados: Boolean = False; blnSetaCodAgregados: Boolean = False): string;
var
  strSQL: string;
begin

  strSQL := '';

  if blnSetaCodAgregados then
  begin
    strSQL := strSQL + ' SET group_concat_max_len := 65535; ';
    strSQL := strSQL + ' SET @CODAGR = ( ';
  end;

  strSQL := strSQL + 'SELECT ';

  if blnSetaCodAgregados then
    strSQL := strSQL + ' GROUP_CONCAT(DISTINCT AGR_CODAGR SEPARATOR "_") '
  else
  begin

    strSQL := strSQL + '  I.ITE_CODITE  AS CODITE, ';
    strSQL := strSQL + '  I.ITE_CODBAR  AS CODBAR, ';
    strSQL := strSQL + '  I.ITE_REFERE  AS REFERE, ';
    strSQL := strSQL + '  I.ITE_APLICA  AS APLICA, ';
    strSQL := strSQL + '  G.ITE_SALDOS  AS SALDOS, ';
    strSQL := strSQL + '  I.ITE_CODFAB  AS CODFAB, ';
    strSQL := strSQL + '  M.MAR_DESMAR  AS DESMAR, ';

    case rdgDescricao.ItemIndex of
      0: strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
      1: strSQL := strSQL + '  IF(TRIM(IFNULL(I.ITE_DESSIM,"")) = "", I.ITE_DESITE, I.ITE_DESSIM)  AS DESITE, ';
    end;

    strSQL := strSQL + '  UNI_SIGUNI    AS SIGUNI, ';
    strSQL := strSQL + '  L.GRU_CODGRU  AS CODGRU, ';
    strSQL := strSQL + '    GRU_DESGRU  AS DESGRU, ';
    strSQL := strSQL + '  IG.ITE_IMGB64 AS IMGB64, ';
    strSQL := strSQL + '  "" AS TEMIMG, ';
    strSQL := strSQL + '  D.DEP_CODIGO  AS CODDEP, ';
    strSQL := strSQL + '  D.DEP_DESCRI  AS DESDEP, ';
    strSQL := strSQL + '  CONCAT(ROUND(IFNULL(I.ITE_EMBALA,0), 0), "/", ROUND(IFNULL(I.ITE_MLTVEN,0), 0))AS EMBALA, ';

    strSQL := strSQL + ' CASE '+fTabPreco+' ' ;
      If (chkExiPrecos.Checked) And (chkConsiderarPromocao.Checked) Then
      Begin
        strSQL := strSQL + '    WHEN 1 THEN IFNULL(PRO.IPR_PREVEN, G.ITE_PREVE1) ';
        strSQL := strSQL + '    WHEN 2 THEN IFNULL(PRO.IPR_PREVE2, G.ITE_PREVE2) ';
        strSQL := strSQL + '    WHEN 3 THEN IFNULL(PRO.IPR_PREVE3, G.ITE_PREVE3) ';
        strSQL := strSQL + '    WHEN 4 THEN IFNULL(PRO.IPR_PREVE4, G.ITE_PREVE4) ';
        strSQL := strSQL + '    WHEN 5 THEN IFNULL(PRO.IPR_PREVE5, G.ITE_PREVE5) ';
        strSQL := strSQL + '    WHEN 6 THEN IFNULL(PRO.IPR_PREVE6, G.ITE_PREVE6) ';
        strSQL := strSQL + '    WHEN 7 THEN IFNULL(PRO.IPR_PREVE7, G.ITE_PREVE7) ';
      End
      Else
      Begin
        strSQL := strSQL + '    WHEN 1 THEN G.ITE_PREVE1 ';
        strSQL := strSQL + '    WHEN 2 THEN G.ITE_PREVE2 ';
        strSQL := strSQL + '    WHEN 3 THEN G.ITE_PREVE3 ';
        strSQL := strSQL + '    WHEN 4 THEN G.ITE_PREVE4 ';
        strSQL := strSQL + '    WHEN 5 THEN G.ITE_PREVE5 ';
        strSQL := strSQL + '    WHEN 6 THEN G.ITE_PREVE6 ';
        strSQL := strSQL + '    WHEN 7 THEN G.ITE_PREVE7 ';
      End;
    strSQL := strSQL + '  END PREVEN ';

  end;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '       JOIN ITEGER G  ON G.ITE_CODITE  = I.ITE_CODITE AND G.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + '       JOIN CADGRU L  ON I.ITE_CODGRU  = L.GRU_CODGRU ';
  strSQL := strSQL + '  LEFT JOIN CADUNI U  ON (U.UNI_CODUNI = I.ITE_CODUNI) ';
  strSQL := strSQL + '  LEFT JOIN CADDEP D  ON (D.DEP_CODIGO = I.ITE_CODDEP) ';
  strSQL := strSQL + '  LEFT JOIN CADMAR M  ON (M.MAR_CODMAR = I.ITE_CODMAR) ';
  strSQL := strSQL + '  LEFT JOIN ITEBAR B  ON (B.BAR_CODITE = I.ITE_CODITE AND B.BAR_CODEMP = :CODEMP AND B.BAR_PRINCI = 1  ) ';
  strSQL := strSQL + '  LEFT JOIN ITEIMG IG ON (IG.ITE_CODITE = I.ITE_CODITE AND IG.ITE_PRINCI = "S") ';
  strSQL := strSQL + '  LEFT JOIN (	SELECT 																								';
  strSQL := strSQL + '								PRO_CODPRO,                                         ';
  strSQL := strSQL + '								PRO_DESPRO,                                         ';
  strSQL := strSQL + '								IPR_CODITE,                                         ';
  strSQL := strSQL + '								IPR_CODEMP,                                         ';
  strSQL := strSQL + '								IPR_PREVEN,                                         ';
  strSQL := strSQL + '								IPR_PREVE2,                                         ';
  strSQL := strSQL + '								IPR_PREVE3,                                         ';
  strSQL := strSQL + '								IPR_PREVE4,                                         ';
  strSQL := strSQL + '								IPR_PREVE5,                                         ';
  strSQL := strSQL + '								IPR_PREVE6,                                         ';
  strSQL := strSQL + '								IPR_PREVE7                                          ';
  strSQL := strSQL + '							FROM CADPRO C                                         ';
  strSQL := strSQL + '							INNER JOIN ITEPRO I ON I.IPR_SEQGER = C.AUTOINCREM    ';
  strSQL := strSQL + '							INNER JOIN PROEMP P ON P.PRO_SEQGER = C.AUTOINCREM    ';
  strSQL := strSQL + '							                   AND P.PRO_CODEMP = :CODEMP         ';
  strSQL := strSQL + '							WHERE TRUE                                            ';
  strSQL := strSQL + '								AND CURRENT_DATE BETWEEN PRO_DTAINI AND PRO_DTAFIN  ';
  strSQL := strSQL + '								AND PRO_PREDES IN ("D","P")                         ';
  strSQL := strSQL + '						) AS PRO ON PRO.IPR_CODITE = G.ITE_CODITE               ';

  if (blnRetornaAgregados or blnSetaCodAgregados) then
    strSQL := strSQL + '  LEFT JOIN CADAGR ON AGR_CODITE = I.ITE_CODITE ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE ';

  if blnSetaCodAgregados then
  begin
    strSQL := strSQL + ' AND AGR_CODAGR IS NOT NULL ';
    strSQL := strSQL + ' AND AGR_ITEPAI = "S" ';
  end;

  if blnRetornaAgregados then
  begin
    strSQL := strSQL + ' AND LOCATE(AGR_CODAGR, @CODAGR) > 0 ';
    strSQL := strSQL + ' AND AGR_ITEPAI = "N" ';
  end;

  Case rdgExibirItens.ItemIndex of
    1: strSQL := strSQL + ' AND I.ITE_ITEATI = "S" ';
    2: strSQL := strSQL + ' AND I.ITE_ITEATI = "N" ';
  End;

  Case rdgImpLis.ItemIndex of
    0: strSQL := strSQL + ' AND G.ITE_IMPLIS = "S" ';
    1: strSQL := strSQL + ' AND G.ITE_IMPLIS = "N" ';
  End;

  Case rdgAtivoCompras.ItemIndex of
    0: strSQL := strSQL + ' AND I.ITE_ATICOM = "S" ';
    1: strSQL := strSQL + ' AND I.ITE_ATICOM = "N" ';
  End;

  Case rdgSaldoProduto.ItemIndex of
    1: strSQL := strSQL + ' AND (fRetSaldo(G.ITE_CODITE, G.ITE_CODEMP, ' + QuotedStr(VS_strCodEmp) + ') - fRetSaldoReservado(G.ITE_CODITE, G.ITE_CODEMP)) > 0 ';
    2: strSQL := strSQL + ' AND (fRetSaldo(G.ITE_CODITE, G.ITE_CODEMP, ' + QuotedStr(VS_strCodEmp) + ') - fRetSaldoReservado(G.ITE_CODITE, G.ITE_CODEMP)) < 0 ';
    3: strSQL := strSQL + ' AND (fRetSaldo(G.ITE_CODITE, G.ITE_CODEMP, ' + QuotedStr(VS_strCodEmp) + ') - fRetSaldoReservado(G.ITE_CODITE, G.ITE_CODEMP)) = 0 ';
  End;

  If chkConsiderarPromocao.Checked Then
    strSQL := strSQL + fStrLocate(edtPromoc,arrPromoc,'PRO.PRO_CODPRO','CODPRO');

  If rdgPromocao.ItemIndex = 0 Then
    strSQL := strSQL + ' AND PRO.PRO_CODPRO IS NOT NULL ';

  if not blnRetornaAgregados then
    strSql := strSQL + fStrLocate(edtProdutos, arrProdut, 'I.ITE_CODITE','CODITE');

  strSql := strSQL + fStrLocate(edtCodDep, arrDepart, 'I.ITE_CODDEP','CODDEP');
  strSql := strSQL + fStrLocateLinGru(mskLinhaGrupo, arrLinGru, 'I.ITE_CODGRU','CODGRU');
  strSql := strSQL + fStrLocate(edtFornecedor, arrFornec,'I.ITE_CODFOR','CODFOR');
  strSql := strSQL + fStrLocate(edtMarca,arrMarca,'I.ITE_CODMAR','CODMAR');
  strSql := strSQL + fStrLocate(edtUnidade,arrUnidad,'I.ITE_CODUNI','CODUNI');
  strSql := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa,'G.ITE_CODEMP','CODEMP');

  If Not fEmptyStr(edtDescri.Text) Then
  Begin
    strSQL := strSQL + '  AND I.ITE_DESITE LIKE ' + '''' + edtDescri.Text + '%'' ';
  End;

  If Not fEmptyStr(edtRefere.Text) Then
  Begin
    strSQL := strSQL + '  AND I.ITE_REFERE = :REFERE ';
  End;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) And Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) Then
  Begin
    strSQL := strSQL + '  AND I.ITE_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
  End;

  If (chkExbVeiculo.Checked) And ((Not fEmptyStr(edtMarVei.Text)) Or (Not fEmptyStr(edtModVei.Text))) Then
  Begin
    strSQL := strSQL + ' AND IFNULL((SELECT COUNT(DM.AUTOINCREM) ';
    strSQL := strSQL + '             FROM DETMOD DM ';
    strSQL := strSQL + '               JOIN MODVEI MO ON DM.MOD_CODMOD = MO.MOD_CODMOD ';
    strSQL := strSQL + '               JOIN VEIPRO VP ON DM.AUTOINCREM = VP.VEI_CODMOD ';
    strSQL := strSQL + '             WHERE TRUE ';
    strSQL := strSQL + '               AND VP.VEI_CODITE = I.ITE_CODITE ';
    strSql := strSQL + fStrLocate(edtMarVei, arrMarVei, 'MO.MOD_CODMAR', 'MARVEI');
    strSql := strSQL + fStrLocate(edtModVei, arrModVei, 'MO.MOD_CODMOD', 'MODVEI');
    strSQL := strSQL + '), 0) > 0 ';
  End;

  if not blnSetaCodAgregados then
    strSQL := strSQL + ' GROUP BY I.ITE_CODITE ';

  if blnSetaCodAgregados then
    strSQL := strSQL + ' ) ';

  Result := strSQL;

end;

function TfrmRelCatalogoProduto.fRetOrdenacao: string;
var
  strSQL: string;
begin

  strSQL := '';
  strSQL := strSQL + ' ORDER BY ';

  if rdgOrdena.ItemIndex = 0 then
    strSQL := strSQL + '  DESDEP, DESITE '
  else if rdgOrdena.ItemIndex = 1 then
    strSQL := strSQL + '  DESITE '
  else
    strSQL := strSQL + '  DESITE DESC ';

  Result := strSQL;

end;

procedure TfrmRelCatalogoProduto.pSetaFiltros(qryComponente: TUniQuery);
begin
  pSetaParam(edtProdutos.Text, arrProdut ,strProdut, 'CODITE', qryComponente);
  pSetaParam(edtCodDep.Text, arrDepart, strDepart, 'CODDEP', qryComponente);
  pSetaParam(mskLinhaGrupo.Text, arrLinGru, strLinGru, 'CODGRU', qryComponente);
  pSetaParam(edtFornecedor.Text, arrFornec, strFornec ,'CODFOR', qryComponente);
  pSetaParam(edtMarca.Text, arrMarca, strMarca, 'CODMAR', qryComponente);
  pSetaParam(edtUnidade.Text,arrUnidad, strUnidad,'CODUNI',qryComponente);
  pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa ,'CODEMP', qryComponente);
  pSetaParam(edtMarVei.Text, arrMarVei, strMarVei, 'MARVEI', qryComponente);
  pSetaParam(edtModVei.Text, arrModVei, strModVei, 'MODVEI', qryComponente);

  If chkConsiderarPromocao.Checked Then
    pSetaParam(edtPromoc.Text, arrPromoc, strPromoc, 'CODPRO', qryComponente);

  If Not fEmptyStr(edtRefere.Text) Then
  Begin
    qryComponente.ParamByName('REFERE').AsString := edtRefere.Text;
  End;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) And Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) Then
  Begin
    qryComponente.ParamByName('DTAINI').AsDate  := StrToDate(mskDtaCadIni.Text);
    qryComponente.ParamByName('DTAFIN').AsDate  := StrToDate(mskDtaCadFin.Text);
  End;

  If fEmptyStr(edtCodEmpresa.Text) Then
    qryComponente.ParamByName('CODEMP').AsString := VS_strCodEmp;
end;

procedure TfrmRelCatalogoProduto.pSetaAgregados;
var
  qryAgregados: TUniQuery;
begin

  try
    qryAgregados := fCriaQuery(nil);
    qryAgregados.SQL.Clear;
    qryAgregados.SQL.Add(fRetornaSQL(False, True));
    pSetaFiltros(qryAgregados);
    qryAgregados.ExecSQL;
  finally
    FreeAndNil(qryAgregados);
  end;

end;

function TfrmRelCatalogoProduto.fGetCaminhoFR3: String;
begin
  Result := fCfgSis('PATETI') + '\frxCatalogoProduto.fr3';
end;

function TfrmRelCatalogoProduto.fGetCaminhoLogo: String;
begin
  Result := fCfgSis('PATETI') + '\LogoCatalogoProduto.jpg';
end;

function TfrmRelCatalogoProduto.fTemFR3: Boolean;
var
  strPathEti: String;
begin
  Result := False;
  strPathEti := fCfgSis('PATETI', varString);
  If Not fEmptyStr(strPathEti) Then
    Result := FileExists(fGetCaminhoFR3);
end;

function TfrmRelCatalogoProduto.fTemLogo: Boolean;
var
  strPathEti: String;
begin
  Result := False;
  strPathEti := fCfgSis('PATETI', varString);
  If Not fEmptyStr(strPathEti) Then
    Result := FileExists(fGetCaminhoLogo);
end;

procedure TfrmRelCatalogoProduto.pValidaImagensExternas;
var
  frxImage: TfrxPictureView;
begin
  frxImage := TfrxPictureView.Create(nil);
  try
    qryCodIte.Filtered := False;
    qryCodIte.Fields[qryCodIte.FieldByName('TEMIMG').Index].ReadOnly := False;
    if rdgImagem.ItemIndex <> 2 then
    begin
      qryCodIte.First;
      while not qryCodIte.Eof do
      begin
        qryCodIte.Edit;
        if not qryCodIte.FieldByName('IMGB64').IsNull then
          qryCodIte.FieldByName('TEMIMG').AsString := 'S'
        else
          qryCodIte.FieldByName('TEMIMG').AsString := IIF(fCarregaImagemProdutoRed(qryCodIte.FieldByName('CODITE').AsString, frxImage) = riOk, 'S', 'N');
        qryCodIte.Post;
        qryCodIte.Next;
      end;
      qryCodIte.Filter   := 'TEMIMG = ' + QuotedStr(IIF(rdgImagem.ItemIndex = 0, 'S', 'N'));
      qryCodIte.Filtered := True;
      qryCodIte.First;
    end;
  finally
    FreeAndNil(frxImage);
  end;
end;

procedure TfrmRelCatalogoProduto.btnImprimirClick(Sender: TObject);
Var
  strSQL     : String;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  pCarregaConfImpr(qryCfgRel, Self.Name);

  If edtDestino.Text = 'I' Then
    fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);

  If blnImprime Then
  Begin

    if chkAgregados.Checked then
      pSetaAgregados;

    strSQL := fRetornaSQL;

    if chkAgregados.Checked then
      strSQL := ' SELECT DISTINCT TAB.* FROM ( ' + strSQL + ' UNION ALL ' + fRetornaSQL(True) + ' ) AS TAB ';

    strSQL := strSQL + fRetOrdenacao;

    qryCodIte.Close;
    qryCodIte.SQL.Clear;
    qryCodIte.SQL.Add(strSQL);
    pSetaFiltros(qryCodIte);
    qryCodIte.Open;

    pValidaImagensExternas;

    If Not qryCodIte.IsEmpty then
    Begin

      if fTemFR3 then
      begin
        frxRelJato.LoadFromFile(fGetCaminhoFR3);
      end
      else
      begin
        frxRelJato := frxRelJato;
      end;

      If (frxRelJato.FindObject('picLogo') <> Nil) Then
      begin
        if fTemLogo then
        begin
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Picture.LoadFromFile(fGetCaminhoLogo);
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Visible := True;
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Height := 64.25201;
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Width := 136.06308;
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Left := 7.55906;
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Top := 3.77953;

          TfrxPictureView(frxRelJato.FindObject('mmEmpresa')).Top := 15;
          TfrxPictureView(frxRelJato.FindObject('mmDepartamento')).Top := 15;

          TfrxPageHeader(frxRelJato.FindObject('PageHeader1')).Height := 71.81107;
        end
        else
        begin
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Clear;
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Visible := False;
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Height := 0;
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Width := 0;
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Left := 0;
          TfrxPictureView(frxRelJato.FindObject('picLogo')).Top := 0;

          TfrxPictureView(frxRelJato.FindObject('mmEmpresa')).Top := 0;
          TfrxPictureView(frxRelJato.FindObject('mmDepartamento')).Top := 0;

          TfrxPageHeader(frxRelJato.FindObject('PageHeader1')).Height := 37.7952755905512;
        end;
      end;

      frxRelJato.DotMatrixReport           := False;
      frxRelJato.PrintOptions.PrintMode    := pmScale;
      frxRelJato.PrintOptions.PrintOnSheet := 9; //A4

      case rdgOrientacao.ItemIndex of
        0 : TfrxReportPage(frxRelJato.Pages[1]).Orientation := poLandscape;
        1 : TfrxReportPage(frxRelJato.Pages[1]).Orientation := poPortrait;
      end;

      TfrxMemoView(frxRelJato.FindObject('mmAplica')).Text := 'APLICAÇÃO';
      TfrxMemoView(frxRelJato.FindObject('mnoAplica')).Text := '[frxRelatorio."APLICA"]';

      case rdgExibir.ItemIndex of
        0 : begin
          frxRelJato.FindObject('mmAplica').Visible := True;
          frxRelJato.FindObject('mnoAplica').Visible := True;
          frxRelJato.FindObject('mmSaldos').Visible := False;
          frxRelJato.FindObject('mnoSaldos').Visible := False;
        end;
        1 : begin
          frxRelJato.FindObject('mmAplica').Visible := False;
          frxRelJato.FindObject('mnoAplica').Visible := False;
          frxRelJato.FindObject('mmSaldos').Visible := True;
          frxRelJato.FindObject('mnoSaldos').Visible := True;
        end;
        2 : begin
          frxRelJato.FindObject('mmAplica').Visible := True;
          frxRelJato.FindObject('mnoAplica').Visible := True;
          frxRelJato.FindObject('mmSaldos').Visible := True;
          frxRelJato.FindObject('mnoSaldos').Visible := True;
        end;
        3 : begin
          frxRelJato.FindObject('mmAplica').Visible := True;
          frxRelJato.FindObject('mnoAplica').Visible := True;
          TfrxMemoView(frxRelJato.FindObject('mmAplica')).Text := 'MARCA';
          TfrxMemoView(frxRelJato.FindObject('mnoAplica')).Text := '[frxRelatorio."DESMAR"]';
          frxRelJato.FindObject('mmSaldos').Visible := False;
          frxRelJato.FindObject('mnoSaldos').Visible := False;
        end;
        4 : begin
          If fCfgSis('EXBREF') = 'S' Then
          Begin
            frxRelJato.FindObject('mmAplica').Visible := True;
            frxRelJato.FindObject('mnoAplica').Visible := True;
            TfrxMemoView(frxRelJato.FindObject('mmAplica')).Text := 'REFERÊNCIA';
            TfrxMemoView(frxRelJato.FindObject('mnoAplica')).Text := '[frxRelatorio."REFERE"]';
            frxRelJato.FindObject('mmSaldos').Visible := False;
            frxRelJato.FindObject('mnoSaldos').Visible := False;
          End
          Else
          Begin
            fMensagem('ATENÇÃO', 'A configuração CFG_EXBREF está configurada como NÃO. O campo referência não será exibido', ['&Ok']);
          End;
        end;
        5 : begin
          frxRelJato.FindObject('mmAplica').Visible := True;
          frxRelJato.FindObject('mnoAplica').Visible := True;
          TfrxMemoView(frxRelJato.FindObject('mmAplica')).Text := 'CÓD.FAB';
          TfrxMemoView(frxRelJato.FindObject('mnoAplica')).Text := '[frxRelatorio."CODFAB"]';
          frxRelJato.FindObject('mmSaldos').Visible := False;
          frxRelJato.FindObject('mnoSaldos').Visible := False;
        end;
        6 : begin
          frxRelJato.FindObject('mmAplica').Visible := False;
          frxRelJato.FindObject('mnoAplica').Visible := False;
          frxRelJato.FindObject('mmSaldos').Visible := False;
          frxRelJato.FindObject('mnoSaldos').Visible := False;
        end;
      end;

      frxRelJato.FindObject('mmUnidade').Visible := chkExbUni.Checked;
      frxRelJato.FindObject('mnoUnidade').Visible := chkExbUni.Checked;

      frxRelJato.FindObject('mmEmbalagem').Visible := chkExbEmb.Checked;
      frxRelJato.FindObject('mnoEmbalagem').Visible := chkExbEmb.Checked;

      frxRelJato.FindObject('mmEmail').Visible := chkExbEmail.Checked;

      If (frxRelJato.FindObject('mmDepartamento') <> Nil) Then
      Begin
        TfrxPictureView(frxRelJato.FindObject('mmDepartamento')).Visible := rdgOrdena.ItemIndex = 0;
        TfrxPictureView(frxRelJato.FindObject('mmDepartamento')).Width   := IIF(rdgOrdena.ItemIndex = 0, 381.73238354, 0);
      End;

      //número de colunas
      TfrxReportPage(frxRelJato.Pages[1]).Columns := cbxColunas.ItemIndex +1;

      //configura cores Cabeçalho
      If (frxRelJato.FindObject('mmEmpresa') <> Nil) Then
      begin
        TfrxPictureView(frxRelJato.FindObject('mmEmpresa')).Color := shpFundoCabecalho.Brush.Color;
        TfrxPictureView(frxRelJato.FindObject('mmEmpresa')).Font.Color := shpFonteCabecalho.Brush.Color;
      end;

      If (frxRelJato.FindObject('mmDepartamento') <> Nil) Then
      begin
        TfrxPictureView(frxRelJato.FindObject('mmDepartamento')).Color := shpFundoCabecalho.Brush.Color;
        TfrxPictureView(frxRelJato.FindObject('mmDepartamento')).Font.Color := shpFonteCabecalho.Brush.Color;
      end;

      //configura cores Rodapé
      If (frxRelJato.FindObject('mmFone01') <> Nil) Then
      begin
        TfrxPictureView(frxRelJato.FindObject('mmFone01')).Color := shpFundoRodape.Brush.Color;
        TfrxPictureView(frxRelJato.FindObject('mmFone01')).Font.Color := shpFonteRodape.Brush.Color;
      end;

      If (frxRelJato.FindObject('mmEmail') <> Nil) Then
      begin
        TfrxPictureView(frxRelJato.FindObject('mmEmail')).Color := shpFundoRodape.Brush.Color;
        TfrxPictureView(frxRelJato.FindObject('mmEmail')).Font.Color := shpFonteRodape.Brush.Color;
      end;

      If (chkExiPrecos.Checked) Then
      Begin
          frxRelJato.FindObject('mmPreco').Visible := True;
          frxRelJato.FindObject('mnoPreco').Visible := True;
      End
      Else
      Begin
          frxRelJato.FindObject('mmPreco').Visible := False;
          frxRelJato.FindObject('mnoPreco').Visible := False;
      End;

      qryCodIte.First;

      TfrxChild(frxRelJato.FindObject('ChildBarras')).Visible := chkCodBar.Checked;

      If edtDestino.Text = 'V' Then
        pPreviewReport(Self.Name, Self.Caption, frxRelJato);

      If edtDestino.Text = 'I' Then
        pPrintReport(Self.Name, Self.Caption, strNomImp, frxRelJato);

    End
    Else
    Begin
      If rdgImagem.ItemIndex = 0 Then
        fMensagem('', 'Nenhum produto com foto foi encontrado !', ['&O k'])
      Else
        pTabelaVazia;
    End;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';

  fExecutaSQL('SET SESSION group_concat_max_len = 3072');

end;

procedure TfrmRelCatalogoProduto.chkConsiderarPromocaoClick(Sender: TObject);
begin
  inherited;
  rdgPromocao.Enabled := chkConsiderarPromocao.Checked;
  edtPromoc.Enabled := chkConsiderarPromocao.Checked;
end;

procedure TfrmRelCatalogoProduto.chkExbVeiculoClick(Sender: TObject);
begin
  inherited;
  edtMarVei.Enabled := chkExbVeiculo.Checked;
  edtModVei.Enabled := chkExbVeiculo.Checked;
end;

procedure TfrmRelCatalogoProduto.chkExiPrecosClick(Sender: TObject);
begin
  inherited;
  cbxTabPre.Enabled := chkExiPrecos.Checked;
end;

procedure TfrmRelCatalogoProduto.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep,edtDesDep,arrDepart,fRetDescDepartamento,nil,'do Departamento');
end;

procedure TfrmRelCatalogoProduto.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, nil, Key, arrDepart, False) Then
  Begin
    If fvalidaCampos(edtCodDep,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCatalogoProduto.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmpresa,fRetNomeEmpresa,nil,'da Empresa');
end;

procedure TfrmRelCatalogoProduto.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa,False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCatalogoProduto.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornec,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelCatalogoProduto.edtFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCatalogoProduto.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelCatalogoProduto.edtMarcaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCatalogoProduto.edtMarVeiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarVei,edtDescMarVei,arrMarVei,fRetDesMarcaVeic,nil,'da Marca do Veículo');
end;

procedure TfrmRelCatalogoProduto.edtMarVeiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcaVeiculo(Self, edtMarVei, edtDescMarVei, Nil, Key, arrMarVei, False) Then
  Begin
    If fValidaCampos(edtMarVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCatalogoProduto.edtModVeiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtModVei,edtDescModVei,arrModVei,fRetDesModeloVeic,nil,'do Modelo do Veículo');
end;

procedure TfrmRelCatalogoProduto.edtModVeiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqModeloVeiculo(Self, edtModVei, edtDescModVei, Nil, Key, arrModVei, False) Then
  Begin
    If fValidaCampos(edtModVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCatalogoProduto.edtProdutosExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtProdutos,edtDesProduto,arrProdut,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmRelCatalogoProduto.edtProdutosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, nil, Key, arrProdut, False, nil, 'Consulta de Itens', '1') Then
  Begin
    If fvalidaCampos(edtProdutos,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCatalogoProduto.edtPromocExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPromoc,edtDesPromoc,arrPromoc,nil,fRetDescPromocao,'da Promoção');
end;

procedure TfrmRelCatalogoProduto.edtPromocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPromocoes(Self, edtPromoc, edtDesPromoc, Nil, Key, arrPromoc, False) Then
  Begin
    If fValidaCampos(edtPromoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCatalogoProduto.edtUnidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtUnidade,nil,arrUnidad,fRetNomUnidade,Nil,'da Unidade');
end;

procedure TfrmRelCatalogoProduto.edtUnidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, arrUnidad, False) Then
  Begin
    If fvalidaCampos(edtUnidade,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCatalogoProduto.fSQLVeiculos: String;
var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DISTINCT VEI_CODITE AS CODITE, MAR_DESMAR AS MARVEI, MOD_DESMOD AS MODVEI ';
  strSQL := strSQL + 'FROM DETMOD ';
  strSQL := strSQL + '  INNER JOIN MODVEI ON MODVEI.MOD_CODMOD = DETMOD.MOD_CODMOD ';
  strSQL := strSQL + '  INNER JOIN VEIPRO ON VEIPRO.VEI_CODMOD = DETMOD.AUTOINCREM ';
  strSQL := strSQL + '  INNER JOIN MARVEI ON MAR_CODMAR = MOD_CODMAR ';
  strSQL := strSQL + 'WHERE VEI_CODITE = :CODITE ';

  Result := strSQL;
End;

procedure TfrmRelCatalogoProduto.FormCreate(Sender: TObject);
var
  qryEmp  : TUniQuery;
begin
  inherited;
  pSetaCodIte(edtProdutos);
  qryDepartamento := fCriaQuery(Self);
  qryCodIte  := fCriaQuery(Self);
  qryVeiculos:= fCriaQuery(Self);

  qryVeiculos.Close;
  qryVeiculos.SQL.Clear;
  qryVeiculos.SQL.Add(fSQLVeiculos);

  dtsVeiculos.DataSet := qryVeiculos;

  frxRelatorio.DataSet := qryCodIte ;
  dtsDepartamento.DataSet := qryDepartamento;
  frxRelJato.AddFunction('procedure pCarregaImagemProduto(strCodIte: String);');
  frxRelJato.AddFunction('procedure pCarregaImagemProdutoRed(strCodIte: String);');
  frxRelJato.AddFunction('function fRetornaSaldoDisponivel(strCodIte: String): Double;');
  frxRelJato.AddFunction('function fRetornaLeftImagem: Double;');
  frxRelJato.AddFunction('function fRetornaWidthImagem: Double;');
  frxRelJato.AddFunction('function fTemVeiculo(strCodIte: String): Boolean;');
  frxRelJato.AddFunction('function fQuantVeiculo(strCodIte: String): Double;');
  frxRelJato.AddFunction('function fExibeCodBar: Boolean;');
  strEmpFone01 := '';
  strEmpEmail  := '';

  qryEmp := fCriaQuery(nil);
  try

    qryEmp.SQL.Add('SELECT                  ');
    qryEmp.SQL.Add('  EMP_FONE01,           ');
    qryEmp.SQL.Add('  EMP_EMAIL_            ');
    qryEmp.SQL.Add('FROM                    ');
    qryEmp.SQL.Add('  CADEMP                ');
    qryEmp.SQL.Add('WHERE                   ');
    qryEmp.SQL.Add('  EMP_CODEMP = :CODEMP  ');
    qryEmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryEmp.Open;

    if not qryEmp.isEmpty then
    begin
      strEmpFone01 := qryEmp.FieldByName('EMP_FONE01').AsString;
      strEmpEmail  := qryEmp.FieldByName('EMP_EMAIL_').AsString;
    end;


  finally
    if Assigned(qryEmp) then
    begin
      qryEmp.Close;
      FreeAndNil(qryEmp);
    end;
  end;
  pSetaCodIte(edtProdutos);
end;

procedure TfrmRelCatalogoProduto.FormShow(Sender: TObject);
Var
  intIndex: Integer;
begin
  inherited;

  For intIndex := 1 To Length(VS_strTabPrc) Do
    if VS_strTabPrc[intIndex] = 'S' Then
      cbxTabPre.Items.Add('Tabela ' + IntToStr(intIndex));

  cbxTabPre.ItemIndex := 0;

  If fCfgSis('IDSORC', varBoolean) Then
    rdgDescricao.ItemIndex := 1
  Else
    rdgDescricao.ItemIndex := 0;
end;

function TfrmRelCatalogoProduto.fTabPreco: String;
begin
  Result := RightStr(cbxTabPre.Text,1);
end;

procedure TfrmRelCatalogoProduto.frxGenGetValue(const VarName: string;
  var Value: Variant);
begin
  inherited;
  If VarName = 'EMP_FONE01' Then
  begin
    if not fEmptyStr(strEmpFone01) then
      Value := 'Telefone: ' + fFormataFone(strEmpFone01)
    else
      Value := '';
  end;

  If VarName = 'EMP_EMAIL' Then
  begin
    if not fEmptyStr(strEmpEmail) then
      Value := 'Email: ' + strEmpEmail
    else
      Value := '';
  end;

end;

function TfrmRelCatalogoProduto.Split(const strTexto: string; chrDelimitador : Char): TStringList;
begin
  Result := TStringList.Create;
  Result.Delimiter := chrDelimitador;
  Result.StrictDelimiter := True;
  Result.DelimitedText := strTexto;
end;

function TfrmRelCatalogoProduto.fRetornaSaldoDisponivelEmpresas(strCodIte: string): Double;
var
  dblTotSalDis: Double;
  intEmpresas: Integer;
  sltEmpAcesso: TStringList;
begin

  dblTotSalDis := 0;

  if (Length(edtCodEmpresa.Text) = 3) and (edtCodEmpresa.Text <> '000') then
    dblTotSalDis := fRetornaSaldoDisponivel(strCodIte, False, True, '', True, edtCodEmpresa.Text)
  else
  begin
    if fEmptyStr(edtCodEmpresa.Text) then
    begin
      try
        sltEmpAcesso := Split(Trim(strEmpAcessoUsuarioLogado), '_');
        for intEmpresas := 0 to sltEmpAcesso.Count - 1 do
        begin
          if not fEmptyStr(sltEmpAcesso[intEmpresas]) then
            dblTotSalDis := dblTotSalDis + fRetornaSaldoDisponivel(strCodIte, False, True, '', True, sltEmpAcesso[intEmpresas])
        end;
      finally
        FreeAndNil(sltEmpAcesso);
      end;
    end
    else
    begin
      for intEmpresas := Low(arrEmpresa) to High(arrEmpresa) do
        dblTotSalDis := dblTotSalDis + fRetornaSaldoDisponivel(strCodIte, False, True, '', True, arrEmpresa[intEmpresas].strCodigo);
    end;
  end;

  Result := dblTotSalDis;
end;

function TfrmRelCatalogoProduto.fRetornaLeftImagem: Double;
var
  fltValor: Double;
begin
  fltValor := 0;
  if rdgOrientacao.ItemIndex = 0 then
  begin
    case cbxColunas.ItemIndex of
      0: fltValor := 345.99234628;
      1: fltValor := 120.94495756;
      2: fltValor := 42.07088628;
      3: fltValor := 17.39370628;
      4: fltValor := 9.83464628;
    end;
  end
  else
  begin
    case cbxColunas.ItemIndex of
      0: fltValor := 191.81114628;
      1: fltValor := 25.51182628;
      2: fltValor := 14.17323628;
      3: fltValor := 6.61417628;
      4: fltValor := 6.61417628;
    end;
  end;
  Result := fltValor;
end;

function TfrmRelCatalogoProduto.fRetornaWidthImagem: Double;
var
  fltValor: Double;
begin
  fltValor := 0;
  if rdgOrientacao.ItemIndex = 0 then
  begin
    case cbxColunas.ItemIndex of
      0: fltValor := 391.18135744;
      1: fltValor := 285.35451744;
      2: fltValor := 277.79545744;
      3: fltValor := 236.22062744;
      4: fltValor := 198.42532744;
    end;
  end
  else
  begin
    case cbxColunas.ItemIndex of
      0: fltValor := 372.28370744;
      1: fltValor := 326.92934744;
      2: fltValor := 224.88203744;
      3: fltValor := 175.74814744;
      4: fltValor := 137.95284744;
    end;
  end;
  Result := fltValor;
end;

function TfrmRelCatalogoProduto.fTemVeiculo(strCodIte: String): Boolean;
begin
  Result := chkExbVeiculo.Checked;

  If Result Then
  Begin
    qryVeiculos.Close;
    qryVeiculos.ParamByName('CODITE').AsString := strCodIte;
    qryVeiculos.Open;
    Result := Not qryVeiculos.IsEmpty;
  End;
end;

function TfrmRelCatalogoProduto.fQuantVeiculo(strCodIte: String): Double;
begin
  If Not chkExbVeiculo.Checked Then
    Result := 0
  Else
  Begin
    qryVeiculos.Close;
    qryVeiculos.ParamByName('CODITE').AsString := strCodIte;
    qryVeiculos.Open;
    Result := qryVeiculos.RecordCount;
  End;
end;

function TfrmRelCatalogoProduto.frxRelJatoUserFunction(const MethodName: string; var Params: Variant): Variant;
begin

  inherited;
  If MethodName = 'PCARREGAIMAGEMPRODUTO' Then
  Begin
    if not (fCarregaImagemProduto(Params[0], TfrxPictureView(frxRelJato.FindObject('picCodIte'))) = riOk) then
      TfrxPictureView(frxRelJato.FindObject('picCodIte')).Picture := nil;
  End
  Else If MethodName = 'PCARREGAIMAGEMPRODUTORED' Then
  Begin
    if not (fCarregaImagemProdutoRed(Params[0], TfrxPictureView(frxRelJato.FindObject('picCodIte'))) = riOk) then
      TfrxPictureView(frxRelJato.FindObject('picCodIte')).Picture := nil;
  End
  Else If SameText(MethodName, 'FRETORNASALDODISPONIVEL') Then
    Result := fRetornaSaldoDisponivelEmpresas(Params[0])
  Else If SameText(MethodName, 'FRETORNALEFTIMAGEM') Then
    Result := fRetornaLeftImagem
  Else If SameText(MethodName, 'FRETORNAWIDTHIMAGEM') Then
    Result := fRetornaWidthImagem
  Else If SameText(MethodName, 'FTEMVEICULO') Then
    Result := fTemVeiculo(Params[0])
  Else If SameText(MethodName, 'FQUANTVEICULO') Then
    Result := fQuantVeiculo(Params[0])
  Else If SameText(MethodName, 'FEXIBECODBAR') Then
    Result := chkCodBar.Checked;

end;


procedure TfrmRelCatalogoProduto.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo, edtDesGrupo, arrLinGru, fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelCatalogoProduto.mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    If fvalidaCampos(mskLinhaGrupo,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

end.
