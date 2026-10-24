unit untFatConsVendasAntigas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, untMensagemSenhaFixa,
  MaskEditFocus, MaskUtils, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, StrUtils,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade, cxProgressBar, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatConsVendasAntigas = class(TfrmPaiOrdena)
    lbl1: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    lbl4: TLabel;
    edtDesItem: TEditFocus;
    lbl5: TLabel;
    edtDesMarca: TEditFocus;
    lbl6: TLabel;
    edtVendedor: TEditFocus;
    lbl7: TLabel;
    edtMens001: TEditFocus;
    edtMens002: TEditFocus;
    lbl9: TLabel;
    edtCndPgto: TEditFocus;
    edtFormas: TEditFocus;
    lbl10: TLabel;
    lblCodCli: TLabel;
    edtCliente: TEditFocus;
    lblFornecedor: TLabel;
    edtFornecedor: TEditFocus;
    lbl8: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtProdutos: TEditFocus;
    edtDesGrupo: TEditFocus;
    edtDesProduto: TEditFocus;
    edtDescri: TEditFocus;
    edtRefere: TEditFocus;
    lbl14: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    btnFiltrar: TBitBtnLocked;
    lbl2: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblNumDoc: TLabel;
    edtNumDoc: TEditFocus;
    lblEspDoc: TLabel;
    edtEspDoc: TEditFocus;
    btnDadosComp: TBitBtnLocked;
    Label13: TLabel;
    edtCodCliCon: TEditFocus;
    Label26: TLabel;
    edtConNom: TEditFocus;
    edtNomCliCon: TEditFocus;
    dbgItens: TcxGrid;
    dbgItensDBTableView1: TcxGridDBTableView;
    GER_CODEMP: TcxGridDBColumn;
    GER_DTAENT: TcxGridDBColumn;
    GER_NUMDOC: TcxGridDBColumn;
    GER_ESPDOC: TcxGridDBColumn;
    GER_NOMCLI: TcxGridDBColumn;
    DET_CODITE: TcxGridDBColumn;
    DET_DESCRI: TcxGridDBColumn;
    DET_QTDITE: TcxGridDBColumn;
    DET_UNITAR: TcxGridDBColumn;
    DET_TOTITE: TcxGridDBColumn;
    DET_TOTCUS: TcxGridDBColumn;
    dbgItensLevel1: TcxGridLevel;
    Label16: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure mskLinhaGrupoEnter(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnDadosCompClick(Sender: TObject);
    procedure edtCodCliConKeyPress(Sender: TObject; var Key: Char);
    procedure dbgConsultaEnter(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCadCli: TUniQuery;
    blnPedCompra: Boolean;


    procedure pSetaConsumidor;
    procedure pCarregaCliente;
    procedure pCarregaFornecedor;
    procedure pAtualizarDados(DataSet: TDataSet);
    procedure pFiltrarDados;
    function  fFiltrarDados(pgbProgresso: TcxProgressBar): Boolean; overload;
    function  fPossuiDadosComp(strAutinc: String): Boolean;
    function  fGetDadosCompItem(strAutinc: String): String;
    procedure pCarregaRede;
  protected
    function fGetOrderBy : String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;
    function fSetParametros: Boolean; override;
  public
    { Public declarations }
    strCliCon: String;

    procedure pSetarParaConsultaDeCompra();

    Class Procedure pMostraVendasAntigas(strCodIte: String);
    Class Procedure pMostraComprasAntigas(strCodIte: String);

  end;

var
  frmFatConsVendasAntigas: TfrmFatConsVendasAntigas;

implementation

uses untFuncoesSimples, untPesqAux, untConsultas, untTypesSistema, untGravando,
  untConstantes;

{$R *.dfm}

procedure TfrmFatConsVendasAntigas.btnDadosCompClick(Sender: TObject);
  function fMontarCaption: String;
  begin
    Result := 'Dados Comp. Item: ' + cdsConsulta.FieldByName('DET_CODITE').AsString + '-' +
      cdsConsulta.FieldByName('DET_DESCRI').AsString;
  end;
begin
  inherited;

  TfrmMensagemSenhaFixa.pShowMessage(
                            fGetDadosCompItem(cdsConsulta.FieldByName('AUTOINCREM').AsString),
                            fMontarCaption(),
                            11,
                            'Courier New',
                            True
                        );
end;

procedure TfrmFatConsVendasAntigas.btnFiltrarClick(Sender: TObject);
begin
  inherited;

  pFiltrarDados();
end;

procedure TfrmFatConsVendasAntigas.dbgConsultaEnter(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItens);
end;

procedure TfrmFatConsVendasAntigas.edtCodCliConKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryAuxili: TUniQuery;
    arrAuxili: TConsultasArray;
begin
  If edtCodCliCon.ReadOnly Then
    Exit;

  inherited;

  Try
    qryAuxili := fCriaQuery(Nil);
    Try
      If fPesqConsumidores(Self, nil, nil, nil, nil, qryAuxili, Key, arrAuxili, '', True) Then
      Begin
        edtCodCliCon.Text := qryAuxili.FieldByName('CON_C_P_F_').AsString;
        If fValidaCampos(edtCodCliCon, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    Finally
      FreeAndNil(qryAuxili);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmFatConsVendasAntigas.edtCodCliConKeyPress]');
    End;
  End;
end;

procedure TfrmFatConsVendasAntigas.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If blnPedCompra Then
  Begin
    If fPesqFornecedor(conForSimples,
                    Self,
                    edtCodCliente,
                    edtDesCliente,
                    nil,
                    Key,
                    arrSel) Then
      If fValidaCampos(edtCodCliente, True) Then
        SelectNext(ActiveControl, True, True);
  End
  Else
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConsVendasAntigas.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConsVendasAntigas.edtCodMarExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodMar.Text) Then
    edtDesMar.Text := 'TODAS'
  Else
    edtDesMar.Text := fRetNomMarca(edtCodMar.Text);

  If fEmptyStr(edtDesMar.Text) And (Not fEmptyStr(edtCodMar.Text))  Then
  Begin
    fMensagem('AVISO','Código da Marca não encontrado.', ['&O K']);
    edtCodMar.Clear;
    pSetFocus(edtCodMar);
  End;
end;

procedure TfrmFatConsVendasAntigas.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMarca: TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConsVendasAntigas.edtCodRedeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConsVendasAntigas.edtProdutosExit(Sender: TObject);
begin
  inherited;
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

procedure TfrmFatConsVendasAntigas.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte: TUniQuery;
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

function TfrmFatConsVendasAntigas.fAbreConsulta(blnLike: Boolean): Boolean;
begin
  If (Not fEmptyStr(strCliCon)) And cdsConsulta.Active Then
  Begin
    Result := True;
    Exit;
  End;
  Result := inherited fAbreConsulta(blnLike);
  If Result Then
  Begin
    dtsConsulta.DataSet.AfterScroll := pAtualizarDados;
    cdsConsulta.First;
    (cdsConsulta.FieldByName('DET_QTDITE') As TFloatField).DisplayFormat := ',0.0000';
    (cdsConsulta.FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := ',0.00';
    (cdsConsulta.FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := ',0.00';
    (cdsConsulta.FieldByName('DET_TOTCUS') As TFloatField).DisplayFormat := ',0.00';
  End;
end;

function TfrmFatConsVendasAntigas.fFiltrarDados(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;

  If fVerificaCampos Then
  Begin
    If fAbreConsulta(True) And (Not cdsConsulta.IsEmpty) Then Begin
      pSetFocus(dbgItens);
      dbgItensDBTableView1.ApplyBestFit;
      Result := True;
    End Else
      fMensagem('','Nenhum registro foi encontrado com os filtros informado!', ['&Ok']);
  End;
end;

function TfrmFatConsVendasAntigas.fGetDadosCompItem(strAutinc: String): String;
begin
  Result := AnsiReplaceStr(fCampoTabela('NOT_DADCOM', 'AUXCOD', ['NOT_SEQDET'], [strAutinc]), STRING_QUEBRA, STRING_ENTER);
end;

function TfrmFatConsVendasAntigas.fGetOrderBy: String;
begin
  Result := ' ORDER BY GER_DTAENT DESC, GER_HORENT DESC ';
end;

function TfrmFatConsVendasAntigas.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '   D.AUTOINCREM,    ';
  Result := Result + '   G.GER_CODEMP,    ';
  Result := Result + '   G.GER_NUMDOC,    ';
  Result := Result + '   G.GER_ESPDOC,    ';
  Result := Result + '   G.GER_CODCLI,    ';
  Result := Result + '   G.GER_DTAENT,    ';
  Result := Result + '   G.GER_MEN001,    ';
  Result := Result + '   G.GER_MEN002,    ';
  Result := Result + '   G.GER_CONPAG,    ';
  Result := Result + '   D.DET_CODITE,    ';
  Result := Result + '   D.DET_DESCRI,    ';
  Result := Result + '   D.DET_QTDITE,    ';
  Result := Result + '   IF(LEFT(DET_CLAFIS,1) >= 5, D.DET_UNITAR, -D.DET_UNITAR) AS DET_UNITAR, ';
  Result := Result + '   IF(LEFT(DET_CLAFIS,1) >= 5, D.DET_TOTITE, -D.DET_TOTITE) AS DET_TOTITE, ';
  Result := Result + '   IF(LEFT(DET_CLAFIS,1) >= 5, D.DET_TOTCUS, -D.DET_TOTCUS) AS DET_TOTCUS, ';
  Result := Result + '   M.MAR_DESMAR,    ';
  Result := Result + '   O.OPE_NOMOPE,    ';
  Result := Result + '   F.FOR_NOMFOR,    ';
  Result := Result + '   F.FOR_CODFOR,    ';
  Result := Result + '   G.GER_CODFPG,    ';
  Result := Result + '   IF(G.GER_TIP_FC = "C", '+fSQLIFClienteConsumidor('C.CLI_NOMCLI',' IF(IFNULL(G.GER_NOMCON, "") = "", " ", G.GER_NOMCON) ', ' C.CLI_NOMCLI ')+', PCF.FOR_NOMFOR) AS GER_NOMCLI,     ';
  Result := Result + '   P.FPG_DESCRI     ';
  Result := Result + 'FROM                ';
  Result := Result + '   NOTCOG G         ';
  Result := Result + '   LEFT JOIN NOTCOD D ON D.DET_SEQGER = G.AUTOINCREM ';
  Result := Result + '   LEFT JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE ';
  Result := Result + '   LEFT JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
  Result := Result + '   LEFT JOIN CADOPE O ON O.OPE_CODOPE = G.GER_CODVEN ';
  Result := Result + '   LEFT JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';
  Result := Result + '   LEFT JOIN CADCLI C ON C.CLI_CODCLI = G.GER_CODCLI ';
  Result := Result + '   LEFT JOIN CADFPG P ON P.FPG_CODIGO = G.GER_CODFPG ';
  Result := Result + '   LEFT JOIN CADFOR PCF ON PCF.FOR_CODFOR = G.GER_CODCLI ';
  Result := Result + 'WHERE  TRUE                     ';
  If Not fEmptyStr(edtCodCliente.Text) Then
    Result := Result + '   AND GER_CODCLI = :CODCLI     ';

  If Not fEmptyStr(edtCodCliCon.Text) Then
    Result := Result + ' AND G.GER_CGCCON = :CGCCON ';

  If Not fEmptyStr(edtConNom.Text) Then
    Result := Result + ' AND G.GER_NOMCON LIKE :NOMCON ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    Result := Result + '   AND GER_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtNumDoc.Text) Then
    Result := Result + '   AND GER_NUMDOC = :NUMDOC ';

  If Not fEmptyStr(edtEspDoc.Text) Then
    Result := Result + '   AND GER_ESPDOC = :ESPDOC ';

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    If (RightStr(mskLinhaGrupo.Text,3) = '000') Then
      Result := Result + '  AND LEFT(ITE_CODGRU, 3) = LEFT(:CODGRU, 3) '
    Else
      Result := Result + '  AND ITE_CODGRU = :CODGRU ';
  End;

  If Not fEmptyStr(edtProdutos.Text) Then
    Result := Result + '  AND DET_CODITE = :CODITE ';

  If Not fEmptyStr(edtDescri.Text) Then
    Result := Result + '  AND DET_DESCRI LIKE :DESCRI ';

  If Not fEmptyStr(edtRefere.Text) Then
    Result := Result + '  AND ITE_REFERE LIKE :REFERE ';

  If Not fEmptyStr(edtCodMar.Text) Then
    Result := Result + '  AND ITE_CODMAR = :CODMAR ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Result := Result + '  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN        ';

  if blnPedCompra Then
    Result := Result + '  AND GER_TIP_FC = "F"'
  else
    Result := Result + '  AND GER_TIP_FC = "C"';

  If Not fEmptyStr(edtCodRede.Text) Then
    Result := Result + '  AND CLI_CODRED = :CODRED ';
end;

procedure TfrmFatConsVendasAntigas.FormCreate(Sender: TObject);
begin
  inherited;
  
  lflLastField.strNomCam := 'GER_DTAENT';
  lflLastField.strNomCol := 'Data Ent.';
  lflLastField.intIndCol := 1;
  lflLastField.ftyTipCam := ftDate;

  qryCadCli     := fCriaQuery(Self);
  blnTemSelecao := False;
  blnTemPesquisa:= False;
  blnPedCompra  := False;
end;

procedure TfrmFatConsVendasAntigas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryCadCli);
end;

procedure TfrmFatConsVendasAntigas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: Begin
                 If ((ActiveControl) = dbgItens) Then
                   pSetFocus(mskDtaIni)
                 Else
                   Inherited;
               End;
    VK_F6:     Begin
                 If (btnDadosComp.Visible) Then
                   btnDadosComp.Click();
               End;
    VK_F3: Key := 0;
    VK_F5: Key := 0;

    Else inherited;
  End;
end;

procedure TfrmFatConsVendasAntigas.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
  If (Not fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa(VS_strCodEmp);

  mskDtaIni.Text := DateToStr(VS_Date - fCfgSis('DIAVAN', VarInteger));
  mskDtaFin.Text := DateToStr(VS_Date);

  pSetaCodIte( edtProdutos );

end;

function TfrmFatConsVendasAntigas.fPossuiDadosComp(strAutinc: String): Boolean;
begin
  Result := fCampoTabela('COUNT(*)', 'AUXCOD', ['NOT_SEQDET'], [strAutinc]) > 0;
end;

procedure TfrmFatConsVendasAntigas.pCarregaRede;
begin
  If Not fEmptyStr(edtCodRede.Text) Then
    edtDesRede.Text := fRetNomeRedeLoja(edtCodRede.Text)
  Else
    edtDesRede.text := 'TODOS';
end;

function TfrmFatConsVendasAntigas.fSetParametros: Boolean;
begin
  With qryConsulta Do
  Begin
    If Not fEmptyStr(edtCodCliente.Text) Then
      ParamByName('CODCLI').AsString := edtCodCliente.Text;

    If Not fEmptyStr(edtCodCliCon.Text) Then
      ParamByName('CGCCON').AsString := edtCodCliCon.Text;

    If Not fEmptyStr(edtConNom.Text) Then
        ParamByName('NOMCON').AsString := edtConNom.Text + '%';

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If Not fEmptyStr(edtNumDoc.Text) Then
      ParamByName('NUMDOC').AsString := edtNumDoc.Text;

    If Not fEmptyStr(edtEspDoc.Text) Then
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    
    If Not fEmptyStr(mskLinhaGrupo.Text) Then
      ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

    If Not fEmptyStr(edtProdutos.Text) Then
      ParamByName('CODITE').AsString := edtProdutos.Text;

    If Not fEmptyStr(edtDescri.Text) Then
      ParamByName('DESCRI').AsString := edtDescri.Text + '%';

    If Not fEmptyStr(edtRefere.Text) Then
      ParamByName('REFERE').AsString := edtRefere.Text + '%';

    If Not fEmptyStr(edtCodMar.Text) Then
      ParamByName('CODMAR').AsString := edtCodMar.Text;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    If Not fEmptyStr(edtCodRede.Text) Then
      ParamByName('CODRED').AsString := edtCodRede.Text;
  End;
  Result := True;
end;

function TfrmFatConsVendasAntigas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCliente) And (blnPedCompra) Then
    Begin

      If Not fEmptyStr(edtCodCliente.Text) Then
      begin
        pCarregaFornecedor;
        If fEmptyStr(edtDesCliente.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Fornecedor não cadastrado!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtCodCliente) Then
    Begin

      If Not fEmptyStr(edtCodCliente.Text) Then
      Begin
        pCarregaCliente;
        If fEmptyStr(edtDesCliente.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Cliente não cadastrado!', ['&Ok']);
          Result := False;
        End;

      End;

      pSetaConsumidor;
    End

    Else If (Sender = edtCodCliCon) And (edtCodCliCon.Enabled) And (Not edtCodCliCon.ReadOnly) Then
    Begin
      edtNomCliCon.Text := fRetNomClienteConsumidor(edtCodCliCon.Text);

      If Not fEmptyStr(edtCodCliCon.Text) Then
      Begin

        If fEmptyStr(edtNomCliCon.Text) Then
        Begin
          fMensagem('','Nenhum consumidor encontrado com este código!',['&OK']);
          Result := False;
        End
        Else If fRetUFCliente(edtCodCliente.Text) <> fRetNomCidade(fRetDadosClienteConsumidor(edtCodCliCon.Text, 'CODCID'), 1) Then
        Begin
          fMensagem('','Estado do cliente consumidor deve ser ' + fRetUFCliente(edtCodCliente.Text),['&OK']);
          Result := False;
        End;

      End
    End

    Else If (Sender = mskDtaIni) Then
    Begin
      mskDtaFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text));

      If Not mskDtaFin.Enabled Then
        mskDtaFin.Clear;
    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End;  

    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Essa Empresa não está cadastrada!',['&O k']);
          Result := False;
        End;
      End
      Else
        edtNomEmp.Text := 'TODAS';
    End

    Else If (Sender = edtCodRede) Then
    Begin
      pCarregaRede;

      If fEmptyStr(edtDesRede.Text) And (Not fEmptyStr(edtCodRede.Text))  Then
      Begin
        fMensagem('AVISO','Código da rede não encontrado.', ['&O K']);
        edtCodRede.Clear;
        Result := False;        
      End;
    End;    

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatConsVendasAntigas.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
//  edtProdutos.Clear;
//  edtDesProduto.Text := '';
end;

procedure TfrmFatConsVendasAntigas.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);
    If fEmptyStr(edtDesGrupo.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo.Clear;
      pSetFocus(mskLinhaGrupo);
    End;
  End;
end;

procedure TfrmFatConsVendasAntigas.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatConsVendasAntigas.pAtualizarDados(DataSet: TDataSet);
begin
  With dtsConsulta Do
  Begin
    edtDesItem.Text  := DataSet.FieldByName('DET_DESCRI').AsString;
    edtDesMarca.Text := DataSet.FieldByName('MAR_DESMAR').AsString;
    edtVendedor.Text := DataSet.FieldByName('OPE_NOMOPE').AsString;
    edtMens001.Text  := DataSet.FieldByName('GER_MEN001').AsString;
    edtMens002.Text  := DataSet.FieldByName('GER_MEN002').AsString;
    edtCndPgto.Text  := FormatMaskText(MASK_CONPAG,
                                       DataSet.FieldByName('GER_CONPAG').AsString);
    edtCliente.Text  := DataSet.FieldByName('GER_CODCLI').AsString + ' - ' +
                        DataSet.FieldByName('GER_NOMCLI').AsString;

    If (DataSet.FindField('FOR_NOMFOR') <> Nil) Then
    Begin
      edtFornecedor.Text := DataSet.FieldByName('FOR_CODFOR').AsString + ' - ' +
                            DataSet.FieldByName('FOR_NOMFOR').AsString;
    End
    Else
    Begin
      edtFornecedor.Visible := False;
      lblFornecedor.Visible := False;
    End;

    If (DataSet.FindField('FPG_DESCRI') <> Nil) Then
      edtFormas.Text := DataSet.FieldByName('GER_CODFPG').AsString + ' - ' +
                        DataSet.FieldByName('FPG_DESCRI').AsString;

    btnDadosComp.Visible := fPossuiDadosComp(DataSet.FieldByName('AUTOINCREM').AsString);
  End;
end;

procedure TfrmFatConsVendasAntigas.pCarregaCliente;
begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCliente.Text);
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
end;

procedure TfrmFatConsVendasAntigas.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryCadCli, qryCadCli, edtCodCliente.Text);
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('FOR_NOMFOR').AsString
  Else
    edtDesCliente.Text := '';
end;

procedure TfrmFatConsVendasAntigas.pFiltrarDados;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.pgbStatus.Visible   := False;
      frmGravando.lblGravando.Caption := 'Aguarde... Carregando vendas.';
      frmGravando.fExecutarAcao := fFiltrarDados;
      frmGravando.showModal;
      Self.Repaint();
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatConsVendasAntigas.pFiltrarDados]');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmFatConsVendasAntigas.pSetaConsumidor;
begin
  If fClienteConsumidor(edtDesCliente.Text, False, True) Then
  Begin
    edtCodCliCon.ReadOnly := False;
    edtConNom.ReadOnly := edtCodCliCon.ReadOnly;
  End
  Else
  Begin
    edtCodCliCon.ReadOnly := True;
    edtCodCliCon.Clear;

    edtNomCliCon.Clear;

    edtConNom.ReadOnly := edtCodCliCon.ReadOnly;
    edtConNom.Clear;
  End;

  edtCodCliCon.TabStop := Not edtCodCliCon.ReadOnly;
  edtConNom.TabStop := edtCodCliCon.TabStop;

  edtCodCliCon.NormalColor := IIF(edtCodCliCon.ReadOnly, $00FFDFB8, clWindow);
  edtConNom.NormalColor := edtCodCliCon.NormalColor;
end;

procedure TfrmFatConsVendasAntigas.pSetarParaConsultaDeCompra;
begin
  { Altera  a tela para mostrar os pedidos de compra }
  lbl1.Caption := 'Fornecedor';
  lbl6.Caption := 'Comprador';
  lblCodCli.Caption := 'Fornecedor.:';
  blnPedCompra := True;
  Self.Caption := 'Compras do Sistema Anterior';
end;

Class Procedure TfrmFatConsVendasAntigas.pMostraComprasAntigas(strCodIte: String);
Begin
  pCriarFormularios(TfrmFatConsVendasAntigas, frmFatConsVendasAntigas);
  Try
    frmFatConsVendasAntigas.pSetarParaConsultaDeCompra;
    frmFatConsVendasAntigas.edtProdutos.Text := strCodIte;
    frmFatConsVendasAntigas.ShowModal;
  Finally
    FreeAndNil(frmFatConsVendasAntigas);
  End;
End;

Class Procedure TfrmFatConsVendasAntigas.pMostraVendasAntigas(strCodIte: String);
Begin
  pCriarFormularios(TfrmFatConsVendasAntigas, frmFatConsVendasAntigas);
  Try
    frmFatConsVendasAntigas.edtProdutos.Text := strCodIte;
    frmFatConsVendasAntigas.ShowModal;
  Finally
    FreeAndNil(frmFatConsVendasAntigas);
  End;
End;



end.

