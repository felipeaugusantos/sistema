unit untRelEstatAbcCredito;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, Menus, RLFilters, RLDraftFilter,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus,
  DBCtrls, DBEditFocus, ComCtrls, StrUtils, ComObj, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, Uni, AppEvnts, untTypesSistema,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelEstatAbcCredito = class(TfrmPaiRelatorio)
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label7: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label8: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    edtCodVendedor: TEditFocus;
    Label14: TLabel;
    edtCodRepresentante: TEditFocus;
    Label40: TLabel;
    edtCodAti: TEditFocus;
    edtQtdCli: TEditFocus;
    Label1: TLabel;
    edtDesVendedor: TEditFocus;
    edtDesRepresentante: TEditFocus;
    edtAtividade: TEditFocus;
    svdExcel: TSaveDialog;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtDesCli: TEditFocus;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    gpbTipo: TGroupBox;
    lblQbrDentro1: TColorLabel;
    edtTipo: TEditFocus;
    gpbFiltro: TGroupBox;
    lblFiltro: TColorLabel;
    edtFiltro: TEditFocus;
    gpbOrdem: TGroupBox;
    lbl1: TColorLabel;
    edtOrdem: TEditFocus;
    Label11: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    Label2: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepresentanteExit(Sender: TObject);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtTipoExit(Sender: TObject);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
  private
    { Private declarations }
    fltSoma: Double;
    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;
    procedure pGeraExcelAbcCredito;
  public
    { Public declarations }

    arrVen,
    arrRep,
    arrCli,
    arrRede,
    arrAti,
    arrEmp,
    arrPor : TConsultasArray;

    strVen,
    strRep,
    strCli,
    strRede,
    strAti,
    strEmp,
    strPor : String;

  protected

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelEstatAbcCredito: TfrmRelEstatAbcCredito;

implementation

uses DB, untQckEstatAbcCredito, untExcel,
  untFuncoesFactory, untIFuncoes, untClassPanelCx;

{$R *.dfm}

procedure TfrmRelEstatAbcCredito.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrVen, fRetNomVendRep, Nil, 'do Vendedor');
end;

procedure TfrmRelEstatAbcCredito.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVen, False) Then
  Begin
    If fValidaCampos(edtCodVendedor,False) Then
      SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmRelEstatAbcCredito.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede, edtDesRede, arrRede, nil, fRetNomeRedeLoja, 'da rede');
end;

procedure TfrmRelEstatAbcCredito.edtCodRedeKeyPress(Sender: TObject;
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

procedure TfrmRelEstatAbcCredito.edtCodRepresentanteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRepresentante, edtDesRepresentante, arrRep, fRetNomVendRep, Nil, 'do Representante');
end;

procedure TfrmRelEstatAbcCredito.edtCodRepresentanteKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodRepresentante, edtDesRepresentante, nil, Key, arrRep, False) Then
  Begin
    If fValidaCampos(edtCodRepresentante,False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcCredito.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtAtividade, arrAti, nil, fRetNomAtividade,  'da Atividade');
end;

procedure TfrmRelEstatAbcCredito.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtAtividade, Nil, Key, arrAti, False) Then
  Begin
    If fValidaCampos(edtCodAti, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcCredito.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstatAbcCredito.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodEmpresa.Text    := VS_strCodEmp;
  edtDesEmpresa.Text    := fRetNomeEmpresa;

  shpMultSel.Visible := True;
end;

procedure TfrmRelEstatAbcCredito.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstatAbcCredito.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresaExit(Sender);

  inherited;
end;

function TfrmRelEstatAbcCredito.fValidaCampos(Sender: TWinControl;
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

    Else If (Sender = edtCodCli) Then
    Begin
      pDesmarcaLista(edtCodCli,arrCli);
    End

    Else If (Sender = edtCodRede) Then
    Begin
      pDesmarcaLista(edtCodRede,arrRede);
    End

    Else If (Sender = edtCodPor) Then
    Begin
      {*REQ*145940**********RP*}
      If Not fEmptyStr(edtCodEmpresa.Text) And Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End;

      pDesmarcaLista(edtCodPor,arrPor);
    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      pDesmarcaLista(edtCodEmpresa,arrEmp);
    End
    Else If (Sender = edtQtdCli) Then
    Begin

      If StrToInt(edtQtdCli.Text) < 1 Then
      Begin
        fMensagem('ATENÇÃO!','A quantidade de clientes a ser impressos deve ser maior ou igual a 1!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodAti) Then
    Begin
      pDesmarcaLista(edtCodAti, arrAti);
    End

    Else If (Sender = edtCodVendedor) Then
    Begin
      pDesmarcaLista(edtCodVendedor,arrVen);
    End

    Else If (Sender = edtCodRepresentante) Then
    Begin
      pDesmarcaLista(edtCodRepresentante,arrRep);
    End

    Else If (Sender = edtFiltro) Then
    Begin

      If Pos(edtFiltro.Text,'A_V_T_') <= 0 Then
      Begin
        fMensagem('','O campo Títulos em Aberto deve ser A, V ou T!',['&O K'],0);
        Result := False;
      End;

    End
    Else If (Sender = edtOrdem) Then
    Begin

      If Pos(edtOrdem.Text,'V_M_') <= 0 Then
      Begin
        fMensagem('','O campo Ordem deve ser V ou M!',['&O K'],0);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelEstatAbcCredito.btnImprimirClick(Sender: TObject);
  Var
    strSQL   : String;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;
  If blnImprime Then
  Begin

    Try
      {********************************}
      {* VAI COMEÇA UM SELECT MONSTRO *}
      {*****************************AF*}
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
      strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
      strSQL := strSQL + '  CLI_LIMCRE AS LIMCRE, ';
      strSQL := strSQL + '  CTR_VALDUP AS TOTDUP, ';
      strSQL := strSQL + '  DATEDIFF(' + fCurrentDate + ', CTR_DTAVEN) AS DIAATR  ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI, ';
      strSQL := strSQL + '  CADREC  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_CODCLI = CLI_CODCLI    AND ';
      strSQL := strSQL + '  CTR_DTAREC IS NULL         AND ';
      strSQL := strSQL + '  CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

      If edtTipo.Text = 'F' Then
        strSQL := strSQL + '  AND CLI_CGCCPF = "2" '
      Else If edtTipo.Text = 'J' Then
        strSQL := strSQL + '  AND CLI_CGCCPF = "1" ';

      If edtFiltro.Text = 'A' Then
        strSQL := strSQL + '  AND DATEDIFF(' + fCurrentDate + ', CTR_DTAVEN) > 0 '
      Else If edtFiltro.Text = 'V' Then
        strSQL := strSQL + '  AND DATEDIFF(' + fCurrentDate + ', CTR_DTAVEN) <= 0 ';

      If Not fEmptyStr(edtCodVendedor.Text) Then
        strSQL := strSQL + fStrLocate(edtCodVendedor, arrVen, 'CTR_CODVEN', 'CODVEN');

      If Not fEmptyStr(edtCodRepresentante.Text) Then
        strSQL := strSQL + fStrLocate(edtCodRepresentante, arrRep, 'CTR_CODREP', 'CODREP');

      If Not fEmptyStr(edtCodCli.Text) Then
        strSQL := strSQL + fStrLocate(edtCodCli, arrCli, 'CTR_CODCLI', 'CODCLI');

      If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede, arrRede, 'CLI_CODRED', 'CODRED');

      If Not fEmptyStr(edtCodPor.Text) Then
        strSQL := strSQL + fStrLocate(edtCodPor, arrPor, 'CTR_CODPOR', 'CODPOR');

      If Not fEmptyStr(edtCodAti.Text) Then
        strSQL := strSQL + fStrLocate(edtCodAti, arrAti, 'CLI_CODATI', 'CODATI');

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'CTR_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + ' AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      strSQL := ' SELECT SQL_NO_CACHE ' +
                '   CODCLI, '           +
                '   NOMCLI, '           +
                '   LIMCRE, '           +
                '   SUM(TOTDUP) AS VALDUP, ' +
                '   SUM(IF(DIAATR>0,DIAATR,0)) / ' +
                '   IF(COUNT(DIAATR)>0,COUNT(DIAATR),1) AS MEDATR  ' +
                ' FROM ' +
                '   (' + strSQL + ') T ' +
                ' GROUP BY ' +
                '   CODCLI ' +
                ' ORDER BY ' +
                '   ' + IfThen(edtOrdem.Text = 'V', '  VALDUP DESC ', '  MEDATR DESC ') +
                ' LIMIT ' + edtQtdCli.Text;

      With qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        If Not fEmptyStr(edtCodRepresentante.Text) Then
          pSetaParam(edtCodRepresentante.Text, arrRep, strRep, 'CODREP', qryRelatorio);

        If Not fEmptyStr(edtCodVendedor.Text) Then
          pSetaParam(edtCodVendedor.Text, arrVen, strVen, 'CODVEN', qryRelatorio);

        If Not fEmptyStr(edtCodCli.Text) Then
          pSetaParam(edtCodCli.Text, arrCli, strCli, 'CODCLI', qryRelatorio);

        If Not fEmptyStr(edtCodRede.Text) Then
          pSetaParamOR(edtCodRede, arrRede, 'CODRED', qryRelatorio);

        If Not fEmptyStr(edtCodPor.Text) Then
          pSetaParam(edtCodPor.Text, arrPor, strPor, 'CODPOR', qryRelatorio);

        If Not fEmptyStr(edtCodAti.Text) Then
          pSetaParam(edtCodAti.Text, arrAti, strAti, 'CODATI', qryRelatorio);

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          pSetaParam(edtCodEmpresa.Text, arrEmp, strEmp, 'CODEMP', qryRelatorio);

        Open;

        fltSoma := 0;

        First;
        While Not Eof Do
        Begin
          If edtOrdem.Text = 'V' Then
            fltSoma := fltSoma + FieldByName('VALDUP').AsFloat
          Else fltSoma := fltSoma + FieldByName('MEDATR').AsFloat;

          Next;
        End;
        First;
      End;

    Except
      on E:Exception do
        ShowMessage(E.Message);
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin

      If (edtDestino.Text = 'E') Then
        pGeraExcelAbcCredito
      Else
      Begin
        Try
          pCriarFormularios(TfrmQckEstatAbcCredito, frmQckEstatAbcCredito);

          frmQckEstatAbcCredito.dtsRelatorio.DataSet := qryRelatorio;

          frmQckEstatAbcCredito.fltSoma := fltSoma;
          frmQckEstatAbcCredito.strOrdSel := edtOrdem.Text;

          If strTipImp = 'M' Then
            frmQckEstatAbcCredito.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckEstatAbcCredito.qckPagina.DefaultFilter := Nil;

          frmQckEstatAbcCredito.strOrdem   := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          If (fEmptyStr(edtCodEmpresa.Text)) Then
            frmQckEstatAbcCredito.rllEmpresa.Caption := 'EMPRESA: TODAS '
          Else
            frmQckEstatAbcCredito.rllEmpresa.Caption := fStrTitulo(edtCodEmpresa.Text,edtDesEmpresa,arrEmp,strEmp,'EMPRESA');

          If Not fEmptyStr(edtCodRepresentante.Text) Then
            frmQckEstatAbcCredito.rllRepresentante.Caption := fStrTitulo(edtCodRepresentante.Text,edtDesRepresentante,arrRep,strRep,'REPRESENTANTE')
          Else
            frmQckEstatAbcCredito.rllRepresentante.Caption := 'REPRESENTANTE: TODOS';

          If Not fEmptyStr(edtCodVendedor.Text) Then
            frmQckEstatAbcCredito.rllVendedor.Caption := fStrTitulo(edtCodVendedor.Text, edtDesVendedor, arrVen, strVen, 'VENDEDOR')
          Else
            frmQckEstatAbcCredito.rllVendedor.Caption := 'VENDEDOR: TODOS';

          If Not fEmptyStr(edtCodCli.Text) Then
            frmQckEstatAbcCredito.rllCliente.Caption := fStrTitulo(edtCodCli.Text, edtDesCli, arrCli, strCli, 'CLIENTE')
          Else
            frmQckEstatAbcCredito.rllCliente.Caption := 'CLIENTE: TODOS';

          {*****************************************}
          {* ACRESCENTOU FILTRO POR REDE DE LOJAS  *}
          {**************************************DP*}
          If Not fEmptyStr(edtCodRede.Text) Then
            frmQckEstatAbcCredito.rllRedeLoja.Caption := fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS')
          Else
            frmQckEstatAbcCredito.rllRedeLoja.Caption := 'REDE DE LOJAS: TODAS';

          If Not fEmptyStr(edtCodPor.Text) Then
            frmQckEstatAbcCredito.rllPortador.Caption := fStrTitulo(edtCodPor.Text, edtNomPor, arrPor, strPor, 'PORTADOR')
          Else
            frmQckEstatAbcCredito.rllPortador.Caption := 'PORTADOR: TODOS';

          If Not fEmptyStr(edtCodAti.Text) Then
            frmQckEstatAbcCredito.rllAtividade.Caption := fStrTitulo(edtCodAti.Text, edtAtividade, arrAti, strAti, 'ATIVIDADE')
          Else
            frmQckEstatAbcCredito.rllAtividade.Caption := 'ATIVIDADE: TODOS';

          If edtTipo.Text = 'F' Then
            frmQckEstatAbcCredito.rllTipoPessoa.Caption := 'TIPO DE PESSOA: FÍSICA'
          Else If edtTipo.Text = 'J' Then
            frmQckEstatAbcCredito.rllTipoPessoa.Caption := 'TIPO DE PESSOA: JURÍDICA'
          Else
            frmQckEstatAbcCredito.rllTipoPessoa.Caption := 'TIPO DE PESSOA: TODOS';

          If edtOrdem.Text = 'V' Then
            frmQckEstatAbcCredito.rllOrdSel.Caption := 'ORDENADO POR: VALOR EM ABERTO'
          Else
            frmQckEstatAbcCredito.rllOrdSel.Caption := 'ORDENADO POR: MEDIA DE DIAS EM ATRASO';

          If edtFiltro.Text = 'A' Then
            frmQckEstatAbcCredito.rllFiltro.Caption := 'TITULOS EM ABERTO: ATRASADOS'
          Else If edtFiltro.Text = 'V' Then
            frmQckEstatAbcCredito.rllFiltro.Caption := 'TITULOS EM ABERTO: A VENCER'
          Else
            frmQckEstatAbcCredito.rllFiltro.Caption := 'TITULOS EM ABERTO: TODOS';

          frmQckEstatAbcCredito.rllNomeRelatorio.Caption := 'RELATORIO DE CURVA ABC DE CREDITO - QTD. CLIENTES: ' + edtQtdCli.Text;

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frmQckEstatAbcCredito.qckPagina, frmQckEstatAbcCredito.rpsSetup)
          Else
            pPrintReport(Self.Name, Self.Caption, strNomImp, frmQckEstatAbcCredito.qckPagina);

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TfrmRelEstatAbcClientes.btnImprimirClick]');
          End;
        End;

        pFreeAndNil(frmQckEstatAbcCredito);

      End;

    End
    Else
      pTabelaVazia;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

end;

procedure TfrmRelEstatAbcCredito.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelEstatAbcCredito.pGeraExcelAbcCredito;
  Var
    objExcel: TExcel;

    fltTotCtr: Double;
    fltTotMed: Double;
    fltAcuRep: Double;
begin

  fltTotCtr := 0.0;
  fltTotMed := 0.0;
  fltAcuRep := 0.0;

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
    Escrever(ProximaLinha, 01, 'RELATORIO DE CURVA ABC DE CREDITO - QTD. CLIENTES: ' + edtQtdCli.Text);

    ProximaLinha;

    {*******************************************}
    {* OUTROS DADOS DO RELATÓRIO               *}
    {****************************************MV*}
    If Not fEmptyStr(edtCodVendedor.Text) Then
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodVendedor.Text, edtDesVendedor, arrVen, strVen, 'VENDEDOR'))
    Else
      Escrever(ProximaLinha, 01, 'VENDEDOR: TODOS');

    If Not fEmptyStr(edtCodRepresentante.Text) Then
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodRepresentante.Text,edtDesRepresentante,arrRep,strRep,'REPRESENTANTE'))
    Else
      Escrever(ProximaLinha, 01, 'REPRESENTANTE: TODOS');

    If Not fEmptyStr(edtCodCli.Text) Then
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodCli.Text, edtDesCli, arrCli, strCli, 'CLIENTE'))
    Else
      Escrever(ProximaLinha, 01, 'CLIENTE: TODOS');

    If Not fEmptyStr(edtCodRede.Text) Then
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS'))
    Else
      Escrever(ProximaLinha, 01, 'REDE DE LOJAS: TODAS');

    If Not fEmptyStr(edtCodPor.Text) Then
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodPor.Text, edtNomPor, arrPor, strPor, 'PORTADOR'))
    Else
      Escrever(ProximaLinha, 01, 'PORTADOR: TODOS');

    If Not fEmptyStr(edtCodAti.Text) Then
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodAti.Text, edtAtividade, arrAti, strAti, 'ATIVIDADE'))
    Else
      Escrever(ProximaLinha, 01, 'ATIVIDADE: TODOS');

    If (fEmptyStr(edtCodEmpresa.Text)) Then
      Escrever(ProximaLinha, 01, 'EMPRESA: TODAS ')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodEmpresa.Text,edtDesEmpresa,arrEmp,strEmp,'EMPRESA'));

    If edtOrdem.Text = 'V' Then
      Escrever(ProximaLinha, 01, 'ORDENADO POR: VALOR EM ABERTO')
    Else
      Escrever(ProximaLinha, 01, 'ORDENADO POR: MEDIA DE DIAS EM ATRASO');

    If edtFiltro.Text = 'A' Then
      Escrever(ProximaLinha, 01, 'TITULOS EM ABERTO: ATRASADOS')
    Else If edtFiltro.Text = 'V' Then
      Escrever(ProximaLinha, 01, 'TITULOS EM ABERTO: A VENCER')
    Else
      Escrever(ProximaLinha, 01, 'TITULOS EM ABERTO: TODOS');

    Escrever(ProximaLinha, 01, 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

    {********************************}
    {* COLOCA EM NEGRITO E ALINHA   *}
    {* AO CENTRO DA CELULA          *}
    {*****************************MV*}
    Mesclar('A1','G1');
    Mesclar('A2','G2');
    Mesclar('A3','G3');
    Alinhamento('A1','G3', Centro);
    Negrito('A1','G3', True);

    Mesclar('A4','G4');
    Mesclar('A5','G5');
    Mesclar('A6','G6');
    Mesclar('A7','G7');
    Mesclar('A8','G8');
    Mesclar('A9','G9');
    Mesclar('A10','G10');
    Mesclar('A11','G11');
    Mesclar('A12','G12');
    Mesclar('A13','G13');
    Mesclar('A14','G14');

    Alinhamento('A4','G14', Centro);

    Negrito('A4','G14', True);

    ProximaLinha;

    {*******************************************}
    {* COLUNAS                                 *}
    {****************************************MV*}
    Escrever(LinhaAtual, 01, 'CODIGO');
    Escrever(LinhaAtual, 02, 'NOME DO CLIENTE');
    Escrever(LinhaAtual, 03, 'CTR ABERTO');
    Escrever(LinhaAtual, 04, 'MEDIA ATR');
    Escrever(LinhaAtual, 05, 'LIM.CREDITO');
    Escrever(LinhaAtual, 06, '% REP.');
    Escrever(LinhaAtual, 07, '% ACUM.');

    {*******************************************}
    {* COLOCA NEGRITO NAS COLUNAS              *}
    {****************************************MV*}
    Negrito('A' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual), True);

    {*************************************}
    {* COLORI O FUNDO DA CELULA P/ CINZA *}
    {**********************************MV*}
    CorFundo('A2','G3', Cinza);
    CorFundo('A' + IntToStr(LinhaAtual),'G' + IntToStr(LinhaAtual), Cinza);

    {********************************}
    {* INSERE BORDAS NA CELULA      *}
    {*****************************MV*}
    Bordas('A2','G3');
    Bordas('A5','G' + IntToStr(LinhaAtual));

    With qryRelatorio Do
    Begin
      First;
      ProximaLinha;

      While (Not Eof) Do
      Begin

        Escrever(LinhaAtual, 01, '''' + fStrZero(FieldByName('CODCLI').AsString, 8));
        Escrever(LinhaAtual, 02, FieldByName('NOMCLI').AsString);
        Escrever(LinhaAtual, 03, FloatToStrF(FieldByName('VALDUP').AsFloat, ffFixed, 12, 2));
        Escrever(LinhaAtual, 04, FloatToStrF(FieldByName('MEDATR').AsFloat, ffFixed, 12, 2));
        Escrever(LinhaAtual, 05, FloatToStrF(FieldByName('LIMCRE').AsFloat, ffFixed, 12, 2));

        If edtOrdem.Text = 'V' Then
        Begin
          Escrever(LinhaAtual, 06, FloatToStrF((FieldByName('VALDUP').AsFloat/fltSoma)*100, ffFixed, 12, 2));
          fltAcuRep := fltAcuRep + ((FieldByName('VALDUP').AsFloat / fltSoma) * 100);
        End
        Else
        Begin
          Escrever(LinhaAtual, 06, FloatToStrF((FieldByName('MEDATR').AsFloat/fltSoma)*100, ffFixed, 12, 2));
          fltAcuRep := fltAcuRep + ((FieldByName('MEDATR').AsFloat / fltSoma) * 100);
        End;
        Escrever(LinhaAtual, 07, FloatToStrF(fltAcuRep, ffFixed, 12, 2));

        Bordas('A' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
        Alinhamento('C' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual), Direita);

        fltTotCtr := fltTotCtr + FieldByName('VALDUP').AsFloat;
        fltTotMed := fltTotMed + FieldByName('MEDATR').AsFloat;

        ProximaLinha;

        Next;
      End;

      Escrever(LinhaAtual, 02, 'TOTAL:');
      Escrever(LinhaAtual, 03, FloatToStrF(fltTotCtr, ffFixed, 12, 2));
      Escrever(LinhaAtual, 04, FloatToStrF(fltTotMed, ffFixed, 12, 2));

      Bordas('A' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
      Alinhamento('B' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual), Direita);

      Negrito(LinhaAtual, 02, True);

    End;

    CongelarPaines('A16');
    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

    fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
  End;

  FreeAndNil(objExcel);

end;

procedure TfrmRelEstatAbcCredito.edtDestinoExit(Sender: TObject);
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

procedure TfrmRelEstatAbcCredito.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmp,nil,fRetNomeEmpresaSelec,'da Empresa');

  {  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;}
end;

procedure TfrmRelEstatAbcCredito.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa,False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcCredito.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor,edtNomPor,arrPor,nil,fRetNomPortador,'do Portador');
end;

procedure TfrmRelEstatAbcCredito.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE PORTADOR   *}
  {****************************RV*}
  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, nil, Key, arrPor, False) Then
  Begin
    If (fValidaCampos(edtCodPor, True)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcCredito.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCli, nil, fRetNomCliente, 'do Cliente');

  If edtCodCli.Text <> '' Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede, edtDesRede, arrRede, nil, fRetNomeRedeLoja, 'da rede');
    pSetFocus(edtTipo);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;

end;

procedure TfrmRelEstatAbcCredito.edtCodCliKeyPress(Sender: TObject;
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

procedure TfrmRelEstatAbcCredito.edtTipoExit(Sender: TObject);
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


