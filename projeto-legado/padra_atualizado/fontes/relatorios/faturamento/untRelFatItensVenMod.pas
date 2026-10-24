unit untRelFatItensVenMod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts, untTypesSistema,
  BitBtnLockedIncrem, DB, UniClientDataSet, ComCtrls, ComboBoxFocus,
  frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmRelFatItensVenMod = class(TfrmPaiRelatorio)
    Label11: TLabel;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label10: TLabel;
    Label1: TLabel;
    edtFornecedor: TEditFocus;
    edtMarca: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDesMarca: TEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtUnidade: TEditFocus;
    edtDesUnidade: TEditFocus;
    Label7: TLabel;
    mskCST: TMaskEditFocus;
    mskCFOP: TMaskEditFocus;
    Label88: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtCodVendedor: TEditFocus;
    edtCodRepresentante: TEditFocus;
    edtDesVendedor: TEditFocus;
    edtDesRepresentante: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    Label15: TLabel;
    cdsRelatorio: TUniClientDataSet;
    cdsRelatorioCODITE: TStringField;
    cdsRelatorioDESITE: TStringField;
    cdsRelatorioREFERE: TStringField;
    cdsRelatorioUNIDAD: TStringField;
    cdsRelatorioQTDITE: TFloatField;
    cdsRelatorioTOTITE: TFloatField;
    cdsRelatorioATIVO: TStringField;
    cdsRelatorioPROBAS: TStringField;
    cdsRelatorioCOMLUB: TStringField;
    cdsRelatorioCODFIS: TStringField;
    cdsRelatorioCLAFIS: TStringField;
    cdsRelatorioIMPLIS: TStringField;
    pbgRelatorio: TProgressBar;
    grpMargem: TGroupBox;
    ColorLabel8: TColorLabel;
    shpMargem: TShape;
    edtMargem: TEditFocus;
    lbl2: TLabel;
    cdsRelatorioTOTCUS: TFloatField;
    cdsRelatorioDESESP: TFloatField;
    lbl3: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label16: TLabel;
    lbl1: TLabel;
    lbl4: TLabel;
    mskHorIni: TMaskEditFocus;
    mskHorFin: TMaskEditFocus;
    gpbIncPis: TGroupBox;
    edtIncidePis: TEditFocus;
    ColorLabel2: TColorLabel;
    gpbAtivo: TGroupBox;
    edtAtivo: TEditFocus;
    ColorLabel4: TColorLabel;
    gpbProBas: TGroupBox;
    edtProdBase: TEditFocus;
    ColorLabel6: TColorLabel;
    gpbComLub: TGroupBox;
    ColorLabel3: TColorLabel;
    edtCombLub: TEditFocus;
    gpbImpLis: TGroupBox;
    edtImpList: TEditFocus;
    ColorLabel5: TColorLabel;
    gpbOperacao: TGroupBox;
    edtOperac: TEditFocus;
    ColorLabel7: TColorLabel;
    Label2: TLabel;
    cbbComCus: TComboBoxFocus;
    chkTotQtd: TCheckBox;
    mskEspDoc: TMaskEditFocus;
    procedure pAtualizaClaFis;
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtUnidadeExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodRepresentanteExit(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtOperacChange(Sender: TObject);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
  private
    arrLinhaGrupo: TConsultasArray;
    arrUnidade: TConsultasArray;
    arrFornec: TConsultasArray;
    arrMarca: TConsultasArray;
    arrVendedor: TConsultasArray;
    arrRepresen: TConsultasArray;
    arrEmpresa: TConsultasArray;
    arrCliente: TConsultasArray;
    QryRel       : TUniQuery;
      
    strLinGru: String;
    strLinUni: String;
    strLinFor: String;
    strLinMar: String;
    strLinVen: String;
    strLinRep: String;
    strLinEmp: String;
    strLinCli: String;
      
    procedure pGeraExcel;
    procedure pSintetizaItens;

    function fHorFinEmpty: Boolean;
    function fHorIniEmpty: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelFatItensVenMod: TfrmRelFatItensVenMod;

implementation

uses untQckFatItensVenMod, untFuncoesFactory, untIFuncoes, untExcel,
  untClassPanelCx;

{$R *.dfm}

procedure TfrmRelFatItensVenMod.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;


procedure TfrmRelFatItensVenMod.FormShow(Sender: TObject);
begin
  shpMargem.Brush.Color := clGreen;

  frxRelatorio.DataSet := QryRel;

  If Not fVerificaAcessoSistema('MARREL') Then
  Begin
    shpMargem.Brush.Color := clRed;
    edtMargem.TabStop     := False;
    edtMargem.ReadOnly    := True;
    edtMargem.Text        := 'N';
  End;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  inherited;
end;

procedure TfrmRelFatItensVenMod.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);  
end;

procedure TfrmRelFatItensVenMod.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtUnidade, edtDesUnidade, nil, nil, Key, arrUnidade, False) Then
  Begin
    fvalidaCampos(edtUnidade,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatItensVenMod.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatItensVenMod.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornec,fRetNomFornecedor,Nil,'do Fornecedor');
end;

procedure TfrmRelFatItensVenMod.edtUnidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtUnidade,edtDesUnidade,arrUnidade,fRetNomUnidade,Nil,'da Unidade');
end;

procedure TfrmRelFatItensVenMod.edtMarcaKeyPress(Sender: TObject;
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

procedure TfrmRelFatItensVenMod.edtOperacChange(Sender: TObject);
begin
  inherited;
  If (edtOperac.Text = 'V') Then
    Caption := 'Relatório de Produtos Vendidos Por Modalidade'
  Else
    Caption := 'Relatório de Produtos Comprados Por Modalidade';
end;

procedure TfrmRelFatItensVenMod.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,Nil,'da Marca');
end;

{*****************}
{* VALIDA CAMPOS *}
{**************LB*}
function TfrmRelFatItensVenMod.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;
  If (inherited  fValidaCampos(Sender, blnValidaIndividual)) Then
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

    Else If (Sender = mskHorIni) Then
    Begin
      If fHorIniEmpty Then
        mskHorFin.Clear
      Else
      Begin
        If StrToTimeDef(mskHorIni.Text, 0) = 0 Then
        Begin
          fMensagem('', 'Hora Inicial Inválida!', ['&O k']);
          Result := False;
        End;

      End;
    End

    Else If (Sender = mskHorFin) Then
    Begin
      If fHorFinEmpty and (not fHorIniEmpty) Then
      Begin
        fMensagem('', 'A Hora Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If not fHorFinEmpty Then
      Begin
        If fHorIniEmpty Then
          mskHorFin.Clear
          
        Else If StrToTimeDef(mskHorFin.Text, 0) = 0 Then
        Begin
          fMensagem('', 'Hora Final Inválida!', ['&O k']);
          Result := False;
        End
        
        Else If (mskHorFin.Text < mskHorIni.Text) Then
        Begin
          fMensagem('', 'A Hora Inicial deve ser menor que a Hora Final!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtIncidePis) Then
    Begin
      If Not (Pos(edtIncidePis.Text, 'S_N_T_') > 0) Then
      Begin
        fMensagem('','O campo Incide Pis deve ter S, N ou T!',['&O K']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtAtivo) Then
    Begin
      If (edtAtivo.Text <> 'S') And (edtAtivo.Text <> 'N') Then
      Begin
        fMensagem('','O campo Ativo deve ter S ou N!',['&O K']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtProdBase) Then
    Begin
      If Not (Pos(edtProdBase.Text, 'S_N_T_') > 0) Then
      Begin
        fMensagem('','O campo Produto Base deve ter S, N ou T!',['&O K']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtCombLub) Then
    Begin
      If Not (Pos(edtCombLub.Text, 'S_N_T_') > 0) Then
      Begin
        fMensagem('','O campo Combustivel/Lubrificante deve ter S, N ou T!',['&O K']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtImpList) Then
    Begin
      If (edtImpList.Text <> 'S') And (edtImpList.Text <> 'N') and (edtImpList.Text <> 'T') Then
      Begin
        fMensagem('','O campo Imprime Lista deve ter S, N ou T!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtOperac) Then
    Begin

      If (Pos(edtOperac.Text, 'VC') <= 0) Then
      Begin
        fMensagem('','O campo Operação deve ser (V)enda ou (C)ompra!',['&O K']);
        Result := False;
      End;

    End

    {************************************}
    {* VALIDA MARGEM                    *}
    {*********************************RV*}
    Else If (Sender = edtMargem) Then
    Begin

      If (edtMargem.Text <> 'S') And (edtMargem.Text <> 'N') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Mostrar Margem deve ser S ou N!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) And (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCliente) Then
    Begin

      If edtCodCliente.Enabled Then
      Begin
        pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrCliente, Nil, fRetNomCliente, 'do cliente');        
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelFatItensVenMod.btnImprimirClick(Sender: TObject);
  Var
    strSQL,
    strUnion,
    strCusTmp: String;
    qryGenMod: TUniQuery;
begin

  qryGenMod := fCriaQuery(Self);

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CONCAT(LEFT(CADITE.ITE_CODGRU,3),".",RIGHT(CADITE.ITE_CODGRU,3),".",DET_CODITE) AS CODITE, ';
    strSQL := strSQL + '  CADITE.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  CADITE.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  CADITE.ITE_CODUNI AS UNIDAD, ';
    strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE, DET_QTDITE)) AS QTDITE, ';

    strSQL := strSQL + '  SUM(DET_DESESP) AS DESESP,   ';

    strCusTmp := '  IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0) ';

    strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(' + strCusTmp + '), ' + strCusTmp + ')) AS TOTCUS, ';

    strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, ';
    strSQL := strSQL + '    -(IF(DET_TOTITE IS NULL,0,DET_TOTITE) - IF(DET_DESESP IS NULL,0,DET_DESESP) - IF(DET_DESCFF IS NULL,0,DET_DESCFF)), ';
    strSQL := strSQL + '    IF(DET_TOTITE IS NULL,0,DET_TOTITE) - IF(DET_DESESP IS NULL,0,DET_DESESP) - IF(DET_DESCFF IS NULL,0,DET_DESCFF))) AS TOTITE, ';

    strSQL := strSQL + '  CADITE.ITE_ITEATI AS ATIVO, ';
    strSQL := strSQL + '  CADITE.ITE_ITEBAS AS PROBAS, ';
    strSQL := strSQL + '  CADITE.ITE_COMLUB AS COMLUB, ';
    strSQL := strSQL + '  ITEGER.ITE_IMPLIS AS IMPLIS, ';
    strSQL := strSQL + '  DET_CODFIS AS CODFIS, ';
    strSQL := strSQL + '  DET_CLAFIS AS CLAFIS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET D ';
    strSQL := strSQL + 'LEFT JOIN CADITE ON DET_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + 'LEFT JOIN ITEGER ON ';
    strSQL := strSQL + '  D.DET_CODITE = ITEGER.ITE_CODITE AND ';
    strSQL := strSQL + '  D.DET_CODEMP = ITEGER.ITE_CODEMP     ';
    strSQL := strSQL + 'LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM  ';


    strSQL := strSQL + 'WHERE ';

    If (edtOperac.Text = 'V') Then
      strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND '; {EDUARDO}

    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';

    If not fHorIniEmpty Then
      strSQL := strSQL + '  DET_HORENT BETWEEN :HORINI AND :HORFIN AND ';

    strSQL := strSQL + '  DET_ESPDOC NOT IN ("AJ", "BR", "TM", "ML", "PR") AND ';

    If edtOperac.Text = 'V' Then
      strSQL := strSQL + '  DET_TIP_FC = "C" '
    Else
      strSQL := strSQL + '  DET_TIP_FC = "F" ';

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      strSQL := strSQL + fStrLocateLinGru(mskLinhaGrupo, arrLinhaGrupo, 'ITE_CODGRU', 'CODGRU');
      {
      If Length(arrLinhaGrupo) > 1 Then
        strSQL := strSQL + '  AND LOCATE(ITE_CODGRU,:CODGRU) > 0 '
      Else
      Begin
        If RightStr(mskLinhaGrupo.Text,3) = '000' Then
        Begin
          strSQL := strSQL + '  AND LEFT(CADITE.ITE_CODGRU,3) = LEFT(:CODGRU,3) ';
        End
        Else
        Begin
          strSQL := strSQL + '  AND CADITE.ITE_CODGRU = :CODGRU ';
        End;
      End;
      }
    End;

    If Not fEmptyStr(edtUnidade.Text) Then
      strSQL := strSQL + fStrLocate(edtUnidade,arrUnidade,'CADITE.ITE_CODUNI','UNIDAD');    

    If Not fEmptyStr(edtFornecedor.Text) Then
      strSQL := strSQL + fStrLocate(edtFornecedor,arrFornec,'DET_FORITE','CODFOR');    

    If Not fEmptyStr(edtMarca.Text) Then
      strSQL := strSQL + fStrLocate(edtMarca,arrMarca,'CADITE.ITE_CODMAR','CODMAR');    

    If (Pos(edtIncidePis.Text, 'S_N_') > 0) Then
      strSQL := strSQL + '  AND DET_INCPIS = :INCPIS ';

    If Not fEmptyStr(edtAtivo.Text) Then
      strSQL := strSQL + '  AND CADITE.ITE_ITEATI = :ATIVO ';

    If (Pos(edtProdBase.Text, 'S_N_') > 0) Then
      strSQL := strSQL + '  AND CADITE.ITE_ITEBAS = :PROBAS ';

    If (Pos(edtCombLub.Text, 'S_N_') > 0) Then
      strSQL := strSQL + '  AND CADITE.ITE_COMLUB = :COMLUB ';

    If (Pos(edtImpList.Text, 'S_N_') > 0) Then
      strSQL := strSQL + '  AND ITEGER.ITE_IMPLIS = :IMPLIS ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskCFOP.Text)) Then
      strSQL := strSQL + '  AND LOCATE(DET_CLAFIS,:CLAFIS) > 0 ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskCST.Text)) Then
      strSQL := strSQL + '  AND LOCATE(DET_CODFIS,:CODFIS) > 0 ';

    If Not fEmptyStr(edtCodVendedor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVendedor,arrVendedor,'DET_CODVEN','CODVEN');    

    If Not fEmptyStr(edtCodRepresentante.Text) Then
      strSQL := strSQL + fStrLocate(edtCodRepresentante,arrRepresen,'DET_CODREP','CODREP');        

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa,arrEmpresa, 'DET_CODEMP', 'CODEMP')    
    Else
      strSQL := strSQL + '  AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If Not fEmptyStr(edtCodCliente.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCliente,  arrCliente, 'DET_CODCLI', 'CODCLI');    

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspDoc.Text)) Then
      strSQL := strSQL + '  AND LOCATE(DET_ESPDOC,:ESPDOC) > 0 ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  DET_CODITE ';

    strSQL := strSQL + ' ORDER BY 1 ';

    strUnion := strSQL;

    QryRel := fCriaQuery;

    With QryRel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If not fHorIniEmpty Then
      Begin
        ParamByName('HORINI').AsTime := StrToTime(mskHorIni.Text);
        ParamByName('HORFIN').AsTime := StrToTime(mskHorFin.Text);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskCFOP.Text)) Then
        ParamByName('CLAFIS').AsString := mskCFOP.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskCST.Text)) Then
        ParamByName('CODFIS').AsString := mskCST.Text;

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLinGru,'CODGRU', QryRel);

      If Not fEmptyStr(edtUnidade.Text) Then
        pSetaParam(edtUnidade.Text,arrUnidade,strLinUni,'UNIDAD', QryRel);

      If Not fEmptyStr(edtFornecedor.Text) Then
        pSetaParam(edtFornecedor.Text,arrFornec,strLinFor,'CODFOR', QryRel);

      If Not fEmptyStr(edtMarca.Text) Then
        pSetaParam(edtMarca.Text,arrMarca,strLinMar,'CODMAR', QryRel);

      If (Pos(edtIncidePis.Text, 'S_N_') > 0) Then
        ParamByName('INCPIS').AsString := edtIncidePis.Text;

      If Not fEmptyStr(edtAtivo.Text) Then
        ParamByName('ATIVO').AsString := edtAtivo.Text;

      If (Pos(edtProdBase.Text, 'S_N_') > 0) Then
        ParamByName('PROBAS').AsString := edtProdBase.Text;

      If (Pos(edtCombLub.Text, 'S_N_') > 0) Then
        ParamByName('COMLUB').AsString := edtCombLub.Text;

      If (Pos(edtImpList.Text, 'S_N_') > 0) Then
        ParamByName('IMPLIS').AsString := edtImpList.Text;

      If Not fEmptyStr(edtCodVendedor.Text) Then
        pSetaParam(edtCodVendedor.Text,arrVendedor,strLinVen,'CODVEN',QryRel);

      If Not fEmptyStr(edtCodRepresentante.Text) Then
        pSetaParam(edtCodRepresentante.Text,arrRepresen,strLinRep,'CODREP', QryRel);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text,arrEmpresa,strLinEmp,'CODEMP', QryRel);

      If Not fEmptyStr(edtCodCliente.Text) Then
        pSetaParam(edtCodCliente.Text, arrCliente, strLinCli, 'CODCLI', QryRel);

      If Not fEmptyStr(fTiraCaracEspeciais(mskEspDoc.Text)) Then
        ParamByName('ESPDOC').AsString := mskEspDoc.Text;

      Open;

      pSintetizaItens;
    End;

    If Not cdsRelatorio.IsEmpty Then
    Begin

      If edtDestino.Text = 'E' Then
        pGeraExcel
      Else
      Begin
        Try
          pCriarFormularios(TfrmQckFatItensVenMod,frmQckFatItensVenMod);
          frmQckFatItensVenMod.dtsRelatorio.DataSet := cdsRelatorio;

          frmQckFatItensVenMod.rldTotQtd.Visible := chkTotQtd.Checked;

          If strTipImp = 'M' Then
            frmQckFatItensVenMod.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckFatItensVenMod.qckPagina.DefaultFilter := Nil;

          {****************}
          {* HEADER GRUPO *}
          {*************LB*}
          If (edtOperac.Text = 'C') Then
            frmQckFatItensVenMod.rllNomeRelatorio.Caption := 'RELATORIO DE PRODUTOS COMPRADOS POR MODALIDADE';

          frmQckFatItensVenMod.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          If Not fHorIniEmpty Then
            frmQckFatItensVenMod.strOrdem := frmQckFatItensVenMod.strOrdem + ' - HORÁRIO: ' + mskHorIni.Text + ' AS ' + mskHorFin.Text; 

          If Not fEmptyStr(mskLinhaGrupo.Text) Then
            frmQckFatItensVenMod.rllLinhaGrupo.Caption := fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo,strLinGru,'LINHA/GRUPO')
          Else
            frmQckFatItensVenMod.rllLinhaGrupo.Caption := 'LINHA/GRUPO: TODOS ';

          If Not fEmptyStr(edtUnidade.Text) Then
            frmQckFatItensVenMod.rllUnidade.Caption := fStrTitulo(edtUnidade.Text,edtDesUnidade,arrUnidade,strLinUni,'UNIDADE')
          Else
            frmQckFatItensVenMod.rllUnidade.Caption := 'UNIDADE: TODOS ';

          If Not fEmptyStr(edtFornecedor.Text) Then
            frmQckFatItensVenMod.rllFornecedor.Caption := fStrTitulo(edtFornecedor.Text,edtDesFornecedor,arrFornec,strLinFor,'FORNECEDOR')
          Else
            frmQckFatItensVenMod.rllFornecedor.Caption := 'FORNECEDOR: TODOS ';

          If Not fEmptyStr(edtMarca.Text) Then
            frmQckFatItensVenMod.rllMarca.Caption := fStrTitulo(edtMarca.Text,edtDesMarca,arrMarca,strLinMar,'MARCA')
          Else
            frmQckFatItensVenMod.rllMarca.Caption := 'MARCA: TODOS ';

          If Not fEmptyStr(mskCST.Text) Then
            frmQckFatItensVenMod.rllCST.Caption := 'C.S.T.: ' + mskCST.Text
          Else
            frmQckFatItensVenMod.rllCST.Caption := 'C.S.T.: TODOS ';

          If Not fEmptyStr(mskCFOP.Text) Then
            frmQckFatItensVenMod.rllCFOP.Caption := 'C.F.O.P.: ' + mskCFOP.Text
          Else
            frmQckFatItensVenMod.rllCFOP.Caption := 'C.F.O.P.: TODOS ';

          If Not fEmptyStr(edtIncidePis.Text) Then
            frmQckFatItensVenMod.rllIncPis.Caption := 'INCIDE PIS: ' + edtIncidePis.Text
          Else
            frmQckFatItensVenMod.rllIncPis.Caption := 'INCIDE PIS: TODOS ';

          If Not fEmptyStr(edtAtivo.Text) Then
            frmQckFatItensVenMod.rllAtivo.Caption := 'ATIVO: ' + edtAtivo.Text
          Else
            frmQckFatItensVenMod.rllAtivo.Caption := 'ATIVO: TODOS ';

          If Not fEmptyStr(edtProdBase.Text) Then
            frmQckFatItensVenMod.rllProdBase.Caption := 'PRODUTO BASE: ' + edtProdBase.Text
          Else
            frmQckFatItensVenMod.rllProdBase.Caption := 'PRODUTO BASE: TODOS ';

          If Not fEmptyStr(edtCombLub.Text) Then
            frmQckFatItensVenMod.rllComLub.Caption := 'COMBUSTIVEL/LUBRIFICANTE: ' + edtCombLub.Text
          Else
            frmQckFatItensVenMod.rllComLub.Caption := 'COMBUSTIVEL/LUBRIFICANTE: TODOS ';

          If (Pos(edtImpList.Text, 'S_N_') > 0) Then
            frmQckFatItensVenMod.rllImpList.Caption := 'IMPRIME LISTA: ' + edtImpList.Text
          Else
            frmQckFatItensVenMod.rllImpList.Caption := 'IMPRIME LISTA: TODOS ';

          If Not fEmptyStr(edtCodVendedor.Text) Then
            frmQckFatItensVenMod.rllVendedor.Caption := fStrTitulo(edtCodVendedor.Text,edtDesVendedor,arrVendedor,strLinVen,'VENDEDOR')
          Else
            frmQckFatItensVenMod.rllVendedor.Caption := 'VENDEDOR: TODOS ';

          If Not fEmptyStr(edtCodRepresentante.Text) Then
            frmQckFatItensVenMod.rllRepresentante.Caption := fStrTitulo(edtCodRepresentante.Text,edtDesRepresentante,arrRepresen,strLinRep,'REPRESENTANTE')
          Else
            frmQckFatItensVenMod.rllRepresentante.Caption := 'REPRESENTANTE: TODOS ';

          If fEmptyStr(edtCodEmpresa.Text) Then
            frmQckFatItensVenMod.rllEmpresa.Caption := 'EMPRESA: TODOS '
          Else
            frmQckFatItensVenMod.rllEmpresa.Caption := fStrTitulo(edtCodEmpresa.Text,edtDesEmpresa,arrEmpresa,strLinEmp,'EMPRESA');

          If fEmptyStr(edtCodCliente.Text) Then
            frmQckFatItensVenMod.rllCliente.Caption := 'CLIENTE: TODOS '
          Else
            frmQckFatItensVenMod.rllCliente.Caption := fStrTitulo(edtCodCliente.Text,edtDesCliente,arrCliente,strLinCli,'CLIENTE');          

          If fEmptyStr(fTiraCaracEspeciais(mskEspDoc.Text)) Then
            frmQckFatItensVenMod.rllEspecie.Caption := 'ESPECIE: TODAS '
          Else
            frmQckFatItensVenMod.rllEspecie.Caption := 'ESPECIE: ' + AnsiReplaceStr(mskEspDoc.Text,'-',', ');;

          frmQckFatItensVenMod.rllComCus.Caption := 'CUSTO POR: ' + cbbComCus.Text;

          frmQckFatItensVenMod.rllCusto.Visible  := (edtMargem.Text = 'S');
          frmQckFatItensVenMod.rlbCusto.Visible  := (edtMargem.Text = 'S');
          frmQckFatItensVenMod.rlbTotCus.Visible := (edtMargem.Text = 'S');
          frmQckFatItensVenMod.rllMargem.Visible := (edtMargem.Text = 'S');
          frmQckFatItensVenMod.rlbMargem.Visible := (edtMargem.Text = 'S');
          frmQckFatItensVenMod.rlbTotMar.Visible := (edtMargem.Text = 'S');

          If edtDestino.Text = 'V' Then
            frmQckFatItensVenMod.qckPagina.PreviewModal
          Else
            frmQckFatItensVenMod.qckPagina.Print;

          pbgRelatorio.Position := 0;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckFatItensVenMod);
      End;
      
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

  FreeAndNil(qryGenMod);

end;

procedure TfrmRelFatItensVenMod.FormCreate(Sender: TObject);
begin
  inherited;
  pCarregaComposicaoCusto(cbbComCus);

  pAtualizaClaFis;
  cdsRelatorio.CreateDataSet;


end;

procedure TfrmRelFatItensVenMod.pAtualizaClaFis;
  Var
    strClaFis: String;
begin

  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;


end;

procedure TfrmRelFatItensVenMod.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVendedor,edtDesVendedor,arrVendedor,fRetNomVendRep,Nil,'do Vendedor');
end;

procedure TfrmRelFatItensVenMod.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor, False) Then  
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatItensVenMod.edtCodRepresentanteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRepresentante,edtDesRepresentante,arrRepresen,fRetNomVendRep,Nil,'do Representante');
end;

procedure TfrmRelFatItensVenMod.edtCodRepresentanteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodRepresentante, edtDesRepresentante, nil, Key, arrRepresen, False) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatItensVenMod.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente,edtDesCliente,arrCliente,Nil,fRetNomCliente,'do Cliente');
end;

procedure TfrmRelFatItensVenMod.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatItensVenMod.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmpresa,Nil,fRetNomeEmpresaSelec,'da Empresa');
end;

procedure TfrmRelFatItensVenMod.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatItensVenMod.edtDestinoExit(Sender: TObject);
begin
// inherited;

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

procedure TfrmRelFatItensVenMod.pGeraExcel;
  Var
    objExcel  : TExcel;
    intQtdCol : Integer;
    strUltCol : String;
    arrColunas: Array [1..7] Of Array [1..2] Of String;
    intCont   : Integer;
    fltTotIte : Double;
    fltQtdIte : Double;
    intLinCong : Integer;
Begin
  arrColunas[01][01] := 'CODIGO';
  arrColunas[02][01] := 'DESCRICAO DO ITEM';
  arrColunas[03][01] := 'REFERENCIA';
  arrColunas[04][01] := 'C.F.O.P.';
  arrColunas[05][01] := 'UNIDADE';
  arrColunas[06][01] := 'QUANT. TOTAL';
  arrColunas[07][01] := 'VALOR VENDIDO';

  arrColunas[01][02] := 'CODITE';
  arrColunas[02][02] := 'DESITE';
  arrColunas[03][02] := 'REFERE';
  arrColunas[04][02] := 'CLAFIS';
  arrColunas[05][02] := 'UNIDAD';
  arrColunas[06][02] := 'QTDITE';
  arrColunas[07][02] := 'TOTITE';

  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel, cdsRelatorio Do
  Begin
    pnlInfo.Caption := 'Aguarde... Gerando Arquivo!';

    PintarTudo(Branco);
    DefinirFonte(CourierNew, 10);

    LinhaAtual := 1;
    intQtdCol  := Length(arrColunas);
    strUltCol  := fGetLetraAlfa(intQtdCol);

    Escrever(LinhaAtual, 01, fRetNomeEmpresa);

    Escrever(ProximaLinha, 01, 'RELATORIO DE PRODUTOS VENDIDOS POR MODALIDADE');

    Escrever(ProximaLinha, 01, 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);
    Escrever(ProximaLinha, 01, IfThen(fEmptyStr(fTiraCaracEspeciais(mskEspDoc.Text)),'ESPECIE: TODAS','ESPECIE: ' + AnsiReplaceStr(mskEspDoc.Text,'-',', ')));
    Escrever(ProximaLinha, 01, IfThen(fEmptyStr(mskLinhaGrupo.Text),'LINHA/GRUPO: TODOS', fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo,strLinGru,'LINHA/GRUPO')));
    Escrever(ProximaLinha, 01, IfThen(fEmptyStr(edtUnidade.Text), 'UNIDADE: TODAS', fStrTitulo(edtUnidade.Text,edtDesUnidade,arrUnidade,strLinUni,'UNIDADE')));
    Escrever(ProximaLinha, 01, IfThen(fEmptyStr(edtFornecedor.Text), 'FORNECEDOR: TODOS', fStrTitulo(edtFornecedor.Text,edtDesFornecedor,arrFornec,strLinFor,'FORNECEDOR')));
    Escrever(ProximaLinha, 01, IfThen(fEmptyStr(edtMarca.Text), 'MARCA: TODAS', fStrTitulo(edtMarca.Text,edtDesMarca,arrMarca,strLinMar,'MARCA')));
    Escrever(ProximaLinha, 01, 'C.S.T.: ' + IfThen(fEmptyStr(mskCST.Text), 'TODOS', mskCST.Text));
    Escrever(ProximaLinha, 01, 'C.F.O.P.: ' + IfThen(fEmptyStr(mskCFOP.Text), 'TODAS', mskCFOP.Text));
    Escrever(ProximaLinha, 01, 'INCIDE PIS: ' + IfThen(fEmptyStr(edtIncidePis.Text), 'TODOS', edtIncidePis.Text));
    Escrever(ProximaLinha, 01, 'ATIVO: ' + IfThen(fEmptyStr(edtAtivo.Text), 'TODOS', edtAtivo.Text));
    Escrever(ProximaLinha, 01, 'PRODUTO BASE: ' + IfThen(fEmptyStr(edtProdBase.Text), 'TODOS', edtProdBase.Text));
    Escrever(ProximaLinha, 01, 'COMBUSTIVEL/LUBRIFICANTE: ' + IfThen(fEmptyStr(edtCombLub.Text), 'TODOS', edtCombLub.Text));
    Escrever(ProximaLinha, 01, 'IMPRIME LISTA: ' + IfThen(Pos(edtImpList.Text, 'S_N_') > 0, edtImpList.Text, 'TODOS'));
    Escrever(ProximaLinha, 01, IfThen(fEmptyStr(edtCodVendedor.Text), 'VENDEDOR: TODOS', fStrTitulo(edtCodVendedor.Text,edtDesVendedor,arrVendedor,strLinVen,'VENDEDOR')));
    Escrever(ProximaLinha, 01, IfThen(fEmptyStr(edtCodRepresentante.Text), 'REPRESENTANTE: TODOS', fStrTitulo(edtCodRepresentante.Text,edtDesRepresentante,arrRepresen,strLinRep,'REPRESENTANTE')));
    Escrever(ProximaLinha, 01, IfThen(fEmptyStr(edtCodEmpresa.Text), 'EMPRESA: TODAS', fStrTitulo(edtCodEmpresa.Text,edtDesEmpresa,arrEmpresa,strLinEmp,'EMPRESA')));
    Escrever(ProximaLinha, 01, 'CUSTO POR: ' + cbbComCus.Text);

    For intCont := 1 To LinhaAtual Do
    Begin
      Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
      Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
      Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
    End;

    CorFundo('A2', strUltCol + '3', Cinza);
    Bordas('A2', strUltCol + '3',True,True,True,True);

    ProximaLinha;

    intLinCong := LinhaAtual+1;

    For intCont := 1 To intQtdCol Do
    Begin
      Escrever(LinhaAtual, intCont, arrColunas[intCont, 01]);
      Negrito(LinhaAtual, intCont, True);

      If FieldByName(arrColunas[intCont, 02]).DataType = ftFloat Then
        Alinhamento(LinhaAtual,intCont, Direita)
      Else
        Alinhamento(LinhaAtual,intCont, Esquerda);

    End;

    CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
    CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
    Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

    First;

    fltTotIte := 0;
    fltQtdIte := 0;

    While Not Eof Do
    Begin

      ProximaLinha;

      For intCont := 1 To intQtdCol Do
      Begin

        If FieldByName(arrColunas[intCont, 02]).DataType = ftFloat Then
        Begin
          Escrever(LinhaAtual, intCont, FormatFloat('#,##0.00', FieldByName(arrColunas[intCont, 02]).AsFloat));
          Alinhamento(LinhaAtual, intCont, Direita);
        End
        Else
        Begin
          Escrever(LinhaAtual, intCont, '''' + FieldByName(arrColunas[intCont, 02]).AsString);
          Alinhamento(LinhaAtual, intCont, Esquerda);
        End;

      End;

      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      fltTotIte := fltTotIte + FieldByName('TOTITE').AsFloat;
      fltQtdIte := fltQtdIte + FieldByName('QTDITE').AsFloat;
      Next;
    End;

    ProximaLinha;

    If Not chkTotQtd.Checked Then
      Escrever(LinhaAtual, 06, 'TOTAL')
    Else
    Begin
      Escrever(LinhaAtual, 05, 'TOTAL');
      Escrever(LinhaAtual, 06, FormatFloat('#,##0.00', fltQtdIte));
      Alinhamento(LinhaAtual, 06, Direita);
    End;

    Escrever(LinhaAtual, 07, FormatFloat('#,##0.00', fltTotIte));

    Alinhamento(LinhaAtual, 07, Direita);
    CorFundo('A' + IntToStr(LinhaAtual) , 'G' + IntToStr(LinhaAtual), Cinza);
    Bordas('A' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual), True,True,True,True);

    OrientacaoPagina(Retrato);
    AutoAjuste;
    CongelarPaines('A' + IntToStr(intLinCong));
    SalvarArquivo;
    FecharArquivo;
    pnlInfo.Caption := '';

    fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);
    pbgRelatorio.Position := 0;
  End;

  FreeAndNil(objExcel);

End;

procedure TfrmRelFatItensVenMod.pSintetizaItens;
  Var
    strCodIte: String;
    fltQtdIte: Double;
    fltTotIte: Double;
    fltTotCus: Double;
    fltDesEsp: Double;
begin
  cdsRelatorio.EmptyDataSet;
  pbgRelatorio.Position := 0;
  pbgRelatorio.Max := QryRel.RecordCount;

  While (Not QryRel.Eof) Do
  Begin
    strCodIte := QryRel.FieldByName('CODITE').AsString;
    fltQtdIte := 0;
    fltTotIte := 0;
    fltTotCus := 0;
    fltDesEsp := 0;
    cdsRelatorio.Append;

    cdsRelatorio.FieldByName('CODITE').AsString := QryRel.FieldByName('CODITE').AsString;
    cdsRelatorio.FieldByName('DESITE').AsString := QryRel.FieldByName('DESITE').AsString;
    cdsRelatorio.FieldByName('REFERE').AsString := QryRel.FieldByName('REFERE').AsString;
    cdsRelatorio.FieldByName('UNIDAD').AsString := QryRel.FieldByName('UNIDAD').AsString;
    cdsRelatorio.FieldByName('ATIVO').AsString  := QryRel.FieldByName('ATIVO').AsString;
    cdsRelatorio.FieldByName('PROBAS').AsString := QryRel.FieldByName('PROBAS').AsString;
    cdsRelatorio.FieldByName('COMLUB').AsString := QryRel.FieldByName('COMLUB').AsString;
    cdsRelatorio.FieldByName('IMPLIS').AsString := QryRel.FieldByName('IMPLIS').AsString;
    cdsRelatorio.FieldByName('CODFIS').AsString := QryRel.FieldByName('CODFIS').AsString;
    cdsRelatorio.FieldByName('CLAFIS').AsString := QryRel.FieldByName('CLAFIS').AsString;

    While (Not QryRel.Eof) And
          (strCodIte = QryRel.FieldByName('CODITE').AsString) Do
    Begin
      fltQtdIte := fltQtdIte + QryRel.FieldByName('QTDITE').AsFloat;
      fltTotIte := fltTotIte + QryRel.FieldByName('TOTITE').AsFloat;
      fltTotCus := fltTotCus + QryRel.FieldByName('TOTCUS').AsFloat;
      fltDesEsp := fltDesEsp + QryRel.FieldByName('DESESP').AsFloat;

      QryRel.Next;
      pbgRelatorio.StepBy(1);
      Application.ProcessMessages;
    End;

    If fFormataFloat(fltQtdIte, 2) <> 0.00 Then
    Begin
      cdsRelatorio.FieldByName('QTDITE').AsFloat := fltQtdIte;
      cdsRelatorio.FieldByName('TOTITE').AsFloat := fltTotIte;
      cdsRelatorio.FieldByName('TOTCUS').AsFloat := fltTotCus;
      cdsRelatorio.FieldByName('DESESP').AsFloat := fltDesEsp;
      cdsRelatorio.Post;
    End
    Else
      cdsRelatorio.Cancel;

  End;
  cdsRelatorio.First;
end;

function TfrmRelFatItensVenMod.fHorFinEmpty: Boolean;
begin
  Result := fEmptyStr(fTiraCaracEspeciais(mskHorFin.Text, True, False, False, True));
end;

function TfrmRelFatItensVenMod.fHorIniEmpty: Boolean;
begin
  Result := fEmptyStr(fTiraCaracEspeciais(mskHorIni.Text, True, False, False, True));
End;

End.

