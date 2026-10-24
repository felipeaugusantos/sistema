unit untRelFatComparatVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel,
  Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils, Uni, AppEvnts,
  ComboBoxFocus, DB, untExcel, BitBtnLockedIncrem, untGeraExcel, ComCtrls,
  cxHint, dxScreenTip, cxClasses, dxCustomHint, frxExportCSVTestabilidade;

type
  TfrmRelFatComparatVenda = class(TfrmPaiRelatorio)
    lstClaFis: TMemo;
    Label7: TLabel;
    chkPreCus: TCheckBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lblEmpresa: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    edtDocumento: TEditFocus;
    edtEspDoc: TEditFocus;
    cbxTabPre: TComboBoxFocus;
    rdgEmpresa: TRadioGroup;
    rdgOpcao: TRadioGroup;
    chkVendMenSug: TCheckBox;
    chkDiferenca: TCheckBox;
    pgbProgresso: TProgressBar;
    lbl15: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    HintControler: TcxHintStyleController;
    lbl16: TLabel;
    edtDesGruIni: TEditFocus;
    mskGruIni: TMaskEditFocus;
    lbl17: TLabel;
    edtDesGruFin: TEditFocus;
    mskGruFin: TMaskEditFocus;
    shpVen: TShape;
    gpbDif: TGroupBox;
    edtDifFin: TEditFocus;
    lblEDif: TLabel;
    edtDifIni: TEditFocus;
    lblTitDif: TLabel;
    rdgDif: TRadioGroup;
    Label11: TLabel;
    shpGer: TShape;
    Label12: TLabel;
    shpSubGer: TShape;
    edtCodGer: TEditFocus;
    edtDesGer: TEditFocus;
    edtCodSubGer: TEditFocus;
    edtDesSubGer: TEditFocus;
    chkExibeOpeLiberacao: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pAtualizaClaFis;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepExit(Sender: TObject);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure chkDiferencaClick(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtDifIniEnter(Sender: TObject);
    procedure edtDifIniExit(Sender: TObject);
    procedure mskGruIniKeyPress(Sender: TObject; var Key: Char);
    procedure mskGruFinKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodGerKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubGerKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubGerExit(Sender: TObject);
    procedure edtCodGerExit(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure rdgOpcaoClick(Sender: TObject);
  private
    { Private declarations }
    QryRelatorio: TUniQuery;
    arrCli      : TConsultasArray;
    arrRed      : TConsultasArray;
    arrGer      : TConsultasArray;
    arrSubGer   : TConsultasArray;
    arrEmp      : TConsultasArray;
    arrFor      : TConsultasArray;
    arrMar      : TConsultasArray;
    arrGruIni   : TConsultasArray;
    arrGruFin   : TConsultasArray;
    arrVen      : TConsultasArray;
    arrRep      : TConsultasArray;
    arrDep      : TConsultasArray;
    arrPro      : TConsultasArray;

    strGer      : String;
    strSubGer   : String;
    strVen      : String;
    strDep      : String;
    strPro      : String;
    strCli      : String;
    strRed      : String;
    strRep      : String;
    strFor      : String;
    strEmp      : String;
    strMar      : String;

    blnLibVen   : Boolean;
    blnLibGer   : Boolean;
    blnLibSub   : Boolean;

    strMsgConf : String;

    procedure pCarregaPrecos;
    Function fRetTabPre: String;
    Function fRetCampoPre: String;
    procedure pGeraExcelNovo(qryDados: TDataSet);
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pImprimeLiberacao(Excel: TExcel; Dados: TDataSet; Campos: TCampos; enmCorFundo: TCorExcel);
    function fGetCOM_FF: String;
    function fGetCOM_TR: String;
    function fGetCOM_DV: String;

    function fGetVrSuge : String;
    function fGetVrVend : String;

    function fGetSelect : String;
    function fGetFrom : String;
    function fGetWhere : String;
    function fGetOrderBy : String;

    procedure pSetaParametros(qryQuery: TUniQuery);

    procedure pVerdeVermelho(Edt: TEditFocus; Shp: TShape; bln: Boolean);

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelFatComparatVenda: TfrmRelFatComparatVenda;

implementation

uses untFuncoesFactory, untIFuncoes, untQckFatComparatVenda,
  untConstantes, Math, untClassPanelCx;

{$R *.dfm}

function TfrmRelFatComparatVenda.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin
      If (Not fEmptyStr(edtCodEmp.Text)) and (edtCodEmp.Text <> '000') Then
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {*******************************}
    {* VALIDA DATA INICIAL E FINAL *}
    {****************************JU*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('AVISO!', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('AVISO!', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('AVISO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDifIni) Then
    Begin
      If Sender.Visible Then
      Begin
        If fEmptyStr(edtDifIni.Text) Then
        Begin
          fMensagem('AVISO','Informe o valor inicial para "Exibir diferenças entre"!', ['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDifFin) Then
    Begin
      If Sender.Visible Then
      Begin
        If fEmptyStr(edtDifFin.Text) Then
        Begin
          fMensagem('AVISO','Informe o valor final para "Exibir diferenças entre"!', ['&O K']);
          Result := False;
        End
        Else If fStrToFloat(edtDifIni.Text) > fStrToFloat(edtDifIni.Text) Then
        Begin
          fMensagem('AVISO','O valor final deve ser maior ou igual ao valor inicial para "Exibir diferenças entre"!', ['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskGruIni) Then
    Begin
      If fEmptyStr(mskGruIni.Text) Then
      begin
        pDesmarcaLista(mskGruIni, arrGruIni);
        edtDesGruIni.Text := 'TODOS';
      end
      Else
      Begin
        edtDesGruIni.Text := fRetNomeLinhaGrupo(mskGruIni.Text);
        If fEmptyStr(edtDesGruIni.Text) Then
        Begin
          fMensagem('AVISO', 'Linha/Grupo Inicial Inválido!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskGruFin) Then
    Begin
      If fEmptyStr(mskGruFin.Text) Then
      begin
        pDesmarcaLista(mskGruFin, arrGruFin);
        edtDesGruFin.Text := 'TODOS';
      end
      Else
      Begin
        edtDesGruFin.Text := fRetNomeLinhaGrupo(mskGruFin.Text);
        If fEmptyStr(edtDesGruFin.Text) Then
        Begin
          fMensagem('AVISO', 'Linha/Grupo Final Inválido!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodVen) Then
    Begin
      Result := fValidaGerSubVen(blnLibVen, 'V', edtCodVen, edtDesVen);
    End

    Else If (Sender = edtCodSubGer) Then
    Begin
      Result := fValidaGerSubVen(blnLibSub, 'S', edtCodSubGer, edtDesSubGer);
    End

    Else If (Sender = edtCodGer) Then
    Begin
      Result := fValidaGerSubVen(blnLibGer, 'G', edtCodGer, edtDesGer);
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelFatComparatVenda.mskGruFinKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskGruFin, edtDesGruFin, nil, Key, arrGruFin) Then
  Begin
    If fValidaCampos(mskGruFin, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComparatVenda.mskGruIniKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskGruIni, edtDesGruIni, nil, Key, arrGruIni) Then
  Begin
    If fValidaCampos(mskGruIni, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComparatVenda.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin
  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;
End;

procedure TfrmRelFatComparatVenda.FormShow(Sender: TObject);
begin
  blnLibGer := fVerificaAcessoSistema('RCPMSG', strLoginUsuarioLogado);
  blnlibSub := fVerificaAcessoSistema('RCPMSS', strLoginUsuarioLogado);
  blnLibVen := fVerificaAcessoSistema('RCPMSV', strLoginUsuarioLogado);

  pVerdeVermelho(edtCodGer, shpGer, blnLibGer);
  pVerdeVermelho(edtCodSubGer, shpSubGer, blnlibSub);
  pVerdeVermelho(edtCodVen, shpVen, blnLibVen);

  shpMultSel.Visible := True;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

  inherited;
end;

procedure TfrmRelFatComparatVenda.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  inherited;
  if Assigned(QryRelatorio) then
    FreeAndNil(QryRelatorio);
end;

procedure TfrmRelFatComparatVenda.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  QryRelatorio         := fCriaQuery;
  frxRelatorio.DataSet := QryRelatorio;

  edtDocumento.MaxLength := fTamDocCadRec();
  edtDocumento.TamCampo  := edtDocumento.MaxLength;

  pAtualizaClaFis;

  rdgOpcao.Items.Clear;
  rdgOpcao.Items.Add('Analítico');
  rdgOpcao.Items.Add('Sintético por Documento');
  rdgOpcao.Items.Add('Sintético por Vendedor');

  If fCfgSis('USAFPG',varBoolean) Or
     fCfgSis('USACND',varBoolean) Then
  Begin
    rdgOpcao.Items.Add('Sintético por Condição/Forma de Pagto e Documento');
  End;

  rdgOpcao.ItemIndex := 0;

  pCarregaPrecos;
end;

procedure TfrmRelFatComparatVenda.edtCodVenExit(Sender: TObject);
begin
  inherited;

  If (blnLibVen) Then
    pEdtCodSelectExit(edtCodVen, edtDesVen, arrVen, fRetNomVendRep, nil, 'do Vendedor');
  fValidaCampos(edtCodVen, True);

end;

procedure TfrmRelFatComparatVenda.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnLibVen) And
     (fPesqOperador(Self, edtCodVen, edtDesVen, nil, Key, arrVen, False)) Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatComparatVenda.chkDiferencaClick(Sender: TObject);
begin
  inherited;
  gpbDif.Visible := chkDiferenca.Checked;
end;

procedure TfrmRelFatComparatVenda.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCli, Nil, fRetNomCliente, 'do Cliente');

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtCodRed.Enabled := False;
    edtCodRed.Clear;
    pEdtCodSelectExit(edtCodRed, edtDesRed, arrRed, Nil, fRetNomeRedeLoja, 'da Rede');
    pSetFocus(edtCodFor);
  End
  Else
  Begin
    edtCodRed.Enabled := True;
    pSetFocus(edtCodRed);
  End;

end;

procedure TfrmRelFatComparatVenda.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComparatVenda.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrDep, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmRelFatComparatVenda.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, nil, Key, arrDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComparatVenda.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComparatVenda.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed, edtDesRed, arrRed, Nil, fRetNomeRedeLoja, 'de Rede');
end;

procedure TfrmRelFatComparatVenda.edtCodRedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRed, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComparatVenda.edtCodRepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRep, edtDesRep, arrRep, fRetNomVendRep, Nil, 'do Representante');
end;

procedure TfrmRelFatComparatVenda.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodRep, edtDesRep, Nil, Key, arrRep, False) Then
  Begin
    If fValidaCampos(edtCodRep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComparatVenda.edtCodSubGerExit(Sender: TObject);
begin
  inherited;

  If (blnLibSub) Then
    pEdtCodSelectExit(edtCodSubGer, edtDesSubGer, arrSubGer, fRetNomVendRep, Nil, 'do Sub-Gerente');
  fValidaCampos(edtCodSubGer, True);

end;

procedure TfrmRelFatComparatVenda.edtCodSubGerKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnLibSub) And
     (fPesqOperador(Self, edtCodSubGer, edtDesSubGer, nil, Key, arrSubGer, False, True, False, False, False, False, False, True)) Then
  Begin
    If fValidaCampos(edtCodSubGer, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComparatVenda.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp , edtDesEmp, arrEmp, fRetNomeEmpresa, nil, 'da Empresa');
end;

procedure TfrmRelFatComparatVenda.btnImprimirClick(Sender: TObject);
  Var
    strSQL   : String;
    strSQL2  : String;
    strSQLSub: String;
    strTmp   : String;
    str_FF,
    str_DV,    
    str_TR : String;
    strMsgDif : String;
begin
  strMsgConf := fGetMsgRelCnf;
  strMsgDif  := '';

  Case rdgOpcao.ItemIndex Of
    1,2,3: Begin
      If (chkDiferenca.Checked) Then
      Begin
        strMsgDif := '* A coluna %Dif é calculada sobre a soma dos itens que atendem o ';
        strMsgDif := strMsgDif + 'filtro (Exibir somente documentos com diferença) ';
        strMsgDif := strMsgDif + 'portanto pode ocorrer divergencia entre a coluna %Dif ';
        strMsgDif := strMsgDif + 'com o filtro aplicado.';
      End;
    End;
  End;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  If edtDestino.Text <> 'E' Then
    inherited
  Else
    blnImprime := fVerificaCampos;

  If blnImprime Then
  Begin

    strSQL := '';
    strSQL := strSQL + fGetSelect;
    strSQL := strSQL + fGetFrom;
    strSQL := strSQL + fGetWhere;

    str_FF := strSQL;
    str_TR := strSQL;
    str_DV := strSQL;

    If (fGetCOM_FF = '2') Then
    Begin
      str_FF := AnsiReplaceStr(str_FF, 'DET_DTAENT','DET_DTAFAT');
      str_FF := AnsiReplaceStr(str_FF, 'NOT IN ("FF")','IN ("FF")');

      strSQL := strSQL + ' UNION ALL ' + str_FF;
    End
    Else
      strSQL := AnsiReplaceStr(strSQL, 'NOT IN ("FF")','NOT IN ("")');

    If (fGetCOM_TR = '2') Then
    Begin
      str_TR := AnsiReplaceStr(str_TR, 'DET_DTAENT','DET_DTAFAT');
      str_TR := AnsiReplaceStr(str_TR, 'NOT IN ("TR")','IN ("TR")');

      strSQL := strSQL + ' UNION ALL ' + str_TR;
    End
    Else
      strSQL := AnsiReplaceStr(strSQL, 'NOT IN ("TR")','NOT IN ("")');

    If (fGetCOM_DV = '2') Then
    Begin
      str_DV := AnsiReplaceStr(str_DV, 'DET_DTAENT','DET_DTAFAT');
      str_DV := AnsiReplaceStr(str_DV, 'NOT IN ("DV")','IN ("DV")');

      strSQL := strSQL + ' UNION ALL ' + str_DV;
    End
    Else
      strSQL := AnsiReplaceStr(strSQL, 'NOT IN ("DV")','NOT IN ("")');

    strSQL := strSQL + fGetOrderBy;

    Case rdgOpcao.ItemIndex Of
      1: Begin
        strSQLSub := ' SELECT SQL_NO_CACHE ';
        strSQLSub := strSQLSub + '   AUTINC, ';
        strSQLSub := strSQLSub + '   CODEMP, ';
        strSQLSub := strSQLSub + '   SUM(TOTCUS) AS TOTCUS, ';
        strSQLSub := strSQLSub + '   SUM(VRSUGE) AS VRSUGE, ';
        strSQLSub := strSQLSub + '   SUM(VRVEND) AS VRVEND, ';
        strSQLSub := strSQLSub + '   SUM(DIFERE) AS DIFERE, ';
        strSQLSub := strSQLSub + '   ROUND( -1 * ((SUM(VRSUGE) - ';
        strSQLSub := strSQLSub + '                 SUM(VRVEND) ) / ';
        strSQLSub := strSQLSub + '                 SUM(VRSUGE) * 100), 2) AS PERDIF, ';
        If chkExibeOpeLiberacao.Checked Then
        Begin
          strSQLSub := strSQLSub + '   OPELIB, ';
          strSQLSub := strSQLSub + '   DTALIB, ';
          strSQLSub := strSQLSub + '   HORLIB, ';
          strSQLSub := strSQLSub + '   OBSLIB, ';
        End;
        strSQLSub := strSQLSub + '   CODCLI, ';
        strSQLSub := strSQLSub + '   NOMCLI, ';
        strSQLSub := strSQLSub + '   DTAENT, ';
        strSQLSub := strSQLSub + '   CODVEN, ';
        strSQLSub := strSQLSub + '   NOMVEN, ';
        strSQLSub := strSQLSub + '   NUMDOC, ';
        strSQLSub := strSQLSub + '   ESPDOC ';
        strSQLSub := strSQLSub + ' FROM ( ' + strSQL + ' ) AS TAB ';
        strSQLSub := strSQLSub + ' GROUP BY NUMDOC, CODCLI, NOMCLI, ';
        strSQLSub := strSQLSub + '          DTAENT, CODVEN, NOMVEN, ';
        strSQLSub := strSQLSub + '          ESPDOC ';
        strSQLSub := strSQLSub + ' ORDER BY DTAENT, ESPDOC, NUMDOC, AUTINC ';
        strSQL := strSQLSub;
      End;

      2: Begin
        strSQLSub := ' SELECT SQL_NO_CACHE ';
        strSQLSub := strSQLSub + '   SUM(TOTCUS) AS TOTCUS, ';
        strSQLSub := strSQLSub + '   SUM(VRSUGE) AS VRSUGE, ';
        strSQLSub := strSQLSub + '   SUM(VRVEND) AS VRVEND, ';
        strSQLSub := strSQLSub + '   SUM(DIFERE) AS DIFERE, ';
        strSQLSub := strSQLSub + '   ROUND( -1 * ((SUM(VRSUGE) - ';
        strSQLSub := strSQLSub + '                 SUM(VRVEND) ) / ';
        strSQLSub := strSQLSub + '                 SUM(VRSUGE) * 100), 2) AS PERDIF, ';
        strSQLSub := strSQLSub + '   CODVEN, ';
        strSQLSub := strSQLSub + '   NOMVEN ';
        strSQLSub := strSQLSub + ' FROM ( ' + strSQL + ' ) AS TAB ';
        strSQLSub := strSQLSub + ' GROUP BY CODVEN, NOMVEN ';
        strSQLSub := strSQLSub + ' ORDER BY CODVEN, NOMVEN ';
        strSQL := strSQLSub;
      End;

      3:
      Begin
        strSQLSub := ' SELECT SQL_NO_CACHE ';
        strSQLSub := strSQLSub + '   DTAENT, ';
        strSQLSub := strSQLSub + '   NUMDOC, ';
        strSQLSub := strSQLSub + '   ESPDOC, ';
        strSQLSub := strSQLSub + '   CODEMP, ';
        strSQLSub := strSQLSub + '   CODCLI, ';
        strSQLSub := strSQLSub + '   NOMCLI, ';
        strSQLSub := strSQLSub + '   CODVEN, ';
        strSQLSub := strSQLSub + '   NOMVEN, ';
        strSQLSub := strSQLSub + '   CONCAT("FORMA DE PAGAMENTO: ",DESFPG,"          CONDIÇÃO DE PAGAMENTO: ",DESCND) AS CNDFPG, ';
        strSQLSub := strSQLSub + '   SUM(TOTCUS) AS TOTCUS, ';
        strSQLSub := strSQLSub + '   SUM(VRSUGE) AS VRSUGE, ';
        strSQLSub := strSQLSub + '   SUM(VRVEND) AS VRVEND, ';
        strSQLSub := strSQLSub + '   SUM(DIFERE) AS DIFERE, ';
        strSQLSub := strSQLSub + '   ROUND( -1 * ((SUM(VRSUGE) - ';
        strSQLSub := strSQLSub + '                 SUM(VRVEND) ) / ';
        strSQLSub := strSQLSub + '                 SUM(VRSUGE) * 100), 2) AS PERDIF ';
        strSQLSub := strSQLSub + ' FROM ( ' + strSQL + ' ) AS TAB ';
        strSQLSub := strSQLSub + ' GROUP BY CODCND, DESCND, CODFPG, ';
        strSQLSub := strSQLSub + '          DESFPG, NUMDOC, ESPDOC  ';
        strSQLSub := strSQLSub + ' ORDER BY DESFPG, DESCND, DTAENT, ';
        strSQLSub := strSQLSub + '          NUMDOC, ESPDOC          ';
        strSQL := strSQLSub;
      End;
    End;

    With QryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      pSetaParametros(QryRelatorio);
      Open;
    End;

    If Not QryRelatorio.IsEmpty Then
    Begin

      If (edtDestino.Text = 'E') Then
        pGeraExcelNovo(QryRelatorio)
      Else
      Begin

        Try
          pCriarFormularios(TfrmQckFatComparatVenda,frmQckFatComparatVenda);

          Case rdgOpcao.ItemIndex of
          0:
            Begin
              If SameText(strTipImp, 'M') Then
                frmQckFatComparatVenda.rllNomeRelatorio.Caption  := 'RELATORIO DE COMPARATIVO DE VENDAS - ANALITICO'
              Else
                frmQckFatComparatVenda.rllNomeRelatorio.Caption  := 'RELATÓRIO DE COMPARATIVO DE VENDAS - ANALÍTICO';

              frmQckFatComparatVenda.rlbTitulo.Visible         := True;
              frmQckFatComparatVenda.rlbDetalhe.Visible        := True;
              frmQckFatComparatVenda.blnImpLiberacao           := chkExibeOpeLiberacao.Checked;
            End;
          1:
            Begin
              If SameText(strTipImp, 'M') Then
                frmQckFatComparatVenda.rllNomeRelatorio.Caption  := 'RELATORIO DE COMPARATIVO DE VENDAS - SINTETICO POR DOCUMENTO'
              Else
                frmQckFatComparatVenda.rllNomeRelatorio.Caption  := 'RELATÓRIO DE COMPARATIVO DE VENDAS - SINTÉTICO POR DOCUMENTO';

              frmQckFatComparatVenda.rlbTituloSint.Visible     := True;
              frmQckFatComparatVenda.rlbDetalheSint.Visible    := True;
              frmQckFatComparatVenda.blnImpLiberacao           := chkExibeOpeLiberacao.Checked;
            End;
          2:
            Begin
              If SameText(strTipImp, 'M') Then
                frmQckFatComparatVenda.rllNomeRelatorio.Caption  := 'RELATORIO DE COMPARATIVO DE VENDAS - SINTETICO POR VENDEDOR'
              Else
                frmQckFatComparatVenda.rllNomeRelatorio.Caption  := 'RELATÓRIO DE COMPARATIVO DE VENDAS - SINTÉTICO POR VENDEDOR';

              frmQckFatComparatVenda.rlbTituloSintVend.Visible := True;
              frmQckFatComparatVenda.rlbDetalheSintVend.Visible:= True;
            End;
          3:
            Begin
              If SameText(strTipImp, 'M') Then
                frmQckFatComparatVenda.rllNomeRelatorio.Caption  := 'RELATORIO DE COMPARATIVO DE VENDAS - SINTETICO POR CONDICAO/FORMA DE PAGAMENTO'
              Else
                frmQckFatComparatVenda.rllNomeRelatorio.Caption  := 'RELATÓRIO DE COMPARATIVO DE VENDAS - SINTÉTICO POR CONDIÇÃO/FORMA DE PAGAMENTO';

              frmQckFatComparatVenda.rlbTituloSint.Visible     := True;
              frmQckFatComparatVenda.rlbGrupo.Visible          := True;
            End;
          End;

          frmQckFatComparatVenda.rllPrecus1.Visible  := chkPreCus.Checked;
          frmQckFatComparatVenda.rllPrecus2.Visible  := chkPreCus.Checked;
          frmQckFatComparatVenda.rllPrecus3.Visible  := chkPreCus.Checked;
          frmQckFatComparatVenda.rdbPrecus1.Visible  := chkPreCus.Checked;
          frmQckFatComparatVenda.rdbPrecus2.Visible  := chkPreCus.Checked;
          frmQckFatComparatVenda.rdbPrecus3.Visible  := chkPreCus.Checked;
          frmQckFatComparatVenda.rdbPrecus4.Visible  := chkPreCus.Checked;
          frmQckFatComparatVenda.rdbPrecusTot.Visible := chkPreCus.Checked;
          frmQckFatComparatVenda.rdbPrecusGru.Visible := chkPreCus.Checked;

          If edtDocumento.Text <> '' Then
            frmQckFatComparatVenda.strOrdem := 'DOCUMENTO: ' + edtDocumento.Text + '  ';

          If edtEspDoc.Text <> '' Then
            frmQckFatComparatVenda.strOrdem := frmQckFatComparatVenda.strOrdem + 'ESPÉCIE: ' + edtEspDoc.Text;

          if cbxTabPre.ItemIndex > 0 then
            frmQckFatComparatVenda.rllTabela.Caption := 'TABELA DE PREÇO: ' + cbxTabPre.Text;

          {*********************************************}
          {* TITULOS DO RELATORIO                      *}
          {* SUBSTITUIDO OS IFS PELA FUNCAO FSTRTITULO *}
          {******************************************RL*}

          frmQckFatComparatVenda.rllVendedor.Caption        := fStrTitulo(edtCodVen, edtDesVen, arrVen, strVen, 'VENDEDOR');
          frmQckFatComparatVenda.rllGerente.Caption         := fStrTitulo(edtCodGer, edtDesGer, arrGer, strGer, 'GERENTE');
          frmQckFatComparatVenda.rllSubGer.Caption          := fStrTitulo(edtCodSubGer, edtDesSubGer, arrSubGer, strSubGer, 'SUB-GERENTE');
          frmQckFatComparatVenda.rllRepresentante.Caption   := fStrTitulo(edtCodRep.Text, edtDesRep, arrRep, strRep, 'REPRESENTANTE');
          frmQckFatComparatVenda.rllDepartamento.Caption    := fStrTitulo(edtCodDep.Text, edtDesDep, arrDep, strDep, 'DEPARTAMENTO');
          frmQckFatComparatVenda.rllCliente.Caption         := fStrTitulo(edtCodCli.Text, edtDesCli, arrCli, strCli, 'CLIENTE');
          frmQckFatComparatVenda.rllRedeLoja.Caption        := fStrTitulo(edtCodRed.Text, edtDesRed, arrRed, strRed, 'REDE');
          frmQckFatComparatVenda.rllFornecedor.Caption      := fStrTitulo(edtCodFor.Text, edtDesFor, arrFor, strFor, 'FORNECEDOR');
          frmQckFatComparatVenda.rllMarca.Caption           := fStrTitulo(edtCodMar.Text, edtDesMar, arrMar, strMar, 'MARCA');
          frmQckFatComparatVenda.rllProduto.Caption         := fStrTitulo(edtCodIte.Text, edtDesIte, arrPro, strPro, 'PRODUTO');

          case rdgEmpresa.ItemIndex of
            0 : frmQckFatComparatVenda.rllEmpresa.Caption   := fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmp, strEmp, 'EMPRESA (FATURAMENTO)');
            1 : frmQckFatComparatVenda.rllEmpresa.Caption   := fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmp, strEmp, 'EMPRESA (ORIGEM)');
          end;

          If fEmptyStr(fRetTabPre) Then
          Begin
            frmQckFatComparatVenda.rllTabPre1.Caption := 'VR. Suger.';
            frmQckFatComparatVenda.rllTabPre2.Caption := 'VR. Suger.';
          End
          Else
          Begin
            frmQckFatComparatVenda.rllTabPre1.Caption := 'Pr. Venda ' + fRetTabPre;
            frmQckFatComparatVenda.rllTabPre2.Caption := 'Pr. Venda ' + fRetTabPre;
          End;

          If (fEmptyStr(strMsgConf)) And (Not fEmptyStr(strMsgDif)) Then
          Begin
            strMsgConf := strMsgDif;
            strMsgDif := '';
          End;

          If Not fEmptyStr(strMsgConf) Then
          Begin
            frmQckFatComparatVenda.rllMsgCnf.Visible := True;
            frmQckFatComparatVenda.rllMsgCnf.Caption := strMsgConf;
          End;

          If Not fEmptyStr(strMsgDif) Then
          Begin
            frmQckFatComparatVenda.rllMsgDif.Visible := True;
            frmQckFatComparatVenda.rllMsgDif.Caption := strMsgDif;
          End;

          If fEmptyStr(strMsgConf + strMsgDif) Then
          Begin
            frmQckFatComparatVenda.rlbResumo.Height := frmQckFatComparatVenda.rlbResumo.Height -
            (frmQckFatComparatVenda.rllMsgCnf.Height + frmQckFatComparatVenda.rllMsgDif.Height);
          End
          Else
          Begin
            If fEmptyStr(strMsgDif) Then
              frmQckFatComparatVenda.rlbResumo.Height := frmQckFatComparatVenda.rlbResumo.Height - frmQckFatComparatVenda.rllMsgDif.Height;

            If fEmptyStr(strMsgConf) Then
              frmQckFatComparatVenda.rlbResumo.Height := frmQckFatComparatVenda.rlbResumo.Height - frmQckFatComparatVenda.rllMsgCnf.Height;
          End;

          frmQckFatComparatVenda.rllOrdem.Caption := 'REFERÊNTE AO PERÍODO DE ENTRADA DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          If fEmptyStr(mskGruIni.Text) And fEmptyStr(mskGruFin.Text) Then
            frmQckFatComparatVenda.rllLinGru.Caption := 'LINHA/GRUPO: TODOS'
          Else
            frmQckFatComparatVenda.rllLinGru.Caption := 'LINHA/GRUPO: ' + mskGruIni.Text + ' - ' + edtDesGruIni.Text + ' A ' + mskGruFin.Text + ' - ' + edtDesGruFin.Text;

          If rdgDif.ItemIndex = 0 Then
            strTmp := '%'
          Else
            strTmp := 'R$';

          If chkDiferenca.Checked Then
            frmQckFatComparatVenda.rllExibDifEntre.Caption := 'EXIBIR DIFERENÇAS ENTRE: ' + IfThen(rdgDif.ItemIndex = 1, strTmp, '') +
                                                                                            edtDifIni.Text +
                                                                                            IfThen(rdgDif.ItemIndex = 0, strTmp, '') +
                                                                                            ' A ' +
                                                                                            IfThen(rdgDif.ItemIndex = 1, strTmp, '') +
                                                                                            edtDifFin.Text +
                                                                                            IfThen(rdgDif.ItemIndex = 0, strTmp, '')
          Else
            frmQckFatComparatVenda.rllExibDifEntre.Caption := 'EXIBIR DIFERENÇAS ENTRE: TODOS';

          If chkVendMenSug.Checked Then
            frmQckFatComparatVenda.rllExiDocSug.Caption := 'EXIBIR DOCS./ITENS QUE O VALOR DE VENDA É MENOR QUE O VALOR SUGERIDO: SIM'
          Else
            frmQckFatComparatVenda.rllExiDocSug.Caption := 'EXIBIR DOCS./ITENS QUE O VALOR DE VENDA É MENOR QUE O VALOR SUGERIDO: NÃO';

          If chkPreCus.Checked Then
            frmQckFatComparatVenda.rllExiPreCus.Caption := 'EXIBIR PREÇO DE CUSTO: SIM'
          Else
            frmQckFatComparatVenda.rllExiPreCus.Caption := 'EXIBIR PREÇO DE CUSTO: NÃO';

          frmQckFatComparatVenda.lblDif1.Visible   := rdgDif.ItemIndex = 0;
          frmQckFatComparatVenda.lblDif2.Visible   := rdgDif.ItemIndex = 0;
          frmQckFatComparatVenda.lblDif3.Visible   := rdgDif.ItemIndex = 0;
          frmQckFatComparatVenda.rlbDif1.Visible   := rdgDif.ItemIndex = 0;
          frmQckFatComparatVenda.rlbDif2.Visible   := rdgDif.ItemIndex = 0;
          frmQckFatComparatVenda.rlbDif3.Visible   := rdgDif.ItemIndex = 0;
          frmQckFatComparatVenda.rlbDifTot.Visible := rdgDif.ItemIndex = 0;

          frmQckFatComparatVenda.dtsRelatorio.DataSet := QryRelatorio;

          If edtDestino.Text = 'V' Then
            frmQckFatComparatVenda.qckPagina.PreviewModal
          Else
            frmQckFatComparatVenda.qckPagina.Print;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckFatComparatVenda);

      End;

    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFatComparatVenda.pCarregaPrecos;
  Var
    intIndex: Integer;
Begin
  cbxTabPre.Items.Clear;
  cbxTabPre.Items.Add('Sugerido na Venda');

  For intIndex := 1 To Length(VS_strTabPrc) Do
    if VS_strTabPrc[intIndex] = 'S' Then
      cbxTabPre.Items.Add('Tabela ' + IntToStr(intIndex));

  cbxTabPre.ItemIndex := 0;    
End;

Function TfrmRelFatComparatVenda.fRetTabPre: String;
Begin
  If cbxTabPre.ItemIndex = 0 Then
    Result := ''
  Else
    Result := Copy(cbxTabPre.Text, 8,1);
End;

Function TfrmRelFatComparatVenda.fRetCampoPre: String;
Begin
  If fEmptyStr(fRetTabPre) Then
    Result := ' IF(IFNULL(DET_UNIORI, 0) = 0, DET_UNITAR, DET_UNIORI) '
  Else
  Begin
    {***********************************************************************************}
    {* CASO OS PRECOS DA TINTA PRONTA ESTEJAM GRAVADOS CORRETAMENTE UTILIZA OS MESMOS, *}
    {* CASO CONTRARIO SE FOR UM PRODUTO NORMAL IRA PEGAR O PRECO DE TABELA DO ITEM E SE*}
    {* FOR UMA TINTA DE MAQUINA PEGA O PRECO ORIGINAL SUGERIDO NA VENDA                *}
    {*******************************************************************************JC**}
    Result := 'IF(IFNULL(ACA_PREVE' + fRetTabPre + ', 0) > 0, ACA_PREVE' + fRetTabPre + ', ' +
              'IF(DET_IDEPRO = "NOR", ITE_PREVE' + fRetTabPre + ', IF(IFNULL(DET_UNIORI, 0) = 0, DET_UNITAR, DET_UNIORI)))';
  End;
End;

procedure TfrmRelFatComparatVenda.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor, edtDesFor, arrFor, fRetNomFornecedor , nil, 'do Fornecedor');
end;

procedure TfrmRelFatComparatVenda.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComparatVenda.edtCodGerExit(Sender: TObject);
begin
  inherited;

  If (blnLibGer) Then
    pEdtCodSelectExit(edtCodGer, edtDesGer, arrGer, fRetNomVendRep, nil, 'do Gerente');
  fValidaCampos(edtCodGer, True);

end;

procedure TfrmRelFatComparatVenda.edtCodGerKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnLibGer) Then
  Begin
    If (fPesqOperador(Self, edtCodGer, edtDesGer, nil, Key, arrGer, False, True, True)) Then
    Begin
      If fValidaCampos(edtCodGer, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelFatComparatVenda.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMar, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmRelFatComparatVenda.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMar, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComparatVenda.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtDesIte, arrPro, NIL , fRetNomProduto, 'do Produto');
end;

procedure TfrmRelFatComparatVenda.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrPro, False, nil, 'Consulta de Itens', '1') Then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelFatComparatVenda.fGetCOM_DV: String;
begin
  // Ronaldo solicitou que esse relatório utilize a configuração COM_DV sempre como se fosse 1.
  // Caso venha a mudar a regra apenas substitua o numero '1' por fCfgSis('COM_DV')

  {* Requisito: 39665 *}
  Result := fCfgSis('COM_DV');
end;

function TfrmRelFatComparatVenda.fGetCOM_FF: String;
begin
  // Ronaldo solicitou que esse relatório utilize a configuração COM_FF sempre como se fosse 1.
  // Caso venha a mudar a regra apenas substitua o numero '1' por fCfgSis('COM_FF')

  {* Requisito: 39665 *}
  Result := fCfgSis('COM_FF');
end;

function TfrmRelFatComparatVenda.fGetCOM_TR: String;
begin
  // Ronaldo solicitou que esse relatório utilize a configuração COM_TR sempre como se fosse 1.
  // Caso venha a mudar a regra apenas substitua o numero '1' por fCfgSis('COM_TR')

  {* Requisito: 39665 *}
  Result := fCfgSis('COM_TR');
end;

function TfrmRelFatComparatVenda.fGetFrom: String;
  Var
    strSQL : String;
begin
  strSQL :=        '  FROM      ';
  strSQL := strSQL + '    MOVDET  ';
  strSQL := strSQL + '    INNER JOIN CADCLI ON DET_CODCLI = CADCLI.CLI_CODCLI ';
  strSQL := strSQL + '    INNER JOIN CADOPE OV ON DET_CODVEN = OV.OPE_CODOPE ';
  strSQL := strSQL + '    LEFT JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI  ';
  strSQL := strSQL + '    LEFT  JOIN CADACA A ON A.ACA_CODACA = DET_CODACA ';
  strSQL := strSQL + '                       AND A.ACA_CODITE = DET_CODITE  ';
  strSQL := strSQL + '                       AND A.ACA_CODEMP = DET_CODEMP  ';
  strSQL := strSQL + '    LEFT  JOIN ACAGER G ON G.ACA_CODACA = A.ACA_CODACA  ';
  strSQL := strSQL + '                       AND G.ACA_CODEMP = A.ACA_CODEMP  ';
  strSQL := strSQL + '                       AND G.ACA_EMPEST = DET_CODEMP    ';
  strSQL := strSQL + '    INNER JOIN ITEGER I ON I.ITE_CODITE = DET_CODITE  ';
  strSQL := strSQL + '                       AND I.ITE_CODEMP = DET_CODEMP  ';
  strSQL := strSQL + '    INNER JOIN CADITE C ON C.ITE_CODITE = DET_CODITE  ';
  strSQL := strSQL + '    LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + '    LEFT JOIN CADCND ON DET_CODCND = CADCND.CND_CODIGO ';
  strSQL := strSQL + '    LEFT JOIN CADFPG ON DET_CODFPG = CADFPG.FPG_CODIGO ';

  If (rdgOpcao.ItemIndex in [0, 1]) And chkExibeOpeLiberacao.Checked Then
  Begin
    strSQL := strSQL + '    LEFT JOIN LOGLIB ON LOG_NUMDOC = DET_NUMDOC ';
    strSQL := strSQL + '                    AND LOG_ESPDOC = DET_ESPDOC ';
    strSQL := strSQL + '                    AND LOG_CODEMP = DET_CODEMP ';
    strSQL := strSQL + '                    AND ((LOG_OBSERV LIKE "%VALOR DA VENDA MENOR QUE O VALOR MÍNIMO%") ';
    strSQL := strSQL + '                         OR (LOG_OBSERV LIKE "%VALOR UNITÁRIO MENOR QUE O PREÇO DE MÍNIMO%")) ';
    strSQL := strSQL + '    LEFT JOIN CADOPE OL ON OL.OPE_CODOPE = LOG_CODOPE ';
  End;

  Result := strSQL;
end;

function TfrmRelFatComparatVenda.fGetOrderBy: String;
  Var
    strSQL : String;
begin
  strSQL := ''; 

  Case rdgOpcao.ItemIndex Of
    0,1: strSQL := strSQL + ' ORDER BY DTAENT, ESPDOC, NUMDOC, AUTINC ';
    2:   strSQL := strSQL + ' ORDER BY CODVEN, NOMVEN ';
    3:   strSQL := strSQL + ' ORDER BY DESCND, DESFPG, DTAENT, NUMDOC, ESPDOC ';
  End;

  Result := strSQL;
end;

function TfrmRelFatComparatVenda.fGetSelect: String;
  Var
    strSQL : String;
begin
  strSQL := '';

  Case rdgOpcao.ItemIndex Of

    0: Begin
      strSQL := strSQL + 'SELECT  SQL_NO_CACHE    ';
      strSQL := strSQL + '  MOVDET.AUTOINCREM AS AUTINC, ';
      strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';
      strSQL := strSQL + '  DET_CODITE AS CODITE, ';
      strSQL := strSQL + '  DET_DESCRI AS DESITE, ';
      strSQL := strSQL + '  DET_REFERE AS REFERE, ';
      strSQL := strSQL + '  UNI_DESUNI AS UNIDAD, ';
      strSQL := strSQL + '  DET_QTDITE AS QTDITE, ';
      strSQL := strSQL + '  DET_TOTCUS AS TOTCUS, ';
      strSQL := strSQL + ' ' + fGetVrSuge + ' AS VRSUGE, ';
      strSQL := strSQL + ' ' + fGetVrVend + ' AS VRVEND, ';
      strSQL := strSQL + ' ' + fGetVrVend + ' - ' + fGetVrSuge + ' AS DIFERE, ';

      If rdgDif.ItemIndex = 0 Then
      Begin
        strSQL := strSQL + '  ROUND( -1 * ((' + fGetVrSuge + ' - ';
        strSQL := strSQL + '                ' + fGetVrVend + ' ) / ';
        strSQL := strSQL + '                ' + fGetVrSuge + ' * 100), 2) AS PERDIF, ';
      End
      Else
        strSQL := strSQL + ' 0.00 AS PERDIF, ';

      If chkExibeOpeLiberacao.Checked Then
      Begin
        strSQL := strSQL + '    CONCAT(LOG_CODOPE, "-", OL.OPE_NOMOPE) AS OPELIB, ';
        strSQL := strSQL + '    LOG_DTACAD AS DTALIB, ';
        strSQL := strSQL + '    LOG_HRACAD AS HORLIB, ';
        strSQL := strSQL + '    LOG_OBSERV AS OBSLIB, ';
      End;

      strSQL := strSQL + '    DET_CODCLI AS CODCLI, ';
      strSQL := strSQL + '    CLI_NOMCLI AS NOMCLI, ';
      strSQL := strSQL + '    DET_DTAENT AS DTAENT, ';
      strSQL := strSQL + '    DET_CODVEN AS CODVEN, ';
      strSQL := strSQL + '    OV.OPE_NOMOPE AS NOMVEN, ';
      strSQL := strSQL + '    DET_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '    DET_ESPDOC AS ESPDOC  ';
    End;

    1: Begin
      strSQL := strSQL + 'SELECT  SQL_NO_CACHE     ';
      strSQL := strSQL + '  MOVDET.AUTOINCREM AS AUTINC, ';
      strSQL := strSQL + '  DET_CODEMP AS CODEMP,  ';
      strSQL := strSQL + '  DET_TOTCUS AS TOTCUS,  ';
      strSQL := strSQL + fGetVrSuge + ' AS VRSUGE, ';
      strSQL := strSQL + fGetVrVend + ' AS VRVEND, ';
      strSQL := strSQL + fGetVrVend + ' - ' + fGetVrSuge + ' AS DIFERE, ';

      If rdgDif.ItemIndex = 0 Then
      Begin
        strSQL := strSQL + '  ROUND( -1 * ((' + fGetVrSuge + ' - ';
        strSQL := strSQL + '                ' + fGetVrVend + ' ) / ';
        strSQL := strSQL + '                ' + fGetVrSuge + ' * 100), 2) AS PERDIF, ';
      End
      Else
        strSQL := strSQL + ' 0.00 AS PERDIF, ';

      If chkExibeOpeLiberacao.Checked Then
      Begin
        strSQL := strSQL + '    CONCAT(LOG_CODOPE, "-", OL.OPE_NOMOPE) AS OPELIB, ';
        strSQL := strSQL + '    LOG_DTACAD AS DTALIB, ';
        strSQL := strSQL + '    LOG_HRACAD AS HORLIB, ';
        strSQL := strSQL + '    LOG_OBSERV AS OBSLIB, ';
      End;

      strSQL := strSQL + '    DET_CODCLI AS CODCLI, ';
      strSQL := strSQL + '    CLI_NOMCLI AS NOMCLI, ';
      strSQL := strSQL + '    DET_DTAENT AS DTAENT, ';
      strSQL := strSQL + '    DET_CODVEN AS CODVEN, ';
      strSQL := strSQL + '    OV.OPE_NOMOPE AS NOMVEN, ';
      strSQL := strSQL + '    DET_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '    DET_ESPDOC AS ESPDOC  ';
    End;

    2: Begin
      strSQL := ' SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '   DET_CODVEN AS CODVEN, ';
      strSQL := strSQL + '   OV.OPE_NOMOPE AS NOMVEN, ';
      strSQL := strSQL + '   DET_TOTCUS AS TOTCUS, ';
      strSQL := strSQL + fGetVrSuge + ' AS VRSUGE, ';
      strSQL := strSQL + fGetVrVend + ' AS VRVEND, ';
      strSQL := strSQL + fGetVrVend + ' - ' + fGetVrSuge + ' AS DIFERE, ';
      If rdgDif.ItemIndex = 0 Then
      Begin
        strSQL := strSQL + '  ROUND( -1 * ((' + fGetVrSuge + ' - ';
        strSQL := strSQL + '                ' + fGetVrVend + ' ) / ';
        strSQL := strSQL + '                ' + fGetVrSuge + ' * 100), 2) AS PERDIF ';
      End
      Else
        strSQL := strSQL + ' 0.00 AS PERDIF ';
    End;

    3:
    Begin
      strSQL := ' SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '   MOVDET.AUTOINCREM AS AUTINC, ';
      strSQL := strSQL + '   DET_DTAENT AS DTAENT, ';
      strSQL := strSQL + '   DET_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '   DET_ESPDOC AS ESPDOC, ';
      strSQL := strSQL + '   DET_CODEMP AS CODEMP, ';
      strSQL := strSQL + '   DET_CODCLI AS CODCLI, ';
      strSQL := strSQL + '   CLI_NOMCLI AS NOMCLI, ';
      strSQL := strSQL + '   DET_CODVEN AS CODVEN, ';
      strSQL := strSQL + '   OV.OPE_NOMOPE AS NOMVEN, ';
      strSQL := strSQL + '   DET_CODCND AS CODCND, ';
      strSQL := strSQL + '   CND_DESCRI AS DESCND, ';
      strSQL := strSQL + '   DET_CODFPG AS CODFPG, ';
      strSQL := strSQL + '   FPG_DESCRI AS DESFPG, ';
      strSQL := strSQL + '   DET_TOTCUS AS TOTCUS, ';
      strSQL := strSQL + fGetVrSuge + ' AS VRSUGE, ';
      strSQL := strSQL + fGetVrVend + ' AS VRVEND, ';
      strSQL := strSQL + fGetVrVend + ' - ' + fGetVrSuge + ' AS DIFERE, ';
      If rdgDif.ItemIndex = 0 Then
      Begin
        strSQL := strSQL + '  ROUND( -1 * ((' + fGetVrSuge + ' - ';
        strSQL := strSQL + '                ' + fGetVrVend + ' ) / ';
        strSQL := strSQL + '                ' + fGetVrSuge + ' * 100), 2) AS PERDIF ';
      End
      Else
        strSQL := strSQL + ' 0.00 AS PERDIF ';
    End;
  End;

  Result := strSQL;
end;

function TfrmRelFatComparatVenda.fGetVrSuge: String;
begin
  Result := ' IF(LEFT(DET_CLAFIS,1) < 5, - ROUND((' + fRetCampoPre + ' * DET_QTDITE),2), ROUND((' + fRetCampoPre + ' * DET_QTDITE),2)) ';
end;

function TfrmRelFatComparatVenda.fGetVrVend: String;
begin
  Result := ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -ROUND((DET_TOTITE - DET_DESESP - DET_DESCFF),2), ROUND(DET_TOTITE - DET_DESESP - DET_DESCFF,2))) ';
end;

function TfrmRelFatComparatVenda.fGetWhere: String;
  Var
    strSQL : String;
begin
  strSQL :=          '  WHERE ';
  strSQL := strSQL + '     DET_PROEMB <> "S"                        AND ';
  strSQL := strSQL + '     DET_TIP_FC = "C"                         AND ';
  strSQL := strSQL + '     DET_ESPDOC NOT IN ("FF")                 AND ';
  strSQL := strSQL + '     DET_ESPDOC NOT IN ("TR")                 AND ';
  strSQL := strSQL + '     DET_ESPDOC NOT IN ("DV")                 AND ';
  strSQL := strSQL + '     DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  strSQL := strSQL + '     ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

  If fCfgSis('ENTBRF', varBoolean) Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    strSQL := strSQL + ') ';

  If fEmptyStr(edtDocumento.Text) Or fEmptyStr(edtEspDoc.Text) Then
    strSQL := strSQL + ' AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(edtDocumento.Text) Then
    strSQL := strSQL + ' AND DET_NUMDOC = :NUMDOC ';

  If Not fEmptyStr(edtEspDoc.Text) Then
    strSQL := strSQL + ' AND DET_ESPDOC = :ESPDOC ';

  strSQL := strSQL + fStrLocate(edtCodFor, arrFor, 'DET_FORITE',   'CODFOR');
  strSQL := strSQL + fStrLocate(edtCodMar, arrMar, 'C.ITE_CODMAR', 'CODMAR');
  strSQL := strSQL + fStrLocate(edtCodDep, arrDep, 'OPE_CODDEP',   'CODDEP');
  strSQL := strSQL + fStrLocate(edtCodIte, arrPro, 'DET_CODITE',   'CODITE');
  strSQL := strSQL + fStrLocate(edtCodCli, arrCli, 'DET_CODCLI',   'CODCLI');
  strSQL := strSQL + fStrLocate(edtCodRep, arrRep, 'DET_CODREP',   'CODREP');
  strSQL := strSQL + fStrLocate(edtCodRed, arrRed, 'CLI_CODRED',   'CODRED');

  If (Not fEmptyStr(edtCodGer.Text)) Then
  Begin
    If (blnLibGer) Then
      strSQL := strSQL + fStrLocate(edtCodGer, arrGer, 'OPE_CODGER', 'CODGER')
    Else
      strSQL := strSQL + ' AND OPE_CODGER = :CODGER ';
  End;

  If (Not fEmptyStr(edtCodSubGer.Text)) Then
  begin
    If (blnLibSub) Then
      strSQL := strSQL + fStrLocate(edtCodSubGer, arrSubGer, 'OPE_CODSUB', 'CODSUB')
    Else
      strSQL := strSQL + ' AND OPE_CODSUB = :CODSUB ';
  end;

  If (Not fEmptyStr(edtCodVen.Text)) Then
  Begin
    If (blnLibVen) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVen, 'DET_CODVEN', 'CODVEN')
    Else
      strSQL := strSQL + ' AND DET_CODVEN = :CODVEN ';
  End;

  If Not fEmptyStr(mskGruIni.Text) Then
  Begin
    If RightStr(mskGruIni.Text, 2) = '00' Then
       strSQL := strSQL + ' AND LEFT(C.ITE_CODGRU, 2) >= LEFT(:GRUINI, 2) '
    Else
       strSQL := strSQL + ' AND C.ITE_CODGRU >= :GRUINI ';
  End;

  If Not fEmptyStr(mskGruFin.Text) Then
  Begin
    If RightStr(mskGruFin.Text, 2) = '00' Then
       strSQL := strSQL + ' AND LEFT(C.ITE_CODGRU, 2) <= LEFT(:GRUFIN, 2) '
    Else
       strSQL := strSQL + ' AND C.ITE_CODGRU <= :GRUFIN ';
  End;

  If (chkDiferenca.Checked) Then
  Begin
    If rdgDif.ItemIndex = 0 Then
    Begin
      strSQL := strSQL + ' AND (ROUND( -1 * ((IF(LEFT(DET_CLAFIS,1) < 5, - ROUND((' + fRetCampoPre + ' * DET_QTDITE),2), ROUND((' + fRetCampoPre + ' * DET_QTDITE),2)) - ';
      strSQL := strSQL + '                    IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -ROUND((DET_TOTITE - DET_DESESP - DET_DESCFF),2), ROUND(DET_TOTITE - DET_DESESP - DET_DESCFF,2))) ) / ';
      strSQL := strSQL + '                    IF(LEFT(DET_CLAFIS,1) < 5, - ROUND((' + fRetCampoPre + ' * DET_QTDITE),2), ROUND((' + fRetCampoPre + ' * DET_QTDITE),2)) * 100), 2) BETWEEN :DIFINI AND :DIFFIN) ';
    End
    Else
    Begin
      strSQL := strSQL + ' AND (IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -ROUND((DET_TOTITE - DET_DESESP - DET_DESCFF),2), ROUND(DET_TOTITE - DET_DESESP - DET_DESCFF,2))) - ';
      strSQL := strSQL + '      IF(LEFT(DET_CLAFIS,1) < 5, - ROUND((' + fRetCampoPre + ' * DET_QTDITE),2), ROUND((' + fRetCampoPre + ' * DET_QTDITE),2)) BETWEEN :DIFINI AND :DIFFIN) ';
    End;
  End;

  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    Case rdgEmpresa.ItemIndex Of
      0: strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'DET_CODEMP', 'CODEMP');
      1: strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'MOVTRI.DET_EMPORI', 'CODEMP');
    End;
  End
  Else
  Begin
    Case rdgEmpresa.ItemIndex Of
      0: strSQL := strSQL + '  AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
      1: strSQL := strSQL + '  AND LOCATE(MOVTRI.DET_EMPORI,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;
  End;

  If (chkVendMenSug.Checked) Then
    strSQL := strSQL + '  HAVING VRVEND < VRSUGE ';

  Result := strSQL;
end;

procedure TfrmRelFatComparatVenda.edtDestinoExit(Sender: TObject);
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

procedure TfrmRelFatComparatVenda.edtDifIniEnter(Sender: TObject);
  Var
    varWidth: Variant;
begin
  inherited;

  varWidth := int(TWinControl(Sender).Width / 2);

  HintControler.ShowHint(Self.Left + TWinControl(Sender).Parent.Left + TWinControl(Sender).Left + varWidth,
                         15 + Self.Top + TWinControl(Sender).Parent.Top + TWinControl(Sender).Parent.Height,
                         'Exibir diferenças entre:',
                         'Informando um valor inicial e um valor final é possível filtrar os ' + #13#10 +
                         'documentos/itens que tiveram descontos ou acréscimos.' + #13#10 +
                         'Exemplos: ' + #13#10 +
                         'Para exibir somente documentos/itens que tiveram até 10,00 de valor desconto,' + #13#10 +
                         'informe o valor da diferença entre -10,00 e 0,00.' + #13#10 +
                         'Para exibir somente documentos/itens que tiveram até 10,00 de valor acréscimo,' + #13#10 +
                         'informe o valor da diferença entre 0,00 e 10,00.' + #13#10 +
                         'O mesmo serve para quando for selecionado em porcentagem.');

end;

procedure TfrmRelFatComparatVenda.edtDifIniExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmRelFatComparatVenda.pGeraExcelNovo(qryDados: TDataSet);
  Var
    objExcel: TGeraExcel;
    strDoc,
    strTab,
    strTmp : string;
begin
  If edtDocumento.Text <> '' Then
    strDoc := 'DOCUMENTO: ' + edtDocumento.Text + '  ';

  If edtEspDoc.Text <> '' Then
    strDoc := strDoc + 'ESPÉCIE: ' + edtEspDoc.Text;

  if cbxTabPre.ItemIndex > 0 then
    strTab := 'TABELA DE PREÇO: ' + cbxTabPre.Text;

  objExcel := TGeraExcel.Create(qryDados, pgbProgresso);

  With objExcel Do
  Begin
    Case rdgOpcao.ItemIndex of
      0: strNomRel := 'RELATÓRIO DE COMPARATIVO DE VENDAS - ANALÍTICO';
      1: strNomRel := 'RELATÓRIO DE COMPARATIVO DE VENDAS - SINTÉTICO POR DOCUMENTO';
      2: strNomRel := 'RELATÓRIO DE COMPARATIVO DE VENDAS - SINTÉTICO POR VENDEDOR';
      3: strNomRel := 'RELATÓRIO DE COMPARATIVO DE VENDAS - SINTÉTICO POR CONDIÇÃO/FORMA DE PAGAMENTO';
    end;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Or Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      AddFiltro('REFERÊNTE AO PERÍODO DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)));

    AddFiltro(fStrTitulo(edtCodGer, edtDesGer, arrGer, strGer, 'GERENTE'));
    AddFiltro(fStrTitulo(edtCodSubGer, edtDesSubGer, arrSubGer, strSubGer, 'SUB-GERENTE'));
    AddFiltro(fStrTitulo(edtCodVen, edtDesVen, arrVen, strVen, 'VENDEDOR'));
    AddFiltro(fStrTitulo(edtCodRep.Text, edtDesRep, arrRep, strRep, 'REPRESENTANTE'));
    AddFiltro(fStrTitulo(edtCodDep.Text, edtDesDep, arrDep, strDep, 'DEPARTAMENTO'));
    AddFiltro(fStrTitulo(edtCodCli.Text, edtDesCli, arrCli, strCli, 'CLIENTE'));
    AddFiltro(fStrTitulo(edtCodRed.Text, edtDesRed, arrRed, strRed, 'REDE'));
    AddFiltro(fStrTitulo(edtCodFor.Text, edtDesFor, arrFor, strFor, 'FORNECEDOR'));
    AddFiltro(fStrTitulo(edtCodMar.Text, edtDesMar, arrMar, strMar, 'MARCA'));
    AddFiltro(fStrTitulo(edtCodIte.Text, edtDesIte, arrPro, strPro, 'PRODUTO'));

    Case rdgEmpresa.ItemIndex Of
      0 : AddFiltro(fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmp, strEmp, 'EMPRESA (FATURAMENTO)'));
      1 : AddFiltro(fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmp, strEmp, 'EMPRESA (ORIGEM)'));
    End;

    If fEmptyStr(mskGruIni.Text) And fEmptyStr(mskGruFin.Text) Then
      AddFiltro('LINHA/GRUPO: TODOS')
    Else
      AddFiltro('LINHA/GRUPO: ' + mskGruIni.Text + ' - ' + edtDesGruIni.Text + ' A ' + mskGruFin.Text + ' - ' + edtDesGruFin.Text);

    If rdgDif.ItemIndex = 0 Then
      strTmp := '%'
    Else
      strTmp := 'R$';

    If chkDiferenca.Checked Then
      AddFiltro('EXIBIR DIFERENÇAS ENTRE: ' + IfThen(rdgDif.ItemIndex = 1, strTmp, '') +
                                              edtDifIni.Text +
                                              IfThen(rdgDif.ItemIndex = 0, strTmp, '') +
                                              ' A ' +
                                              IfThen(rdgDif.ItemIndex = 1, strTmp, '') +
                                              edtDifFin.Text +
                                              IfThen(rdgDif.ItemIndex = 0, strTmp, ''))
    Else
      AddFiltro('EXIBIR DIFERENÇAS ENTRE: TODOS');

    If chkVendMenSug.Checked Then
      AddFiltro('EXIBIR DOCS./ITENS QUE O VALOR DE VENDA É MENOR QUE O VALOR SUGERIDO: SIM')
    Else
      AddFiltro('EXIBIR DOCS./ITENS QUE O VALOR DE VENDA É MENOR QUE O VALOR SUGERIDO: NÃO');

    If chkPreCus.Checked Then
      AddFiltro('EXIBIR PREÇO DE CUSTO: SIM')
    Else
      AddFiltro('EXIBIR PREÇO DE CUSTO: NÃO');

    If Not fEmptyStr(strMsgConf) Then
      AddFiltro(strMsgConf);

    if not fEmptyStr(strDoc) then
      AddFiltro(strDoc);

    if not fEmptyStr(strTab) then
      AddFiltro(strTab);

    Case rdgOpcao.ItemIndex of
    0:
      Begin
        AddCampo('DTAENT','DATA');
        AddCampo('NUMDOC','NRO.DOC');
        AddCampo('ESPDOC','ESP.');
        AddCampo('CODEMP','EMP.');
        AddCampo('NOMCLI','CLIENTE');
        AddCampo('NOMVEN','VENDEDOR');
        AddCampo('CODITE','ITEM');
        AddCampo('DESITE','DESCRIÇÃO');
        AddCampo('REFERE','REFERÊNCIA');
        AddCampo('UNIDAD','UNID.');
        AddCampo('QTDITE','QTD.');
        AddCampo('VRSUGE','VL.SUGER.');
        AddCampo('VRVEND','VL.VEND.');
        AddCampo('DIFERE','DIF. (R$)');

        If rdgDif.ItemIndex = 0 Then
          AddCampo('PERDIF','% DIF.');

        If (chkPreCus.Checked) Then
          AddCampo('TOTCUS','VR.CUSTO');

        AddTotais('VRSUGE');
        AddTotais('VRVEND');
        AddTotais('DIFERE');

        If rdgDif.ItemIndex = 0 Then
          AddTotais('PERDIF');

        If (chkPreCus.Checked) Then
          AddTotais('TOTCUS');
      End;
    1:
      Begin
        AddCampo('DTAENT','DATA');
        AddCampo('NUMDOC','NRO.DOC');
        AddCampo('ESPDOC','ESP.');
        AddCampo('CODEMP','EMP.');
        AddCampo('NOMCLI','CLIENTE');
        AddCampo('NOMVEN','VENDEDOR');
        AddCampo('VRSUGE','VL.SUGER.');
        AddCampo('VRVEND','VL.VEND.');
        AddCampo('DIFERE','DIF. (R$)');

        If rdgDif.ItemIndex = 0 Then
          AddCampo('PERDIF','% DIF.');

        If (chkPreCus.Checked) Then
          AddCampo('TOTCUS','VR.CUSTO');

        AddTotais('VRSUGE');
        AddTotais('VRVEND');
        AddTotais('DIFERE');

        If rdgDif.ItemIndex = 0 Then
          AddTotais('PERDIF');

        If (chkPreCus.Checked) Then
          AddTotais('TOTCUS');
      End;
    2:
      Begin
        AddCampo('NOMVEN','VENDEDOR');
        AddCampo('VRSUGE','VL.SUGER.');
        AddCampo('VRVEND','VL.VEND.');
        AddCampo('DIFERE','DIF. (R$)');

        If rdgDif.ItemIndex = 0 Then
          AddCampo('PERDIF','% DIF.');

        If (chkPreCus.Checked) Then
          AddCampo('TOTCUS','VR.CUSTO');

        AddTotais('VRSUGE');
        AddTotais('VRVEND');
        AddTotais('DIFERE');

        If rdgDif.ItemIndex = 0 Then
          AddTotais('PERDIF');

        If (chkPreCus.Checked) Then
          AddTotais('TOTCUS');
      End;
    3:
      Begin
        AddCampo('DTAENT','DATA');
        AddCampo('NUMDOC','NRO.DOC');
        AddCampo('ESPDOC','ESP.');
        AddCampo('CODEMP','EMP.');
        AddCampo('NOMCLI','CLIENTE');
        AddCampo('NOMVEN','VENDEDOR');
        AddCampo('VRSUGE','VL.SUGER.');
        AddCampo('VRVEND','VL.VEND.');
        AddCampo('DIFERE','DIF. (R$)');

        If rdgDif.ItemIndex = 0 Then
          AddCampo('PERDIF','% DIF.');

        If (chkPreCus.Checked) Then
          AddCampo('TOTCUS','VR.CUSTO');

        AddQuebra('CNDFPG','');

        AddTotais('VRSUGE');
        AddTotais('VRVEND');
        AddTotais('DIFERE');

        If rdgDif.ItemIndex = 0 Then
          AddTotais('PERDIF');

        If (chkPreCus.Checked) Then
          AddTotais('TOTCUS');
      End;
    End;

    OnMontaResumo := pMontaResumo;
    OnSomaResumo  := pSomaTotais;
    If (rdgOpcao.ItemIndex in [0, 1]) And chkExibeOpeLiberacao.Checked Then
      OnImpDetalhes := pImprimeLiberacao;

    If fGerarRelatorio Then
    Begin
      fMensagem('','Arquivo gerado com sucesso!',['&OK']);
    End;

  End;

  FreeAndNil(objExcel);
end;

procedure TfrmRelFatComparatVenda.pImprimeLiberacao(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; enmCorFundo: TCorExcel);
begin
  if Not Dados.FieldByName('OPELIB').IsNull Then
  Begin
    With Excel Do
    Begin
      ProximaLinha;
      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), enmCorFundo);
      Escrever(LinhaAtual, 1, 'Operador Liberação: ' + Dados.FieldByName('OPELIB').AsString);
      Mesclar('A' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
      Escrever(LinhaAtual, 6, 'Data/Hora Liberação: ' + Dados.FieldByName('DTALIB').AsString + ' ' + Dados.FieldByName('HORLIB').AsString);
      Mesclar('F' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

      ProximaLinha;
      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), enmCorFundo);
      Escrever(LinhaAtual, 1, ReplaceStr(Dados.FieldByName('OBSLIB').AsString, #13, ''));
      Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      AlinhamentoVertical(LinhaAtual, 1, xlsTop);

      Bordas  ('A' + IntToStr(LinhaAtual - 1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    End;
  End;
end;

procedure TfrmRelFatComparatVenda.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
  Var
    intAux : Integer;
    strTotal: String;
    CorTmp: TCorExcel;
begin
  intAux := 0;

  With Excel Do
  Begin
    If (Quebra.NomeCampo = 'CNDFPG') Then
      strTotal := 'TOTAL POR FORMA/CONDIÇÃO: '
    Else
      strTotal := 'TOTAL GERAL: ';

    If strTotal <> '' Then
    Begin
      ProximaLinha;

      Escrever(LinhaAtual, 01, strTotal);

      Case rdgOpcao.ItemIndex of
        0  : intAux := 12;
        1,3: intAux := 7;
        2  : intAux := 2;
      end;

      Escrever(LinhaAtual, intAux  , fPadL(FormatFloat('##,#0.00', Quebra.Totais['VRSUGE']), 14));
      Escrever(LinhaAtual, intAux+1, fPadL(FormatFloat('##,#0.00', Quebra.Totais['VRVEND']), 14));
      Escrever(LinhaAtual, intAux+2, fPadL(FormatFloat('##,#0.00', Quebra.Totais['DIFERE']), 14));

      If rdgDif.ItemIndex = 0 Then
        Escrever(LinhaAtual, intAux+3, fPadL(FormatFloat('##,#0.00', Quebra.Totais['PERDIF']), 14));

      If (chkPreCus.Checked) Then
        Escrever(LinhaAtual, intAux+IfThen(rdgDif.ItemIndex = 0, 4, 3), fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTCUS']), 14));

      Negrito(LinhaAtual, 01, True);
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

      Mesclar ('A' + IntToStr(LinhaAtual), IfThen(rdgOpcao.ItemIndex = 0,'K',IfThen(rdgOpcao.ItemIndex = 1,'F','A')) + IntToStr(LinhaAtual));

      If (Quebra.NomeCampo = 'CNDFPG') Then
        CorTmp := Azul
      Else
        CorTmp := Preto;

      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), CorTmp);
      CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
      Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    End;
  End;
end;

procedure TfrmRelFatComparatVenda.pSetaParametros(qryQuery: TUniQuery);
begin
  With qryQuery Do
  Begin
    If fEmptyStr(edtDocumento.Text) Or fEmptyStr(edtEspDoc.Text) Then
    Begin
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    End;

    If chkDiferenca.Checked Then
    Begin
      ParamByName('DIFINI').AsFloat := fStrToFloat(edtDifIni.Text);
      ParamByName('DIFFIN').AsFloat := fStrToFloat(edtDifFin.Text);
    End;

    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;

    If Not fEmptyStr(edtDocumento.Text) Then
      ParamByName('NUMDOC').AsString := edtDocumento.Text;


    If Not fEmptyStr(edtEspDoc.Text) Then
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;

    pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryQuery);
    pSetaParam(edtCodCli.Text, arrCli, strCli, 'CODCLI', qryQuery);
    pSetaParam(edtCodFor.Text, arrFor, strFor, 'CODFOR', qryQuery);
    pSetaParam(edtCodMar.Text, arrMar, strMar, 'CODMAR', qryQuery);
    pSetaParam(edtCodDep.Text, arrDep, strDep, 'CODDEP', qryQuery);
    pSetaParam(edtCodIte.Text, arrPro, strPro, 'CODITE', qryQuery);
    pSetaParam(edtCodRed.Text, arrRed, strRed, 'CODRED', qryQuery);
    pSetaParam(edtCodRep.Text, arrRep, strRep, 'CODREP', qryQuery);

    If (Not fEmptyStr(edtCodGer.Text)) Then
    Begin
      If (blnLibGer) Then
        pSetaParam(edtCodGer.Text, arrGer, strGer, 'CODGER', qryQuery)
      Else
        ParamByName('CODGER').AsString := fRetCodVendedor(edtCodGer.Text);
    End;

    If (Not fEmptyStr(edtCodSubGer.Text)) Then
    Begin
      If (blnLibSub) Then
        pSetaParam(edtCodSubGer.Text, arrSubGer, strSubGer, 'CODSUB', qryQuery)
      Else
        ParamByName('CODSUB').AsString := fRetCodVendedor(edtCodSubGer.Text);
    End;

    If (Not fEmptyStr(edtCodVen.Text)) Then
    Begin
      If (blnLibVen) Then
        pSetaParam(edtCodVen.Text, arrVen, strVen, 'CODVEN', qryQuery)
      Else
        ParamByName('CODVEN').AsString := fRetCodVendedor(edtCodVen.Text);
    End;

    If Not fEmptyStr(mskGruIni.Text) Then
      ParamByName('GRUINI').AsString := mskGruIni.Text;

    If Not fEmptyStr(mskGruFin.Text) Then
      ParamByName('GRUFIN').AsString := mskGruFin.Text;
  End;
end;

procedure TfrmRelFatComparatVenda.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
begin
  Totais['VRSUGE'] := Totais['VRSUGE'] + Dados.FieldByName('VRSUGE').AsCurrency;
  Totais['VRVEND'] := Totais['VRVEND'] + Dados.FieldByName('VRVEND').AsCurrency;

  If (chkPreCus.Checked) Then
    Totais['TOTCUS'] := Totais['TOTCUS'] + Dados.FieldByName('TOTCUS').AsCurrency;

  Totais['DIFERE'] := Totais['DIFERE'] + (Dados.FieldByName('VRVEND').AsCurrency -
                                          Dados.FieldByName('VRSUGE').AsCurrency);

  If rdgDif.ItemIndex = 0 Then
  Begin
    If (Totais['VRSUGE'] <> 0) Then
      Totais['PERDIF'] := -1 * (((Totais['VRSUGE'] - Totais['VRVEND']) / Totais['VRSUGE']) * 100)
    Else
      Totais['PERDIF'] := 0;
  End;
end;

procedure TfrmRelFatComparatVenda.pVerdeVermelho(Edt: TEditFocus; Shp: TShape; bln: Boolean);
begin
  Shp.Brush.Color := clGreen;
  If (Not bln) Then
  Begin
    Edt.MaxLength := 10;
    Edt.TamCampo  := 10;
    Edt.CompZeros := False;
    Edt.PasswordChar := '*';
    Edt.TipoTexto := ttAlfanumerico;

    Shp.Brush.Color  := clRed;
  End
end;

procedure TfrmRelFatComparatVenda.rdgOpcaoClick(Sender: TObject);
begin
  inherited;
  chkExibeOpeLiberacao.Enabled := rdgOpcao.ItemIndex in [0, 1];
end;

end.
