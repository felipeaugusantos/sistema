unit untGerarGTINAtualizarCadastroGS1CNP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Vcl.Mask,
  MaskEditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, QColorLabel,
  Uni, untGravando, cxCheckBox, untZClient, Produto.GS1CNP.Interfaces.Cadastro,
  untIteBar, cxMemo, Produto.GS1CNP.Shared.Types,
  Produto.GS1CNP.Interfaces.Atualiza, Produto.GS1CNP.Auth, cxTextEdit,
  cxButtonEdit, cxDropDownEdit, cxCalendar, Produto.GS1CNP.Shared.Exception;

type
  TfrmGerarGTINAtualizarCadastroGS1CNP = class(TfrmPaiSimples)
    pnlFiltro: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label50: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtProCadGS1: TEditFocus;
    Label8: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    grbDataCadastro: TGroupBox;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label4: TLabel;
    mskDtaFin: TMaskEditFocus;
    grbDataCadastroGS1: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    mskDtaIniCadGS1: TMaskEditFocus;
    mskDtaFinCadGS1: TMaskEditFocus;
    grbDataUltimaAtualizacaoGS1: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    mskDtaIniAtuGS1: TMaskEditFocus;
    mskDtaFinAtuGS1: TMaskEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    pnlGrid: TPanel;
    ColorLabel2: TColorLabel;
    btnEnviar: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnCadProduto: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    prbProgresso: TProgressBar;
    cxgProdutos: TcxGrid;
    cxgProdutosDBTableView1: TcxGridDBTableView;
    SELECIONADO: TcxGridDBColumn;
    ITE_CADGS1: TcxGridDBColumn;
    ITE_DTCGS1: TcxGridDBColumn;
    ITE_DTAGS1: TcxGridDBColumn;
    ITE_CODITE: TcxGridDBColumn;
    ITE_DESITE: TcxGridDBColumn;
    ITE_CODGPC: TcxGridDBColumn;
    GPC_DESGPC: TcxGridDBColumn;
    ITE_CLAIPI: TcxGridDBColumn;
    ITE_CDCEST: TcxGridDBColumn;
    ITE_CODMAR: TcxGridDBColumn;
    MAR_DESMAR: TcxGridDBColumn;
    ITE_CODUNI: TcxGridDBColumn;
    UNI_DESUNI: TcxGridDBColumn;
    UNI_CODUNG: TcxGridDBColumn;
    ITE_PESOIT: TcxGridDBColumn;
    ITE_PESLIQ: TcxGridDBColumn;
    ITE_IMGURL: TcxGridDBColumn;
    cxgProdutosLevel1: TcxGridLevel;
    dtsProdutos: TDataSource;
    BAR_CODBAR_1: TcxGridDBColumn;
    BAR_CODBAR_2: TcxGridDBColumn;
    BAR_CODBAR_3: TcxGridDBColumn;
    BAR_CODBAR_4: TcxGridDBColumn;
    BAR_CODBAR_5: TcxGridDBColumn;
    BAR_STGTIN_1: TcxGridDBColumn;
    BAR_STGTIN_2: TcxGridDBColumn;
    BAR_STGTIN_3: TcxGridDBColumn;
    BAR_STGTIN_4: TcxGridDBColumn;
    BAR_STGTIN_5: TcxGridDBColumn;
    INCONSISTENCIAS: TcxGridDBColumn;
    ITE_TEMPRO: TcxGridDBColumn;
    ITE_DTALAN: TcxGridDBColumn;
    rdgOpcoesServicos: TRadioGroup;
    STATUS: TcxGridDBColumn;
    Shape4: TShape;
    Label11: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label12: TLabel;
    Label13: TLabel;
    Shape3: TShape;
    Label14: TLabel;
    procedure edtDesIteKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCadProdutoClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure STATUSCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure INCONSISTENCIASPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    qryConGru: TUniQuery;
    qryConFor: TUniQuery;
    qryConMar: TUniQuery;

    cdsProdutos: TZClient;

    objIteBar: TIteBar;

    FAccessToken: String;

    procedure pCarregaLinGru;
    procedure pCarregaFornecedor;
    procedure pCarregaMarca;
    procedure pAtribuiTabelas;
    procedure pAbreConsulta;
    function fSqlConsulta: String;
    procedure pProcessaEmbalagens;
    procedure pAdicionarEmbalagensProdutos;
    procedure pSelecionar(const strOpcao: String);
    procedure pFechaConsulta;
    procedure pCadastrarOuAtualizarProdutoGS1CNP;
    procedure pCadastrarProdutoGS1CNP(const AIndex: Integer);
    procedure pCadastrarProdutoGS1CNPComGTIN(const AIndex: Integer);
    procedure pAtualizarProdutoGS1CNP(const AIndex: Integer);
    procedure pSetaRetornoCadastroProdutoGS1CNP(const ARetorno: IRetornoGS1CNPCadastro);
    procedure pSetaRetornoCadastroProdutoGS1CNPComGTIN(const ARetorno: IRetornoGS1CNPCadastro; const AIndex: Integer);
    procedure pSetaRetornoAtualizaProdutoGS1CNP(const ARetorno: IRetornoGS1CNPAtualiza; const AIndex: Integer);

    procedure pAtualizaDataSetProdutoCadastradoGS1CNP;
    procedure pAtualizaDataSetCodigoDeBarrasEStatusGTIN(const ARetorno: IRetornoGS1CNPCadastro);
    procedure pAtualizaDataSetStatusGTIN(const AStatus: String; const AIndex: Integer);
    procedure pSetaInconsistenciasCadastroProdutoGS1CNP(const ARetorno: IRetornoGS1CNPCadastro);
    procedure pSetaInconsistenciasAtualizaProdutoGS1CNP(const ARetorno: IRetornoGS1CNPAtualiza);
    procedure pAtualizaDataSetInconsistenciasProduto(const AValidations: TArrayValidations);
    procedure pAtualizaDataSetCamposObrigatoriosProduto(const AResponseError: TResponseError);

    procedure pSetaStatusDoProduto(const AResponseCode, AStatusGtin: String);
    procedure pAtualizaProdutoSelecionadoGrid;
    function fRetornaStatusGTIN(const AIndex: Integer): String;
    procedure pLimparStatusEInconsistencias;
    function fRegistroSelecionado: Boolean;
    procedure pSetaAccessTokenGS1CNP;
    procedure pAtualizaProduto(const AQryCad: TUniQuery);
    procedure pAtualizaCodigoDeBarras(const AQryBar: TUniQuery);
    procedure pAtualizaProdutoPreencheRecord(ARecProd: TArrayProduto; const AQryCad: TUniQuery);
    procedure pAtualizaProdutoPreencheClient(const ARecProd: TArrayProduto);

    function fRespostaSucessoComValidacoes(const AResponseCode: String; const AValidations: TArrayValidations): Boolean;
    function fRetornoCadastroProdutoGS1CNPSucesso(const ARetorno: IRetornoGS1CNPCadastro): Boolean;
    procedure pSetaClientStatusDoProduto(const AValue: String);
    function fStatusDoProdutoSucessoAtivo(const AResponseCode: String; const AStatusGtin: String): Boolean;
    function fStatusDoProdutoSucessoInativo(const AResponseCode: String; const AStatusGtin: String): Boolean;

    procedure pSetaParametroDesIte;
    procedure pSetaParametroLinGru;
    procedure pSetaParametroCodFor;
    procedure pSetaParametroCodMar;
    procedure pSetaParametroDataCadastro;
    procedure pSetaParametroDataCadastroGS1;
    procedure pSetaParametroDataUltimaAtualizacaoGS1;
    procedure pSetaParametrosConsulta;

    function fRetornaFiltrosConsultaDesIte: String;
    function fRetornaFiltrosConsultaLinGru: String;
    function fRetornaFiltrosConsultaCodFor: String;
    function fRetornaFiltrosConsultaCodMar: String;
    function fRetornaFiltrosConsultaDataCadastro: String;
    function fRetornaFiltrosConsultaDataCadastroGS1: String;
    function fRetornaFiltrosConsultaDataUltAtualizacaoGS1: String;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmGerarGTINAtualizarCadastroGS1CNP: TfrmGerarGTINAtualizarCadastroGS1CNP;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untPesqAux,
  Produto.GS1CNP.Controller, untCadProdutos, Produto.GS1CNP.Model,
  untMemo, Produto.GS1CNP.Shared.Constants;

{$R *.dfm}

{ TfrmGerarGTINAtualizarCadastroGS1CNP }

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.btnAdicionarClick(
  Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
  Begin
    Exit;
  End;

  TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde, Carregando Produtos...', '');
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.btnEnviarClick(Sender: TObject);
begin
  inherited;

  If Not cdsProdutos.Active Then
    Exit;

  If cdsProdutos.RecordCount = 0 Then
    Exit;

  If Not fRegistroSelecionado Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum registro foi selecionado!', ['&Ok']);
    Exit;
  End;

  Try
    cdsProdutos.DisableControls;

    prbProgresso.Position := 0;
    prbProgresso.Max      := cdsProdutos.RecordCount;
    prbProgresso.Visible  := True;
    Application.ProcessMessages;

    TfrmGravando.fExecutarModalA(pSetaAccessTokenGS1CNP, 'Aguarde autenticando...', '');

    If fEmptyStr(FAccessToken) Then
      Exit;

    cdsProdutos.First;
    While Not cdsProdutos.Eof Do
    Begin
      If (cxgProdutosDBTableView1.DataController.Values[cdsProdutos.RecNo - 1, 0] = 'S') Then
      Begin
        objIteBar.strCodIte := cdsProdutos.FieldByName('ITE_CODITE').AsString;
        pLimparStatusEInconsistencias;
        pCadastrarOuAtualizarProdutoGS1CNP;
      End;
      cdsProdutos.Next;
      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;
  Finally
    prbProgresso.Visible := False;
    cdsProdutos.EnableControls;
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.btnCadProdutoClick(
  Sender: TObject);
begin
  inherited;
  If (Not cdsProdutos.Active) Then
    Exit;

  If cdsProdutos.RecordCount = 0 Then
    Exit;

  pCriarForm(TfrmCadProdutos, frmCadProdutos);

  TfrmGravando.fExecutarModal(pAtualizaProdutoSelecionadoGrid, 'Atualizando informações do produto...', '');
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.btnCancelaItemClick(
  Sender: TObject);
begin
  inherited;
  pFechaConsulta;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.btnDesmarcarClick(
  Sender: TObject);
begin
  inherited;
  pSelecionar('N');
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.btnMarcarClick(Sender: TObject);
begin
  inherited;
  pSelecionar('S');
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.edtCodForKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrSel) Then
  Begin
    edtCodFor.Text := qryConFor.FieldByName('FOR_CODFOR').AsString;
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.edtCodMarKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrMarca : TConsultasArray;
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.edtDesIteKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, nil, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    pSetFocus(mskLinGru);
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.FormCreate(Sender: TObject);
begin
  inherited;
  cdsProdutos := TZClient.Create(Self);
  dtsProdutos.DataSet := cdsProdutos;
  objIteBar := TIteBar.Create(opcOperacoes);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsProdutos);
  FreeAndNil(objIteBar);
  FreeAndNil(qryConGru);
  FreeAndNil(qryConFor);
  FreeAndNil(qryConMar);
  inherited;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2    : btnMarcar.Click;
    VK_F3    : btnDesmarcar.Click;
    VK_F8    : btnCadProduto.Click;
    VK_F10   : btnEnviar.Click;
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.FormShow(Sender: TObject);
begin
  inherited;
  pAtribuiTabelas;
  btnCadProduto.Visible := fVerificaAcessoSistema('frmCadProdutos');
  pSetFocus(mskDtaIni);
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRegistroSelecionado: Boolean;
begin
  Result := False;
  Try
    cdsProdutos.DisableControls;
    cdsProdutos.First;
    While Not cdsProdutos.Eof Do
    Begin
      If (cxgProdutosDBTableView1.DataController.Values[cdsProdutos.RecNo - 1, 0] = 'S') Then
      Begin
        Result := True;
        Exit;
      End;
      cdsProdutos.Next;
    End;
  Finally
    cdsProdutos.First;
    cdsProdutos.EnableControls;
  End;
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRespostaSucessoComValidacoes(const AResponseCode: String; const AValidations: TArrayValidations): Boolean;
begin
  Result := False;

  If (AResponseCode <> '200') Then
    Exit;

  If (Length(AValidations) <= 0) Then
    Exit;

  Result := True;
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRetornaFiltrosConsultaCodFor: String;
begin
  Result := '';

  If fEmptyStr(edtCodFor.Text) Then
    Exit;

  Result := Result + ' AND I.ITE_CODFOR = :CODFOR ';
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRetornaFiltrosConsultaCodMar: String;
begin
  Result := '';

  If fEmptyStr(edtCodMar.Text) Then
    Exit;

  Result := Result + ' AND I.ITE_CODMAR = :CODMAR ';
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRetornaFiltrosConsultaDataCadastro: String;
begin
  Result := '';

  If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Exit;

  Result := Result + '  AND I.ITE_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRetornaFiltrosConsultaDataCadastroGS1: String;
begin
  Result := '';

  If fEmptyStr(fTiraCaracEspeciais(mskDtaIniCadGS1.Text)) Then
    Exit;

  Result := Result + '  AND I.ITE_DTCGS1 BETWEEN :DTCGSI AND :DTCGSF ';
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRetornaFiltrosConsultaDataUltAtualizacaoGS1: String;
begin
  Result := '';

  If fEmptyStr(fTiraCaracEspeciais(mskDtaIniAtuGS1.Text)) Then
    Exit;

  Result := Result + '  AND I.ITE_DTAGS1 BETWEEN :DTAGSI AND :DTAGSF ';
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRetornaFiltrosConsultaDesIte: String;
begin
  Result := '';

  If fEmptyStr(edtDesIte.Text) Then
    Exit;

  Result := Result + ' AND I.ITE_DESITE LIKE :DESITE ';
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRetornaFiltrosConsultaLinGru: String;
begin
  Result := '';

  If fEmptyStr(mskLinGru.Text) Then
    Exit;

  If Copy(mskLinGru.Text,4,3) = '000' then
    Result := Result + ' AND I.ITE_CODGRU LIKE :CODGRU '
  Else
    Result := Result + ' AND I.ITE_CODGRU = :CODGRU  ';
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRetornaStatusGTIN(const AIndex: Integer): String;
begin
  Result := IIF(fEmptyStr(cdsProdutos.FieldByName('BAR_STGTIN_' + intToStr(AIndex)).AsString), STATUS_GTIN_ACTIVE, cdsProdutos.FieldByName('BAR_STGTIN_' + intToStr(AIndex)).AsString);
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fRetornoCadastroProdutoGS1CNPSucesso(
  const ARetorno: IRetornoGS1CNPCadastro): Boolean;
begin
  Result := False;

  If (ARetorno.GetResponseCode <> '200') Then
    Exit;

  If (ARetorno.GetResponseSuccess.result <> 'SUCCESS') Then
    Exit;

  Result := True;
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fSqlConsulta: String;
begin
  Result := '';
  Result := Result + 'SELECT "S" AS SELECIONADO, ';
  Result := Result + '       "NAO" AS STATUS, '; //status do registro
  Result := Result + '       I.ITE_CADGS1, ';
  Result := Result + '       I.ITE_DTCGS1, ';
  Result := Result + '       I.ITE_DTAGS1, ';
  Result := Result + '       I.ITE_CODITE, ';
  Result := Result + '       I.ITE_DESITE, ';
  Result := Result + '       I.ITE_CODGPC, ';
  Result := Result + '       GPC_DESGPC,   ';
  Result := Result + '       I.ITE_CLAIPI, ';
  Result := Result + '       I.ITE_CDCEST, ';
  Result := Result + '       I.ITE_CODMAR, ';
  Result := Result + '       MAR_DESMAR,   ';
  Result := Result + '       I.ITE_CODUNI, ';
  Result := Result + '       UNI_DESUNI,   ';
  Result := Result + '       UNI_CODUNG,   ';
  Result := Result + '       I.ITE_PESOIT, ';
  Result := Result + '       I.ITE_PESLIQ, ';
  Result := Result + '       ITE_IMGURL,   ';
  Result := Result + '       I.ITE_TEMPRO, ';
  Result := Result + '       I.ITE_DTALAN, ';

  Result := Result + '       "" AS BAR_CODBAR_1, ';
  Result := Result + '       "" AS BAR_STGTIN_1, ';
  Result := Result + '       "" AS BAR_EANTRB_1, ';

  Result := Result + '       "" AS BAR_CODBAR_2, ';
  Result := Result + '       "" AS BAR_STGTIN_2, ';
  Result := Result + '       "" AS BAR_EANTRB_2, ';

  Result := Result + '       "" AS BAR_CODBAR_3, ';
  Result := Result + '       "" AS BAR_STGTIN_3, ';
  Result := Result + '       "" AS BAR_EANTRB_3, ';

  Result := Result + '       "" AS BAR_CODBAR_4, ';
  Result := Result + '       "" AS BAR_STGTIN_4, ';
  Result := Result + '       "" AS BAR_EANTRB_4, ';

  Result := Result + '       "" AS BAR_CODBAR_5, ';
  Result := Result + '       "" AS BAR_STGTIN_5, ';
  Result := Result + '       "" AS BAR_EANTRB_5, ';

  Result := Result + '       "" AS INCONSISTENCIAS ';

  Result := Result + '  FROM CADITE I ';
  Result := Result + '  LEFT JOIN CADGPC ON GPC_CODGPC = I.ITE_CODGPC ';
  Result := Result + '  LEFT JOIN CADMAR ON MAR_CODMAR = I.ITE_CODMAR ';
  Result := Result + '  LEFT JOIN CADUNI ON UNI_CODUNI = I.ITE_CODUNI ';
  Result := Result + '  LEFT JOIN ITEIMG M ON M.ITE_CODITE = I.ITE_CODITE ';
  Result := Result + '                    AND M.ITE_PRINCI = "S" ';

  Result := Result + '  WHERE (1=1) ';

  Result := Result + '    AND I.ITE_CADGS1 = :CADGS1 ';

  Result := Result + fRetornaFiltrosConsultaDesIte;

  Result := Result + fRetornaFiltrosConsultaLinGru;

  Result := Result + fRetornaFiltrosConsultaCodFor;

  Result := Result + fRetornaFiltrosConsultaCodMar;

  Result := Result + fRetornaFiltrosConsultaDataCadastro;

  Result := Result + fRetornaFiltrosConsultaDataCadastroGS1;

  Result := Result + fRetornaFiltrosConsultaDataUltAtualizacaoGS1;
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fStatusDoProdutoSucessoAtivo(
  const AResponseCode, AStatusGtin: String): Boolean;
begin
  Result := False;

  If (AResponseCode <> '200') Then
    Exit;

  If (AStatusGtin <> STATUS_GTIN_ACTIVE) Then
    Exit;

  Result := True;
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fStatusDoProdutoSucessoInativo(
  const AResponseCode, AStatusGtin: String): Boolean;
begin
  Result := False;

  If (AResponseCode <> '200') Then
    Exit;

  If (AStatusGtin = STATUS_GTIN_ACTIVE) Then
    Exit;

  Result := True;
end;

function TfrmGerarGTINAtualizarCadastroGS1CNP.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaFin) And (mskDtaFin.Enabled) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
         fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
        Result := False;
      End

      Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
              (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser maior que a data inicial!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFinCadGS1) And (mskDtaFinCadGS1.Enabled) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCadGS1.Text))) And
         fEmptyStr(fTiraCaracEspeciais(mskDtaFinCadGS1.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final de cadastro na GS1 deve ser preenchida!', ['&Ok']);
        Result := False;
      End

      Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCadGS1.Text))) And
              (Not fValidaPeriodo(mskDtaIniCadGS1.Text, mskDtaFinCadGS1.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final de cadastro na GS1 deve ser maior que a data inicial!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFinAtuGS1) And (mskDtaFinAtuGS1.Enabled) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniAtuGS1.Text))) And
         fEmptyStr(fTiraCaracEspeciais(mskDtaFinAtuGS1.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final de atualização na GS1 deve ser preenchida!', ['&Ok']);
        Result := False;
      End

      Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniAtuGS1.Text))) And
              (Not fValidaPeriodo(mskDtaIniAtuGS1.Text, mskDtaFinAtuGS1.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final de atualização na GS1 deve ser maior que a data inicial!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = mskLinGru) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
      Begin
        edtDesGru.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaLinGru;
        If qryConGru.FieldByName('GRU_CODGRU').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Linha / Grupo não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        edtNomFor.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaFornecedor;
        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
      Begin
        edtDesMar.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaMarca;
        If qryConMar.FieldByName('MAR_CODMAR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Marca não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtProCadGS1) Then
    Begin
      If Pos(edtProCadGS1.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Produto cadastrado na GS1 deve ser S ou N !', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.INCONSISTENCIASPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  TfrmMemo.pShowMessage(cdsProdutos.FieldByName('INCONSISTENCIAS').AsString, 9, False, 800, 600);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.mskLinGruKeyPress(
  Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, arrSel) Then
  Begin
    if fValidaCampos(mskLinGru, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAbreConsulta;
begin
  Try
    cxgProdutos.Enabled := False;

    cdsProdutos.qryQuery.Close;

    cdsProdutos.qryQuery.SQL.Text := fSqlConsulta;

    pSetaParametrosConsulta;

    cdsProdutos.fAbreClient(True, 'TfrmGerarGTINAtualizarCadastroGS1CNP.pAbreConsulta');

    TFloatField(cdsProdutos.FieldByName('ITE_PESOIT')).DisplayFormat := fMskDigitos(fCfgSis('DECBRU', varInteger));
    TFloatField(cdsProdutos.FieldByName('ITE_PESLIQ')).DisplayFormat := '#,###0.000';

    pProcessaEmbalagens;

    cdsProdutos.IndexFieldNames := 'ITE_CODITE';

    cxgProdutos.Enabled := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmConsultaPedidos.pAbreConsulta');
    End;
  End;

  pSetFocus(cxgProdutos);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAdicionarEmbalagensProdutos;
var
  LQryBar: TUniQuery;
begin
  LQryBar := fCriaQuery(Nil);
  Try
    LQryBar.Close;
    LQryBar.SQL.Clear;
    LQryBar.SQL.Add('SELECT BAR_CODBAR, BAR_STGTIN, BAR_EANTRB FROM ITEBAR WHERE BAR_CODITE = :CODITE ORDER BY BAR_PRINCI DESC');
    LQryBar.ParamByName('CODITE').AsString := cdsProdutos.FieldByName('ITE_CODITE').AsString;
    LQryBar.Open;

    LQryBar.First;
    while not LQryBar.Eof do
    begin
      If LQryBar.RecNo > 5 Then
        Exit;

      cdsProdutos.Edit;
      cdsProdutos.FieldByName('BAR_CODBAR_' + intToStr(LQryBar.RecNo)).AsString := LQryBar.FieldByName('BAR_CODBAR').AsString;
      cdsProdutos.FieldByName('BAR_STGTIN_' + intToStr(LQryBar.RecNo)).AsString := LQryBar.FieldByName('BAR_STGTIN').AsString;
      cdsProdutos.FieldByName('BAR_EANTRB_' + intToStr(LQryBar.RecNo)).AsString := LQryBar.FieldByName('BAR_EANTRB').AsString;
      cdsProdutos.Post;

      LQryBar.Next;
    end;
  Finally
   FreeAndNil(LQryBar);
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtribuiTabelas;
begin
  qryConGru := fCriarQuery('SELECT * FROM CADGRU WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConMar := fCriarQuery('SELECT * FROM CADMAR WHERE FALSE', Self);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizaCodigoDeBarras(
  const AQryBar: TUniQuery);
begin
  If AQryBar.RecordCount > 0 Then
  Begin
    AQryBar.First;
    While Not AQryBar.Eof Do
    Begin
      If (AQryBar.FieldByName('BAR_STGTIN').AsString <> cdsProdutos.FieldByName('BAR_STGTIN_' + intToStr(AQryBar.RecNo)).AsString) Then
      Begin
        cdsProdutos.Edit;
        cdsProdutos.FieldByName('BAR_STGTIN_' + intToStr(AQryBar.RecNo)).AsString := AQryBar.FieldByName('BAR_STGTIN').AsString;
        cdsProdutos.Post;
      End;

      AQryBar.Next;
    End;
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizaDataSetCamposObrigatoriosProduto(
  const AResponseError: TResponseError);
begin
  If Length(AResponseError.data.validations) <= 0 Then //error = 'Unprocessable Entity'
  Begin
    cdsProdutos.Edit;
    cdsProdutos.FieldByName('INCONSISTENCIAS').AsString :=
      cdsProdutos.FieldByName('INCONSISTENCIAS').AsString + #13#10 + #13#10 + TConvertCamposObrigatorios.GetMessage(AResponseError.messageError);
    cdsProdutos.Post;
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizaDataSetCodigoDeBarrasEStatusGTIN(
  const ARetorno: IRetornoGS1CNPCadastro);
begin
  cdsProdutos.Edit;
  cdsProdutos.FieldByName('BAR_CODBAR_1').AsString := ARetorno.GetResponseSuccess.product.gs1TradeItemIdentificationKey.gtin;
  cdsProdutos.FieldByName('BAR_STGTIN_1').AsString := ARetorno.GetResponseSuccess.product.gtinStatusCode;
  cdsProdutos.Post;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaAccessTokenGS1CNP;
begin
  FAccessToken := '';
  FAccessToken := TProdutoGS1CNPAuth.GetAcessToken;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaClientStatusDoProduto(
  const AValue: String);
begin
  cdsProdutos.Edit;
  cdsProdutos.FieldByName('STATUS').AsString := AValue;
  cdsProdutos.Post;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaInconsistenciasAtualizaProdutoGS1CNP(
  const ARetorno: IRetornoGS1CNPAtualiza);
begin
  if (ARetorno.GetResponseCode = '400') then // 400 - error
  begin
    pAtualizaDataSetInconsistenciasProduto(ARetorno.GetResponseError.data.validations);
    pAtualizaDataSetCamposObrigatoriosProduto(ARetorno.GetResponseError);
  end;

  if fRespostaSucessoComValidacoes(ARetorno.GetResponseCode, ARetorno.GetResponseSuccess.validations) Then // Sucesso mas tem validacoes
    pAtualizaDataSetInconsistenciasProduto(ARetorno.GetResponseSuccess.validations);

  pSetaStatusDoProduto(ARetorno.GetResponseCode, ARetorno.GetResponseSuccess.product.gtinStatusCode);

  TProdutoGS1CNPModel.GravarGS1JsonResponse(objIteBar.strCodIte, ARetorno.GetJsonResponse, Self.Name, 'Atualizar');
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaInconsistenciasCadastroProdutoGS1CNP(
  const ARetorno: IRetornoGS1CNPCadastro);
begin
  if (ARetorno.GetResponseCode = '400') then // 400 - error
  begin
    pAtualizaDataSetInconsistenciasProduto(ARetorno.GetResponseError.data.validations);
    pAtualizaDataSetCamposObrigatoriosProduto(ARetorno.GetResponseError);
  end;

  if fRespostaSucessoComValidacoes(ARetorno.GetResponseCode, ARetorno.GetResponseSuccess.validations) Then // Sucesso mas tem validacoes
    pAtualizaDataSetInconsistenciasProduto(ARetorno.GetResponseSuccess.validations);

  pSetaStatusDoProduto(ARetorno.GetResponseCode, ARetorno.GetResponseSuccess.product.gtinStatusCode);

  TProdutoGS1CNPModel.GravarGS1JsonResponse(objIteBar.strCodIte, ARetorno.GetJsonResponse, Self.Name, 'Cadastrar');
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaParametroCodFor;
begin
  If fEmptyStr(edtCodFor.Text) Then
    Exit;

  cdsProdutos.qryQuery.ParamByName('CODFOR').AsString := edtCodFor.Text;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaParametroCodMar;
begin
  If fEmptyStr(edtCodMar.Text) Then
    Exit;

  cdsProdutos.qryQuery.ParamByName('CODMAR').AsString := edtCodMar.Text;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaParametroDataCadastro;
begin
  If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Exit;

  cdsProdutos.qryQuery.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
  cdsProdutos.qryQuery.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaParametroDataCadastroGS1;
begin
  If fEmptyStr(fTiraCaracEspeciais(mskDtaIniCadGS1.Text)) Then
    Exit;

  cdsProdutos.qryQuery.ParamByName('DTCGSI').AsDateTime := StrToDate(mskDtaIniCadGS1.Text);
  cdsProdutos.qryQuery.ParamByName('DTCGSF').AsDateTime := StrToDate(mskDtaFinCadGS1.Text);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaParametroDataUltimaAtualizacaoGS1;
begin
  If fEmptyStr(fTiraCaracEspeciais(mskDtaIniAtuGS1.Text)) Then
    Exit;

  cdsProdutos.qryQuery.ParamByName('DTAGSI').AsDateTime := StrToDate(mskDtaIniAtuGS1.Text);
  cdsProdutos.qryQuery.ParamByName('DTAGSF').AsDateTime := StrToDate(mskDtaFinAtuGS1.Text);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaParametroDesIte;
begin
  If fEmptyStr(edtDesIte.Text) Then
    Exit;

  cdsProdutos.qryQuery.ParamByName('DESITE').AsString := edtDesIte.Text + '%';
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaParametroLinGru;
begin
  If fEmptyStr(mskLinGru.Text) Then
    Exit;

  If Copy(mskLinGru.Text,4,3) = '000' then
    cdsProdutos.qryQuery.ParamByName('CODGRU').AsString := Copy(mskLinGru.Text,1,3)+'%'
  Else
    cdsProdutos.qryQuery.ParamByName('CODGRU').AsString := mskLinGru.Text;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaParametrosConsulta;
begin
  cdsProdutos.qryQuery.ParamByName('CADGS1').AsString := edtProCadGS1.Text;

  pSetaParametroDesIte;

  pSetaParametroLinGru;

  pSetaParametroCodFor;

  pSetaParametroCodMar;

  pSetaParametroDataCadastro;

  pSetaParametroDataCadastroGS1;

  pSetaParametroDataUltimaAtualizacaoGS1;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizaDataSetInconsistenciasProduto(const AValidations: TArrayValidations);
var
  LContador: Integer;
begin
  for LContador := 0 to Length(AValidations) - 1 do
  begin
    cdsProdutos.Edit;
    cdsProdutos.FieldByName('INCONSISTENCIAS').AsString := cdsProdutos.FieldByName('INCONSISTENCIAS').AsString + #13#10 + #13#10 + AValidations[LContador].messageValidations;
    cdsProdutos.Post;
  end;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizaDataSetProdutoCadastradoGS1CNP;
begin
  cdsProdutos.Edit;
  cdsProdutos.FieldByName('ITE_CADGS1').AsString   := 'S';
  cdsProdutos.FieldByName('ITE_DTCGS1').AsDateTime := VS_Date;
  cdsProdutos.FieldByName('ITE_DTAGS1').AsDateTime := VS_Date;
  cdsProdutos.Post;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizaDataSetStatusGTIN(const AStatus: String; const AIndex: Integer);
begin
  cdsProdutos.Edit;
  cdsProdutos.FieldByName('BAR_STGTIN_' + intToStr(AIndex)).AsString := AStatus;
  cdsProdutos.Post;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizaProduto(
  const AQryCad: TUniQuery);
var
  ARecProd: TArrayProduto;
begin
  SetLength(ARecProd, 0);
  pAtualizaProdutoPreencheRecord(ARecProd, AQryCad);
  pAtualizaProdutoPreencheClient(ARecProd);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizaProdutoPreencheClient(
  const ARecProd: TArrayProduto);
var
  LContRecProd: Integer;
begin
  If Length(ARecProd) > 0 Then
  Begin
    cdsProdutos.Edit;
    For LContRecProd := 0 To Length(ARecProd) - 1 Do
    Begin
      cdsProdutos.FieldByName(ARecProd[LContRecProd].campo).Value := ARecProd[LContRecProd].valor;
      If (ARecProd[LContRecProd].campo = 'ITE_CODGPC') Then
        cdsProdutos.FieldByName('GPC_DESGPC').AsString := fRetNomGpc(ARecProd[LContRecProd].valor);
      If (ARecProd[LContRecProd].campo = 'ITE_CODMAR') Then
        cdsProdutos.FieldByName('MAR_DESMAR').AsString := fRetNomMarca(ARecProd[LContRecProd].valor);
      If (ARecProd[LContRecProd].campo = 'ITE_CODUNI') Then
      Begin
        cdsProdutos.FieldByName('UNI_DESUNI').AsString := fRetNomUnidade(ARecProd[LContRecProd].valor);
        cdsProdutos.FieldByName('UNI_CODUNG').AsString := fRetCodigoUnidadeGS1(ARecProd[LContRecProd].valor);
      End;
    End;
    cdsProdutos.Post;
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizaProdutoPreencheRecord(
  ARecProd: TArrayProduto; const AQryCad: TUniQuery);
var
  LContCadastro: Integer;
  LContView: Integer;
begin
  For LContCadastro := 0 To AQryCad.Fields.Count - 1 Do
  Begin
    For LContView := 0 To cdsProdutos.Fields.Count - 1 Do
    Begin
      If AQryCad.Fields[LContCadastro].FieldName = cdsProdutos.Fields[LContView].FieldName Then
      Begin
        If AQryCad.Fields[LContCadastro].Value <> cdsProdutos.Fields[LContView].Value Then
        Begin
          SetLength(ARecProd, Length(ARecProd) + 1);

          ARecProd[Length(ARecProd) - 1].campo := AQryCad.Fields[LContCadastro].FieldName;
          ARecProd[Length(ARecProd) - 1].valor := AQryCad.Fields[LContCadastro].Value;
        End;
      End;
    End;
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizaProdutoSelecionadoGrid;
var
  LQryCad: TUniQuery;
  LQryBar: TUniQuery;
begin
  LQryCad:= fCriaQuery(Nil);
  LQryBar:= fCriaQuery(Nil);
  Try
    LQryCad.Close;
    LQryCad.SQL.Clear;
    LQryCad.SQL.Add('SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE');
    LQryCad.ParamByName('CODITE').AsString := cdsProdutos.FieldByName('ITE_CODITE').AsString;
    LQryCad.Open;

    LQryBar.Close;
    LQryBar.SQL.Clear;
    LQryBar.SQL.Add('SELECT BAR_CODBAR, BAR_STGTIN FROM ITEBAR WHERE BAR_CODITE = :CODITE ORDER BY BAR_PRINCI DESC');
    LQryBar.ParamByName('CODITE').AsString := cdsProdutos.FieldByName('ITE_CODITE').AsString;
    LQryBar.Open;

    cdsProdutos.DisableControls;

    pAtualizaProduto(LQryCad);

    pAtualizaCodigoDeBarras(LQryBar);
  Finally
    FreeAndNil(LQryCad);
    FreeAndNil(LQryBar);
    cdsProdutos.EnableControls;
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pAtualizarProdutoGS1CNP(const AIndex: Integer);
var
  LRetorno: IRetornoGS1CNPAtualiza;
  LCodigoBarrasTributavel: Boolean;
begin
  If fEmptyStr(cdsProdutos.FieldByName('BAR_CODBAR_' + intToStr(AIndex)).AsString) Then
    Exit;

  LCodigoBarrasTributavel := cdsProdutos.FieldByName('BAR_EANTRB_' + intToStr(AIndex)).AsString = 'S';

  LRetorno :=
    TProdutoGS1CNPController.New.Atualizar(cdsProdutos,
                                           cdsProdutos.FieldByName('BAR_CODBAR_' + intToStr(AIndex)).AsString,
                                           LCodigoBarrasTributavel,
                                           FAccessToken,
                                           fRetornaStatusGTIN(AIndex));

  pSetaInconsistenciasAtualizaProdutoGS1CNP(LRetorno);
  pSetaRetornoAtualizaProdutoGS1CNP(LRetorno, AIndex);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pCadastrarOuAtualizarProdutoGS1CNP;
var
  intContador: Integer;
begin
  For intContador := 1 To 5 Do
  Begin
    Case rdgOpcoesServicos.ItemIndex Of
      0: pCadastrarProdutoGS1CNP(intContador);
      1: pCadastrarProdutoGS1CNPComGTIN(intContador);
      2: pAtualizarProdutoGS1CNP(intContador);
    End;
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pCadastrarProdutoGS1CNP(const AIndex: Integer);
var
  LRetorno: IRetornoGS1CNPCadastro;
begin
  If AIndex > 1 Then //indica que é um cadastro do zero;
    Exit;

  If Not fEmptyStr(cdsProdutos.FieldByName('BAR_CODBAR_' + intToStr(AIndex)).AsString) Then
    Exit;

  LRetorno := TProdutoGS1CNPController.New.Cadastrar(cdsProdutos, '', False, FAccessToken, fRetornaStatusGTIN(AIndex));
  pSetaInconsistenciasCadastroProdutoGS1CNP(LRetorno);
  pSetaRetornoCadastroProdutoGS1CNP(LRetorno);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pCadastrarProdutoGS1CNPComGTIN(const AIndex: Integer);
var
  LRetorno: IRetornoGS1CNPCadastro;
  LCodigoBarrasTributavel: Boolean;
begin
  If fEmptyStr(cdsProdutos.FieldByName('BAR_CODBAR_' + intToStr(AIndex)).AsString) Then
    Exit;

  LCodigoBarrasTributavel := cdsProdutos.FieldByName('BAR_EANTRB_' + intToStr(AIndex)).AsString = 'S';

  LRetorno :=
    TProdutoGS1CNPController.New.Cadastrar(cdsProdutos,
                                           cdsProdutos.FieldByName('BAR_CODBAR_' + intToStr(AIndex)).AsString,
                                           LCodigoBarrasTributavel,
                                           FAccessToken,
                                           fRetornaStatusGTIN(AIndex));

  pSetaInconsistenciasCadastroProdutoGS1CNP(LRetorno);
  pSetaRetornoCadastroProdutoGS1CNPComGTIN(LRetorno, AIndex);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);

  edtNomFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pCarregaLinGru;
begin
  pPesquisaLinGru(qryConGru, qryConGru, mskLinGru.Text);

  edtDesGru.Text := qryConGru.FieldByName('GRU_DESGRU').AsString;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pCarregaMarca;
begin
  pPesquisaCadMar(qryConMar, qryConMar, edtCodMar.Text);

  edtDesMar.Text := qryConMar.FieldByName('MAR_DESMAR').AsString;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pFechaConsulta;
begin
  cdsProdutos.Close;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  mskDtaIniCadGS1.Clear;
  mskDtaFinCadGS1.Clear;
  mskDtaIniAtuGS1.Clear;
  mskDtaFinAtuGS1.Clear;
  edtDesIte.Clear;
  mskLinGru.Clear;
  edtDesGru.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtProCadGS1.Text := 'N';
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pLimparStatusEInconsistencias;
begin
  cdsProdutos.Edit;
  cdsProdutos.FieldByName('STATUS').AsString := 'NAO';
  cdsProdutos.FieldByName('INCONSISTENCIAS').AsString := '';
  cdsProdutos.Post;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSelecionar(
  const strOpcao: String);
begin
  If Not cdsProdutos.Active Then
    Exit;

  If cdsProdutos.RecordCount = 0 Then
    Exit;

  Try
    cdsProdutos.DisableControls;

    cdsProdutos.First;
    While Not cdsProdutos.Eof Do
    Begin
      cdsProdutos.Edit;
      cdsProdutos.FieldByName('SELECIONADO').AsString := strOpcao;
      cdsProdutos.Post;

      cdsProdutos.Next;
    End;
  Finally
    cdsProdutos.EnableControls;
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaRetornoAtualizaProdutoGS1CNP(const ARetorno: IRetornoGS1CNPAtualiza; const AIndex: Integer);
begin
  If (ARetorno.GetResponseCode = '200') Then //200 - sucesso
  Begin
    If (cdsProdutos.FieldByName('ITE_CADGS1').AsString = 'S') Then
    Begin
      objIteBar.pAtualizaCadIteProdutoCadastradoGS1CNP(False);
    End;

    If (cdsProdutos.FieldByName('ITE_CADGS1').AsString = 'N') Then
    Begin
      objIteBar.pAtualizaCadIteProdutoCadastradoGS1CNP(True);
      pAtualizaDataSetProdutoCadastradoGS1CNP;
    End;

    objIteBar.pAtualizaIteBarStatusGS1CNP(cdsProdutos.FieldByName('ITE_CODITE').AsString,
                                          cdsProdutos.FieldByName('BAR_CODBAR_' + intToStr(AIndex)).AsString,
                                          ARetorno.GetResponseSuccess.product.gtinStatusCode);

    pAtualizaDataSetStatusGTIN(ARetorno.GetResponseSuccess.product.gtinStatusCode, AIndex);
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaRetornoCadastroProdutoGS1CNP(
  const ARetorno: IRetornoGS1CNPCadastro);
var
  blnPrincipal: Boolean;
begin
  If Not fRetornoCadastroProdutoGS1CNPSucesso(ARetorno) Then
    Exit;

  blnPrincipal := True;

  objIteBar.pAtualizaCadIteProdutoCadastradoGS1CNP(True);
  pAtualizaDataSetProdutoCadastradoGS1CNP;

  objIteBar.pCarregaDados(objIteBar.strCodIte);
  objIteBar.pIncluiCodigo(ARetorno.GetResponseSuccess.product.gs1TradeItemIdentificationKey.gtin,
                          1, blnPrincipal, False, False, 0.0, '', '1', '', 0, 0, 0, 0, 0, 0, 0, 0,
                          False, ARetorno.GetResponseSuccess.product.gtinStatusCode, '');
  objIteBar.pSalvaDados(objIteBar.strCodIte, True);

  pAtualizaDataSetCodigoDeBarrasEStatusGTIN(ARetorno);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaRetornoCadastroProdutoGS1CNPComGTIN(const ARetorno: IRetornoGS1CNPCadastro; const AIndex: Integer);
begin
  If Not fRetornoCadastroProdutoGS1CNPSucesso(ARetorno) Then
    Exit;

  If (cdsProdutos.FieldByName('ITE_CADGS1').AsString = 'S') Then
  Begin
    objIteBar.pAtualizaCadIteProdutoCadastradoGS1CNP(False);
  End;

  If (cdsProdutos.FieldByName('ITE_CADGS1').AsString = 'N') Then
  Begin
    objIteBar.pAtualizaCadIteProdutoCadastradoGS1CNP(True);
    pAtualizaDataSetProdutoCadastradoGS1CNP;
  End;

  objIteBar.pAtualizaIteBarStatusGS1CNP(cdsProdutos.FieldByName('ITE_CODITE').AsString,
                                        cdsProdutos.FieldByName('BAR_CODBAR_' + intToStr(AIndex)).AsString,
                                        ARetorno.GetResponseSuccess.product.gtinStatusCode);

  pAtualizaDataSetStatusGTIN(ARetorno.GetResponseSuccess.product.gtinStatusCode, AIndex);
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pSetaStatusDoProduto(
  const AResponseCode, AStatusGtin: String);
begin
  If fStatusDoProdutoSucessoAtivo(AResponseCode, AStatusGtin) Then
  Begin
    pSetaClientStatusDoProduto('SUC');
  End;

  If fStatusDoProdutoSucessoInativo(AResponseCode, AStatusGtin) Then
  Begin
    pSetaClientStatusDoProduto('INA');
  End;

  If (AResponseCode = '400') Then
  Begin
    pSetaClientStatusDoProduto('INC');
  End;
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.STATUSCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.Value = 'SUC' Then
  Begin
    ACanvas.Font.Color  := clGreen;
    ACanvas.Brush.Color := clGreen;
  End
  Else If AViewInfo.Value = 'INC' Then
  Begin
    ACanvas.Font.Color  := clRed;
    ACanvas.Brush.Color := clRed;
  End
  Else If AViewInfo.Value = 'INA' Then
  Begin
    ACanvas.Font.Color  := clYellow;
    ACanvas.Brush.Color := clYellow;
  End
  Else
  Begin
    ACanvas.Font.Color  := clWhite;
    ACanvas.Brush.Color := clWhite;
  End
end;

procedure TfrmGerarGTINAtualizarCadastroGS1CNP.pProcessaEmbalagens;
begin
  Try
    cdsProdutos.DisableControls;

    prbProgresso.Position := 0;
    prbProgresso.Max := cdsProdutos.RecordCount;
    prbProgresso.Visible := True;
    Application.ProcessMessages;

    cdsProdutos.First;
    While Not cdsProdutos.Eof Do
    Begin
      pAdicionarEmbalagensProdutos;
      cdsProdutos.Next;
      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;
  Finally
    prbProgresso.Visible := False;
    cdsProdutos.First;
    cdsProdutos.EnableControls;
  End;
end;

end.
