
{*********************************************************}
{* RELATÓRIO DE FATURAMENTO: EVOLUÇÃO DE VENDAS          *}
{*                                                       *}
{* DATA......: 06/09/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "TO CONGELANDO!!"*}
{*                                                       *}
{******************************************************AF*}
unit untRelFatEvolVendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, DateUtils,
  StrUtils, RLReport, RLTypes, ComObj, untTypesSistema, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  Uni, AppEvnts, UniDataSetProvider, DB, UniClientDataSet, ComCtrls, untGeraExcel,
  BitBtnLockedIncrem, untExcel, ComboBoxFocus, Provider, frxExportCSVTestabilidade,
  untIFuncoes, untIZClient, Datasnap.DBClient;

type
  TfrmRelFatEvolVendas = class(TfrmPaiRelatorio)
    Label1: TLabel;
    mskMesBas: TMaskEditFocus;
    Label2: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label12: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    Label3: TLabel;
    edtCodRepresentante: TEditFocus;
    edtDesRepresentante: TEditFocus;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label4: TLabel;
    edtCodCidade: TEditFocus;
    edtDesCidade: TEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label5: TLabel;
    edtQtdMes: TEditFocus;
    Label6: TLabel;
    lblQtdMes: TColorLabel;
    gpbOpcao2: TGroupBox;
    lblOpcao2: TColorLabel;
    edtOpcao2: TEditFocus;
    edtEstado: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    edtCodProduto: TEditFocus;
    edtDesProduto: TEditFocus;
    edtDesUnidade: TEditFocus;
    edtCodUnidade: TEditFocus;
    Label11: TLabel;
    svdExcel: TSaveDialog;
    gpbFiltro: TGroupBox;
    edtNumCli: TEditFocus;
    chkCurva: TCheckBox;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    gpbOpcao: TGroupBox;
    ColorLabel3: TColorLabel;
    ColorLabel2: TColorLabel;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    ColorLabel6: TColorLabel;
    ColorLabel7: TColorLabel;
    ColorLabel8: TColorLabel;
    Label13: TLabel;
    edtOpcao: TEditFocus;
    gpbVendedor: TGroupBox;
    lblVendedor: TColorLabel;
    edtVendedor: TEditFocus;
    lstClaFis: TMemo;
    Label14: TLabel;
    edtCodMarca: TEditFocus;
    edtNomMarca: TEditFocus;
    ColorLabel9: TColorLabel;
    GroupBox1: TGroupBox;
    rdbAtivos: TRadioButton;
    rdbInativo: TRadioButton;
    rdbTodos: TRadioButton;
    shpVen: TShape;
    shpRep: TShape;
    ColorLabel11: TColorLabel;
    ColorLabel12: TColorLabel;
    ColorLabel13: TColorLabel;
    gpbEmpresa: TGroupBox;
    ColorLabel10: TColorLabel;
    edtEmpFat: TEditFocus;
    ColorLabel14: TColorLabel;
    ColorLabel15: TColorLabel;
    cdsVendas: TUniClientDataSet;
    dspVendas: TUniDataSetProvider;
    pgbProgresso: TProgressBar;
    ColorLabel16: TColorLabel;
    ColorLabel17: TColorLabel;
    Label15: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    ColorLabel18: TColorLabel;
    ColorLabel19: TColorLabel;
    ColorLabel20: TColorLabel;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    Label16: TLabel;
    ColorLabel21: TColorLabel;
    lbl1: TLabel;
    edtCodProfis: TEditFocus;
    edtNomProfis: TEditFocus;
    ColorLabel22: TColorLabel;
    ColorLabel23: TColorLabel;
    Label17: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    Label18: TLabel;
    edtDesIni: TEditFocus;
    edtDesFin: TEditFocus;
    Label19: TLabel;
    chkRefPro: TCheckBox;
    lbl2: TLabel;
    lbl3: TLabel;
    edtCodSub: TEditFocus;
    edtDesSub: TEditFocus;
    lbl4: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    chkCliMov: TCheckBox;
    ColorLabel24: TColorLabel;
    ColorLabel25: TColorLabel;
    edtDepIte: TEditFocus;
    Label20: TLabel;
    edtDesDepIte: TEditFocus;
    Label21: TLabel;
    cbbCategoria: TComboBoxFocus;
    ColorLabel26: TColorLabel;
    ColorLabel27: TColorLabel;
    chkMarPro: TCheckBox;
    Label22: TLabel;
    edtCodCidExc: TEditFocus;
    edtDesCidExc: TEditFocus;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    Label23: TLabel;
    Label24: TLabel;
    mskLinhaGrupoExcluir: TMaskEditFocus;
    edtDesGrupoExcluir: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepresentanteExit(Sender: TObject);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodCidadeExit(Sender: TObject);
    procedure edtCodCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodUnidadeExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtOpcaoChange(Sender: TObject);
    procedure chkCurvaClick(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarcaExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProfisKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure chkRefProClick(Sender: TObject);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodSubExit(Sender: TObject);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure chkCliMovClick(Sender: TObject);
    procedure edtDepIteExit(Sender: TObject);
    procedure edtDepIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure chkMarProClick(Sender: TObject);
    procedure edtCodCidExcExit(Sender: TObject);
    procedure edtCodCidExcKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoEnter(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure mskLinhaGrupoExcluirExit(Sender: TObject);
    procedure mskLinhaGrupoExcluirKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    arrDatas      : Array [0..11] Of String[7];
    arrDatasExcel : Array [0..198] Of String[7];
    blnLiberado: Boolean;
    strCodVen    : String;
    strCodRep    : String;
    strOpcQue : String;
    strDesAnt : String;
    QryRelatorio : TUniQuery;

    Procedure pCamposLocate(Var strLocate: String; Var KeyValues: Variant);
    procedure pAtualizaClaFis;
    procedure pGeraExcel(qryDados: TDataSet);
    procedure pSomaTotais(Var Totais: TTotais; Dados: TDataSet);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pVerdeVermelho(edtCodigo: TEditFocus; Shape: TShape);
    procedure pIncluiNoClient;
    procedure pVerificaQtdMes;
    procedure pHabilitaOpcoesQuebra(Sender: TObject);
    procedure pSqlCliSemMovimento;
    function fRetColunasData(blnCriarTodasColunasZeradas: Boolean=False): String;

    function fSqlGroupBy: String;
    procedure pSetarIndiceClientVendas;
    function fGetNroColunas: Integer;
  public
    { Public declarations }
    arrLinhaGrupo: TConsultasArray;
    arrLinhaRepre: TConsultasArray;
    arrLinhaClien: TConsultasArray;
    arrLinhaVende: TConsultasArray;
    arrLinhaForne: TConsultasArray;
    arrLinhaMarca: TConsultasArray;
    arrLinhaCidad: TConsultasArray;
    arrGruCmp:     TConsultasArray;

    arrLinhaGrupoExc: TConsultasArray;

    arrProduto   : TConsultasArray;
    arrUnidade   : TConsultasArray;
    arrLinAti    : TConsultasArray;
    arrRedeLojas : TConsultasArray;
    arrProfis    : TConsultasArray;
    arrRegiao    : TConsultasArray;
    arrSubReg    : TConsultasArray;
    arrDepart    : TConsultasArray;
    arrEmpresa   : TConsultasArray;
    arrDepIte    : TConsultasArray;
    arrCidExc    : TConsultasArray;

    intLimCol    : Integer;
    strQtdMes    : String;
    cdsClientes  : IZClient;

    strLinGru  : String;
    strLinGruExc: String;
    strLinRep  : String;
    strLinCli  : String;
    strLinVen  : String;
    strLinFor  : String;
    strLinMar  : String;
    strLinCid  : String;
    strLinPro  : String;
    strLinUni  : String;
    strLinAti  : String;
    strRedLojas: String;
    strProfis  : String;
    strRegiao  : String;
    strEmpresa : String;
    strSubReg  : String;
    strDepIte  : String;
    strDepart  : String;
    strCidExc  : String;
    strGruCmp  : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  end;

var
  frmRelFatEvolVendas: TfrmRelFatEvolVendas;

implementation

uses untQckFatEvolVendas, untConstantes, untFuncoesFactory,
  untQckFatEvolVendasPaisagem, AnsiStrings, untClassPanelCx;

{$R *.dfm}

procedure TfrmRelFatEvolVendas.FormShow(Sender: TObject);
begin

  QryRelatorio := fCriaQuery(Self);

  frxRelatorio.DataSet := QryRelatorio;
  dspVendas.DataSet := QryRelatorio;

  blnLiberado := fVerificaAcessoSistema('REVOVE');

  strDesAnt := '';

  strCodRep := '';
  strCodVen := '';

  pVerdeVermelho(edtCodVendedor, shpVen);
  pVerdeVermelho(edtCodRepresentante, shpRep);

  mskMesBas.Text := FormatDateTime('mm/yyyy', VS_Date);

  If Not fCfgSis('USATMQ', varBoolean) Then
  Begin
    lblOpcao2.Caption := '(Q)uantidade (V)alor';
  End Else
  Begin
    If SameText(fCfgSis('LITGAL'), 'L') Then
      lblOpcao2.Caption := '(L)itros/Kilos (Q)uantidade (V)alor'
    Else
      lblOpcao2.Caption := '(G)alonag. (Q)uantidade (V)alor';
  End;

  edtOpcaoChange(Sender);

  {***********************************}
  {* EXIBE O SHAPE Q IDENTIFICA SE O *}
  {* RELATÓRIO POSSUI CONSULTAS COM  *}
  {* MULTISELEÇÃO                    *}
  {***08/02/2008*******************ER*}
  shpMultSel.Visible := True;

  If Not fCfgSis('REPVEN', varBoolean) Then
  Begin
    edtVendedor.Text := '1';
    edtVendedor.Enabled := False;
  End;

  inherited;
end;

{**************************************}
{* ATUALIZA LIST DE CLASSIFICAÇÕES    *}
{***********************************AF*}
procedure TfrmRelFatEvolVendas.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin

  strClaFis := VS_strClaVen + VS_strClaDev;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;

End;

procedure TfrmRelFatEvolVendas.FormCreate(Sender: TObject);
begin
  inherited;
  strOpcQue := '01_02_03_04_05_06_07_08_09_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25';
  pSetaCodIte(edtCodProduto);
  pAtualizaClaFis;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  chkRefPro.Checked  := False;
  chkMarPro.Checked  := False;

  strQtdMes := '7';

  pPreencheCombo(TCustomComboBox(cbbCategoria), arrCtgCli);
end;

procedure TfrmRelFatEvolVendas.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(QryRelatorio) Then
    FreeAndNil(QryRelatorio);
end;

procedure TfrmRelFatEvolVendas.FormResize(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmRelFatEvolVendas.mskLinhaGrupoExcluirExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupoExcluir,edtDesGrupoExcluir,arrLinhaGrupoExc,fRetNomeLinhaGrupo,Nil,'da linha/grupo a excluir',6);

  If (Length(arrLinhaGrupoExc) <= 0) Then
    edtDesGrupoExcluir.Text := 'NENHUM';
end;

procedure TfrmRelFatEvolVendas.mskLinhaGrupoExcluirKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupoExcluir, edtDesGrupoExcluir, Nil, Key, arrLinhaGrupoExc, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupoExcluir, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatEvolVendas.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelFatEvolVendas.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendas.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,
                    arrLinhaForne,fRetNomFornecedor,nil,'do Fornecedor');

end;

procedure TfrmRelFatEvolVendas.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrLinhaForne, False) Then
  Begin
    If fValidaCampos(edtFornecedor, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendas.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmRelFatEvolVendas.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatEvolVendas.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed,edtDesRed,arrRedeLojas, Nil, fRetNomeRedeLoja, 'da Rede Lojas');
end;

procedure TfrmRelFatEvolVendas.edtCodRedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRedeLojas, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendas.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg,edtDesReg,arrRegiao,fRetDesReg, nil, 'da Região');
end;

procedure TfrmRelFatEvolVendas.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE REGIOES *}
  {*************************DP*}
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao, False) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendas.edtCodRepresentanteExit(Sender: TObject);
begin
  inherited;

  If blnLiberado Then
    pEdtCodSelectExit(edtCodRepresentante,edtDesRepresentante,arrLinhaRepre,fRetNomVendRep,nil,'do Representante');
end;

procedure TfrmRelFatEvolVendas.edtCodRepresentanteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fEntraCons(Key) then
  begin
    If (blnLiberado) And (fPesqOperador(self, edtCodRepresentante, edtDesRepresentante, nil, Key, arrLinhaRepre, False)) then
    Begin
      If fValidaCampos(edtCodRepresentante, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmRelFatEvolVendas.edtCodSubExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSub, edtDesSub, arrSubReg, fRetDesSubReg, nil, 'da Sub-Região');
end;

procedure TfrmRelFatEvolVendas.edtCodSubKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqSubRegiao(Self, edtCodSub, edtDesSub, Nil, Key, arrSubReg, False) Then
  Begin
    if fValidaCampos(edtCodSub, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatEvolVendas.edtCodVendedorExit(Sender: TObject);
begin
  inherited;

  If blnLiberado Then
    pEdtCodSelectExit(edtCodVendedor,edtDesVendedor,arrLinhaVende,fRetNomVendRep,nil,'do Vendedor');
end;

procedure TfrmRelFatEvolVendas.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fEntraCons(Key) then
  begin
    If (blnLiberado) And (fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrLinhaVende, False)) then
    Begin
      If fValidaCampos(edtCodVendedor, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  end;
end;

function TfrmRelFatEvolVendas.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    strMsg : String;
    intIndex : Integer;
begin

  Result := True;

  {*******************}
  {* VALIDA MÊS BASE *}
  {****************AF*}
  If (Sender = mskMesBas) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskMesBas.Text)) Then
    Begin
      fMensagem('','O mês base deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin

      If Not IsValidDate(StrToInt(Trim(RightStr(mskMesBas.Text,4))), StrToInt(LeftStr(Trim(mskMesBas.Text),2)), 01) Then
      Begin
        fMensagem('','O mês base digitado não é valido!',['&OK']);
        Result := False;
      End

    End;

  End

  Else If (Sender = edtVendedor) Then
  Begin

    if fCfgSis('REPVEN', varBoolean) Then
    Begin
      If Pos(edtVendedor.Text,'12') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo opção de vendedor deve ser 1 ou 2!',['&O K']);
        Result := False;
      End;
    End;

  End

  {******************************}
  {* VALIDA VENDEDOR            *}
  {***************************LA*}
  Else If (Sender = edtCodVendedor) Then
  Begin

    If blnLiberado Then
    Begin
      strCodVen := edtCodVendedor.Text;
    End

    Else If Not fEmptyStr(edtCodVendedor.Text) Then
    Begin
      strCodVen := fRetCodVendedor(edtCodVendedor.Text);

      If Not fEmptyStr(strCodVen) Then
        edtDesVendedor.Text := fRetNomVendRep(strCodVen)
      Else
      Begin
        Result := False;
        fMensagem('','Vendedor não encontrado.', ['&O K']);
      End;

    End Else
    Begin
      edtDesVendedor.Text := 'TODOS';
      strCodVen := '';
    End;

  End
  {******************************}
  {* VALIDA REPRESENTANTE       *}
  {***************************LA*}
  Else If (Sender = edtCodRepresentante) Then
  Begin

    If blnLiberado Then
    Begin
      strCodRep := edtCodRepresentante.Text;
    End

    Else If Not fEmptyStr(edtCodRepresentante.Text) Then
    Begin
      strCodRep := fRetCodVendedor(edtCodRepresentante.Text);

      If Not fEmptyStr(strCodRep) Then
        edtDesRepresentante.Text := fRetNomVendRep(strCodRep)
      Else
      Begin
        Result := False;
        fMensagem('','Representante não encontrado.', ['&O K']);
      End;

    End Else
    Begin
      edtDesRepresentante.Text := 'TODOS';
      strCodRep := '';
    End;

  End
  {******************************}
  {* VALIDA FORNECEDOR          *}
  {***************************LA*}
  Else If (Sender = edtFornecedor) Then
  Begin
    pDesmarcaLista(edtFornecedor,arrLinhaForne);
  End
  {******************************}
  {* VALIDA MARCA               *}
  {***************************LA*}
  Else If (Sender = edtCodMarca) Then
  Begin
    pDesmarcaLista(edtCodMarca,arrLinhaMarca);
  End

  {Else If (Sender = edtCodAti) Then
  Begin
    If Not fEmptyStr(edtCodAti.Text) Then
    Begin
      edtDesAti.Text := fRetNomAtividade(edtCodAti.Text);
      If fEmptyStr(edtDesAti.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta Atividade não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      edtDesAti.Text := 'TODAS';
    End;
  End}

  {********************************}
  {* VALIDA O CÓD. DO PROFISSIONAL*}
  {*****************************RV*}
  Else If (Sender = edtCodProfis) Then
  Begin
    If edtNomProfis.Text <> '+1' Then
      If Not fEmptyStr(edtCodProfis.Text) Then
      Begin
        edtNomProfis.Text := fRetNomProfissional(edtCodProfis.Text);
        If fEmptyStr(edtNomProfis.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Profissional não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomProfis.Text := 'TODOS';
      End;
  End

  {**********************}
  {* VALIDA LINHA GRUPO *}
  {*******************LA*}
  Else  If (Sender = mskLinhaGrupo) Then
  Begin
    pDesmarcaLista(mskLinhaGrupo,arrLinhaGrupo,'',6);
  End

  {**********************}
  {* VALIDA LINHA GRUPO *}
  {*******************TS*}
  Else  If (Sender = mskLinhaGrupoExcluir) Then
  Begin
    pDesmarcaLista(mskLinhaGrupoExcluir,arrLinhaGrupoExc,'',6);
  End

  Else If (Sender = edtCodSub) Then
  Begin
    pDesmarcaLista(edtCodSub, arrSubReg);
  End

  Else If (Sender = edtCodDep) Then
  Begin
    pDesmarcaLista(edtCodDep, arrDepart);
  End

  {******************************}
  {* VALIDA PRODUTO              *}
  {***************************LA*}
  Else If (Sender = edtCodProduto) Then
  Begin
    pDesmarcaLista(edtCodProduto,arrProduto);
  End
  {******************************}
  {* VALIDA UNIDADE             *}
  {***************************LA*}
  Else If (Sender = edtCodUnidade) Then
  Begin
    pDesmarcaLista(edtCodUnidade,arrUnidade,'',edtCodUnidade.MaxLength);
  End
  {*****************}
  {* VALIDA QTDMES *}
  {**************AF*}
  Else If (Sender = edtQtdMes) Then
  Begin

    If fEmptyStr(edtQtdMes.Text) Then
    Begin
      fMensagem('','A quantidade de meses deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin

      If (StrToInt(edtQtdMes.Text) > StrToInt(strQtdMes)) Or (StrToInt(edtQtdMes.Text) < 1) Then
      Begin
        fMensagem('','A quantidade de meses deve ser de 1 a ' + strQtdMes + '!',['&OK']);
        Result := False;
      End;

    End;

  End

  {****************}
  {* VALIDA OPÇÃO *}
  {*************AF*}
  Else If (Sender = edtOpcao) Then
  Begin

    If fEmptyStr(edtOpcao.Text) Then
    Begin
      fMensagem('','A Opção de quebra deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin
      If Pos(fStrZero(edtOpcao.Text,2),strOpcQue) <= 0 Then
      Begin
        if (chkRefPro.Checked) Or (chkMarPro.Checked) then
          strMsg := '06, 12, 21 e 23!'
        Else if chkCliMov.Checked then
          strMsg := '01 e 05!'
        Else
          strMsg := '01 e 25!';

        fMensagem('','A Opção de quebra deve ser um número entre ' + strMsg,['&OK']);
        Result := False;
      End
      Else
      Begin
        pVerificaQtdMes;
      End;
    End;

  End

  {*****************}
  {* VALIDA OPÇÃO2 *}
  {**************AF*}
  Else If (Sender = edtOpcao2) Then
  Begin

    If fEmptyStr(edtOpcao2.Text) Then
    Begin
      fMensagem('','A Opção deve ser preenchida!',['&OK']);
      Result := False;
    End
    Else
    Begin

      If fCfgSis('USATMQ', varBoolean) Then
      Begin

        If SameText(fCfgSis('LITGAL'), 'L') Then
        Begin
          If Pos(edtOpcao2.Text,'L_Q_V_') <= 0 Then
          Begin
            fMensagem('','A Opção deve ser L, Q ou V!',['&OK']);
            Result := False;
          End;
        End Else
        Begin
          If Pos(edtOpcao2.Text,'G_Q_V_') <= 0 Then
          Begin
            fMensagem('','A Opção deve ser G, Q ou V!',['&OK']);
            Result := False;
          End;
        End;

      End
      Else
      Begin

        If Pos(edtOpcao2.Text,'Q_V_') <= 0 Then
        Begin
          fMensagem('','A Opção deve ser Q ou V!',['&OK']);
          Result := False;
        End;

      End;

    End;

  End
  Else If (Sender = edtDestino) Then
  Begin

    If fEmptyStr(edtDestino.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (edtDestino.Text <> 'V') And
            (edtDestino.Text <> 'I') And
            (edtDestino.Text <> 'E') Then
    Begin
      Result := False;
    End
    Else
    Begin
      pVerificaQtdMes;
    End;

  End

  Else If (Sender = edtEmpFat) Then
  Begin

    If Pos(edtEmpFat.Text,'FP') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!','O campo (empresa do...) deve ser F ou P!',['&O K']);
      Result := False;
    End;

  End

  Else If (Sender = edtCodEmp) Then
  Begin
    pDesmarcaLista(edtCodEmp, arrEmpresa);

    If High(arrEmpresa) >= 0 Then
    Begin
      For intIndex := 0 To High(arrEmpresa) Do
      Begin
        If Not fEmptyStr(arrEmpresa[intIndex].strCodigo) Then
        Begin
          If Pos(arrEmpresa[intIndex].strCodigo, QuotedStr(strEmpAcessoUsuarioLogado)) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
            Result := False;
            Break;
          End;
        End;
      End;
    End
    Else
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If Pos(edtCodEmp.Text, QuotedStr(strEmpAcessoUsuarioLogado)) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
          Result := False;
        End;
      End;
    End;
  End

  Else If (Sender = edtCodCidade) And (blnValidaIndividual) Then
  Begin
    If (Not fEmptyStr(edtCodCidade.Text)) Then
      edtEstado.Text := fRetNomCidade(edtCodCidade.Text, 1);
  End

  Else If (Sender = edtCodCidExc)  Then
  Begin
    If (Not fEmptyStr(edtCodCidExc.Text)) Then
      edtEstado.Text := fRetNomCidade(edtCodCidExc.Text, 1)
    Else
      pDesmarcaLista(edtCodCidExc, arrCidExc);

  End

  Else If (Sender = edtEstado) Then
  Begin
    If (Not fEmptyStr(edtEstado.Text)) Then
    Begin
      If (Not fValidaEstado(edtEstado.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Estado informado não existe!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtDepIte) Then
  Begin
    pDesmarcaLista(edtDepIte, arrDepIte);
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelFatEvolVendas.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti,edtDesAti,arrLinAti,nil,fRetNomAtividade,'da Atividade');
end;

procedure TfrmRelFatEvolVendas.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrLinAti, False) Then
  Begin
    fValidaCampos(edtCodAti, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendas.edtCodCidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCidade,edtDesCidade,arrLinhaCidad,fRetNomCidadeSemOpc,nil,'da Cidade');
end;

procedure TfrmRelFatEvolVendas.edtCodProdutoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodProduto,edtDesProduto,arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmRelFatEvolVendas.edtCodUnidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUnidade,edtDesUnidade,arrUnidade,fRetNomUnidade,nil,'da Unidade',edtCodUnidade.MaxLength);
end;

procedure TfrmRelFatEvolVendas.edtCodCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCidade, edtDesCidade, edtEstado, Nil, Key, arrLinhaCidad, False) Then
  Begin
    fValidaCampos(edtCodCidade, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatEvolVendas.edtCodCidExcExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCidExc, edtDesCidExc, arrCidExc, fRetNomCidadeSemOpc,nil,'da Cidade');

  If (Length(arrCidExc) <= 0) Then
    edtDesCidExc.Text := 'NENHUM';
end;

procedure TfrmRelFatEvolVendas.edtCodCidExcKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {****************************}
  {* CIDADES A EXCLUIR        *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCidExc, edtDesCidExc, nil, Nil, Key, arrCidExc, False) Then
  Begin
    fValidaCampos(edtCodCidExc, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatEvolVendas.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente,edtDesCliente,arrLinhaClien,nil,fRetNomCliente,'do cliente');
end;

procedure TfrmRelFatEvolVendas.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrLinhaClien, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendas.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep,edtDesDep,arrDepart,fRetDescDepartamento,nil,'do Departamento');
end;

procedure TfrmRelFatEvolVendas.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************MM*}
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepart, False) Then
  Begin
    fValidaCampos(edtCodDep, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatEvolVendas.pSqlCliSemMovimento;
  Var
    strRegiao,
    strSubReg,
    strLinCli,
    strLinVen,
    strLinRep,
    strLinAti,
    strRedLojas,
    strLinCid,
    strProfis,
    strSQLCli : String;
begin
  strSQLCli := '';
  strSQLCli := strSQLCli + 'SELECT SQL_NO_CACHE     ';
  strSQLCli := strSQLCli + '  CLI_BAIRRO AS BAIRRO, ';
  strSQLCli := strSQLCli + '  CLI_CODATI AS CODATI, ';
  strSQLCli := strSQLCli + '  CLI_CODDIV AS CODDIV, ';
  strSQLCli := strSQLCli + '  CLI_CODCID AS CODCID, ';
  strSQLCli := strSQLCli + '  CLI_CODVEN AS VENATU, ';
  strSQLCli := strSQLCli + '  CLI_CODREP AS REPATU, ';
  strSQLCli := strSQLCli + '  CLI_CODCLI AS CODCLI, ';
  strSQLCli := strSQLCli + '  LPAD("", 8, " ") AS CODFOR, ';
  strSQLCli := strSQLCli + '  LPAD("", 5, " ") AS CODITE, ';
  strSQLCli := strSQLCli + '  LPAD("", 6, " ") AS CODGRU, ';
  strSQLCli := strSQLCli + '  LPAD("", 6, " ") AS CODMAR, ';
  strSQLCli := strSQLCli + '  CLI_CODVEN AS CODVEN, ';
  strSQLCli := strSQLCli + '  CLI_CODREP AS CODREP, ';
  strSQLCli := strSQLCli + '  CLI_C_G_C_ AS C_G_C_, ';

  strSQLCli := strSQLCli + fRetColunasData(True);

  strSQLCli := strSQLCli + '  LPAD("", 100, " ") AS DESITE, ';
  strSQLCli := strSQLCli + '  LPAD("",  50, " ") AS DESGRU, ';
  strSQLCli := strSQLCli + '  LPAD("",  50, " ") AS DESMAR, ';
  strSQLCli := strSQLCli + '  CONCAT(CLI_ENDERE,IF(CLI_ENDNUM <>"",CONCAT(", ",CLI_ENDNUM),"")) AS ENDERE, ';
  strSQLCli := strSQLCli + '  CID_ESTADO AS ESTADO, ';
  strSQLCli := strSQLCli + '  CLI_FONE01 AS FONE01, ';
  strSQLCli := strSQLCli + '  CID_NOMCID AS NOMCID, ';
  strSQLCli := strSQLCli + '  O.OPE_NOMOPE AS NOMVEN, ';
  strSQLCli := strSQLCli + '  R.OPE_NOMOPE AS NOMREP, ';
  strSQLCli := strSQLCli + '  LPAD("", 50, " ") AS NOMFOR, ';
  strSQLCli := strSQLCli + '  LPAD("", 50, " ") AS NOMATI, ';
  strSQLCli := strSQLCli + '  CLI_NOMCLI AS NOMCLI, ';
  strSQLCli := strSQLCli + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ';

  case StrToIntDef(edtOpcao.Text,0) of
    1: strSQLCli := strSQLCli + ' CONCAT("REPRESENTANTE: ",IFNULL(CLI_CODREP," "),"-",IFNULL(R.OPE_NOMOPE," ")) AS QUEBRA, ';
    2: strSQLCli := strSQLCli + ' CONCAT("VENDEDOR: ",IFNULL(CLI_CODVEN," "),"-",IFNULL(O.OPE_NOMOPE," ")) AS QUEBRA, ';
    3: strSQLCli := strSQLCli + ' CONCAT("CIDADE: ",IFNULL(CLI_CODCID," "),"-",IFNULL(D.CID_NOMCID," ")) AS QUEBRA, ';
    4,
    5: strSQLCli := strSQLCli + ' LPAD("", 100, " ") AS QUEBRA, ';
  end;

  strSQLCli := strSQLCli + '  LPAD("", 100, " ") AS QUEBRA, ';
  strSQLCli := strSQLCli + '  0.00 AS TOTDTA ';
  strSQLCli := strSQLCli + 'FROM ';
  strSQLCli := strSQLCli + '  CADCLI C LEFT JOIN CADCID D ON C.CLI_CODCID = D.CID_CODCID ';
  strSQLCli := strSQLCli + '           LEFT JOIN CADOPE O ON C.CLI_CODVEN = O.OPE_CODOPE ';
  strSQLCli := strSQLCli + '           LEFT JOIN CADOPE R ON C.CLI_CODREP = R.OPE_CODOPE ';
  strSQLCli := strSQLCli + 'WHERE ';
  strSQLCli := strSQLCli + '  CLI_CODCLI NOT IN (' + VS_strCliFil + ') ';

  If Not fEmptyStr(edtEstado.Text) Then
    strSQLCli := strSQLCli + ' AND CID_ESTADO = :ESTADO ';

  {*********************************************}
  {* FILTRO POR CLIENTES ATIVOS\INATIVOS\TODOS *}
  {******************************************JB*}
  If rdbAtivos.Checked then
    strSQLCli := strSQLCli + ' AND CLI_STATUS = "A" '
  Else If rdbInativo.Checked then
    strSQLCli := strSQLCli + ' AND CLI_STATUS <> "A" ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQLCli := strSQLCli + fStrLocate(edtCodEmp, arrEmpresa, 'CLI_CODEMP', 'CODEMP')
  Else
    strSQLCli := strSQLCli + ' AND LOCATE(CLI_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(edtDesReg.Text) Then
    strSQLCli := strSQLCli + fStrLocate(edtCodReg, arrRegiao, 'CLI_CODREG', 'CODREG');

  If Not fEmptyStr(edtDesSub.Text) Then
    strSQLCli := strSQLCli + fStrLocate(edtCodSub, arrSubReg, 'CLI_CODSUB', 'CODSUB');

  If Not fEmptyStr(cbbCategoria.Text) Then
    strSQLCli := strSQLCli + '  AND CLI_CATEGO = :CATEGO ';

  strSQLCli := strSQLCli + fStrLocate(edtCodCliente,arrLinhaClien,'CLI_CODCLI','CODCLI');
  strSQLCli := strSQLCli + fStrLocate(edtCodAti,arrLinAti,'CLI_CODATI','CODATI');
  strSQLCli := strSQLCli + fStrLocate(edtCodRed,arrRedeLojas,'CLI_CODRED','CODRED');
  strSQLCli := strSQLCli + fStrLocate(edtCodCidade,arrLinhaCidad,'CLI_CODCID','CODCID');
  strSQLCli := strSQLCli + fStrLocate(edtCodProfis,arrProfis,'CLI_CODDIV','CODDIV');
  strSQLCli := strSQLCli + fStrLocate(edtCodRepresentante,arrLinhaRepre,'CLI_CODREP','CODREP');
  strSQLCli := strSQLCli + fStrLocate(edtCodVendedor,arrLinhaVende,'CLI_CODVEN','CODVEN');

  if Not Assigned(cdsClientes) then
  Begin
    cdsClientes := fGetZClient(Self, strSQLCli);
  End
  Else
    cdsClientes.qryQuery.SQL.Text := strSQLCli;

  With cdsClientes Do
  Begin
    Close;
    qryQuery.Close;
    pSetProvider;

    If Not fEmptyStr(edtCodEmp.Text) Then
      pSetaParam(edtCodEmp.Text, arrEmpresa, strEmpresa, 'CODEMP', qryQuery);

    If Not fEmptyStr(edtDesReg.Text) Then
      pSetaParam(edtCodReg.Text, arrRegiao, strRegiao, 'CODREG', qryQuery);

    If Not fEmptyStr(edtDesSub.Text) Then
      pSetaParam(edtCodSub.Text, arrSubReg, strSubReg, 'CODSUB', qryQuery);

    If Not fEmptyStr(cbbCategoria.Text) Then
      qryQuery.ParamByName('CATEGO').AsString := cbbCategoria.Text;

    pSetaParam(edtCodCliente.Text,arrLinhaClien,strLinCli,'CODCLI',qryQuery);
    pSetaParam(edtCodAti.Text,arrLinAti,strLinAti,'CODATI',qryQuery);
    pSetaParam(edtCodRed.Text,arrRedeLojas,strRedLojas,'CODRED',qryQuery);
    pSetaParam(edtCodCidade.Text,arrLinhaCidad,strLinCid,'CODCID',qryQuery);
    pSetaParam(edtCodProfis.Text,arrProfis,strProfis,'CODDIV',qryQuery);
    pSetaParam(strCodVen,arrLinhaVende,strLinVen,'CODVEN',qryQuery);
    pSetaParam(strCodRep,arrLinhaRepre,strLinRep,'CODREP',qryQuery);    

    If Not fEmptyStr(edtEstado.Text) Then
      qryQuery.ParamByName('ESTADO').AsString := edtEstado.Text;

    qryQuery.Open;
    pSetaClient(qryQuery);
    Open;
  End;
end;

function TfrmRelFatEvolVendas.fRetColunasData(blnCriarTodasColunasZeradas: Boolean=False): String;
  Var
    intContador: Integer;
begin
  {**************************************}
  {* MONTA TODAS AS COLUNAS             *}
  {***********************************AF*}
  For intContador := 0 To fGetNroColunas() Do
  Begin
    If blnCriarTodasColunasZeradas Then
    Begin
      Result := Result + '  0.00 AS DATA0' + IntToStr(intContador + 1) + ', ';
    End
    Else
    Begin
      {**************************************}
      {* LITRAGEM                           *}
      {***********************************AF*}
      If (edtOpcao2.Text = 'L') Or (edtOpcao2.Text = 'G') Then
      Begin
        If edtDestino.Text <> 'E' Then Begin
          If fEmptyStr(String(arrDatas[intContador])) Then
            Result := Result + '  0.00 AS DATA0' + IntToStr(intContador + 1) + ', '
          Else
            Result := Result + '  SUM(IF(DATE_FORMAT(DET_DTAENT,"%m/%Y") = ' + QuotedStr(String(arrDatas[intContador])) + ', IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE, DET_QTDITE) * ' + fStrRelFatorLit + ', 0)) AS DATA0' + IntToStr(intContador + 1) + ', ';
        End Else Begin
          If fEmptyStr(String(arrDatasExcel[intContador])) Then
            Result := Result + '  0.00 AS DATA0' + IntToStr(intContador + 1) + ', '
          Else
            Result := Result + '  SUM(IF(DATE_FORMAT(DET_DTAENT,"%m/%Y") = ' + QuotedStr(String(arrDatasExcel[intContador])) + ', IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE, DET_QTDITE) * ' + fStrRelFatorLit + ', 0)) AS DATA0' + IntToStr(intContador + 1) + ', ';
        End;
      End

      {**************************************}
      {* UNITARIO                           *}
      {***********************************AF*}
      Else If edtOpcao2.Text = 'Q' Then
      Begin
        If edtDestino.Text <> 'E' Then Begin
          If fEmptyStr(String(arrDatas[intContador])) Then
            Result := Result + '  0.00 AS DATA0' + IntToStr(intContador + 1) + ', '
          Else
            Result := Result + '  SUM(IF(DATE_FORMAT(DET_DTAENT,"%m/%Y") = ' + QuotedStr(String(arrDatas[intContador])) + ', IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE, DET_QTDITE), 0)) AS DATA0' + IntToStr(intContador + 1) + ', ';
        End Else Begin
          If fEmptyStr(String(arrDatasExcel[intContador])) Then
            Result := Result + '  0.00 AS DATA0' + IntToStr(intContador + 1) + ', '
          Else
            Result := Result + '  SUM(IF(DATE_FORMAT(DET_DTAENT,"%m/%Y") = ' + QuotedStr(String(arrDatasExcel[intContador])) + ', IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE, DET_QTDITE), 0)) AS DATA0' + IntToStr(intContador + 1) + ', ';
        End;
      End

      {**************************************}
      {* VALOR                              *}
      {***********************************AF*}
      Else If edtOpcao2.Text = 'V' Then
      Begin
        If edtDestino.Text <> 'E' Then Begin
          If fEmptyStr(String(arrDatas[intContador])) Then
            Result := Result + '  0.00 AS DATA0' + IntToStr(intContador + 1) + ', '
          Else
            Result := Result + '  SUM(IF(DATE_FORMAT(DET_DTAENT,"%m/%Y") = ' + QuotedStr(String(arrDatas[intContador])) + ', IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE-DET_DESESP-DET_DESCFF), DET_TOTITE-DET_DESESP-DET_DESCFF)), 0)) AS DATA0' + IntToStr(intContador + 1) + ', ';
        End Else Begin
          If fEmptyStr(String(arrDatasExcel[intContador])) Then
            Result := Result + '  0.00 AS DATA0' + IntToStr(intContador + 1) + ', '
          Else
            Result := Result + '  SUM(IF(DATE_FORMAT(DET_DTAENT,"%m/%Y") = ' + QuotedStr(String(arrDatasExcel[intContador])) + ', IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE-DET_DESESP-DET_DESCFF), DET_TOTITE-DET_DESESP-DET_DESCFF)), 0)) AS DATA0' + IntToStr(intContador + 1) + ', ';
        End;
      End;
    End;
  End;

  Result := ' '+Result+' ';
end;

function TfrmRelFatEvolVendas.fSqlGroupBy: String;
  Var
   strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'GROUP BY ';

  Case strToIntDef(edtOpcao.Text,0) Of
    1 : If fEmptyStr(edtCodRepresentante.Text) Or (Length(arrLinhaRepre) > 0) Then
          strSQL := strSQL + ' CODREP, CODCLI '
        Else
          strSQL := strSQL + ' CODCLI ';

    2 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
          strSQL := strSQL + ' CODVEN, CODCLI '
        Else
          strSQL := strSQL + ' CODCLI ';

    3 : If fEmptyStr(edtCodCidade.Text) Or (Length(arrLinhaCidad) > 0) Then
          strSQL := strSQL + ' CODCID, CODCLI '
        Else
          strSQL := strSQL + ' CODCLI ';

    4 : strSQL := strSQL + ' CODCLI ';

    5 : strSQL := strSQL + ' CODCLI ';

    6 : If fEmptyStr(edtFornecedor.Text) Or (Length(arrLinhaForne) > 0) Then
         strSQL := strSQL + ' CODFOR, CODITE '
        Else
         strSQL := strSQL + ' CODITE ';

    7 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
          strSQL := strSQL + ' CODVEN, CODCID '
        Else
          strSQL := strSQL + ' CODCID ';

    8 : strSQL := strSQL + ' CODATI ';

    9 : strSQL := strSQL + ' CODREP ';

    10 : strSQL := strSQL + ' CODFOR ';

    11 : strSQL := strSQL + ' CODGRU ';

    12 : If fEmptyStr(edtCodCliente.Text) Or (Length(arrLinhaClien) > 0) Then
           strSQL := strSQL + ' CODCLI, CODITE '
         Else
           strSQL := strSQL + ' CODITE ';

    13 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
           strSQL := strSQL + ' CODVEN, CODATI '
         Else
           strSQL := strSQL + ' CODATI ';

    14 : strSQL := strSQL + ' CODMAR ';

    15 : strSQL := strSQL + ' CODCID ';

    16 : If fEmptyStr(edtCodRepresentante.Text) Or (Length(arrLinhaRepre) > 0) Then
           strSQL := strSQL + ' REPATU, CODCLI '
         Else
           strSQL := strSQL + ' CODCLI ';

    17 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
           strSQL := strSQL + ' VENATU, CODCLI '
         Else
           strSQL := strSQL + ' CODCLI ';

    18 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
           strSQL := strSQL + ' CODVEN, CODMAR '
         Else
           strSQL := strSQL + ' CODMAR ';

    19: strSQL := strSQL + ' CODVEN ';

    20: strSQL := strSQL + ' CODDIV ';

    21 : strSQL := strSQL + ' CODVEN, CODITE ';
    22 : strSQL := strSQL + ' LINHA ';
    23 : strSQL := strSQL + ' CODCID, CODITE ';
    24 : strSQL := strSQL + ' CODCLI, LINHA ';
    25 : strSQL := strSQL + ' CODEMP ';
  end;

  Result := strSQL;
End;

Procedure TfrmRelFatEvolVendas.pCamposLocate(Var strLocate: String; Var KeyValues: Variant);
Begin

  With QryRelatorio Do
  Case strToIntDef(edtOpcao.Text,0) Of
    1 : If fEmptyStr(edtCodRepresentante.Text) Or (Length(arrLinhaRepre) > 0) Then
        Begin
          strLocate := 'CODREP;CODCLI';
          KeyValues := VarArrayOf([FieldByName('CODREP').AsString, FieldByName('CODCLI').AsString]);
        End
        Else
        Begin
          strLocate := 'CODCLI';
          KeyValues := FieldByName('CODCLI').AsString;
        End;

    2 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
        Begin
          strLocate := 'CODVEN;CODCLI';
          KeyValues := VarArrayOf([FieldByName('CODVEN').AsString, FieldByName('CODCLI').AsString]);
        End
        Else
        Begin
          strLocate := 'CODCLI';
          KeyValues := FieldByName('CODCLI').AsString;
        End;

    3 : If fEmptyStr(edtCodCidade.Text) Or (Length(arrLinhaCidad) > 0) Then
        Begin
          strLocate := 'CODCID;CODCLI';
          KeyValues := VarArrayOf([FieldByName('CODCID').AsString, FieldByName('CODCLI').AsString]);
        End
        Else
        Begin
          strLocate := 'CODCLI';
          KeyValues := FieldByName('CODCLI').AsString;
        End;

    4 : Begin
          strLocate := 'CODCLI';
          KeyValues := FieldByName('CODCLI').AsString;
        End;

    5 : Begin
          strLocate := 'CODCLI';
          KeyValues := FieldByName('CODCLI').AsString;
        End;

    6 : If fEmptyStr(edtFornecedor.Text) Or (Length(arrLinhaForne) > 0) Then
        Begin
         strLocate := 'CODFOR;CODITE';
         KeyValues := VarArrayOf([FieldByName('CODFOR').AsString, FieldByName('CODITE').AsString]);
        End
        Else
        Begin
          strLocate := 'CODITE';
          KeyValues := FieldByName('CODITE').AsString;
        End;

    7 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
        Begin
          strLocate := 'CODVEN;CODCID';
          KeyValues := VarArrayOf([FieldByName('CODVEN').AsString, FieldByName('CODCID').AsString]);
        End
        Else
        Begin
          strLocate := 'CODCID';
          KeyValues := FieldByName('CODCID').AsString;
        End;

    8 : Begin
          strLocate := 'CODATI';
          KeyValues := FieldByName('CODATI').AsString;
        End;

    9 : Begin
          strLocate := 'CODREP';
          KeyValues := FieldByName('CODREP').AsString;
        End;

    10: Begin
          strLocate := 'CODFOR';
          KeyValues := FieldByName('CODFOR').AsString;
        End;

    11: Begin
          strLocate := 'CODGRU';
          KeyValues := FieldByName('CODGRU').AsString;
        End;

    12 : If fEmptyStr(edtCodCliente.Text) Or (Length(arrLinhaClien) > 0) Then
         Begin
           strLocate := 'CODCLI;CODITE';
           KeyValues := VarArrayOf([FieldByName('CODCLI').AsString, FieldByName('CODITE').AsString]);
         End
         Else
         Begin
           strLocate := 'CODITE';
           KeyValues := FieldByName('CODITE').AsString;
         End;

    13 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
         Begin
           strLocate := 'CODVEN;CODATI';
           KeyValues := VarArrayOf([FieldByName('CODVEN').AsString, FieldByName('CODATI').AsString]);
         End
         Else
         Begin
           strLocate := 'CODATI';
           KeyValues := FieldByName('CODATI').AsString;
         End;

    14 : Begin
           strLocate := 'CODMAR';
           KeyValues := FieldByName('CODMAR').AsString;
         End;

    15 : Begin
           strLocate := 'CODCID';
           KeyValues := FieldByName('CODCID').AsString;
         End;

    16 : If fEmptyStr(edtCodRepresentante.Text) Or (Length(arrLinhaRepre) > 0) Then
         Begin
           strLocate := 'REPATU;CODCLI';
           KeyValues := VarArrayOf([FieldByName('REPATU').AsString, FieldByName('CODCLI').AsString]);
         End
         Else
         Begin
           strLocate := 'CODCLI';
           KeyValues := FieldByName('CODCLI').AsString;
         End;

    17 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
         Begin
           strLocate := 'VENATU;CODCLI';
           KeyValues := VarArrayOf([FieldByName('VENATU').AsString, FieldByName('CODCLI').AsString]);
         End
         Else
         Begin
           strLocate := 'CODCLI';
           KeyValues := FieldByName('CODCLI').AsString;
         End;

    18 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
         Begin
           strLocate := 'CODVEN;CODMAR';
           KeyValues := VarArrayOf([FieldByName('CODVEN').AsString, FieldByName('CODMAR').AsString]);
         End
         Else
         Begin
           strLocate := 'CODMAR';
           KeyValues := FieldByName('CODMAR').AsString;
         End;

    19 : Begin
          strLocate := 'CODVEN';
          KeyValues := FieldByName('CODVEN').AsString;
         End;

    20 : Begin
          strLocate := 'CODDIV';
          KeyValues := FieldByName('CODDIV').AsString;
         End;

    21 : Begin
           strLocate := 'CODVEN;CODITE';
           KeyValues := VarArrayOf([FieldByName('CODVEN').AsString, FieldByName('CODITE').AsString]);
         End;
    22 : Begin
           strLocate :='LINHA';
           KeyValues := FieldByName('LINHA').AsString;
         End;
    23 : Begin
           strLocate := 'CODCID;CODITE';
           KeyValues := VarArrayOf([FieldByName('CODCID').AsString, FieldByName('CODITE').AsString]);
         End;
    24 : Begin
           strLocate := 'CODCLI;LINHA';
           KeyValues := VarArrayOf([FieldByName('CODCLI').AsString, FieldByName('LINHA').AsString]);
         End;
    25 : Begin
           strLocate := 'CODEMP';
           KeyValues := FieldByName('CODEMP').AsString;
         End;
  end;
End;

procedure TfrmRelFatEvolVendas.btnImprimirClick(Sender: TObject);
  Var
    strSQL     : String;
    strSQLInterno: String;
    strData    : String;
    intContador: Integer;
    rllLabel   : TRLLabel;
    rdbLabel   : TRLDBText;
    rdbResult  : TRLDBResult;
    strOpcoes  : String;
    dtaDtaIni  : TDate;

    strComFF: String;
    strComTR: String;
    strComDV: String;

    strSQLGru,
    strSQLLin: String;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  blnPerFil := False;

  If ((fEmptyStr(strTipImp)) Or (fEmptyStr(strNomImp)) Or (strDesAnt <> edtDestino.Text)) Then
  Begin
    fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, edtDestino.Text);
    strDesAnt := edtDestino.Text;
  End;

  inherited;

  If fEmptyStr(strCodVen) And fEmptyStr(strCodRep) And (Not blnLiberado) Then
  Begin
    blnImprime := False;
    fMensagem('', 'Informe a senha para o Vendedor ou Representante!', ['&Ok']);
  End;

  pVerificaQtdMes;

  If blnImprime Then
  Begin
    {**************************************}
    {* ESTABELECE UM Nº MÁXIMO DE COLUNAS *}
    {* PARA NÃO ULTRAPASSAR O LIMITE      *}
    {* DO RELATÓRIO (EXCEL\VIDEO\IMPRE)   *}
    {***********************************JB*}
    If (StrToIntDef(edtOpcao.Text,0) = 4) And (Pos(edtDestino.Text, 'V_I_') > 0) Then
    Begin
      If strTipImp = 'M' Then
        intLimCol := 7
      Else
        intLimCol := 4;
    End
    Else If (StrToIntDef(edtOpcao.Text,0) = 5)  And (Pos(edtDestino.Text, 'V_I_') > 0) Then
    Begin
      If strTipImp = 'M' Then
        intLimCol := StrToInt(edtQtdMes.Text)
      Else
        intLimCol := 9;
    End
    Else
      intLimCol := StrToInt(edtQtdMes.Text);

    {***************************************}
    {* ATRIBUI AO CAMPO QTDMES O Nº MAXIMO *}
    {* DE COLUNAS Q PODE APARECER NO TIPO  *}
    {* DE RELATÓRIO ESCOLHIDO              *}
    {************************************ER*}
    If StrToIntDef(edtQtdMes.Text, 0) > intLimCol Then
      edtQtdMes.Text := IntToStr(intLimCol);

    {***********************************************}
    {* CASO FOR UMA DESTAS OPCOES;                 *}
    {* SE DESTINO FOR EXEL LIMITE DE MESES ATÉ 12; *}
    {* SE DESTINO FOR OUTRO APENAS 7;              *}
    {********************************************JB*}
    strOpcoes := '01_02_03_04_06_07_08_09_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_';
    If edtDestino.Text = 'E' Then
    Begin
      If (Pos(fStrZero(edtOpcao.Text,2),strOpcoes) > 0) And (StrToInt(edtQtdMes.Text) > 199) Then Begin
        edtQtdMes.TamCampo  := 3;
        edtQtdMes.MaxLength := 3;
        edtQtdMes.Text := '199';
      End;
    End
    Else
    Begin
      If (Pos(fStrZero(edtOpcao.Text,2),strOpcoes) > 0) And (StrToInt(edtQtdMes.Text) > 7) Then Begin
        edtQtdMes.TamCampo  := 2;
        edtQtdMes.MaxLength := 2;
        edtQtdMes.Text := '7';
      End;
    End;

    {**************************}
    {* MONTA MATRIZ DAS DATAS *}
    {***********************AF*}
    strData := mskMesBas.Text;

    If edtDestino.Text <> 'E' Then Begin
      For intContador := 0 To fGetNroColunas() Do
        arrDatas[intContador] := '';

      For intContador := fGetNroColunas() DownTo (fGetNroColunas() - (StrToInt(edtQtdMes.Text)-1)) Do
      Begin
        {****************************************************************************}
        {* ALTERADO PORQUE ESTAVA DANDO ERRO QUANDO O ANO EH DIGITADO COM 2 DIGITOS *}
        {*************************************************************************LA*}
        arrDatas[intContador] := ShortString(FormatDateTime('mm/yyyy',StrToDate('01/' + strData)));

        strData := FormatDateTime('mm/yyyy',IncMonth( StrToDate('01/' + strData), -1 ));
      End;
    End Else Begin
      For intContador := 0 To fGetNroColunas() Do
        arrDatasExcel[intContador] := '';

      For intContador := 198 DownTo (198 - (StrToInt(edtQtdMes.Text)-1)) Do
      Begin
        {****************************************************************************}
        {* ALTERADO PORQUE ESTAVA DANDO ERRO QUANDO O ANO EH DIGITADO COM 2 DIGITOS *}
        {*************************************************************************LA*}
        arrDatasExcel[intContador] := ShortString(FormatDateTime('mm/yyyy',StrToDate('01/' + strData)));

        strData := FormatDateTime('mm/yyyy',IncMonth( StrToDate('01/' + strData), -1 ));
      End;

    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
    strSQL := strSQL + '  DET_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ';
    strSQL := strSQL + '  CLI_C_G_C_ AS C_G_C_, ';
    strSQL := strSQL + '  CLI_FONE01 AS FONE01, ';
    strSQL := strSQL + '  CONCAT(CLI_ENDERE,IF(CLI_ENDNUM <>"",CONCAT(", ",CLI_ENDNUM),"")) AS ENDERE, ';
    strSQL := strSQL + '  CLI_BAIRRO AS BAIRRO, ';
    strSQL := strSQL + '  CLI_CODCID AS CODCID, ';
    strSQL := strSQL + '  CLI_CODATI AS CODATI, ';
    strSQL := strSQL + '  IF(IFNULL(DET_CODVEN,"") = "", CLI_CODVEN, DET_CODVEN) AS CODVEN, ';
    strSQL := strSQL + '  IF(IFNULL(DET_CODREP,"") = "", CLI_CODREP, DET_CODREP) AS CODREP, ';
    strSQL := strSQL + '  DET_CODDIV AS CODDIV, ';
    strSQL := strSQL + '  DIV_NOMDIV AS NOMDIV, ';
    strSQL := strSQL + '  CLI_CODVEN AS VENATU, ';
    strSQL := strSQL + '  CLI_CODREP AS REPATU, ';
    strSQL := strSQL + '  DET_FORITE AS CODFOR, ';
    strSQL := strSQL + '  DET_CODITE AS CODITE, ';
    strSQL := strSQL + '  ITE_CODGRU AS CODGRU, ';
    strSQL := strSQL + '  CONCAT(LEFT(ITE_CODGRU, 3), "000") AS LINHA, ';
    strSQL := strSQL + '  CLI_STATUS AS CLISTA, ';
    strSQL := strSQL + '  ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';

    strSQL := strSQL + fRetColunasData;

    If (chkRefPro.Checked) Then
      strSQL := strSQL + '  CONCAT(ITE_DESITE," - ",ITE_REFERE) AS DESITE '
    Else
    Begin
      If Not (chkMarPro.Checked) Then
        strSQL := strSQL + '  ITE_DESITE AS DESITE '
      Else
        strSQL := strSQL + '  CONCAT(ITE_DESITE," - ",MAR_DESMAR) AS DESITE ';
    End;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';
    strSQL := strSQL + '  INNER JOIN CADCLI ON DET_CODCLI = CLI_CODCLI ';
    strSQL := strSQL + '   LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD ';
    strSQL := strSQL + '   LEFT JOIN CADITE ON ITE_CODITE = DET_CODITE ';
    strSQL := strSQL + '   LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
    strSQL := strSQL + '   LEFT JOIN CADDIV ON DIV_CODDIV = DET_CODDIV ';

    If Not fEmptyStr(edtCodDep.Text) Then
      strSQL := strSQL + '   LEFT JOIN CADOPE ON OPE_CODOPE = DET_CODVEN ';

    If Not fEmptyStr(edtEstado.Text) Then
      strSQL := strSQL + ' INNER JOIN CADCID ON CID_CODCID = CLI_CODCID ';

    strSQL := strSQL + '   LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';

    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';

    {*********************************************}
    {* FILTRO POR CLIENTES ATIVOS\INATIVOS\TODOS *}
    {******************************************JB*}
    If rdbAtivos.Checked then
      strSQL := strSQL + '  CLI_STATUS = "A"  AND '
    Else If rdbInativo.Checked then
      strSQL := strSQL + '  CLI_STATUS <> "A" AND ';

    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) AND '
    Else
      strSQL := strSQL + ') AND ';

    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C" AND ';
    strSQL := strSQL + '  DET_ESPDOC NOT IN ("FF")                 AND ';
    strSQL := strSQL + '  DET_ESPDOC NOT IN ("TR")                 AND ';
    strSQL := strSQL + '  DET_ESPDOC NOT IN ("DV")                 AND ';
    strSQL := strSQL + '  DET_DTAENT BETWEEN :MESINI AND :MESFIN ';

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      If edtEmpFat.Text = 'F' Then
        strSQL := strSQL + fStrLocate(edtCodEmp, arrEmpresa, 'DET_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + fStrLocate(edtCodEmp, arrEmpresa, 'MOVTRI.DET_EMPORI', 'CODEMP');
    End
    Else
      strSQL := strSQL + IfThen(edtEmpFat.Text = 'F',
                          ' AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ',
                          ' AND LOCATE(MOVTRI.DET_EMPORI,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ');

    strSQL := strSQL + fStrLocateLinGru(mskLinhaGrupo, arrLinhaGrupo, 'ITE_CODGRU', 'CODGRU' );

    If (Not fEmptyStr(mskLinhaGrupoExcluir.Text)) Then
      strSQL := strSQL + fStrLocateLinGru(mskLinhaGrupoExcluir, arrLinhaGrupoExc, 'ITE_CODGRU', 'GRUEXC', False, True);

    strSQL := strSQL + fStrLocate(edtGruCmp, arrGruCmp, 'ITE_GRUCMP', 'GRUCMP');


    {************************************}
    {* FILTRO POR DESCRIÇÃO DE PRODUTOS *}
    {*********************************RV*}
    If Not fEmptyStr(edtDesIni.Text) Then
    Begin
      strSQL := strSQL + ' AND LEFT(ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESINI AND :DESFIN ';
    End;

    If Not fEmptyStr(edtDesReg.Text) Then
      strSQL := strSQL + fStrLocate(edtCodReg, arrRegiao, 'CLI_CODREG', 'CODREG');

    If Not fEmptyStr(edtDesSub.Text) Then
      strSQL := strSQL + fStrLocate(edtCodSub, arrSubReg, 'CLI_CODSUB', 'CODSUB');

    If Not fEmptyStr(cbbCategoria.Text) Then
      strSQL := strSQL + '  AND CLI_CATEGO = :CATEGO ';

    strSQL := strSQL + fStrLocate(edtCodCliente,arrLinhaClien,'DET_CODCLI','CODCLI');
    strSQL := strSQL + fStrLocate(edtCodVendedor,arrLinhaVende,'DET_CODVEN','CODVEN');
    strSQL := strSQL + fStrLocate(edtCodRepresentante,arrLinhaRepre,'DET_CODREP','CODREP');
    strSQL := strSQL + fStrLocate(edtFornecedor,arrLinhaForne,'DET_FORITE','CODFOR');
    strSQL := strSQL + fStrLocate(edtCodMarca,arrLinhaMarca,'ITE_CODMAR','CODMAR');
    strSQL := strSQL + fStrLocate(edtCodAti,arrLinAti,'CLI_CODATI','CODATI');
    strSQL := strSQL + fStrLocate(edtCodDep,arrDepart,'OPE_CODDEP','CODDEP');
    strSQL := strSQL + fStrLocate(edtCodRed,arrRedeLojas,'CLI_CODRED','CODRED');
    strSQL := strSQL + fStrLocate(edtCodCidade,arrLinhaCidad,'CLI_CODCID','CODCID');
    strSQL := strSQL + fStrLocate(edtCodProduto,arrProduto,'DET_CODITE','CODITE');
    strSQL := strSQL + fStrLocate(edtCodUnidade,arrUnidade,'DET_UNIDAD','CODUNI');
    strSQL := strSQL + fStrLocate(edtCodProfis,arrProfis,'DET_CODDIV','CODDIV');
    strSQL := strSQL + fStrLocate(edtDepIte, arrDepIte, 'ITE_CODDEP', 'DEPITE');

    { CIDADES A EXCLUIR DO RELATÓRIO - PARTE 2}
    If (Not fEmptyStr(edtCodCidExc.Text)) Then
      strSQL := strSQL + fStrLocate(edtCodCidExc, arrCidExc, 'CLI_CODCID', 'CIDEXC', False, True);

    If Not fEmptyStr(edtEstado.Text) Then
      strSQL := strSQL + ' AND CID_ESTADO = :ESTADO ';

    strSQL := strSQL + fSqlGroupBy;

    strComFF := strSQL;
    strComTR := strSQL;
    strComDV := strSQL;

    {*****************************************}
    {* VERIFICA O VENDEDOR QUE ESTARA USANDO *}
    {**************************************LU*}
    If edtVendedor.Text = '2' Then
      strSQL := AnsiReplaceStr(strSQL,'DET_CODVEN','DET_CODVE2');

    {*******************************************}
    {* CASO A OPÇÃO SEJA 2 (FF POR DATA DE CON-*}
    {* FIRMAÇÃO, ACRESCENTA MAIS UM SELECT QUE *}
    {* FILTRA APENAS AS FF       E VAI POR DATA*}
    {* DE CONFIRMAÇÃO. CASO SEJA OPÇÃO 1,      *}
    {* NÃO FILTRA EM LUGAR NENHUM POR FF       *}
    {****************************************MV*}
    If (fCfgSis('COM_FF') = '2') Then
    Begin
      strComFF := AnsiReplaceStr(strComFF, 'DET_DTAENT','DET_DTAFAT');
      strComFF := AnsiReplaceStr(strComFF, 'NOT IN ("FF")','IN ("FF")');

      strSQL   := strSQL + ' UNION ALL ' + strComFF;
    End
    Else
      strSQL   := AnsiReplaceStr(strSQL, 'NOT IN ("FF")','NOT IN ("")');

    {*******************************************}
    {* CASO A OPÇÃO SEJA 2 (FF POR DATA DE CON-*}
    {* FIRMAÇÃO, ACRESCENTA MAIS UM SELECT QUE *}
    {* FILTRA APENAS AS    TR/DV E VAI POR DATA*}
    {* DE CONFIRMAÇÃO. CASO SEJA OPÇÃO 1,      *}
    {* NÃO FILTRA EM LUGAR NENHUM POR    TR/DV *}
    {****************************************MV*}
    If (fCfgSis('COM_TR') = '2') Then
    Begin
      strComTR := AnsiReplaceStr(strComTR, 'DET_DTAENT','DET_DTAFAT');
      strComTR := AnsiReplaceStr(strComTR, 'NOT IN ("TR")','IN ("TR")');

      strSQL   := strSQL + ' UNION ALL ' + strComTR;
    End
    Else
      strSQL   := AnsiReplaceStr(strSQL, 'NOT IN ("TR")','NOT IN ("")');

    If (fCfgSis('COM_DV') = '2') Then
    Begin
      strComDV := AnsiReplaceStr(strComDV, 'DET_DTAENT','DET_DTAFAT');
      strComDV := AnsiReplaceStr(strComDV, 'NOT IN ("DV")','IN ("DV")');

      strSQL   := strSQL + ' UNION ALL ' + strComDV;
    End
    Else
      strSQL   := AnsiReplaceStr(strSQL, 'NOT IN ("DV")','NOT IN ("")');

    strSQLInterno := strSQL;

    With QryRelatorio Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '03_04_05_07_15_23_') > 0 Then
      Begin
        strSQL := strSQL + '  IF(CID_NOMCID IS NULL OR CID_NOMCID = "", " ", CID_NOMCID) AS NOMCID, ';
        strSQL := strSQL + '  IF(CID_ESTADO IS NULL OR CID_ESTADO = "", " ", CID_ESTADO) AS ESTADO, ';
      End
      Else
      Begin
        strSQL := strSQL + '  " " AS NOMCID, ';
        strSQL := strSQL + '  " " AS ESTADO, ';
      End;

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '02_07_13_18_19_21_') > 0 Then
        strSQL := strSQL + '  IF(V.OPE_NOMOPE IS NULL OR V.OPE_NOMOPE = "", " ", V.OPE_NOMOPE) AS NOMVEN, '
      Else
        strSQL := strSQL + '  " " AS NOMVEN, ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '17_') > 0 Then
        strSQL := strSQL + '  IF(VA.OPE_NOMOPE IS NULL OR VA.OPE_NOMOPE = "", " ", VA.OPE_NOMOPE) AS NOMVEN, '
      Else
        strSQL := strSQL + '  " " AS NOMVEN, ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '01_09') > 0 Then
        strSQL := strSQL + '  IF(R.OPE_NOMOPE IS NULL OR R.OPE_NOMOPE = "", " ", R.OPE_NOMOPE) AS NOMREP, '
      Else
        strSQL := strSQL + '  " " AS NOMREP, ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '16_') > 0 Then
        strSQL := strSQL + '  IF(RA.OPE_NOMOPE IS NULL OR RA.OPE_NOMOPE = "", " ", RA.OPE_NOMOPE) AS NOMREP, '
      Else
        strSQL := strSQL + '  " " AS NOMREP, ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '06_10_') > 0 Then
        strSQL := strSQL + '  IF(FOR_NOMFOR IS NULL OR FOR_NOMFOR = "", " ", FOR_NOMFOR) AS NOMFOR, '
      Else
        strSQL := strSQL + '  " " AS NOMFOR, ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '11_') > 0 Then
        strSQL := strSQL + '  IF(GRU_DESGRU IS NULL OR GRU_DESGRU = "", " ", GRU_DESGRU) AS DESGRU, '
      Else
        strSQL := strSQL + '  " " AS DESGRU, ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '08_13_') > 0 Then
        strSQL := strSQL + ' IF(ATI_DESATI IS NULL OR ATI_DESATI = "", " ", ATI_DESATI) AS NOMATI, '
      Else
        strSQL := strSQL + '  " " AS NOMATI, ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '14_18_') > 0 Then
        strSQL := strSQL + ' IF(M.MAR_DESMAR IS NULL OR M.MAR_DESMAR = "", " ", M.MAR_DESMAR) AS DESMAR, '
      Else
        strSQL := strSQL + '  " " AS DESMAR, ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '20_') > 0 Then
        strSQL := strSQL + '  IF(NOMDIV IS NULL OR NOMDIV = "", " ", NOMDIV) AS NOMVEN, '
      Else
        strSQL := strSQL + '  " " AS NOMVEN, ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '22_') > 0 Then
        strSQL := strSQL + '  IF(IFNULL(L.GRU_CODGRU,"") = "", " ", CONCAT(LEFT(L.GRU_CODGRU,3), ".000")) AS LINHA, '
      Else If Pos(fPadL(edtOpcao.Text, 2, '0'), '24_') > 0 Then
        strSQL := strSQL + '  CONCAT(IFNULL(CONCAT(LEFT(L.GRU_CODGRU, 3), ".000")," "),"-",IFNULL(L.GRU_DESGRU," ")) AS LINHA, '
      Else
        strSQL := strSQL + '  " " AS LINHA, ';

      strSQL := strSQL + '  IF(CODCLI IS NULL OR CODCLI = "", " ", CODCLI) AS CODCLI, ';
      strSQL := strSQL + '  IF(NOMCLI IS NULL OR NOMCLI = "", " ", NOMCLI) AS NOMCLI, ';
      strSQL := strSQL + '  CONCAT(CODCLI, "-", NOMCLI) AS CLIENTE, ';
      strSQL := strSQL + '  IF(C_G_C_ IS NULL OR C_G_C_ = "", " ", C_G_C_) AS C_G_C_, ';
      strSQL := strSQL + '  IF(FONE01 IS NULL OR FONE01 = "", " ", FONE01) AS FONE01, ';
      strSQL := strSQL + '  IF(ENDERE IS NULL OR ENDERE = "", " ", ENDERE) AS ENDERE, ';
      strSQL := strSQL + '  IF(BAIRRO IS NULL OR BAIRRO = "", " ", BAIRRO) AS BAIRRO, ';
      strSQL := strSQL + '  IF(CODCID IS NULL OR CODCID = "", " ", CODCID) AS CODCID, ';
      strSQL := strSQL + '  IF(CODVEN IS NULL OR CODVEN = "", " ", CODVEN) AS CODVEN, ';
      strSQL := strSQL + '  IF(CODREP IS NULL OR CODREP = "", " ", CODREP) AS CODREP, ';
      strSQL := strSQL + '  IF(VENATU IS NULL OR VENATU = "", " ", VENATU) AS VENATU, ';
      strSQL := strSQL + '  IF(REPATU IS NULL OR REPATU = "", " ", REPATU) AS REPATU, ';
      strSQL := strSQL + '  IF(CODFOR IS NULL OR CODFOR = "", " ", CODFOR) AS CODFOR, ';
      strSQL := strSQL + '  IF(CODITE IS NULL OR CODITE = "", " ", CODITE) AS CODITE, ';
      strSQL := strSQL + '  IF(CODGRU IS NULL OR CODGRU = "", " ", CODGRU) AS CODGRU, ';
      strSQL := strSQL + '  IF(DESITE IS NULL OR DESITE = "", " ", DESITE) AS DESITE, ';
      strSQL := strSQL + '  IF(CODATI IS NULL OR CODATI = "", " ", CODATI) AS CODATI, ';
      strSQL := strSQL + '  IF(CODMAR IS NULL OR CODMAR = "", " ", CODMAR) AS CODMAR, ';
      strSQL := strSQL + '  IF(CODDIV IS NULL OR CODDIV = "", " ", CODDIV) AS CODDIV, ';
      strSQL := strSQL + '  IF(CODEMP IS NULL OR CODEMP = "", " ", CODEMP) AS CODEMP, ';

      {**************************************}
      {* DEFINE A QUEBRA DO RELATORIO       *}
      {***********************************AF*}
      Case StrToInt(edtOpcao.Text) Of
         1: strSQL := strSQL + ' CONCAT("REPRESENTANTE: ",IFNULL(CODREP," "),"-",IFNULL(R.OPE_NOMOPE," ")) AS QUEBRA, ';
         2,
         7,
        13,
        18,
        21: strSQL := strSQL + ' CONCAT("VENDEDOR: ",IFNULL(CODVEN," "),"-",IFNULL(V.OPE_NOMOPE," ")) AS QUEBRA, ';
         3,
        15: strSQL := strSQL + ' CONCAT(IFNULL(CODCID," "),"-",IFNULL(CID_NOMCID," ")) AS QUEBRA, ';
         4: strSQL := strSQL + ' IF(NOMCLI IS NULL OR NOMCLI = "", " ", NOMCLI) AS QUEBRA, ';
         5: strSQL := strSQL + ' IF(NOMCLI IS NULL OR NOMCLI = "", " ", NOMCLI) AS QUEBRA, ';
         6: strSQL := strSQL + ' CONCAT("FORNECEDOR: ",IFNULL(CODFOR," "),"-",IFNULL(FOR_NOMFOR," ")) AS QUEBRA, ';
         8: strSQL := strSQL + ' ATI_DESATI AS QUEBRA, ';
         9: strSQL := strSQL + ' CONCAT(IFNULL(CODREP," "),"-",IFNULL(R.OPE_NOMOPE," ")) AS QUEBRA, ';
        10: strSQL := strSQL + ' CONCAT(IFNULL(CODFOR," "),"-",IFNULL(FOR_NOMFOR," "))  AS QUEBRA, ';
        11: strSQL := strSQL + ' CONCAT(IFNULL(CODGRU," "),"-",IFNULL(GRU_DESGRU," "))  AS QUEBRA, ';
        12,
        24: strSQL := strSQL + ' CONCAT("CLIENTE: ",IFNULL(CODCLI," "),"-",IFNULL(NOMCLI," ")) AS QUEBRA, ';
        14: strSQL := strSQL + ' CONCAT("MARCA: ",IFNULL(CODMAR," "),"-",IFNULL(M.MAR_DESMAR," ")) AS QUEBRA, ';
        16: strSQL := strSQL + ' CONCAT("REPR. ATUAL: ",IFNULL(REPATU," "),"-",IFNULL(RA.OPE_NOMOPE," ")) AS QUEBRA, ';
        17: strSQL := strSQL + ' CONCAT("VEND. ATUAL: ",IFNULL(VENATU," "),"-",IFNULL(VA.OPE_NOMOPE," ")) AS QUEBRA, ';
        19: strSQL := strSQL + ' CONCAT(IFNULL(CODVEN," "),"-",IFNULL(V.OPE_NOMOPE," ")) AS QUEBRA, ';
        20: strSQL := strSQL + ' CONCAT(IFNULL(CODDIV," "),"-",IFNULL(NOMDIV," ")) AS QUEBRA, ';
        22: strSQL := strSQL + ' CONCAT(IFNULL(CONCAT(LEFT(L.GRU_CODGRU, 3), ".000")," "),"-",IFNULL(L.GRU_DESGRU," ")) AS QUEBRA, ';
        23: strSQL := strSQL + ' CONCAT("CIDADE: ",IFNULL(CODCID," "),"-",IFNULL(CID_NOMCID," ")) AS QUEBRA, ';
        25: strSQL := strSQL + ' CONCAT(IFNULL(CODEMP," "),"-",IFNULL(EMP_NOMEMP," ")) AS QUEBRA, ';
      End;

      {**************************************}
      {* MONTA AS COLUNAS SOMADAS           *}
      {***********************************AF*}
      For intContador := 1 To fGetNroColunas() + 1 Do
        strSQL := strSQL + '  SUM(DATA0' + IntToStr(intContador) + ') AS DATA0' + IntToStr(intContador) + ', ';

      strSQL := strSQL + '  ( ';

      {**************************************}
      {* MONTA A COLUNA DE SOMA             *}
      {***********************************AF*}
      For intContador := 1 To fGetNroColunas() + 1 Do
        strSQL := strSQL + '   SUM(DATA0' + IntToStr(intContador) + ') + ';

      strSQL := LeftStr(strSQL, Length(strSQL)-2);
      strSQL := strSQL + '   ) AS TOTDTA ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ( ' + strSQLInterno + ' ) AS EVOVEN ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '03_04_05_07_15_23_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADCID   ON   CID_CODCID = CODCID     ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '02_07_13_18_19_21_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADOPE V ON V.OPE_CODOPE = CODVEN     ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '01_09_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADOPE R ON R.OPE_CODOPE = CODREP     ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '17_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADOPE VA ON VA.OPE_CODOPE = VENATU   ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '16_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADOPE RA ON RA.OPE_CODOPE = REPATU   ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '06_10_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADFOR   ON   FOR_CODFOR = CODFOR     ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '11_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADGRU   ON   GRU_CODGRU = CODGRU     ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '08_13_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADATI   ON   ATI_CODATI = CODATI     ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '14_18_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADMAR M ON   MAR_CODMAR = CODMAR     ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '22_24_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADGRU L ON L.GRU_CODGRU = LINHA ';

      If Pos(fPadL(edtOpcao.Text, 2, '0'), '25_') > 0 Then
        strSQL := strSQL + ' LEFT JOIN CADEMP ON CADEMP.EMP_CODEMP = CODEMP ';

      strSQL := strSQL + fSqlGroupBy;

      if Not (chkCliMov.Checked) then
      Begin
        strSQL := strSQL + 'HAVING ';

        strSQL := strSQL + ' TOTDTA <> 0.00 ';
      End;

      Close;

      cdsVendas.Close;
      cdsVendas.ProviderName := 'dspVendas';

      pSetarIndiceClientVendas;

      SQL.Clear;
      SQL.Add(strSQL);

      If (edtDestino.Text <> 'E') Then
        dtaDtaIni := StrToDate('01/' + String(arrDatas[fGetNroColunas() - (StrToInt(edtQtdMes.Text)-1)]))
      Else
        dtaDtaIni := StrToDate('01/' + String(arrDatasExcel[fGetNroColunas() - (StrToInt(edtQtdMes.Text)-1)]));

      For intContador := 1 To StrToIntDef(edtQtdMes.Text, 0) Do
      Begin
        pnlInfo.Caption := 'Calculando mês '+ IntToStr(intContador) + ' / ' + IntToStr(StrToInt(edtQtdMes.Text)) + ' ...';
        Application.ProcessMessages;

        Close;

        ParamByName('MESINI').AsDate := dtaDtaIni;
        ParamByName('MESFIN').AsDate := IncMonth(dtaDtaIni, 1) -1;

        dtaDtaIni := IncMonth(dtaDtaIni, 1);

        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLADEV').AsString := VS_strClaDev;

        pSetaParam(edtCodEmp.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);

        {************************************}
        {* FILTRO POR DESCRIÇÃO DE PRODUTOS *}
        {*********************************RV*}
        If Not fEmptyStr(edtDesIni.Text) Then
        Begin
          If Length(edtDesIni.Text) > Length(edtDesFin.Text) Then
            ParamByName('MAIOR').AsString := edtDesIni.Text
          Else
            ParamByName('MAIOR').AsString := edtDesFin.Text;

          ParamByName('DESINI').AsString := edtDesIni.Text;
          ParamByName('DESFIN').AsString := edtDesFin.Text;
        End;

        If Not fEmptyStr(edtDesReg.Text) Then
          pSetaParam(edtCodReg.Text, arrRegiao, strRegiao, 'CODREG', QryRelatorio);

        If Not fEmptyStr(edtDesSub.Text) Then
          pSetaParam(edtCodSub.Text, arrSubReg, strSubReg, 'CODSUB', QryRelatorio);

        If Not fEmptyStr(mskLinhaGrupo.Text) Then
          pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLinGru,'CODGRU',QryRelatorio);

        If Not fEmptyStr(mskLinhaGrupoExcluir.Text) Then
          pSetaParam(mskLinhaGrupoExcluir.Text,arrLinhaGrupoExc,strLinGruExc,'GRUEXC',QryRelatorio);

        If Not fEmptyStr(cbbCategoria.Text) Then
          ParamByName('CATEGO').AsString := cbbCategoria.Text;

        pSetaParam(edtCodCliente.Text,arrLinhaClien,strLinCli,'CODCLI',QryRelatorio);
        pSetaParam(strCodVen,arrLinhaVende,strLinVen,'CODVEN',QryRelatorio);
        pSetaParam(strCodRep,arrLinhaRepre,strLinRep,'CODREP',QryRelatorio);
        pSetaParam(edtFornecedor.Text,arrLinhaForne,strLinFor,'CODFOR',QryRelatorio);
        pSetaParam(edtCodMarca.Text,arrLinhaMarca,strLinMar,'CODMAR',QryRelatorio);
        pSetaParam(edtCodAti.Text,arrLinAti,strLinAti,'CODATI',QryRelatorio);
        pSetaParam(edtCodDep.Text,arrDepart,strDepart,'CODDEP',QryRelatorio);
        pSetaParam(edtCodRed.Text,arrRedeLojas,strRedLojas,'CODRED',QryRelatorio);
        pSetaParam(edtCodCidade.Text,arrLinhaCidad,strLinCid,'CODCID',QryRelatorio);
        pSetaParam(edtCodProduto.Text,arrProduto,strLinPro,'CODITE',QryRelatorio);
        pSetaParam(edtCodUnidade.Text,arrUnidade,strLinUni,'CODUNI',QryRelatorio);
        pSetaParam(edtCodProfis.Text,arrProfis,strProfis,'CODDIV',QryRelatorio);
        pSetaParam(edtDepIte.Text, arrDepIte, strDepIte, 'DEPITE', QryRelatorio);
        pSetaParam(edtGruCmp.Text, arrGruCmp, strGruCmp, 'GRUCMP', QryRelatorio);

        { CIDADES A EXCLUIR DO RELATÓRIO - PARTE 3}
        If (Not fEmptyStr(edtCodCidExc.Text)) Then
          pSetaParam(edtCodCidExc.Text, arrCidExc, strCidExc, 'CIDEXC', QryRelatorio);

        If Not fEmptyStr(edtEstado.Text) Then
          ParamByName('ESTADO').AsString := edtEstado.Text;

        If Params.FindParam('LITGAL') <> Nil Then
        Begin
          If SameText(fCfgSis('LITGAL'), 'L') Then
            ParamByName('LITGAL').AsFloat := 1
          Else
            ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
        End;

        If (Not cdsVendas.Active) Or cdsVendas.IsEmpty Then
        Begin
          Open;
          pSetaClient(QryRelatorio);
          QryRelatorio.Options.SetFieldsReadOnly := False;

          cdsVendas.Close;
          cdsVendas.Open;
          pSetaClient(cdsVendas);
        End Else
        Begin
          cdsVendas.ProviderName := '';
          Open; // Abre a query;

          pSetaClient(QryRelatorio);

          pIncluiNoClient;
        End;

      End; {For}

      If (chkCliMov.Checked) Then
      Begin
        pSqlCliSemMovimento;

        With cdsVendas Do
        Begin

          pgbProgresso.Position := 0;
          pgbProgresso.Max      := RecordCount;
          pgbProgresso.Visible  := True;

          First;
          while Not EOF do
          Begin
            cdsClientes.DisableControls;
            cdsClientes.Filtered := False;
            Case StrToInt(edtOpcao.Text) Of
            1: cdsClientes.Filter := ' CODCLI = ' + QuotedStr(FieldByName('CODCLI').AsString)  + ' AND ' +
                                     ' CODREP = ' + QuotedStr(FieldByName('CODREP').AsString);
            2: cdsClientes.Filter := ' CODCLI = ' + QuotedStr(FieldByName('CODCLI').AsString)  + ' AND ' +
                                     ' CODVEN = ' + QuotedStr(FieldByName('CODVEN').AsString);
            3: cdsClientes.Filter := ' CODCLI = ' + QuotedStr(FieldByName('CODCLI').AsString)  + ' AND ' +
                                     ' CODCID = ' + QuotedStr(FieldByName('CODCID').AsString);
            4,
            5: cdsClientes.Filter := ' CODCLI = ' + QuotedStr(FieldByName('CODCLI').AsString);
            end;
            cdsClientes.Filtered := True;
            cdsClientes.EnableControls;

            if (cdsClientes.IsEmpty) then
              cdsClientes.Insert
            Else
              cdsClientes.Edit;

            cdsClientes.FieldByName('BAIRRO').AsString := FieldByName('BAIRRO').AsString;
            cdsClientes.FieldByName('CODATI').AsString := FieldByName('CODATI').AsString;
            cdsClientes.FieldByName('CODDIV').AsString := FieldByName('CODDIV').AsString;
            cdsClientes.FieldByName('VENATU').AsString := FieldByName('VENATU').AsString;
            cdsClientes.FieldByName('REPATU').AsString := FieldByName('REPATU').AsString;
            cdsClientes.FieldByName('CODCID').AsString := FieldByName('CODCID').AsString;
            cdsClientes.FieldByName('CODCLI').AsString := FieldByName('CODCLI').AsString;
            cdsClientes.FieldByName('CODFOR').AsString := FieldByName('CODFOR').AsString;            
            cdsClientes.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
            cdsClientes.FieldByName('CODGRU').AsString := FieldByName('CODGRU').AsString;
            cdsClientes.FieldByName('CODMAR').AsString := FieldByName('CODMAR').AsString;
            cdsClientes.FieldByName('CODVEN').AsString := FieldByName('CODVEN').AsString;
            cdsClientes.FieldByName('CODREP').AsString := FieldByName('CODREP').AsString;
            cdsClientes.FieldByName('C_G_C_').AsString := FieldByName('C_G_C_').AsString;

            For intContador := 0 To fGetNroColunas() Do
            Begin
              cdsClientes.FieldByName('DATA0' + IntToStr(intContador + 1)).AsFloat := FieldByName('DATA0' + IntToStr(intContador + 1)).AsFloat;
            End;

            cdsClientes.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
            cdsClientes.FieldByName('DESGRU').AsString := FieldByName('DESGRU').AsString;
            cdsClientes.FieldByName('DESMAR').AsString := FieldByName('DESMAR').AsString;
            cdsClientes.FieldByName('ENDERE').AsString := FieldByName('ENDERE').AsString;
            cdsClientes.FieldByName('ESTADO').AsString := FieldByName('ESTADO').AsString;
            cdsClientes.FieldByName('FONE01').AsString := FieldByName('FONE01').AsString;
            cdsClientes.FieldByName('NOMCID').AsString := FieldByName('NOMCID').AsString;
            cdsClientes.FieldByName('NOMVEN').AsString := FieldByName('NOMVEN').AsString;
            cdsClientes.FieldByName('NOMREP').AsString := FieldByName('NOMREP').AsString;
            cdsClientes.FieldByName('NOMFOR').AsString := FieldByName('NOMFOR').AsString;
            cdsClientes.FieldByName('NOMATI').AsString := FieldByName('NOMATI').AsString;
            cdsClientes.FieldByName('NOMCLI').AsString := FieldByName('NOMCLI').AsString;
            cdsClientes.FieldByName('QUEBRA').AsString := FieldByName('QUEBRA').AsString;
            cdsClientes.FieldByName('TOTDTA').AsFloat  := FieldByName('TOTDTA').AsFloat;
            cdsClientes.Post;

            pgbProgresso.Position := pgbProgresso.Position + 1;
            Next;
          End;        
        End;

        cdsVendas.Data := cdsClientes.Data;
        cdsVendas.Close;
        cdsVendas.Open;
      End;

      pgbProgresso.Position := 0;
      pgbProgresso.Visible  := False;

      cdsVendas.First;

      If Not cdsVendas.IsEmpty Then
      Begin

        If (edtDestino.Text = 'E') Then
        Begin
          pGeraExcel(cdsVendas);
          btnImprimir.Enabled := True;
          pnlInfo.Caption := '';
          Exit;
        End;

        Try
          If (Not (chkRefPro.Checked)) And (Not (chkMarPro.Checked)) Then
          Begin
            pCriarFormularios(TfrmQckFatEvolVendas,frmQckFatEvolVendas);

            frmQckFatEvolVendas.intQtdReg := 0;

            If chkCurva.Checked Then
              frmQckFatEvolVendas.intMaxReg := StrToIntDef(edtNumCli.Text, 0)
            Else
              frmQckFatEvolVendas.intMaxReg := 0;

            frmQckFatEvolVendas.dtsVendas.DataSet := cdsVendas;

            If strTipImp = 'M' Then
              frmQckFatEvolVendas.qckPagina.DefaultFilter := rldFiltro
            Else
              frmQckFatEvolVendas.qckPagina.DefaultFilter := Nil;

            {**************************}
            {* CABECALHO DO RELATORIO *}
            {***********************AF*}
            frmQckFatEvolVendas.intOpcao := StrToIntDef(edtOpcao.Text, 0);
            frmQckFatEvolVendas.strNomCliente    := fStrTitulo(edtCodCliente.Text,edtDesCliente,arrLinhaClien,strLinCli,'CLIENTE');
            frmQckFatEvolVendas.strNomVendedor   := fStrTitulo(strCodVen,edtDesVendedor,arrLinhaVende,strLinVen,'VENDEDOR');
            frmQckFatEvolVendas.strRepresentante := fStrTitulo(strCodRep,edtDesRepresentante,arrLinhaRepre,strLinRep,'REPRESENTANTE');
            frmQckFatEvolVendas.strFornecedor    := fStrTitulo(edtFornecedor.Text,edtDesFornecedor,arrLinhaForne,strLinFor,'FORNECEDOR');
            frmQckFatEvolVendas.strMarca         := fStrTitulo(edtCodMarca.Text,edtNomMarca,arrLinhaMarca,strLinMar,'MARCA',True);
            frmQckFatEvolVendas.strAtividade     := fStrTitulo(edtCodAti.Text,edtDesAti,arrLinAti,strLinAti,'ATIVIDADE',True);
            frmQckFatEvolVendas.strDepartamento  := fStrTitulo(edtCodDep.Text,edtDesDep,arrDepart,strDepart,'DEPARTAMENTO');            
            frmQckFatEvolVendas.strRedeLojas     := fStrTitulo(edtCodRed.Text,edtDesRed,arrRedeLojas,strRedLojas,'REDE DE LOJAS',True);
            frmQckFatEvolVendas.strCidade        := fStrTitulo(edtCodCidade.Text,edtDesCidade,arrLinhaCidad,strLinCid,'CIDADE',True);
            frmQckFatEvolVendas.strNomProduto    := fStrTitulo(edtCodProduto.Text,edtDesProduto,arrProduto,strLinPro,'PRODUTO');
            frmQckFatEvolVendas.strNomUnidade    := fStrTitulo(edtCodUnidade.Text,edtDesUnidade,arrUnidade,strLinUni,'UNIDADE',True);
            frmQckFatEvolVendas.strGruCmp        := fStrTitulo(edtGruCmp.Text,edtDesGruCmp, arrGruCmp, strGruCmp,'GRUPO DE COMPRA');
            frmQckFatEvolVendas.strLinhaGrupo    := fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo,strLinGru,'LINHA/GRUPO',True);
            frmQckFatEvolVendas.strLinhaGrupoExc := fStrTitulo(mskLinhaGrupoExcluir.Text,edtDesGrupoExcluir,arrLinhaGrupoExc,strLinGruExc,'LINHA/GRUPO A EXCLUIR',True,True);
            frmQckFatEvolVendas.strProfissional  := fStrTitulo(edtCodProfis.Text,edtNomProfis,arrProfis,strProfis,'PROFISSIONAL');
            frmQckFatEvolVendas.strRegiao        := fStrTitulo(edtCodReg.Text,edtDesReg,arrRegiao,strRegiao,'REGIAO',True);
            frmQckFatEvolVendas.strSubReg        := fStrTitulo(edtCodSub.Text,edtDesSub,arrSubReg,strSubReg,'SUB-REGIAO',True);
            frmQckFatEvolVendas.strOrdem         := 'MES BASE: ' + mskMesBas.Text;
            frmQckFatEvolVendas.strDepIte        := fStrTitulo(edtDepIte.Text, edtDesDepIte, arrDepIte, strDepIte, 'DEPARTAMENTO DO PRODUTO');

            frmQckFatEvolVendas.rllEmpresa.Caption   := fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmpresa, strEmpresa, 'EMPRESA');
            frmQckFatEvolVendas.rllEmpresa.Caption   := frmQckFatEvolVendas.rllEmpresa.Caption + IfThen(edtEmpFat.Text='P', ' (Pedido)', ' (Faturamento)');
            frmQckFatEvolVendas.rllCategoria.Caption := 'CATEGORIA: ' + IfThen(fEmptyStr(cbbCategoria.Text), 'TODAS',  cbbCategoria.Text);
            frmQckFatEvolVendas.rllCidExc.Caption    := IfThen(fEmptyStr(edtCodCidExc.Text), 'CIDADES A EXCLUIR:NENHUMA',
                 fStrTitulo(edtCodCidExc.Text,edtDesCidExc,arrCidExc,strCidExc,'CIDADES A EXCLUIR',True));

            Case StrToInt(edtOpcao.Text) Of
               1: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR REPRESENTANTE/CLIENTE ';
               2: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/CLIENTE '     ;
               3: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR CIDADE/CLIENTE '       ;
               4: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE '              ;
               5: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE 2 '            ;
               6: Begin
                    frmQckFatEvolVendas.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR FORNECEDOR/PRODUTO ';
                    frmQckFatEvolVendas.rllCliente.Caption := 'PRODUTO';
                  End;
               7: Begin
                    frmQckFatEvolVendas.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/CIDADE';
                    frmQckFatEvolVendas.rllCliente.Caption := 'CIDADE';
                  End;
               8: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR ATIVIDADE';
               9: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR REPRESENTANTE'         ;
              10: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR FORNECEDOR'           ;
              11: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR LINHA/GRUPO'          ;
              12: Begin
                    frmQckFatEvolVendas.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE/PRODUTO'    ;
                    frmQckFatEvolVendas.rllCliente.Caption := 'PRODUTO';
                  End;
              13: Begin
                    frmQckFatEvolVendas.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/ATIVIDADE';
                    frmQckFatEvolVendas.rllCliente.Caption := 'ATIVIDADE';
                  End;
              14: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR MARCA';
              15: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR CIDADE';
              16: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR REPRESENTANTE ATUAL/CLIENTE';
              17: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR ATUAL/CLIENTE';
              18: Begin
                    frmQckFatEvolVendas.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/MARCA';
                    frmQckFatEvolVendas.rllCliente.Caption := 'MARCA';
                  End;
              19: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR' ;
              20: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR PROFISSIONAL' ;
              21: Begin
                    frmQckFatEvolVendas.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/PRODUTO';
                    frmQckFatEvolVendas.rllCliente.Caption := 'PRODUTO';
                  End;
              22: frmQckFatEvolVendas.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR LINHA' ;
              23: Begin
                    frmQckFatEvolVendas.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR CIDADE/PRODUTO';
                    frmQckFatEvolVendas.rllCliente.Caption := 'PRODUTO';
                  End;
              24: Begin
                    frmQckFatEvolVendas.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE/LINHA';
                    frmQckFatEvolVendas.rllCliente.Caption := 'LINHA';
                  End;
              25: Begin
                    frmQckFatEvolVendas.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR EMPRESA';
                    frmQckFatEvolVendas.rllCliente.Caption := 'EMPRESA';
                  End;
            End;

            If (Pos(fStrZero(edtOpcao.Text,2), '06_12_21_23_') > 0) Then
            Begin
              frmQckFatEvolVendas.rdbCodIte.Visible := True;
            End
            Else If (StrToIntDef(edtOpcao.Text,0) In [7,13,24]) Then
            Begin
              frmQckFatEvolVendas.rdbCodCid.Visible := True;
            End
            Else If (StrToIntDef(edtOpcao.Text,0) = 18) Then
            Begin
              frmQckFatEvolVendas.rdbCodMar.Visible := True;
            End
            Else
            Begin
              frmQckFatEvolVendas.rdbCodCli.Visible := True;
            End;

            {**************************************}
            {* RENOMEIA AS COLUNAS                *}
            {***********************************AF*}
            For intContador := fGetNroColunas() DownTo fGetNroColunas() - (StrToInt(edtQtdMes.Text) - 1) Do
            Begin
              If intContador > 4 Then
              Begin
                rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo,'rllMes' + IntToStr(intContador + 1)) As TRLLabel);

                If edtDestino.Text <> 'E' Then Begin
                  rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatas[intContador]),2))]) + String(AnsiStrings.RightStr(arrDatas[intContador],5));
                End Else Begin
                  rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatasExcel[intContador]),2))]) + String(AnsiStrings.RightStr(arrDatasExcel[intContador],5));
                End;

                rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo2,'rllMes2' + IntToStr(intContador + 1)) As TRLLabel);

                If edtDestino.Text <> 'E' Then Begin
                  rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatas[intContador]),2))]) + String(AnsiStrings.RightStr(arrDatas[intContador],5));
                End Else Begin
                  rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatasExcel[intContador]),2))]) + String(AnsiStrings.RightStr(arrDatasExcel[intContador],5));
                End;

                rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo4,'rllMes4' + IntToStr(intContador + 1)) As TRLLabel);

                If edtDestino.Text <> 'E' Then Begin
                  rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatas[intContador]),2))]) + String(AnsiStrings.RightStr(arrDatas[intContador],5));
                End Else Begin
                  rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatasExcel[intContador]),2))]) + String(AnsiStrings.RightStr(arrDatasExcel[intContador],5));
                End;

                rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo5,'rllMes5' + IntToStr(intContador + 1)) As TRLLabel);

                If edtDestino.Text <> 'E' Then Begin
                  rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatas[intContador]),2))]) + String(AnsiStrings.RightStr(arrDatas[intContador],5));
                End Else Begin
                  rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatasExcel[intContador]),2))]) + String(AnsiStrings.RightStr(arrDatasExcel[intContador],5));
                End;
              End;
              rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo3,'rllMes3' + IntToStr(intContador + 1)) As TRLLabel);

              If edtDestino.Text <> 'E' Then Begin
                rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatas[intContador]),2))]) + String(AnsiStrings.RightStr(arrDatas[intContador],5));
              End Else Begin
                rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatasExcel[intContador]),2))]) + String(AnsiStrings.RightStr(arrDatasExcel[intContador],5));
              End;
            End;

            {*********************************}
            {* SETA COLUNAS QUE SERÃO USADAS *}
            {******************************AF*}
            For intContador := fGetNroColunas() + 1 DownTo ((fGetNroColunas() + 1 - StrToInt(edtQtdMes.Text)) + 1) Do
            Begin

              If intContador > 5 Then
              Begin
                rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo,'rllMes' + IntToStr(intContador)) As TRLLabel);
                rllLabel.Visible := True;
                rdbLabel := (fComponentByName(frmQckFatEvolVendas.rlbDetalheGrupo,'rdbDta00' + IntToStr(intContador)) As TRLDBText);
                rdbLabel.Visible := True;
                rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbResumoGrupo,'rdbTotDta' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;
                rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbTotalGeral,'rdbGerDta' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;

                rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo2,'rllMes2' + IntToStr(intContador)) As TRLLabel);
                rllLabel.Visible := True;
                rdbLabel := (fComponentByName(frmQckFatEvolVendas.rlbDetalhe,'rdbDta002' + IntToStr(intContador)) As TRLDBText);
                rdbLabel.Visible := True;
                rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbSumario2,'rdbTotDta2' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;

                rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo4,'rllMes4' + IntToStr(intContador)) As TRLLabel);
                rllLabel.Visible := True;
                rdbLabel := (fComponentByName(frmQckFatEvolVendas.rlbDetalhe4,'rdbDta004' + IntToStr(intContador)) As TRLDBText);
                rdbLabel.Visible := True;
                rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbSumario4,'rdbTot4Dta' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;

                rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo5,'rllMes5' + IntToStr(intContador)) As TRLLabel);
                rllLabel.Visible := True;
                rdbLabel := (fComponentByName(frmQckFatEvolVendas.rlbDetalhe5,'rdbDta005' + IntToStr(intContador)) As TRLDBText);
                rdbLabel.Visible := True;
                rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbSumario5,'rdbTot5Dta' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;
              End;

              rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo3,'rllMes3' + IntToStr(intContador)) As TRLLabel);
              rllLabel.Visible := True;
              rdbLabel := (fComponentByName(frmQckFatEvolVendas.rlbDetalhe2,'rdbDta003' + IntToStr(intContador)) As TRLDBText);
              rdbLabel.Visible := True;
              rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbSumario3,'rdbTotDta3' + IntToStr(intContador)) As TRLDBResult);
              rdbResult.Visible := True;

            End;

            rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo,'rllTotDta') As TRLLabel);
            rllLabel.Visible := True;
            rdbLabel := (fComponentByName(frmQckFatEvolVendas.rlbDetalheGrupo,'rdbTotDta') As TRLDBText);
            rdbLabel.Visible := True;
            rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbResumoGrupo,'rdbTotDtaTot') As TRLDBResult);
            rdbResult.Visible := True;
            rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbTotalGeral,'rdbTotDtaGer') As TRLDBResult);
            rdbResult.Visible := True;

            rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo2,'rllTot132') As TRLLabel);
            rllLabel.Visible := True;
            rdbLabel := (fComponentByName(frmQckFatEvolVendas.rlbDetalhe,'rdbTotDta132') As TRLDBText);
            rdbLabel.Visible := True;
            rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbSumario2,'rdbTotDtaGer132') As TRLDBResult);
            rdbResult.Visible := True;

            rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo3,'rllTot1322') As TRLLabel);
            rllLabel.Visible := True;
            rdbLabel := (fComponentByName(frmQckFatEvolVendas.rlbDetalhe2,'rdbTotDta1322') As TRLDBText);
            rdbLabel.Visible := True;
            rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbSumario3,'rdbTotDtaGer1322') As TRLDBResult);
            rdbResult.Visible := True;

            rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo4,'rllTotAti') As TRLLabel);
            rllLabel.Visible := True;
            rdbLabel := (fComponentByName(frmQckFatEvolVendas.rlbDetalhe4,'rdbTotDtaAti') As TRLDBText);
            rdbLabel.Visible := True;
            rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbSumario4,'rdbTotDtaTotAti') As TRLDBResult);
            rdbResult.Visible := True;

            rllLabel := (fComponentByName(frmQckFatEvolVendas.rlbTitulo5,'rllTotMar') As TRLLabel);
            rllLabel.Visible := True;
            rdbLabel := (fComponentByName(frmQckFatEvolVendas.rlbDetalhe5,'rdbTotDtaMar') As TRLDBText);
            rdbLabel.Visible := True;
            rdbResult := (fComponentByName(frmQckFatEvolVendas.rlbSumario5,'rdbTotDtaTotMar') As TRLDBResult);
            rdbResult.Visible := True;

            {**************************************}
            {* SE FOR OPCAO CLIENTE É 132 COLUNAS *}
            {***********************************AF*}
            If StrToIntDef(edtOpcao.Text,0) = 4 Then
            Begin
              frmQckFatEvolVendas.strTipImp := strTipImp;
              If strTipImp = 'M' Then
              Begin
                frmQckFatEvolVendas.qckPagina.PageSetup.PaperSize   := fpCustom;
                frmQckFatEvolVendas.qckPagina.PageSetup.PaperHeight := 280;
                frmQckFatEvolVendas.qckPagina.PageSetup.PaperWidth  := 350;
              End
              Else
              Begin
                frmQckFatEvolVendas.qckPagina.PageSetup.Orientation := poLandscape;
                frmQckFatEvolVendas.qckPagina.Margins.LeftMargin    := 4;
                frmQckFatEvolVendas.qckPagina.Margins.RightMargin   := 1;
                frmQckFatEvolVendas.rllPagina.Left                  := 970;
                frmQckFatEvolVendas.rllDataRelatorio.Width          := 997;
              End;

              frmQckFatEvolVendas.RLPanel1.Left := frmQckFatEvolVendas.rllTot132.Left;
              frmQckFatEvolVendas.rlbTitulo.Visible     := False;
              frmQckFatEvolVendas.rlbGrupo.Visible      := False;
              frmQckFatEvolVendas.rlbTotalGeral.Visible := False;

              frmQckFatEvolVendas.rlbTitulo3.Visible  := False;
              frmQckFatEvolVendas.rlbDetalhe2.Visible := False;
              frmQckFatEvolVendas.rlbSumario3.Visible := False;

              frmQckFatEvolVendas.rlbTitulo4.Visible := False;
              frmQckFatEvolVendas.rlbDetalhe4.Visible := False;
              frmQckFatEvolVendas.rlbSumario4.Visible := False;

              frmQckFatEvolVendas.rlbTitulo5.Visible := False;
              frmQckFatEvolVendas.rlbDetalhe5.Visible := False;
              frmQckFatEvolVendas.rlbSumario5.Visible := False;
            End
            {**************************************}
            {* SE FOR CLIENTE 2 EH 132 COLUNAS    *}
            {***********************************AF*}
            Else If StrToIntDef(edtOpcao.Text,0) = 5 Then
            Begin

              If strTipImp = 'M' Then
              Begin
                frmQckFatEvolVendas.qckPagina.PageSetup.PaperSize   := fpCustom;
                frmQckFatEvolVendas.qckPagina.PageSetup.PaperHeight := 280;
                frmQckFatEvolVendas.qckPagina.PageSetup.PaperWidth  := 350;
              End
              Else
              Begin
                frmQckFatEvolVendas.qckPagina.PageSetup.Orientation := poLandscape;
                frmQckFatEvolVendas.qckPagina.Margins.LeftMargin    := 4;
                frmQckFatEvolVendas.qckPagina.Margins.RightMargin   := 1;
                frmQckFatEvolVendas.rllPagina.Left                  := 970;
                frmQckFatEvolVendas.rllDataRelatorio.Width          := 997;
              End;

              frmQckFatEvolVendas.RLPanel1.Left := frmQckFatEvolVendas.rllTot1322.Left;
              frmQckFatEvolVendas.rlbTitulo.Visible     := False;
              frmQckFatEvolVendas.rlbGrupo.Visible      := False;
              frmQckFatEvolVendas.rlbTotalGeral.Visible := False;

              frmQckFatEvolVendas.rlbTitulo2.Visible  := False;
              frmQckFatEvolVendas.rlbDetalhe.Visible  := False;
              frmQckFatEvolVendas.rlbSumario2.Visible := False;

              frmQckFatEvolVendas.rlbTitulo4.Visible := False;
              frmQckFatEvolVendas.rlbDetalhe4.Visible := False;
              frmQckFatEvolVendas.rlbSumario4.Visible := False;

              frmQckFatEvolVendas.rlbTitulo5.Visible := False;
              frmQckFatEvolVendas.rlbDetalhe5.Visible := False;
              frmQckFatEvolVendas.rlbSumario5.Visible := False;
            End
            Else
            Begin
              If Pos(fStrZero(edtOpcao.Text,2), '08_09_10_11_19_20_22') > 0 Then
              Begin
                frmQckFatEvolVendas.qckPagina.PageSetup.PaperSize := fpLetter;

                frmQckFatEvolVendas.rlbTitulo.Visible     := False;
                frmQckFatEvolVendas.rlbGrupo.Visible      := False;
                frmQckFatEvolVendas.rlbTotalGeral.Visible := False;

                frmQckFatEvolVendas.rlbTitulo2.Visible  := False;
                frmQckFatEvolVendas.rlbDetalhe.Visible  := False;
                frmQckFatEvolVendas.rlbSumario2.Visible := False;

                frmQckFatEvolVendas.rlbTitulo3.Visible  := False;
                frmQckFatEvolVendas.rlbDetalhe2.Visible := False;
                frmQckFatEvolVendas.rlbSumario3.Visible := False;

                frmQckFatEvolVendas.rlbTitulo5.Visible := False;
                frmQckFatEvolVendas.rlbDetalhe5.Visible := False;
                frmQckFatEvolVendas.rlbSumario5.Visible := False;

                Case StrToInt(edtOpcao.Text) Of
                  8:  frmQckFatEvolVendas.rllAtividade.Caption := 'ATIVIDADE';
                  9:  frmQckFatEvolVendas.rllAtividade.Caption := 'REPRESENTANTE';
                  10: frmQckFatEvolVendas.rllAtividade.Caption := 'FORNECEDOR';
                  11: frmQckFatEvolVendas.rllAtividade.Caption := 'LINHA/GRUPO';
                  19: frmQckFatEvolVendas.rllAtividade.Caption := 'VENDEDOR';
                  20: frmQckFatEvolVendas.rllAtividade.Caption := 'PROFISSIONAL';
                  22: frmQckFatEvolVendas.rllAtividade.Caption := 'LINHA';
                End;
              End
              Else If Pos(fStrZero(edtOpcao.Text,2), '14_15_25_') > 0 Then
              Begin
                frmQckFatEvolVendas.qckPagina.PageSetup.PaperSize := fpLetter;

                frmQckFatEvolVendas.rlbTitulo.Visible     := False;
                frmQckFatEvolVendas.rlbGrupo.Visible      := False;
                frmQckFatEvolVendas.rlbTotalGeral.Visible := False;

                frmQckFatEvolVendas.rlbTitulo2.Visible  := False;
                frmQckFatEvolVendas.rlbDetalhe.Visible  := False;
                frmQckFatEvolVendas.rlbSumario2.Visible := False;

                frmQckFatEvolVendas.rlbTitulo3.Visible  := False;
                frmQckFatEvolVendas.rlbDetalhe2.Visible := False;
                frmQckFatEvolVendas.rlbSumario3.Visible := False;

                frmQckFatEvolVendas.rlbTitulo4.Visible := False;
                frmQckFatEvolVendas.rlbDetalhe4.Visible := False;
                frmQckFatEvolVendas.rlbSumario4.Visible := False;

                Case StrToInt(edtOpcao.Text) Of
                  14: frmQckFatEvolVendas.rllMarca.Caption := 'MARCA';
                  15: frmQckFatEvolVendas.rllMarca.Caption := 'CIDADE';
                  25: frmQckFatEvolVendas.rllMarca.Caption := 'EMPRESA';
                End;
              End
              Else
              Begin
                frmQckFatEvolVendas.qckPagina.PageSetup.PaperSize := fpLetter;
                frmQckFatEvolVendas.rlbTitulo2.Visible  := False;
                frmQckFatEvolVendas.rlbDetalhe.Visible  := False;
                frmQckFatEvolVendas.rlbSumario2.Visible := False;

                frmQckFatEvolVendas.rlbTitulo3.Visible  := False;
                frmQckFatEvolVendas.rlbDetalhe2.Visible := False;
                frmQckFatEvolVendas.rlbSumario3.Visible := False;

                frmQckFatEvolVendas.rlbTitulo4.Visible := False;
                frmQckFatEvolVendas.rlbDetalhe4.Visible := False;
                frmQckFatEvolVendas.rlbSumario4.Visible := False;

                frmQckFatEvolVendas.rlbTitulo5.Visible := False;
                frmQckFatEvolVendas.rlbDetalhe5.Visible := False;
                frmQckFatEvolVendas.rlbSumario5.Visible := False;
              End;
            End;

            If edtDestino.Text = 'V' Then
              frmQckFatEvolVendas.qckPagina.PreviewModal
            Else
            begin
              if ( strNomImp <> '' ) or ( strTipImp <> '' ) then
              frmQckFatEvolVendas.qckPagina.Print;
            end;
          End
          Else
          Begin
            pCriarFormularios(TfrmQckFatEvolVendasPaisagem,frmQckFatEvolVendasPaisagem);

            frmQckFatEvolVendasPaisagem.intQtdReg := 0;

            If chkCurva.Checked Then
              frmQckFatEvolVendasPaisagem.intMaxReg := StrToIntDef(edtNumCli.Text, 0)
            Else
              frmQckFatEvolVendasPaisagem.intMaxReg := 0;

            frmQckFatEvolVendasPaisagem.dtsVendas.DataSet := cdsVendas;

            If strTipImp = 'M' Then
              frmQckFatEvolVendasPaisagem.qckPagina.DefaultFilter := rldFiltro
            Else
              frmQckFatEvolVendasPaisagem.qckPagina.DefaultFilter := Nil;

            {**************************}
            {* CABECALHO DO RELATORIO *}
            {***********************AF*}
            frmQckFatEvolVendasPaisagem.intOpcao := StrToIntDef(edtOpcao.Text, 0);
            frmQckFatEvolVendasPaisagem.strNomCliente    := fStrTitulo(edtCodCliente.Text,edtDesCliente,arrLinhaClien,strLinCli,'CLIENTE');
            frmQckFatEvolVendasPaisagem.strNomVendedor   := fStrTitulo(strCodVen,edtDesVendedor,arrLinhaVende,strLinVen,'VENDEDOR');
            frmQckFatEvolVendasPaisagem.strRepresentante := fStrTitulo(strCodRep,edtDesRepresentante,arrLinhaRepre,strLinRep,'REPRESENTANTE');
            frmQckFatEvolVendasPaisagem.strFornecedor    := fStrTitulo(edtFornecedor.Text,edtDesFornecedor,arrLinhaForne,strLinFor,'FORNECEDOR');
            frmQckFatEvolVendasPaisagem.strMarca         := fStrTitulo(edtCodMarca.Text,edtNomMarca,arrLinhaMarca,strLinMar,'MARCA',True);
            frmQckFatEvolVendasPaisagem.strAtividade     := fStrTitulo(edtCodAti.Text,edtDesAti,arrLinAti,strLinAti,'ATIVIDADE',True);
            frmQckFatEvolVendasPaisagem.strDepartamento  := fStrTitulo(edtCodDep.Text,edtDesDep,arrDepart,strDepart,'DEPARTAMENTO');
            frmQckFatEvolVendasPaisagem.strRedeLojas     := fStrTitulo(edtCodRed.Text,edtDesRed,arrRedeLojas,strRedLojas,'REDE DE LOJAS',True);
            frmQckFatEvolVendasPaisagem.strCidade        := fStrTitulo(edtCodCidade.Text,edtDesCidade,arrLinhaCidad,strLinCid,'CIDADE',True);
            frmQckFatEvolVendasPaisagem.strNomProduto    := fStrTitulo(edtCodProduto.Text,edtDesProduto,arrProduto,strLinPro,'PRODUTO');
            frmQckFatEvolVendasPaisagem.strNomUnidade    := fStrTitulo(edtCodUnidade.Text,edtDesUnidade,arrUnidade,strLinUni,'UNIDADE',True);
            frmQckFatEvolVendasPaisagem.strGruCmp        := fStrTitulo(edtGruCmp.Text,edtDesGruCmp, arrGruCmp, strGruCmp,'GRUPO DE COMPRA');
            frmQckFatEvolVendasPaisagem.strLinhaGrupo    := fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo,strLinGru,'LINHA/GRUPO',True);
            frmQckFatEvolVendasPaisagem.strLinhaGrupoExc := fStrTitulo(mskLinhaGrupoExcluir.Text,edtDesGrupoExcluir,arrLinhaGrupoExc,strLinGruExc,'LINHA/GRUPO A EXCLUIR',True);
            frmQckFatEvolVendasPaisagem.strProfissional  := fStrTitulo(edtCodProfis.Text,edtNomProfis,arrProfis,strProfis,'PROFISSIONAL');
            frmQckFatEvolVendasPaisagem.strRegiao        := fStrTitulo(edtCodReg.Text,edtDesReg,arrRegiao,strRegiao,'REGIAO',True);
            frmQckFatEvolVendasPaisagem.strSubReg        := fStrTitulo(edtCodSub.Text,edtDesSub,arrSubReg,strSubReg,'SUB-REGIAO',True);
            frmQckFatEvolVendasPaisagem.strOrdem         := 'MES BASE: ' + mskMesBas.Text;
            frmQckFatEvolVendasPaisagem.strDepIte        := fStrTitulo(edtDepIte.Text, edtDesDepIte, arrDepIte, strDepIte, 'DEPARTAMENTO DO PRODUTO');

            frmQckFatEvolVendasPaisagem.rllEmpresa.Caption   := fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmpresa, strEmpresa, 'EMPRESA');
            frmQckFatEvolVendasPaisagem.rllEmpresa.Caption   := frmQckFatEvolVendasPaisagem.rllEmpresa.Caption + IfThen(edtEmpFat.Text='P', ' (Pedido)', ' (Faturamento)');
            frmQckFatEvolVendasPaisagem.rllCategoria.Caption := 'CATEGORIA: ' + IfThen(fEmptyStr(cbbCategoria.Text), 'TODAS',  cbbCategoria.Text);

            Case StrToInt(edtOpcao.Text) Of
               1: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR REPRESENTANTE/CLIENTE ';
               2: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/CLIENTE '     ;
               3: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR CIDADE/CLIENTE '       ;
               4: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE '              ;
               5: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE 2 '            ;
               6: Begin
                    frmQckFatEvolVendasPaisagem.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR FORNECEDOR/PRODUTO';
                    frmQckFatEvolVendasPaisagem.rllCliente.Caption := 'PRODUTO';
                  End;
               7: Begin
                    frmQckFatEvolVendasPaisagem.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/CIDADE';
                    frmQckFatEvolVendasPaisagem.rllCliente.Caption := 'CIDADE';
                  End;
               8: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR ATIVIDADE';
               9: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR REPRESENTANTE';
              10: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR FORNECEDOR'   ;
              11: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR LINHA/GRUPO'  ;
              12: Begin
                    frmQckFatEvolVendasPaisagem.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE/PRODUTO'    ;
                    frmQckFatEvolVendasPaisagem.rllCliente.Caption := 'PRODUTO';
                  End;
              13: Begin
                    frmQckFatEvolVendasPaisagem.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/ATIVIDADE';
                    frmQckFatEvolVendasPaisagem.rllCliente.Caption := 'ATIVIDADE';
                  End;
              14: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR MARCA';
              15: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR CIDADE';
              16: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR REPRESENTANTE ATUAL/CLIENTE ';
              17: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR ATUAL/CLIENTE '     ;
              18: Begin
                    frmQckFatEvolVendasPaisagem.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/MARCA ';
                    frmQckFatEvolVendasPaisagem.rllCliente.Caption := 'MARCA';
                  End;
              19: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR' ;
              20: frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR PROFISSIONAL' ;
              21: Begin
                    frmQckFatEvolVendasPaisagem.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/PRODUTO ';
                    frmQckFatEvolVendasPaisagem.rllCliente.Caption := 'PRODUTO';
                  End;
              22: Begin
                    frmQckFatEvolVendasPaisagem.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE VENDAS POR LINHA' ;
                    frmQckFatEvolVendasPaisagem.rllCliente.Caption := 'PRODUTO';
                  End;
              23: Begin
                    frmQckFatEvolVendasPaisagem.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR CIDADE/PRODUTO ';
                    frmQckFatEvolVendasPaisagem.rllCliente.Caption := 'PRODUTO';
                  End;
              24: Begin
                    frmQckFatEvolVendasPaisagem.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE/LINHA ';
                    frmQckFatEvolVendasPaisagem.rllCliente.Caption := 'LINHA';
                  End;
              25: Begin
                    frmQckFatEvolVendasPaisagem.strNomRelatorio    := 'RELATORIO DE EVOLUCAO DE VENDAS POR EMPRESA ';
                    frmQckFatEvolVendasPaisagem.rllCliente.Caption := 'EMPRESA';
                  End;
            End;
            frmQckFatEvolVendasPaisagem.rdbCodIte.Visible := True;

            {**************************************}
            {* RENOMEIA AS COLUNAS                *}
            {***********************************AF*}
            For intContador := fGetNroColunas() DownTo fGetNroColunas() - (StrToInt(edtQtdMes.Text) - 1) Do
            Begin
              If intContador > 4 Then
              Begin
                rllLabel := (fComponentByName(frmQckFatEvolVendasPaisagem.rlbTitulo,'rllMes' + IntToStr(intContador + 1)) As TRLLabel);

                If edtDestino.Text <> 'E' Then Begin
                  rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatas[intContador]),2))]) + RightStr(String(arrDatas[intContador]),5);
                End Else Begin
                  rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatasExcel[intContador]),2))]) + RightStr(String(arrDatasExcel[intContador]),5);
                End;
              End;
            End;

            {*********************************}
            {* SETA COLUNAS QUE SERÃO USADAS *}
            {******************************AF*}
            For intContador := fGetNroColunas() + 1 DownTo ((fGetNroColunas() + 1 - StrToInt(edtQtdMes.Text)) + 1) Do
            Begin

              If intContador > 5 Then
              Begin
                rllLabel := (fComponentByName(frmQckFatEvolVendasPaisagem.rlbTitulo,'rllMes' + IntToStr(intContador)) As TRLLabel);
                rllLabel.Visible := True;
                rdbLabel := (fComponentByName(frmQckFatEvolVendasPaisagem.rlbDetalheGrupo,'rdbDta00' + IntToStr(intContador)) As TRLDBText);
                rdbLabel.Visible := True;
                rdbResult := (fComponentByName(frmQckFatEvolVendasPaisagem.rlbResumoGrupo,'rdbTotDta' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;
                rdbResult := (fComponentByName(frmQckFatEvolVendasPaisagem.rlbTotalGeral,'rdbGerDta' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;
              End;
            End;

            rllLabel := (fComponentByName(frmQckFatEvolVendasPaisagem.rlbTitulo,'rllTotDta') As TRLLabel);
            rllLabel.Visible := True;
            rdbLabel := (fComponentByName(frmQckFatEvolVendasPaisagem.rlbDetalheGrupo,'rdbTotDta') As TRLDBText);
            rdbLabel.Visible := True;
            rdbResult := (fComponentByName(frmQckFatEvolVendasPaisagem.rlbResumoGrupo,'rdbTotDtaTot') As TRLDBResult);
            rdbResult.Visible := True;
            rdbResult := (fComponentByName(frmQckFatEvolVendasPaisagem.rlbTotalGeral,'rdbTotDtaGer') As TRLDBResult);
            rdbResult.Visible := True;

            frmQckFatEvolVendasPaisagem.qckPagina.PageSetup.PaperSize := fpLetter;

            If edtDestino.Text = 'V' Then
              frmQckFatEvolVendasPaisagem.qckPagina.PreviewModal
            Else
              if ( strNomImp <> '' ) or ( strTipImp <> '' ) then
              frmQckFatEvolVendasPaisagem.qckPagina.Print;
          End;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;

        If (Not (chkRefPro.Checked)) And (Not (chkMarPro.Checked)) Then
          pFreeAndNil(frmQckFatEvolVendas)
        Else
          pFreeAndNil(frmQckFatEvolVendasPaisagem);
      End
      Else
        pTabelaVazia;

    End;
  End;

  strNomImp := '';
  strTipImp := '';

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

end;

procedure TfrmRelFatEvolVendas.pIncluiNoClient;
  Var
    intContador: Integer;
    strLocate: String;
    KeyValues: Variant;
    strFieldName : String;
Begin
  With QryRelatorio Do
  Begin
    First;
    While Not Eof Do
    Begin
      pCamposLocate(strLocate, KeyValues);
      If cdsVendas.Locate(strLocate, KeyValues, []) Then
      Begin
        cdsVendas.Edit;

        For intContador := 0 To Fields.Count - 1 Do
        Begin
          strFieldName := Fields[intContador].FieldName;
          If (Pos('DATA0', strFieldName) > 0) Or
             (Pos('TOTDTA', strFieldName) > 0) Then
          Begin
            cdsVendas.FieldByName(strFieldName).Value := cdsVendas.FieldByName(strFieldName).Value + QryRelatorio.FieldByName(strFieldName).Value ;
          End;
        End;

      End
      Else
      Begin
        cdsVendas.Insert;

        For intContador := 0 To Fields.Count - 1 do
          cdsVendas.Fields[intContador].Value := Fields[intContador].Value;
      End;

      cdsVendas.Post;
      Next;
    End;
  End;
End;

procedure TfrmRelFatEvolVendas.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
  Var
    strLegend: String;
    intCont : Integer;
begin
  With Excel Do
  Begin
    If (Copy(Quebra.ValorAtual,1,3) = 'REP') Then
      strLegend := 'TOTAL DO REPRESENTANTE: '
    Else If (Copy(Quebra.ValorAtual,1,3) = 'VEN') Then
      strLegend := 'TOTAL DO VENDEDOR: '
    Else If (Copy(Quebra.ValorAtual,1,3) = 'CID') Then
      strLegend := 'TOTAL DA CIDADE: '
    Else If (Copy(Quebra.ValorAtual,1,3) = 'FOR') Then
      strLegend := 'TOTAL DA FORNECEDOR: '
    Else If (Copy(Quebra.ValorAtual,1,3) = 'CLI') Then
      strLegend := 'TOTAL DO CLIENTE: '
    Else
      strLegend := 'TOTAL GERAL: ';

    ProximaLinha;
    Escrever(LinhaAtual, Campos.Colunas.Count - (StrToInt(edtQtdMes.Text)+1), strLegend);
    Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count - (StrToInt(edtQtdMes.Text)+1)) + IntToStr(LinhaAtual));

    For intCont := fGetNroColunas() - (StrToInt(edtQtdMes.Text) - 1) To fGetNroColunas() Do
    Begin
      Escrever(LinhaAtual,
               Campos.ColunaPorNome['DATA0' + IntToStr(intCont+1)].Coluna,
               fPadL(FormatFloat('##,#0.00', Quebra.Totais['DATA0' + IntToStr(intCont+1)]), 14));
    End;

    Escrever(LinhaAtual,
             Campos.ColunaPorNome['TOTDTA'].Coluna,
             fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTDTA']), 14));

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);
  End;
end;

procedure TfrmRelFatEvolVendas.pSetarIndiceClientVendas;
begin
  If chkCurva.Checked Then
  Begin
    cdsVendas.IndexDefs[0].Fields := 'TOTDTA';
    cdsVendas.IndexDefs[0].Options := cdsVendas.IndexDefs[0].Options + [ixDescending];
  End
  Else
  Begin
    cdsVendas.IndexDefs[0].Fields := 'QUEBRA';

    If (StrToIntDef(edtOpcao.Text,0) = 7) Then
      cdsVendas.IndexDefs[0].Fields := 'QUEBRA;NOMCID';

    If (StrToIntDef(edtOpcao.Text,0) = 13) Then
      cdsVendas.IndexDefs[0].Fields := 'QUEBRA;NOMATI';

    If (StrToIntDef(edtOpcao.Text,0) = 18) Then
      cdsVendas.IndexDefs[0].Fields := 'QUEBRA;DESMAR';

    If (StrToIntDef(edtOpcao.Text,0) = 21) Then
      cdsVendas.IndexDefs[0].Fields := 'QUEBRA;DESITE';

    If (StrToIntDef(edtOpcao.Text,0) = 23) Then
      cdsVendas.IndexDefs[0].Fields := 'QUEBRA;DESITE';

    If (StrToIntDef(edtOpcao.Text,0) = 24) Then
      cdsVendas.IndexDefs[0].Fields := 'QUEBRA;LINHA';

    If (StrToIntDef(edtOpcao.Text,0) = 25) Then
      cdsVendas.IndexDefs[0].Fields := 'QUEBRA;CODEMP';

    cdsVendas.IndexDefs[0].Options := cdsVendas.IndexDefs[0].Options - [ixDescending];
  End;
end;

procedure TfrmRelFatEvolVendas.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
  Var
    intCont : Integer;
begin
  For intCont := fGetNroColunas() - (StrToInt(edtQtdMes.Text) - 1) To fGetNroColunas() Do
  Begin
    Totais['DATA0' + IntToStr(intCont+1)] := Totais['DATA0' + IntToStr(intCont+1)] + Dados.FieldByName('DATA0' + IntToStr(intCont+1)).AsFloat;
  End;
  Totais['TOTDTA'] := Totais['TOTDTA'] + Dados.FieldByName('TOTDTA').AsFloat;
end;

procedure TfrmRelFatEvolVendas.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqItem(conIteSimples, Self, edtCodProduto, edtDesProduto, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') then
  Begin
    if fvalidaCampos(edtCodProduto,False) then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendas.edtCodProfisKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  If fPesqDiversos(Self, edtCodProfis, edtNomProfis, Nil, Key, arrProfis, False) Then
  Begin
    If fValidaCampos(edtCodProfis, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendas.edtCodUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtCodUnidade, edtDesUnidade, nil, nil, Key, arrUnidade, False) Then
  Begin
    fvalidaCampos(edtCodUnidade,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

{*******************************************}
{* GERAR RELATÓRIO EM PLANILHA EXCEL       *}
{****************************************RL*}
procedure TfrmRelFatEvolVendas.pGeraExcel(qryDados: TDataSet);
  Var
    objExcel: TGeraExcel;
    strCaixa : String;
    intOpcao,
    intQtdMes,
    intCont : Integer;
begin
  objExcel  := TGeraExcel.Create(qryDados, pgbProgresso);
  intOpcao  := StrToIntDef(edtOpcao.Text, 0);
  intQtdMes := StrToIntDef(edtQtdMes.Text, 0);

  With objExcel Do
  Begin
    Case intOpcao Of
      1,
      9:  strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR REPRESENTANTE '         ;
      2:  strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR '              ;
      3:  strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR CIDADE/CLIENTE '        ;
      4:  strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE '               ;
      5:  strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE 2 '             ;
      6,
      10: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR FORNECEDOR '            ;
      7:  strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/CIDADE '       ;
      8:  strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR ATIVIDADE '             ;
      11: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR LINHA/GRUPO '           ;
      12: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE/PRODUTO '       ;
      13: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/ATIVIDADE '    ;
      14: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR MARCA '                 ;
      15: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR CIDADE '                ;
      16: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR REPRES. ATUAL/CLIENTE ' ;
      17: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR VENDED. ATUAL/CLIENTE ' ;
      18: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/MARCA '        ;
      19: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR '              ;
      20: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR PROFISSIONAL '          ;
      21: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR VENDEDOR/PRODUTO '      ;
      22: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR LINHA '                 ;
      23: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR CIDADE/PRODUTO '        ;
      24: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR CLIENTE/LINHA '         ;
      25: strNomRel :=  'RELATORIO DE EVOLUCAO DE VENDAS POR EMPRESA '               ;
    End;

    AddFiltro('MES BASE: '     + mskMesBas.Text);
    AddFiltro(fStrTitulo(edtCodCliente.Text,edtDesCliente,arrLinhaClien,strLinCli,'CLIENTE'));
    AddFiltro(fStrTitulo(strCodVen,edtDesVendedor,arrLinhaVende,strLinVen,'VENDEDOR'));
    AddFiltro(fStrTitulo(strCodRep,edtDesRepresentante,arrLinhaRepre,strLinRep,'REPRESENTANTE'));
    AddFiltro(fStrTitulo(edtFornecedor.Text,edtDesFornecedor,arrLinhaForne,strLinFor,'FORNECEDOR'));
    AddFiltro(fStrTitulo(edtCodMarca.Text,edtNomMarca,arrLinhaMarca,strLinMar,'MARCA'));
    AddFiltro(fStrTitulo(edtCodAti.Text,edtDesAti,arrLinAti,strLinAti,'ATIVIDADE'));
    AddFiltro(fStrTitulo(edtCodCidade.Text,edtDesCidade,arrLinhaCidad,strLinCid,'CIDADE'));
    AddFiltro(fStrTitulo(edtCodProduto.Text,edtDesProduto,arrProduto, strLinPro,'PRODUTO'));
    AddFiltro(fStrTitulo(edtCodUnidade.Text,edtDesUnidade,arrUnidade, strLinUni,'UNIDADE'));
    AddFiltro(fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo,strLinGru,'LINHA/GRUPO'));
    AddFiltro(fStrTitulo(mskLinhaGrupoExcluir.Text,edtDesGrupoExcluir,arrLinhaGrupoExc,strLinGruExc,'LINHA/GRUPO A EXCLUIR',True));
    AddFiltro(fStrTitulo(edtCodEmp.Text,edtDesEmp,arrEmpresa, strEmpresa,'EMPRESA'));
    AddFiltro(fStrTitulo(edtCodRed.Text,edtDesRed,arrRedeLojas,strRedLojas,'REDE DE LOJAS'));
    AddFiltro(fStrTitulo(edtCodProfis.Text,edtNomProfis,arrProfis,strProfis,'PROFISSIONAL'));
    AddFiltro(fStrTitulo(edtCodReg.Text,edtDesReg,arrRegiao,strRegiao,'REGIAO'));
    AddFiltro(fStrTitulo(edtCodSub.Text,edtDesSub,arrSubReg,strSubReg,'SUB-REGIAO'));
    AddFiltro('DESCRIÇÃO: DE ' + edtDesIni.text + ' ATÉ ' + edtDesFin.text);
    AddFiltro('OPÇÃO DE VENDEDOR: VENDEDOR ' + edtVendedor.Text);
    AddFiltro('TIPO DE CLIENTE: ' + IfThen(rdbAtivos.Checked, 'ATIVO', IfThen(rdbInativo.Checked, 'INATIVO', 'TODOS')));
    AddFiltro(fStrTitulo(edtDepIte.Text,edtDesDepIte,arrDepIte,strDepIte,'DEPARTAMENTO DO PRODUTO'));
    AddFiltro('CATEGORIA: ' + IfThen(fEmptyStr(cbbCategoria.Text), 'TODAS',  cbbCategoria.Text));
    AddFiltro(IfThen(fEmptyStr(edtCodCidExc.Text), 'CIDADES A EXCLUIR: NENHUMA',
        fStrTitulo(edtCodCidExc.Text,edtDesCidExc,arrCidExc,strCidExc, 'CIDADES A EXCLUIR')));
    AddFiltro(fStrTitulo(edtGruCmp.Text,edtDesGruCmp, arrGruCmp, strGruCmp,'GRUPO DE COMPRA'));
    Case intOpcao Of
      1: AddCampo('CLIENTE', 'CLIENTE');
      2: AddCampo('CLIENTE', 'CLIENTE');
      3: AddCampo('CLIENTE', 'CLIENTE');
      4:
      Begin
        AddCampo ('CLIENTE', 'CLIENTE');
        AddCampo ('C_G_C_', 'CPF/CNPJ');
        AddCampo ('FONE01', 'FONE',11);
        AddCampo ('ENDERE', 'ENDEREÇO');
        AddCampo ('BAIRRO', 'BAIRRO');
        AddCampo ('NOMCID', 'CIDADE');
        AddCampo ('ESTADO', 'UF');
        AddCampo ('CODVEN', 'VEN');
      End;
      5:
      Begin
        AddCampo ('CLIENTE', 'CLIENTE');
        AddCampo ('NOMCID', 'CIDADE');
        AddCampo ('ESTADO', 'UF');
        AddCampo ('REPATU', 'REP');
        AddCampo ('VENATU', 'VEN');
      End;
      6:  AddCampo('DESITE', 'PRODUTO');
      7:  AddCampo('NOMCID', 'CIDADE');
      8:  AddCampo('QUEBRA', 'ATIVIDADE');
      9:  AddCampo('QUEBRA', 'REPRESENTANTE');
      10: AddCampo('QUEBRA', 'FORNECEDOR');
      11: AddCampo('QUEBRA', 'LINHA/GRUPO');
      12: AddCampo('DESITE', 'PRODUTO');
      13: AddCampo('NOMATI', 'ATIVIDADE');
      14: AddCampo('QUEBRA', 'MARCA');
      15: AddCampo('QUEBRA', 'CIDADE');
      16: AddCampo('NOMCLI', 'CLIENTE');
      17: AddCampo('NOMCLI', 'CLIENTE');
      18: AddCampo('DESMAR', 'MARCA');
      19: AddCampo('QUEBRA', 'VENDEDOR');
      20: AddCampo('QUEBRA', 'PROFISSIONAL');
      21: AddCampo('DESITE', 'PRODUTO');
      22: AddCampo('QUEBRA', 'LINHA');
      23: AddCampo('DESITE', 'PRODUTO');
      24: AddCampo('LINHA',  'LINHA');
      25: AddCampo('QUEBRA', 'CODEMP');
    End;

    Case intOpcao Of
      1,2,3,6,7,12,13,16,17,18,21,23,24: AddQuebra('QUEBRA', '');
    End;

    For intCont := fGetNroColunas() - (intQtdMes - 1) To fGetNroColunas() Do
    Begin
      If edtDestino.Text <> 'E' Then Begin
        AddCampo ('DATA0' + IntToStr(intCont+1), String(arrMesAbr[StrToInt(LeftStr(String(arrDatas[intCont]),2))]) + RightStr(String(arrDatas[intCont]),5));
      End Else Begin
        AddCampo ('DATA0' + IntToStr(intCont+1), String(arrMesAbr[StrToInt(LeftStr(String(arrDatasExcel[intCont]),2))]) + RightStr(String(arrDatasExcel[intCont]),5));
      End;

      AddTotais('DATA0' + IntToStr(intCont+1));
    End;

    AddCampo ('TOTDTA','TOTAL');

    OnMontaResumo := pMontaResumo;
    OnSomaResumo  := pSomaTotais;

    blnCongelarPaineis := False;
        
    If fGerarRelatorio Then
    Begin
      fMensagem('','Arquivo gerado com sucesso!',['&OK']);
    End;
        
  End;

  FreeAndNil(objExcel);
end;

procedure TfrmRelFatEvolVendas.pHabilitaOpcoesQuebra(Sender: TObject);
begin
  if (Sender = chkRefPro) Or (Sender = chkMarPro) then
  Begin
    chkCliMov.Enabled    := Not (Sender As TCheckBox).Checked;

    ColorLabel2.Enabled  := Not (Sender As TCheckBox).Checked;
    ColorLabel3.Enabled  := Not (Sender As TCheckBox).Checked;
    ColorLabel4.Enabled  := Not (Sender As TCheckBox).Checked;
    ColorLabel5.Enabled  := Not (Sender As TCheckBox).Checked;
    ColorLabel17.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel6.Enabled  := True;
    ColorLabel7.Enabled  := Not (Sender As TCheckBox).Checked;
    ColorLabel8.Enabled  := Not (Sender As TCheckBox).Checked;
    ColorLabel9.Enabled  := Not (Sender As TCheckBox).Checked;
    ColorLabel11.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel13.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel14.Enabled := True;
    ColorLabel15.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel16.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel12.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel18.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel19.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel20.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel21.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel22.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel23.Enabled := True;
    ColorLabel24.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel26.Enabled := Not (Sender As TCheckBox).Checked;
    ColorLabel25.Enabled := True;
    ColorLabel27.Enabled := Not (Sender As TCheckBox).Checked;

    If ((Sender As TCheckBox).Checked) Then
      fMensagem('ATENÇÃO!','Este relatório será impresso no formato PAISAGEM',['&O K']);

    If Sender = chkRefPro Then
    Begin
      chkMarPro.OnClick := Nil;

      If chkRefPro.Checked Then
        chkMarPro.Checked := False;

      chkMarPro.OnClick := chkMarProClick;
    End
    Else
    Begin
      chkRefPro.OnClick := Nil;

      If chkMarPro.Checked Then
        chkRefPro.Checked := False;

      chkRefPro.OnClick := chkRefProClick;
    End;
  End
  Else if (Sender = chkCliMov) then
  Begin
    chkRefPro.Enabled    := Not chkCliMov.Checked;
    chkMarPro.Enabled    := Not chkCliMov.Checked;

    ColorLabel2.Enabled  := True;
    ColorLabel3.Enabled  := True;
    ColorLabel4.Enabled  := True;
    ColorLabel5.Enabled  := True;
    ColorLabel17.Enabled := True;
    ColorLabel6.Enabled  := Not chkCliMov.Checked;
    ColorLabel7.Enabled  := Not chkCliMov.Checked;
    ColorLabel8.Enabled  := Not chkCliMov.Checked;
    ColorLabel9.Enabled  := Not chkCliMov.Checked;
    ColorLabel11.Enabled := Not chkCliMov.Checked;
    ColorLabel13.Enabled := Not chkCliMov.Checked;
    ColorLabel14.Enabled := Not chkCliMov.Checked;
    ColorLabel15.Enabled := Not chkCliMov.Checked;
    ColorLabel16.Enabled := Not chkCliMov.Checked;
    ColorLabel12.Enabled := Not chkCliMov.Checked;
    ColorLabel18.Enabled := Not chkCliMov.Checked;
    ColorLabel19.Enabled := Not chkCliMov.Checked;
    ColorLabel20.Enabled := Not chkCliMov.Checked;
    ColorLabel21.Enabled := Not chkCliMov.Checked;
    ColorLabel22.Enabled := Not chkCliMov.Checked;
    ColorLabel23.Enabled := Not chkCliMov.Checked;
    ColorLabel24.Enabled := Not chkCliMov.Checked;
    ColorLabel25.Enabled := Not chkCliMov.Checked;
    ColorLabel27.Enabled := Not chkCliMov.Checked;
  End;

  if (chkRefPro.Checked) Or (chkMarPro.Checked) then
    strOpcQue := '06_12_21_23_'
  Else if chkCliMov.Checked then
    strOpcQue := '01_02_03_04_05_'
  Else
    strOpcQue := '01_02_03_04_05_06_07_08_09_10_11_12_13_14_15_16_17_18_19_20_21_22_23_25_';
end;

procedure TfrmRelFatEvolVendas.edtDepIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtDepIte, edtDesDepIte, arrDepIte, fRetDescDepartamento, Nil, 'do Departamento do Produto');
end;

procedure TfrmRelFatEvolVendas.edtDepIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtDepIte, edtDesDepIte, Nil, Key, arrDepIte, False) Then
  Begin
    If fValidaCampos(edtDepIte, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatEvolVendas.edtDestinoEnter(Sender: TObject);
begin
  // inherited;
  strNomImp := '';
  strTipImp := '';
end;

procedure TfrmRelFatEvolVendas.edtDestinoExit(Sender: TObject);
begin
  //inherited;
  If ((fEmptyStr(strTipImp)) Or (fEmptyStr(strNomImp)) Or (strDesAnt <> edtDestino.Text)) Then
  Begin
    fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, edtDestino.Text);
    strDesAnt := edtDestino.Text;
  End;
end;

procedure TfrmRelFatEvolVendas.edtOpcaoChange(Sender: TObject);
begin
  inherited;
  if (StrToIntDef(edtOpcao.Text,0) = 4) Or (StrToIntDef(edtOpcao.Text,0) = 5) Then
  Begin
    gpbFiltro.Enabled := True;
    chkCurva.Enabled  := True;
    edtNumCli.Enabled := True;

    chkCurva.Checked := True;
    chkCurvaClick(Sender);
  End
  Else
  Begin
    gpbFiltro.Enabled := False;
    chkCurva.Enabled  := False;
    edtNumCli.Enabled := False;

    chkCurva.Checked := False;
    chkCurvaClick(Sender);
  end;
end;

function TfrmRelFatEvolVendas.fGetNroColunas: Integer;
begin
  If (edtDestino.Text <> 'E') Then
    Result := 11
  Else
    Result := 198;
end;

procedure TfrmRelFatEvolVendas.chkMarProClick(Sender: TObject);
begin
  inherited;
  pHabilitaOpcoesQuebra(Sender);
end;

procedure TfrmRelFatEvolVendas.chkCliMovClick(Sender: TObject);
begin
  inherited;
  pHabilitaOpcoesQuebra(Sender);
end;

procedure TfrmRelFatEvolVendas.chkCurvaClick(Sender: TObject);
begin
  inherited;
  If chkCurva.Checked Then
  Begin
    edtNumCli.Enabled := True;
    edtNumCli.Text    := '9999';
  End
  Else
    edtNumCli.Enabled := False;
end;

procedure TfrmRelFatEvolVendas.chkRefProClick(Sender: TObject);
begin
  inherited;
  pHabilitaOpcoesQuebra(Sender);
end;

procedure TfrmRelFatEvolVendas.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmpresa, fRetNomeEmpresa, Nil,'da empresa');
end;

procedure TfrmRelFatEvolVendas.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendas.edtCodMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMarca, edtNomMarca, Nil, Key, arrLinhaMarca, False) Then
  Begin
    If fValidaCampos(edtCodMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendas.pVerdeVermelho(edtCodigo: TEditFocus; Shape: TShape);
Begin
  If (Not blnLiberado) Then
  Begin
    edtCodigo.MaxLength := 10;
    edtCodigo.TamCampo  := 10;
    edtCodigo.CompZeros := False;
    edtCodigo.PasswordChar := '*';
    edtCodigo.TipoTexto := ttAlfanumerico;
    Shape.Brush.Color  := clRed;
  End
  Else
  Begin
    Shape.Brush.Color  := clGreen;
  End;
End;

procedure TfrmRelFatEvolVendas.pVerificaQtdMes;
begin
  If (edtDestino.Text = 'E') Then
    strQtdMes := '199'
  Else
  Begin
    If (strTipImp = 'M') Then
    Begin
      If (StrToIntDef(edtOpcao.Text,0) = 4) Then
        strQtdMes := '07'
      Else If (StrToIntDef(edtOpcao.Text,0) = 5) Then
        strQtdMes := '199'
      Else
        strQtdMes := '07';
    End
    Else
    Begin
      If (StrToIntDef(edtOpcao.Text,0) = 4) Then
        strQtdMes := '04'
      Else If (StrToIntDef(edtOpcao.Text,0) = 5) Then
        strQtdMes := '09'
      Else
        strQtdMes := '07';
    End;
  End;
  edtQtdMes.TamCampo  := Length(strQtdMes);
  edtQtdMes.MaxLength := Length(strQtdMes);
  edtQtdMes.Text      := IfThen(StrToInt(edtQtdMes.Text) > StrToInt(strQtdMes), fStrZero(strQtdMes, Length(strQtdMes)), edtQtdMes.Text);
  lblQtdMes.Caption := '(1) Até (' + strQtdMes + ')';
  lblQtdMes.Repaint;
end;

procedure TfrmRelFatEvolVendas.edtCodMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMarca,edtNomMarca,
                    arrLinhaMarca,fRetNomMarca,nil,'da Marca');

end;

end.
