unit untRelPedItensRepresent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelPedItensRepresent = class(TfrmPaiRelatorio)
    Label12: TLabel;
    Label11: TLabel;
    lblDtaIni: TLabel;
    lblDtaFin: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label2: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label1: TLabel;
    edtCodPedido: TEditFocus;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label3: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPedidoExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;
    function fPedidoExiste(strNumPed: String): Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public
    { Public declarations }

  end;

var
  frmRelPedItensRepresent: TfrmRelPedItensRepresent;

implementation

uses untFuncoesFactory, untTypesSistema, untIFuncoes,
     DB, untQckPedItensRepresent, untClassPanelcx;

{$R *.dfm}

procedure TfrmRelPedItensRepresent.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPedItensRepresent.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtFornecedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtFornecedor.Clear;
    pSetFocus(edtFornecedor);
  End;
end;

procedure TfrmRelPedItensRepresent.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  if fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrSel) then  
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPedItensRepresent.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelPedItensRepresent.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);


  If fEmptyStr(edtDesGrupo.Text) And (Not fEmptyStr(mskLinhaGrupo.Text))  Then
  Begin
    fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
    mskLinhaGrupo.Clear;
    pSetFocus(mskLinhaGrupo);
  End;

end;

procedure TfrmRelPedItensRepresent.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    //stlIndicePro: TStringList;
    //stlDesIndPro: TStringList;
    //stlCamposPro: TStringList;
    qryGenIte   : TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;

  qryGenIte := fCriaQuery(nil);

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryGenIte);

end;

procedure TfrmRelPedItensRepresent.edtProdutosExit(Sender: TObject);
begin
  If fEmptyStr(edtProdutos.Text) Then
    edtDesProduto.Text := 'TODOS'
  Else
    edtDesProduto.Text := fRetNomProduto(edtProdutos.Text);

  If fEmptyStr(edtDesProduto.Text) And (Not fEmptyStr(edtProdutos.Text))  Then
  Begin
    fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End;
end;

procedure TfrmRelPedItensRepresent.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPedItensRepresent.edtCodClienteExit(Sender: TObject);
begin
  inherited;

   If fEmptyStr(edtCodCliente.Text) Then
    edtDesCliente.Text := 'TODOS '
  Else
    edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);


  If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCodCliente.Text)) Then
  Begin
    fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
    edtCodCliente.Clear;
    pSetFocus(edtCodCliente);
  End;
end;

procedure TfrmRelPedItensRepresent.edtCodPedidoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    //strSQL: String;
    qryFatGor : TUniQuery;
    arrSel    : TConsultasArray;

begin
  inherited;

  qryFatGor := fCriaQuery;

  If fPesqPedOrc(conPedCompleta, Self, 'PD', 'PD', VS_strCodEmp, edtCodPedido, nil, nil, qryFatGor, Key, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryFatGor);

end;

function TfrmRelPedItensRepresent.fPedidoExiste(
  strNumPed: String): Boolean;
  Var
    strSQL   : String;
    qryGenGor: TUniQuery;

begin
  Try

    qryGenGor := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATGOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FGO_ESPDOC = "PD" AND ';
    strSQL := strSQL + '  FGO_CODEMP = :CODEMP ';

    With qryGenGor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumPed;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := (FieldByName('QTD').AsInteger > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryGenGor);
  End;

end;

procedure TfrmRelPedItensRepresent.edtCodPedidoExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtCodPedido.Text))     And
     (Not fPedidoExiste(edtCodPedido.Text)) Then
  Begin
    fMensagem('', 'Esse pedido não está cadastrado!', ['&Ok']);
    pSetFocus(edtCodPedido);
  End;
end;

procedure TfrmRelPedItensRepresent.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;

  If blnImprime Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  G.FGO_DTAENT AS DTAENT, ';
    strSQL := strSQL + '  G.FGO_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '  G.FGO_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  F.FOR_NOMFOR AS NOMFOR, ';
    strSQL := strSQL + '  R.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  R.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  R.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  R.ITE_UNIDAD AS UNIDAD, ';
    strSQL := strSQL + '  R.ITE_QTDITE AS QTDITE, ';
    strSQL := strSQL + '  R.ITE_UNITAR AS UNITAR, ';
    strSQL := strSQL + '  R.ITE_TOTITE AS TOTITE, ';
    strSQL := strSQL + '  G.FGO_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  CONCAT(C.CLI_CODCLI, "-", C.CLI_NOMCLI) AS NOMCLI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATGOR G ';
    strSQL := strSQL + '  JOIN ITEREP R ON R.ITE_NUMDOC = G.FGO_NUMDOC AND R.ITE_ESPDOC = G.FGO_ESPDOC AND R.ITE_CODEMP = G.FGO_CODEMP ';
    strSQL := strSQL + '  JOIN CADITE I ON I.ITE_CODITE = R.ITE_CODITE  ';
    strSQL := strSQL + '  JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';
    strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = G.FGO_CODCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  G.FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQl := strSQl + '  G.FGO_ESPDOC = "PD" AND ';
    strSQL := strSQL + '  G.FGO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  G.FGO_JAFATU = 0 ';

    If (Not fEmptyStr(edtCodPedido.Text)) Then
      strSQL := strSQL + '  AND G.FGO_NUMDOC = :NUMPED ';

    If (Not fEmptyStr(edtCodCliente.Text)) Then
      strSQL := strSQL + '  AND G.FGO_CODCLI = :CODCLI ';

    If (Not fEmptyStr(edtFornecedor.Text)) Then
      strSQL := strSQL + '  AND F.FOR_CODFOR = :CODFOR ';

    If (Not fEmptyStr(mskLinhaGrupo.Text)) Then
      If (RightStr(mskLinhaGrupo.Text, 3) = '000') Then
        strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU, 3) = LEFT(:CODGRU, 3) '
      Else
        strSQL := strSQL + '  AND I.ITE_CODGRU = :CODGRU ';

    If (Not fEmptyStr(edtProdutos.Text)) Then
      strSQL := strSQL + '  AND R.ITE_CODITE = :CODITE ';

    strSQL := strSQL + ' AND FGO_VLRCON <> 0 ';

    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  G.FGO_CODCLI, G.FGO_NUMDOC ';

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQl);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If (Not fEmptyStr(edtCodPedido.Text)) Then
        ParamByName('NUMPED').AsString := edtCodPedido.Text;

      If (Not fEmptyStr(edtCodCliente.Text)) Then
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      If (Not fEmptyStr(edtFornecedor.Text)) Then
        ParamByName('CODFOR').AsString := edtFornecedor.Text;

      If (Not fEmptyStr(mskLinhaGrupo.Text)) Then
        ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

      If (Not fEmptyStr(edtProdutos.Text)) Then
        ParamByName('CODITE').AsString := edtProdutos.Text;

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckPedItensRepresent, frmQckPedItensRepresent);

        frmQckPedItensRepresent.dtsRelatorio.DataSet := qryRelatorio;

        If strTipImp = 'M' Then
          frmQckPedItensRepresent.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckPedItensRepresent.qckPagina.DefaultFilter := Nil;


        {********************}
        {* CABEÇALHO DO QCK *}
        {*****************MV*}

        frmQckPedItensRepresent.rllOrdem.Caption := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        If (Not fEmptyStr(edtCodPedido.Text)) Then
          frmQckPedItensRepresent.rllPedido.Caption := 'PEDIDO: ' + edtCodPedido.Text
        Else
          frmQckPedItensRepresent.rllPedido.Caption := 'PEDIDO: TODOS ';

        If (Not fEmptyStr(edtFornecedor.Text)) Then
          frmQckPedItensRepresent.rllFornecedor.Caption := 'FORNECEDOR: ' + edtFornecedor.Text + '-' + edtDesFornecedor.Text
        Else
          frmQckPedItensRepresent.rllFornecedor.Caption := 'FORNECEDOR: TODOS ';

        If (Not fEmptyStr(mskLinhaGrupo.Text)) Then
          frmQckPedItensRepresent.rllLinGru.Caption := 'LINHA / GRUPO: ' + mskLinhaGrupo.Text + '-' + edtDesGrupo.Text
        Else
          frmQckPedItensRepresent.rllLinGru.Caption := 'LINHA / GRUPO: TODOS ';

        If (Not fEmptyStr(edtProdutos.Text)) Then
          frmQckPedItensRepresent.rllProduto.Caption := 'PRODUTO: ' + edtProdutos.Text + '-' + edtDesProduto.Text
        Else
          frmQckPedItensRepresent.rllProduto.Caption := 'PRODUTO: TODOS ';

        If Not fEmptyStr(edtCodCliente.Text) Then
          frmQckPedItensRepresent.rllCliente.Caption := 'CLIENTE: ' + edtCodCliente.Text + '-' + edtDesCliente.Text
        Else
          frmQckPedItensRepresent.rllCliente.Caption := 'CLIENTE: TODOS ';

        frmQckPedItensRepresent.rllNomeRelatorio.Caption := 'RELATORIO DE PRODUTOS REPRESENTADOS';

        If edtDestino.Text = 'V' Then
          frmQckPedItensRepresent.qckPagina.PreviewModal
        Else
          frmQckPedItensRepresent.qckPagina.Print;


      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckPedItensRepresent);
    End
    Else
      pTabelaVazia;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pSetFocus(mskDtaIni);


end;

procedure TfrmRelPedItensRepresent.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelPedItensRepresent.FormCreate(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  pSetaCodIte(edtProdutos);
  edtCodPedido.MaxLength := fTamDocCadRec;
  edtCodPedido.TamCampo  := fTamDocCadRec;
end;

procedure TfrmRelPedItensRepresent.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelPedItensRepresent.FormShow(Sender: TObject);
begin
  inherited;
  pCriaQryRelatorio;
end;

function TfrmRelPedItensRepresent.fValidaCampos(Sender: TWinControl;
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

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

end.

