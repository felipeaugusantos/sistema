unit untRelEstPosicaoEst;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  Menus, Windows, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, untfuncoesFactory, ComObj,
  AppEvnts, BitBtnLockedIncrem, untExcel, untGeraExcel, ComCtrls,untClassPanelCx,
  UniClientDataSet, DB, untTypesSistema, frxExportCSVTestabilidade, untIFuncoes;

Type
  TConsultas = Record
    strTabela: String;
    strCampo : String;
End;

type
  TfrmRelEstPosicaoEst = class(TfrmPaiRelatorio)
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
    gpbOpcao: TGroupBox;
    edtOpcao: TEditFocus;
    ColorLabel3: TColorLabel;
    gpbQuebra: TGroupBox;
    edtDesGrupo: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDesMarca: TEditFocus;
    Label3: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtRefFin: TEditFocus;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    ColorLabel2: TColorLabel;
    edtSaldos: TEditFocus;
    Label5: TLabel;
    edtLocFis: TEditFocus;
    rdgStatus: TRadioGroup;
    Label6: TLabel;
    mskLinhaGrupo1: TMaskEditFocus;
    edtDesGrupo1: TEditFocus;
    GroupBox2: TGroupBox;
    chkResumoGP: TCheckBox;
    dlgExcel: TSaveDialog;
    chkReferencia: TCheckBox;
    chkMarca: TCheckBox;
    edtTabPre: TEditFocus;
    Label7: TLabel;
    chkSaldoRes: TCheckBox;
    rdgLocalizacaoFisica: TRadioGroup;
    Label8: TLabel;
    cbxTipPre: TComboBox;
    pbProgresso: TProgressBar;
    gpbOpcaoSintetico: TGroupBox;
    cbxOpcaoSint: TComboBox;
    cbxQuebra: TComboBox;
    grbEntregaFutura: TGroupBox;
    chkEntFut: TCheckBox;
    grbMotFut: TGroupBox;
    chkFalta: TCheckBox;
    chkPrevisao: TCheckBox;
    chkAguarda: TCheckBox;
    rdbSalIte: TRadioButton;
    rdbSalLot: TRadioButton;
    rdgAtivoCompras: TRadioGroup;
    lblDepartamento: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    chkExibirTotSaldo: TCheckBox;
    edtGruCmp: TEditFocus;
    Label12: TLabel;
    edtDesGruCmp: TEditFocus;
    GroupBox3: TGroupBox;
    rdgLotesDeProdutos: TRadioGroup;
    grbLoteValidade: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    GroupBox4: TGroupBox;
    ColorLabel4: TColorLabel;
    edtImpLis: TEditFocus;
    rdgOpcaoSaldoTodasEmpresas: TRadioGroup;
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaGrupo(Var qryCadGru: TUniQuery);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtFornecedorExit(Sender: TObject);
    procedure pCarregaFornecedor(Var qryCadFor: TUniQuery);
    procedure pCarregaMarca(Var qryCadMar: TUniQuery);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtUnidadeExit(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskLinhaGrupo1Exit(Sender: TObject);
    procedure mskLinhaGrupo1KeyPress(Sender: TObject; var Key: Char);
    procedure pGeraExcel(qryDados: TDataSet);
    procedure pGeraExcelResumo(qryDados: TDataSet);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edtOpcaoChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkEntFutClick(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    function fSqlValidarQtdSaldoLote(blnFiltraSaldoLote: Boolean = False): string;
    procedure edtCodEmpresaChange(Sender: TObject);
  private
    { Private declarations }
    blnQtdCai: Boolean;
    blnCadLoc: Boolean;
    blnLotArm: Boolean;

    strLinEmp  : String;
    strCodDep  : String;
    arrCodDep  : TConsultasArray;
    strGruCmp  : String;

    qryRelAux   : TUniQuery;
    qryRelatorio: TUniQuery;

    strNomeArquivoExcel: String;

    procedure pEscondeMarca;

    Function fSQLFiltroLote(blnFiltraSaldoLote: Boolean = False): String;
    Function fSQLFiltroEmpresa(strAlias: String; strCampo: String = 'ITE_CODEMP'): String;
    Function fSQLFiltroSaldos: String;
    Function fSoUmaEmpresaSelecionada: Boolean;
    Function fSQLFiltros: String;
    Function fSqlSaldos(strAlias: String = 'G'; blnFiltroSaldo: boolean = False): String;
    Function fSQLPrecoCusto(strAlias: String): String;
    Function fTituloOpcaoPreco: String;
    function fTituloSaldos: String;
    Function fGetSqlPesoLitroKilo(strCampo: String; strTipUni: String): String;
    Function fVerificaEntFut: Boolean;
    Function fTituloEntFut: String;

    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(Var Totais: TTotais; Dados: TDataSet);
    procedure pImpDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure pAjustaSintetico;
    Procedure pSQLAnalitico(Var strSQL: String);
    Procedure pSQLSintetico(Var strSQL: String);
    Procedure pSQLResumoGrupo(Var strSQL_Rel: String);
    procedure pCriaQryRelatorio;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    arrLinhaGrupo: TConsultasArray;
    arrLinhaGrupo1: TConsultasArray;
    arrProduto   : TConsultasArray;
    arrFornecedor: TConsultasArray;
    arrMarca     : TConsultasArray;
    arrEmpresa   : TConsultasArray;
    arrUnidade   : TconsultasArray;
    arrGruCmp    : TConsultasArray;

    strLinGru  : String;
    qryCadLot  : TUniQuery;
    procedure pAbreLote(qryCadLot: TUniQuery);

  end;

var
  frmRelEstPosicaoEst: TfrmRelEstPosicaoEst;

implementation

uses untQckEstPosicaoEst, untPai, untConstantes;

{$R *.dfm}

Function TfrmRelEstPosicaoEst.fSqlSaldos(strAlias: String = 'G'; blnFiltroSaldo: boolean = False): String;
  Var
    sqlSQL: String;
Begin
  If strAlias = '' Then
     strAlias := 'G';

  sqlSQL := ' ROUND(';

  sqlSQL := sqlSQL + ' IF((IFNULL((SELECT COUNT(*) FROM CADLOT ';
  sqlSQL := sqlSQL + '             WHERE LOT_CODITE = ' + strAlias + '.ITE_CODITE AND LOT_CODEMP = ' + strAlias + '.ITE_CODEMP), 0) > 0),  ';

  sqlSQL := sqlSQL + ' ( SELECT SUM(IFNULL(LOT_SALDOS, 0)) FROM CADLOT ';
  sqlSQL := sqlSQL + '   WHERE ';
  sqlSQL := sqlSQL +       strAlias + '.ITE_CODITE = LOT_CODITE AND ';
  sqlSQL := sqlSQL +       strAlias + '.ITE_CODEMP = LOT_CODEMP     ';
  sqlSQL := sqlSQL +      fSQLFiltroLote(blnFiltroSaldo);
  sqlSQL := sqlSQL + ' ), ';

  sqlSQL := sqlSQL +      strAlias + '.ITE_SALDOS + IF(IFNULL(I.ITE_CNV_ML, 0) > 0, ' + strAlias + '.ITE_SAL_ML / I.ITE_CNV_ML, 0)) ';

  If (fCfgSis('BEFTRG', VarBoolean)) Then
    sqlSQL := sqlSQL + ' - ' + fGetSQLSomaCamposEntregaFutura(strAlias) + ' ';

  If chkEntFut.Checked And chkAguarda.Checked Then
    sqlSQL := sqlSQL + ' + IFNULL(' + strAlias + '.ITE_QTEF_A, 0) ';

  If chkEntFut.Checked And chkFalta.Checked Then
    sqlSQL := sqlSQL + ' + IFNULL(' + strAlias + '.ITE_QTEF_F, 0) ';

  If chkEntFut.Checked And chkPrevisao.Checked Then
    sqlSQL := sqlSQL + ' + IFNULL(' + strAlias + '.ITE_QTEF_P, 0) ';

  sqlSQL := sqlSQL + ', ' + fCfgSis('DECQTD') + ') ';

  Result := sqlSQL;
End;

function TfrmRelEstPosicaoEst.fSqlValidarQtdSaldoLote(blnFiltraSaldoLote: Boolean = False): string;
begin
  Result := '';
  If (Not rdbSalLot.Checked) And (Not blnFiltraSaldoLote) Then
    Exit;
  If edtSaldos.Text = 'P' Then Result := ' > 0 '
  Else If edtSaldos.Text = 'N' Then Result := ' < 0 '
  Else If edtSaldos.Text = 'Z' Then Result := ' = 0 ';
  If (Result <> '') And (Not blnFiltraSaldoLote) Then
    Result := ' AND CADLOT.LOT_SALDOS ' + Result;
end;

{********************************************************************************************************}
{* PROCEDURE PARA CARREGAR A DESCRICAO DO DADO NO EDIT DE DESCRICAO                                     *}
{*****************************************************************************************************LA*}
procedure pCarrega(strText: String; edtDescri: TEditFocus; arrLinha: TConsultasArray);
Begin
  If Assigned(edtDescri) Then
  Begin

    If Not fEmptyStr(strText) Then
    Begin

      If Length(arrLinha) = 1 Then
        edtDescri.Text := arrLinha[0].strDescri
      Else
        edtDescri.Text := '+1';

    End
    Else
      edtDescri.Text := '';
  End;
End;

procedure TfrmRelEstPosicaoEst.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelEstPosicaoEst.pCarregaGrupo(Var qryCadGru: TUniQuery);
Begin
  If Not (fEmptyStr(mskLinhaGrupo.Text)) Then
    edtDesGrupo.Text := qryCadGru.FieldByName('GRU_DESGRU').AsString
  Else
    edtDesGrupo.Text := '';
End;

procedure TfrmRelEstPosicaoEst.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then  
  Begin
    fvalidaCampos(mskLinhaGrupo,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstPosicaoEst.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
  {***********************************************************}
  {* ESCREVE NENHUM, POIS O LABEL DIZ: LINHA/GRUPO A EXCLUIR *}
  {********************************************************LU*}
  if edtDesGrupo.Text = 'TODOS' then
    edtDesGrupo.Text := 'NENHUM';
end;

procedure TfrmRelEstPosicaoEst.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelEstPosicaoEst.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstPosicaoEst.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmRelEstPosicaoEst.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstPosicaoEst.edtLocFisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelEstPosicaoEst.pCarregaFornecedor(Var qryCadFor: TUniQuery);
Begin
  If Not fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := qryCadFor.FieldByName('FOR_NOMFOR').AsString
  Else
    edtDesFornecedor.Text := '';
End;

procedure TfrmRelEstPosicaoEst.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelEstPosicaoEst.edtMarcaKeyPress(Sender: TObject;
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

procedure TfrmRelEstPosicaoEst.edtOpcaoChange(Sender: TObject);
begin
  inherited;
  pAjustaSintetico;
end;

procedure TfrmRelEstPosicaoEst.pCarregaMarca(Var qryCadMar: TUniQuery);
Begin
  If Not fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := qryCadMar.FieldByName('MAR_DESMAR').AsString
  Else
    edtDesFornecedor.Text := '';
End;

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmRelEstPosicaoEst.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intTabPre: Integer;
begin
  intTabPre := 0;
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskLinhaGrupo1) Then
    Begin
      pDesmarcaLista(mskLinhaGrupo1, arrLinhaGrupo1, '', 6);
    End
    Else
    If (Sender = mskLinhaGrupo) Then
    Begin
      pDesmarcaLista(mskLinhaGrupo, arrLinhaGrupo, '', 6);
    End
    Else

    If (Sender = edtProdutos) Then
    Begin
      pDesmarcaLista(edtProdutos, arrProduto);
    End
    Else
    If (Sender = edtFornecedor) Then
    Begin
      pDesmarcaLista(edtFornecedor, arrFornecedor);
    End
    Else
    If (Sender = edtMarca) Then
    Begin
      pDesmarcaLista(edtMarca, arrMarca);
    End
    Else
    If (Sender = edtCodEmpresa) Then
    Begin
      pDesmarcaLista(edtCodEmpresa, arrEmpresa);
    End
    Else
    If (Sender = edtUnidade) Then
    Begin
      pDesmarcaLista(edtUnidade, arrUnidade);
    End
    Else

    If (Sender = edtOpcao) Then
    Begin
      If (edtOpcao.Text <> 'A') And (edtOpcao.Text <> 'S') Then
      Begin
        fMensagem('','O campo opcao deve ter A ou S!',['&O K'],0);
        Result := False;
      End
      Else
      Begin
        gpbQuebra.Visible := edtOpcao.Text = 'A';
      End;

    End

    Else If (Sender = edtDestino) Then
    Begin
      If (edtDestino.Text <> 'I') And (edtDestino.Text <> 'V') And (edtDestino.Text <> 'E') Then
      Begin
        fMensagem('','O campo Destino deve ser V, I ou E!',['&O K'],0);
        Result := False;
      End;

    End

    Else If (Sender = edtSaldos) Then
    Begin

      If Pos(edtSaldos.Text,'P_N_Z_T_') <= 0 Then
      Begin
        fMensagem('','O campo saldos deve ser P,N,Z ou T!',['&O K'],0);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If fSoUmaEmpresaSelecionada Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtLocFis) Then
    Begin

      If blnCadLoc Then
      Begin

        If (Not fEmptyStr(edtLocFis.Text)) Then
        Begin

          If fEmptyStr(fRetNomLocFisica(edtLocFis.Text)) Then
          Begin
            pMensagemOk('Localização Física não encontrada!');
            Result := False;
          End

        End;

      End;

    End

    Else If (Sender = edtTabPre) Then
    Begin
      If fEmptyStr(edtTabPre.Text)Or (intTabPre <= 0) Or (intTabPre > Length(VS_strTabPrc)) Then
      Begin
        intTabPre := StrToIntDef(edtTabPre.Text, 0);
        If (intTabPre <= 0) Or (intTabPre > Length(VS_strTabPrc)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A tabela de preço deve ser um número entre 1 e ' + IntToStr(Length(VS_strTabPrc)) + '!', ['&Ok']);
          Result := False;
        End
        Else If VS_strTabPrc[intTabPre] <> 'S' Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa tabela não está sendo utilizada.', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtImpLis) Then
    Begin
      if (fEmptyStr(edtImpLis.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'Informe (T)odos ou (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      end;

      if ( Pos(edtImpLis.Text, 'T_S_N') <= 0 ) then
      begin
        fMensagem('ATENÇÃO!', 'Informe (T)odos ou (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      end;
    end
    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin
      If Sender = mskDtaIni Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
           Exit;
        try
           mskDtaIni.Text := DateToStr(StrToDate(mskDtaIni.Text));
        Except
          fMensagem('ATENÇÃO!', 'Data inicial inválida', ['&Ok']);
          Result := False
        End;
      End
      else
      If Sender = mskDtaFin Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
           Exit;
        try
           mskDtaFin.Text := DateToStr(StrToDate(mskDtaFin.Text));
        Except
          fMensagem('ATENÇÃO!', 'Data final inválida', ['&Ok']);
          Result := False;
        End;

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) and Result Then
          If StrToDate(mskDtaFin.Text) < StrToDate(mskDtaIni.Text) Then
          Begin 
            fMensagem('ATENÇÃO!', 'Data Final deve ser maior que a Data Inicial.', ['&Ok']);
            Result := False;
          End;    
      End
    End;
  End;
  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmRelEstPosicaoEst.fSQLFiltroEmpresa(strAlias: String; strCampo: String = 'ITE_CODEMP'): String;
Begin
  Result := fStrLocateEmpresa(edtCodEmpresa, arrEmpresa, strAlias + '.' + strCampo, 'CODEMP');
End;

Function TfrmRelEstPosicaoEst.fSoUmaEmpresaSelecionada: Boolean;
Begin
  Result := (Length(arrEmpresa) < 2) And (Not fEmptyStr(edtCodEmpresa.Text));
End;

Function TfrmRelEstPosicaoEst.fSQLFiltroSaldos: String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  If (edtSaldos.Text <> 'T') Then
  Begin

    If fSoUmaEmpresaSelecionada Then
    Begin
      strSQL     := strSQL     + '  ' + fSqlSaldos('', True) + ' ';
    End Else
    Begin
      If (rdgOpcaoSaldoTodasEmpresas.Visible) And
         (rdgOpcaoSaldoTodasEmpresas.ItemIndex = 0) Then
        strSQL := strSQL + '  ' + fSqlSaldos + ' '
      Else
      Begin
        strSQL := strSQL + ' (SELECT  ';
        strSQL := strSQL + '    SUM(IFNULL(' + fSqlSaldos('IG') + ',0))  ';
        strSQL := strSQL + '  FROM                                 ';
        strSQL := strSQL + '    ITEGER IG                          ';
        strSQL := strSQL + '  WHERE                                ';
        strSQL := strSQL + '    IG.ITE_CODITE = I.ITE_CODITE       ';
        strSQL := strSQL +      fSQLFiltroEmpresa('IG');
        strSQL := strSQL + '  )                                    ';
      End;
    End;

    If edtSaldos.Text = 'P' Then
    Begin
      strSQL     := strSQL     + ' > 0 ';
    End
    Else If edtSaldos.Text = 'N' Then
    Begin
      strSQL     := strSQL     + ' < 0 ';
    End
    Else If edtSaldos.Text = 'Z' Then
    Begin
      strSQL     := strSQL   + ' = 0 ';
    End;

  End

  Else strSQL     := strSQL   + ' TRUE ';

Result := strSQL;
End;

Function TfrmRelEstPosicaoEst.fSQLPrecoCusto(strAlias: String): String;
Begin
  Case cbxTipPre.ItemIndex Of
    0: Result := 'ITE_PRECUS ';
    1: Result := '((ITE_PRECUS + ITE_OUTVAL) / (1 - ((ITE_ICMSAI + ITE_IMPFED + ITE_DESOPE) / 100)))';
    2: Result := 'ITE_PREMED ';
    3: Result := 'ITE_PREULT ';
    4: Result := 'ITE_IMPULT ';

  End;

  Result := ' (' + AnsiReplaceStr(Result, 'ITE_', strAlias + '.ITE_') + ') ';
End;

Function TfrmRelEstPosicaoEst.fTituloOpcaoPreco: String;
Begin
  Case cbxTipPre.ItemIndex Of
    0: Result := 'OPCAO DE PRECO: PRECO DE CUSTO';
    1: Result := 'OPCAO DE PRECO: PRECO DE CUSTO REAL';
    2: Result := 'OPCAO DE PRECO: PRECO MEDIO';
    3: Result := 'OPCAO DE PRECO: PRECO DA ULTIMA COMPRA';
    4: Result := 'OPCAO DE PRECO: PRECO DA ULTIMA COMPRA + IMPOSTOS';
  End;
End;

Procedure TfrmRelEstPosicaoEst.pSQLAnalitico(Var strSQL: String);
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  LEFT(I.ITE_CODGRU,3) AS LINHA, ';
  strSQL := strSQL + '  I.ITE_CODGRU AS GRUPO,         ';
  strSQL := strSQL + ' CONCAT(LEFT(I.ITE_CODGRU,3)," - ", ';
  strSQL := strSQL + '       (SELECT GRU_DESGRU FROM CADGRU ';
  strSQL := strSQL + '        WHERE GRU_CODGRU = CONCAT(LEFT(I.ITE_CODGRU,3),"","000"))) AS LINDES, ';
  strSQL := strSQL + ' CONCAT(I.ITE_CODGRU," - ", ';
  strSQL := strSQL + '       (SELECT GRU_DESGRU FROM CADGRU ';
  strSQL := strSQL + '        WHERE GRU_CODGRU = I.ITE_CODGRU)) AS GRUDES, ';
  strSQL := strSQL + '  I.ITE_CODITE AS CODIGO, ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '    UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
  strSQL := strSQL + '  M.MAR_DESMAR AS MARCA,  ';

  {****************************************}
  {* SELECT DO SALDO RESERVADO DO PRODUTO *}
  {*************************************RV*}
  strSQL := strSQL + '  IFNULL((SELECT ';
  strSQL := strSQL + '     IFNULL(SUM(IFNULL(FDO_QTDITE, 0) - IFNULL(FDO_QTDBAI, 0)), 0) ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     FATDOR ';
  strSQL := strSQL + '   INNER JOIN FATGOR ON ';
  strSQL := strSQL + '     FDO_ESPDOC = FGO_ESPDOC AND ';
  strSQL := strSQL + '     FDO_NUMDOC = FGO_NUMDOC AND ';
  strSQL := strSQL + '     FDO_CODEMP = FGO_CODEMP     ';
  strSQL := strSQL + '   WHERE ';
  strSQL := strSQL + '     FATDOR.FDO_ESPDOC = "PD"     AND ';
  strSQL := strSQL + '     FATDOR.FDO_JAFATU = 0        AND ';
  strSQL := strSQL + '     FATDOR.FDO_CODITE = I.ITE_CODITE ';
  strSQL := strSQL +       fSQLFiltroEmpresa('FATGOR', 'FGO_CODEMP');

  strSQL := strSQL + '   GROUP BY ';
  strSQL := strSQL + '     FDO_CODITE), 0) AS "SALRES", ';

  If fSoUmaEmpresaSelecionada Then
  Begin
    strSQL := strSQL + '  SUM(IFNULL(' + fSqlSaldos + ',0)) AS SALDOS, ';
    strSQL := strSQL + '  SUM(IFNULL(G.ITE_PREULT,0)) AS VALULT, ';
    strSQL := strSQL + '  SUM(IFNULL( ROUND(' + fSQLPrecoCusto('G') + '/ IF((ITE_FATCNV=0 OR ITE_FATCNV IS NULL),1,ITE_FATCNV), ' + fCfgSis('DECUNI') + ')  ,0)) AS VALCUS, ';
    strSQL := strSQL + '  SUM(IFNULL(G.ITE_PREVE' + edtTabPre.Text + ',0)) AS VALVEN, ';

    If blnQtdCai Then
    Begin
      strSQL := strSQL + '  SUM(IFNULL(IF(ITE_MLTVEN > 0, ' + fSqlSaldos + ' / ITE_MLTVEN, 0), 0)) AS LITRAG, ';

      {******************************************************}
      {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
      {****************************************************FC}
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL(IF(ITE_MLTVEN > 0, ' + fSqlSaldos + ' / ITE_MLTVEN, 0), 0)', 'L') + ') AS TOTLIT, ';
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL(IF(ITE_MLTVEN > 0, ' + fSqlSaldos + ' / ITE_MLTVEN, 0), 0)', 'K') + ') AS TOTKIL, ';
    End
    Else
    Begin
      strSQL := strSQL + '  SUM(IFNULL((' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL),0)) AS LITRAG, ';

      {******************************************************}
      {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
      {****************************************************FC}
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL((' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL),0)', 'L') + ') AS TOTLIT, ';
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL((' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL),0)', 'K') + ') AS TOTKIL, ';
    End;

    strSQL := strSQL + '  SUM(IFNULL((' + fSqlSaldos + ' * G.ITE_PREULT),0)) AS TOTULT, ';
    strSQL := strSQL + '  SUM(IFNULL((' + fSqlSaldos + ' * ROUND(' + fSQLPrecoCusto('G') + ' / IF((ITE_FATCNV=0 OR ITE_FATCNV IS NULL),1,ITE_FATCNV), ' + fCfgSis('DECUNI') + ')),0)) AS TOTCUS, ';
    strSQL := strSQL + '  SUM(IFNULL((' + fSqlSaldos + ' * G.ITE_PREVE' + edtTabPre.Text + '),0)) AS TOTVEN ';
  End Else
  Begin
    (*******************************************************************)
    (* QUANDO FOR MAIS DE UMA EMPRESA PEGAR INFORMACOES DA MATRIZ      *)
    (***************************************************************IV**)
    strSQL := strSQL + '  SUM(IFNULL(' + fSqlSaldos + ',0)) AS SALDOS, ';
    strSQL := strSQL + '  IFNULL( G.ITE_PREULT,0) AS VALULT, ';
    strSQL := strSQL + '  IFNULL( ROUND(' + fSQLPrecoCusto('G') + ' / IF((ITE_FATCNV=0 OR ITE_FATCNV IS NULL),1,ITE_FATCNV), ' + fCfgSis('DECUNI') + '), 0) AS VALCUS, ';
    strSQL := strSQL + '  IFNULL( G.ITE_PREVE' + edtTabPre.Text + ', 0) AS VALVEN, ';

    If blnQtdCai Then
    Begin
      strSQL := strSQL + '  SUM(IFNULL(IF(ITE_MLTVEN > 0, ' + fSqlSaldos + ' / ITE_MLTVEN, 0), 0)) AS LITRAG, ';

      {******************************************************}
      {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
      {****************************************************FC}
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL(IF(ITE_MLTVEN > 0, ' + fSqlSaldos + ' / ITE_MLTVEN, 0), 0)', 'L') + ') AS TOTLIT, ';
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL(IF(ITE_MLTVEN > 0, ' + fSqlSaldos + ' / ITE_MLTVEN, 0), 0)', 'K') + ') AS TOTKIL, ';
    End
    Else
    Begin
      strSQL := strSQL + '  SUM(IFNULL((' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL),0)) AS LITRAG, ';

      {******************************************************}
      {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
      {****************************************************FC}
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL((' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL),0)', 'L') + ') AS TOTLIT, ';
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL((' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL),0)', 'K') + ') AS TOTKIL, ';
    End;

    strSQL := strSQL + '  SUM(IFNULL((' + fSqlSaldos + ' * G.ITE_PREULT),0)) AS TOTULT, ';
    strSQL := strSQL + '  SUM(IFNULL((' + fSqlSaldos + ' * ROUND(' + fSQLPrecoCusto('G') + ' / IF((ITE_FATCNV=0 OR ITE_FATCNV IS NULL),1,ITE_FATCNV), ' + fCfgSis('DECUNI') + ')), 0)) AS TOTCUS, ';
    strSQL := strSQL + '  SUM(IFNULL((' + fSqlSaldos + ' * G.ITE_PREVE' + edtTabPre.Text + '),0)) AS TOTVEN ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '  JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL +    fSQLFiltroSaldos;
  strSQL := strSQL +    fSQLFiltros;

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '  I.ITE_CODITE, I.ITE_CODGRU ';

  strSQL := strSQL + ' ORDER BY ';
  Case cbxQuebra.ItemIndex Of
    1:  strSQL     := strSQL  + '  I.ITE_CODGRU, ';
    2:  strSQL     := strSQL  + '  LITRAG DESC,       ';
    3:  strSQL     := strSQL  + '  SALDOS DESC,       ';
    4:  strSQL     := strSQL  + '  TOTULT DESC,       ';
    5:  strSQL     := strSQL  + '  TOTCUS DESC,       ';
    6:  strSQL     := strSQL  + '  TOTVEN DESC,       ';
  End;

  strSQL     := strSQL     + '  I.ITE_DESITE ';
End;

Procedure TfrmRelEstPosicaoEst.pSQLSintetico(Var strSQL: String);
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

  if (edtOpcao.Text = 'S') And (cbxOpcaoSint.ItemIndex < 2) Then
  Begin
    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  F.FOR_NOMFOR AS NOMFOR, ';
  End;

  strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
  strSQL := strSQL + '  M.MAR_DESMAR AS MARCA,  ';

  {********************************************************************}
  {* DADOS DA EMPRESA PARA SER EXIBIDO NA OPÇÃO SINTEITCO POR EMPRESA *}
  {******************************************************************FC}
  strSQL := strSQL + '  G.ITE_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  (SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '     EMP_NOMEMP ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     CADEMP ';
  strSQL := strSQL + '  WHERE EMP_CODEMP = G.ITE_CODEMP ';
  strSQL := strSQL + '    LIMIT 1) AS NOMEMP, ';

  {****************************************}
  {* SELECT DO SALDO RESERVADO DO PRODUTO *}
  {*************************************RV*}
  strSQL := strSQL + '  IFNULL((SELECT ';
  strSQL := strSQL + '     IFNULL(SUM(IFNULL(FDO_QTDITE, 0) - IFNULL(FDO_QTDBAI, 0)), 0) ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     FATDOR ';
  strSQL := strSQL + '   INNER JOIN FATGOR ON ';
  strSQL := strSQL + '     FDO_ESPDOC = FGO_ESPDOC AND ';
  strSQL := strSQL + '     FDO_NUMDOC = FGO_NUMDOC AND ';
  strSQL := strSQL + '     FDO_CODEMP = FGO_CODEMP     ';
  strSQL := strSQL + '   WHERE ';
  strSQL := strSQL + '     FATDOR.FDO_ESPDOC = "PD"     AND ';
  strSQL := strSQL + '     FATDOR.FDO_JAFATU = 0        AND ';
  strSQL := strSQL + '     FATDOR.FDO_CODITE = I.ITE_CODITE ';
  strSQL := strSQL +       fSQLFiltroEmpresa('FATGOR', 'FGO_CODEMP');
  strSQL := strSQL + '   GROUP BY ';
  strSQL := strSQL + '     FDO_CODITE), 0) AS "SALRES", ';

  If fSoUmaEmpresaSelecionada Then
  Begin


    strSQL := strSQL + '  SUM(IF(' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL IS NULL,0,' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL)) AS LITRAG, ';


    If blnQtdCai Then
    Begin
      strSQL := strSQL + '  SUM(IFNULL(IF(ITE_MLTVEN > 0, ' + fSqlSaldos + ' / ITE_MLTVEN, 0), 0)) AS LITRAG, ';

      {******************************************************}
      {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
      {****************************************************FC}
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL(IF(ITE_MLTVEN > 0, ' + fSqlSaldos + ' / ITE_MLTVEN, 0), 0)', 'L') + ') AS TOTLIT, ';
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL(IF(ITE_MLTVEN > 0, ' + fSqlSaldos + ' / ITE_MLTVEN, 0), 0)', 'K') + ') AS TOTKIL, ';
    End
    Else
    Begin
      strSQL := strSQL + '  SUM(IFNULL((' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL),0)) AS LITRAG, ';

      {******************************************************}
      {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
      {****************************************************FC}
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL((' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL),0)', 'L') + ') AS TOTLIT, ';
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('IFNULL((' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL),0)', 'K') + ') AS TOTKIL, ';
    End;

    {******************************************************}
    {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
    {****************************************************FC}

    strSQL := strSQL + '  SUM(IF(' + fSqlSaldos + ' * G.ITE_PREULT IS NULL,0,' + fSqlSaldos + ' * G.ITE_PREULT)) AS TOTULT, ';
    strSQL := strSQL + '  SUM(IF(' + fSqlSaldos + ' * ROUND(' + fSQLPrecoCusto('G') + ' / IF((ITE_FATCNV = 0 OR ITE_FATCNV IS NULL), 1, ITE_FATCNV), ' + fCfgSis('DECUNI') + ') IS NULL, ';
    strSQL := strSQL + '         0, ';
    strSQL := strSQL +           fSqlSaldos + ' * ROUND(' + fSQLPrecoCusto('G') + ' / IF((ITE_FATCNV = 0 OR ITE_FATCNV IS NULL), 1, ITE_FATCNV), ' + fCfgSis('DECUNI') + '))) AS TOTCUS, ';

    strSQL := strSQL + '  SUM(IF(' + fSqlSaldos + ' * G.ITE_PREVE' + edtTabPre.Text + ' IS NULL,0,' + fSqlSaldos + ' * G.ITE_PREVE' + edtTabPre.Text + ')) AS TOTVEN ';
  End Else
  Begin
    (*******************************************************************)
    (* QUANDO FOR MAIS DE UMA EMPRESA PEGAR INFORMACOES DA MATRIZ      *)
    (* O SALDO SOMAR TODAS                                             *)
    (***************************************************************LA**)

    {******************************************************}
    {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
    {****************************************************FC}
    If blnQtdCai Then
    Begin
      strSQL := strSQL + '  SUM(' + fSqlSaldos + ' / ITE_MLTVEN) AS LITRAG, ';
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('(' + fSqlSaldos + '  / ITE_MLTVEN)', 'L') + ') AS TOTLIT, ';
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('(' + fSqlSaldos + '  / ITE_MLTVEN)', 'K') + ') AS TOTKIL, ';
    end
    Else
    Begin
      strSQL := strSQL + '  SUM(' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL) AS LITRAG, ';
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('(' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL)', 'L') + ') AS TOTLIT, ';
      strSQL := strSQL + '  SUM(' + fGetSqlPesoLitroKilo('(' + fSqlSaldos + ' * U.UNI_PESLIT / :LITGAL)', 'K') + ') AS TOTKIL, ';
    End;


    strSQL := strSQL + '  SUM(' + fSqlSaldos + ' * G.ITE_PREULT) AS TOTULT, ';
    strSQL := strSQL + '  SUM(' + fSqlSaldos + ' * ROUND(' + fSQLPrecoCusto('G') + ' / IF((ITE_FATCNV = 0 OR ITE_FATCNV IS NULL), 1, ITE_FATCNV), ' + fCfgSis('DECUNI') + ')) AS TOTCUS, ';
    strSQL := strSQL + '  SUM(' + fSqlSaldos + ' * G.ITE_PREVE' + edtTabPre.Text + ') AS TOTVEN ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '  JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';

  strSQL := strSQL + '  LEFT JOIN CADFOR F ON (F.FOR_CODFOR = I.ITE_CODFOR) ';

  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + fSQLFiltroSaldos;

  strSQL := strSQL + fSQLFiltros;

  strSQL := strSQL + ' GROUP BY ';

  {*********************************************}
  {* OPÇÃO SINTETICA POR FORNECEDOR OU EMPRESA *}
  {*******************************************FC}
  Case cbxOpcaoSint.ItemIndex Of
    0: strSQL := strSQL + '  I.ITE_CODFOR ';
    1: strSQL := strSQL + '  G.ITE_CODEMP ';
    2: strSQL := strSQL + '  I.ITE_CODMAR ';
  End;

  strSQL := strSQL + ' ORDER BY ';
  Case cbxOpcaoSint.ItemIndex Of
    0: strSQL := strSQL + '  I.ITE_CODFOR ';
    1: strSQL := strSQL + '  G.ITE_CODEMP ';
    2: strSQL := strSQL + '  I.ITE_CODMAR ';
  End;
End;

Procedure TfrmRelEstPosicaoEst.pSQLResumoGrupo(Var strSQL_Rel: String);
Begin
  {****************************************}
  {* SELECT P\ O REL DE RESUMO POR GRUPOS *}
  {***11/03/2008*************JBAT**********}
  strSQL_Rel :=  'SELECT ';
  strSQL_Rel := strSQL_Rel + '  I.ITE_CODGRU AS GRUPO,';
  strSQL_Rel := strSQL_Rel + '  GP.GRU_DESGRU AS DESCGRUPO,';

  strSQL_Rel := strSQL_Rel + '  SUM(IF((' + fSqlSaldos + ' * (' + fSQLPrecoCusto('G') + ' / IF((ITE_FATCNV = 0 OR ITE_FATCNV IS NULL), 1, ITE_FATCNV))) IS NULL, ';
  strSQL_Rel := strSQL_Rel + '         0, ';
  strSQL_Rel := strSQL_Rel + ' ' + fSqlSaldos + ' *  ROUND((' + fSQLPrecoCusto('G') + ' / IF((ITE_FATCNV = 0 OR ITE_FATCNV IS NULL), 1, ITE_FATCNV)), ' + fCfgSis('DECUNI') + '))) AS TOTCUS, ';

  strSQL_Rel := strSQL_Rel + '  SUM(IF((' + fSqlSaldos + ' * G.ITE_PREVE' + edtTabPre.Text + ') IS NULL,0,(' + fSqlSaldos + ' * G.ITE_PREVE' + edtTabPre.Text + '))) AS TOTVEN ';

  strSQL_Rel := strSQL_Rel + 'FROM ';
  strSQL_Rel := strSQL_Rel + '  CADITE I  ';
  strSQL_Rel := strSQL_Rel + '  JOIN CADUNI  U  ON I.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL_Rel := strSQL_Rel + '  JOIN ITEGER  G  ON I.ITE_CODITE = G.ITE_CODITE ';
  strSQL_Rel := strSQL_Rel + '  JOIN CADGRU  GP ON I.ITE_CODGRU = GP.GRU_CODGRU ';
  strSQL_Rel := strSQL_Rel + '  JOIN CADMAR  M  ON I.ITE_CODMAR = M.MAR_CODMAR  ';

  strSQL_Rel := strSQL_Rel + 'WHERE ';

  strSQL_Rel := strSQL_Rel + fSQLFiltroSaldos;

  strSQL_Rel := strSQL_Rel + fSQLFiltros;
  strSQL_Rel := strSQL_Rel + ' GROUP BY ';
  strSQL_Rel := strSQL_Rel + '  I.ITE_CODGRU ';
  strSQL_Rel := strSQL_Rel + 'ORDER BY ';
  strSQL_Rel := strSQL_Rel + '  I.ITE_CODGRU ';
End;

Function TfrmRelEstPosicaoEst.fSQLFiltros: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  {***************************************}
  {STATUS: ATIVO, INATIVO E TODOS         }
  {************************************RL*}
  If rdgStatus.ItemIndex = 0 Then
  Begin
    strSQL     := strSQL     + '  AND I.ITE_ITEATI = "S" ';
  End
  Else If rdgStatus.ItemIndex = 1 Then
  Begin
    strSQL     := strSQL     + '  AND I.ITE_ITEATI = "N" ';
  End;

  If Not fEmptyStr(edtGruCmp.Text) Then
    strSQL := strSQL + fStrLocate(edtGruCmp, arrGruCmp, 'I.ITE_GRUCMP', 'GRUCMP');

  {***************************************}
  { LOCALIZAÇÃO FÍSICA: SIM, NÃO E TODOS  }
  {************************************CI*}
  Case rdgLocalizacaoFisica.ItemIndex Of
    0:  Begin
          // (O ITEM POSSUI ALGUM LOTE COM LOCALIZAO FISICA) OU (NÃO TEM LOTE E POSSUI LOCALIZAÇÃO FÍSICA)
          strSQL := strSQL     + '  AND (((IFNULL((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = G.ITE_CODEMP ' +  fSqlValidarQtdSaldoLote + '), 0) > 0) AND ';
          strSQL := strSQL     + '        (IFNULL((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = G.ITE_CODEMP AND IFNULL(LOT_LOCFIS, "") <> "" ' +  fSqlValidarQtdSaldoLote + '), 0) > 0)) OR ';
          strSQL := strSQL     + '       ((IFNULL((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = G.ITE_CODEMP ' +  fSqlValidarQtdSaldoLote + '), 0) = 0) AND ';
          strSQL := strSQL     + '        (IFNULL(G.ITE_LOCFIS, "") <> ""))) ';
        End;
    1:  Begin
          // (O ITEM TEM ALGUM LOTE SEM LOCALIZAÇÃO FÍSICA) OU (NÃO TEM LOTE E NÃO POSSUI LOCALIZAÇÃO FÍSICA)
          strSQL := strSQL     + '  AND (((IFNULL((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = G.ITE_CODEMP ' +  fSqlValidarQtdSaldoLote + '), 0) > 0) AND ';
          strSQL := strSQL     + '        (IFNULL((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = G.ITE_CODEMP ' +  fSqlValidarQtdSaldoLote + 'AND IFNULL(LOT_LOCFIS, "")  = ""), 0) > 0)) OR ';
          strSQL := strSQL     + '       ((IFNULL((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = G.ITE_CODEMP' +  fSqlValidarQtdSaldoLote + '), 0) = 0) AND ';
          strSQL := strSQL     + '        (IFNULL(G.ITE_LOCFIS, "") = ""))) ';
        End;
  End;

  {************************************}
  { ITENS COM LOTES: SIM, NÃO E TODOS  }
  {*********************************CI*}
  Case rdgLotesDeProdutos.ItemIndex Of
    0: Begin
         strSQL := strSQL     + '  AND IFNULL((SELECT COUNT(*) ';
         strSQL := strSQL     + '                FROM CADLOT    ';
         strSQL := strSQL     + '               WHERE LOT_CODITE = G.ITE_CODITE ';
         If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
           strSQL := strSQL + ' AND  LOT_DTAVAL >= :DTAINI ';
         If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
           strSQL := strSQL + ' AND  LOT_DTAVAL <= :DTAFIN ';

         strSQL := strSQL     + fSQLFiltroEmpresa('CADLOT', 'LOT_CODEMP') +   fSqlValidarQtdSaldoLote + '), 0) > 0 ';
       End;
    1: Begin
         strSQL := strSQL     + '  AND IFNULL((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE ' +  fSQLFiltroEmpresa('CADLOT', 'LOT_CODEMP') +  fSqlValidarQtdSaldoLote + '), 0) = 0';
       End;
    2: Begin
         strSQL := strSQL  + ' AND IF(IFNULL((SELECT COUNT(*)  ';
         strSQL := strSQL  + '           FROM CADLOT    ';
         strSQL := strSQL  + '          WHERE LOT_CODITE = G.ITE_CODITE ';
         strSQL := strSQL  + '            AND LOT_CODEMP = G.ITE_CODEMP), 0) = 0, ';
         strSQL := strSQL  + '         TRUE, ';
         strSQL := strSQL  + '         (SELECT COUNT(*)  ';
         strSQL := strSQL  + '           FROM CADLOT    ';
         strSQL := strSQL  + '          WHERE LOT_CODITE = G.ITE_CODITE ';
         strSQL := strSQL  + '            AND LOT_CODEMP = G.ITE_CODEMP' + fSqlValidarQtdSaldoLote + ') > 0) ';
       End
  End;

  strSQL     := strSQL     + fStrLocateLinGru(mskLinhaGrupo1, arrLinhaGrupo1, 'I.ITE_CODGRU','CODGRU');

  strSQL     := strSQL     + fStrLocateLinGru(mskLinhaGrupo, arrLinhaGrupo, 'I.ITE_CODGRU','CODGRU_EX', False, True);

  strSQL     := strSQL     + fSQLFiltroEmpresa('G');

  If Not fEmptyStr(edtProdutos.Text) Then
  Begin
    strSQL     := strSQL     + fStrLocate(edtProdutos, arrProduto, 'I.ITE_CODITE', 'CODITE');
  End;

  If Not fEmptyStr(edtFornecedor.Text) Then
  Begin
    strSQL     := strSQL     + fStrLocate(edtFornecedor, arrFornecedor, 'I.ITE_CODFOR', 'CODFOR');
  End;

  If Not fEmptyStr(edtMarca.Text) Then
  Begin
    strSQL     := strSQL     + fStrLocate(edtMarca, arrMarca, 'I.ITE_CODMAR', 'CODMAR');
  End;

  {**********************************}
  {* FILTRO DEPARTAMENTO DO PRODUTO *}
  {*******************************RM*}
  strSql := strSQL + fStrLocate(edtCodDep, arrCodDep, 'I.ITE_CODDEP', 'CODDEP' );

  If Not fEmptyStr(edtDescri.Text) Then
  Begin
    strSQL     := strSQL     + '  AND (LOCATE(:DESITE, I.ITE_DESITE) >0 ) ';
  end;

  If Not fEmptyStr(edtRefere.Text) Then
  Begin

    If (Not fEmptyStr(edtRefFin.Text)) Then
    Begin
      strSQL     := strSQL     + ' AND LEFT(I.ITE_REFERE, LENGTH(:MAIOR)) BETWEEN :REFERE AND :REFFIN ';
    End
    Else
    Begin
      strSQL     := strSQL     + '  AND I.ITE_REFERE LIKE :REFERE ';
    End;

  End;

  If Not fEmptyStr(edtLocFis.Text) Then
  Begin
    strSQL     := strSQL     + '  AND (((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE ' +  fSQLFiltroEmpresa('CADLOT', 'LOT_CODEMP') + ' AND LOT_LOCFIS LIKE :LOCFIS ' +  fSqlValidarQtdSaldoLote + ') > 0) OR ';
    strSQL     := strSQL     + '       ((G.ITE_LOCFIS LIKE :LOCFIS) AND (IFNULL((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE ' +  fSQLFiltroEmpresa('CADLOT', 'LOT_CODEMP') + '' +  fSqlValidarQtdSaldoLote + '), 0) = 0))) ';
  End;

  If Not fEmptyStr(edtUnidade.Text) Then
  Begin
    strSQL     := strSQL     + fStrLocate(edtUnidade, arrUnidade, 'I.ITE_CODUNI', 'CODUNI');
  End;

  if (edtImpLis.Text = 'S') then
    strSQL := strSQL + '  AND G.ITE_IMPLIS = "S"'
  else if (edtImpLis.Text = 'N') then
    strSQL := strSQL + '  AND G.ITE_IMPLIS = "N"';

  {*************************************}
  { AIVO PARA COMPRAS: SIM, NÃO E TODOS }
  {**********************************RM*}
  case rdgAtivoCompras.ItemIndex of
    0 : strSQL := strSQL + '  AND I.ITE_ATICOM = "S"';
    1 : strSQL := strSQL + '  AND I.ITE_ATICOM = "N"';
  end;

  Result := strSQL;
End;

Function TfrmRelEstPosicaoEst.fVerificaEntFut: Boolean;
Begin
  If chkEntFut.Checked And (Not chkAguarda.Checked) And (Not chkPrevisao.Checked) And (Not chkFalta.Checked) Then
  Begin
    pMensagemOk('Informe os motivos da entrega futura que deseja considerar!');
    Result := False;
  End

  Else Result := True;
End;

Function TfrmRelEstPosicaoEst.fTituloEntFut: String;
Begin
  If chkEntFut.Checked Then
  Begin
    Result := 'CONSIDERAR ENTREGA FUTURA PENDENTE NO SALDO DO PRODUTO PARA: ';

    If chkAguarda.Checked Then
      Result := Result + ' AGUANDANDO CLIENTE - ';

    If chkPrevisao.Checked Then
      Result := Result + 'PREVISÃO DE ENTREGA - ';

    If chkFalta.Checked Then
      Result := Result + 'FALTA PRODUTO';

  End Else
  Begin
    Result := 'CONSIDERAR ENTREGA FUTURA PENDENTE NO SALDO DO PRODUTO: NAO';
  End;
End;

procedure TfrmRelEstPosicaoEst.btnImprimirClick(Sender: TObject);
  Var
    strSQL     : String;
    strSQL_Rel : String;
    strLinPro  : String;
    strLinFor  : String;
    strLinMar  : String;
    strLinUni  : String;

    strCodigo,
    strDescri,
    strTitulo: String;
    strAmazemOuLote: String;
begin
  If Not fVerificaEntFut Then
    Exit;

  If blnLotArm Then
    strAmazemOuLote := 'Armazem'
  Else
    strAmazemOuLote := 'Lote';

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

    If edtOpcao.Text = 'A' Then
    Begin
      pSQLAnalitico(strSQL);
    End
    Else
    Begin
      pSQLSintetico(strSQL);
    End;

    pSQLResumoGrupo(strSQL_Rel);

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      qryRelAux := fCriaQuery(Self);
      qryRelAux.Close;
      qryRelAux.SQL.Clear;

      If (edtDestino.Text = 'E') Then
        qryRelAux.SQL.Add(strSQL_Rel)
      Else
        qryRelAux.SQL.Add(strSQL_Rel + ' DESC ');

      If Params.FindParam('LITGAL') <> Nil Then
      Begin
        If SameText(fCfgSis('LITGAL'), 'L') Then
          ParamByName('LITGAL').AsFloat := 1
        Else
          ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
      End;
      
      If Params.FindParam('EMPMAT') <> Nil Then
        ParamByName('EMPMAT').AsString := fCfgSis('EMPMAT');

      pSetaParam(edtCodEmpresa.Text,arrEmpresa,strLinEmp,'CODEMP',qryRelatorio);
      pSetaParam(edtCodEmpresa.Text,arrEmpresa,strLinEmp,'CODEMP',qryRelAux);
      pSetaParam(edtGruCmp.Text,    arrGruCmp, strGruCmp, 'GRUCMP', qryRelatorio);
      pSetaParam(edtGruCmp.Text,    arrGruCmp, strGruCmp, 'GRUCMP', qryRelAux);


      If Not fEmptyStr(mskLinhaGrupo1.Text) Then
      Begin
        pSetaParam(mskLinhaGrupo1.Text,arrLinhaGrupo1,strLinGru,'CODGRU',qryRelatorio);
        pSetaParam(mskLinhaGrupo1.Text,arrLinhaGrupo1,strLinGru,'CODGRU',qryRelAux);
      End;

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
      Begin
        pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLinGru,'CODGRU_EX',qryRelatorio);
        pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLinGru,'CODGRU_EX',qryRelAux);
      End;

      If Not fEmptyStr(edtProdutos.Text) Then
      Begin
        pSetaParam(edtProdutos.Text,arrProduto,strLinPro,'CODITE', qryRelatorio);
        pSetaParam(edtProdutos.Text,arrProduto,strLinPro,'CODITE',qryRelAux);
      End;

      If Not fEmptyStr(edtFornecedor.Text) Then
      Begin
        pSetaParam(edtFornecedor.Text,arrFornecedor,strLinFor,'CODFOR', qryRelatorio);
        pSetaParam(edtFornecedor.Text,arrFornecedor,strLinFor,'CODFOR',qryRelAux);
      End;

      If Not fEmptyStr(edtMarca.Text) Then
      Begin
        pSetaParam(edtMarca.Text,arrMarca,strLinMar,'CODMAR', qryRelatorio);
        pSetaParam(edtMarca.Text,arrMarca,strLinMar,'CODMAR',qryRelAux);
      End;

      If Not fEmptyStr(edtCodDep.Text) Then
      Begin
        pSetaParam(edtCodDep.Text,arrCodDep, strCodDep, 'CODDEP', qryRelatorio);
        pSetaParam(edtCodDep.Text,arrCodDep, strCodDep, 'CODDEP', qryRelAux);
      End;

      If Not fEmptyStr(edtDescri.Text) Then
      Begin
        ParamByName('DESITE').AsString := edtDescri.Text;
        qryRelAux.ParamByName('DESITE').AsString := edtDescri.Text;
      End;

      If Not fEmptyStr(edtLocFis.Text) Then
      Begin
        ParamByName('LOCFIS').AsString := edtLocFis.Text + '%';
        qryRelAux.ParamByName('LOCFIS').AsString := edtLocFis.Text + '%';
      End;

      If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(edtRefere.Text) Then
      Begin

        If (Not fEmptyStr(edtRefFin.Text)) Then
        Begin
          ParamByName('REFERE').AsString := edtRefere.Text;
          ParamByName('REFFIN').AsString := edtRefFin.Text;

          qryRelAux.ParamByName('REFERE').AsString := edtRefere.Text;
          qryRelAux.ParamByName('REFFIN').AsString := edtRefFin.Text;


          If Length(edtRefere.Text) > Length(edtRefFin.Text) Then
          Begin
            ParamByName('MAIOR').AsString := edtRefere.Text;
            qryRelAux.ParamByName('MAIOR').AsString := edtRefere.Text;
          End
          Else
          Begin
            ParamByName('MAIOR').AsString := edtRefFin.Text;
            qryRelAux.ParamByName('MAIOR').AsString := edtRefFin.Text;
          End;

        End
        Else
        Begin
          ParamByName('REFERE').AsString := edtRefere.Text + '%';
          qryRelAux.ParamByName('REFERE').AsString := edtRefere.Text + '%';
        End;

      End;

      If Not fEmptyStr(edtUnidade.Text) Then
      Begin
        pSetaParam(edtUnidade.Text,arrUnidade, strLinUni,'CODUNI', qryRelatorio);
        pSetaParam(edtUnidade.Text,arrUnidade, strLinUni,'CODUNI',qryRelAux);
      End;
      Open;

      qryRelAux.Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try

        If edtDestino.Text = 'E' Then
          pGeraExcel(qryRelatorio)
        Else
        Begin
          pCriarFormularios(TfrmQckEstPosicaoEst,frmQckEstPosicaoEst);

          frmQckEstPosicaoEst.dtsRelatorio.DataSet := qryRelatorio;

          frmQckEstPosicaoEst.rllEntFut.Caption := fTituloEntFut;
          frmQckEstPosicaoEst.pAbreLote := pAbreLote;
          frmQckEstPosicaoEst.blnQtdCai := blnQtdCai;

          If blnQtdCai Then
          Begin
            frmQckEstPosicaoEst.rdbSumLit1.Visible   := False;
            frmQckEstPosicaoEst.rdbSumLit2.Visible   := False;
            frmQckEstPosicaoEst.rdbSumLit3.Visible   := False;
            frmQckEstPosicaoEst.rllLitragem1.Caption := 'CAIXAS'
          End Else
          Begin
            frmQckEstPosicaoEst.rdbSumLit1.Visible   := True;
            frmQckEstPosicaoEst.rdbSumLit2.Visible   := True;
            frmQckEstPosicaoEst.rdbSumLit3.Visible   := True;
            frmQckEstPosicaoEst.rllLitragem1.Caption := 'LT/KG';
          End;

          frmQckEstPosicaoEst.qryRelAux := qryRelAux;
          frmQckEstPosicaoEst.blnResumoGP := chkResumoGP.Checked;

          If strTipImp = 'M' Then
            frmQckEstPosicaoEst.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckEstPosicaoEst.qckPagina.DefaultFilter := Nil;

          frmQckEstPosicaoEst.rllQuebra.Visible := edtOpcao.Text = 'A';
          frmQckEstPosicaoEst.rllQuebra.Caption := 'ORDENACAO: ' + UpperCase(fRemoveAcento(cbxQuebra.Text));

          { FILTRO IMPRIMIR LISTA }
          if (edtImpLis.Text = 'T') then
            frmQckEstPosicaoEst.rllImpLista.Caption := 'IMPRIMIR LISTA:TODOS'
          else if (edtImpLis.Text = 'S') then
            frmQckEstPosicaoEst.rllImpLista.Caption := 'IMPRIMIR LISTA:SIM'
          else
            frmQckEstPosicaoEst.rllImpLista.Caption := 'IMPRIMIR LISTA:NÃO';

          {**************************}
          {* HEADER ATIVO P COMPRAS *}
          {***********************RM*}
          case rdgAtivoCompras.ItemIndex of
            0 : frmQckEstPosicaoEst.rllImpAtivoCompras.Caption := 'ATIVO PARA COMPRAS:SIM';
            1 : frmQckEstPosicaoEst.rllImpAtivoCompras.Caption := 'ATIVO PARA COMPRAS:NÃO';
            2 : frmQckEstPosicaoEst.rllImpAtivoCompras.Caption := 'ATIVO PARA COMPRAS:TODOS';
          end;

          {*********************}
          {* HEADER FORNECEDOR *}
          {******************AF*}
          If Not fEmptyStr(edtFornecedor.Text) Then
            frmQckEstPosicaoEst.strOrdem := fStrTitulo(edtFornecedor.Text,edtDesFornecedor,arrFornecedor,strLinFor,'FORNECEDOR')
          Else
            frmQckEstPosicaoEst.strOrdem := 'FORNECEDOR: TODOS';
          {****************}
          {* HEADER GRUPO *}
          {*************LU*}
          If Not fEmptyStr(mskLinhaGrupo.Text) Then
              frmQckEstPosicaoEst.rllGrupo.Caption    := fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo,strLinGru,'LINHA/GRUPO NÃO INCLUSOS')
          Else
          Begin
            If Not fEmptyStr(mskLinhaGrupo1.Text) Then
                frmQckEstPosicaoEst.rllGrupo.Caption    := fStrTitulo(mskLinhaGrupo1.Text,edtDesGrupo1,arrLinhaGrupo1,strLinGru,'LINHA/GRUPO')
            Else
              frmQckEstPosicaoEst.rllGrupo.Caption    := 'LINHA / GRUPO: TODOS';
          End;
          {******************}
          {* HEADER UNIDADE *}
          {***************AF*}
          If Not fEmptyStr(edtUnidade.Text) Then
            frmQckEstPosicaoEst.rllUnidade.Caption := 'UNIDADE: ' + strLinUni
          Else
            frmQckEstPosicaoEst.rllUnidade.Caption := 'UNIDADE: TODAS';
          {****************}
          {* HEADER MARCA *}
          {*************AF*}
          If Not fEmptyStr(edtMarca.Text) Then
            frmQckEstPosicaoEst.rllMarcaOrd.Caption := fStrTitulo(edtMarca.Text,edtDesMarca,arrMarca,strLinMar,'MARCA')
          Else
            frmQckEstPosicaoEst.rllMarcaOrd.Caption := 'MARCA: TODAS';

          {***********************}
          {* HEADER DEPARTAMENTO *}
          {********************RM*}
           frmQckEstPosicaoEst.rllCodDep.Caption := fStrTitulo(edtCodDep.Text,edtDesDep,arrCodDep,strCodDep,'DEPARTAMENTO');

          {*****************}
          {* HEADER DESCRI *}
          {**************AF*}
          If Not fEmptyStr(edtDescri.Text) Then
            frmQckEstPosicaoEst.rllDescri.Caption := 'DESCRICAO: ' + edtDescri.Text
          Else
            frmQckEstPosicaoEst.rllDescri.Caption := 'DESCRICAO: TODAS';
          {*********************}
          {* HEADER REFERENCIA *}
          {******************AF*}
          frmQckEstPosicaoEst.rllGrupoCompra.Caption    := fStrTitulo(edtGruCmp.Text,edtDesGruCmp, arrGruCmp, strGruCmp,'GRUPO DE COMPRA');

          If Not fEmptyStr(edtRefere.Text) Then
          Begin
            frmQckEstPosicaoEst.rllRef.Caption := 'REFERENCIA: ' + edtRefere.Text;
            If (Not fEmptyStr(edtRefFin.Text)) Then
              frmQckEstPosicaoEst.rllRef.Caption := frmQckEstPosicaoEst.rllRef.Caption + ' A ' + edtRefFin.Text;
          End
          Else
            frmQckEstPosicaoEst.rllRef.Caption := 'REFERENCIA: TODAS';

          {******************}
          {* HEADER PRODUTO *}
          {***************AF*}
          If Not fEmptyStr(edtProdutos.Text) Then
            frmQckEstPosicaoEst.rllProdutoOrd.Caption := fStrTitulo(edtProdutos.Text,edtDesProduto,arrProduto,strLinPro,'PRODUTO')
          Else
            frmQckEstPosicaoEst.rllProdutoOrd.Caption := 'PRODUTOS: TODOS';

          {*****************************}
          {* HEADER LOCALIZAÇÃO FISICA *}
          {**************************AF*}
          If Not fEmptyStr(edtLocFis.Text) Then
            frmQckEstPosicaoEst.rllLocFis.Caption := 'LOC. FISICA INICIADA POR: ' + edtLocFis.Text
          Else
            frmQckEstPosicaoEst.rllLocFis.Caption := 'LOC. FISICA INICIADA POR: TODAS';

          {****************************************}
          { HEADER IMPRIMIR COM LOCALIZAÇÃO FISICA }
          {*************************************CI*}
          Case rdgLocalizacaoFisica.ItemIndex Of
            0:  frmQckEstPosicaoEst.rllImprimirComLocalizacao.Caption := 'IMPRIME ITENS COM LOCALIZAÇÃO FÍSICA: SIM ';
            1:  frmQckEstPosicaoEst.rllImprimirComLocalizacao.Caption := 'IMPRIME ITENS COM LOCALIZAÇÃO FÍSICA: NÃO ';
            2:  frmQckEstPosicaoEst.rllImprimirComLocalizacao.Caption := 'IMPRIME ITENS COM LOCALIZAÇÃO FÍSICA: TODOS ';
          End;

          {******************************************}
          { HEADER IMPRIMIR COM LOTE: SIM, NÃO TODOS }
          {***************************************CI*}
          If blnLotArm Then
          Begin
            frmQckEstPosicaoEst.rllLote1.Caption   := 'LOTE:';
            frmQckEstPosicaoEst.rllLote2.Caption   := 'LOTE:';
            Case rdgLotesDeProdutos.ItemIndex Of
            0: frmQckEstPosicaoEst.rllLote.Caption := 'APENAS ITENS QUE POSSUEM LOTE: SIM ';
            1: frmQckEstPosicaoEst.rllLote.Caption := 'APENAS ITENS QUE POSSUEM LOTE: NÃO ';
            2: frmQckEstPosicaoEst.rllLote.Caption := 'APENAS ITENS QUE POSSUEM LOTE: TODOS ';
            End;
          End
          Else
          Begin
            frmQckEstPosicaoEst.rllLote1.Caption   := 'ARMAZEM:';
            frmQckEstPosicaoEst.rllLote2.Caption   := 'ARMAZEM:';
            Case rdgLotesDeProdutos.ItemIndex Of
            0: frmQckEstPosicaoEst.rllLote.Caption := 'APENAS ITENS QUE POSSUEM ARMAZÉM: SIM ';
            1: frmQckEstPosicaoEst.rllLote.Caption := 'APENAS ITENS QUE POSSUEM ARMAZÉM: NÃO ';
            2: frmQckEstPosicaoEst.rllLote.Caption := 'APENAS ITENS QUE POSSUEM ARMAZÉM: TODOS ';
            End;
          End;

          {******************}
          {* HEADER EMPRESA *}
          {***************AF*}
          If fSoUmaEmpresaSelecionada Then
            frmQckEstPosicaoEst.rllEmpresa.Caption := fStrTitulo(edtCodEmpresa.Text,edtDesEmpresa,arrEmpresa,strLinEmp,'EMPRESA')
          Else
            frmQckEstPosicaoEst.rllEmpresa.Caption :=
              'EMPRESA: SALDO SOMADO DAS LOJAS, OUTRAS INFORMACOES DA MATRIZ: ' + fCfgSis('EMPMAT') + '-' + fRetNomeEmpresa(fCfgSis('EMPMAT'));

          frmQckEstPosicaoEst.strTipo   := edtOpcao.Text;
          frmQckEstPosicaoEst.intQuebra := cbxQuebra.ItemIndex;

          {***************************************}
          {HEADER STATUS: ATIVO, INATIVO E TODOS  }
          {************************************RL*}
          frmQckEstPosicaoEst.rllStatus.Caption := 'STATUS: TODOS';
          If rdgStatus.ItemIndex = 0 Then
            frmQckEstPosicaoEst.rllStatus.Caption := 'STATUS: ATIVO'
          Else If rdgStatus.ItemIndex = 1 Then
            frmQckEstPosicaoEst.rllStatus.Caption := 'STATUS: INATIVO';

          frmQckEstPosicaoEst.rllPreCus.Caption := fTituloOpcaoPreco;
          frmQckEstPosicaoEst.rllTitSaldos.Caption := fTituloSaldos;
            
          {*********************************************}
          {* VERIFICA SE EXIBE A REFERENCIA DO PRODUTO *}
          {******************************************LU*}
          If Not chkReferencia.Checked Then
          Begin
            frmQckEstPosicaoEst.rllDescricao.Width  := 320; //frmQckEstPosicaoEst.rllDescricao.Width + frmQckEstPosicaoEst.rllReferencia.Width;
            frmQckEstPosicaoEst.rldDescricao1.Width := 320; //frmQckEstPosicaoEst.rldDescricao1.Width + frmQckEstPosicaoEst.rldReferencia1.Width;
            frmQckEstPosicaoEst.rldDescricao2.Width := 320; //frmQckEstPosicaoEst.rldDescricao2.Width + frmQckEstPosicaoEst.rldReferencia2.Width;

            frmQckEstPosicaoEst.rllReferencia.Visible := False;
            frmQckEstPosicaoEst.rldReferencia1.Visible := False;
            frmQckEstPosicaoEst.rldReferencia2.Visible := False;
          End;

          {**************************************}
          {* TITULO (PREÇO CUSTO / PREÇO MEDIO) *}
          {************************************FC}
          If cbxTipPre.ItemIndex = 0 Then
          Begin
            frmQckEstPosicaoEst.rllValCusto.Caption := 'PR.CUSTO';
            frmQckEstPosicaoEst.rllTotValCusto2.Caption := 'TOT. PR.CUSTO';
          End
          Else If cbxTipPre.ItemIndex = 1 Then
          Begin
            frmQckEstPosicaoEst.rllValCusto.Caption := 'PR.CUS.REL';
            frmQckEstPosicaoEst.rllTotValCusto2.Caption := 'TOT. PR.CUS.REL';
          End
          Else If cbxTipPre.ItemIndex = 2 Then
          Begin
            frmQckEstPosicaoEst.rllValCusto.Caption := 'PR.MEDIO';
            frmQckEstPosicaoEst.rllTotValCusto2.Caption := 'TOT. PR.MEDIO';
          End
          Else If cbxTipPre.ItemIndex = 3 Then
          Begin
            frmQckEstPosicaoEst.rllValCusto.Caption := 'ULT.COMPRA';
            frmQckEstPosicaoEst.rllTotValCusto2.Caption := 'TOT. ULT.COMPRA';
          End
          Else If cbxTipPre.ItemIndex = 4 Then
          Begin
            frmQckEstPosicaoEst.rllValCusto.Caption := 'ULT.CMP.IMP';
            frmQckEstPosicaoEst.rllTotValCusto2.Caption := 'TOT. ULT.CMP.IMP';
          End;
          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            frmQckEstPosicaoEst.rllValidadeDoLote.Caption := 'Valídade do ' + strAmazemOuLote + ' Inicial: ' + mskDtaIni.Text
          Else
            frmQckEstPosicaoEst.rllValidadeDoLote.Caption := '';


          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
            frmQckEstPosicaoEst.rllValidadedoLoteFin.Caption := 'Valídade do ' + strAmazemOuLote + ' Final: ' + mskDtaIni.Text
          Else
            frmQckEstPosicaoEst.rllValidadedoLoteFin.Caption := '';

          If rdgOpcaoSaldoTodasEmpresas.Visible Then
          Begin
            If rdgOpcaoSaldoTodasEmpresas.ItemIndex = 0 Then
              frmQckEstPosicaoEst.rllOpcaoSaldo.Caption := 'OPCAO FILTRO SALDO: EMPRESA'
            Else
              frmQckEstPosicaoEst.rllOpcaoSaldo.Caption := 'OPCAO FILTRO SALDO: GERAL';
          End
          Else
            frmQckEstPosicaoEst.rllOpcaoSaldo.Caption := '';

          If Not chkMarca.Checked Then
            pEscondeMarca
          Else If (Not chkReferencia.Checked) Then
          Begin
            frmQckEstPosicaoEst.rllDescricao.Width  := frmQckEstPosicaoEst.rllDescricao.Width  - (frmQckEstPosicaoEst.rllMarca.Width  + 5);
            frmQckEstPosicaoEst.rldDescricao1.Width := frmQckEstPosicaoEst.rldDescricao1.Width - (frmQckEstPosicaoEst.rldMarca1.Width + 5);
            frmQckEstPosicaoEst.rldDescricao2.Width := frmQckEstPosicaoEst.rldDescricao2.Width - (frmQckEstPosicaoEst.rldMarca2.Width + 5);
          End;

          If gpbOpcaoSintetico.Visible Then
          Begin
             Case cbxOpcaoSint.ItemIndex Of
               0: Begin
                    strCodigo := 'CODFOR';
                    strDescri := 'NOMFOR';
                    strTitulo := 'NOME DO FORNECEDOR';
                  End;

               1: Begin
                    strCodigo := 'CODEMP';
                    strDescri := 'NOMEMP';
                    strTitulo := 'NOME DA EMPRESA';
                  End;

               2: Begin
                    strCodigo := 'CODMAR';
                    strDescri := 'MARCA';
                    strTitulo := 'MARCA';
                  End;
             End;

            frmQckEstPosicaoEst.rllDescricao2.Caption   := strTitulo;
            frmQckEstPosicaoEst.rdbDescricao2.DataField := strDescri;
            frmQckEstPosicaoEst.rdbCodigo2.DataField    := strCodigo
            
          End;

          {*********************************************}
          {* VERIFICA SE EXIBE O SALDO RESERVADO       *}
          {******************************************RV*}
          If chkSaldoRes.Checked Then
          Begin
            frmQckEstPosicaoEst.rllLitragem1.Caption     := 'SLDO RES.';
            frmQckEstPosicaoEst.rllLitragem2.Caption     := 'SLDO RES.';
            frmQckEstPosicaoEst.rdbLitragem1.DataFormula := 'SALRES';
            frmQckEstPosicaoEst.rdbLitragem2.DataFormula := 'SALRES';
            frmQckEstPosicaoEst.rdbLitragem3.DataFormula := 'SALRES';
            frmQckEstPosicaoEst.rdbSumLit1.DataFormula   := 'SALRES';
            frmQckEstPosicaoEst.rdbSumLit2.DataFormula   := 'SALRES';
            frmQckEstPosicaoEst.rdbSumLit3.DataFormula   := 'SALRES';
            frmQckEstPosicaoEst.rdbSumLit4.DataFormula   := 'SALRES';

            {***********************************************************************}
            {* ESCONDE OS TOTAIS DE LITROS E KILOS SE FOR EXIBER O SALDO RESERVADO *}
            {*********************************************************************FC}
            frmQckEstPosicaoEst.rllTotLitGru.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rllTotKilGru.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rllTotLitLin.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rllTotKilLin.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rllTotLitGer.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rllTotKilGer.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rllTotLitGerG.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rllTotKilGerG.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rdbTotLitGru.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rdbTotKilGru.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rdbTotLitLin.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rdbTotKilLin.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rdbTotLitGer.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rdbTotKilGer.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rdbTotLitGerG.Visible := Not chkSaldoRes.Checked;
            frmQckEstPosicaoEst.rdbTotKilGerG.Visible := Not chkSaldoRes.Checked;
          End;

          frmQckEstPosicaoEst.rdbTotSaldosG.Visible := chkExibirTotSaldo.Checked;
          frmQckEstPosicaoEst.rdbTotSaldosLin.Visible := chkExibirTotSaldo.Checked;
          frmQckEstPosicaoEst.rdbTotSaldos.Visible := chkExibirTotSaldo.Checked;
          frmQckEstPosicaoEst.rdbTotSaldosGru.Visible := chkExibirTotSaldo.Checked;

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frmQckEstPosicaoEst.qckPagina, frmQckEstPosicaoEst.rpsSetup)
          Else
            pPrintReport(Self.Name, Self.Caption, strNomImp, frmQckEstPosicaoEst.qckPagina);

        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckEstPosicaoEst);
    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;
  btnImprimir.Enabled := True;
  mskLinhaGrupo.Enabled := true;
  pnlInfo.Caption := '';
  strLinGru := '';
  strLinPro := '';
  strLinFor := '';
  strLinEmp := '';
  strLinUni := '';
  strLinMar := '';
  FreeAndNil(qryRelAux);
end;

procedure TfrmRelEstPosicaoEst.edtUnidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtUnidade,nil,arrUnidade,fRetNomUnidade,Nil,'da Unidade');
end;

procedure TfrmRelEstPosicaoEst.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, arrUnidade, False) Then
  Begin
    fvalidaCampos(edtUnidade,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelEstPosicaoEst.fGetSqlPesoLitroKilo(strCampo,
  strTipUni: String): String;
begin
  Result := ' IF(COALESCE(IF(TRIM(U.UNI_KILLIT) = "", NULL, U.UNI_KILLIT), "L") = "' + strTipUni + '", ' + strCampo + ', 0) ';
end;

procedure TfrmRelEstPosicaoEst.edtProdutosExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtProdutos,edtDesProduto,arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmRelEstPosicaoEst.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fvalidaCampos(edtProdutos,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstPosicaoEst.chkEntFutClick(Sender: TObject);
begin
  inherited;

  grbMotFut.Enabled := chkEntFut.Checked;

  If Not grbMotFut.Enabled Then
  Begin
    chkFalta.Checked    := False;
    chkPrevisao.Checked := False;
    chkAguarda.Checked  := False;
  End;

end;

procedure TfrmRelEstPosicaoEst.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrCodDep, fRetDescDepartamento, nil, 'do Departamento');
end;

procedure TfrmRelEstPosicaoEst.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, nil, Key, arrCodDep, False) then
  Begin
    If fValidaCampos(edtCodDep, True) then
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstPosicaoEst.edtCodEmpresaChange(Sender: TObject);
begin
  inherited;
  rdgOpcaoSaldoTodasEmpresas.Visible := (fEmptyStr(edtCodEmpresa.Text)) Or (edtCodEmpresa.Text = '000');
end;

procedure TfrmRelEstPosicaoEst.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmpresa,fRetNomeEmpresa,nil,'da Empresa');
end;

procedure TfrmRelEstPosicaoEst.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fvalidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstPosicaoEst.FormShow(Sender: TObject);
begin
  blnCadLoc           := fCfgSis('CADLOC', varBoolean);
  blnQtdCai           := fCfgSis('EMBSEP', varBoolean);
  blnLotArm           := fCfgSis('CTLEST', varBoolean);

  chkSaldoRes.Visible := Not blnQtdCai;

  If Not blnLotArm Then
  Begin
    rdgLotesDeProdutos.Caption          := 'Armazém';
    rdgLotesDeProdutos.Items.Strings[0] := 'Apenas itens que possuem armazém';
    rdgLotesDeProdutos.Items.Strings[1] := 'Apenas itens que não possuem armazém';
    grbLoteValidade.Caption := 'Validade do armazém';
  End;

  edtCodEmpresa.Text  := VS_strCodEmp;
  edtDesEmpresa.Text  := fRetNomeEmpresa;
  qryCadLot := fCriaQuery(Self);
  pSetFocus(mskLinhaGrupo1);
  pCriaQryRelatorio;
  inherited;
end;

procedure TfrmRelEstPosicaoEst.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskLinhaGrupo1);
end;

procedure TfrmRelEstPosicaoEst.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryCadLot);
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstPosicaoEst.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: begin
      If (ActiveControl Is TComboBox) Then
        SelectNext(ActiveControl, True, True);
    end;
  end;
end;

procedure TfrmRelEstPosicaoEst.mskLinhaGrupo1Exit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo1,edtDesGrupo1,arrLinhaGrupo1,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelEstPosicaoEst.mskLinhaGrupo1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo1, edtDesGrupo1, nil, Key, arrLinhaGrupo1, False) Then
  Begin
    fvalidaCampos(mskLinhaGrupo1,False);
    self.SelectNext(ActiveControl, True, True);
  End;

  If fEntraCons(Key) Then
  Begin
    Key := #0;

    If edtDesGrupo1.Text <> 'TODOS' then
    Begin
      mskLinhaGrupo.Text := '';
      edtDesGrupo.Text := '';
      mskLinhaGrupo.Enabled := false;
      pSetFocus(edtProdutos);
    End
    Else
    Begin
      mskLinhaGrupo.Enabled := true;
      pSetFocus(mskLinhaGrupo);
    End;

  End;

end;

procedure TfrmRelEstPosicaoEst.pGeraExcelResumo(qryDados: TDataSet);
  Var
    objGeraExcel: TGeraExcel;
begin
  Try
    objGeraExcel := TGeraExcel.Create(qryDados, pbProgresso);
    With objGeraExcel Do
    Begin
      blnImpEmp                         := False;
      blnCongelarPaineis                := False;
      objExcel.blnAbrirArquivoExistente := True;

      strNomArq := strNomeArquivoExcel;
      strNomRel := 'RESUMO DOS GRUPOS ';

      AddCampo('GRUPO',     'CÓDIGO');
      AddCampo('DESCGRUPO', 'DESCRIÇÃO');
      AddCampo('TOTCUS',    'TOT PR.CUSTO');
      AddCampo('TOTVEN',    'TOT PR.VENDA');

      OnMontaResumo := pMontaResumo;
      OnSomaResumo  := pSomaTotais;

      If fGerarRelatorio Then
      Begin
        fMensagem('','Arquivo gerado com sucesso!',['&OK']);
      End;
    End;

    FreeAndNil(objGeraExcel);

  Except
    On E: Exception Do
    Begin
      FreeAndNil(objGeraExcel);
      pMensagensErro(E.Message, '');
    End;
  End;    
end;

procedure TfrmRelEstPosicaoEst.pImpDetalhes(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; CorFundo: TCorExcel);
begin
  With Excel Do
  Begin

    pAbreLote(qryCadLot);

    With qryCadLot Do
    Begin
      If Not (IsEmpty) Then
      Begin
        First;
        While Not (Eof) do
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, Campos.ColunaPorNome['UNIDAD'].Coluna, fPadR(FieldByName('NUMLOT').AsString,15) +
          ' DT. VALID.: '+ fPadL(FieldByName('DTAVAL').AsString,10) +' LOC. FÍS.: ' + FieldByName('LLOFIS').AsString);
          Escrever(LinhaAtual, Campos.ColunaPorNome['SALDOS'].Coluna, fPadL(FormatFloat('##,#0.00',FieldByName('SALDOS').AsFloat), 14));

          If Not (chkSaldoRes.Checked) Then
            Escrever(LinhaAtual, Campos.ColunaPorNome['LITRAG'].Coluna, fPadL(FormatFloat('##,#0.00',FieldByName('QTDCAI').AsFloat), 14));

          Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['UNIDAD'].Coluna) + IntToStr(LinhaAtual));
          Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
          CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Preto);
          Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
          Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

          Next;
        End;
      End;
    End;

  End;
end;

procedure TfrmRelEstPosicaoEst.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
  Var
    strTotal: String;
    cfCorFundo: TCorExcel;
    strNomCol : String;
begin
  With Excel Do
  Begin
    If Quebra.NomeCampo = 'LINDES' Then
    Begin
      strTotal := 'TOTAL LINHA:   ';
      cfCorFundo := Cinza;
    End
    Else If Quebra.NomeCampo = 'GRUDES' Then
    Begin
      strTotal := 'TOTAL GRUPO:   ';
      cfCorFundo := Amarelo;
    End
    Else
    Begin
      strTotal := 'TOTAL GERAL:   ';
      cfCorFundo := Verde_Mar;
    End;
    
    ProximaLinha;
    Escrever(LinhaAtual, 01, strTotal);

    If fEmptyStr(strNomeArquivoExcel) Then
    Begin
      If (chkSaldoRes.Checked) Then
        Escrever(LinhaAtual, Campos.ColunaPorNome['SALRES'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['SALRES']), 18))
      Else
        Escrever(LinhaAtual, Campos.ColunaPorNome['LITRAG'].Coluna, fPadL(' ', 14));

      Escrever(LinhaAtual, Campos.ColunaPorNome['TOTULT'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTULT']), 18));
    End;

    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTCUS'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTCUS']), 18));
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTVEN'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTVEN']), 18));

    if (chkExibirTotSaldo.Checked)then
      Escrever(LinhaAtual, Campos.ColunaPorNome['SALDOS'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['SALDOS']), 18));

    Case cbxOpcaoSint.ItemIndex Of
      0 : strNomCol := 'NOMFOR';
      1 : strNomCol := 'NOMEMP';
      2 : strNomCol := 'MARCA' ;
    End;

    If fEmptyStr(strNomeArquivoExcel) Then
    Begin

      If edtOpcao.Text = 'S' Then
        Mesclar  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome[strNomCol].Coluna) + IntToStr(LinhaAtual))
      Else
        Mesclar  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['UNIDAD'].Coluna) + IntToStr(LinhaAtual));
    End;

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), cfCorFundo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

    If Not (chkSaldoRes.Checked) And fEmptyStr(strNomeArquivoExcel) Then
    Begin
      {********************************************}
      {* EXIBE OS VALORES DE LITROS SEPARADAMENTE *}
      {******************************************FC}
      ProximaLinha;
      Escrever(LinhaAtual, 01, 'TOTAL LITROS:   ');
      Escrever(LinhaAtual, Campos.ColunaPorNome['LITRAG'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTLIT']), 18));

      If edtOpcao.Text = 'S' Then
        Mesclar  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome[strNomCol].Coluna) + IntToStr(LinhaAtual))
      Else
        Mesclar  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['UNIDAD'].Coluna) + IntToStr(LinhaAtual));

      Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), cfCorFundo);
      CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

      {*******************************************}
      {* EXIBE OS VALORES DE KILOS SEPARADAMENTE *}
      {*****************************************FC}
      ProximaLinha;
      Escrever(LinhaAtual, 01, 'TOTAL KILOS:   ');
      Escrever(LinhaAtual, Campos.ColunaPorNome['LITRAG'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTKIL']), 18));

      If edtOpcao.Text = 'S' Then
        Mesclar  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome[strNomCol].Coluna) + IntToStr(LinhaAtual))
      Else
        Mesclar  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['UNIDAD'].Coluna) + IntToStr(LinhaAtual));

      Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), cfCorFundo);
      CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);
    End;
  End;
end;

procedure TfrmRelEstPosicaoEst.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
begin
  If fEmptyStr(strNomeArquivoExcel) Then
  Begin
    If (chkSaldoRes.Checked) Then
      Totais['SALRES'] := Totais['SALRES'] + Dados.FieldByName('SALRES').AsCurrency
    Else
    Begin
      Totais['TOTLIT'] := Totais['TOTLIT'] + Dados.FieldByName('TOTLIT').AsCurrency;
      Totais['TOTKIL'] := Totais['TOTKIL'] + Dados.FieldByName('TOTKIL').AsCurrency;
    End;

    Totais['TOTULT'] := Totais['TOTULT'] + Dados.FieldByName('TOTULT').AsCurrency;
  End;
  if chkExibirTotSaldo.Checked then
     Totais['SALDOS'] := Totais['SALDOS'] + Dados.FieldByName('SALDOS').AsCurrency;

  Totais['TOTCUS'] := Totais['TOTCUS'] + Dados.FieldByName('TOTCUS').AsCurrency;
  Totais['TOTVEN'] := Totais['TOTVEN'] + Dados.FieldByName('TOTVEN').AsCurrency;
end;

procedure TfrmRelEstPosicaoEst.pGeraExcel(qryDados: TDataSet);
  Var
    objGeraExcel: TGeraExcel;
begin
  Try
    objGeraExcel := TGeraExcel.Create(qryDados, pbProgresso);

    With objGeraExcel Do
    Begin

      strNomeArquivoExcel := EmptyStr;
      objExcel.blnShowOnTerminate := (not chkResumoGP.Checked); {Arquivo não pode ser aberto, pois será editado para gerar o resumo, req 221357}

      If edtOpcao.Text = 'A' Then
        strNomRel := 'RELATORIO DA POSICAO DE ESTOQUE - ANALITICO'
      Else
        strNomRel := 'RELATORIO DA POSICAO DE ESTOQUE - SINTETICO POR ' + Ifthen(cbxOpcaoSint.ItemIndex = 2, 'MARCA' ,Ifthen(cbxOpcaoSint.ItemIndex = 0, 'FORNECEDOR', 'EMPRESA'));

      AddFiltro('PRODUTOS: ' + Ifthen(Not fEmptyStr(edtProdutos.Text),edtProdutos.Text + ' - ' + edtDesProduto.Text,'TODOS'));
      AddFiltro('FORNECEDOR: ' + Ifthen(Not fEmptyStr(edtFornecedor.Text),edtFornecedor.Text + ' - ' + edtDesFornecedor.Text,'TODOS'));
      AddFiltro('LINHA/GRUPO: ' + Ifthen(Not fEmptyStr(mskLinhaGrupo.Text),fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo,strLinGru,'LINHA/GRUPO NÃO INCLUSOS'),
                                      Ifthen(Not fEmptyStr(mskLinhaGrupo1.Text),fStrTitulo(mskLinhaGrupo1.Text,edtDesGrupo1,arrLinhaGrupo1,strLinGru,'LINHA/GRUPO'),'TODOS')));
      AddFiltro('LOC. FÍSICA INICIADA POR: ' + Ifthen(Not fEmptyStr(edtLocFis.Text),edtLocFis.Text,'TODAS'));
      AddFiltro('MARCA: ' + Ifthen(Not fEmptyStr(edtMarca.Text),edtMarca.Text + ' - ' + edtDesMarca.Text,'TODAS'));

      {********************}
      {HEADER DEPARTAMENTO }
      {*****************RM*}
      AddFiltro(fStrTitulo(edtCodDep.Text,edtDesDep,arrCodDep,strCodDep,'DEPARTAMENTO'));

      AddFiltro('UNIDADE: ' + Ifthen(Not fEmptyStr(edtUnidade.Text),edtUnidade.Text,'TODAS'));
      AddFiltro('DESCRIÇÃO: ' + Ifthen(Not fEmptyStr(edtDescri.Text),edtDescri.Text,'TODAS'));
      AddFiltro('REFERÊNCIA: ' + Ifthen(Not fEmptyStr(edtRefere.Text),
                                     Ifthen(Not fEmptyStr(edtRefFin.Text),edtRefere.Text + ' A ' + edtRefFin.Text,edtRefere.Text),'TODAS'));
      AddFiltro(fStrTitulo(edtGruCmp.Text, edtDesGruCmp, arrGruCmp, strGruCmp, 'GRUPO DE COMPRA'));
      AddFiltro('STATUS: ' + Ifthen(rdgStatus.ItemIndex = 0,'ATIVO',Ifthen(rdgStatus.ItemIndex = 1,'INATIVO','TODOS')));
      AddFiltro(fTituloSaldos);
      
      Case rdgLocalizacaoFisica.ItemIndex Of
        0: AddFiltro('IMPRIME ITENS COM LOCALIZAÇÃO FÍSICA: SIM ');
        1: AddFiltro('IMPRIME ITENS COM LOCALIZAÇÃO FÍSICA: NÃO ');
        2: AddFiltro('IMPRIME ITENS COM LOCALIZAÇÃO FÍSICA: TODOS ');
      End;

      AddFiltro('EMPRESA: ' + fRetNomeEmpresaSelec(VS_strCodEmp));

      If blnLotArm Then
      Begin
        Case rdgLotesDeProdutos.ItemIndex Of
          0: AddFiltro('APENAS ITENS QUE POSSUEM LOTE: SIM    -  ' +  fTituloOpcaoPreco);
          1: AddFiltro('APENAS ITENS QUE POSSUEM LOTE: NÃO    -  ' +  fTituloOpcaoPreco);
          2: AddFiltro('APENAS ITENS QUE POSSUEM LOTE: TODOS  -  ' +  fTituloOpcaoPreco);
        End;
      End
      Else
      Begin
        Case rdgLotesDeProdutos.ItemIndex Of
          0: AddFiltro('APENAS ITENS QUE POSSUEM ARMAZÉM: SIM    -  ' +  fTituloOpcaoPreco);
          1: AddFiltro('APENAS ITENS QUE POSSUEM ARMAZÉM: NÃO    -  ' +  fTituloOpcaoPreco);
          2: AddFiltro('APENAS ITENS QUE POSSUEM ARMAZÉM: TODOS  -  ' +  fTituloOpcaoPreco);
        End;
      End;

      AddFiltro(fTituloEntFut);

      if ( edtImpLis.Text = 'T' ) then
        AddFiltro('IMPRIMIR LISTA:TODOS')
      else if ( edtImpLis.Text = 'S' )then
        AddFiltro('IMPRIMIR LISTA:SIM')
      else
        AddFiltro('IMPRIMIR LISTA:NÃO');

      {**************************}
      {* HEADER ATIVO P COMPRAS *}
      {***********************RM*}
      case rdgAtivoCompras.ItemIndex of
        0 : AddFiltro('ATIVO PARA COMPRAS:SIM');
        1 : AddFiltro('ATIVO PARA COMPRAS:NÃO');
        2 : AddFiltro('ATIVO PARA COMPRAS:TODOS');
      end;

      AddFiltro('STATUS: ' + Ifthen(rdgStatus.ItemIndex = 0,'ATIVO',Ifthen(rdgStatus.ItemIndex = 1,'INATIVO','TODOS')));

      If edtOpcao.Text = 'A' Then
      Begin
        AddCampo('CODIGO', 'CÓDIGO');
        AddCampo('DESITE', 'DESCRIÇÃO');

        If (chkReferencia.Checked) Then
          AddCampo('REFERE', 'REFERÊNCIA');

        If (chkMarca.Checked) Then
          AddCampo('MARCA', 'MARCA');

        AddCampo('UNIDAD', 'UN');
        AddCampo('SALDOS', 'SALDO');

        If (chkSaldoRes.Checked) Then
          AddCampo('SALRES', 'SALDO RES.')
        Else
          AddCampo('LITRAG', Ifthen(blnQtdCai,'CAIXAS','LITROS/KILOS'));

        AddCampo('VALULT', 'ULT.COMP');
        AddCampo('TOTULT', 'TOTAL');

        If cbxTipPre.ItemIndex = 0 Then
          AddCampo('VALCUS', 'PR.CUSTO')
        Else If cbxTipPre.ItemIndex = 1 Then
          AddCampo('VALCUS', 'PR.CUSTO REAL')
        Else If cbxTipPre.ItemIndex = 2 Then
          AddCampo('VALCUS', 'PR.MEDIO')
        Else If cbxTipPre.ItemIndex = 3 Then
          AddCampo('VALCUS', 'ULT.COMPRA')
        Else If cbxTipPre.ItemIndex = 4 Then
          AddCampo('VALCUS', 'ULT.COMPRA + IMP');

        AddCampo('TOTCUS', 'TOTAL');
        AddCampo('VALVEN', 'PR.VENDA');
        AddCampo('TOTVEN', 'TOTAL');
      End
      Else
      Begin
        If cbxOpcaoSint.ItemIndex = 0 Then
        Begin
          AddCampo('CODFOR', 'CÓDIGO');
          AddCampo('NOMFOR', 'NOME DO FORNECEDOR');
        End
        Else If cbxOpcaoSint.ItemIndex = 1 Then
        Begin
          AddCampo('CODEMP', 'CÓDIGO');
          AddCampo('NOMEMP', 'NOME DA EMPRESA');
        End
        Else If cbxOpcaoSint.ItemIndex = 2 Then
        Begin
          AddCampo('CODMAR', 'CÓDIGO');
          AddCampo('MARCA', 'MARCA');
        End;

        If (chkSaldoRes.Checked) Then
          AddCampo('SALRES', 'SALDO RES.')
        Else
          AddCampo('LITRAG', 'LITROS/KILOS');

        AddCampo('TOTULT', 'TOT ULT.COMPRA');

        If cbxTipPre.ItemIndex = 0 Then
          AddCampo('TOTCUS', 'TOT PR.CUSTO')
        Else If cbxTipPre.ItemIndex = 1 Then
          AddCampo('TOTCUS', 'TOT PR.CUSTO REAL')
        Else If cbxTipPre.ItemIndex = 2 Then
          AddCampo('TOTCUS', 'TOT PR.MEDIO')
        Else If cbxTipPre.ItemIndex = 3 Then
          AddCampo('TOTCUS', 'TOT ULT.COMPRA')
        Else If cbxTipPre.ItemIndex = 4 Then
          AddCampo('TOTCUS', 'TOT ULT.COMPRA + IMP');

        AddCampo('TOTVEN', 'TOT PR.VENDA');
      End;

      If (gpbQuebra.Visible) Then
      Begin
        Case cbxQuebra.ItemIndex Of
           1: Begin
                AddQuebra('LINDES', 'LINHA: ');
                AddQuebra('GRUDES', 'GRUPO: ');
              End;
        End;        
      End;

      If (chkSaldoRes.Checked) Then
        AddTotais('SALRES')
      Else
      Begin
        AddTotais('TOTLIT');
        AddTotais('TOTKIL');
      End;

      AddTotais('TOTULT');
      AddTotais('TOTCUS');
      AddTotais('TOTVEN');

      OnMontaResumo := pMontaResumo;
      OnSomaResumo  := pSomaTotais;

      If edtOpcao.Text = 'A' Then
        OnImpDetalhes := pImpDetalhes;

      If fGerarRelatorio Then
      Begin
        If (chkResumoGP.Checked) Then
        Begin
          strNomeArquivoExcel := objExcel.NomeArquivo;
          pGeraExcelResumo(qryRelAux);
        End
        Else
        Begin
          fMensagem('','Arquivo gerado com sucesso!',['&OK']);
        End;
      End;

    End;

    FreeAndNil(objGeraExcel);

  Except
    On E: Exception Do
    Begin
      FreeAndNil(objGeraExcel);
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmRelEstPosicaoEst.edtDestinoExit(Sender: TObject);
begin
//inherited;
end;

function TfrmRelEstPosicaoEst.fTituloSaldos: String;
  Var
    strSaldos: String;
begin
  strSaldos := '';

  If SameText(edtSaldos.Text, 'T') Then
    strSaldos := '(T)ODOS'
  Else If SameText(edtSaldos.Text, 'N') Then
    strSaldos := '(N)EGATIVO'
  Else If SameText(edtSaldos.Text, 'P') Then
    strSaldos := '(P)OSITIVO'
  Else If SameText(edtSaldos.Text, 'Z') Then
    strSaldos := '(Z)ERO';

  Result := 'SALDOS: ' + strSaldos;
end;

procedure TfrmRelEstPosicaoEst.pEscondeMarca;
begin

  If (Not chkReferencia.Checked) Then
  Begin
    frmQckEstPosicaoEst.rllDescricao.Width   := 320;//frmQckEstPosicaoEst.rllDescricao.Width  + frmQckEstPosicaoEst.rllReferencia.Width  + frmQckEstPosicaoEst.rllMarca.Width;
    frmQckEstPosicaoEst.rldDescricao1.Width  := 320;//frmQckEstPosicaoEst.rldDescricao1.Width + frmQckEstPosicaoEst.rldReferencia1.Width + frmQckEstPosicaoEst.rldMarca1.Width;
    frmQckEstPosicaoEst.rldDescricao2.Width  := 320;//frmQckEstPosicaoEst.rldDescricao2.Width + frmQckEstPosicaoEst.rldReferencia2.Width + frmQckEstPosicaoEst.rldMarca2.Width;

    frmQckEstPosicaoEst.rllMarca.Visible     := False;
    frmQckEstPosicaoEst.rldMarca1.Visible    := False;
    frmQckEstPosicaoEst.rldMarca2.Visible    := False;
  End
  Else If (chkReferencia.Checked) Then  //And (Not chkMarca.Checked)
  Begin
    frmQckEstPosicaoEst.rllReferencia.Left   := frmQckEstPosicaoEst.rllMarca.Left - 15;
    frmQckEstPosicaoEst.rldReferencia1.Left  := frmQckEstPosicaoEst.rldMarca1.Left - 15;
    frmQckEstPosicaoEst.rldReferencia2.Left  := frmQckEstPosicaoEst.rldMarca2.Left - 15;

    frmQckEstPosicaoEst.rllReferencia.Width  := frmQckEstPosicaoEst.rllReferencia.Width - 5;
    frmQckEstPosicaoEst.rldReferencia1.Width := frmQckEstPosicaoEst.rldReferencia1.Width - 5;
    frmQckEstPosicaoEst.rldReferencia2.Width := frmQckEstPosicaoEst.rldReferencia2.Width - 5;

    frmQckEstPosicaoEst.rllDescricao.Width   := frmQckEstPosicaoEst.rllDescricao.Width  + frmQckEstPosicaoEst.rllReferencia.Width;
    frmQckEstPosicaoEst.rldDescricao1.Width  := frmQckEstPosicaoEst.rldDescricao1.Width + frmQckEstPosicaoEst.rldReferencia1.Width;
    frmQckEstPosicaoEst.rldDescricao2.Width  := frmQckEstPosicaoEst.rldDescricao2.Width + frmQckEstPosicaoEst.rldReferencia2.Width;

    frmQckEstPosicaoEst.rllMarca.Visible     := False;
    frmQckEstPosicaoEst.rldMarca1.Visible    := False;
    frmQckEstPosicaoEst.rldMarca2.Visible    := False;
  End;

end;

Function TfrmRelEstPosicaoEst.fSQLFiltroLote(blnFiltraSaldoLote: Boolean = False): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  If (blnFiltraSaldoLote) And (rdbSalLot.Checked) Then
    strSQL := ' AND LOT_SALDOS ' + fSqlValidarQtdSaldoLote(blnFiltraSaldoLote);

  If Not fEmptyStr(edtLocFis.Text) Then
    strSQL := strSQL + ' AND LOT_LOCFIS LIKE :LOCFIS ';

  Case rdgLocalizacaoFisica.ItemIndex Of
    0: strSQL := strSQL + '  AND IFNULL(LOT_LOCFIS, "") <> "" ';
    1: strSQL := strSQL + '  AND IFNULL(LOT_LOCFIS, "") = "" ';
  End;

  If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    strSQL := strSQL + ' AND  LOT_DTAVAL >= :DTAINI ';
  If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    strSQL := strSQL + ' AND  LOT_DTAVAL <= :DTAFIN ';


  Result := strSQL;
End;

procedure TfrmRelEstPosicaoEst.pAbreLote(qryCadLot: TUniQuery);
Begin
  With qryCadLot, SQL Do
  Begin
    Close;

    Clear;
    Add('SELECT');
    Add('  LOT_LOCFIS AS LLOFIS,');
    Add('  LOT_NUMLOT AS NUMLOT,');
    Add('  LOT_CODEMP AS CODEMP,');

    Add('  LOT_DTAVAL AS DTAVAL,');
    Add('  SUM(LOT_SALDOS) AS SALDOS,');
    Add('  SUM(IF(ITE_MLTVEN > 0, LOT_SALDOS / ITE_MLTVEN, 0)) AS QTDCAI');
    Add('FROM CADLOT ');
    Add('INNER JOIN CADITE ON ITE_CODITE = LOT_CODITE');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE');
    Add(   fSQLFiltroEmpresa('CADLOT', 'LOT_CODEMP'));
    Add(fSQLFiltroLote);
    Add(' GROUP BY LOT_NUMLOT');
    If fUsaRotinaWMS Then
      Add(' , LOT_LOCFIS ');

    If (edtSaldos.Text <> 'T') And (rdbSalLot.Checked) Then
    Begin
      Add(' HAVING ( ROUND( SALDOS, 2) ');

      If (edtSaldos.Text = 'N') Then
        Add(' < 0 ');

      If (edtSaldos.Text = 'P') Then
        Add(' > 0 ');

      If (edtSaldos.Text = 'Z') Then
        Add(' = 0 ');

      Add(' ) ');
    End;

    pSetaParam(edtCodEmpresa.Text, arrEmpresa, strLinEmp, 'CODEMP', qryCadLot);

    ParamByName('CODITE').AsString := qryRelatorio.FieldByName('CODIGO').AsString;

    If Not fEmptyStr(edtLocFis.Text) Then
      ParamByName('LOCFIS').AsString := edtLocFis.Text;

    If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    Open;
  End;

End;

procedure TfrmRelEstPosicaoEst.pAjustaSintetico;
begin
  gpbOpcaoSintetico.Visible := edtOpcao.Text = 'S';

  If (edtOpcao.Text = 'S') Then
  Begin
    chkSaldoRes.Checked := False;
    chkSaldoRes.Enabled := False;

    chkReferencia.Checked := False;
    chkReferencia.Enabled := False;

    chkMarca.Checked := False;
    chkMarca.Enabled := False;

    chkExibirTotSaldo.Enabled := False;
    chkExibirTotSaldo.Checked := False;
  End
  Else
  Begin
    chkSaldoRes.Enabled   := True;
    chkReferencia.Enabled := True;
    chkMarca.Enabled      := True;
    chkExibirTotSaldo.Enabled := True;
  End;
end;

end.