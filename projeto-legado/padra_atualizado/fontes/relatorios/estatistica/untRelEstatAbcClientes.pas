unit untRelEstatAbcClientes;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, untTypesSistema,
  Dialogs, StdCtrls, untPaiRelatorio, Menus, RLFilters, RLDraftFilter,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus,
  DBCtrls, DBEditFocus, ComCtrls, StrUtils, ComObj, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, Uni, AppEvnts, UniClientDataSet, UniDataSetProvider,
  DB, BitBtnLockedIncrem, frxExportCSVTestabilidade, ComboBoxFocus;

type
  TfrmRelEstatAbcClientes = class(TfrmPaiRelatorio)
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label8: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    edtCodVendedor: TEditFocus;
    Label14: TLabel;
    edtCodRepresentante: TEditFocus;
    Label40: TLabel;
    edtQtdCli: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    lstClaFis: TMemo;
    edtDesVendedor: TEditFocus;
    edtDesRepresentante: TEditFocus;
    edtAtividade: TEditFocus;
    svdExcel: TSaveDialog;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbMargem: TGroupBox;
    ColorLabel4: TColorLabel;
    edtMargem: TEditFocus;
    lblFornecedor: TLabel;
    edtDesFor: TEditFocus;
    edtCodFor: TEditFocus;
    lblProduto: TLabel;
    edtDesPro: TEditFocus;
    edtCodPro: TEditFocus;
    edtDesCli: TEditFocus;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    grp1: TGroupBox;
    lblQbrDentro1: TColorLabel;
    edtTipo: TEditFocus;
    edtCodAti: TEditFocus;
    Label11: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    rdgEmpresa: TRadioGroup;
    grbExibirCpfCnpj: TGroupBox;
    chkExibirCpfCnpj: TCheckBox;
    Label3: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    cbbComCus: TComboBoxFocus;
    lblComCus: TLabel;
    lblDepVen: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    Label19: TLabel;
    edtDepIte: TEditFocus;
    edtDesDepIte: TEditFocus;
    shaRep: TShape;
    shaVen: TShape;
    rdgTipAbc: TRadioGroup;
    Label4: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepresentanteExit(Sender: TObject);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure pAtualizaClaFis;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtTipoExit(Sender: TObject);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edtDepIteExit(Sender: TObject);
    procedure edtDepIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodProExit(Sender: TObject);
    procedure mskLinhaGrupoEnter(Sender: TObject);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cdsCliABC : TUniClientDataSet;
    cdsAbc: TUniClientDataSet;
    fltSoma: Double;
    qryRelatorio: TUniQuery;
    blnLiberado: Boolean;

    arrAtividade,
    arrRede,
    arrRegiao,
    arrLinhaGrupo,
    arrLinDepart,
    arrVendedor,
    arrRepresen,
    arrDepart,
    arrMarca,
    arrFornec,
    arrProduto,
    arrClientes,
    arrEmp : TConsultasArray;

    strCodVen,
    strCodRep,
    strVendedor,
    strRepres : String;

    strLinhaGrupo,
    strAtividade,
    strRede,
    strRegiao,
    strLinDepart,
    strDepart,
    strMarca,
    strFornec,
    strProduto,
    strClientes,
    strEmp: String;

    function fSQLFiltroEmpresa: String;

    procedure pGeraExcelAbcClientes;
		procedure pCriaQryRelatorio;
    procedure pVerdeVermelho(edtCodigo: TEditFocus; shaVen: TShape; blnLiberado: Boolean);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

Const
  TIPABC_CLIENTE = 0;
  TIPABC_CLIENTE_DEP_PRODUTO = 1;

var
  frmRelEstatAbcClientes: TfrmRelEstatAbcClientes;

implementation

uses  untQckEstatAbcClientes, untConstantes, untExcel, untFuncoesGenerica,
  untFuncoesFactory, untIFuncoes, untClassPanelCx;

{$R *.dfm}

procedure TfrmRelEstatAbcClientes.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  If blnLiberado Then
    pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrVendedor, fRetNomVendRep, nil, 'do Vendedor');
end;

procedure TfrmRelEstatAbcClientes.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnLiberado) And (fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor, False)) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcClientes.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelEstatAbcClientes.edtCodRedeKeyPress(Sender: TObject;
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

procedure TfrmRelEstatAbcClientes.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg,edtDesReg,arrRegiao,nil,fRetNomRegiao,'da Região');
end;

procedure TfrmRelEstatAbcClientes.edtCodRegKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao, False) Then
  Begin
    If fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcClientes.edtCodRepresentanteExit(Sender: TObject);
begin
  inherited;
  If blnLiberado Then
    pEdtCodSelectExit(edtCodRepresentante, edtDesRepresentante, arrRepresen, fRetNomVendRep, nil, 'do Representante');
end;

procedure TfrmRelEstatAbcClientes.edtCodRepresentanteKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If (blnLiberado) And (fPesqOperador(Self, edtCodRepresentante, edtDesRepresentante, nil, Key, arrRepresen, False)) Then
  Begin
    If fValidaCampos(edtCodRepresentante, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcClientes.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti,edtAtividade,arrAtividade,nil,fRetNomAtividade,'da Atividade');
end;

procedure TfrmRelEstatAbcClientes.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtAtividade, Nil, Key, arrAtividade, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmRelEstatAbcClientes.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin
  //'5102_5403_5405_5655_5656_6102_6108_6404_6405_6655_6656_'
  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;
End;

procedure TfrmRelEstatAbcClientes.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
end;

procedure TfrmRelEstatAbcClientes.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstatAbcClientes.FormCreate(Sender: TObject);
begin
  inherited;
  pCarregaComposicaoCusto(cbbComCus);

  blnLiberado := fVerificaAcessoSistema('RABCCL');

  pVerdeVermelho(edtCodVendedor,      shaVen, blnLiberado);
  pVerdeVermelho(edtCodRepresentante, shaRep, blnLiberado);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  pAtualizaClaFis;
  pSetaCodIte(edtCodPro);
end;

procedure TfrmRelEstatAbcClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If ActiveControl Is TRadioButton Then
    Self.SelectNext(ActiveControl, True, True)
  Else
    inherited;
end;

procedure TfrmRelEstatAbcClientes.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresaExit(Sender);

  strCodRep := '';
  strCodVen := '';

  shpMultSel.Visible := True;

  inherited;
end;

function TfrmRelEstatAbcClientes.fSQLFiltroEmpresa: String;
begin
  Case rdgEmpresa.ItemIndex Of
    0: Result := ' DET_CODEMP ';
    1: Result := ' MOVTRI.DET_EMPORI ';
  End;
end;

function TfrmRelEstatAbcClientes.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
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

    Else If (Sender = mskLinhaGrupo) Then
    Begin
      if (fEmptyStr(mskLinhaGrupo.Text)) then
        pDesmarcaLista(mskLinhaGrupo,arrLinhaGrupo,'',6);
    End

    Else If (Sender = edtCodPro) Then
    Begin
      if (fEmptyStr(edtCodPro.Text)) then
        pDesmarcaLista(edtCodPro,arrProduto);
    End

    Else If (Sender = edtCodFor) Then
    Begin
      if (fEmptyStr(edtCodFor.Text)) then
        pDesmarcaLista(edtCodFor,arrFornec);
    End

    Else If (Sender = edtMarca) Then
    Begin
      if (fEmptyStr(edtMarca.Text)) then
        pDesmarcaLista(edtMarca,arrMarca);
    End


    Else If (Sender = edtCodCli) Then
    Begin
      if (fEmptyStr(edtCodCli.Text)) then
        pDesmarcaLista(edtCodCli,arrClientes);
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


    Else If (Sender = edtCodAti) Then
    Begin
      if (fEmptyStr(edtCodAti.Text)) then
        pDesmarcaLista(edtCodAti,arrAtividade);
    End


    Else If (Sender = edtQtdCli) Then
    Begin

      If StrToInt(edtQtdCli.Text) < 1 Then
      Begin
        fMensagem('ATENÇÃO!','A quantidade de clientes a ser impressos deve ser maior ou igual a 1!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtMargem) Then
    Begin

      If Pos(edtMargem.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Mostrar Margem deve ser S ou N!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodVendedor) Then
    Begin

      If blnLiberado Then
      Begin
        pDesmarcaLista(edtCodVendedor, arrVendedor);
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
          fMensagem('', 'Vendedor não encontrado.', ['&O K']);
        End;

      End
      Else
      Begin
        edtDesVendedor.Text := 'TODOS';
        strCodVen := '';
      End;

    End

    {******************************}
    {* VALIDA REPRESENTANTE       *}
    {***************************JB*}
    Else If (Sender = edtCodRepresentante) Then
    Begin

      If blnLiberado Then
      Begin
        pDesmarcaLista(edtCodRepresentante, arrRepresen);
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
          fMensagem('', 'Representante não encontrado.', ['&O K']);
        End;

      End Else
      Begin
        edtDesRepresentante.Text := 'TODOS';
        strCodRep := '';
      End;

    End

    Else If (Sender = edtDepIte) Then
    Begin
      if (fEmptyStr(edtDepIte.Text)) then
        pDesmarcaLista(edtDepIte, arrDepart);
    End

    Else If (Sender = edtCodDep) Then
    Begin
      if (fEmptyStr(edtCodDep.Text)) then
        pDesmarcaLista(edtCodDep, arrLinDepart);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelEstatAbcClientes.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
  edtCodPro.Clear;
  edtDesPro.Text := '';
  pDesmarcaLista(edtCodPro,arrProduto);
end;

procedure TfrmRelEstatAbcClientes.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelEstatAbcClientes.mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then  
  Begin
    fValidaCampos(mskLinhaGrupo,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcClientes.btnImprimirClick(Sender: TObject);
  Var
    strSQL   : String;
    strUnion : String;
    strSQL2  : String;
    strSQL3  : String;
    dspCliAbc: TUniDataSetProvider;
    strSQLLinGru,
    strLinGru,
    strCusto: String;
    intCnt: Integer;
    fltAcuComGeral,
    fltAcuCusGeral,
    fltAcuComDep,
    fltAcuCusDep,
    fltTotComCli,
    fltTotCusCli: Double;
    strCli: String;
begin
  cdsCliAbc := TUniClientDataSet.Create(Self);
  dspCliAbc := TUniDataSetProvider.Create(Self);
  cdsCliAbc.SetProvider(dspCliAbc);
  dspCliAbc.DataSet := qryRelatorio;
  cdsCliAbc.AggregatesActive := True;
  fltAcuComDep := 0.00;
  fltAcuCusDep := 0.00;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_TOTCOM';
    FieldName     := 'TOT_TOTCOM';
    DataSet       := cdsCliAbc;
    Expression    := 'SUM(TOTCOM)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If fEmptyStr(strCodVen) And fEmptyStr(strCodRep) And (Not blnLiberado) Then
  Begin
    blnImprime := False;
    fMensagem('', 'Informe a Senha para o Vendedor ou Representante!', ['&Ok']);
  End;

  If blnImprime Then
  Begin
    strCusto := 'IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0)';

    try
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
      strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
      strSQL := strSQL + '  CLI_C_G_C_ AS C_G_C_, ';
      strSQL := strSQL + '  SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF))) AS TOTCOM, ';
      strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, - (' + strCusto + '), (' +  strCusto + '))) AS TOTCUS ';

      If rdgTipABC.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
        strSQL := strSQL + '  , DEP_DESCRI AS DEPART ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI ';
      strSQL := strSQL + '        JOIN MOVDET ON DET_CODCLI = CLI_CODCLI ';
      strSQL := strSQL + '  INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
      strSQL := strSQL + '        JOIN CADITE ON ITE_CODITE = DET_CODITE ';
      strSQL := strSQL + '        JOIN CADOPE ON OPE_CODOPE = DET_CODVEN ';

      // Seleciona o departamento do item quando for por departamento
      If rdgTipABC.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
        strSQL := strSQL + '  LEFT JOIN CADDEP ON DEP_CODIGO = ITE_CODDEP ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND '; {EDUARDO}
      strSQL := strSQL + '  DET_TIP_FC = "C" AND ';

      If edtTipo.Text = 'F' Then
        strSQL := strSQL + '  CLI_CGCCPF = "2" AND '
      Else If edtTipo.Text = 'J' Then
        strSQL := strSQL + '  CLI_CGCCPF = "1" AND ';

      strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
      strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';

      strSQL := strSQL + cnsFiltroFFDVTR;      
      
      strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

      If fCfgSis('ENTBRF', varBoolean) Then
        strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
      Else
        strSQL := strSQL + ') ';

      If Not fEmptyStr(edtCodVendedor.Text) Then
        strSQL := strSQL + fStrLocate(edtCodVendedor, arrVendedor, 'DET_CODVEN','CODVEN');

      If Not fEmptyStr(edtCodRepresentante.Text) Then
        strSQL := strSQL + fStrLocate(edtCodRepresentante, arrRepresen, 'DET_CODREP', 'CODREP');

      If Not fEmptyStr(edtMarca.Text) Then
        strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'ITE_CODMAR', 'CODMAR');

      If Not fEmptyStr(edtCodFor.Text) Then
        strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'DET_FORITE', 'CODFOR');

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
              strSQLLinGru := strSQLLinGru + ' (LEFT(ITE_CODGRU,3) = ' + QuotedStr(LeftStr(arrLinhaGrupo[intCnt].strCodigo,3)) + ')'
            Else
              strSQLLinGru := strSQLLinGru + ' (ITE_CODGRU = ' + QuotedStr(arrLinhaGrupo[intCnt].strCodigo) + ')';
          End;
        End;
      End
      Else
      Begin
        If (Length(arrLinhaGrupo) = 1) Or (Not fEmptyStr(mskLinhaGrupo.Text)) Then
        begin
          If RightStr(mskLinhaGrupo.Text,3) = '000' Then
            strSQL := strSQL + '  AND (LOCATE(LEFT(ITE_CODGRU,3), LEFT(:CODGRU,3)) > 0 ) '
          Else
            strSQL := strSQL + '  AND (LOCATE(ITE_CODGRU, :CODGRU) > 0 ) ';
        End;
      End;

      If (Not fEmptyStr(strSQLLinGru)) Then
        strSQL := strSql + ' AND ( ' + strSQLLinGru + ' ) ';

      If Not fEmptyStr(edtCodPro.Text) Then
        strSQL := strSQL + fStrLocate(edtCodPro, arrProduto, 'DET_CODITE', 'CODITE');

      If Not fEmptyStr(edtCodCli.Text) Then
        strSQL := strSQL + fStrLocate(edtCodCli, arrClientes, 'DET_CODCLI', 'CODCLI');

      If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

      If Not fEmptyStr(edtCodReg.Text) Then
        strSQL := strSQL + fStrLocate(edtCodReg,arrRegiao,'CLI_CODREG','CODREG');

      If Not fEmptyStr(edtCodAti.Text) Then
        strSQL := strSQL + fStrLocate(edtCodAti, arrAtividade, 'CLI_CODATI', 'CODATI');

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, fSQLFiltroEmpresa, 'CODEMP')
      Else
        strSQL := strSQL + '  AND LOCATE(' + fSQLFiltroEmpresa + ',' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      If Not fEmptyStr(edtDepIte.Text) Then
        strSQL := strSQL + fStrLocate(edtDepIte, arrDepart, 'ITE_CODDEP','DEPITE');

      If Not fEmptyStr(edtCodDep.Text) Then
        strSQL := strSQL + fStrLocate(edtCodDep,arrLinDepart,'OPE_CODDEP','CODDEP');

      strSQL := strSQL + 'GROUP BY CODCLI ';
      If rdgTipABC.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
        strSQL := strSQL + '  , DEPART ';

      strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

      strSQL3 := '';
      strSQL3 := strSQl3 + 'SELECT SQL_NO_CACHE ';
      strSQL3 := strSQl3 + '  CODCLI AS CODCLI, ';
      strSQL3 := strSQl3 + '  NOMCLI AS NOMCLI, ';
      strSQL3 := strSQl3 + '  C_G_C_ AS C_G_C_, ';

      If rdgTipABC.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
        strSQL3 := strSQL3 + '  DEPART, ';

      strSQL3 := strSQl3 + '  SUM(TOTCOM) AS TOTCOM, ';
      strSQL3 := strSQl3 + '  SUM(TOTCUS) AS TOTCUS ';
      strSQL3 := strSQl3 + 'FROM ( ';
      strSQL3 := strSQL3 +  strSQL + ' ) AS TAB2 GROUP BY CODCLI ';
      If rdgTipABC.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
        strSQL3 := strSQL3 + '  , DEPART ';

      strUnion := strSQL3;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  CODCLI, ';
      strSQL := strSQL + '  NOMCLI, ';
      strSQL := strSQL + '  C_G_C_, ';

      If rdgTipABC.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
        strSQL := strSQL + '  DEPART, ';

      strSQL := strSQL + '  SUM(CTR_VALDUP) AS VALDUP, ';
      strSQL := strSQL + '  SUM(CHQ_VALCHQ) AS VALCHQ, ';

      strSQL := strSQL + '  SUM(TOTCOM) AS TOTCOM, ';
      strSQL := strSQL + '  SUM(TOTCUS) AS TOTCUS  ';
      strSQL := strSQL + 'FROM ( ';
      strSQL := strSQL +  strUnion + ' ) AS TAB ';

      strSQL := strSQL + '  LEFT JOIN ';
      strSQL := strSQL + '  (SELECT ';
      strSQL := strSQL + '    CTR_CODCLI, ';
      strSQL := strSQL + '    SUM(CTR_VALDUP) AS CTR_VALDUP ';
      strSQL := strSQL + '  FROM ';

      strSQL := strSQL + '  (SELECT ';
      strSQL := strSQL + '    CTR_CODCLI, ';
      strSQL := strSQL + '    SUM(CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) - IFNULL(CTR_DESSUJ, 0)) AS CTR_VALDUP ';
      strSQL := strSQL + '  FROM ';
      strSQL := strSQL + '    CADREC ';
      strSQL := strSQL + '  WHERE ';
      strSQL := strSQL + '    CTR_DTAREC IS NULL ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'CTR_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      If Not fEmptyStr(edtCodVendedor.Text) Then
        strSQL := strSQL + fStrLocate(edtCodVendedor, arrVendedor, 'CTR_CODVEN','CODVEN');

      If Not fEmptyStr(edtCodCli.Text) Then
        strSQL := strSQL + fStrLocate(edtCodCli, arrClientes, 'CTR_CODCLI', 'CODCLI');

      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '   CTR_CODCLI ';
      strSQL := strSQL + ' ) AS TMP ';
      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '   CTR_CODCLI ';
      strSQL := strSQL + ' ) AS TMPCTR ';
      strSQL := strSQL + '  ON CTR_CODCLI = CODCLI ';

      strSQL := strSQL + '  LEFT JOIN ';
      strSQL := strSQL + '  (SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '    CHQ_CODCLI, ';
      strSQL := strSQL + '    SUM(CHQ_VALCHQ) AS CHQ_VALCHQ ';
      strSQL := strSQL + '  FROM ';
      strSQL := strSQL + '  (SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '    CHQ_CODCLI, ';
      strSQL := strSQL + '    SUM(CHQ_VALCHQ) AS CHQ_VALCHQ ';
      strSQL := strSQL + '  FROM ';
      strSQL := strSQL + '    CADCHQ ';
      strSQL := strSQL + '  WHERE TRUE ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'CHQ_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + '  AND LOCATE(CHQ_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      strSQL := strSQL + '    AND CHQ_DTADEP IS NULL AND ';
      strSQL := strSQL + '    CHQ_INCCTR = "N" ';
      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '    CHQ_CODCLI ';
      strSQL := strSQL + ' ) AS TMP ';
      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '    CHQ_CODCLI ';
      strSQL := strSQL + ' ) AS TMPCHQ ';
      strSQL := strSQL + '  ON CHQ_CODCLI = CODCLI ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  TOTCOM IS NOT NULL AND ';
      strSQL := strSQL + '  TOTCUS IS NOT NULL ';
      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  CODCLI ';
      If rdgTipABC.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
        strSQL := strSQL + '  , DEPART ';
      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  TOTCOM DESC ';

      With qryRelatorio Do
      Begin
        Close;
        cdsCliAbc.Close;

        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
        ParamByName('CLAFIS').AsString := VS_strClaVen;
        ParamByName('CLADEV').AsString := VS_strClaDev;

        If Not fEmptyStr(edtCodRepresentante.Text) Then
          pSetaParam(strCodRep, arrRepresen, strRepres, 'CODREP', qryRelatorio);

        If Not fEmptyStr(edtMarca.Text) Then
          pSetaParam(edtMarca.Text, arrMarca, strMarca, 'CODMAR', qryRelatorio);

        If Not fEmptyStr(edtCodVendedor.Text) Then
          pSetaParam(strCodVen, arrVendedor, strVendedor, 'CODVEN', qryRelatorio);

        If Not fEmptyStr(edtCodFor.Text) Then
          pSetaParam(edtCodFor.Text, arrFornec, strFornec, 'CODFOR', qryRelatorio);

        If Not fEmptyStr(mskLinhaGrupo.Text) Then
          pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLinhaGrupo,'CODGRU',qryRelatorio);

        If Not fEmptyStr(edtCodPro.Text) Then
          pSetaParam(edtCodPro.Text, arrProduto, strProduto, 'CODITE', qryRelatorio);

        If Not fEmptyStr(edtCodCli.Text) Then
          pSetaParam(edtCodCli.Text, arrClientes, strClientes, 'CODCLI', qryRelatorio);

        If Not fEmptyStr(edtCodRede.Text) Then
          pSetaParamOR(edtCodRede,arrRede,'CODRED',qryRelatorio);

        If Not fEmptyStr(edtCodReg.Text) Then
          pSetaParam(edtCodReg.Text, arrRegiao, strRegiao, 'CODREG', qryRelatorio);

        If Not fEmptyStr(edtCodAti.Text) Then
          pSetaParam(edtCodAti.Text, arrAtividade, strAtividade,'CODATI',qryRelatorio);

        If (Not fEmptyStr(edtCodEmpresa.Text)) Then
          pSetaParam(edtCodEmpresa.Text, arrEmp, strEmp, 'CODEMP', qryRelatorio);

        If (Not fEmptyStr(edtDepIte.Text)) Then
          pSetaParam(edtDepIte.Text, arrDepart, strDepart, 'DEPITE', qryRelatorio);

        If (Not fEmptyStr(edtCodDep.Text)) Then
          pSetaParam(edtCodDep.Text, arrLinDepart, strLinDepart, 'CODDEP', qryRelatorio);

        Open;
        cdsCliAbc.Open;
      End;

      fltSoma := fDoubleAggregate(cdsCliAbc, 'TOT_TOTCOM');
    Except
      On E:Exception Do
        pMensagensErro(E.Message, 'btnImprimirClick');
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin

      cdsABC := TUniClientDataSet.Create(Nil);
      Try
        cdsABC.FieldDefs.Add('CODCLI', ftString, 8);
        cdsABC.FieldDefs.Add('NOMCLI', ftString, 60);
        cdsABC.FieldDefs.Add('C_G_C_', ftString, 20);
        If rdgTipAbc.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
          cdsABC.FieldDefs.Add('DEPART', ftString, 40);
        cdsABC.FieldDefs.Add('VALDUP', ftFloat);
        cdsABC.FieldDefs.Add('VALCHQ', ftFloat);
        cdsABC.FieldDefs.Add('TOTCOM', ftFloat);
        cdsABC.FieldDefs.Add('TOTCUS', ftFloat);
        cdsABC.FieldDefs.Add('TOTCOM_CLI', ftFloat);
        cdsABC.FieldDefs.Add('TOTCUS_CLI', ftFloat);

        cdsABC.FieldDefs.Add('MARGEM_CLI', ftFloat);
        cdsABC.FieldDefs.Add('PERREP_CLI', ftFloat);
        cdsABC.FieldDefs.Add('PERACU_CLI', ftFloat);

        cdsABC.FieldDefs.Add('MARGEM_DEP', ftFloat);
        cdsABC.FieldDefs.Add('PERREP_DEP', ftFloat);
        cdsABC.FieldDefs.Add('PERACU_DEP', ftFloat);

        cdsABC.CreateDataSet;
        cdsABC.Open;

        qryRelatorio.First;
        While Not qryRelatorio.Eof Do
        Begin
          cdsABC.Filter := 'CODCLI = '+ QuotedStr(qryRelatorio.FieldByName('CODCLI').AsString);
          cdsABC.Filtered := True;
          fltTotComCli := 0;
          fltTotCusCli := 0;
          cdsABC.First;
          While Not cdsABC.Eof Do
          Begin
            fltTotComCli := cdsABC.FieldByName('TOTCOM_CLI').AsFloat + qryRelatorio.FieldByName('TOTCOM').AsFloat;
            fltTotCusCli := cdsABC.FieldByName('TOTCUS_CLI').AsFloat + qryRelatorio.FieldByName('TOTCUS').AsFloat;

            cdsABC.Edit;
            cdsABC.FieldByName('TOTCOM_CLI').AsFloat := fltTotComCli;
            cdsABC.FieldByName('TOTCUS_CLI').AsFloat := fltTotCusCli;
            cdsABC.Post;

            cdsABC.Next;
          End;

          // Se é o primeiro cliente atribui o valor atual
          If fltTotComCli = 0 Then
          Begin
            fltTotComCli := qryRelatorio.FieldByName('TOTCOM').AsFloat;
            fltTotCusCli := qryRelatorio.FieldByName('TOTCUS').AsFloat;
          End;

          cdsABC.Filtered := False;
          cdsABC.Filter := '';

          cdsABC.Append;
          cdsABC.FieldByName('CODCLI').AsString := qryRelatorio.FieldByName('CODCLI').AsString;
          cdsABC.FieldByName('NOMCLI').AsString := qryRelatorio.FieldByName('NOMCLI').AsString;
          cdsABC.FieldByName('C_G_C_').AsString := qryRelatorio.FieldByName('C_G_C_').AsString;
          If rdgTipAbc.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
            cdsABC.FieldByName('DEPART').AsString := qryRelatorio.FieldByName('DEPART').AsString;
          cdsABC.FieldByName('VALDUP').AsFloat  := qryRelatorio.FieldByName('VALDUP').AsFloat;
          cdsABC.FieldByName('VALCHQ').AsFloat  := qryRelatorio.FieldByName('VALCHQ').AsFloat;
          cdsABC.FieldByName('TOTCOM').AsFloat  := qryRelatorio.FieldByName('TOTCOM').AsFloat;
          cdsABC.FieldByName('TOTCUS').AsFloat  := qryRelatorio.FieldByName('TOTCUS').AsFloat;
          cdsABC.FieldByName('TOTCOM_CLI').AsFloat  := fltTotComCli;
          cdsABC.FieldByName('TOTCUS_CLI').AsFloat  := fltTotCusCli;
          cdsABC.Post;

          qryRelatorio.Next;
        End;

        cdsABC.AddIndex('IDX_TOTCOM_CLI', 'TOTCOM_CLI;CODCLI;TOTCOM', [ixDescending]);
        cdsABC.IndexName := 'IDX_TOTCOM_CLI';

        // Calcula margem perrep e peracu
        strCli := '';
        fltAcuComGeral := 0;

        cdsABC.First;
        While Not cdsABC.Eof Do
        Begin
          If strCli <> cdsABC.FieldByName('CODCLI').AsString Then
          Begin
            strCli := cdsABC.FieldByName('CODCLI').AsString;
            fltAcuComGeral := fltAcuComGeral + cdsABC.FieldByName('TOTCOM_CLI').AsFloat;
            fltAcuComDep := 0;
          End
          // Se houver mais de um departamento por cliente zera o valdup e valchq para não duplicar
          Else
          Begin
            cdsABC.Edit;
            cdsABC.FieldByName('VALDUP').AsFloat := 0;
            cdsABC.FieldByName('VALCHQ').AsFloat := 0;
            cdsABC.Post;
          End;

          fltAcuComDep   := fltAcuComDep   + cdsABC.FieldByName('TOTCOM').AsFloat;

          cdsABC.Edit;
          cdsABC.FieldByName('MARGEM_CLI').AsFloat := fCalculaPrecoVenda(2, cdsABC.FieldByName('TOTCUS_CLI').AsFloat, cdsABC.FieldByName('TOTCOM_CLI').AsFloat, 0, 0, 0, 0, 0);
          If fltSoma <> 0 Then
          Begin
            cdsABC.FieldByName('PERREP_CLI').AsFloat := cdsABC.FieldByName('TOTCOM_CLI').AsFloat / fltSoma * 100;
            cdsABC.FieldByName('PERACU_CLI').AsFloat := fltAcuComGeral / fltSoma * 100;
          End;

          If rdgTipAbc.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
          Begin
            cdsABC.FieldByName('MARGEM_DEP').AsFloat := fCalculaPrecoVenda(2, cdsABC.FieldByName('TOTCUS').AsFloat, cdsABC.FieldByName('TOTCOM').AsFloat, 0, 0, 0, 0, 0);
            If cdsABC.FieldByName('TOTCOM_CLI').AsFloat <> 0 Then
            Begin
              cdsABC.FieldByName('PERREP_DEP').AsFloat := cdsABC.FieldByName('TOTCOM').AsFloat / cdsABC.FieldByName('TOTCOM_CLI').AsFloat * 100;
              cdsABC.FieldByName('PERACU_DEP').AsFloat := fltAcuComDep / cdsABC.FieldByName('TOTCOM_CLI').AsFloat * 100;
            End;
          End;

          cdsABC.Post;

          cdsABC.Next;
        End;
        {**************************************}
        {* SE UTILIZAR MARGEM PEDE SENHA      *}
        {***********************************LU*}
        If edtMargem.Text = 'S' Then
        Begin
          If Not fEmptyStr(fCfgSis('SENMLC')) Then
          Begin
            ffrmSenha(strSenha,'Margem');
            If strSenha <> fCfgSis('SENMLC') Then
              edtMargem.Text := 'N';
          End;
        End;

        If (edtDestino.Text = 'E') Then
        Begin
          pGeraExcelAbcClientes;
          btnImprimir.Enabled := True;
          pnlInfo.Caption := '';
        End
        Else
        Begin
          Try
            pCriarFormularios(TfrmQckEstatAbcClientes,frmQckEstatAbcClientes);

            frmQckEstatAbcClientes.dtsRelatorio.DataSet := cdsABC;

            frmQckEstatAbcClientes.intLimite := StrToIntDef(edtQtdCli.Text, 0);

            If strTipImp = 'M' Then
            Begin
              frmQckEstatAbcClientes.qckPagina.DefaultFilter := rldFiltro;
              frmQckEstatAbcClientes.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
            End
            Else
            Begin
              frmQckEstatAbcClientes.qckPagina.DefaultFilter := Nil;
              frmQckEstatAbcClientes.strOrdem := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' À ' + mskDtaFin.Text;
            End;

            frmQckEstatAbcClientes.rllEmpresa.Caption          := fStrTitulo(edtCodEmpresa, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA ' + IfThen(rdgEmpresa.ItemIndex = 0, '(FATURAMENTO)', '(ORIGEM)'));
            frmQckEstatAbcClientes.rllRepresentante.Caption    := fStrTitulo(strCodRep, edtDesRepresentante, arrRepresen, strRepres, 'REPRESENTANTE');
            frmQckEstatAbcClientes.rllMarca.Caption            := fStrTitulo(edtMarca, edtDesMarca, arrMarca, strMarca, 'MARCA');
            frmQckEstatAbcClientes.rllVendedor.Caption         := fStrTitulo(strCodVen, edtDesVendedor, arrVendedor, strVendedor, 'VENDEDOR');
            frmQckEstatAbcClientes.rllFornecedor.Caption       := fStrTitulo(edtCodFor, edtDesFor, arrFornec, strFornec, 'FORNECEDOR');
            frmQckEstatAbcClientes.rllProduto.Caption          := fStrTitulo(edtCodPro, edtDesPro, arrProduto, strProduto, 'PRODUTO');
            frmQckEstatAbcClientes.rllCliente.Caption          := fStrTitulo(edtCodCli, edtDesCli, arrClientes, strClientes, 'CLIENTE');
            frmQckEstatAbcClientes.rllAtividade.Caption        := fStrTitulo(edtCodAti, edtAtividade, arrAtividade, strAtividade, 'ATIVIDADE');
            frmQckEstatAbcClientes.rllRedeLoja.Caption         := fStrTitulo(edtCodRede, edtDesRede, arrRede, strRede, 'REDE DE LOJAS');
            frmQckEstatAbcClientes.rllRegiao.Caption           := fStrTitulo(edtCodReg, edtDesReg, arrRegiao, strRegiao, IfThen(strTipImp = 'M', 'REGIAO', 'REGIÃO'));
            frmQckEstatAbcClientes.rllDepartamentoItem.Caption := fStrTitulo(edtDepIte, edtDesDepIte, arrDepart, strDepart, 'DEPARTAMENTO DO ITEM');
            frmQckEstatAbcClientes.rllDepartamentoVen.Caption  := fStrTitulo(edtCodDep, edtDesDep, arrLinDepart, strLinDepart, 'DEPARTAMENTO DO VENDEDOR');
            frmQckEstatAbcClientes.rllLinhaGrupo.Caption       := fStrTitulo(mskLinhaGrupo.Text, edtDesGrupo, arrLinhaGrupo, strLinhaGrupo, 'LINHA/GRUPO');

            If edtTipo.Text = 'F' Then
              frmQckEstatAbcClientes.rllTipoPessoa.Caption := 'TIPO DE PESSOA: ' + IfThen(strTipImp = 'M', 'FISICA', 'FÍSICA')
            Else If edtTipo.Text = 'J' Then
              frmQckEstatAbcClientes.rllTipoPessoa.Caption := 'TIPO DE PESSOA: ' + IfThen(strTipImp = 'M', 'JURIDICA', 'JURÍDICA')
            Else
              frmQckEstatAbcClientes.rllTipoPessoa.Caption := 'TIPO DE PESSOA: TODOS';

            frmQckEstatAbcClientes.rllNomeRelatorio.Caption := 'RELATORIO DE CURVA ABC DE CLIENTES - ' + IfThen(rdgTipABC.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO, 'ABC POR CLIENTE / DEP. PRODUTO ', 'ABC POR CLIENTE') + ' -  QTD. CLIENTES: ' + edtQtdCli.Text;

            If edtMargem.Text = 'N' Then
            Begin
              frmQckEstatAbcClientes.rllDesMargem.Visible := False;
              frmQckEstatAbcClientes.rllMargem.Visible    := False;
              frmQckEstatAbcClientes.rllTotMar.Visible    := False;
              frmQckEstatAbcClientes.rllMarCli.Visible    := False;
              frmQckEstatAbcClientes.rllMarDep.Visible    := False;
            End;

            If (chkExibirCpfCnpj.Checked) Then
            Begin
              frmQckEstatAbcClientes.rllCpfCnpj.Visible := True;
              frmQckEstatAbcClientes.rllCgcCpf.Visible  := True;
              frmQckEstatAbcClientes.rdbNomCli.Width    := 206;
            End
            Else
            Begin
              frmQckEstatAbcClientes.rllCpfCnpj.Visible := False;
              frmQckEstatAbcClientes.rllCgcCpf.Visible  := False;
              frmQckEstatAbcClientes.rdbNomCli.Width    := 291;
            End;

            If rdgTipAbc.ItemIndex = TIPABC_CLIENTE Then
            Begin
              frmQckEstatAbcClientes.rlbGrupo.Visible := False;
              frmQckEstatAbcClientes.rlbDetalhe.Visible := True;
            End
            Else
            Begin
              frmQckEstatAbcClientes.rlbGrupo.Visible := True;
              frmQckEstatAbcClientes.rlbDetalhe.Visible := False;
            End;

            frxRelatorio.DataSet := cdsABC;

            If edtDestino.Text = 'V' Then
              pPreviewReport(Self.Name, Self.Caption, frmQckEstatAbcClientes.qckPagina, frmQckEstatAbcClientes.rpsSetup)
            Else
              pPrintReport(Self.Name, Self.Caption, strNomImp, frmQckEstatAbcClientes.qckPagina);

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
            End;
          End;
          pFreeAndNil(frmQckEstatAbcClientes);
        End;
      Finally
        cdsABC.Free;
      End;
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

  FreeAndNil(dspCliAbc);
  FreeAndNil(cdsCliAbc);
end;

procedure TfrmRelEstatAbcClientes.pGeraExcelAbcClientes;
  Var
    objExcel: TExcel;

    fltTotCtr: Double;
    fltTotChq: Double;
    fltTotCom: Double;
    fltTotCus: Double;
    fltAcuRep: Double;
    strUltLet: String;
    strCodCli: String;
    blnZebra : Boolean;
begin

  fltTotCtr := 0.0;
  fltTotChq := 0.0;
  fltTotCom := 0.0;
  fltTotCus := 0.0;
  fltAcuRep := 0.0;

  If chkExibirCpfCnpj.Checked Then
    strUltLet := 'J'
  Else
    strUltLet := 'I';

  {*******************************************}
  {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA  *}
  {* A APLICAÇÃO INVISÍVEL                   *}
  {****************************************MV*}
  objExcel := TExcel.fCriarExcel(Self);

  {*******************************************}
  {* ADICIONA UMA PASTA DE TRABALHO          *}
  {****************************************MV*}
  If Not objExcel.CriarArquivo Then
  Begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin
    LinhaAtual := 01;
    {********************************}
    {* EMPRESA PADRAO DO SISTEMA    *}
    {*****************************MV*}
    Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

    {*******************************************}
    {* TITULO DO RELATORIO                     *}
    {****************************************MV*}
    Escrever(ProximaLinha, 01, 'RELATÓRIO DE CURVA ABC DE CLIENTES - QTD. CLIENTES: ' + edtQtdCli.Text);

    ProximaLinha;

    Escrever(ProximaLinha, 01, fStrTitulo(strCodVen, edtDesVendedor, arrVendedor, strVendedor, 'VENDEDOR'));
    Escrever(ProximaLinha, 01, fStrTitulo(strCodRep, edtDesRepresentante, arrRepresen, strRepres, 'REPRESENTANTE'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodFor, edtDesFor, arrFornec, strFornec, 'FORNECEDOR'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodPro, edtDesPro, arrProduto, strProduto, 'PRODUTO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodCli, edtDesCli, arrClientes, strClientes, 'CLIENTE'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodRede, edtDesRede, arrRede, strRede, 'REDE DE LOJAS'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodReg, edtDesReg, arrRegiao, strRegiao, 'REGIÃO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodAti, edtAtividade, arrAtividade, strAtividade, 'ATIVIDADE'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodEmpresa, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA ' + IfThen(rdgEmpresa.ItemIndex = 0, '(FATURAMENTO)', '(ORIGEM)')));
    Escrever(ProximaLinha, 01, fStrTitulo(edtMarca, edtDesMarca, arrMarca, strMarca, 'MARCA'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtDepIte, edtDesDepIte, arrDepart, strDepart, 'DEPARTAMENTO DO ITEM'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodDep, edtDesDep, arrLinDepart, strLinDepart, 'DEPARTAMENTO DO VENDEDOR'));
    Escrever(ProximaLinha, 01, fStrTitulo(mskLinhaGrupo.Text, edtDesGrupo, arrLinhaGrupo, strLinhaGrupo, 'LINHA/GRUPO'));
    Escrever(ProximaLinha, 01, 'REFERÊNTE AO PERÍODO DE ' + mskDtaIni.Text + ' À ' + mskDtaFin.Text);

    {********************************}
    {* COLOCA EM NEGRITO E ALINHA   *}
    {* AO CENTRO DA CELULA          *}
    {*****************************MV*}
    Mesclar('A1', strUltLet + '1');
    Mesclar('A2', strUltLet + '2');
    Mesclar('A3', strUltLet + '3');
    Alinhamento('A1', strUltLet + '3', Centro);
    Negrito('A1', strUltLet + '3', True);

    Mesclar('A4',strUltLet + '4');
    Mesclar('A5',strUltLet + '5');
    Mesclar('A6',strUltLet + '6');
    Mesclar('A7',strUltLet + '7');
    Mesclar('A8',strUltLet + '8');
    Mesclar('A9',strUltLet + '9');
    Mesclar('A10',strUltLet + '10');
    Mesclar('A11',strUltLet + '11');
    Mesclar('A12',strUltLet + '12');
    Mesclar('A13',strUltLet + '13');
    Mesclar('A14',strUltLet + '14');
    Mesclar('A15',strUltLet + '15');
    Mesclar('A16',strUltLet + '16');
    Mesclar('A17',strUltLet + '17');
    Alinhamento('A4',strUltLet + '17', Centro);
    Negrito('A4',strUltLet + '17', True);

    ProximaLinha;

    {*******************************************}
    {* COLUNAS                                 *}
    {****************************************MV*}
    Escrever(LinhaAtual, 01, 'CÓDIGO');
    Escrever(LinhaAtual, 02, 'NOME DO CLIENTE');
    Escrever(LinhaAtual, 03, 'CTR ABERTO');
    Escrever(LinhaAtual, 04, 'CHEQUE');
    Escrever(LinhaAtual, 05, 'TOTAL COMPRA');
    Escrever(LinhaAtual, 06, 'TOTAL CUSTO');
    If edtMargem.Text = 'S' Then
      Escrever(LinhaAtual, 07, 'MARGEM')
    Else
      Escrever(LinhaAtual, 07, ' ');
    Escrever(LinhaAtual, 08, '% REP.');
    Escrever(LinhaAtual, 09, '% ACUM.');
    If chkExibirCpfCnpj.Checked Then
      Escrever(LinhaAtual, 10, 'CNPJ/CPF');

    {*******************************************}
    {* COLOCA NEGRITO NAS COLUNAS              *}
    {****************************************MV*}
    Negrito('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), True);

    {*************************************}
    {* COLORI O FUNDO DA CELULA P/ CINZA *}
    {**********************************MV*}
    CorFundo('A2', strUltLet + '3', Cinza);
    CorFundo('A18', strUltLet + '18', Cinza);

    {********************************}
    {* INSERE BORDAS NA CELULA      *}
    {*****************************MV*}
    Bordas('A2', strUltLet + '3');
    Bordas('A5', strUltLet + '18');

    With cdsABC Do
    Begin
      First;
      ProximaLinha;

      strCodCli := '';
      blnZebra := False;
      While (Not Eof) Do
      Begin
        If rdgTipAbc.ItemIndex = TIPABC_CLIENTE_DEP_PRODUTO Then
        Begin
          If strCodCli <> FieldByName('CODCLI').AsString Then
          Begin
            blnZebra := Not blnZebra;
            strCodCli := FieldByName('CODCLI').AsString;

            Escrever(LinhaAtual, 01, fStrZero(FieldByName('CODCLI').AsString, 8));
            Escrever(LinhaAtual, 02, FieldByName('NOMCLI').AsString);
            Escrever(LinhaAtual, 03, FloatToStrF(FieldByName('VALDUP').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 04, FloatToStrF(FieldByName('VALCHQ').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 05, FloatToStrF(FieldByName('TOTCOM_CLI').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 06, FloatToStrF(FieldByName('TOTCUS_CLI').AsFloat, ffFixed, 12, 2));
            If edtMargem.Text = 'S' Then
              Escrever(LinhaAtual, 07, FloatToStrF(FieldByName('MARGEM_CLI').AsFloat, ffFixed, 12, 2))
            Else
              Escrever(LinhaAtual, 07, ' ');
            Escrever(LinhaAtual, 08, FloatToStrF(FieldByName('PERREP_CLI').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 09, FloatToStrF(FieldByName('PERACU_CLI').AsFloat, ffFixed, 12, 2));

            If chkExibirCpfCnpj.Checked Then
            Begin
              Escrever(LinhaAtual, 10, fFormataCpfCgc(FieldByName('C_G_C_').AsString, fSetaPais)) ;
              Negrito('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), True);
              Alinhamento('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), Direita);
            End
            Else
            Begin
              Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);
              Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Direita);
            End;

            If blnZebra Then
            Begin
              If chkExibirCpfCnpj.Checked Then
                CorFundo( 'A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), Cinza)
              Else
                CorFundo( 'A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Cinza);
            End;
            ProximaLinha;

          End;

          Escrever(LinhaAtual, 01, 'DEP');
          Escrever(LinhaAtual, 02, FieldByName('DEPART').AsString);
          Escrever(LinhaAtual, 03, '');
          Escrever(LinhaAtual, 04, '');
          Escrever(LinhaAtual, 05, FloatToStrF(FieldByName('TOTCOM').AsFloat, ffFixed, 12, 2));
          Escrever(LinhaAtual, 06, FloatToStrF(FieldByName('TOTCUS').AsFloat, ffFixed, 12, 2));
          If edtMargem.Text = 'S' Then
            Escrever(LinhaAtual, 07, FloatToStrF(FieldByName('MARGEM_DEP').AsFloat, ffFixed, 12, 2))
          Else
            Escrever(LinhaAtual, 07, ' ');
          Escrever(LinhaAtual, 08, FloatToStrF(FieldByName('PERREP_DEP').AsFloat, ffFixed, 12, 2));
          Escrever(LinhaAtual, 09, FloatToStrF(FieldByName('PERACU_DEP').AsFloat, ffFixed, 12, 2));

          If blnZebra Then
          Begin
            If chkExibirCpfCnpj.Checked Then
              CorFundo( 'A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), Cinza)
            Else
              CorFundo( 'A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Cinza);
          End;
        End
        Else
        Begin
          Escrever(LinhaAtual, 01, fStrZero(FieldByName('CODCLI').AsString, 8));
          Escrever(LinhaAtual, 02, FieldByName('NOMCLI').AsString);
          Escrever(LinhaAtual, 03, FloatToStrF(FieldByName('VALDUP').AsFloat, ffFixed, 12, 2));
          Escrever(LinhaAtual, 04, FloatToStrF(FieldByName('VALCHQ').AsFloat, ffFixed, 12, 2));
          Escrever(LinhaAtual, 05, FloatToStrF(FieldByName('TOTCOM').AsFloat, ffFixed, 12, 2));
          Escrever(LinhaAtual, 06, FloatToStrF(FieldByName('TOTCUS').AsFloat, ffFixed, 12, 2));
          If edtMargem.Text = 'S' Then
            Escrever(LinhaAtual, 07, FloatToStrF(fCalculaPrecoVenda(2, FieldByName('TOTCUS').AsFloat,
                                                 FieldByName('TOTCOM').AsFloat, 0, 0, 0, 0, 0), ffFixed, 12, 2));
          Escrever(LinhaAtual, 08, FloatToStrF((FieldByName('TOTCOM').AsFloat / fltSoma) * 100, ffFixed, 12, 2));

          fltAcuRep := fltAcuRep + ((FieldByName('TOTCOM').AsFloat / fltSoma) * 100);
          Escrever(LinhaAtual, 09, FloatToStrF(fltAcuRep, ffFixed, 12, 2));

          If chkExibirCpfCnpj.Checked Then
            Escrever(LinhaAtual, 10, fFormataCpfCgc(FieldByName('C_G_C_').AsString, fSetaPais)) ;

        End;
        Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Alinhamento('C' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        fltTotCtr := fltTotCtr + FieldByName('VALDUP').AsFloat;
        fltTotChq := fltTotChq + FieldByName('VALCHQ').AsFloat;
        fltTotCom := fltTotCom + FieldByName('TOTCOM').AsFloat;
        fltTotCus := fltTotCus + FieldByName('TOTCUS').AsFloat;

        ProximaLinha;

        Next;
      End;

      Escrever(LinhaAtual, 02, 'TOTAL:');
      Escrever(LinhaAtual, 03, FloatToStrF(fltTotCtr, ffFixed, 12, 2));
      Escrever(LinhaAtual, 04, FloatToStrF(fltTotChq, ffFixed, 12, 2));
      Escrever(LinhaAtual, 05, FloatToStrF(fltTotCom, ffFixed, 12, 2));
      Escrever(LinhaAtual, 06, FloatToStrF(fltTotCus, ffFixed, 12, 2));
      If edtMargem.Text = 'S' Then
        Escrever(LinhaAtual, 07, FloatToStrF(fCalculaPrecoVenda(2, fltTotCus, fltTotCom, 0, 0, 0, 0, 0), ffFixed, 12, 2))
      Else
        Escrever(LinhaAtual, 07, ' ');

      Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
      Alinhamento('B' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

      Negrito(LinhaAtual, 02, True);

    End;

    CongelarPaines('A19');
    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

    fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
  End;

  FreeAndNil(objExcel);

end;

procedure TfrmRelEstatAbcClientes.pVerdeVermelho(edtCodigo: TEditFocus;
  shaVen: TShape; blnLiberado: Boolean);
begin
  If (Not blnLiberado) Then
  Begin
    edtCodigo.MaxLength    := 10;
    edtCodigo.TamCampo     := 10;
    edtCodigo.CompZeros    := False;
    edtCodigo.PasswordChar := '*';
    edtCodigo.TipoTexto    := EditFocus.TControlTipoTexto(ttAlfanumerico);
    shaVen.Brush.Color     := clRed;
  End
  Else
    shaVen.Brush.Color     := clGreen;
end;

procedure TfrmRelEstatAbcClientes.edtDepIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtDepIte, edtDesDepIte, arrDepart, fRetDescDepartamento, Nil, 'do Departamento');
end;

procedure TfrmRelEstatAbcClientes.edtDepIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************RV*}
  If fPesqDepartamento(Self, edtDepIte, edtDesDepIte, Nil, Key, arrDepart, False) Then
  Begin
    If fValidaCampos(edtDepIte, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcClientes.edtDestinoExit(Sender: TObject);
begin
  If fEmptyStr(edtDestino.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
    pSetFocus(edtDestino);
  End
  Else If (Copy(edtDestino.Text, 1, 1) <> 'V') And
          (COpy(edtDestino.Text, 1, 1) <> 'I') And
          (Copy(edtDestino.Text, 1, 1) <> 'E') Then
  Begin
    pSetFocus(edtDestino);
  End;
end;

procedure TfrmRelEstatAbcClientes.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelEstatAbcClientes.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    fvalidaCampos(edtMarca,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcClientes.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelEstatAbcClientes.edtCodEmpresaKeyPress(Sender: TObject;
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

procedure TfrmRelEstatAbcClientes.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtDesFor,arrFornec,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelEstatAbcClientes.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstatAbcClientes.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro,edtDesPro,arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmRelEstatAbcClientes.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenPro: TUniQuery;
begin
  inherited;
  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    Key := #0;
    Exit;
  End;
  
  qryGenPro := fCriaQuery;

  If fPesqItem(conIteSimples, Self, edtCodPro, edtDesPro, qryGenPro, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    If fValidaCampos(edtCodPro, True) Then
      SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryGenPro);

end;

procedure TfrmRelEstatAbcClientes.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrClientes, Nil, fRetNomCliente, 'do cliente');

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetFocus(edtCodAti);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmRelEstatAbcClientes.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstatAbcClientes.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrLinDepart, fRetDescDepartamento, Nil, 'do Departamento');
end;

procedure TfrmRelEstatAbcClientes.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************RV*}
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrLinDepart, False) Then
  Begin
    fValidaCampos(edtCodDep, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcClientes.edtTipoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtTipo.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O Tipo de Pessoa deve ser preenchido!', ['&Ok']);
    pSetFocus(edtTipo);
  End
  Else If (Copy(edtTipo.Text, 1, 1) <> 'T') And
          (COpy(edtTipo.Text, 1, 1) <> 'F') And
          (Copy(edtTipo.Text, 1, 1) <> 'J') Then
  Begin
    pSetFocus(edtTipo);
  End;
end;

End.


