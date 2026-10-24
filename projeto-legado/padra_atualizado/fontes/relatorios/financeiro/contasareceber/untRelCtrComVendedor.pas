unit untRelCtrComVendedor;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils, Menus,
  QColorLabel, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, Uni, untTypesSistema,
  AppEvnts, untFuncoesFactory, BitBtnLockedIncrem, UniClientDataSet, UniDataSetProvider,
  Data.DB, frxExportCSVTestabilidade, untIFuncoes, untClassPanelCx;

type
  TfrmRelCtrComVendedor = class(TfrmPaiRelatorio)
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    edtCodCliente: TEditFocus;
    lblPortador: TLabel;
    edtCodPor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    Label5: TLabel;
    edtDesCliente: TEditFocus;
    edtDesPortador: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label1: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    gbpDupDesc: TGroupBox;
    ColorLabel2: TColorLabel;
    edtDupDesc: TEditFocus;
    Label2: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    Label3: TLabel;
    edtCodRep: TEditFocus;
    edtNomRep: TEditFocus;
    GroupBox1: TGroupBox;
    ColorLabel3: TColorLabel;
    edtOpcao: TEditFocus;
    Label16: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    dtsRelatorio: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEveExit(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodRepExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    arrClientes : TConsultasArray;
    arrRede     : TConsultasArray;
    arrPortador : TConsultasArray;
    arrEventos  : TConsultasArray;
    arrVendedor : TConsultasArray;
    arrRepresentante : TConsultasArray;
    arrEmpresa : TConsultasArray;
    qryGenPor   : TUniQuery;
    cdsSin      : TUniClientDataSet;

    qryRelatorio: TUniQuery;

    procedure pCriaQryRelatorio;

    procedure pPreparaRelSintetico(cdsDados: TUniClientDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelCtrComVendedor: TfrmRelCtrComVendedor;

implementation

uses untQckCtrComVendedor;

{$R *.dfm}

procedure TfrmRelCtrComVendedor.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  shpMultSel.Visible := True;

  inherited;
end;

procedure TfrmRelCtrComVendedor.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente,edtDesCliente,arrClientes,nil,fRetNomCliente,'do Cliente');

  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetFocus(edtCodPor);
  End
  Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmRelCtrComVendedor.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrComVendedor.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPortador, nil, Key, arrPortador, False)  Then
  Begin
    If fValidaCampos(edtCodPor, True) then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrComVendedor.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;

end;

procedure TfrmRelCtrComVendedor.pPreparaRelSintetico(cdsDados: TUniClientDataSet);
  Var
    intCnt : Integer;
    fldTmp : TField;
begin
  If (Not cdsSin.Active) Then
    pCloneDataSet(cdsSin, cdsDados);

  cdsSin.EmptyDataSet;
  cdsSin.IndexFieldNames := 'OPE_CODOPE';

  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin

    If cdsSin.FindKey([ cdsDados.FieldByName('OPE_CODOPE').AsString ]) Then
    Begin
      cdsSin.Edit;

      fldTmp := cdsSin.FindField('CTR_VLRREC');
      If fldTmp <> Nil Then
        cdsSin.FieldByName('CTR_VLRREC').AsFloat := cdsSin.FieldByName('CTR_VLRREC').AsFloat + cdsDados.FieldByName('CTR_VLRREC').AsFloat;

      fldTmp := cdsSin.FindField('CTR_TOTCOM');
      If fldTmp <> Nil Then
        cdsSin.FieldByName('CTR_TOTCOM').AsFloat := cdsSin.FieldByName('CTR_TOTCOM').AsFloat + cdsDados.FieldByName('CTR_TOTCOM').AsFloat;        
    End
    Else
    Begin
      cdsSin.Append;
      For intCnt := 0 To (cdsDados.FieldCount-1) Do
      Begin
        If (Not cdsDados.Fields[intCnt].IsNull) Then
        Begin
          fldTmp := cdsSin.FindField(cdsDados.Fields[intCnt].FieldName);
          If fldTmp <> Nil Then
            cdsSin.FieldByName(fldTmp.FieldName).Value := cdsDados.Fields[intCnt].Value;
        End;
      End;
    End;
    
    cdsSin.Post;

    cdsDados.Next;
  End;

  pSetaClient(cdsSin);
end;

procedure TfrmRelCtrComVendedor.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, fRetNomeEmpresa, Nil, 'da empresa');
end;

procedure TfrmRelCtrComVendedor.edtCodEmpresaKeyPress(Sender: TObject;
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

function TfrmRelCtrComVendedor.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
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

    Else
    If (Sender = edtDupDesc) Then
    Begin

      If fEmptyStr(edtDupDesc.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Duplicata Descontada deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If (edtDupDesc.Text <> 'S') And (edtDupDesc.Text <> 'N') Then
      Begin
        fMensagem('ATENÇÃO','O campo Duplicata Descontada deve conter somente S ou N!',['&O K']);
        Result := False;
      End;

    End

    Else
    If (Sender = edtCodEmpresa) Then
    Begin
      If Not (fEmptyStr(edtCodEmpresa.Text)) And
         (edtCodEmpresa.Text <> '000')Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else
    {****************}
    {* VALIDA OPCAO *}
    {*************LA*}
    If (Sender = edtOpcao) Then
    Begin
      If (edtOpcao.Text <> 'A') And (edtOpcao.Text <> 'S') Then
      Begin
        fMensagem('','O campo opção deve ter A ou S!',['&O K'],0);
        Result := False;
      End;
    End

    Else If Sender = edtCodPor Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) And (edtCodPor.Text <> '00000') Then
      Begin

        edtDesPortador.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPortador.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
        edtDesPortador.Text := 'TODOS';
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelCtrComVendedor.btnImprimirClick(Sender: TObject);
  Var
    strSQL : String;
    strEmp : String;
    strEve : String;
    strRed : String;
    strPor : String;
    strVen : String;
    strRep : String;
    strCli : String; 
    dtaDtaCor: TDateTime;
    cdsTemp: TUniClientDataSet;
    dspTemp: TUniDataSetProvider;
begin
  inherited;

  If blnImprime Then
  Begin
    cdsTemp := TUniClientDataSet.Create(Self);
    dspTemp := TUniDataSetProvider.Create(Self);
    dspTemp.DataSet := qryRelatorio;
    cdsTemp.SetProvider(dspTemp);

    dtaDtaCor := fCfgSis('DTCOCR', varDate);

    strSQL := '';

    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  R.*, ';
    strSQL := strSQL + '  O.OPE_CODOPE, ';
    strSQL := strSQL + '  O.OPE_NOMOPE, ';
    //strSQL := strSQL + '  O.OPE_PERCOM, ';
    //strSQL := strSQL + '  (R.CTR_VALREC * O.OPE_PERCOM / 100.0) AS ' + IIF(edtOpcao.Text = 'A', 'CTR_TOTCOM', 'CTR_COMISS') + ', ';
    strSQL := strSQL + '  R.CTR_FATREP AS OPE_PERCOM, ';
    If edtOpcao.Text = 'A' Then
      strSQL := strSQL + '  R.CTR_COMREP AS CTR_TOTCOM, '
    Else
    Begin
      strSQL := strSQL + '  SUM(R.CTR_COMREP) AS CTR_TOTCOM, ';
      strSQL := strSQL + '  SUM(R.CTR_VALREC) AS CTR_VLRREC, ';
    End;
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  C.CLI_CODREP AS CLI_CODREP, ';
    strSQL := strSQL + '  P.POR_NOMPOR AS POR_NOMPOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC R, ';
    strSQL := strSQL + '  CADPOR P, ';
    strSQL := strSQL + '  CADOPE O, ';
    strSQL := strSQL + '  CADCLI C ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_CODCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '  POR_CODPOR = CTR_PORBAI AND ';
    strSQL := strSQL + '  CTR_CODVEN = OPE_CODOPE AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NOT NULL AND ';
    strSQL := strSQL + '  CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ';

    If (dtaDtaCor > 0) Then
      strSQL := strSQL + '  AND CTR_DTACAD >= :DTACOR ';

    If (edtDupDesc.Text = 'S') Then
      strSQL := strSQL + '  AND CTR_DESCON = :DESCON ';

    If Not fEmptyStr(edtCodCliente.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCliente, arrClientes, 'CTR_CODCLI', 'CODCLI');

    {****************************}
    {* FILTRO POR REDE DE LOJAS *}
    {*************************DP*}
    If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'CTR_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + ' AND (IFNULL(CTR_PORBAI, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CTR_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTR_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN');

    If Not fEmptyStr(edtCodRep.Text) Then
      strSQL := strSQL + fStrLocate(edtCodRep, arrRepresentante, 'CTR_CODREP', 'CODREP');

    If Not fEmptyStr(edtCodEve.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEve, arrEventos, 'CTR_CODEVE', 'CODEVE');

    If edtOpcao.Text = 'S' Then
      strSQL := strSQL + ' GROUP BY OPE_CODOPE ';

    If edtOpcao.Text = 'A' Then
    Begin
      strSQL := strSQL + ' ORDER BY ';
      strSQL := strSQL + '  OPE_CODOPE, CTR_DTAREC, CTR_NUMDUP, ';
      strSQL := strSQL + '  CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP ';
    End
    Else
      strSQL := strSQL + ' ORDER BY OPE_CODOPE ';

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If (dtaDtaCor > 0) Then
        ParamByName('DTACOR').AsDateTime := dtaDtaCor;

      If (edtDupDesc.Text = 'S') Then
        ParamByName('DESCON').AsString := edtDupDesc.Text;

      If Not fEmptyStr(edtCodCliente.Text) Then
        pSetaParam(edtCodCliente.Text, arrClientes, strCli, 'CODCLI', qryRelatorio);

      {****************************}
      {* FILTRO POR REDE DE LOJAS *}
      {*************************DP*}
      If Not fEmptyStr(edtCodRede.Text) Then
        pSetaParamOR(edtCodRede,arrRede,'CODRED',qryRelatorio);

      If Not fEmptyStr(edtCodPor.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPor, 'CODPOR', qryRelatorio);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmp, 'CODEMP', qryRelatorio);

      If Not fEmptyStr(edtCodEve.Text) Then
        pSetaParam(edtCodEve.Text, arrEventos, strEve, 'CODEVE', qryRelatorio);

      If Not fEmptyStr(edtCodVen.Text) Then
        pSetaParam(edtCodVen.Text, arrVendedor, strVen, 'CODVEN', qryRelatorio);

      If Not fEmptyStr(edtCodRep.Text) Then
        pSetaParam(edtCodRep.Text, arrRepresentante, strRep, 'CODREP', qryRelatorio);

      Open;
    End;

    pSetaClient(qryRelatorio);

    cdsTemp.Open;
    pSetaClient(cdsTemp);

    If edtOpcao.Text = 'A' Then 
      dtsRelatorio.DataSet := cdsTemp
    Else
    Begin
      pPreparaRelSintetico(cdsTemp);
      dtsRelatorio.DataSet := cdsSin;
    End;

    If Not dtsRelatorio.DataSet.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckCtrComVendedor,frmQckCtrComVendedor);

        frmQckCtrComVendedor.dtsRelatorio.DataSet := qryRelatorio;

        If edtOpcao.Text = 'A' Then
        Begin
          frmQckCtrComVendedor.rllNomeRelatorio.Caption := ' RELATORIO DE COMISSAO POR VENDEDOR - ANALITICO';
          frmQckCtrComVendedor.rlbTitulo.Visible        := True;
          frmQckCtrComVendedor.rlbTituloGrupo.Visible   := True;
          frmQckCtrComVendedor.rlbDetalheGrupo.Visible  := True;
          frmQckCtrComVendedor.rlbResumoGrupo.Visible   := True;
          frmQckCtrComVendedor.rlbResumo.Visible        := True;
          frmQckCtrComVendedor.rlbSintetico.Visible     := False;
          frmQckCtrComVendedor.rllTotRec.DataFormula    := 'CTR_VALREC';
        End
        Else
        Begin
          frmQckCtrComVendedor.rllNomeRelatorio.Caption := ' RELATORIO DE COMISSAO POR VENDEDOR - SINTETICO';
          frmQckCtrComVendedor.rlbTituloSint.Visible    := True;
          frmQckCtrComVendedor.rlbDetalhe.Visible       := True;
          frmQckCtrComVendedor.rlbAnalitico.Visible     := False;
          frmQckCtrComVendedor.rlbGrupo.Visible         := False;
        End;


        If strTipImp = 'M' Then
          frmQckCtrComVendedor.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckCtrComVendedor.qckPagina.DefaultFilter := Nil;

        frmQckCtrComVendedor.rllCliente.Caption  := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrClientes, strCli, 'CLIENTE');

        {*****************}
        {* REDE DE LOJAS *}
        {**************DP*}
        frmQckCtrComVendedor.rllRedeLoja.Caption  := fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRed, 'REDE LOJAS');

        frmQckCtrComVendedor.rllPortador.Caption := fStrTitulo(edtCodPor.Text, edtDesPortador, arrPortador, strPor, 'PORTADOR');

        frmQckCtrComVendedor.rllEmpresa.Caption  := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmp, 'EMPRESAS');

        frmQckCtrComVendedor.strOrdem   := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        frmQckCtrComVendedor.rllEventos.Caption := fStrTitulo(edtCodEve.Text, edtDesEve, arrEventos, streVE, 'CENTRO DE CUSTOS');

        frmQckCtrComVendedor.rllVendedor.Caption := fStrTitulo(edtCodVen.Text, edtNomVen, arrVendedor, strvEN, 'VENDEDOR');

        frmQckCtrComVendedor.rllRepresentante.Caption := fStrTitulo(edtCodRep.Text, edtNomRep, arrRepresentante, strRep, 'REPRESENTANTE');

        If edtDupDesc.Text = 'S' Then
          frmQckCtrComVendedor.rllDuplicatas.Caption := 'DUPLICATAS DESCONTADAS: SIM'
        Else
          frmQckCtrComVendedor.rllDuplicatas.Caption := 'DUPLICATAS DESCONTADAS: NÃO';

        If edtDestino.Text = 'V' Then
          frmQckCtrComVendedor.qckPagina.PreviewModal
        Else
          frmQckCtrComVendedor.qckPagina.Print;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckCtrComVendedor);

    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;

  btnImprimir.Enabled := True;

  dtsRelatorio.DataSet := qryRelatorio;
  FreeAndNil(cdsTemp);
  FreeAndNil(dspTemp);
end;

procedure TfrmRelCtrComVendedor.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelCtrComVendedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(cdsSin); 
  inherited;
end;

procedure TfrmRelCtrComVendedor.FormCreate(Sender: TObject);
begin
  inherited;
  qryGenPor := fCriaQuery(Self);
  cdsSin    := TUniClientDataSet.Create(Self);
end;

procedure TfrmRelCtrComVendedor.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtrComVendedor.edtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEve, edtDesEve, arrEventos, fRetNomEvento, Nil, 'do Centro de Custos');
end;

procedure TfrmRelCtrComVendedor.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEventos, False) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrComVendedor.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, arrVendedor, fRetNomVendRep, Nil, 'do Vendedor');
end;

procedure TfrmRelCtrComVendedor.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrVendedor, False) Then  
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrComVendedor.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelCtrComVendedor.edtCodRedeKeyPress(Sender: TObject;
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

procedure TfrmRelCtrComVendedor.edtCodRepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRep, edtNomRep, arrRepresentante, fRetNomVendRep, Nil, 'do Representante');
end;

procedure TfrmRelCtrComVendedor.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodRep, edtNomRep, nil, Key, arrRepresentante, False) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

