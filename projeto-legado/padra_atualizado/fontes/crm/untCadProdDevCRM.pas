unit untCadProdDevCRM;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, EditFocus, cxStyles, cxCustomData, cxGraphics, strUtils,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView, untTypesSistema,
  cxGridDBTableView, cxGrid, UniClientDataSet, Uni, untConstantes, cxContainer, cxLabel,
  cxDBLabel, QColorLabel, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, untDigDocDevCRM, cxNavigator, frxClass,
  frxExportCSVTestabilidade, untGarant, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao, SysUtils;

  const
    MSG_PRODUTO_SEM_VENDA =  'Não há documentos para este produto!';
    MSG_VENDA_NAO_SELECIONADA = 'É obrigatório selecionar um documento para o produto a ser devolvido!';

type
  TfrmCadProdDevCRM = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtQtdIte: TEditFocus;
    edtDesMot: TEditFocus;
    pnlRodape: TPanel;
    pnlBotoesEnt: TPanel;
    pnlProdutos: TPanel;
    dbgProdutosDBTableView1: TcxGridDBTableView;
    dbgProdutosLevel1: TcxGridLevel;
    dbgProdutos: TcxGrid;
    dtsProdutos: TDataSource;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESITE: TStringField;
    cdsProdutosCODMOT: TStringField;
    cdsProdutosDESMOT: TStringField;
    cdsProdutosQTDITE: TFloatField;
    cdsProdutosSIGUNI: TStringField;
    cdsProdutosDOCULT: TStringField;
    cdsProdutosDTAULT: TDateField;
    cdsProdutosVENULT: TStringField;
    dbgProdutosDBTableView1CODITE: TcxGridDBColumn;
    dbgProdutosDBTableView1DESITE: TcxGridDBColumn;
    dbgProdutosDBTableView1DESMOT: TcxGridDBColumn;
    dbgProdutosDBTableView1QTDITE: TcxGridDBColumn;
    dbgProdutosDBTableView1SIGUNI: TcxGridDBColumn;
    dbgProdutosDBTableView1DOCULT: TcxGridDBColumn;
    dbgProdutosDBTableView1DTAULT: TcxGridDBColumn;
    dbgProdutosDBTableView1VENULT: TcxGridDBColumn;
    edtCodMot: TEditFocus;
    cdsProdutosREFERE: TStringField;
    cdsProdutosDESUNI: TStringField;
    cxDBLabel1: TcxDBLabel;
    cxDBLabel2: TcxDBLabel;
    cxDBLabel3: TcxDBLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cdsProdutosESPDOC: TStringField;
    cdsProdutosNUMDOC: TStringField;
    cdsProdutosCODEMP: TStringField;
    cdsProdutosQTDORI: TFloatField;
    cdsProdutosFORCLI: TStringField;
    cdsProdutosTIP_FC: TStringField;
    cdsProdutosSERIE_: TStringField;
    cdsProdutosUNITAR: TFloatField;
    chkGerarColeta: TCheckBox;
    edtGarant: TEditFocus;
    lblGarantia: TLabel;
    clrLblGarantia: TColorLabel;
    cdsProdutosGARANT: TStringField;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    btnDevTotal: TBitBtnLocked;
    cdsProdutosSEQORI: TStringField;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure dbgProdutosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cdsProdutosAfterScroll(DataSet: TDataSet);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDevTotalClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCodOco: String;
    FCodEmp: String;
    FInsert: Boolean;
    FCodCli: String;
    FCodDev: String;
    FSeqGer: String;
    FNomCli: String;
    FNumDoc: String;
    FEspDoc: String;
    FDtaMov: TDate;
    FQtdDev: Double;
    FUniDev: Double;
    FForCli: String;
    FTip_FC: String;
    FSerie: String;
    FConsul: Boolean;
    qryCadMot: TUniQuery;
    qryCadIte: TUniQuery;
    tipOperac: TTipoOperacao;
    blnConfirma: Boolean;
    blnDevTotal: Boolean;
    strProdLiber: String;
    strProdGarLiber: String;
    strProdDevLiber: String;
    strCodIteAnt: String;
    objGar : TMovGad;
    strBookMark: TBookMark;

    objLiberacao : TLiberacao;
    blnPermitirSelecionarDocumentos : boolean;

    FbnlExisteVendasParaOProduto : Boolean;

    FQtdDoc: Double;
    FSeqOri: String;

    procedure pCarregaOcorrencia;
    procedure pCarregaItem(strCodIte: String);
    procedure pGravaItem;
    procedure pLimpaItem;
    procedure pEditaItem;
    procedure pExcluiItem;
    procedure pMostraItem;
    procedure pIniciaVenda;
    procedure pLimpaTela;
    procedure pCarregaUltVendas(strCodIte : String; strNomCol  : String = 'DTA_MOV');
    procedure fConsultaDevolucao;
    procedure pDevolucaoTotal;

    function fFormatDocUltimaCompra(strNumDoc, strEspDoc, strCodEmp: String): String;
    function fPedirSenhaLiberacao: Boolean;
    function fPedirSenhaLiberacaoGarantia: Boolean;
    function fPermiteLiberarProduto: Boolean;
    function fPermiteLiberarGarantia: Boolean;
    function fPermiteLiberarProdutoDevolucao: Boolean;
    function getForCli: String;
    function getSerie: String;
    function getTip_FC: String;
    procedure setForCli(const Value: String);
    procedure setSerie(const Value: String);
    procedure setTip_FC(const Value: String);
    function fQuantidadeEmDevolucao: Double;
    function fRetornaDiasGarantia(strCodIte: String): Integer;
    function fGarantiaDiferente(strGarant: String): Boolean;
    function fValidaItensDevolucaoEmitidosDiasVencidos: Boolean;
    procedure pSomenteConsulta;
    function fValidaTotalQuantidadeDev: Boolean;
    function fRetQuantidadeTotalEmDevolucao: Double;
    function ValidaEspecieDocumentoIncluidoAD: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    function getCodOco: String;
    function getCodEmp: String;
    function getInsert: Boolean;
    function getCodCli: String;
    function getCodDev: String;
    function getSeqGer: String;
    function getNomCli: String;
    function getNumDoc: String;
    function getEspDoc: String;
    function getDtaMov: TDate;
    function getQtdDev: Double;
    function getUniDev: Double;
    function getConsul: Boolean;

    procedure setCodOco(const Value: String);
    procedure setCodEmp(const Value: String);
    procedure setInsert(const Value: Boolean);
    procedure setCodCli(const Value: String);
    procedure setCodDev(const Value: String);
    procedure setSeqGer(const Value: String);
    procedure setNomCli(const Value: String);
    procedure setNumDoc(const Value: String);
    procedure setEspDoc(const Value: String);
    procedure setDtaMov(const Value: TDate);
    procedure setQtdDev(const Value: Double);
    procedure setUniDev(const Value: Double);
    procedure setConsul(const Value: Boolean);

  public
    { Public declarations }
    property strCodOco: String Read getCodOco Write setCodOco;
    property strCodEmp: String Read getCodEmp Write setCodEmp;
    property blnInsert: Boolean Read getInsert Write setInsert;
    property strCodCli: String Read getCodCli Write setCodCli;
    property strCodDev: String Read getCodDev Write setCodDev;
    property strSeqGer: String Read getSeqGer Write setSeqGer;
    property strNomCli: String Read getNomCli Write setNomCli;
    property strNumDoc: String Read getNumDoc Write setNumDoc;
    property strEspDoc: String Read getEspDoc Write setEspDoc;
    property dtaDtaMov: TDate Read getDtaMov Write setDtaMov;
    property fltQtdDev: Double read getQtdDev Write setQtdDev;
    property fltUniDev: Double read getUniDev Write setUniDev;
    property strForCli: String Read getForCli Write setForCli;
    property strTip_FC: String Read getTip_FC Write setTip_FC;
    property strSerie_: String Read getSerie Write setSerie;
    property blnConsul: Boolean Read getConsul Write setConsul;
    property fltQtdDoc: Double Read FQtdDoc Write FQtdDoc;
    property strSeqOri: String Read FSeqOri Write FSeqOri;
  end;

var
  frmCadProdDevCRM: TfrmCadProdDevCRM;

implementation

uses Variants, DateUtils, untFuncoesSimples,
     untConsultas, untConsultaUltVenProdCRM, untFuncoes, untFuncFat, untPesqAux,
     untFuncoesCRM, untGravando, untMsgLiberacao;

{$R *.dfm}

{ TfrmCadProdDevCRM }

procedure TfrmCadProdDevCRM.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  if fVerificaCampos then
    pGravaItem;
end;

procedure TfrmCadProdDevCRM.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaItem;
end;

procedure TfrmCadProdDevCRM.btnCancelarEntradaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadProdDevCRM.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not cdsProdutos.IsEmpty And fValidaItensDevolucaoEmitidosDiasVencidos Then
  Begin
    blnConfirma := True;
    btnSair.Click;
  End;
end;

procedure TfrmCadProdDevCRM.btnDevTotalClick(Sender: TObject);
begin
  inherited;
  If btnDevTotal.Enabled Then
    TfrmGravando.fExecutarModalA(pDevolucaoTotal, 'Aguarde, Carregando produtos ...', '');
end;

procedure TfrmCadProdDevCRM.pDevolucaoTotal;
  var
    LLiberadoProdutoDevolucao: Boolean;
begin

  If cdsProdutos.IsEmpty Or
     fPergunta('Os itens já inseridos no grid serão descartados. ' +
               'Deseja continuar?') Then
  Begin
    Try
      blnDevTotal := True;
      LLiberadoProdutoDevolucao := False;
      cdsProdutos.EmptyDataSet;

      Try
        pCriarFormularios(TfrmDigDocDevCRM, frmDigDocDevCRM);
        frmDigDocDevCRM.strCodCli := strCodCli;
        frmDigDocDevCRM.strCodEmp := IIF(fEmptyStr(FCodEmp), VS_strCodEmp, FCodEmp);
        frmDigDocDevCRM.ShowModal;

        If frmDigDocDevCRM.blnConfirma Then
        Begin
          frmDigDocDevCRM.qryItens.First;
          While Not frmDigDocDevCRM.qryItens.Eof Do
          Begin
            pLimpaItem;
            blnDevTotal    := True;

            If Not LLiberadoProdutoDevolucao Then
            Begin
              If Not fPermiteLiberarProdutoDevolucao Then
                Exit
              Else
                LLiberadoProdutoDevolucao := True;
            End;

            edtCodIte.Text := frmDigDocDevCRM.qryItens.FieldByName('DET_CODITE').AsString;
            edtQtdIte.Text := frmDigDocDevCRM.qryItens.FieldByName('DET_QTDITE').AsString;
            edtCodMot.Text := frmDigDocDevCRM.edtCodMot.Text;
            edtGarant.Text := frmDigDocDevCRM.edtGarant.Text;

            strNumDoc := frmDigDocDevCRM.qryItens.FieldByName('DET_NUMDOC').AsString;
            strEspDoc := frmDigDocDevCRM.qryItens.FieldByName('DET_ESPDOC').AsString;
            dtaDtaMov := frmDigDocDevCRM.qryItens.FieldByName('DET_DTAENT').AsDateTime;
            fltQtdDev := frmDigDocDevCRM.qryItens.FieldByName('DET_QTDITE').AsFloat;
            fltUniDev := frmDigDocDevCRM.qryItens.FieldByName('DET_UNITAR').AsFloat;
            strForCli := frmDigDocDevCRM.qryItens.FieldByName('DET_CODCLI').AsString;
            strTip_FC := frmDigDocDevCRM.qryItens.FieldByName('DET_TIP_FC').AsString;
            strSerie_ := frmDigDocDevCRM.qryItens.FieldByName('DET_SERIE_').AsString;
            strSeqOri := frmDigDocDevCRM.qryItens.FieldByName('SEQORI').AsString;

            If fVerificaCampos Then
              pGravaItem
            Else
              Break;

            frmDigDocDevCRM.qryItens.Next;

            Application.ProcessMessages;
          End;
        End;

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;

      pFreeAndNil(frmDigDocDevCRM);

    Finally
      blnDevTotal := False;
    End;

  End;
end;

procedure TfrmCadProdDevCRM.cdsProdutosAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not cdsProdutos.IsEmpty then
    btnConfirma.Enabled := not FConsul //True
  else
    btnConfirma.Enabled := False;
end;

procedure TfrmCadProdDevCRM.dbgProdutosDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pEditaItem;
    VK_DELETE: pExcluiItem;
  End;
end;

procedure TfrmCadProdDevCRM.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If (fEntraCons(Key)) And (Not edtCodIte.ReadOnly) Then
  Begin
    Try

      if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
      Begin
        If fValidaCampos(edtCodIte, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmPrincipal.pConsultaItem]');
      End;
    End;
  End;

end;

procedure TfrmCadProdDevCRM.edtCodMotKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOcor: TConsultasArray;
begin
  inherited;
  If fPesqOcorrencia(Self, edtCodMot, edtDesMot, Nil, Key, arrOcor) Then
  begin
    If fValidaCampos(edtCodMot, True) Then
      Self.SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmCadProdDevCRM.fConsultaDevolucao;
var
  qryCons: TUniQuery;
begin
  try
    qryCons := fCriaQuery(Self);
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.SQL.Add(fRetornaSQLConsultaDevolucao);
    qryCons.ParamByName('CODEMP').AsString := FCodEmp;
    qryCons.ParamByName('CODOCO').AsString := FCodOco;
    qryCons.Open;
    qryCons.First;
    cdsProdutos.DisableControls;
    while not qryCons.Eof do
    begin

      strCodDev := qryCons.FieldByName('DET_CODADE').AsString;
      strSeqGer := qryCons.FieldByName('DET_SEQGER').AsString;

      cdsProdutos.Append;
      cdsProdutosCODITE.AsString   := qryCons.FieldByName('DET_CODITE').AsString;
      cdsProdutosDESITE.AsString   := qryCons.FieldByName('ITE_DESITE').AsString;
      cdsProdutosCODMOT.AsString   := qryCons.FieldByName('DET_CODMOT').AsString;
      cdsProdutosDESMOT.AsString   := qryCons.FieldByName('OCO_DESOCO').AsString;
      cdsProdutosQTDITE.AsFloat    := qryCons.FieldByName('DET_QTDDEV').AsFloat;
      cdsProdutosUNITAR.AsFloat    := qryCons.FieldByName('DET_UNIDEV').AsFloat;      
      cdsProdutosSIGUNI.AsString   := qryCons.FieldByName('UNI_SIGUNI').AsString;

      cdsProdutosDOCULT.AsString   := fFormatDocUltimaCompra(qryCons.FieldByName('DET_NUMDOC').AsString,
                                                             qryCons.FieldByName('DET_ESPDOC').AsString,
                                                             qryCons.FieldByName('DET_CODEMP').AsString);
      if qryCons.FieldByName('DET_DTAMOV').AsDateTime > 0 then
        cdsProdutosDTAULT.AsDateTime := qryCons.FieldByName('DET_DTAMOV').AsDateTime
      else
        cdsProdutosDTAULT.IsNull;
      cdsProdutosVENULT.AsString   := IIF(fEmptyStr(qryCons.FieldByName('DET_NUMDOC').AsString),'',fRetornaVendedorUltCompra(qryCons.FieldByName('DET_NUMDOC').AsString,
                                                                                                                             qryCons.FieldByName('DET_ESPDOC').AsString,
                                                                                                                             qryCons.FieldByName('DET_CODEMP').AsString));
      cdsProdutosREFERE.AsString   := qryCons.FieldByName('ITE_REFERE').AsString;
      cdsProdutosDESUNI.AsString   := qryCons.FieldByName('UNI_DESUNI').AsString;
      cdsProdutosNUMDOC.AsString   := qryCons.FieldByName('DET_NUMDOC').AsString;
      cdsProdutosESPDOC.AsString   := qryCons.FieldByName('DET_ESPDOC').AsString;
      cdsProdutosCODEMP.AsString   := qryCons.FieldByName('DET_CODEMP').AsString;
      cdsProdutosQTDORI.AsFloat    := qryCons.FieldByName('DET_QTDORI').AsFloat;
      cdsProdutosFORCLI.AsString   := qryCons.FieldByName('DET_FORCLI').AsString;
      cdsProdutosTIP_FC.AsString   := qryCons.FieldByName('DET_TIP_FC').AsString;
      cdsProdutosSERIE_.AsString   := qryCons.FieldByName('DET_SERIE_').AsString;
      cdsProdutosGARANT.AsString   := qryCons.FieldByName('DET_GARANT').AsString;
      cdsProdutos.Post;

      qryCons.Next;
    end;
  finally
    cdsProdutos.EnableControls;
    FreeAndNil(qryCons);
  end;

end;

function TfrmCadProdDevCRM.fFormatDocUltimaCompra(strNumDoc, strEspDoc,
  strCodEmp: String): String;
begin
  Result := '';
  if (not fEmptyStr(strNumDoc)) then
    Result := strNumDoc + '-' + strEspDoc + '-' + strCodEmp;
end;

function TfrmCadProdDevCRM.fGarantiaDiferente(strGarant: String): Boolean;
begin
  Result := False;

  If cdsProdutos.RecordCount > 0 Then
  Begin
    Try
      cdsProdutos.DisableControls;
      cdsProdutos.First;
      While Not cdsProdutos.Eof Do
      Begin
        If (cdsProdutos.FieldByName('GARANT').AsString <> strGarant) Then
        Begin
          Result := True;
          Break;
        End;

        cdsProdutos.Next;
      End;
    Finally
      cdsProdutos.EnableControls;
    End;
  End;

end;

procedure TfrmCadProdDevCRM.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if not blnConfirma then
    cdsProdutos.EmptyDataSet;

  FreeAndNil(qryCadIte);
  FreeAndNil(qryCadMot);
end;

procedure TfrmCadProdDevCRM.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  pSetaCodIte(cdsProdutosCODITE);

  objGar := TMovGad.Create(Self);
  blnPermitirSelecionarDocumentos := False;
  cdsProdutos.CreateDataSet;

  objLiberacao := TLiberacao.Create;

  blnDevTotal     := False;
  blnConfirma     := False;
  strProdLiber    := '';
  strProdGarLiber := '';
  strProdDevLiber := '';
  strCodIteAnt    := '';

  tipOperac    := opIncluir;

  qryCadIte    := fCriaQuery(Self);
  qryCadMot    := fCriarQuery('SELECT * FROM CADOCO WHERE FALSE', Self);

  // usados para lancar os itens em edicao;
  strCodDev := '';
  strSeqGer := '';

  edtQtdIte.EditFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
end;

procedure TfrmCadProdDevCRM.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objGar);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;
end;

procedure TfrmCadProdDevCRM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F6 : btnDevTotal.Click;
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmCadProdDevCRM.FormShow(Sender: TObject);
begin
  inherited;
  pIniciaVenda;
  btnDevTotal.Enabled := Not FConsul;
  FbnlExisteVendasParaOProduto := False;

  If Not fCfgSis('GARANT', varBoolean) Then
  Begin
    lblGarantia.Visible := False;
    edtGarant.Visible := False;
    clrLblGarantia.Visible := False;
    pnlCabecalho.Height := pnlCabecalho.Height - edtGarant.Height;
    edtGarant.Text := 'N';
  End;
end;

function TfrmCadProdDevCRM.fPedirSenhaLiberacao: Boolean;
begin
  Result := False;
  if (FDtaMov = 0) Or
     (DaysBetween(VS_Date, FDtaMov) > DaysInYear(VS_Date)) then  //365
    Result := True;
end;

function TfrmCadProdDevCRM.fPedirSenhaLiberacaoGarantia: Boolean;
begin
  Result := False;
  If (FDtaMov > 0) And (DaysBetween(VS_Date, FDtaMov) > fRetornaDiasGarantia(edtCodIte.Text)) Then
    Result := True;
end;

function TfrmCadProdDevCRM.fPermiteLiberarGarantia: Boolean;
begin
  Result := False;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Produto ultrapassou o prazo de Garantia !');
  objLiberacao.objMsgLibera.pAddTextoCaption('Produto'        , edtCodIte.Text + ' - ' + edtDesIte.Text , 15);
  objLiberacao.objMsgLibera.pAddTextoCaption('Documento'      , strNumDoc + '-' + strEspDoc             , 15);
  objLiberacao.objMsgLibera.pAddTextoCaption('Data da Compra' , DateToStr(FDtaMov)                      , 15);

  try
    With qryCadIte Do
    begin
      objGar.pCarregaDadosGarantia(FieldByName('ITE_CODITE').AsString);

      If Not Result And (strProdGarLiber <> FieldByName('ITE_CODITE').AsString) Then
      Begin
        if ( objGar.blnTemGarantia ) then
        begin
          If fPedirSenhaLiberacaoGarantia Then
          Begin

            objLiberacao.strDirAce := 'PRAGAR';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.strCliente := FCodCli + ' - ' + FNomCli;
            objLiberacao.strCpfCnpj := fRetCgcCpf(FCodCli);
            objLiberacao.blnUsarSenhaFixa := False;
            objLiberacao.blnSempreVariavelUsuario := True;

            Result := objLiberacao.fLibera;
          End;
        end
        else
          Result := True;
      End;
    End;
    finally
      //FreeAndNil(objGar);
    end;
end;

function TfrmCadProdDevCRM.fPermiteLiberarProduto: Boolean;
begin
  Result := True;
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Produto ultrapassou o prazo de Garantia !');
  objLiberacao.objMsgLibera.pAddTextoCaption('Produto'        , edtCodIte.Text + ' - ' + edtDesIte.Text , 15);
  if (FDtaMov = 0) then
    objLiberacao.objMsgLibera.pAddTexto('Cliente nunca comprou esse produto !')
  else
    objLiberacao.objMsgLibera.pAddTextoCaption('Data da Compra' , DateToStr(FDtaMov)                      , 15);
  objLiberacao.strDirAce := 'PRAGAR';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCliente := FCodCli + ' - ' + FNomCli;
  objLiberacao.strCpfCnpj := fRetCgcCpf(FCodCli);
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;
  If (strProdGarLiber <> qryCadIte.FieldByName('ITE_CODITE').AsString) Then
  Begin
    objGar.pCarregaDadosGarantia(qryCadIte.FieldByName('ITE_CODITE').AsString);
    if (objGar.blnTemGarantia) and (fPedirSenhaLiberacaoGarantia) then
      Result := objLiberacao.fLibera;
  end;
end;

function TfrmCadProdDevCRM.fPermiteLiberarProdutoDevolucao: Boolean;
  var
    strIteDev: String;
begin
  Result := True;

  If blnDevTotal Then
    strIteDev := fVerificaItemRecebeDevolucao(frmDigDocDevCRM.qryItens.FieldByName('DET_NUMDOC').AsString,
                                              frmDigDocDevCRM.qryItens.FieldByName('DET_ESPDOC').AsString,
                                              frmDigDocDevCRM.qryItens.FieldByName('DET_CODEMP').AsString)
  Else
    strIteDev := edtCodIte.Text + '-' + fRetNomProduto(edtCodIte.Text);

  If fEmptyStr(strIteDev) Then
    Exit;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Permite receber produto(s) bloqueado(s) para devolução');
  objLiberacao.objMsgLibera.pAddSeparador(48);
  objLiberacao.objMsgLibera.pAddTextoCaption('Produto', strIteDev, 7);
  objLiberacao.strDirAce := 'DEVPROD';
  objLiberacao.strMsgSen := 'Devolução de Produto';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCliente := strCodCli + '-' + fRetNomCliente(strCodCli);
  objLiberacao.strCpfCnpj := fRetCgcCpf(strCodCli);

  If (blnDevTotal) Or (strProdDevLiber <> qryCadIte.FieldByName('ITE_CODITE').AsString) Then
    Result := objLiberacao.fLibera;
end;

function TfrmCadProdDevCRM.fQuantidadeEmDevolucao: Double;
  Var
    cdsClone: TUniClientDataSet;
begin
  Result := 0;
  try
    cdsClone := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsClone, cdsProdutos);
    cdsClone.Filter := 'NUMDOC=' + QuotedStr(FNumDoc) +' AND '+
                       'ESPDOC=' + QuotedStr(FEspDoc) +' AND '+
                       'CODEMP=' + QuotedStr(FCodEmp) +' AND '+
                       'CODITE=' + QuotedStr(edtCodIte.Text) +' AND '+
                       'SEQORI=' + QuotedStr(strSeqOri);
    cdsClone.Filtered := True;
    cdsClone.First;
    while not cdsClone.Eof do
    begin
      Result := Result + cdsClone.FieldByName('QTDITE').AsFloat;
      cdsClone.Next;
    end;
  finally
    FreeAndNil(cdsClone);
  end;
end;

function TfrmCadProdDevCRM.fRetornaDiasGarantia(strCodIte: String): Integer;
const fltMes = 30.4375;
var
  qryCon : TUniQuery;
  intCont: Integer;
  fltDias: Double;
begin
  Result := 0;
  fltDias := 0.0;
  Try
    qryCon := fCriaQuery(Nil);
    With qryCon Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ITE_TMPGAR ');
      SQL.Add('   FROM CADITE ');
      SQL.Add('  WHERE ITE_CODITE = :CODITE ');
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If FieldByName('ITE_TMPGAR').AsInteger > 0 Then
      Begin
        For intCont := 1 To FieldByName('ITE_TMPGAR').AsInteger Do
          fltDias := fltDias + fltMes;
        Result := Round(fltDias);
      End;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TfrmCadProdDevCRM.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodIte) And (tipOperac <> opAlterar) Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
      Begin
        pMensagemOk('O Código do Item deve ser preenchido!');
        Result := False;
      End
      Else
      Begin
        pCarregaItem(edtCodIte.Text);
        objGar.pCarregaDadosGarantia(qryCadIte.FieldByName('ITE_CODITE').AsString);

        If not qryCadIte.IsEmpty Then
        Begin
          if (strCodIteAnt <> edtCodIte.Text) or (blnPermitirSelecionarDocumentos) then
          begin
            blnPermitirSelecionarDocumentos := False;
            pCarregaUltVendas(edtCodIte.Text);
          end;
          edtDesIte.Text := qryCadIte.FieldByName('ITE_DESITE').AsString;
          strCodIteAnt := edtCodIte.Text;
        End;

        If qryCadIte.IsEmpty Then
        Begin
          pMensagemOk('Item não encontrado!');
          Result := False;
        End

        Else If Not SameText(qryCadIte.FieldByName('ITE_ITEATI').AsString, 'S') Then
        Begin
          pMensagemOk('Item inativo!');
          Result := False;
        End

        Else If (fEmptyStr(FNumDoc)) Then
        Begin
          blnPermitirSelecionarDocumentos := True;
          if FbnlExisteVendasParaOProduto then
            fMensagem('ATENÇÃO!', MSG_VENDA_NAO_SELECIONADA, ['&O k'])
          else
            fMensagem('ATENÇÃO!', MSG_PRODUTO_SEM_VENDA, ['&O k']);
          Result := False;
        End

        Else If (Not fEmptyStr(edtCodIte.Text)) And
                (Not blnDevTotal) And
                (Not fPermiteReceberDevolucao(edtCodIte.Text, strCodEmp)) Then
        Begin
          If Not fPermiteLiberarProdutoDevolucao Then
          Begin
            pMensagemOk('Produto não Liberado!');
            Result := False;
          End
          Else
            strProdDevLiber := qryCadIte.FieldByName('ITE_CODITE').AsString;
        End

        Else If fPedirSenhaLiberacao And (strProdLiber <> qryCadIte.FieldByName('ITE_CODITE').AsString) Then
        Begin
          if ( objGar.blnTemGarantia ) then
          begin
            If Not fPermiteLiberarProduto Then
            Begin
              pMensagemOk('Produto não Liberado!');
              Result := False;
            End
            Else
              strProdLiber := qryCadIte.FieldByName('ITE_CODITE').AsString;
          end;
        End;

        //Verificando a Garantia do Produto
        If Result And (strProdGarLiber <> qryCadIte.FieldByName('ITE_CODITE').AsString) Then
        Begin
          if ( objGar.blnTemGarantia ) then
          begin
            If fPedirSenhaLiberacaoGarantia Then
            Begin
              fMensagem('ATENÇÃO','Prazo de Garantia do Produto foi Ultrapassado !' + #13#10 +
                                  'Data da Compra : ' + DateToStr(FDtaMov),['&Ok']);

              If Not fPermiteLiberarGarantia Then
              Begin
                blnPermitirSelecionarDocumentos := True;
                pMensagemOk('Produto sem Garantia não Liberado!');
                Result := False;
              End
              Else
                strProdGarLiber := qryCadIte.FieldByName('ITE_CODITE').AsString;
            End;
          end;
        End;

        If Result And Not(ValidaEspecieDocumentoIncluidoAD) Then
        Begin
          pMensagemOk('Somente itens da mesma espécie podem ser selecionados:  ' +
                      'Itens de FF podem ser selecionados apenas com outros itens de FF ' +
                      'Itens IF ou NF devem ser selecionados somente entre si, mas não podem ser selecionados com itens de FF. ');
          Result := False;
        End;

      End;
    End

    Else If Sender = edtQtdIte Then
    Begin

      If fStrToFloat(edtQtdIte.Text) <= 0 Then
      Begin
        pMensagemOk('A quantidade deve ser maior que zero!');
        Result := False;
      End
      Else If (FQtdDev > 0) And (fStrToFloat(edtQtdIte.Text) > FQtdDev) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade devolvida deve ser menor ou igual' + #13#10 +
                              ' a quantidade do documento selecionado !' , ['&Ok']);
        Result := False;
      End
      Else If (Not fEmptyStr(FNumDoc)) Then
      Begin
        If Not fValidaTotalQuantidadeDev Then
        Begin
          fMensagem('ATENÇÃO!', 'A soma das quantidades devolvidas não pode ultrapassar a quantidade total do documento. ' +
                                'Verifique a quantidade informada para o produto de mesmo código, valor unitário e sequência.' , ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodMot) Then
    Begin

      If fEmptyStr(edtCodMot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Motivo deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaOcorrencia;
        If qryCadMot.FieldByName('OCO_CODOCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Motivo não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If fEmptyStr(FNumDoc) Then
    Begin
      blnPermitirSelecionarDocumentos := True;
      if FbnlExisteVendasParaOProduto then
        fMensagem('ATENÇÃO!', MSG_VENDA_NAO_SELECIONADA, ['&O k'])
      else
        fMensagem('ATENÇÃO!', MSG_PRODUTO_SEM_VENDA, ['&O k']);
      Result := False;
    End

    Else If (Sender = edtGarant) and (edtGarant.Visible) Then
    Begin
      If fEmptyStr(edtGarant.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É obrigatório o preenchimento do campo Garantia S ou N!', ['&O k']);
        Result := False;
      End
      Else If (Pos('S',edtGarant.Text) <= 0) And (Pos('N',edtGarant.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'É obrigatório o preenchimento do campo Garantia S ou N !', ['&O k']);
        Result := False;
      End
      Else If fGarantiaDiferente(edtGarant.Text) Then    //Verifica se existe outro tipo de garantia S ou N já
      Begin
        fMensagem('ATENÇÃO!', 'Na mesma AD não podemos ter Garantias Diferentes! ' + #13#10 +
                              'A AD tem que ser Garatina = S ou N.' , ['&O k']);
        Result := False;
      End;
    End;

    blnMudarFoco := True;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadProdDevCRM.getCodCli: String;
begin
  Result := FCodCli;
end;

function TfrmCadProdDevCRM.getCodDev: String;
begin
  Result := FCodDev;
end;

function TfrmCadProdDevCRM.getCodEmp: String;
begin
  Result := FCodEmp;
end;

function TfrmCadProdDevCRM.getCodOco: String;
begin
  Result := FCodOco;
end;

function TfrmCadProdDevCRM.getConsul: Boolean;
begin
  Result := FConsul;
end;

function TfrmCadProdDevCRM.getDtaMov: TDate;
begin
  Result := FDtaMov;
end;

function TfrmCadProdDevCRM.getEspDoc: String;
begin
  Result := FEspDoc;
end;

function TfrmCadProdDevCRM.getForCli: String;
begin
  Result := FForCli;
end;

function TfrmCadProdDevCRM.getInsert: Boolean;
begin
  Result := FInsert;
end;

function TfrmCadProdDevCRM.getNomCli: String;
begin
  Result := FNomCli;
end;

function TfrmCadProdDevCRM.getNumDoc: String;
begin
  Result := FNumDoc;
end;

function TfrmCadProdDevCRM.getQtdDev: Double;
begin
  Result := FQtdDev;
end;

function TfrmCadProdDevCRM.getUniDev: Double;
begin
  Result := FUniDev;
end;

function TfrmCadProdDevCRM.getSeqGer: String;
begin
  Result := FSeqGer;
end;

function TfrmCadProdDevCRM.getSerie: String;
begin
  Result := FSerie;
end;

function TfrmCadProdDevCRM.getTip_FC: String;
begin
  Result := FTip_FC;
end;

procedure TfrmCadProdDevCRM.pCarregaItem(strCodIte: String);
begin
  With qryCadIte, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT SQL_NO_CACHE ');
    Add('  CADITE.*,   ');
    Add('  UNI_SIGUNI, ');
    Add('  UNI_DESUNI, ');
    Add('  IF(         ');
    Add('      IFNULL(ITE_CNV_ML, 0) = 0, ');
    Add('      1,                         ');
    Add('      ITE_CNV_ML                 ');
    Add('    ) AS CNV_ML                  ');

    Add('FROM CADITE');
    Add('INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
    Add('WHERE ITE_CODITE = :CODITE');
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    If Not IsEmpty Then
      edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadProdDevCRM.pCarregaOcorrencia;
begin
  pPesquisaCadOco(Nil, qryCadMot, edtCodMot.Text);
  With qryCadMot Do
  Begin
    edtDesMot.Text := FieldByName('OCO_DESOCO').AsString;
  End;
end;

procedure TfrmCadProdDevCRM.pCarregaUltVendas(strCodIte, strNomCol: String);
Begin
  If blnDevTotal Then
    Exit;

  Try
    pCriarFormularios(TfrmConsultaUltVenProdCRM,frmConsultaUltVenProdCRM);
    frmConsultaUltVenProdCRM.strCodIte := strCodIte;
    frmConsultaUltVenProdCRM.strCodEmp := IIF(fEmptyStr(FCodEmp), VS_strCodEmp, FCodEmp);
    frmConsultaUltVenProdCRM.strCodCli := FCodCli;
    frmConsultaUltVenProdCRM.pConsultaUltimasVendas(strNomCol);
    if not frmConsultaUltVenProdCRM.cdsUltVendas.IsEmpty then
    begin
      FbnlExisteVendasParaOProduto := True;

      frmConsultaUltVenProdCRM.strDiasGa := fRetornaDiasGarantia(edtCodIte.Text);
      frmConsultaUltVenProdCRM.ShowModal;
      if not fEmptyStr(frmConsultaUltVenProdCRM.strNumDoc) then
      begin
        strNumDoc := frmConsultaUltVenProdCRM.strNumDoc;
        strEspDoc := frmConsultaUltVenProdCRM.strEspDoc;
        dtaDtaMov := frmConsultaUltVenProdCRM.dtaDtaMov;
        fltQtdDev := frmConsultaUltVenProdCRM.fltQtdDev;
        fltUniDev := frmConsultaUltVenProdCRM.fltUniDev;
        strForCli := frmConsultaUltVenProdCRM.strForCli;
        strTip_FC := frmConsultaUltVenProdCRM.strTip_FC;
        strSerie_ := frmConsultaUltVenProdCRM.strSerie_;
        fltQtdDoc := frmConsultaUltVenProdCRM.fltQtdDoc;
        strSeqOri := frmConsultaUltVenProdCRM.strSeqOri;
      end;
    end
    Else
      FbnlExisteVendasParaOProduto := False;

  Finally
    FreeAndNil(frmConsultaUltVenProdCRM);
  End;
end;

procedure TfrmCadProdDevCRM.pEditaItem;
begin
  pMostraItem;
  pSetFocus(edtQtdIte);
end;

procedure TfrmCadProdDevCRM.pExcluiItem;
begin
  With cdsProdutos Do
  Begin
    If (Not IsEmpty) And fPergunta('Deseja excluir o item?') Then
      Delete;

    pLimpaItem;
  End;
end;

procedure TfrmCadProdDevCRM.pGravaItem;
begin
  With cdsProdutos Do
  Begin
    Case tipOperac Of
      opIncluir : begin
                    Insert;
                  end;
      opAlterar : Begin
                    Bookmark := strBookMark;
                    Edit;
                  End
      Else        Exit;
    End;

    FieldByName('CODMOT').AsString   := edtCodMot.Text;
    FieldByName('DESMOT').AsString   := edtDesMot.Text;
    FieldByName('QTDITE').AsFloat    := fStrToFloat(edtQtdIte.Text);
    FieldByName('GARANT').AsString   := IIF(edtGarant.Visible, edtGarant.Text, 'N');

    If tipOperac <> opAlterar Then
    Begin
      FieldByName('CODITE').AsString   := edtCodIte.Text;
      FieldByName('DESITE').AsString   := edtDesIte.Text;
      FieldByName('SIGUNI').AsString   := qryCadIte.FieldByName('UNI_SIGUNI').AsString;
      FieldByName('DOCULT').AsString   := fFormatDocUltimaCompra(FNumDoc,FEspDoc,FCodEmp);
      if FDtaMov > 0 then
        FieldByName('DTAULT').AsDateTime := FDtaMov
      else
        FieldByName('DTAULT').IsNull;
      FieldByName('VENULT').AsString := fRetornaVendedorUltCompra(FNumDoc,FEspDoc,FCodEmp);
      FieldByName('REFERE').AsString := qryCadIte.FieldByName('ITE_REFERE').AsString;
      FieldByName('DESUNI').AsString := qryCadIte.FieldByName('UNI_DESUNI').AsString;
      FieldByName('NUMDOC').AsString := FNumDoc;
      FieldByName('ESPDOC').AsString := FEspDoc;
      FieldByName('CODEMP').AsString := FCodEmp;
      FieldByName('QTDORI').AsFloat  := IIF(qryCadIte.FieldByName('CNV_ML').AsFloat <=0, FQtdDev, FQtdDev / qryCadIte.FieldByName('CNV_ML').AsFloat) ;
      FieldByName('UNITAR').AsFloat  := FUniDev;
      FieldByName('FORCLI').AsString := FForCli;
      FieldByName('TIP_FC').AsString := FTip_FC;
      FieldByName('SERIE_').AsString := FSerie;
      FieldByName('SEQORI').AsString := strSeqOri;
    End;

    Post;

    strCodIteAnt := '';
    strBookMark := nil;

    pLimpaItem;
  End;
end;

procedure TfrmCadProdDevCRM.pIniciaVenda;
begin
  pLimpaTela;
  if not FInsert then
    fConsultaDevolucao;
  pSetFocus(edtCodIte);
  If FConsul Then
    pSomenteConsulta;
end;

procedure TfrmCadProdDevCRM.pLimpaItem;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodMot.Clear;
  edtDesMot.Clear;
  edtGarant.Clear;
  edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, 0);
  dbgProdutos.Enabled := True;
  edtCodIte.Enabled := True;

  strNumDoc       := '';
  strEspDoc       := '';
  dtaDtaMov       := 0;
  fltQtdDev       := 0;
  fltUniDev       := 0;
  strProdLiber    := '';
  strProdGarLiber := '';
  strProdDevLiber := '';
  strCodIteAnt    := '';
  strSeqOri       := '';

  tipOperac := opIncluir;

  blnPermitirSelecionarDocumentos := False;

  pSetFocus(edtCodIte);
end;

procedure TfrmCadProdDevCRM.pLimpaTela;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtQtdIte.Clear;
  edtCodMot.Clear;
  edtDesMot.Clear;
  edtGarant.Clear;

  pLimpaItem;
end;

procedure TfrmCadProdDevCRM.pMostraItem;
begin

  If cdsProdutos.State In [dsEdit, dsInsert] Then
    Exit;

  If cdsProdutos.IsEmpty Then
    Exit;

  edtCodIte.Enabled := False;
  edtCodIte.Text := cdsProdutos.FieldByName('CODITE').AsString;
  edtDesIte.Text := cdsProdutos.FieldByName('DESITE').AsString;
  edtCodMot.Text := cdsProdutos.FieldByName('CODMOT').AsString;
  edtDesMot.Text := cdsProdutos.FieldByName('DESMOT').AsString;
  edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, cdsProdutos.FieldByName('QTDITE').AsFloat);
  edtGarant.Text := cdsProdutos.FieldByName('GARANT').AsString;
  fltQtdDev      := cdsProdutos.FieldByName('QTDORI').AsFloat;
  fltUniDev      := cdsProdutos.FieldByName('UNITAR').AsFloat;

  strNumDoc := cdsProdutos.FieldByName('NUMDOC').AsString;
  strEspDoc := cdsProdutos.FieldByName('ESPDOC').AsString;
  strCodEmp := cdsProdutos.FieldByName('SEQORI').AsString;

  strBookMark := cdsProdutos.GetBookMark;

  dbgProdutos.Enabled := False;

  tipOperac := opAlterar;

end;

procedure TfrmCadProdDevCRM.pSomenteConsulta;
begin
  pnlCabecalho.Enabled   := False;
  chkGerarColeta.Enabled := False;
end;

procedure TfrmCadProdDevCRM.setCodCli(const Value: String);
begin
  If (FCodCli <> Value) Then
    FCodCli := Value;
end;

procedure TfrmCadProdDevCRM.setCodDev(const Value: String);
begin
  If (FCodDev <> Value) Then
    FCodDev := Value;
end;

procedure TfrmCadProdDevCRM.setCodEmp(const Value: String);
begin
  If (FCodEmp <> Value) Then
    FCodEmp := Value;
end;

procedure TfrmCadProdDevCRM.setCodOco(const Value: String);
begin
  If (FCodOco <> Value) Then
    FCodOco := Value;
end;

procedure TfrmCadProdDevCRM.setConsul(const Value: Boolean);
begin
  If (FConsul <> Value) Then
    FConsul := Value;
end;

procedure TfrmCadProdDevCRM.setDtaMov(const Value: TDate);
begin
  If (FDtaMov <> Value) Then
    FDtaMov := Value;
end;

procedure TfrmCadProdDevCRM.setEspDoc(const Value: String);
begin
  If (FEspDoc <> Value) Then
    FEspDoc := Value;
end;

procedure TfrmCadProdDevCRM.setForCli(const Value: String);
begin
  FForCli := Value;
end;

procedure TfrmCadProdDevCRM.setInsert(const Value: Boolean);
begin
  If (FInsert <> Value) Then
    FInsert := Value;
end;

procedure TfrmCadProdDevCRM.setNomCli(const Value: String);
begin
  If (FNomCli <> Value) Then
    FNomCli := Value;
end;

procedure TfrmCadProdDevCRM.setNumDoc(const Value: String);
begin
  If (FNumDoc <> Value) Then
    FNumDoc := Value;
end;

procedure TfrmCadProdDevCRM.setQtdDev(const Value: Double);
begin
  If (FQtdDev <> Value) Then
    FQtdDev := Value;
end;

procedure TfrmCadProdDevCRM.setUniDev(const Value: Double);
begin
  If (FUniDev <> Value) Then
    FUniDev := Value;
end;

function TfrmCadProdDevCRM.ValidaEspecieDocumentoIncluidoAD: Boolean;
begin
  Result := True;

  If (cdsProdutos.RecordCount = 0) Then
    Exit;

  If (Pos(FEspDoc, 'NF_IF_') > 0) Then
  Begin
    cdsProdutos.Filter := 'ESPDOC = ' + QuotedStr('FF');
    cdsProdutos.Filtered := True;
    Result := (cdsProdutos.RecordCount = 0);
  End
  Else If (Pos(FEspDoc, 'FF_') > 0) Then
  Begin
    cdsProdutos.Filter := 'ESPDOC = ' + QuotedStr('NF') +  ' OR ESPDOC = ' + QuotedStr('IF') ;
    cdsProdutos.Filtered := True;
    Result := (cdsProdutos.RecordCount = 0);
  End;

  cdsProdutos.Filter := '';
  cdsProdutos.Filtered := False;
end;

procedure TfrmCadProdDevCRM.setSeqGer(const Value: String);
begin
  If (FSeqGer <> Value) Then
    FSeqGer := Value;
end;

procedure TfrmCadProdDevCRM.setSerie(const Value: String);
begin
  FSerie := Value;
end;

procedure TfrmCadProdDevCRM.setTip_FC(const Value: String);
begin
  FTip_FC := Value;
end;

function TfrmCadProdDevCRM.fValidaItensDevolucaoEmitidosDiasVencidos: Boolean;
  Var
    strChaveTmp: String;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;

    strDiaNF,
    strDiaFF,
    strDocEmi,
    strDtaEmi,
    strVenEmi,
    strIteEmi,
    strDesEmi,
    strQtdEmi,
    strValUni,
    strTotIte: String;

  function fDiasPassadosDoctoOriginal(dtaDtaDev: TDateTime): Integer;
  begin
    Result := DaysBetween(VS_Date, dtaDtaDev);
  end;

  function fRetornaChaveAcesso(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
    Var
      qryAux: TUniQuery;
      function fRetornaSql(strTabGer, strTabDet: String): String;
      begin
        Result := '';
        Result := Result + 'SELECT ';
        Result := Result + '  FIS_ACESSO ';
        Result := Result + 'FROM ';
        Result := Result + '  CADFIS ';
        Result := Result + 'JOIN ' + strTabGer + ' G ON G.GER_NUMDOC = FIS_NUMDOC AND ';
        Result := Result + '                            G.GER_ESPDOC = FIS_ESPDOC AND ';
        Result := Result + '                            G.GER_CODEMP = FIS_CODEMP AND ';
        Result := Result + '                            IFNULL(G.GER_CODFOR, G.GER_CODCLI) = FIS_FORCLI AND ';
        Result := Result + '                            G.GER_TIP_FC = FIS_TIP_FC AND ';
        Result := Result + '                            G.GER_TIP_FC = FIS_TIP_FC ';

        Result := Result + 'JOIN ' + strTabDet + ' D ON D.DET_SEQGER = G.AUTOINCREM ';
        Result := Result + 'WHERE ';
        Result := Result + '  D.DET_NUMDOC = :NUMDOC AND ';
        Result := Result + '  D.DET_ESPDOC = :ESPDOC AND ';
        Result := Result + '  D.DET_CODEMP = :CODEMP AND ';
        Result := Result + '  D.DET_CODCLI = :CODCLI ';
      end;
  begin
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Add(fRetornaSql('MOVGER', 'MOVDET'));
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    If (qryAux.IsEmpty) Then
    Begin
      qryAux.SQL.Clear;
      qryAux.SQL.Add(fRetornaSql('NOTGER', 'NOTDET'));
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.Open;
    End;

    Result := qryAux.FieldByName('FIS_ACESSO').AsString;

    FreeAndNil(qryAux);
  end;
begin
  Result := True;

  strDiaNF := fStrZero(IntToStr(fCfgSis('DIADVE', VarInteger)), 3);
  strDiaFF := fStrZero(IntToStr(fCfgSis('DIADEV', VarInteger)), 3);

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(119);
  objLiberacao.objMsgLibera.pAddTexto('<<<   Devolução com Documentos Emitidos Fora do Prazo   >>>', alCentro, teAmbos, '', 119);
  objLiberacao.objMsgLibera.pAddSeparador(119);
  objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade de dias limite para Devolução - Nota Eletrônica'   , strDiaNF + ' dias', 60);
  objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade de dias limite para Devolução - Demais Documentos' , strDiaFF + ' dias', 60);
  objLiberacao.objMsgLibera.pAddSeparador(119);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'  , FCodCli + '-' + FNomCli                                             , 9);
  objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor' , strLoginUsuarioLogado + '-' + fRetNomVendRep(strLoginUsuarioLogado) , 9);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'Documento'  , 20  , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Dt.Emissão' , 11 , alCentro    , teAutcom);
  objLinha.pAddColuna(''  , 'Ven'        , 3  , alCentro    , teAutcom);
  objLinha.pAddColuna(''  , 'Cód.'       , fTamCodIte, alCentro    , teAutcom);
  objLinha.pAddColuna(''  , 'Produto'    , 20 , alEsquerda  , teAutcom);
  objLinha.pAddColuna(''  , 'Quantidade' , 12 , alDireita   , teAutcom);
  objLinha.pAddColuna(''  , 'Vr.Unitário', 11 , alDireita   , teAutcom);
  objLinha.pAddColuna(''  , 'Vr.Total'   , 16 , alDireita   , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  With cdsProdutos Do
  Begin
    First;

    While Not Eof Do
    Begin

      If Not fEhItemServico(cdsProdutosCODITE.AsString) Then
      Begin
        strChaveTmp := fRetornaChaveAcesso(cdsProdutosNUMDOC.AsString,
                                           cdsProdutosESPDOC.AsString,
                                           cdsProdutosCODEMP.AsString,
                                           cdsProdutosFORCLI.AsString);

        If (((Not fEmptyStr(strChaveTmp)) And
             (Not cdsProdutosDTAULT.IsNull) And
             (fDiasPassadosDoctoOriginal(cdsProdutosDTAULT.AsDateTime) > fCfgSis('DIADVE', varInteger)))
                                                                                                          Or
             (fEmptyStr(strChaveTmp)      And
             (Not cdsProdutosDTAULT.IsNull) And
             (fDiasPassadosDoctoOriginal(cdsProdutosDTAULT.AsDateTime) > fCfgSis('DIADEV', varInteger)))) Then
        Begin
          strDocEmi := cdsProdutosNUMDOC.AsString + '-' + cdsProdutosESPDOC.AsString + '-' + cdsProdutosCODEMP.AsString;
          strDtaEmi := FormatDateTime('dd/mm/yyyy', cdsProdutosDTAULT.AsDateTime);
          strVenEmi := LeftStr(cdsProdutosVENULT.AsString, 3);
          strIteEmi := cdsProdutosCODITE.AsString;
          strDesEmi := fPadR(cdsProdutosDESITE.AsString, 20);
          strQtdEmi := fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsProdutosQTDITE.AsFloat), 12);
          strValUni := fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), cdsProdutosUNITAR.AsFloat), 11);
          strTotIte := fPadL(FormatFloat(fMskDigitos(2), cdsProdutosQTDITE.AsFloat * cdsProdutosUNITAR.AsFloat), 16);

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Documento'  , strDtaEmi , 20  , alEsquerda );
          objLinha.pAddColuna('Dt.Emissão' , strDtaEmi , 11 , alCentro    );
          objLinha.pAddColuna('Ven'        , strVenEmi , 3  , alCentro    );
          objLinha.pAddColuna('Cód.'       , strIteEmi , fTamCodIte, alCentro    );
          objLinha.pAddColuna('Produto'    , strDesEmi , 20 , alEsquerda  );
          objLinha.pAddColuna('Quantidade' , strQtdEmi , 12 , alDireita   );
          objLinha.pAddColuna('Vr.Unitário', strValUni , 11 , alDireita   );
          objLinha.pAddColuna('Vr.Total'   , strTotIte , 16 , alDireita   );
          objTabela.lstLinhas.Add(objLinha);

          Result := False;
        End;
      End;

      Next;
    End;

    objLiberacao.objMsgLibera.lstRegistros.add(objTabela);
  End;


  If Not Result Then
  begin
    objLiberacao.strDirAce := 'DIAVEN';
    objLiberacao.strSenLib := fCfgSis('DIAVEN');
    objLiberacao.strMsgSen := 'Devolução de Documentos';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.strtitulo := 'Devolução com Documentos Emitidos Fora do Prazo';

    Result := objLiberacao.fLibera;
  end;
end;

function TfrmCadProdDevCRM.fValidaTotalQuantidadeDev: Boolean;
var
  fltTotalEmDevolucao: Double;
begin
  Result := True;

  If blnDevTotal Then
    Exit;

  fltTotalEmDevolucao := fRetQuantidadeTotalEmDevolucao;

  Result := fltTotalEmDevolucao <= fFormataFloat(fltQtdDoc, 2);
end;

function TfrmCadProdDevCRM.fRetQuantidadeTotalEmDevolucao: Double;
begin
  If tipOperac = opAlterar Then
    Result := fFormataFloat(fStrToFloat(edtQtdIte.Text), 2) + fFormataFloat(fQuantidadeEmDevolucao, 2) - cdsProdutosQTDITE.AsFloat
  Else
    Result := fFormataFloat(fStrToFloat(edtQtdIte.Text), 2) + fFormataFloat(fQuantidadeEmDevolucao, 2);
end;

end.

