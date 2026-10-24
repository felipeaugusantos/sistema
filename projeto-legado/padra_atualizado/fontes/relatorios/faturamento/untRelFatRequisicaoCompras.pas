unit untRelFatRequisicaoCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, Mask, MaskEditFocus,
  untFuncoesSimples, StrUtils, BitBtnLockedIncrem, Uni,
  frxExportCSVTestabilidade;

type
  TfrmRelFatRequisicaoCompras = class(TfrmPaiRelatorio)
    Label2: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label12: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    grbPeridoBaixa: TGroupBox;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label3: TLabel;
    edtCodProduto: TEditFocus;
    edtDesProduto: TEditFocus;
    frxReportCliM: TfrxReport;
    frxReportProM: TfrxReport;
    frxReportCliJ: TfrxReport;
    frxReportResumidoM: TfrxReport;
    rdgOpcaoRel: TRadioGroup;
    frxReportProJ: TfrxReport;
    frxReportResumidoJ: TfrxReport;
    Label14: TLabel;
    edtGruCmp: TEditFocus;
    edtDesCmp: TEditFocus;
    Label4: TLabel;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    shpLiberado: TShape;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtNumDoc: TEditFocus;
    lblNumDoc: TLabel;
    frxPedidoCompraM: TfrxReport;
    frxPedidoCompraJ: TfrxReport;
    rdgAssociados: TRadioGroup;
    frxReportForJ: TfrxReport;
    frxReportForM: TfrxReport;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    function frxReportProJUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure rdgOpcaoRelClick(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
  private
    { Private declarations }
    arrCliente    : TConsultasArray;
    arrVendedor   : TConsultasArray;
    arrProduto    : TConsultasArray;
    arrGrupo      : TConsultasArray;
    arrFornecedor : TConsultasArray;
    arrEmpresa    : TConsultasArray;

    blnLiberado: Boolean;

    strVen,
    strCli,
    strPro,
    strGru,
    strFor,
    strEmp: String;

    strCodVen: String;

    procedure pAbreRelatorio;
    Function fRetSQLRel: String;
    function fTotalComprasPeriodo(strCodIte: String): String;
    function fMargemMarkup(fltPreCus, fltPreVen: Double): Double;

    procedure pSetaUserFunctions(frx: TfrxReport);

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses untModuloSPR, fs_iinterpreter, untCfgRel,untFuncoesConsulta, untConsultas,
  Data.DB, untTFatReservaSaldo;

{$R *.dfm}

procedure TfrmRelFatRequisicaoCompras.edtCodClienteKeyPress(Sender: TObject;
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

procedure TfrmRelFatRequisicaoCompras.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp,edtDesEmp,
                    arrEmpresa,nil,fRetNomeEmpresaSelec,'da Empresa');
end;

procedure TfrmRelFatRequisicaoCompras.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresa) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatRequisicaoCompras.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtDesFor,
                    arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelFatRequisicaoCompras.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFornecedor, False) Then
  Begin
    If fValidaCampos(edtCodFor, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatRequisicaoCompras.edtCodClienteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCliente,edtDesCliente,arrCliente,nil,fRetNomCliente,'do cliente');

end;

procedure TfrmRelFatRequisicaoCompras.edtCodVendedorExit(Sender: TObject);
begin
  inherited;

  If blnLiberado Then
    pEdtCodSelectExit(edtCodVendedor,edtDesVendedor,arrVendedor,fRetNomVendRep,nil,'do Vendedor');
  
end;

procedure TfrmRelFatRequisicaoCompras.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnLiberado) And (fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor, False)) Then
  Begin
    fvalidaCampos(edtCodVendedor,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatRequisicaoCompras.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesCmp, arrGrupo, nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmRelFatRequisicaoCompras.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesCmp, Nil, Key, arrGrupo, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelFatRequisicaoCompras.edtCodProdutoExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodProduto, edtDesProduto, arrProduto, nil, fRetNomProduto, 'do Produto');
  
end;

procedure TfrmRelFatRequisicaoCompras.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodProduto, edtDesProduto, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fvalidaCampos(edtCodProduto,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatRequisicaoCompras.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodProduto);
  pSetaUserFunctions(frxReportProJ);
  pSetaUserFunctions(frxReportProM);
  pSetaUserFunctions(frxReportResumidoM);
  pSetaUserFunctions(frxReportResumidoJ);

  pSetaNumPedCom(edtNumDoc);
end;

function TfrmRelFatRequisicaoCompras.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************LA*}
    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Informe o período!',['&O K']);
        Result := False;
      End;

    End

    {*********************}
    {* VALIDA DATA FINAL *}
    {******************LA}
    Else If (Sender = mskDtaFin) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;

    End

    {******************************}
    {* VALIDA VENDEDOR            *}
    {***************************LA*}
    Else If (Sender = edtCodVendedor) Then
    Begin
      pDesmarcaLista(edtCodVendedor, arrVendedor);

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
      End
      Else
      Begin
        edtDesVendedor.Text := 'TODOS';
        strCodVen := '';
      End;

     // edtCodVendedor.Text := strCodVen;
    End

    Else If (Sender = edtCodProduto) Then
    Begin
      pDesmarcaLista(edtCodProduto, arrProduto);
    End

    Else If (Sender = edtCodCliente) Then
    Begin
      pDesmarcaLista(edtCodCliente, arrCliente);
    End

    Else If (Sender = edtGruCmp) Then
    Begin
      pDesmarcaLista(edtGruCmp, arrGrupo);
    End

    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrFornecedor);
    End
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

Function TfrmRelFatRequisicaoCompras.fRetSQLRel: String;
Begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';

  If rdgOpcaoRel.ItemIndex = 0 Then
  Begin
    Result := Result + '  ITE_LOCFIS AS LOCFIS, ';
    Result := Result + '  CONCAT(FOR_CODFOR, "-", FOR_NOMFOR) AS FORNECEDOR, ';
    Result := Result + '  ITE_CODFAB AS CODFAB, ';
    Result := Result + '  SUM(RCD_QTDITE * ITE_PRECUS) AS PRECUS, ';
    Result := Result + '  RCD_CODITE AS CODITE, ';
    Result := Result + '  IF(LOCATE("ITEM ESPECIAL", ITE_DESITE), RCD_DESITE, ITE_DESITE) AS DESITE, ';
    Result := Result + '  ITE_SALDOS      AS SALDOS, ';
    Result := Result + '  SUM(RCD_QTDITE) AS QTDITE, ';
    Result := Result + '  SUM(RCD_QTDITE * ITE_PREVE1) AS PREVEN, ';
    Result := Result + '  RCG_CODVEN AS CODVEN, ';
    Result := Result + '  OPE_NOMOPE AS NOMVEN ';
  End
  Else If (rdgOpcaoRel.ItemIndex = 3) or (rdgOpcaoRel.ItemIndex = 4) Then
  Begin
    If (rdgOpcaoRel.ItemIndex = 3) Then
    Begin
      Result := Result + '    CONCAT(PCD_NUMPED,"-",PCD_ESPDOC,"-",PCD_CODEMP) AS PEDIDO, ';
      Result := Result + '    CONCAT(PCD_CODEMP,"-",EMP_NOMEMP) AS EMPRESA, ';
    End
    Else
    Begin
      Result := Result + '    CONCAT(PCG_NUMPED,"-",PCG_ESPDOC,"-",PCG_CODEMP) AS PEDIDO, ';
      Result := Result + '    CONCAT(PCG_CODEMP,"-",EMP_NOMEMP) AS EMPRESA, ';
    End;
    Result := Result + '    RCG_CODIGO AS REQUISICAO, ';
    Result := Result + '    CONCAT(RCG_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
    Result := Result + '    RCG_DTACAD, ';
    Result := Result + '    RCG_CODVEN AS CODVEN, ';
    Result := Result + '    OPE_NOMOPE AS NOMVEN, ';
    Result := Result + '    RCD_CODITE, ';
    Result := Result + '    RCD_DESITE, ';
    Result := Result + '    ITE_REFERE, ';
    Result := Result + '    UNI_DESUNI, ';
    Result := Result + '    MAR_DESMAR, ';
    Result := Result + '    ITE_SALDOS, ';
    Result := Result + '    RCD_QTDITE  ';
    Result := Result + '  FROM          ';
    If (rdgOpcaoRel.ItemIndex = 3) Then
    Begin
      Result := Result + '    MOVRCG      ';
      Result := Result + ' INNER JOIN MOVRCD                        ';
      Result := Result + '        ON RCD_CODIGO = RCG_CODIGO AND    ';
      Result := Result + '           RCD_CODEMP = RCG_CODEMP        ';
      Result := Result + ' INNER JOIN PCMDET                        ';
      Result := Result + '        ON RCD_SEQPCD = PCMDET.AUTOINCREM ';
    End
    Else
    Begin
      Result := Result + '    PCMGER      ';
      Result := Result + '    JOIN COTGER ';
      Result := Result + '      ON PCG_NUMCOT = COT_NUMCOT AND    ';
      Result := Result + '         PCG_EMPCOT = COT_CODEMP        ';
      Result := Result + '    JOIN COTITE                         ';
      Result := Result + '      ON COT_SEQGER = COTGER.AUTOINCREM ';
      Result := Result + '    JOIN MOVRCD                         ';
      Result := Result + '      ON RCD_SEQCOT = COTITE.AUTOINCREM ';
      Result := Result + '    JOIN MOVRCG                         ';
      Result := Result + '      ON RCD_CODEMP = RCG_CODEMP AND    ';
      Result := Result + '         RCD_CODIGO = RCG_CODIGO        ';
    End;
    Result := Result + '    JOIN CADEMP                           ';
    Result := Result + '      ON EMP_CODEMP = RCG_CODEMP          ';
  End
  Else
  Begin
    Result := Result + '  ITE_LOCFIS AS LOCFIS, ';
    Result := Result + '  FOR_CODFOR AS CODFOR, ';
    Result := Result + '  FOR_NOMFOR AS NOMFOR, ';
    Result := Result + '  CONCAT(FOR_CODFOR, "-", FOR_NOMFOR) AS FORNECEDOR, ';
    Result := Result + '  ITE_CODFAB AS CODFAB, ';
    Result := Result + '  (RCD_QTDITE * ITE_PRECUS) AS PRECUS, ';
    Result := Result + '  RCG_DTACAD AS DTACAD, ';
    Result := Result + '  RCG_CODVEN AS CODVEN, ';
    Result := Result + '  OPE_NOMOPE AS NOMVEN, ';
    Result := Result + '  RCG_CODCLI AS CODCLI, ';
    Result := Result + '  IF(CON_NOMCON IS NULL, CLI_NOMCLI, CON_NOMCON) AS NOMCLI, ';
    Result := Result + '  RCD_CODITE AS CODITE, ';
    Result := Result + '  IF(LOCATE("ITEM ESPECIAL", ITE_DESITE), RCD_DESITE, ITE_DESITE) AS DESITE, ';
    Result := Result + '  CONCAT(RCD_CODITE, RCD_DESITE) AS ITEM, ';
    Result := Result + '  ITE_REFERE AS REFERE, ';
    Result := Result + '  UNI_SIGUNI AS SIGUNI, ';
    Result := Result + '  MAR_DESMAR AS DESMAR, ';
    Result := Result + '  ITE_SALDOS AS SALDOS, ';
    Result := Result + '  RCD_QTDITE AS QTDITE, ';
    Result := Result + '  (RCD_QTDITE * ITE_PREVE1) AS PREVEN, ';
    Result := Result + '  RCG_CODIGO AS REQUISICAO ';
  End;

  If (rdgOpcaoRel.ItemIndex <> 3) And (rdgOpcaoRel.ItemIndex <> 4) Then
  Begin
    Result := Result + ' FROM ';
    Result := Result + '   MOVRCD ';
    Result := Result + ' INNER JOIN MOVRCG ON                                 ';
    Result := Result + '   RCG_CODIGO = RCD_CODIGO AND                        ';
    Result := Result + '   RCG_CODEMP = RCD_CODEMP                            ';
    Result := Result + ' LEFT JOIN CLICON ON CON_C_P_F_ = RCG_CPFCON          ';
  End;

  Result := Result + ' INNER JOIN CADCLI ON CLI_CODCLI = RCG_CODCLI           ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = RCD_CODITE       ';

  If (rdgOpcaoRel.ItemIndex = 3) Or (rdgOpcaoRel.ItemIndex = 4) Then
  Begin
    Result := Result + '    JOIN ITEGER G                         ';
    Result := Result + '      ON I.ITE_CODITE = G.ITE_CODITE AND  ';
    Result := Result + '         RCD_CODEMP   = G.ITE_CODEMP      ';
  End
  Else
  Begin
    Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND ';
    Result := Result + '                        G.ITE_CODEMP = :CODEMP          ';
  End;

  Result := Result + ' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  Result := Result + ' INNER JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR ';
  Result := Result + ' LEFT JOIN CADOPE ON RCG_CODVEN = OPE_CODOPE ';

  Result := Result + ' WHERE    ';
  Result := Result + '   RCG_DTACAD BETWEEN :DTAINI AND :DTAFIN AND ';
  Result := Result + '   RCG_CODEMP = :CODEMP                       ';

  If (rdgAssociados.ItemIndex = 1) And (rdgOpcaoRel.ItemIndex <> 3) And (rdgOpcaoRel.ItemIndex <> 4) Then
  Begin
    Result := Result + ' AND RCD_SEQPCD IS NULL ';
  End
  Else If (rdgAssociados.ItemIndex = 0) And (rdgOpcaoRel.ItemIndex <> 3) And (rdgOpcaoRel.ItemIndex <> 4) Then
  Begin
    Result := Result + ' AND RCD_SEQPCD IS NOT NULL ';
  End;


  If Not fEmptyStr(edtCodCliente.Text) Then
    Result := Result + fStrLocate(edtCodCliente, arrCliente, 'RCG_CODCLI', 'CODCLI');

  If Not fEmptyStr(edtCodVendedor.Text) Then
    If blnLiberado Then
      Result := Result + fStrLocate(edtCodVendedor, arrVendedor, 'RCG_CODVEN', 'CODVEN')
    Else
      Result := Result + ' AND RCG_CODVEN = ' + QuotedStr(strCodVen);

  If Not fEmptyStr(edtCodProduto.Text) Then
    Result := Result + fStrLocate(edtCodProduto, arrProduto, 'RCD_CODITE', 'CODITE');

  If Not fEmptyStr(edtGruCmp.Text) Then
    Result := Result + fStrLocate(edtGruCmp, arrGrupo, 'ITE_GRUCMP', 'GRUCMP');

  If Not fEmptyStr(edtCodFor.Text) Then
    Result := Result + fStrLocate(edtCodFor, arrFornecedor, 'FOR_CODFOR', 'CODFOR');

  If (edtCodEmp.Enabled) And (Not fEmptyStr(edtCodEmp.Text)) Then
    Result := Result + fStrLocate(edtCodEmp, arrEmpresa, 'RCD_CODEMP', 'CODEMP');

  If edtNumDoc.Enabled And (Not fEmptyStr(edtNumDoc.Text)) Then
  Begin
    If rdgOpcaoRel.ItemIndex = 3 Then
      Result := Result + ' AND PCD_NUMPED = :NUMDOC '
    Else
      Result := Result + ' AND PCG_NUMPED = :NUMDOC ';
  End;

  If rdgOpcaoRel.ItemIndex = 0 Then
    Result := Result + ' GROUP BY RCD_CODITE, RCD_DESITE ';

  Result := Result + ' ORDER BY ';

  Case rdgOpcaoRel.ItemIndex Of
    0, 1: Result := Result + ' ITE_LOCFIS, ITE_DESITE, RCG_DTACAD ';
    2:    Result := Result + ' CLI_NOMCLI, ITE_DESITE, RCG_DTACAD ';
    3, 4: Result := Result + ' PEDIDO, EMPRESA, RCD_DESITE ';
    5:    Result := Result + ' FOR_NOMFOR, ITE_DESITE, RCG_DTACAD ';
  End;
End;

function TfrmRelFatRequisicaoCompras.frxReportProJUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If SameText(MethodName, 'fSaldoReservado') Then
  Begin
    Result := TSaldoReservado.New(
                TReservaParametros.New()
                  .EmpresaItem(VS_strCodEmp)
                  .CodigoItem(Params[0])
                  .CodEmpresa(VS_strCodEmp)
                ).fGetQuantidade();
  End
  Else If SameText(MethodName, 'fTotalCompras') Then
  Begin
    Result := fTotalComprasPeriodo(Params[0]);
  End
  Else IF SameText(MethodName, 'fMargemMarkup') Then
  Begin
    Result := fMargemMarkup(Params[0], Params[1]);
  End;
end;

function TfrmRelFatRequisicaoCompras.fTotalComprasPeriodo(strCodIte: String): String;
  Var
    qryAux: TUniQuery;
    strSQL: String;
begin
  If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    Result := '';
    Exit;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(DET_QTDITE) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_CODITE = :CODITE AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  LOCATE(DET_CLAFIS, :CLAFIS) > 0 ';

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add(strSQL);
  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
  qryAux.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
  qryAux.ParamByName('CLAFIS').AsString := VS_strClaDev + '_' + VS_strClaCom;
  qryAux.Open;

  If qryAux.FieldByName('QTD').AsFloat > 0 Then
    Result := 'SIM: ' + FloatToStrF(qryAux.FieldByName('QTD').AsFloat, ffNumber, 12, 2)
  Else
    Result := 'NAO';

  FreeAndNil(qryAux);
end;

function TfrmRelFatRequisicaoCompras.fMargemMarkup(fltPreCus, fltPreVen: Double): Double;
begin
  Result := fCalculaPrecoVenda(2, fltPreCus,
                                  fltPreVen,
                                  0, 0, 0, 0, 0);
end;

procedure TfrmRelFatRequisicaoCompras.pAbreRelatorio;
  Var
    frxReport: TfrxReport;
Begin
  frxReport := Nil;

  Case rdgOpcaoRel.ItemIndex Of
    0  : frxReport := TfrxReport(IIF(strTipImp = 'M', frxReportResumidoM, frxReportResumidoJ));
    1  : frxReport := TfrxReport(IIF(strTipImp = 'M', frxReportProM, frxReportProJ));
    2  : frxReport := TfrxReport(IIF(strTipImp = 'M', frxReportCliM, frxReportCliJ));
    3,4: frxReport := TfrxReport(IIF(strTipImp = 'M', frxPedidoCompraM, frxPedidoCompraJ));
    5  : frxReport := TfrxReport(IIF(strTipImp = 'M', frxReportForM, frxReportForJ));
  End;

  If SameText(strTipImp, 'J') Then
  Begin
    frxReport.DotMatrixReport           := False;
    frxReport.PrintOptions.PrintMode    := pmScale;
    frxReport.PrintOptions.PrintOnSheet := 9;
  End;
  
  If frxReport.FindObject('mmoZebra') <> Nil Then
    TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

  If frxReport.FindObject('mmoZebra2') <> Nil Then
    TfrxMemoView(frxReport.FindObject('mmoZebra2')).Highlight.Color := fCfgSis('CORZEB');

  If rdgOpcaoRel.ItemIndex = 1 Then
  Begin
    TFrxMemoView(frxReport.FindObject('lblMarMkp')).Memo.Clear;
    TFrxMemoView(frxReport.FindObject('lblMarMkp')).Memo.Add(IIF(Pos(fCfgSis('MARMKP'), '1_5_') > 0, 'MARGEM', 'MARK-UP'));
  End;

  With frxReport, Script Do
  Begin
    PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

    Variables['NOMREL']          := 'RELATORIO DE REQUISICAO DE COMPRAS';
    Variables['PERIODO']         := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
    Variables['EMPRESA']         := 'EMPRESA: ' + IIF(edtCodEmp.Enabled, IIF(fEmptyStr(edtCodEmp.Text), 'EMPRESA: TODAS', edtCodEmp.Text + ' - ' + edtDesEmp.Text), VS_strCodEmp + ' - ' + fRetNomeEmpresa);
    Variables['CLIENTE']         := fStrTitulo(edtCodCliente.Text,edtDesCliente,arrCliente,strCli,'CLIENTE');
    Variables['VENDEDOR']        := fStrTitulo(strCodVen,edtDesVendedor,arrVendedor,strVen,'VENDEDOR');
    Variables['PRODUTO']         := fStrTitulo(edtCodProduto.Text,edtDesProduto,arrProduto,strPro,'PRODUTO');
    Variables['GRUPO DE COMPRA'] := fStrTitulo(edtGruCmp.Text,edtDesCmp,arrGrupo,strGru,'GRUPO DE COMPRA');
    Variables['FORNECEDOR']      := fStrTitulo(edtCodFor.Text,edtDesFor,arrFornecedor,strFor,'FORNECEDOR');
    Variables['STATUS']          := 'ASSOCIADOS A PED. DE COMPRA: ' + AnsiUpperCase(rdgAssociados.Items[rdgAssociados.ItemIndex]);

    If (rdgOpcaoRel.ItemIndex = 3) Or (rdgOpcaoRel.ItemIndex = 4) Then
    Begin
      Variables['EMPRESA'] := fStrTitulo(edtCodEmp.Text,edtDesEmp,arrEmpresa,strEmp,'EMPRESA');
      Variables['PEDIDO']  := IIF(fEmptyStr(edtNumDoc.Text), 'TODOS OS PEDIDOS', 'PEDIDO: ' + edtNumDoc.Text);
    End;

    Case rdgOpcaoRel.ItemIndex Of
      1: Variables['ORDEM'] := 'ORDENADO POR PRODUTO';
      2: Variables['ORDEM'] := 'ORDENADO POR CLIENTE';
      3,4: Variables['ORDEM'] := 'ORDENADO POR PEDIDO DE COMPRA';
      5: Variables['ORDEM'] := 'ORDENADO POR FORNECEDOR';
    End;

    If edtDestino.Text = 'V' Then
      pPreviewReport(Self.Name, Self.Caption, frxReport)
    Else
      If PrepareReport Then
        pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);
  End;

End;

procedure TfrmRelFatRequisicaoCompras.pSetaUserFunctions(frx: TfrxReport);
begin
  frx.AddFunction('function fTotalCompras(strCodIte: String): String');
  frx.AddFunction('function fSaldoReservado(strCodIte: String): Double');
  frx.AddFunction('function fMargemMarkup(fltPreCus, fltPreVen: Double): Double');
end;

procedure TfrmRelFatRequisicaoCompras.rdgOpcaoRelClick(Sender: TObject);
begin
  inherited;

  lblEmpresa.Enabled := (rdgOpcaoRel.ItemIndex = 3) Or (rdgOpcaoRel.ItemIndex = 4);
  lblNumDoc.Enabled  := (rdgOpcaoRel.ItemIndex = 3) Or (rdgOpcaoRel.ItemIndex = 4);
  edtCodEmp.Enabled  := (rdgOpcaoRel.ItemIndex = 3) Or (rdgOpcaoRel.ItemIndex = 4);
  edtNumDoc.Enabled  := (rdgOpcaoRel.ItemIndex = 3) Or (rdgOpcaoRel.ItemIndex = 4);
  edtCodEmp.Text     := IIF(((rdgOpcaoRel.ItemIndex = 3) Or (rdgOpcaoRel.ItemIndex = 4)), edtCodEmp.Text, '');
  edtDesEmp.Text     := IIF(((rdgOpcaoRel.ItemIndex = 3) Or (rdgOpcaoRel.ItemIndex = 4)), edtDesEmp.Text, '');
  edtNumDoc.Text     := IIF(((rdgOpcaoRel.ItemIndex = 3) Or (rdgOpcaoRel.ItemIndex = 4)), edtNumDoc.Text, '');

  If (rdgOpcaoRel.ItemIndex = 3) Or (rdgOpcaoRel.ItemIndex = 4) Then
  Begin
    rdgAssociados.ItemIndex := 2;
    rdgAssociados.Enabled := False;
  End
  Else
    rdgAssociados.Enabled := True;

end;

procedure TfrmRelFatRequisicaoCompras.btnImprimirClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodVendedor.Text) And (Not blnLiberado) Then
  Begin
    blnImprime := False;
    fMensagem('', 'Informe a senha para o Vendedor!', ['&Ok']);
  End;  

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  If blnImprime Then
  Begin


    With frmModuloSPR.qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQLRel);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      End;

      pSetaParam(edtCodCliente.Text,  arrCliente,    strCli, 'CODCLI', frmModuloSPR.qryRelatorio);

      If blnLiberado Then
        pSetaParam(strCodVen,           arrVendedor,   strVen, 'CODVEN', frmModuloSPR.qryRelatorio);

      pSetaParam(edtCodProduto.Text,  arrProduto,    strPro, 'CODITE', frmModuloSPR.qryRelatorio);
      pSetaParam(edtGruCmp.Text,      arrGrupo,      strGru, 'GRUCMP', frmModuloSPR.qryRelatorio);
      pSetaParam(edtCodFor.Text,      arrFornecedor, strFor, 'CODFOR', frmModuloSPR.qryRelatorio);

      If (edtCodEmp.Enabled) And (Not fEmptyStr(edtCodEmp.Text)) Then
        pSetaParam(edtCodEmp.Text,    arrEmpresa,  strEmp, 'CODEMP', frmModuloSPR.qryRelatorio)
      Else
        ParamByName('CODEMP').AsString := VS_strCodEmp;

      If (edtNumDoc.Enabled) And (Not fEmptyStr(edtNumDoc.Text)) Then
        ParamByName('NUMDOC').AsString := edtNumDoc.Text;

      Open;
    End;

    If Not frmModuloSPR.qryRelatorio.IsEmpty Then
    Begin
      Try

        pAbreRelatorio;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmRelFatRequisicaoCompras.btnImprimirClick]');
        End;
      End;

    End
    Else
    Begin
      pTabelaVazia;
    End;

    pSetFocus(edtCodCliente);
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

end;

procedure TfrmRelFatRequisicaoCompras.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If ActiveControl Is TRadioButton Then
    Case Key Of
      VK_RETURN: self.SelectNext(ActiveControl, True, True);
      VK_ESCAPE: Close;
    End;
    
end;

procedure TfrmRelFatRequisicaoCompras.FormShow(Sender: TObject);
begin
  inherited;

  blnLiberado := fVerificaAcessoSistema('RFVDRCO');

  If (Not blnLiberado) Then
  Begin
    edtCodVendedor.MaxLength := 10;
    edtCodVendedor.TamCampo  := 10;
    edtCodVendedor.CompZeros := False;
    edtCodVendedor.PasswordChar := '*';
    edtCodVendedor.TipoTexto := ttAlfanumerico;
    shpLiberado.Brush.Color  := clRed;
  End
  Else
  Begin
    shpLiberado.Brush.Color  := clGreen;
  End;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', fNow());
  mskDtaFin.Text := mskDtaIni.Text;
end;

end.
