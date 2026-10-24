unit untGarantiaEnvFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, DB, UniClientDataSet, Grids,
  DBGridCitel, DBGrids, EditFocus, Uni, strUtils, untGarant, AppEvnts, frxClass, frxDMPExport,
  frxDBSet, BitBtnLockedIncrem, untFuncFat, ComCtrls, untTypesSistema, Math,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, cxLookAndFeels,
  cxLookAndFeelPainters, untZClient, cxNavigator, frxExportCSVTestabilidade, untEditorFastImpressao, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTLock, untExcel, untGeraExcel,
  untTControladorEnvioFornecedor;

const
  NAO_EXPORTANDO_PLANILHA = 0;
  EXPORTANDO_PLANILHA = 1;

 type
  TDocSelecionado = class
  public
    AutoIncrem: String;
    strNUMDOC: String;
    strESPDOC: String;
    strSERIE_: String;
    strCODEMP: String;
    strCODITE: String;
    strDESITE: String;
    fltUNITAR: Double;
    fltALQIPI: Double;
    strREFERE: String;
    strACESSO: String;
    strORDITE: String;
    strINCGAR: String;
    fltQtdDev,
    fltQtdIte: Double;
    blnTemSaldo: Boolean;
    Reg: TBookmark;
  end;

type
  TfrmGarantiaEnvFornecedor = class(TfrmPai)
    pnlFornecedor: TPanel;
    Label1: TLabel;
    edtNomFor: TEditFocus;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosDTAENT: TDateTimeField;
    dtsProdutos: TDataSource;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESITE: TStringField;
    cdsProdutosREFERE: TStringField;
    cdsProdutosUNIDAD: TStringField;
    cdsProdutosNUMENT: TStringField;
    cdsProdutosQTDREQ: TFloatField;
    cdsProdutosDTAENV: TDateTimeField;
    edtCodFor: TEditFocus;
    cdsProdutosAUTINC: TStringField;
    cdsProdutosQTDREQ_1: TFloatField;
    cdsProdutosAGG_QTDREQ_1: TAggregateField;
    frxDBGarantia: TfrxDBDataset;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    cdsProdutosCODFAB: TStringField;
    btnConfirmar: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnSemelhantes: TBitBtnLocked;
    cdsProdutosCODCLI: TStringField;
    cdsProdutosPRECUS: TFloatField;
    cdsProdutosTABPRE: TStringField;
    Label2: TLabel;
    btnExcel: TBitBtnLocked;
    pbProgresso: TProgressBar;
    cxgProdutos: TcxGrid;
    cxgProdutosDBTableView1: TcxGridDBTableView;
    cxgProdutosLevel1: TcxGridLevel;
    cxgProdutosNUMENT: TcxGridDBColumn;
    cxgProdutosCODITE: TcxGridDBColumn;
    cxgProdutosCODFAB: TcxGridDBColumn;
    cxgProdutosDESITE: TcxGridDBColumn;
    cxgProdutosREFERE: TcxGridDBColumn;
    cxgProdutosUNIDAD: TcxGridDBColumn;
    cxgProdutosDTAENT: TcxGridDBColumn;
    cxgProdutosNUMDOC: TcxGridDBColumn;
    cxgProdutosQTDREQ: TcxGridDBColumn;
    cxgProdutosDTAENV: TcxGridDBColumn;
    btnUltCompras: TBitBtnLocked;
    frxDocEnvioJ: TfrxReport;
    frxDocEnvioM: TfrxReport;
    Label3: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    cdsProdutosNUMDOC: TStringField;
    chbVenPre: TCheckBox;
    btnSelecionados: TBitBtnLocked;
    cdsProdutosNOMCLI: TStringField;
    cxgProdutosNOMCLI: TcxGridDBColumn;
    cdsProdutosFIS_ACESSO: TStringField;
    cdsProdutosVLRTOT: TFloatField;
    cdsProdutosNFENTRADA: TStringField;
    chkNaoSintetizarItens: TCheckBox;
    cdsProdutosOBSP_1: TStringField;
    cxgProdutosOBSP_1: TcxGridDBColumn;
    cdsProdutosCODFOR: TStringField;
    cxgProdutosCODEMP: TcxGridDBColumn;
    cdsProdutosGAD_CODEMP: TStringField;
    cdsProdutosDOCDEV: TStringField;
    cdsProdutosEMPDEV: TStringField;
    cdsProdutosESPDEV: TStringField;
    cdsProdutosINCDEV: TStringField;
    cdsProdutosINCTMP: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure dbgProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgProdutosDblClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtsProdutosDataChange(Sender: TObject; Field: TField);
    procedure btnSemelhantesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure cxgProdutosDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure btnUltComprasClick(Sender: TObject);
    procedure cdsProdutosAfterScroll(DataSet: TDataSet);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure cdsProdutosBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnSelecionadosClick(Sender: TObject);
  private
    { Private declarations }
    FblnMarcarTodos: Boolean;
    FValidarQtdDevolvidaDocumento: Boolean;
    FControladorEnvioFornecedor: TControladorEnvioFornecedor;
    FblnUsaEspelho: Boolean;
    lstDocSel: TStringList;
    blnGFIREF: Boolean; //Ao gerar envio para fornecedor, incluir a "referência" na descrição do item
    blnInformarChaveNotaEntrada: Boolean;
    blnEfvApr: Boolean;
    blnImpRef: Boolean;
    fatVenda : TFatVenda;
    objMovGag: TMovGag;
    cdsGroup : TUniClientDataSet;
    cdsDocEnt: TZClient;
    strNumPedGer: String;
    arrMarca : TConsultasArray;
    intQtdMar: Integer;
    blnEmpGar,
    blnGarMat: Boolean;
    dtaDtaIni : TDateTime;
    dtaDtaFim : TDateTime;
    enuTipoEnvioFornecedorGarantia : TTipoEnvioFornecedorGarantia;
    intDecUni: Integer;
    objLock : TLock;

    blnGFSDOC: Boolean;
    blnFabNfe: Boolean;
    blnGCP949: boolean;
    strClaGae: String;

    blnCFG_GARIND: Boolean;
    strFornecedorFilial: String;
    strCnpjFornecedor: String;
    blnAdicionarDocOrigemObservacoesNotaGF: Boolean;
    function fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
    function fGetCfopEnvioFornecedor(fatVenda: TFatVenda): Boolean;
    function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fIncluiItens(fatVenda: TFatVenda): Boolean;
    function fAlterarPrecosItensEnvioFornecedor(pstrIncAlteracaoPreco: TStrings): Boolean;
    function fConfirma(var strNumDoc, strEspDoc, strSerie_: string) : Boolean;
    function fPrecoEnvio(qryGenIte: TUniQuery): Double;
    function fCarregaDocEnt(strAutIncGar: String): Boolean;
    procedure pInicializaTemporaria;
    procedure pCarregaTabelaProdutos(qryFornec: TUniQuery;cdsProdutos: TUniClientDataSet);
    procedure pSelecionaProduto(pblnMarcar: Boolean; blnTodos: Boolean = False);overload;
    procedure pSelecionaProduto(Sender: TObject; blnTodos: Boolean = False);overload;
    procedure pImprimeDocumento(strNumDoc, strEspDoc : String; DataSet : TUniClientDataSet);
    procedure pAlteraSemelhante;
    procedure pCarregaDadosFornecedor(strCodFor:String);
    function fTrataEnvioFornecedorGarantia(strNumDoc, strEspDoc, strSerie_: String): Boolean;
    function fValidarSelecaoDocumentoOrigem: Boolean;
    procedure pSepararProdutosParaEnvio(Out blnTemItemSemDocVenda: Boolean);
    function fGerarCreditoPagarEnvioFornecedorCFOPX949(const strClaFis: String): Boolean;
    function fPermitirEnvioFornecedor(const strCodFor: String): boolean;
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(Var Totais: TTotais; Dados: TDataSet);
    function fObterMensagemDocDev: String;
    function fTipoFaturamentoRequerDocumentoDevolucao: Boolean;
    function fValidaDocumentosSelecionadosComFornecedor: Boolean;
    function fTravaDeRegistro(const pstrAutInc: String; const pblnTravar: Boolean): Boolean;
    function fCriarTabelaProdutosEnvio: TUniClientDataSet;
    function fPermitirInformarChaveNFReferenciada: Boolean;
    procedure pSepararDocEnt;
    procedure pCriarFatVenda;
  public
    { Public declarations }

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

Const
  MSG_IMPRESSINV = 'Houve um erro ao enviar o documento para a impressora.' + #13#10 +
                   'Verifique se a impressora selecionada é válida ou seu nome está digitado corretamente.';

implementation

uses untFuncoes, untFuncoesSimples, untCfgRel, untConsultas, untFuncoesConsulta,
     untFatTipoFaturamento, untGravando, untFatDadosFiscais, untFuncFatTypes,
     untFatDigDadosGarantia,  untGarantiaAltPrecosEnvFornecedor,
     untObsGarantia, untConstantesNFe, untFatDigDesconto, untFuncoesRel, untFuncoesRel2,
     untMovGer, untConstantes, untGarantiaEnvFornecedorSelNE, untFatDigDatas,
     untGarantiaEnvFornecedorResumo, untFatDigChaveDev,
     untGarantiaLibDiversos, untReferenciarDocumentos, untFatImpressao;
{$R *.dfm}

{ TfrmGarantiaEnvFornecedor }

{*******************************************}
{* VALIDA CAMPOS                           *}
{****************************************RL*}
function TfrmGarantiaEnvFornecedor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA FORNECEDOR                     *}
    {**************************************RL*}
    If Sender = edtCodFor Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O fornecedor deve ser preenchido!' , ['&Ok']);
        Result := False;
      End

      Else
      Begin

        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('AVISO','Fornecedor não encontrado!', ['&O K']);
          pSetFocus(edtCodFor);
          Result := False;
        End
        Else
        If (untFuncoesSimples.fCadFor('STATUS', edtCodFor.Text) <> 'A') Then
        Begin
          fMensagem('ATENÇÃO!', 'O fornecedor esta inativo!' , ['&Ok']);
          Result := False;
        End;

        if Not fPermitirEnvioFornecedor(edtCodFor.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Não é permitido envio para fornecedor filial "Própria Empresa" se CFG_GARIND = S' , ['&Ok']);
          Result := False;
        end;
      End;
      If Result then
        strCnpjFornecedor := fRetCgcCpfFornecedor(edtCodFor.Text)
      else
        strCnpjFornecedor := EmptyStr;
    End

    Else
    If (Sender = edtCodMar) then
    Begin
      if fValidaCampos(edtCodFor, True) Then
      Begin
        objMovGag.objMovGad.pCarregaProdutosTroca(edtCodFor.Text, edtCodMar, arrMarca);

        If objMovGag.objMovGad.qryFornec.IsEmpty Then
        Begin
          fMensagem('', 'Não existe produtos para enviar para este fornecedor!', ['&Ok']);
          Result := False;
        End

        Else
          pCarregaTabelaProdutos(objMovGag.objMovGad.qryFornec, cdsProdutos);

        objMovGag.objMovGad.qryFornec.Close;
      End;
    End;

  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

function TfrmGarantiaEnvFornecedor.fPermitirEnvioFornecedor(const strCodFor: String): boolean;
begin
  if blnCFG_GARIND then
    Result := strCodFor <> strFornecedorFilial
  Else
    Result := True;
end;

function TfrmGarantiaEnvFornecedor.fValidaDocumentosSelecionadosComFornecedor: Boolean;
begin
  Result := True;

  If cdsProdutos.IsEmpty Then
    Exit;

  Try
    cdsProdutos.First;
    While Not cdsProdutos.Eof do
    Begin

      If (cdsProdutos.FieldByName('CODFOR').AsString <> edtCodFor.Text) Then
      Begin
        Result := False;
        Break;
      End;

      cdsProdutos.Next;
    End;

  Finally
    cdsProdutos.First;
  End;
end;

function TfrmGarantiaEnvFornecedor.fPrecoEnvio(qryGenIte: TUniQuery): Double;
begin
  Result := cdsGroup.FieldByName('PRECUS').AsFloat;

  If (fCfgSis('ENVFOP') = 'PRECUS') Then
    Result := cdsGroup.FieldByName('PRECUS').AsFloat
  Else If (fCfgSis('ENVFOP') = 'COMLIQ') Then
    Result := fCalculaPrecoCompraLiq(qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                     qryGenIte.FieldByName('ITE_DESF01').AsFloat,
                                     qryGenIte.FieldByName('ITE_DESF02').AsFloat,
                                     qryGenIte.FieldByName('ITE_DESF03').AsFloat,
                                     qryGenIte.FieldByName('ITE_DESF04').AsFloat,
                                     qryGenIte.FieldByName('ITE_DESF05').AsFloat,
                                     qryGenIte.FieldByName('ITE_DESF06').AsFloat,
                                     intDecUni,
                                     qryGenIte.FieldByName('ITE_PREDOL').AsString = 'S');
end;


function TfrmGarantiaEnvFornecedor.fTipoFaturamentoRequerDocumentoDevolucao: Boolean;
begin
  Result := fatVenda.strEspDoc = 'NF';
end;

function TfrmGarantiaEnvFornecedor.fTrataEnvioFornecedorGarantia(strNumDoc, strEspDoc, strSerie_ : String) : Boolean;
begin
  Result := True;

  If (fCfgSis('GARMAT',varBoolean)) then
    Result := objMovGag.objMovGad.fBaixaPedidoVenda(cdsProdutos, strNumDoc, strEspDoc);

  If result then
  begin
    Result := objMovGag
                .objMovGad
                  .fAtualizaProdutosTroca(cdsProdutos,
                                          strNumDoc,
                                          strEspDoc,
                                          strSerie_,
                                          VS_strCodEmp,
                                          enuTipoEnvioFornecedorGarantia,
                                          Nil);
  end;
end;

procedure TfrmGarantiaEnvFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  FblnMarcarTodos := False;
  FblnUsaEspelho := fCfgSis('OUSAFO', varString) = '2';
  blnFabNfe := fCfgSis('FABNFE', varString) = 'S';
  blnGFIREF := (fCfgSis('GFIREF', varBoolean));
  blnInformarChaveNotaEntrada := fCfgSis('ENFPCH', VarBoolean);
  blnEfvApr := (fCfgSis('EFVAPR', varBoolean));
  blnImpRef := fCfgSis('IMPREF', varBoolean);
  blnEmpGar := (fCfgSis('EMPGAR', varString) = VS_strCodEmp);
  blnGarMat := (fCfgSis('GARMAT', varString) = 'S');
  intDecUni := fCfgSis('DECUNI', varInteger);
  blnGFSDOC := fCfgSis('GFSDOC', varString) = 'S';
  FValidarQtdDevolvidaDocumento := fCfgSis('GFVQTD', varString) = 'S';
  blnAdicionarDocOrigemObservacoesNotaGF :=  fCfgSis('ADONGF', varString) = 'S';

  objMovGag               := TMovGag.Create(Self);

  pCriarCdsVenda(Self);
  pCriarFatVenda;

  pSetaCodIte(cdsProdutosCODITE);
  cdsProdutos.CreateDataSet;
  cdsProdutos.FieldDefs[0].Size := fTamCodIte;

  cdsGroup           := TUniClientDataSet.Create(Self);
  cdsGroup.FieldDefs := cdsProdutos.FieldDefs;
  cdsGroup.CreateDataSet;

  cdsDocEnt := TZClient.Create(Self, fGetSqlSelNotas(False, (blnEmpGar and blnGarMat)));
  cdsDocEnt.fAbreClient(True,'TfrmGarantiaEnvFornecedor.FormCreate');

  intQtdMar := 0;
  dtaDtaIni := 0;
  dtaDtaFim := 0;
  objLock := TLock.Create;

  blnGCP949 := fCfgSis('GCP949', varString) = 'S';
  strClaGae := fCfgSis('CLAGAE', varString);

  blnCFG_GARIND := fCfgSis('GARIND', varString) = 'S';
  strFornecedorFilial := fObterFornecedorFilial(VS_strCodEmp);
  lstDocSel := TStringList.Create;
  lstDocSel.Clear;
end;

procedure TfrmGarantiaEnvFornecedor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(lstDocSel);
  FreeAndNil(cdsDocEnt);
  if Assigned(fatVenda) then
    FreeAndNil(fatVenda);
  if Assigned(FControladorEnvioFornecedor) then
    FreeAndNil(FControladorEnvioFornecedor);
  inherited;
end;

{*******************************************}
{* CARREGA TABELA DE PRODUTOS              *}
{****************************************RL*}
procedure TfrmGarantiaEnvFornecedor.pCarregaDadosFornecedor(strCodFor:String);
  Var
    strSQL: String;
    qryDados: TUniQuery; 
begin
  qryDados := fCriaQuery(Self);

  Try

    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_I_E_S_, ';
    strSQL := strSQL + '   FOR_CODATI, ';
    strSQL := strSQL + '   FOR_CODFOR, ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_NOMFOR, ';
    strSQL := strSQL + '   FOR_ENDERE, ';
    strSQL := strSQL + '   FOR_ENDNUM, ';
    strSQL := strSQL + '   FOR_ENDCOM, ';
    strSQL := strSQL + '   FOR_BAIRRO, ';
    strSQL := strSQL + '   FOR_C_E_P_, ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_FONE01, ';
    strSQL := strSQL + '   FOR_C_G_C_, ';
    strSQL := strSQL + '   FOR_CGCCPF, ';
    strSQL := strSQL + '   FOR_CGCCPF, ';
    strSQL := strSQL + '   FOR_EMAIL_  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADFOR      ';
    strSQL := strSQL + ' WHERE         ';
    strSQL := strSQL + '   FOR_CODFOR = :CODFOR ';

    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      Open;
    End;

    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliIes := qryDados.FieldByName('FOR_I_E_S_').AsString;
    fatVenda.strCliAti := qryDados.FieldByName('FOR_CODATI').AsString;
    fatVenda.strCodCli := qryDados.FieldByName('FOR_CODFOR').AsString;
    //fatVenda.strCodFor := qryDados.FieldByName('FOR_CODFOR').AsString;
    fatVenda.strCodVen := strLoginUsuarioLogado;
    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliNom := qryDados.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliOri := qryDados.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliEnd := qryDados.FieldByName('FOR_ENDERE').AsString;
    fatVenda.strCliNum := qryDados.FieldByName('FOR_ENDNUM').AsString;
    fatVenda.strCliCom := qryDados.FieldByName('FOR_ENDCOM').AsString;
    fatVenda.strCliBai := qryDados.FieldByName('FOR_BAIRRO').AsString;
    fatVenda.strCliCep := qryDados.FieldByName('FOR_C_E_P_').AsString;
    fatVenda.strCodCid := qryDados.FieldByName('FOR_CODCID').AsString;
    fatVenda.strCliCid := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 0);
    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliTel := qryDados.FieldByName('FOR_FONE01').AsString;
    fatVenda.strCliCgc := qryDados.FieldByName('FOR_C_G_C_').AsString;
    fatVenda.intCgcCpf := qryDados.FieldByName('FOR_CGCCPF').AsInteger;
    fatVenda.strCliIes := qryDados.FieldByName('FOR_I_E_S_').AsString;
    fatVenda.strCliEma := qryDados.FieldByName('FOR_EMAIL_').AsString;
    fatVenda.strCliEm2 := '';
    fatVenda.strCliCon := 'N';
    fatVenda.strTabPre := '1';

    qryDados.Close;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCarregaDadosFornecedor]');
      FreeAndNil(qryDados);      
      Exit;
    End;
  End;

  FreeAndNil(qryDados);
end;

procedure TfrmGarantiaEnvFornecedor.pCarregaTabelaProdutos(
  qryFornec: TUniQuery; cdsProdutos: TUniClientDataSet);
begin
  intQtdMar := 0;
  cdsProdutos.EmptyDataSet;
  cdsProdutos.DisableControls;
  if Assigned(FControladorEnvioFornecedor) then
    FControladorEnvioFornecedor.Free;
  FControladorEnvioFornecedor := TControladorEnvioFornecedor.Create(edtCodFor.Text);
  FControladorEnvioFornecedor.blnEmpGar := blnEmpGar;
  FControladorEnvioFornecedor.blnGarMat := blnGarMat;
  FControladorEnvioFornecedor.blnEfvApr := blnEfvApr;
  FControladorEnvioFornecedor.blnGFSDoc := blnGFSDoc;
  FControladorEnvioFornecedor.intDecUni := intDecUni;
  FControladorEnvioFornecedor.blnValidarQtdDevolvidaDocumento := FValidarQtdDevolvidaDocumento;

  With objMovGag.objMovGad.qryFornec Do
    While Not Eof Do
    Begin

      cdsProdutos.Insert;
      cdsProdutos.FieldByName('AUTINC').AsString   := FieldByName('AUTINC').AsString;
      cdsProdutos.FieldByName('CODITE').AsString   := FieldByName('CODITE').AsString;
      cdsProdutos.FieldByName('CODFAB').AsString   := FieldByName('CODFAB').AsString;
      cdsProdutos.FieldByName('DESITE').AsString   := FieldByName('DESITE').AsString;
      cdsProdutos.FieldByName('REFERE').AsString   := FieldByName('REFERE').AsString;
      cdsProdutos.FieldByName('UNIDAD').AsString   := FieldByName('UNIDAD').AsString;
      cdsProdutos.FieldByName('NUMENT').AsString   := FieldByName('NUMENT').AsString;
      cdsProdutos.FieldByName('QTDREQ').AsFloat    := FieldByName('QTDREQ').AsFloat;
      cdsProdutos.FieldByName('QTDREQ_1').AsFloat  := FieldByName('QTDREQ').AsFloat;
      cdsProdutos.FieldByName('DTAENT').AsDateTime := FieldByName('DTAENT').AsDateTime;
      cdsProdutos.FieldByName('DTAENV').AsDateTime := FieldByName('DTAENV').AsDateTime;
      cdsProdutos.FieldByName('CODCLI').AsString   := FieldByName('CODCLI').AsString;
      cdsProdutos.FieldByName('NOMCLI').AsString   := FieldByName('NOMCLI').AsString;
      cdsProdutos.FieldByName('PRECUS').AsFloat    := FieldByName('PRECUS').AsFloat;
      cdsProdutos.FieldByName('TABPRE').AsString   := IIF(fEmptyStr(FieldByName('TABPRE').AsString),'1',FieldByName('TABPRE').AsString);
      cdsProdutos.FieldByName('CODFAB').AsString   := FieldByName('CODFAB').AsString;
      cdsProdutos.FieldByName('NUMDOC').AsString   := FieldByName('NUMDOC').AsString;
      cdsProdutos.FieldByName('OBSP_1').AsString   := FieldByName('OBSP_1').AsString;
      cdsProdutos.FieldByName('CODFOR').AsString   := FieldByName('CODFOR').AsString;
      cdsProdutos.FieldByName('GAD_CODEMP').AsString   := FieldByName('CODEMP').AsString;
      cdsProdutos.FieldByName('DOCDEV').AsString   := '';
      cdsProdutos.FieldByName('ESPDEV').AsString   := '';
      cdsProdutos.FieldByName('EMPDEV').AsString   := '';
      cdsProdutos.FieldByName('INCDEV').AsString   := '';
      cdsProdutos.FieldByName('FIS_ACESSO').AsString   := '';
      cdsProdutos.Post;

      Next;

    End;

  cdsProdutos.First;
  cdsProdutos.EnableControls;
end;

procedure TfrmGarantiaEnvFornecedor.pCriarFatVenda;
begin
  if fatVenda <> Nil then
    Exit;
  Try
    fatVenda                := TFatVenda.CreateInstance('VN');
    fatVenda.strOpcDocTrue  := 'NG';
    fatVenda.blnVerEstOrc   := False;
    fatVenda.strNomeForm    := 'frmFatVendas';
    fatVenda.fTrataEnvioFornecedorGarantia := fTrataEnvioFornecedorGarantia;
  Except
    On E: Exception do
    begin
      if fatVenda <> Nil then
        FreeAndNil(fatVenda);
      pMensagemOk('Ocorreu uma falha ao tentar criar instância de faturamento. Contate a Citel!');
    end;
  End;
end;

Function TfrmGarantiaEnvFornecedor.fConfirma(var strNumDoc, strEspDoc, strSerie_: string) : Boolean;
Var
  blnConfirma: Boolean;
  strEstEmp: String;
  lstgIncAlteracaoPreco: TStrings;

  function fSelecionouCfopDevolucao: Boolean;
  begin
    Result := Pos(RightStr(fatVenda.strClaFisEnvGarantia, 3), fCfgSis('CLAALP',varString) ) > 0;
  end;

begin
  Result := False;

  pCriarFatVenda;
  if fatVenda = Nil then
    Exit;

  pSepararDocEnt;
  lstgIncAlteracaoPreco:= TStringList.Create;
  lstgIncAlteracaoPreco.Clear;
  Try
    TMovGad.fCriarMovGaeTemporaria;
    Try
      If Not cdsProdutos.Active Then
        Exit;

      If fEmptyStr(fCfgSis('CLARGF')) Then
      Begin
        pMensagemOK('A classificação fiscal de Envio para Conserto não foi configurada.');
        Exit;
      End;

      pCarregaDadosFornecedor(edtCodFor.Text);
      pInicializaTemporaria;

      fatVenda.strOpcDoc := 'GF';
      fatVenda.strOriDoc := 'V';
      fatVenda.strCodVen := strLoginUsuarioLogado;
      fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
      fatVenda.strConPag := '01000';
      fatVenda.strCodForTe := edtCodFor.Text;
      fatVenda.blnVendaPresencial := chbVenPre.Checked;
      fatVenda.strEntFat := IfThen(chbVenPre.Checked, 'N', 'S');
      fatVenda.enuTipoEnvioFornecedorGarantia := enuTipoEnvioFornecedorGarantia;

      blnConfirma := fGetTipoFaturamento(fatVenda)     And
                     fIncluiItens(fatVenda)            And
                     fGetCfopEnvioFornecedor(fatVenda)  ;

      fatVenda.blnAlterouPrecoGF := False;
      If blnConfirma And fSelecionouCfopDevolucao Then
        blnConfirma := fAlterarPrecosItensEnvioFornecedor(lstgIncAlteracaoPreco);

      If (blnConfirma) Then
      Begin
        if fatVenda.blnAlterouPrecoGF then
        begin
          if Assigned(fatVenda.objItensNotaEspelho) Then
          begin
            TItensNotaEspelhoEnvioFornecedor(fatVenda.objItensNotaEspelho).pAddListaItensAlterados(lstgIncAlteracaoPreco);
          end;
        end;
        fatVenda.pCarregaAliquotasRetencao;

        fatVenda.pPreencheMatrizFechamento;

        fatVenda.pCalculaPesBruLiq;

        fatVenda.pCalculaTotGer(False, False);

        If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
        Begin
          If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
            fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
        End;

        fatVenda.pDestacaRetencoes;
        fatVenda.pRetemImpostosNoDescontoEspecial;

        If (fatVenda.fEhDevolucaoEspelhoOuParaFornecedor) Then
          fatVenda.pCalculaDescontoEspecialDevolucaoFornecedor;

        fatVenda.pCalculaTotGer(False, False);

        fatVenda.strClaFis := fatVenda.strClaFisEnvGarantia;
        fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

        fatVenda.pCalculaTotGer;

        fatVenda.pCalculaTotalParaCadRec;

        fatVenda.pRateiaValores;

        If (fatVenda.fEhDevolucaoEspelhoOuParaFornecedor) Then
          fatVenda.pAjustarDescontoEspecialDevolucaoFornecedorConformeNotasOriginais;

        if blnAdicionarDocOrigemObservacoesNotaGF then
          fatVenda.strMen001 := fatVenda.strMen001 + fObterMensagemDocDev;

        If blnConfirma Then
        Begin
          If (fatVenda.strEspDoc = 'NF') Then
          Begin
            Try
              pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);

              strEstEmp := fRetUFEmpresa;

              frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text    := fatVenda.strClafis;
              frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text    := fatVenda.strDesCla;
              frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
              frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := True;
              frmFatDadosFiscais.blnForcaEdiBas    := True;
              frmFatDadosFiscais.fatVenda := fatVenda;

              frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
              frmFatDadosFiscais.blnPodeCancelar := True;
              frmFatDadosFiscais.ShowModal;

              blnConfirma := frmFatDadosFiscais.blnConfirma;

            Except
              On E: Exception Do
              Begin
                blnConfirma := False;
                pMensagensErro(E.Message, '');
              End;
            End;

            pFreeAndNil(frmFatDadosFiscais);
          End
          Else
          Begin
            Try
              pCriarFormularios(TfrmObsGarantia, frmObsGarantia);
              frmObsGarantia.ShowModal;

              blnConfirma := frmObsGarantia.ModalResult = mrOk;

              If blnConfirma Then
              Begin
                fatVenda.strMen001 := frmObsGarantia.edtObs1.Text;
                fatVenda.strMen002 := frmObsGarantia.edtObs2.Text;
              End
              else
              Begin
                fatVenda.strMen001 := '';
                fatVenda.strMen002 := '';
              End;
            Except
              On E: Exception Do
              Begin
                blnConfirma := False;
                pMensagensErro(E.Message, '');
              End;
            End;

            pFreeAndNil(frmObsGarantia);
          End;
        End;

        if blnConfirma then
        begin
          if FControladorEnvioFornecedor <> NIl then
          begin
            FreeAndNil(FControladorEnvioFornecedor);
            if Not fEmptyStr(edtCodFor.Text) then
              FControladorEnvioFornecedor := TControladorEnvioFornecedor.Create(edtCodFor.Text);
          end;

        end;
        {**************************************}
        {* CASO NÃO TENHA CONFIRMADO          *}
        {* DADOS FISCAIS OU CFOP DA GARANTIA  *}
        {***********************************MM*}
        If (Not blnConfirma) Then
        Begin
          fRollBack;
          Exit;
        End;

        Try
          fatVenda.blnGerarContaPagarDevolucaoOutrasSaidas := fGerarCreditoPagarEnvioFornecedorCFOPX949(fatVenda.strClafis);
          pCriarFormularios(TfrmGravando,frmGravando);
          frmGravando.strChave            := 'FATFATURA';
          frmGravando.fExecutarAcao       := fatVenda.fGravaArquivos;
          frmGravando.lblGravando.Caption := 'Aguarde, Gravando Retorno...';
          frmGravando.ShowModal;
          blnConfirma                     := frmGravando.blnConfirma;

          pFreeAndNil(frmGravando);

          If (Not blnConfirma) Then
          Begin
            pInicializaTemporaria;
            Exit;
          End;

        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[fConfirmaVenda - frmGravando]');
            pFreeAndNil(frmGravando);
          End;
        End;

        pInicializaTemporaria;
      End;


      If blnConfirma Then
      Begin
        cdsDocEnt.EmptyDataSet;
        Result := True;
        pMensagemOk('Operação realizada com sucesso!');
        pSetFocus(edtCodFor);
      End;

      strNumPedGer := fatVenda.strNumPedGer;

      strNumDoc := fatVenda.strNumDoc;
      strEspDoc := fatVenda.strEspDoc;
      strSerie_ := fatVenda.strSerFsc;

    Except
      On E: Exception Do
      Begin
        cdsProdutos.EnableControls;
        pMensagensErro(E.Message, '[TfrmGarantiaEnvFornecedor.pConfirma]');
        pInicializaTemporaria;
      End;
    End;
  Finally
    cdsProdutos.EnableControls;
    TMovGad.pApagarMovGaeTemporaria;
    FreeandNil(fatVenda);
    lstgIncAlteracaoPreco.Free;
  End;
end;

function TfrmGarantiaEnvFornecedor.fPermitirInformarChaveNFReferenciada: Boolean;
begin
  Result := False;
  if Not blnInformarChaveNotaEntrada then
    Exit;

  if (fatVenda <> Nil) and (fatVenda.strEspDoc <> 'NF') then
    Exit;

  if (enuTipoEnvioFornecedorGarantia <> tefDevolucao) then
    Exit;

  Result :=  True;
end;

function TfrmGarantiaEnvFornecedor.fCriarTabelaProdutosEnvio: TUniClientDataSet;
Var
  lControladorEnvioFornecedorItem: TControladorEnvioFornecedorItem;
  lGarantiaItem: TGarantiaItem;
  lcdsProdutosTmp: TUniClientDataSet;
  i: Integer;
  procedure pInserirItemTabelaTemporaria(pDocEntradaGarantia: TDocEntradaGarantia);
  begin
    lcdsProdutosTmp.Insert;
    lcdsProdutosTmp.FieldByName('AUTINC').AsString   := cdsProdutos.FieldByName('AUTINC').AsString;
    lcdsProdutosTmp.FieldByName('CODITE').AsString   := cdsProdutos.FieldByName('CODITE').AsString;
    lcdsProdutosTmp.FieldByName('CODFAB').AsString   := cdsProdutos.FieldByName('CODFAB').AsString;
    lcdsProdutosTmp.FieldByName('DESITE').AsString   := cdsProdutos.FieldByName('DESITE').AsString;
    lcdsProdutosTmp.FieldByName('REFERE').AsString   := cdsProdutos.FieldByName('REFERE').AsString;
    lcdsProdutosTmp.FieldByName('UNIDAD').AsString   := cdsProdutos.FieldByName('UNIDAD').AsString;
    lcdsProdutosTmp.FieldByName('QTDREQ').AsFloat    := cdsProdutos.FieldByName('QTDREQ').AsFloat;
    lcdsProdutosTmp.FieldByName('DTAENV').AsDateTime := VS_Date;
    lcdsProdutosTmp.FieldByName('OBSP_1').AsString   := cdsProdutos.FieldByName('OBSP_1').AsString;

    lcdsProdutosTmp.FieldByName('TABPRE').AsString   := IIF(fEmptyStr(cdsProdutos.FieldByName('TABPRE').AsString),
                                                            '1',
                                                            cdsProdutos.FieldByName('TABPRE').AsString);
    If Assigned(pDocEntradaGarantia) Then
    begin
      lcdsProdutosTmp.FieldByName('NFENTRADA').AsString := pDocEntradaGarantia.DocEntradaItem.strNumDoc;
      lcdsProdutosTmp.FieldByName('PRECUS').AsFloat  := pDocEntradaGarantia.DocentradaItem.fltUnitar;
      lcdsProdutosTmp.FieldByName('QTDREQ_1').AsFloat  := pDocEntradaGarantia.Quantidade;
      lcdsProdutosTmp.FieldByName('DOCDEV').AsString  := pDocEntradaGarantia.DocEntradaItem.strNumDoc;
      lcdsProdutosTmp.FieldByName('ESPDEV').AsString  := pDocEntradaGarantia.DocEntradaItem.strEspDoc;
      lcdsProdutosTmp.FieldByName('EMPDEV').AsString  := pDocEntradaGarantia.DocEntradaItem.strCodEmp;
      lcdsProdutosTmp.FieldByName('INCDEV').AsString  := pDocEntradaGarantia.DocEntradaItem.strAutInc;
      lcdsProdutosTmp.FieldByName('FIS_ACESSO').AsString  := pDocEntradaGarantia.DocEntradaItem.strAcesso;
    end
    else
    begin
      lcdsProdutosTmp.FieldByName('NFENTRADA').AsString := '';
      lcdsProdutosTmp.FieldByName('PRECUS').AsFloat  := cdsProdutos.FieldByName('PRECUS').AsFloat;
      lcdsProdutosTmp.FieldByName('QTDREQ_1').AsFloat  := lGarantiaItem.fTotalSemDocumento;
      lcdsProdutosTmp.FieldByName('DOCDEV').AsString  := '';
      lcdsProdutosTmp.FieldByName('ESPDEV').AsString  := '';
      lcdsProdutosTmp.FieldByName('EMPDEV').AsString  := '';
      lcdsProdutosTmp.FieldByName('INCDEV').AsString  := '';
      lcdsProdutosTmp.FieldByName('FIS_ACESSO').AsString  := '';
    end;

    lcdsProdutosTmp.Post;
  end;
begin
  cdsProdutos.First;
  lcdsProdutosTmp := TUniClientDataSet.Create(Self);
  lcdsProdutosTmp.FieldDefs := cdsProdutos.FieldDefs;
  lcdsProdutosTmp.CreateDataSet;
  lControladorEnvioFornecedorItem := Nil;
  While Not cdsProdutos.Eof do
  begin
    lGarantiaItem := NIl;
    if cdsProdutos.FieldByName('QTDREQ_1').AsFloat <= 0 then
    begin
      cdsProdutos.Next;
      Continue;
    end;

    if (lControladorEnvioFornecedorItem = Nil) Or (lControladorEnvioFornecedorItem.strCodIte <> cdsProdutos.FieldByName('CODITE').AsString) then
      lControladorEnvioFornecedorItem := FControladorEnvioFornecedor.ItemDecodigo[cdsProdutos.FieldByName('CODITE').AsString];

    if (lControladorEnvioFornecedorItem = Nil) then
    begin
      cdsProdutos.Next;
      Continue;
    end;

    lGarantiaItem := lControladorEnvioFornecedorItem.GarantiaItemAutInc[cdsProdutos.FieldByName('AUTINC').AsString];
    if lGarantiaItem = Nil then
    begin
      cdsProdutos.Next;
      Continue;
    end;

    for i := 0 to lControladorEnvioFornecedorItem.fContarDocEntradaGarantia -1 do
    begin
      if lControladorEnvioFornecedorItem.DocEntradaGarantiaDeIndice[i].GarantiaItem = lGarantiaItem then
        pInserirItemTabelaTemporaria(lControladorEnvioFornecedorItem.DocEntradaGarantiaDeIndice[i]);
    end;

    if lGarantiaItem.fTotalSemDocumento > 0 then
      pInserirItemTabelaTemporaria(Nil);
    cdsProdutos.Next;
  end;
  Result := lcdsProdutosTmp;
end;

procedure TfrmGarantiaEnvFornecedor.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGarantiaEnvFornecedor.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomeMarca, nil, 'da marca');
end;

procedure TfrmGarantiaEnvFornecedor.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

{*****************************************}
{* VALIDA FORNECEDOR                     *}
{**************************************RL*}
procedure TfrmGarantiaEnvFornecedor.edtCodForExit(Sender: TObject);
begin
  inherited;

  If (Activecontrol) = btnSair Then
    Exit;

  If fValidaCampos(edtCodFor, True) Then
  Begin
    btnMarcarTodos.Enabled    := True;
    btnDesmarcarTodos.Enabled := True;
    btnSemelhantes.Enabled    := True;
    btnExcel.Enabled          := True;
    btnSelecionados.Enabled   := True;
  End
  Else
    pSetFocus(edtCodFor);

  If Assigned(cdsProdutos) And (cdsProdutos.RecordCount > 0) Then
  Begin
    btnDesmarcarTodos.Click;
    cdsProdutos.EmptyDataSet;
  End;

end;

{*******************************************}
{* SELECIONA PRODUTOS DA GRID              *}
{****************************************RL*}
procedure TfrmGarantiaEnvFornecedor.pSelecionaProduto(Sender: TObject;
  blnTodos: Boolean);
begin
  pSelecionaProduto(TBitBtnLocked(Sender).Tag = 1, blnTodos);
end;

procedure TfrmGarantiaEnvFornecedor.pSepararProdutosParaEnvio(
  out blnTemItemSemDocVenda: Boolean);
Var
  blnTemDocDev,
  blnInserir: Boolean;
  lcdsProdutosTmp: TUniClientDataSet;
  i: Integer;

begin
  blnTemItemSemDocVenda := False;
  cdsGroup.EmptyDataSet;
  cdsProdutos.DisableControls;

  i := 0;
  lcdsProdutosTmp := Nil;
  Try
    lcdsProdutosTmp := fCriarTabelaProdutosEnvio;
    lcdsProdutosTmp.First;
    While Not lcdsProdutosTmp.Eof Do
    Begin
      blnTemDocDev := Not fEmptyStr(Trim(lcdsProdutosTmp.FieldByName('INCDEV').AsString));

      if cdsGroup.IsEmpty then
        blnInserir := true

      else IF  blnTemDocDev then
        blnInserir := Not cdsGroup.Locate('CODITE;INCDEV',
                                          VarArrayOf([lcdsProdutosTmp.FieldByName('CODITE').AsString,
                                                      lcdsProdutosTmp.FieldByName('INCDEV').AsString]),
                                          [])

      else
        blnInserir := Not cdsGroup.Locate('CODITE', lcdsProdutosTmp.FieldByName('CODITE').AsString, []);

      if (blnInserir = False) then
        blnInserir := chkNaoSintetizarItens.Checked;

      if blnInserir then
      Begin
        inc(i);
        cdsGroup.Insert;
        cdsGroup.FieldByName('INCTMP').AsString := IntToStr(i);
        cdsGroup.FieldByName('AUTINC').AsString   := lcdsProdutosTmp.FieldByName('AUTINC').AsString;
        cdsGroup.FieldByName('CODITE').AsString   := lcdsProdutosTmp.FieldByName('CODITE').AsString;
        cdsGroup.FieldByName('CODFAB').AsString   := lcdsProdutosTmp.FieldByName('CODFAB').AsString;
        cdsGroup.FieldByName('DESITE').AsString   := lcdsProdutosTmp.FieldByName('DESITE').AsString;
        cdsGroup.FieldByName('REFERE').AsString   := lcdsProdutosTmp.FieldByName('REFERE').AsString;
        cdsGroup.FieldByName('UNIDAD').AsString   := lcdsProdutosTmp.FieldByName('UNIDAD').AsString;
        IF btnExcel.Tag = EXPORTANDO_PLANILHA Then
          cdsGroup.FieldByName('QTDREQ').AsFloat    := lcdsProdutosTmp.FieldByName('QTDREQ_1').AsFloat
        else
          cdsGroup.FieldByName('QTDREQ').AsFloat    := lcdsProdutosTmp.FieldByName('QTDREQ').AsFloat;
        cdsGroup.FieldByName('PRECUS').AsFloat    := lcdsProdutosTmp.FieldByName('PRECUS').AsFloat;
        cdsGroup.FieldByName('TABPRE').AsString   := lcdsProdutosTmp.FieldByName('TABPRE').AsString;
        cdsGroup.FieldByName('DTAENV').AsDateTime := VS_Date;
        cdsGroup.FieldByName('OBSP_1').AsString   := lcdsProdutosTmp.FieldByName('OBSP_1').AsString;
        cdsGroup.FieldByName('QTDREQ_1').AsFloat  := lcdsProdutosTmp.FieldByName('QTDREQ_1').AsFloat;
        cdsGroup.FieldByName('DOCDEV').AsString := lcdsProdutosTmp.FieldByName('DOCDEV').AsString;
        cdsGroup.FieldByName('ESPDEV').AsString := lcdsProdutosTmp.FieldByName('ESPDEV').AsString;
        cdsGroup.FieldByName('EMPDEV').AsString := lcdsProdutosTmp.FieldByName('EMPDEV').AsString;
        cdsGroup.FieldByName('INCDEV').AsString := lcdsProdutosTmp.FieldByName('INCDEV').AsString;
        cdsGroup.FieldByName('NFENTRADA').AsString := lcdsProdutosTmp.FieldByName('NFENTRADA').AsString;
      End
      Else
      Begin
        cdsGroup.Edit;
        cdsGroup.FieldByName('QTDREQ_1').AsFloat  := cdsGroup.FieldByName('QTDREQ_1').AsFloat +
          lcdsProdutosTmp.FieldByName('QTDREQ_1').AsFloat;

        IF btnExcel.Tag = EXPORTANDO_PLANILHA Then
        begin
          cdsGroup.FieldByName('QTDREQ').AsFloat  := cdsGroup.FieldByName('QTDREQ').AsFloat +
            lcdsProdutosTmp.FieldByName('QTDREQ_1').AsFloat;
        end;
      End;

      IF btnExcel.Tag = EXPORTANDO_PLANILHA Then
      begin
        cdsGroup.FieldByName('VLRTOT').AsFloat := cdsGroup.FieldByName('QTDREQ').AsFloat *
          cdsGroup.FieldByName('PRECUS').AsFloat;
      end;
      cdsGroup.Post;
      if ((Not FblnUsaEspelho) Or (fatVenda.strEspDoc <> 'NF')) And (btnExcel.Tag = NAO_EXPORTANDO_PLANILHA) then
      begin
        if Not TMovGad.fGravarGaeTemporaria(cdsGroup.FieldByName('INCTMP').AsString,
                                            lcdsProdutosTmp.FieldByName('AUTINC').AsString,
                                            lcdsProdutosTmp.FieldByName('QTDREQ_1').AsFloat,
                                            lcdsProdutosTmp.FieldByName('PRECUS').AsFloat,
                                            VS_Date) then

          raise Exception.Create('Ocorreu uma falha ao tentar gravar o registro temporário de envio para fornecedor [MOVGAE]. Contate a Citel.');
      end;
      if (Not blnTemItemSemDocVenda) then
        blnTemItemSemDocVenda := blnInserir and (Not blnTemDocDev);

      lcdsProdutosTmp.Next;
    End;
  Finally
    if Assigned(lcdsProdutosTmp) then
      FreeAndNil(lcdsProdutosTmp);
    cdsProdutos.First;
    cdsProdutos.EnableControls;
  End;
end;

procedure TfrmGarantiaEnvFornecedor.pSelecionaProduto(pblnMarcar: Boolean; blnTodos: Boolean = False);
  Var
    strAutInc : String;
    lblnContinuar: Boolean;
    ldtaDtaEnv: TDateTime;
begin
  if ( cdsProdutos.IsEmpty ) then
    Exit;

  strAutInc := cdsProdutos.FieldByName('AUTINC').AsString;

  if blnTodos then
  begin
    cdsProdutos.DisableControls;
    if pblnMarcar then
      FblnMarcarTodos := True;
    Try
      cdsprodutos.Filtered := false;
      cdsprodutos.Filter   := cxgProdutosDBTableView1.DataController.Filter.FilterText;
      cdsprodutos.Filtered := True;
      cdsprodutos.First;
      if FblnMarcarTodos then
        cdsProdutos.EnableControls;
      While Not cdsprodutos.Eof do
      begin
        pSelecionaProduto(pblnMarcar, False);
        cdsprodutos.Next;
      end;
    Finally
      FblnMarcarTodos := false;
      cdsProdutos.Filter := '';
      cdsProdutos.Filtered := False;
      cdsProdutos.Locate('AUTINC', strAutInc, []);
      if cdsProdutos.ControlsDisabled then
        cdsProdutos.EnableControls;
    End;
  end
  else
  begin
    {$Region 'Definindo o tipo de envio'}
    // Se for o primeiro produto a marcar solicita o tipo do documento que sera enviado,
    // caso for nf, já solicita o cfop pois se for utilizar cfop de devolução é necessário informar o documento de entrada;
    // existe a posibilidade de apos marcar todos os produtos, e algum for ST, será solicitado a cfop dos produtos com ST.
    If (intQtdMar = 0) And pblnMarcar Then
    Begin
      if fMensagem('', 'Escolha uma opção de Envio:', ['Devolução', 'Conserto'], 1, False, 1, 0, False, 0, False, False, True) = 1 then
        enuTipoEnvioFornecedorGarantia := tefDevolucao
      else
        enuTipoEnvioFornecedorGarantia := tefConserto;
    End;
    {$EndRegion 'Definindo o tipo de envio'}

    ldtaDtaEnv := VS_Date;
    if pblnMarcar then
      lblnContinuar := (cdsprodutos.FieldByName('DTAENV').AsDateTime <> ldtaDtaEnv)
    else
      lblnContinuar := (cdsprodutos.FieldByName('DTAENV').AsDateTime = ldtaDtaEnv);

    if Not lblnContinuar then
      Exit;

    if Not fTravaDeRegistro(strAutInc, pblnMarcar) then
    begin
      if pblnMarcar then
        Exit;
    end;

    Try
      if pblnMarcar then
      begin
        if fCarregaDocEnt(strAutInc) then
          Inc(intQtdMar)
        else
          ldtaDtaEnv := 0;
      end
      else
      begin
        FControladorEnvioFornecedor.pRemoverGarantia(cdsProdutos.FieldByName('CODITE').AsString,
                                                     cdsProdutos.FieldByName('AUTINC').AsString);
        ldtaDtaEnv := 0;  // registro não selecionado
        Dec(intQtdMar);
      end;

      cdsprodutos.Edit;
      cdsprodutos.FieldByName('DTAENV').AsDateTime := ldtaDtaEnv;
      cdsProdutos.Post;
    Except
      On E: EControleDevolucaoFornecedor do
      begin
        EControleDevolucaoFornecedor(e).pExibirMensagem;
        Exit;
      end;

      On E: Exception do
      begin
        pMensagensErro(e.Message, '[TfrmGarantiaEnvFornecedor.pSelecionaProduto]');
      end;
    End;
  end;
end;


procedure TfrmGarantiaEnvFornecedor.dbgProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = Vk_Return Then
  Begin
    If Not (cdsProdutos.IsEmpty) Then
      pSelecionaProduto((cdsProdutosDTAENV.AsFloat = 0));
  End
  Else If Key = Vk_Escape Then
    pSetFocus(edtCodFor);

end;

procedure TfrmGarantiaEnvFornecedor.dbgProdutosDblClick(Sender: TObject);
begin
  inherited;

  pSelecionaProduto((cdsProdutosDTAENV.AsFloat = 0));

end;

{*******************************************}
{* MARCA TODOS OS PRODUTOS DA GRID         *}
{****************************************RL*}
procedure TfrmGarantiaEnvFornecedor.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

   pSelecionaProduto(Sender, True);

end;

procedure TfrmGarantiaEnvFornecedor.btnSelecionadosClick(Sender: TObject);
  Var
    BookMark: TBookMark;
    cdsItens : TUniClientDataSet;
begin
  inherited;
  BookMark := cdsProdutos.Bookmark;
  cdsProdutos.DisableControls;
  cdsProdutos.Filtered := False;
  cdsProdutos.Filter   := 'DTAENV > 0';
  cdsProdutos.Filtered := True;
  pCriarFormularios(TfrmGarantiaEnvFornecedorResumo, frmGarantiaEnvFornecedorResumo);
  try
    cdsItens := frmGarantiaEnvFornecedorResumo.cdsItens;
    cdsItens.EmptyDataSet;

    if cdsProdutos.isEmpty then
      pMensagemOK('Não há registros selecionados!')
    else
    begin
      cdsProdutos.First;
      while not cdsProdutos.Eof do
      begin
        if cdsItens.Locate('CODITE', cdsProdutos.FieldByName('CODITE').AsString, []) then
        begin
          cdsItens.Edit;
          cdsItens.FieldByName('QTDREQ').AsFloat := cdsItens.FieldByName('QTDREQ').AsFloat + cdsProdutos.FieldByName('QTDREQ').AsFloat;
        end
        else
        begin
          cdsItens.Append;
          cdsItens.FieldByName('CODITE').AsString := cdsProdutos.FieldByName('CODITE').AsString;
          cdsItens.FieldByName('DESITE').AsString := cdsProdutos.FieldByName('DESITE').AsString;
          cdsItens.FieldByName('REFERE').AsString := cdsProdutos.FieldByName('REFERE').AsString;
          cdsItens.FieldByName('UNIDAD').AsString := cdsProdutos.FieldByName('UNIDAD').AsString;
          cdsItens.FieldByName('QTDREQ').AsFloat  := cdsProdutos.FieldByName('QTDREQ').AsFloat;
        end;

        cdsItens.Post;
        cdsProdutos.Next;
      end;

      cdsItens.First;
      frmGarantiaEnvFornecedorResumo.ShowModal;
    end;
  finally
    pFreeAndNil(frmGarantiaEnvFornecedorResumo);

    cdsProdutos.Filtered := False;

    if ( Not cdsProdutos.IsEmpty ) then
      cdsProdutos.GotoBookmark(BookMark);

    cdsProdutos.FreeBookmark(BookMark);

    cdsProdutos.EnableControls;
  end;
end;

procedure TfrmGarantiaEnvFornecedor.btnSemelhantesClick(Sender: TObject);
begin
  inherited;
  pAlteraSemelhante;
end;

procedure TfrmGarantiaEnvFornecedor.cdsProdutosAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnUltCompras.Enabled := (cdsProdutos.RecordCount > 0) and (not fEmptyStr(cdsProdutosCODITE.AsString));
end;

procedure TfrmGarantiaEnvFornecedor.cdsProdutosBeforePost(DataSet: TDataSet);
begin
  inherited;
  If (DataSet.FieldByName('QTDREQ_1').AsFloat <= 0) Or
     (DataSet.FieldByName('QTDREQ_1').AsFloat > DataSet.FieldByName('QTDREQ').AsFloat) Then
  Begin
    fMensagem('', 'A Quantidade enviada deve ser maior que 0 e menor ou igual a ' + FormatFloat('#,##0.00', DataSet.FieldByName('QTDREQ').AsFloat) + '!', ['&OK']);
    DataSet.FieldByName('QTDREQ_1').AsFloat := DataSet.FieldByName('QTDREQ').AsFloat;
  End;

end;

procedure TfrmGarantiaEnvFornecedor.cxgProdutosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  With cdsProdutos Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;
    if FblnMarcarTodos And AViewInfo.GridRecord.Selected then
    begin
     ACanvas.Brush.Color := clInfoBk;
     ACanvas.Font.Color := clBlack;
    end
    else
    If VarToDateTime(IfNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgProdutosDTAENV.Index],0)) <> 0 Then
    Begin
      ACanvas.Font.Color := clBlue;
    End;
     
  end;
end;

{*******************************************}
{* DESMARCA TODOS OS PRODUTOS DA GRID      *}
{****************************************RL*}
procedure TfrmGarantiaEnvFornecedor.btnDesmarcarTodosClick(
  Sender: TObject);
begin
  inherited;

  pSelecionaProduto(Sender, True);

end;

procedure TfrmGarantiaEnvFornecedor.btnExcelClick(Sender: TObject);
{$Region 'Métodos Locais'}
  function TotalItem(Const Quantidade, Unitario: Double): Double;
  begin
    Result := Quantidade * Unitario;
  end;
  procedure pIncluirProdutosNaoSelecionados(pcdsGroup: TDataSet);
  Var
    lfltTotIte: Double;
  begin
    cdsProdutos.Filter   := ' DTAENV = 0 ';
    cdsProdutos.Filtered := True;
    if cdsProdutos.IsEmpty then
      Exit;
    While Not cdsProdutos.Eof Do
    Begin
      if cdsProdutos.FieldByName('QTDREQ').AsFloat = 0 then
      begin
        cdsProdutos.Next;
        Continue;
      end;
      If (Not pcdsGroup.Locate('CODITE;NFENTRADA', VarArrayOf([cdsProdutos.FieldByName('CODITE').AsString, '']), [])) then
      Begin
        pcdsGroup.Insert;
        pcdsGroup.FieldByName('AUTINC').AsString   := '';
        pcdsGroup.FieldByName('CODITE').AsString   := cdsProdutos.FieldByName('CODITE').AsString;
        pcdsGroup.FieldByName('CODFAB').AsString   := cdsProdutos.FieldByName('CODFAB').AsString;
        pcdsGroup.FieldByName('NUMDOC').AsString   := cdsProdutos.FieldByName('NUMDOC').AsString;
        pcdsGroup.FieldByName('DESITE').AsString   := cdsProdutos.FieldByName('DESITE').AsString;
        pcdsGroup.FieldByName('REFERE').AsString   := cdsProdutos.FieldByName('REFERE').AsString;
        pcdsGroup.FieldByName('UNIDAD').AsString   := cdsProdutos.FieldByName('UNIDAD').AsString;
        pcdsGroup.FieldByName('QTDREQ').AsFloat    := cdsProdutos.FieldByName('QTDREQ').AsFloat;
        pcdsGroup.FieldByName('PRECUS').AsFloat    := cdsProdutos.FieldByName('PRECUS').Asfloat;
        pcdsGroup.FieldByName('NFENTRADA').AsString := '';

        pcdsGroup.FieldByName('VLRTOT').AsFloat    :=
          totalItem(pcdsGroup.FieldByName('QTDREQ').AsFloat, pcdsGroup.FieldByName('PRECUS').AsFloat);
        pcdsGroup.Post;
      End
      Else
      Begin
        lfltTotIte := totalItem(cdsProdutos.FieldByName('QTDREQ').AsFloat, cdsProdutos.FieldByName('PRECUS').Asfloat);
        pcdsGroup.Edit;

        pcdsGroup.FieldByName('QTDREQ').AsFloat := pcdsGroup.FieldByName('QTDREQ').AsFloat
                                                     + cdsProdutos.FieldByName('QTDREQ').AsFloat;

        pcdsGroup.FieldByName('VLRTOT').AsFloat    := pcdsGroup.FieldByName('VLRTOT').AsFloat + lfltTotIte;
        pcdsGroup.FieldByName('PRECUS').AsFloat    := RoundTo((pcdsGroup.FieldByName('VLRTOT').AsFloat/pcdsGroup.FieldByName('QTDREQ').AsFloat), -intDecUni);

        pcdsGroup.Post;
      End;
      cdsProdutos.Next;
    End;
  end;
{$EndRegion}
  var
    objExcel : TGeraExcel;
    blnTemItemSemDocVenda: Boolean;
    lblnTodosRegistros: Boolean;
begin
  inherited;
  If fMensagem('', 'Confirma exportação para Excel?', ['&Sim', '&Não']) = 2 Then
    Exit;
  btnExcel.Tag := EXPORTANDO_PLANILHA;
  objExcel := Nil;
  Try
    cdsProdutos.IndexFieldNames := 'CODITE';

    With cdsProdutos Do
    Begin
      cdsProdutos.DisableControls;
      cdsProdutos.First;

      cdsProdutos.Filter   := ' DTAENV > 0 ';
      cdsProdutos.Filtered := True;
      If cdsProdutos.IsEmpty Then
        lblnTodosRegistros := True
      else
      Begin
        Filtered := (fGetMenu('Exportação', ['Exportar Todos Registros', 'Exportar Registros Selecionados'], 1) = 2);
        lblnTodosRegistros := Not Filtered;
        pSepararProdutosParaEnvio(blnTemItemSemDocVenda);
      End;

      if lblnTodosRegistros then
        pIncluirProdutosNaoSelecionados(cdsGroup);
    End;

    Try
      cdsGroup.IndexFieldNames := 'CODITE';

      objExcel  := TGeraExcel.Create(cdsGroup, pbProgresso);
      objExcel.OnMontaResumo := pMontaResumo;
      objExcel.OnSomaResumo  := pSomaTotais;
      With objExcel Do
      Begin
        strNomRel := Format('EXPORTAÇÃO DOS PRODUTOS A SEREM ENVIADOS PARA %0:s (%1:s)',[edtNomFor.Text, strCnpjFornecedor]);

        AddCampo ('CODITE', 'CÓD. ITEM');
        AddCampo ('CODFAB', 'CÓD. FÁBRICA');
        AddCampo ('NUMDOC', 'NUMERO DOC');
        AddCampo ('DESITE', 'DESCRIÇÃO');
        AddCampo ('REFERE', 'REFERÊNCIA');
        AddCampo ('UNIDAD', 'UNIDADE');
        AddCampo ('QTDREQ', 'QUANTIDADE');
        AddCampo ('NFENTRADA','NOTA ENTRADA');
        AddCampo ('PRECUS', 'VR. UNITARIO');
        AddCampo ('VLRTOT', 'VR. TOTAL');
        AddTotais('QTDREQ');
        AddTotais('PRECUS');
        AddTotais('VLRTOT');
        If fGerarRelatorio Then
        Begin
          fMensagem('','Arquivo gerado com sucesso!',['&OK']);
        End;
      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmGarantiaEnvFornecedor.btnExcelClick]');
      End;

    End;

  Finally
    cdsProdutos.Filtered := False;
    cdsProdutos.Filter := '';
    cdsProdutos.EnableControls;

    btnExcel.Tag := NAO_EXPORTANDO_PLANILHA;
    if objExcel <> Nil then
      FreeAndNil(objExcel);
  End;
end;

procedure TfrmGarantiaEnvFornecedor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    Vk_F10: If (btnConfirmar.Enabled) Then
            Begin
              key := 0;
              btnConfirmar.Click;
            End;

    VK_F8: If (btnMarcarTodos.Enabled) Then
             btnMarcarTodos.Click;

    VK_F9: If (btnDesmarcarTodos.Enabled) Then
             btnDesmarcarTodos.Click;

    VK_F7: If (btnSemelhantes.Enabled) Then
             btnSemelhantes.Click;

    VK_F6: If (btnExcel.Enabled) Then
             btnExcel.Click;

    VK_F5: If (btnUltCompras.Enabled) Then
             btnUltCompras.Click;

    VK_F4: If (btnSelecionados.Enabled) Then
             btnSelecionados.Click;
  End;

end;

procedure TfrmGarantiaEnvFornecedor.FormShow(Sender: TObject);
begin
  inherited;

end;

{********************************************}
{* CONFIRMAR ENVIO DO PRODUTOS SELECIONADOS *}
{*****************************************RL*}
procedure TfrmGarantiaEnvFornecedor.btnUltComprasClick(Sender: TObject);
begin
  inherited;

  if not btnUltCompras.Enabled Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(131, 6099, [],
                        ['CODITE'],
                        [cdsProdutosCODITE.AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmGarantiaEnvFornecedor.btnConfirmarClick(Sender: TObject);
  Var strNumDoc, strEspDoc, strSerDoc: string;
begin
  if Not fValidarSelecaoDocumentoOrigem then
    abort;

  inherited;

  Try
    cdsProdutos.DisableControls;
    cdsProdutos.Filtered := False;
    cdsProdutos.Filter   := 'DTAENV > 0';
    cdsProdutos.Filtered := True;

    If cdsProdutos.IsEmpty Then
    Begin
      pMensagemOK('Selecione os itens antes de efetuar o envio para o fornecedor!');
      Exit;
    End
    Else If Not fValidaDocumentosSelecionadosComFornecedor Then
    Begin
      pMensagemOK('Os documentos selecionados não pertencem ao fornecedor '+ edtCodFor.text);
      Exit;
    End;

    If fMensagem('', 'Confirma o envio dos produtos selecionados para o fornecedor?', ['&Sim', '&Não']) = 2 Then
      Exit;

    Try

      If Not fConfirma(strNumDoc, strEspDoc, strSerDoc) Then
      Begin
        Exit;
      End;

      if Not fImprimirControleGarantia(strNumDoc, strEspDoc, edtCodFor.Text) then
        pImprimeDocumento(strNumDoc, strEspDoc, cdsGroup);

      cdsProdutos.EmptyDataSet;
      lstDocSel.Clear;
      edtCodFor.Clear;
      edtNomFor.Clear;
      pSetFocus(edtCodFor);
      objLock.pDestravarTodos;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmGarantiaEnvFornecedor.btnConfirmarClick]');
      End;
    End;
  Finally
    cdsProdutos.Filtered := False;
    cdsProdutos.EnableControls;
  End;
end;

procedure TfrmGarantiaEnvFornecedor.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodFor);
end;

procedure TfrmGarantiaEnvFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  cdsProdutos.Close;
  objLock.pDestravarTodos;

end;

procedure TfrmGarantiaEnvFornecedor.dtsProdutosDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  {***********************************************}
  {* O CAMPO AGGREGATE ESTÁ SENDO UTILIZADO      *}
  {* APENAS PARA HABILITAR / DESABILITAR O       *}
  {* BOTÃO DE CONFIRMAR DE ACORDO COM SEU VALOR. *}
  {********************************************RL*}
  If (TAggregateField(cdsProdutos.FieldByName('AGG_QTDREQ_1')).Value > 0) Then
    btnConfirmar.Enabled := True
  Else
    btnConfirmar.Enabled := False;

end;

procedure TfrmGarantiaEnvFornecedor.pImprimeDocumento(strNumDoc, strEspDoc : String; DataSet : TUniClientDataSet);
  Var
    strNomImp: String;
    strTipImp: String;
    frxDoc: TfrxReport;
Begin

  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  Try
    Try
      dtsProdutos.DataSet := DataSet;

      DataSet.DisableControls;
      DataSet.Filtered := False;
      DataSet.Filter   := 'QTDREQ_1 > 0';
      DataSet.Filtered := True;

      If strTipImp = 'M' Then
        frxDoc := frxDocEnvioM
      Else
        frxDoc := frxDocEnvioJ;

      frxDoc.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
      frxDoc.Script.Variables['TOTQTD'] := IntToStr(DataSet.RecordCount);
      frxDoc.Script.Variables['NOMOPE'] := strDescriUsuarioLogado;
      frxDoc.Script.Variables['NOMFOR'] := Copy(edtNomFor.Text,1,25);
      frxDoc.Script.Variables['NOMFRM'] := Self.Name;
      frxDoc.Script.Variables['NUMENV'] := strNumDoc+'-'+strEspDoc;
      frxDoc.Script.Variables['NUMPED'] := strNumPedGer + '-PD';

      if (not fCfgSis('GARMAT', varBoolean)) or fEmptyStr(strNumPedGer) Then
        frxDoc.FindObject('rllNumPed').Visible := False;

      If Not fEmptyStr(strNomImp) Then
      Begin
        frxDoc.PrintOptions.Printer    := strNomImp;
        frxDoc.PrintOptions.PrintMode  := pmDefault;
        frxDoc.PrintOptions.ShowDialog := False;

        if frxDoc.PrepareReport Then
          pPrintReport(Self.Name, 'Garantia - ' + Self.Caption, strNomImp, frxDoc);
      End
      Else
        pPreviewReport(Self.Name, 'Garantia - ' + Self.Caption, frxDoc);

    Except
      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmGarantiaEnvFornecedor.pImprimeDocumento]');
      End;
    End;

  Finally
    pnlInfo.Caption := '';
    DataSet.Filter   := '';
    DataSet.Filtered := False;
    DataSet.EnableControls;
    dtsProdutos.DataSet := cdsProdutos;    
  End;

End;

procedure TfrmGarantiaEnvFornecedor.pInicializaTemporaria;
begin
  cdsVenda.EmptyDataSet;
  fatVenda.strMen001 := '';
  fatVenda.strMen002 := '';
  fatVenda.strMen003 := '';
  fatVenda.strMen004 := '';
  fatVenda.strMen005 := '';
end;

function TfrmGarantiaEnvFornecedor.fAlterarPrecosItensEnvioFornecedor(pstrIncAlteracaoPreco: TStrings): Boolean;
begin
  Try
    pCriarFormularios(TfrmGarantiaAltPrecosEnvFornecedor, frmGarantiaAltPrecosEnvFornecedor);
    frmGarantiaAltPrecosEnvFornecedor.cdsItens := untFuncFat.cdsVenda;
    frmGarantiaAltPrecosEnvFornecedor.stlIncAlteracao := pstrIncAlteracaoPreco;
    Result := frmGarantiaAltPrecosEnvFornecedor.ShowModal = mrOk;
    fatVenda.blnAlterouPrecoGF := frmGarantiaAltPrecosEnvFornecedor.blnAlterouValor;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmGarantiaAltPrecosEnvFornecedor);
end;

function TfrmGarantiaEnvFornecedor.fGetCfopEnvioFornecedor(fatVenda: TFatVenda): Boolean;
  Var
    blnTemST,blnTributado : Boolean;
    fltPerIcm: Double;
    strCodSit: String;
begin
  Result := True;
  blnTributado := False;

  If (fatVenda.strEspDoc <> 'NF') Then
  Begin
    fatVenda.strClaFisEnvGarantia   := '5999';
    fatVenda.strClaFisEnvGarantiaST := '5999';
    Exit;
  End;

  Try

    With cdsVenda Do
    Begin

      {Req 304457, ajustado para sempre pedir as duas CFOP, pois como pode ser alterada a cst do produto}
      {na digitação dos impostos e como não foi informado a cfop dos produtos não tributados, nota fica com erro no painel}
      {First;
      While Not Eof Do
      Begin
        if not fEmptyStr( FieldByName('ITE_INCDEV').AsString ) then
        begin
          strCodSit := fCampoTabela('DET_CODFIS', 'MOVDET', ['AUTOINCREM'], [FieldByName('ITE_INCDEV').AsString]);
        end
        else
          fatVenda.pRetornaAliquotaItem(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, fltPerIcm, strCodSit);

        blnTemST := (Pos(strCodSit, (CST_SUBSTITUICAO + CST_ANTECIPACAO_ICMS)) > 0);

        If blnTemST Then
          Break;

        Next;
      End;}

      blnTemST := True;

      First;
      While Not Eof Do
      Begin
        if not fEmptyStr( FieldByName('ITE_INCDEV').AsString ) then
        begin
          strCodSit := fCampoTabela('DET_CODFIS', 'MOVDET', ['AUTOINCREM'], [FieldByName('ITE_INCDEV').AsString]);
        end
        else
          fatVenda.pRetornaAliquotaItem(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, fltPerIcm, strCodSit);

        blnTributado := (Pos(strCodSit, (CST_TRIBUTADO)) > 0);

        If blnTributado Then
          Break;

        Next;
      End;

      First;
    End;

    Try
      pCriarFormularios(TfrmFatDigDadosGarantia, frmFatDigDadosGarantia);
      frmFatDigDadosGarantia.edtClaFis.Enabled := True;
      frmFatDigDadosGarantia.edtDesCla.Enabled := True;

      If (Length(fCfgSis('CLARGF')) = 4) Then
      Begin
        fatVenda.strClaFis := fCfgSis('CLARGF');
        fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

        frmFatDigDadosGarantia.edtClaFis.Text := fatVenda.strClaFis;
        frmFatDigDadosGarantia.edtDesCla.Text := fatVenda.strDesCla;
      End;

      If (Length(fCfgSis('CLARGF')) <> 4) Or (blnTemST) Then
      Begin
        frmFatDigDadosGarantia.edtClaFis.Enabled := True;
        frmFatDigDadosGarantia.edtDesCla.Enabled := True;
        frmFatDigDadosGarantia.fatVenda          := fatVenda;
        frmFatDigDadosGarantia.strOpcDoc         := 'GF';
        frmFatDigDadosGarantia.blnTemST          := blnTemST;
        frmFatDigDadosGarantia.enuTipoEnvioFornecedorGarantia := enuTipoEnvioFornecedorGarantia;

        frmFatDigDadosGarantia.ShowModal;

        Result := frmFatDigDadosGarantia.ModalResult = mrOk;
      End;

      If Result Then
      Begin
        fatVenda.strClaFisEnvGarantia   := fatVenda.strClaFis;

        If blnTemST Then
        Begin
          fatVenda.strClaFisEnvGarantiaST := frmFatDigDadosGarantia.edtClaSub.Text;

          If (fatVenda.strClaFisEnvGarantiaST <> fatVenda.strClaFisEnvGarantia) And (Not blnTributado) And
             (fatVenda.strEspDoc = 'NF') Then
          Begin
            fatVenda.strClaFis := fatVenda.strClaFisEnvGarantiaST;
            fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);
          End;
        End
      End;

    Finally
      pFreeAndNil(frmFatDigDadosGarantia);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmGarantiaEnvFornecedor.fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
  Var
    strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';    
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODBAR, ';
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';
    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREMED, ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMGE, ';

    strSQL := strSQL + '  G.ITE_DESMVM, ';
    strSQL := strSQL + '  G.ITE_DESMSM, ';
    strSQL := strSQL + '  G.ITE_DESMGM, ';

    strSQL := strSQL + '  G.ITE_MARMMV, ';
    strSQL := strSQL + '  G.ITE_MARMMS, ';
    strSQL := strSQL + '  G.ITE_MARMMG, ';

    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_QTPPRO, ';
    strSQL := strSQL + '  A.ABF_CODABF, ';
    strSQL := strSQL + '  M.MAR_DESMAR, ';
    strSQL := strSQL + '  I.ITE_OBRCPF, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  U.UNI_CODUNI, ';
    strSQL := strSQL + '  U.UNI_DESUNI, ';
    strSQL := strSQL + '  I.ITE_CODMAR, ';
    strSQL := strSQL + '  I.ITE_REFERE, ';

    strSQL := strSQL + '  G.ITE_DESF01, ';
    strSQL := strSQL + '  G.ITE_DESF02, ';
    strSQL := strSQL + '  G.ITE_DESF03, ';
    strSQL := strSQL + '  G.ITE_DESF04, ';
    strSQL := strSQL + '  G.ITE_DESF05, ';
    strSQL := strSQL + '  G.ITE_DESF06, ';
    strSQL := strSQL + '  G.ITE_PREDOL, ';

    strSQL := strSQL + '  IFNULL(';
    strSQL := strSQL + '         (SELECT A.LOT_NUMLOT ';
    strSQL := strSQL + '         FROM (SELECT IF(LOT_NUMLOT = "GARANTIA",0,1) AS PRIORIDADE,  LOT_NUMLOT ';
    strSQL := strSQL + '               FROM CADLOT ';
    strSQL := strSQL + '               WHERE LOT_GARPRI = "S" ';
    strSQL := strSQL + '                     AND LOT_STATUS = "S" ';
    strSQL := strSQL + '                     AND LOT_CODITE = :CODITE ';
    strSQL := strSQL + '                     AND LOT_CODEMP = :CODEMP ';
    strSQL := strSQL + '               ORDER BY PRIORIDADE) A ';
    strSQL := strSQL + '         LIMIT 1) ';
    strSQL := strSQL + '        ,"") AS ITE_NUMLOT, ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';
      
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADMAR M, ';
    strSQL := strSQL + '  CADUNI U  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  I.ITE_CODUNI = U.UNI_CODUNI AND ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
      Open;
    End;

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmGarantiaEnvFornecedor.fGetItem]');
    End;

  End;

end;

function TfrmGarantiaEnvFornecedor.fGetTipoFaturamento(
  fatVenda: TFatVenda): Boolean;
  Var
    arrOpcoes: TOpcoesFaturamentoArray;
    frmFatTipoFaturamento : TfrmFatTipoFaturamento;
Begin
  Result := False;
  SetLength(arrOpcoes, 2);

  arrOpcoes[0].strDesCri := 'Nota Fiscal';
  arrOpcoes[0].strEspDoc := 'NF';
  arrOpcoes[0].strOpcLet := 'N';
  arrOpcoes[0].strMosMen := 'S';

  arrOpcoes[1].strDesCri := 'Garantia';
  arrOpcoes[1].strEspDoc := 'GF';
  arrOpcoes[1].strOpcLet := 'G';
  arrOpcoes[1].strMosMen := 'N';

  Try
    pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
    frmFatTipoFaturamento.strOpcDoc := 'VN';
    frmFatTipoFaturamento.fatVenda  := fatVenda;
    frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
    frmFatTipoFaturamento.ShowModal;

    If frmFatTipoFaturamento.blnConfirma Then
    Begin
      fatVenda.strEspDoc := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
      fatVenda.strTipFat := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;

      If fVerificaSeImpNFAvulsa(fatVenda.strEspDoc, teNaoPermite) Then
        Result := False
      Else
        Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmGarantiaEnvFornecedor.fGetTipoFaturamento]');
    End;
  End;

  pFreeAndNil(frmFatTipoFaturamento);

  SetLength(arrOpcoes, 0);
end;

function TfrmGarantiaEnvFornecedor.fIncluiItens(fatVenda: TFatVenda): Boolean;
  Var
    qryGenIte   : TUniQuery;
    i, intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strIteDes   : String;
    fltPreEnv   : Double;
    blnDocDev   : Boolean;
    strDesNes,
    strRefere   : String;


    LfrmRefenciarDocumentos: TfrmReferenciarDocumentos;
    strCodFab: String;
    blnTemDocumentoSemChaveReferenciada: Boolean;

Begin
  Result := False;
  qryGenIte := fCriaQuery;
  cdsGroup.EmptyDataSet;
  Try
    Try
      pSepararProdutosParaEnvio(blnTemDocumentoSemChaveReferenciada);

      With cdsGroup Do
      Begin
        DisableControls;

        fatVenda.fltDesEsp := 0;

        intContador := 0;
        First;
        cdsDocEnt.First;
        If (cdsDocEnt.RecordCount > 0) Then
        Begin
        fatVenda.objItensNotaEspelho := TItensNotaEspelhoEnvioFornecedor.Create(fatVenda);
        fatVenda.objItensNotaEspelho.blnUtilizarIcmsDoXmlDeEntrada := True;
        fatVenda.strChaveNFeRefDevolucao := cdsDocEnt.FieldByName('FIS_ACESSO').AsString;
          fatVenda.blnDvComDta := True;
        End
        Else If (enuTipoEnvioFornecedorGarantia = tefDevolucao) And
                (fEmptyStr(fatVenda.strChaveNFeRefDevolucao)) And
                (blnInformarChaveNotaEntrada) Then
        Begin
          pCriarFormularios(TfrmReferenciarDocumentos, LfrmRefenciarDocumentos);

          try
            if Length(fatVenda.arrChaveNFReferenciaDocumentos) > 0 then
            begin
              for i := 0 to Length(fatVenda.arrChaveNFReferenciaDocumentos) -1 do
              begin
                LfrmRefenciarDocumentos.cdsChave.Append;
                LfrmRefenciarDocumentos.cdsChaveCHAVE.AsString := fatVenda.arrChaveNFReferenciaDocumentos[i];
                LfrmRefenciarDocumentos.cdsChave.post;
              end;
            end;
            LfrmRefenciarDocumentos.Caption := 'Chave NFE a ser devolvida';

            LfrmRefenciarDocumentos.ShowModal;

            if (LfrmRefenciarDocumentos.ModalResult = mrOk) and (LfrmRefenciarDocumentos.blnSemChave = False) then
            begin
              SetLength(fatVenda.arrChaveNFReferenciaDocumentos, 0);

              LfrmRefenciarDocumentos.cdsChave.First;

              while not LfrmRefenciarDocumentos.cdsChave.Eof do
              begin
                SetLength(fatVenda.arrChaveNFReferenciaDocumentos, Length(fatVenda.arrChaveNFReferenciaDocumentos) + 1);
                fatVenda.arrChaveNFReferenciaDocumentos[Length(fatVenda.arrChaveNFReferenciaDocumentos) - 1] := LfrmRefenciarDocumentos.cdsChaveCHAVE.AsString;
                LfrmRefenciarDocumentos.cdsChave.Next;
              end;

              fatVenda.objItensNotaEspelho := TItensNotaEspelhoEnvioFornecedor.Create(fatVenda);
              fatVenda.objItensNotaEspelho.blnUtilizarIcmsDoXmlDeEntrada := True;

              fatVenda.blnDvComDta := True;
            end
            else begin
              If (fatVenda.strChaveNFeRefDevolucao = '') and fTipoFaturamentoRequerDocumentoDevolucao Then
              Begin
                pMensagemOk('A chave de acesso deve ser informada');
                Result := False;
                Exit;
              End;
            end;
          finally
            pFreeAndNil(LfrmRefenciarDocumentos);
          end;
        End;

        While Not Eof Do
        Begin
          If FieldByName('QTDREQ_1').AsFloat > 0 Then
          Begin

            if Not fEmptystr(cdsGroup.FieldByName('INCDEV').AsString) then
              blnDocDev :=  cdsDocEnt.Locate('AUTOINCREM', cdsGroup.FieldByName('INCDEV').AsString,[])
            else
            begin
              blnDocDev := cdsDocEnt.Locate('DET_CODITE;INCGAR',
                                             VarArrayOf([cdsGroup.FieldByName('CODITE').AsString,
                                                         cdsGroup.FieldByName('AUTINC').AsString]),
                                             []);
            end;

            inc(intContador);
            If (intContador = 1) Then
            Begin
              fatVenda.strCodVen    := strLoginUsuarioLogado;
              fatVenda.strNomVen    := fRetNomVendRep(fatVenda.strCodVen);
            End;

            fGetItem(qryGenIte,FieldByName('CODITE').AsString);

            strIteDes := FieldByName('DESITE').AsString;

            if blnGFIREF then
              strRefere := FieldByName('REFERE').AsString
            else
              strRefere := EmptyStr;

            If Not blnFabNfe then     //se verdadeiro, ao emitir NF, a DLL irá adicinar código de fábrica antecedendo a descrição
              strCodFab := FieldByName('CODFAB').AsString
            else
              strCodFab := EmptyStr;

            If blnImpRef Then
              If (fCfgSis('MONDES', varString) = '1') Then
                strIteDes := FieldByName('DESITE').AsString +
                             IIF(Not fEmptyStr(strRefere),' ' + strRefere, '') +
                             IIF(Not fEmptyStr(strCodFab),' ' + strCodFab, '')
              Else
                strIteDes := IIF(Not fEmptyStr(strCodFab),strCodFab + ' ', '') +
                             IIF(Not fEmptyStr(strRefere), strRefere + ' ', '') +
                             FieldByName('DESITE').AsString;

            strDesNes := IfThen(not fEmptyStr(cdsDocEnt.FieldByName('ITE_REFERE').AsString) And blnImpRef, fPadR(cdsDocEnt.FieldByName('ITE_REFERE').AsString, 20), '') +
                         IfThen(not fEmptyStr(cdsDocEnt.FieldByName('DET_NUMDOC').AsString), 'NF.:'+fStrZero(RightStr(cdsDocEnt.FieldByName('DET_NUMDOC').AsString, 9), 9), '') +
                         IfThen(not fEmptyStr(cdsDocEnt.FieldByName('DET_SERIE_').AsString), ' SÉRIE:'+fStrZero(cdsDocEnt.FieldByName('DET_SERIE_').AsString, 3),'') +
                         IfThen(not fEmptyStr(cdsDocEnt.FieldByName('ORDITE').AsString)    , ' SEQ.ITEM:'+fStrZero(cdsDocEnt.FieldByName('ORDITE').AsString, 4), '');

            fltPreEnv := fPrecoEnvio(qryGenIte);

            fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                                 Nil,
                                                 'NOR',
                                                 qryGenIte.FieldByName('ITE_CODGRU').AsString,
                                                 FieldByName('CODITE').AsString,
                                                 strIteDes,
                                                 strIteDes,
                                                 qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                                 qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                                 qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                                 qryGenIte.FieldByName('ITE_CODMAR').AsString,
                                                 edtCodFor.Text,
                                                 qryGenIte.FieldByName('ITE_REFERE').AsString,
                                                 IIF(blnDocDev, cdsDocEnt.FieldByName('DET_UNITAR').AsFloat, fltPreEnv), // fltUniOri
                                                 IIF(blnDocDev, cdsDocEnt.FieldByName('DET_UNITAR').AsFloat, fltPreEnv), // fltUniVis
                                                 IIF(blnDocDev, cdsDocEnt.FieldByName('DET_UNITAR').AsFloat, fltPreEnv), // fltUniTar
                                                 0.0,
                                                 0.0,
                                                 FieldByName('QTDREQ_1').AsFloat,
                                                 IIF(blnDocDev, roundTo(cdsDocEnt.FieldByName('DET_UNITAR').AsFloat,-intDecUni), fltPreEnv) * cdsGroup.FieldByName('QTDREQ_1').AsFloat, // fltTotIte
                                                 'S',
                                                 IIF(blnDocDev, cdsDocEnt.FieldByName('DET_UNITAR').AsFloat, FieldByName('PRECUS').AsFloat),
                                                 fFormataFloat(IIF(blnDocDev, cdsDocEnt.FieldByName('DET_UNITAR').AsFloat, FieldByName('PRECUS').AsFloat) * FieldByName('QTDREQ_1').AsFloat, 2), // fltTotCus
                                                 qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                                 IIF(blnEmpGar, IIF(blnDocDev, cdsDocEnt.FieldByName('DET_ALQIPI').AsFloat, qryGenIte.FieldByName('ITE_IPISAI').AsFloat), 0),
                                                 qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                                                 0.0,
                                                 qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                                 'N',
                                                 qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                                 qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                                 qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                                 cdsGroup.FieldByName('DOCDEV').AsString,
                                                 cdsGroup.FieldByName('ESPDEV').AsString,
                                                 cdsGroup.FieldByName('EMPDEV').AsString,
                                                 IIF(blnDocDev, FieldByName('QTDREQ_1').AsFloat, 0),               //QTDDEV
                                                 IIF(blnDocDev, cdsDocEnt.FieldByName('DET_UNITAR').AsFloat, 0),   //UNIDEV
                                                 IIF(blnDocDev, cdsDocEnt.FieldByName('AUTOINCREM').AsString, ''), //INCDEV
                                                 qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('QTDREQ_1').AsFloat,
                                                 qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                                 qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 0,
                                                 '',
                                                 0,
                                                 0,
                                                 0.00,
                                                 0.00,
                                                 0.00,
                                                 'N',
                                                 '',
                                                 0,
                                                 0,
                                                 qryGenIte.FieldByName('ABF_CODABF').AsString,
                                                 qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                                 'N',
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 fatVenda.fRetPerComGrupo(qryGenIte.FieldByName('ITE_CODGRU').AsString),
                                                 cdsGroup.FieldByName('CODFAB').AsString,
                                                 -1,
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                                 fRetNomMarca(qryGenIte.FieldByName('ITE_CODMAR').AsString),
                                                 '',
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 0,
                                                 strDesNes,
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                                 IIF(blnDocDev, cdsDocEnt.FieldByName('DET_UNITAR').AsFloat, fltPreEnv), // fltUniDig
                                                 qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                                 '',
                                                 '',
                                                 fRetSiglaUnidade(qryGenIte.FieldByName('UNI_CODUNI').AsString),
                                                 0.00,
                                                 StrToInt(cdsGroup.FieldByName('INCTMP').AsString),
                                                 '',
                                                 '',
                                                 '',
                                                 False,
                                                 '',
                                                 '',
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 IIF(fEmptyStr(FieldByName('TABPRE').AsString),'1',FieldByName('TABPRE').AsString),
                                                 IIF(blnDocDev, cdsDocEnt.FieldByName('DET_ALQIPI').AsFloat, qryGenIte.FieldByName('ITE_IPIENT').AsFloat),
                                                 qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                                 '',
                                                 0.0,
                                                 '',
                                                 0.0,
                                                 'R',
                                                 '',
                                                 'N',
                                                 '',
                                                 0,
                                                 FieldByName('QTDREQ_1').AsFloat,
                                                 0.0,
                                                 0,
                                                 qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                                 '',
                                                 0.00,
                                                 0.00,
                                                 0.00,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 recForTin,
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_NUMLOT').AsString,
                                                 '',
                                                 '',
                                                 False,
                                                 'N',
                                                 'NOR',
                                                 0,
                                                 '',
                                                 qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 1,
                                                 True,
                                                 '',
                                                 '',
                                                 '',
                                                 0,
                                                 IIF(blnDocDev, cdsDocEnt.FieldByName('DET_UNITAR').AsFloat, FieldByName('PRECUS').AsFloat), // fltCusIte
                                                 '',
                                                 '',
                                                 recMadeira,
                                                 qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('QTDREQ_1').AsFloat,
                                                 0,
                                                 0,
                                                 FieldByName('AUTINC').AsString,
                                                 0,
                                                 '',
                                                 '',
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 0,
                                                 '',
                                                 'N',
                                                 0,
                                                 0,
                                                 0,
                                                 False,
                                                 False,
                                                 'N',
                                                 '',
                                                 0,
                                                 0,
                                                 '',
                                                 'N',
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 0.00,
                                                 '',
                                                 '',
                                                 '',
                                                 'S',
                                                 'N',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 False,
                                                 -1,
                                                 -1,
                                                 'N',
                                                 '',
                                                 'N',
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 False,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 'N',
                                                 'N',
                                                 '',
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMMG').AsFloat);
            Result := True;
          End;

          Next;

        End;

        EnableControls;
      End;
      FreeAndNil(qryGenIte);

      if Not Result then
        pMensagemOk('Nenhum item foi selecionado para devolução. O processo será cancelado.');
    Except
      On E: Exception Do
      Begin
        if Result then
          Result := False;
        pMensagensErro(E.Message,'[TfrmGarantiaEnvFornecedor.fIncluiItens]');
      End;
    End;


  Finally
    cdsGroup.EnableControls;
    if Assigned(qryGenIte) then
      FreeAndNil(qryGenIte);
  End;
end;



function TfrmGarantiaEnvFornecedor.fObterMensagemDocDev: String;
  var
    lstDocumentos: TStringList;
    strDocDev: String;
begin
  if cdsDocEnt.IsEmpty then
    Exit;

  lstDocumentos := TStringList.Create;
  Try
    lstDocumentos.Clear;
    cdsDocEnt.First;
    While Not cdsDocEnt.Eof do
    begin
      strDocDev := fConcatenar([cdsDocEnt.FieldByName('DET_NUMDOC').AsString,
                                cdsDocEnt.FieldByName('DET_ESPDOC').AsString],
                                '-');

      if lstDocumentos.IndexOf(strDocDev) = -1 then
        lstDocumentos.Add(strDocDev);
      cdsDocEnt.Next;
    end;

    if lstDocumentos.Count = 0 then
      Exit;

    Result := 'Doc Origem: ' + lstDocumentos.CommaText;
  Finally
    if Assigned(lstDocumentos) then
      FreeAndNil(lstDocumentos);
  End;
end;

procedure TfrmGarantiaEnvFornecedor.pAlteraSemelhante;
  Var
    strCodFab: String;
Begin
  With cdsProdutos Do
  Begin
    strCodFab := FieldByName('CODFAB').AsString;
    If objMovGag.fRetornaSemelhante(FieldByName('CODITE').AsString, strCodFab) Then
    Begin
      objMovGag.fAlteraSemelhante(FieldByName('AUTINC').AsString, strCodFab);
      Edit;
      FieldByName('CODFAB').AsString := strCodFab;
      Post;
    End;  
  End;
End;

Function TfrmGarantiaEnvFornecedor.fCarregaDocEnt(strAutIncGar: String):Boolean;
begin

  if FControladorEnvioFornecedor.fAutoSelecaoDocumentoComSaldoDisponivel(cdsProdutos.FieldByName('CODITE').AsString,
                                                                         cdsProdutos.FieldByName('AUTINC').AsString,
                                                                         cdsProdutosQTDREQ_1.AsFloat) then
    Exit(True);

  Try
    pCriarFormularios(TfrmFatDigDatas, frmFatDigDatas);

    frmFatDigDatas.lblMsgOF.Visible := True;
    frmFatDigDatas.blnFatVenda := False;

    If (dtaDtaIni > 0) And (dtaDtaFim > 0) Then
    Begin
      frmFatDigDatas.mskDtaIni.Text := DateToStr(dtaDtaIni);
      frmFatDigDatas.mskDtaFin.Text := DateToStr(dtaDtaFim);
    End;

    frmFatDigDatas.ShowModal;
    if ( frmFatDigDatas.blnConfirma ) Then
    Begin
      dtaDtaIni := StrToDateDef( frmFatDigDatas.mskDtaIni.Text, fNow );
      dtaDtaFim := StrToDateDef( frmFatDigDatas.mskDtaFin.Text, fNow );
    End
    Else
    Begin
      dtaDtaIni := 0;
      dtaDtaFim := 0;
    End;
  Finally
    FreeAndNil(frmFatDigDatas);
  End;

  Result := FControladorEnvioFornecedor.fCarregarDocEnt(cdsProdutos.FieldByName('CODITE').AsString,
                                                        cdsProdutos.FieldByName('AUTINC').AsString,
                                                        cdsProdutos.FieldByName('NUMENT').AsString,
                                                        cdsProdutosQTDREQ_1.AsFloat,
                                                        dtaDtaIni,
                                                        dtaDtaFim,
                                                        enuTipoEnvioFornecedorGarantia,
                                                        fPermitirInformarChaveNFReferenciada);
end;




function TfrmGarantiaEnvFornecedor.fValidarSelecaoDocumentoOrigem: Boolean;
begin
  Result := blnGFSDOC or (enuTipoEnvioFornecedorGarantia <> tefDevolucao);
  If Result then
    Exit;

  Result := Not FControladorEnvioFornecedor.fTemGarantiaSemDocumentoDeVenda;
  if Not Result then
  begin
    fMensagem('Atenção','Documento de Devolução sem Nota Fiscal de Entrada associada.',['&Ok']);
    abort;
  end;
end;


function TfrmGarantiaEnvFornecedor.fGerarCreditoPagarEnvioFornecedorCFOPX949(const strClaFis: String): Boolean;
CONST
  SUFIXO_CFOP_OUTRAS_SAIDAS_5949: String = '949';
Var
  strCFOP: String;
begin
  Result := False;
  if Not blnGCP949 then
    Exit;

  if pos(strClaFis, strClaGae) = 0 then
    Exit;

  strCFOP := RightStr(strClaFis,3);

  Result := strCFOP = SUFIXO_CFOP_OUTRAS_SAIDAS_5949;
end;

procedure TfrmGarantiaEnvFornecedor.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
  Var
    strData: String;
    strOpe: String;
begin
  strData := Format('DATA: %s ',[FormatDateTime('dd/mm/yyyy',VS_Date)]);
  strOpe := Format('OPERADOR: %s ',[strLoginUsuarioLogado]);
  Excel.linhaAtual := Excel.linhaAtual + 3;
  Excel.Escrever(Excel.linhaAtual, Campos.ColunaPorNome['CODITE'].Coluna,strData);
  Excel.Escrever(Excel.linhaAtual, Campos.ColunaPorNome['CODFAB'].Coluna, strOpe);
  Excel.Escrever(Excel.linhaAtual, Campos.ColunaPorNome['QTDREQ'].Coluna, 'TOTAL DOS ITENS');
  Excel.Escrever(Excel.linhaAtual, Campos.ColunaPorNome['PRECUS'].Coluna, 'TOTAL UNITÁRIO');
  Excel.Escrever(Excel.linhaAtual, Campos.ColunaPorNome['VLRTOT'].Coluna, 'VALOR TOTAL');

  Excel.Alinhamento(Excel.linhaAtual, Campos.ColunaPorNome['QTDREQ'].Coluna, Direita);
  Excel.Alinhamento(Excel.linhaAtual, Campos.ColunaPorNome['PRECUS'].Coluna, Direita);
  Excel.Alinhamento(Excel.linhaAtual, Campos.ColunaPorNome['VLRTOT'].Coluna, Direita);

  Excel.linhaAtual := Excel.linhaAtual + 1;
  Excel.Escrever(Excel.linhaAtual, Campos.ColunaPorNome['QTDREQ'].Coluna, Quebra.Totais['QTDREQ']);
  Excel.Escrever(Excel.linhaAtual, Campos.ColunaPorNome['PRECUS'].Coluna, Quebra.Totais['PRECUS']);
  Excel.Escrever(Excel.linhaAtual, Campos.ColunaPorNome['VLRTOT'].Coluna, Quebra.Totais['VLRTOT']);
  Excel.Alinhamento(Excel.linhaAtual, Campos.ColunaPorNome['QTDREQ'].Coluna, Direita);
  Excel.Alinhamento(Excel.linhaAtual, Campos.ColunaPorNome['PRECUS'].Coluna, Direita);
  Excel.Alinhamento(Excel.linhaAtual, Campos.ColunaPorNome['VLRTOT'].Coluna, Direita);

end;

procedure TfrmGarantiaEnvFornecedor.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
begin
  Totais['QTDREQ'] := Totais['QTDREQ'] + Dados.FieldByName('QTDREQ').AsCurrency;
  Totais['PRECUS'] := Totais['PRECUS'] + Dados.FieldByName('PRECUS').AsCurrency;
  Totais['VLRTOT'] := Totais['VLRTOT'] + Dados.FieldByName('VLRTOT').AsCurrency;
end;

function TfrmGarantiaEnvFornecedor.fTravaDeRegistro(const pstrAutInc: String;
  const pblnTravar: Boolean): Boolean;
begin
  if pblnTravar And (lstDocSel.IndexOf(pstrAutInc) >= 0) then
  begin
    Result := True;
    Exit;
  end;

  Result := objLock.fLock_Unlock('GARANT_ENV_' + pstrAutInc, pblnTravar, False);

  if pblnTravar  then
  begin
    if Result then
      lstDocSel.add(pstrAutInc)
    else
      fMensagem('',
                'O Documento ' +
                  cdsProdutos.FieldByName('NUMENT').AsString  +
                    cdsProdutos.FieldByName('CODITE').AsString + ' está sendo utilizado em Outra Estação por ' +
                      fGetHostLock('GARANT_ENV_' + pstrAutInc)  + '!',
                ['&Ok']);
  end
  else
  begin
    if Result then
      if lstDocSel.IndexOf(pstrAutInc) >= 0 then
        lstDocSel.Delete(lstDocSel.IndexOf(pstrAutInc));
  end;
end;

procedure TfrmGarantiaEnvFornecedor.pSepararDocEnt;
Var
  i, n: integer;
  lDocEntradaGarantia: TDocEntradaGarantia;
begin
  cdsDocEnt.EmptyDataSet;
  for i := 0 to FControladorEnvioFornecedor.fContar -1 do
  begin
    FControladorEnvioFornecedor.pSelecionarItem(FControladorEnvioFornecedor.Item[i]);
    for n := 0 to (FControladorEnvioFornecedor.ItemSelecionado.fContarDocEntradaGarantia -1) do
    begin
      lDocEntradaGarantia := FControladorEnvioFornecedor.ItemSelecionado.DocEntradaGarantiaDeIndice[n];
      If (lDocEntradaGarantia.GarantiaItem = Nil) then
        Continue;

      if Not cdsDocEnt.Locate('AUTOINCREM;INCGAR',
                              VarArrayOf([lDocEntradaGarantia.DocEntradaItem.strAutInc,
                                          lDocEntradaGarantia.GarantiaItem.strAutInc]),
                              []) then
      begin
        cdsDocEnt.Insert;
        cdsDocEnt.FieldByName('AUTOINCREM').AsString := lDocEntradaGarantia.DocEntradaItem.strAutInc;
        cdsDocEnt.FieldByName('DET_NUMDOC').AsString := lDocEntradaGarantia.DocEntradaItem.strNumDoc;
        cdsDocEnt.FieldByName('DET_ESPDOC').AsString := lDocEntradaGarantia.DocEntradaItem.strEspDoc;
        cdsDocEnt.FieldByName('DET_SERIE_').AsString := lDocEntradaGarantia.DocEntradaItem.strSerie_;
        cdsDocEnt.FieldByName('DET_CODEMP').AsString := lDocEntradaGarantia.DocEntradaItem.strCodEmp;
        cdsDocEnt.FieldByName('DET_CODITE').AsString := lDocEntradaGarantia.DocEntradaItem.strCodIte;
        cdsDocEnt.FieldByName('ITE_DESITE').AsString := lDocEntradaGarantia.DocEntradaItem.strDesIte;
        cdsDocEnt.FieldByName('DET_UNITAR').AsFloat  := lDocEntradaGarantia.DocEntradaItem.fltUnitar;
        cdsDocEnt.FieldByName('DET_ALQIPI').AsFloat  := lDocEntradaGarantia.DocEntradaItem.fltAlqIpi;
        cdsDocEnt.FieldByName('ITE_REFERE').AsString := lDocEntradaGarantia.DocEntradaItem.strRefere;
        cdsDocEnt.FieldByName('FIS_ACESSO').AsString := lDocEntradaGarantia.DocEntradaItem.strAcesso;
        cdsDocEnt.FieldByName('ORDITE').AsString     := lDocEntradaGarantia.DocEntradaItem.strOrdIte;
        cdsDocEnt.FieldByName('INCGAR').AsString     := lDocEntradaGarantia.GarantiaItem.strAutInc;
        cdsDocEnt.FieldByName('QTDITE').AsFloat      := lDocEntradaGarantia.Quantidade;
        cdsDocEnt.FieldByName('MARDES').AsString     := '1';
        cdsDocEnt.Post;
      end;
    end;
  end;
end;

End.

