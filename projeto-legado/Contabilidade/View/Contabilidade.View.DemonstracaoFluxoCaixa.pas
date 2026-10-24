unit Contabilidade.View.DemonstracaoFluxoCaixa; 

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxPC, Data.DB, MemDS, DBAccess, Uni, Datasnap.DBClient,
  UniClientDataSet, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxGroupBox, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxSpinEdit,
  cxButtonEdit, cxButtons, untTypesSistema, cxLabel, EditFocus, cxCheckBox,
  cxGridBandedTableView, cxGridDBBandedTableView, cxCalc, cxProgressBar,
  frxExportPDF, frxDBSet, System.Generics.Collections, Contabilidade.Interfaces;

const
  TITULO_RELATORIO = 'DFC - Demonstração do Fluxo de Caixa' ;

type
  TfrmDemonstracaoFluxoCaixa = class(TfrmPaiContabilidade)
    ControlePaginas: TcxPageControl;
    tsParametros: TcxTabSheet;
    tsGeracao: TcxTabSheet;
    gbExercicio: TcxGroupBox;
    gbBotoes: TcxGroupBox;
    GridParametrosView: TcxGridDBTableViewCitel;
    GridParametrosLevel: TcxGridLevel;
    GridParametros: TcxGridCitel;
    dsParametros: TDataSource;
    GridParametrosViewAUTOINCREM: TcxGridDBColumn;
    GridParametrosViewDFC_EXERCI: TcxGridDBColumn;
    GridParametrosViewDFC_DESCRI: TcxGridDBColumn;
    GridParametrosViewDFC_NIVEL_: TcxGridDBColumn;
    GridParametrosViewDFC_ORDEM_: TcxGridDBColumn;
    GridParametrosViewDFC_EDITAV: TcxGridDBColumn;
    GridParametrosViewDFC_NEGRIT: TcxGridDBColumn;
    GridParametrosViewCNT_BTN: TcxGridDBColumn;
    mnuIncluir: TPopupMenu;
    Incluirde1: TMenuItem;
    btnIncluir: TcxButton;
    btnGravar: TcxButton;
    btnAlterar: TcxButton;
    btnExcluir: TcxButton;
    btnCancela: TcxButton;
    btnPesquisa: TcxButton;
    Incluir1: TMenuItem;
    GridParametrosViewDFC_CONTAS: TcxGridDBColumn;
    StyleRepository: TcxStyleRepository;
    EstiloNegrito: TcxStyle;
    edtExercicio: TcxSpinEdit;
    gbGeracao: TcxGroupBox;
    cxLabel1: TcxLabel;
    cbAnoExercicio: TcxComboBox;
    cxLabel2: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    edtNumeroLivro: TcxSpinEdit;
    edtNumeroPaginaInicial: TcxSpinEdit;
    chkImprimirAssinatura: TcxCheckBox;
    chkImprimirParaArquivo: TcxCheckBox;
    GridGeracaoLevel: TcxGridLevel;
    GridGeracao: TcxGridCitel;
    GridGeracaoView: TcxGridDBBandedTableView;
    GridGeracaoViewDescricao: TcxGridDBBandedColumn;
    GridGeracaoViewDFC: TcxGridDBBandedColumn;
    GridGeracaoViewExercicio: TcxGridDBBandedColumn;
    GridGeracaoViewExercicioAnterior: TcxGridDBBandedColumn;
    btnGerarDados: TcxButton;
    btnImprimir: TcxButton;
    gbBotoesGerar: TcxGroupBox;
    btnFecharGeracao: TcxButton;
    dsGerar: TDataSource;
    GridGeracaoViewDFC_CONTAS: TcxGridDBBandedColumn;
    GridGeracaoViewDFC_NEGRIT: TcxGridDBBandedColumn;
    cdsDadosRelatorio: TUniClientDataSet;
    cdsDadosRelatorioDESCRI: TStringField;
    cdsDadosRelatorioEXERCI: TStringField;
    cdsDadosRelatorioEXEANT: TStringField;
    cdsDadosRelatorioCONTAS: TStringField;
    cdsDadosRelatorioNEGRIT: TStringField;
    frxRelatorio: TfrxReport;
    frxDBRelatorio: TfrxDBDataset;
    frxPDFExport: TfrxPDFExport;
    lbResponsavelEmpresa: TcxLabel;
    lbResponsavelContador: TcxLabel;
    cbResponsavelEmpresa: TcxComboBox;
    cbResponsavelContador: TcxComboBox;
    cdsDadosRelatorioVALOR_: TStringField;
    cxLabel5: TcxLabel;
    edtEmpSel01: TEditFocus;
    edtNomEmpSel01: TEditFocus;
    cxLabel6: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure Incluir1Click(Sender: TObject);
    procedure GridParametrosViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridParametrosViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure GridParametrosViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure GridParametrosViewCNT_BTNPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure GridParametrosViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure ControlePaginasPageChanging(Sender: TObject; NewPage: TcxTabSheet;
      var AllowChange: Boolean);
    procedure Incluirde1Click(Sender: TObject);
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarDadosClick(Sender: TObject);
    procedure btnFecharGeracaoClick(Sender: TObject);
    procedure GridGeracaoViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GridGeracaoViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure GridGeracaoViewExercicioAnteriorPropertiesEditValueChanged(
      Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure chkImprimirAssinaturaPropertiesEditValueChanged(Sender: TObject);
    procedure chkImprimirParaArquivoPropertiesEditValueChanged(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtEmpSel01KeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpSelExit(Sender: TObject);
  private
    { Private declarations }
    FListResponsavelContador: TObjectList<TInfoResponsavelContador> ;
    FListResponsavelEmpresa: TObjectList<TInfoResponsavelEmpresa> ;
    FModoInsert: boolean;
    cdsParametros: TUniClientDataSet;
    cdsParametrosContas: TUniClientDataSet;
    arrEmpSel: TConsultasArray;
    cdsGerar: TUniClientDataSet;
    procedure pCarregaDadosParametros(const AExercicio: integer; const ACodEmp: String);
    procedure pInclusaoParametros;
    procedure pInclusaoParametrosContas(const AArrSel: TConsultasArray; const AAutoIncParametros: string);
    function fGravarParametros:boolean;
    function fDeletarParametros:boolean;
    procedure pReplicaExercicio(const AExercicio: integer; const ACodEmp: String);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pBotoesParametros(const AHabilitar:boolean);
    procedure pBotoesGerar(const AHabilitar:boolean);
    function fExercicioCadastrado(const AExercicio: integer; const ACodEmp: String):boolean;
    procedure pOcorrenciaContas(const AAutoIncParametros: string='');
    function fEmEdicao:boolean ;
    function fEmEdicaoGeracao:boolean ;
    function fListaExercicios(const ACodEmp: String):TStringList ;
    function fIncluirDe(const AExercicio: integer; const ACodEmp: String):boolean ;
    procedure pCarregaAnoExercicio(const ACodEmp: String) ;
    function fEmpresasArrToList:TStringList ;
    procedure pAjustaLabelGridGerar(const ALimpar: boolean=False) ;
    procedure pCalcularTotalGerar ;
    function fGravarSaldoDFC(const AExercicio: integer):boolean ;
    function fGerarDados(pgbProgresso: TcxProgressBar):boolean ;
    function fIsAssignedProgresso(pgbProgresso: TcxProgressBar): boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
      strTexto: String);
    function fValidaImpressao: boolean;
    procedure pCarregaDadosRelatorio;
    procedure pShowComboResponsavel(const AAssinatura, AArquivo: Boolean);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, Contabilidade.Classes.TDemonstracaoFluxoCaixa,
  Contabilidade.Consultas, untConsultas,
  Contabilidade.View.DemonstracaoFluxoCaixaContasContabeis,
  Contabilidade.View.IncluirDeExercicio, untFuncoesConsulta,
  Contabilidade.Funcoes;

{$R *.dfm}

const
  MENSAGEM_PESQUISA_CONTAS = 'Tecle / para adicionar contas contábeis!' ;

procedure TfrmDemonstracaoFluxoCaixa.btnAlterarClick(Sender: TObject);
begin
  inherited;

  if cdsParametros.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  pBotoesParametros(False) ;
end;

procedure TfrmDemonstracaoFluxoCaixa.btnCancelaClick(Sender: TObject);
begin
  inherited;
  FModoInsert := False ;
  pCarregaDadosParametros(edtExercicio.Value, edtEmpSel01.Text) ;
  pBotoesParametros(True) ;
end;

procedure TfrmDemonstracaoFluxoCaixa.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if cdsParametros.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  if fMensagem('ATENÇÃO!', 'Confirma a exclusão dos parametros do exercício '+
                cdsParametros.FieldByName('DFC_EXERCI').AsString+'? ', ['&Sim', '&Não'], 1) = 2 then
  begin
    Exit;
  end;

  if not fDeletarParametros then
  begin
    exit ;
  end;

  pCarregaDadosParametros(-1, edtEmpSel01.Text) ;

end;

procedure TfrmDemonstracaoFluxoCaixa.btnFecharGeracaoClick(Sender: TObject);
var
  intExercicio : integer ;
begin
  inherited;
  intExercicio := strtoint(cbAnoExercicio.Text) ;
  if not fGravarSaldoDFC(intExercicio) then
  begin
    exit ;
  end;
  pGravaConfRelRol(self.Name, arrEmpSel, edtNumeroLivro.Value, edtNumeroPaginaInicial.Value) ;
  cdsGerar.EmptyDataSet ;
  pAjustaLabelGridGerar(True) ;
  pBotoesGerar(True) ;
end;

procedure TfrmDemonstracaoFluxoCaixa.btnGerarDadosClick(Sender: TObject);
begin
  inherited;
  ///valida as informações
  if cbAnoExercicio.ItemIndex < 0 then
  begin
    fMensagem('ATENÇÃO!', 'Ano exercício não informado!' , ['&Ok']);
    pSetFocus(cbAnoExercicio);
    exit ;
  end;

  fValidaCampos(edtEmpSel) ;

  Try
    fChamaTelaGravando(fGerarDados) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;

end;

procedure TfrmDemonstracaoFluxoCaixa.btnGravarClick(Sender: TObject);
begin
  inherited;

  if edtExercicio.Value = 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não informado!' , ['&Ok']);
    pSetFocus(edtExercicio);
    exit ;
  end;

  if fEmptyStr(edtEmpSel01.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Empresa não informada!' , ['&Ok']);
    pSetFocus(edtEmpSel01);
    exit ;
  end;

  If not fValidaCampos(edtEmpSel01) Then
    Exit ;

  pReplicaExercicio(edtExercicio.Value, edtEmpSel01.Text);

  if fExercicioCadastrado(edtExercicio.Value, edtEmpSel01.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Exercício '+inttostr(edtExercicio.Value)+' já cadastrado!' , ['&Ok']);
    pSetFocus(edtExercicio);
    exit ;
  end;

  if not fGravarParametros then
  begin
    exit ;
  end;
  FModoInsert := False ;
  pBotoesParametros(True) ;
end;

procedure TfrmDemonstracaoFluxoCaixa.btnImprimirClick(Sender: TObject);
var
  LInfoResponsavelEmpresa: TInfoResponsavelEmpresa ;
  LInfoResponsavelContador: TInfoResponsavelContador ;
begin
  inherited;

  ///valida as informações selecionadas
  if not fValidaImpressao then
  begin
    exit ;
  end;

  pCarregaDadosRelatorio ;

  LInfoResponsavelEmpresa := Nil ;
  LInfoResponsavelContador := Nil ;
  if cbResponsavelEmpresa.ItemIndex <> -1 then
  begin
    LInfoResponsavelEmpresa := TInfoResponsavelEmpresa(cbResponsavelEmpresa.Properties.Items.Objects[cbResponsavelEmpresa.ItemIndex]) ;
  end;
  if cbResponsavelContador.ItemIndex <> -1 then
  begin
    LInfoResponsavelContador := TInfoResponsavelContador(cbResponsavelContador.Properties.Items.Objects[cbResponsavelContador.ItemIndex]) ;
  end;

  pPreparaRelatorio(strToInt(cbAnoExercicio.Text),
                    arrEmpSel,
                    chkImprimirAssinatura.Checked,
                    chkImprimirParaArquivo.Checked,
                    edtNumeroPaginaInicial.Value,
                    edtNumeroLivro.Value,
                    LInfoResponsavelEmpresa,
                    LInfoResponsavelContador,
                    TITULO_RELATORIO,
                    frxRelatorio);

  pExibirRelatorio(Self.Name, TITULO_RELATORIO, frxRelatorio);
end;

procedure TfrmDemonstracaoFluxoCaixa.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrPesq: TConsultasArray;
  LExercicio: Integer ;
  LCodEmp: String ;
  LRetornoPesquisa: String ;
begin
  chrKey := '/';
  If fPesqDemonstracaoFluxoCaixa(Self, Nil, Nil, Nil, chrKey, arrPesq, False) Then
  begin
    if Length(arrPesq) > 0 then
    begin
      LRetornoPesquisa := arrPesq[0].strCodigo ;
      pTrataExercicioCodEmp(LRetornoPesquisa, LExercicio, LCodEmp) ;
      pCarregaDadosParametros(LExercicio, LCodEmp) ;
      pSetFocus(btnAlterar);
    end;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.chkImprimirAssinaturaPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pShowComboResponsavel(TcxCheckBox(Sender).Checked, chkImprimirParaArquivo.Checked) ;
end;

procedure TfrmDemonstracaoFluxoCaixa.chkImprimirParaArquivoPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pShowComboResponsavel(chkImprimirAssinatura.Checked, TcxCheckBox(Sender).Checked) ;
end;

procedure TfrmDemonstracaoFluxoCaixa.ControlePaginasPageChanging(
  Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
var
  LLivro, LPagina: integer ;
begin
  inherited;
  if fEmEdicao then
  begin
    fMensagem('ATENÇÃO!', 'Gravar as alterações dos parâmetros, antes de mudar de página!' , ['&Ok']);
    AllowChange := false ;
    exit ;
  end;
  if NewPage = tsGeracao then
  begin
    pCarregaConfRelRol(self.Name, arrEmpSel, LLivro, LPagina) ;
    edtNumeroLivro.Value := LLivro ;
    edtNumeroPaginaInicial.Value := LPagina ;
    pSetFocus(cbAnoExercicio);
  end;
  if fEmEdicaoGeracao then
  begin
    fMensagem('ATENÇÃO!', 'Fechar o DFC, antes de mudar de página!' , ['&Ok']);
    AllowChange := false ;
    exit ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.edtEmpSel01KeyPress(Sender: TObject;
  var Key: Char);
var
  LEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel01, edtNomEmpSel01, Nil, Key, LEmpSel, True) Then
  Begin
    If fValidaCampos(edtEmpSel01) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDemonstracaoFluxoCaixa.edtEmpSelExit(Sender: TObject);
begin
  inherited;
  pCarregaAnoExercicio(TEditFocus(Sender).Text) ;
end;

procedure TfrmDemonstracaoFluxoCaixa.edtEmpSelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, arrEmpSel, True) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDemonstracaoFluxoCaixa.fDeletarParametros: boolean;
begin
  result := TDemonstracaoFluxoCaixaParametros.Deletar(cdsParametros.FieldByName('DFC_EXERCI').AsInteger,
                                                      cdsParametros.FieldByName('DFC_CODEMP').AsString) ;
end;

function TfrmDemonstracaoFluxoCaixa.fEmEdicao: boolean;
begin
  result := btnGravar.Enabled ;
end;

function TfrmDemonstracaoFluxoCaixa.fEmEdicaoGeracao: boolean;
begin
  result := btnFecharGeracao.Enabled ;
end;

function TfrmDemonstracaoFluxoCaixa.fEmpresasArrToList: TStringList;
var
  intCnt : integer ;
begin
  result := TStringList.Create ;
  if Length(arrEmpSel) = 0 then
  begin
    if not fEmptyStr(edtEmpSel.Text) then
    begin
      SetLength(arrEmpSel, 0);
      SetLength(arrEmpSel, 1);
      arrEmpSel[0].strCodigo := edtEmpSel.Text ;
      result.Add(arrEmpSel[0].strCodigo) ;
    end;
  end
  else
  begin
    for intCnt := Low(arrEmpSel) to High(arrEmpSel) do
    begin
      result.Add(arrEmpSel[intCnt].strCodigo) ;
    end;
  end;
end;

function TfrmDemonstracaoFluxoCaixa.fExercicioCadastrado(
  const AExercicio: integer; const ACodEmp: String): boolean;
begin
  result := TDemonstracaoFluxoCaixaExercicio.VerificarExistente(AExercicio, ACodEmp, FModoInsert);
end;

function TfrmDemonstracaoFluxoCaixa.fGerarDados(
  pgbProgresso: TcxProgressBar): boolean;
var
  objGerar : TDemonstracaoFluxoCaixaGerar  ;
  lstEmpresas : TStringList ;
begin
  Result := True;
  pgbProgresso.Properties.Max := 1 ;
  pSetaTextoProgresso(pgbProgresso, 'Gerando' + ' Lançamentos: DFC ' + cbAnoExercicio.Text);

  dsGerar.Enabled := False ;
  dsGerar.DataSet := Nil ;
  if Assigned(cdsGerar) then
  begin
    FreeAndNil(cdsGerar) ;
  end;


  lstEmpresas := fEmpresasArrToList ;
  objGerar := TDemonstracaoFluxoCaixaGerar.Create  ;
  try
    objGerar.AnoExercicio := strtoint(cbAnoExercicio.Text) ;
    objGerar.Empresas.Assign(lstEmpresas);
    cdsGerar := objGerar.Processar ;
    if not Assigned(cdsGerar) then
    begin
      exit ;
    end;

    dsGerar.DataSet := cdsGerar ;
    dsGerar.Enabled := True ;

    pAjustaLabelGridGerar ;

    pgbProgresso.Position := 1;
    Application.ProcessMessages;

  finally
    FreeAndNil(objGerar) ;
    FreeAndNil(lstEmpresas) ;
  end;
  pBotoesGerar(False) ;

end;

function TfrmDemonstracaoFluxoCaixa.fGravarParametros: boolean;
begin
  result := TDemonstracaoFluxoCaixaParametros.Gravar(edtExercicio.Value, edtEmpSel01.Text, cdsParametros, cdsParametrosContas, FModoInsert) ;
end;

function TfrmDemonstracaoFluxoCaixa.fGravarSaldoDFC(
  const AExercicio: integer): boolean;
var
  LLstEmpresas: TStringList ;
  LValorSaldo: double ;
begin
  LValorSaldo := 0.00 ;
  ////recupera o saldo da Grid
  if cdsGerar.Locate('DFC_ORDEM_', LINHA_SALDO_FINAL_CAIXA, []) then
  begin
    LValorSaldo := cdsGerar.FieldByName('DFC_VALOR_').AsFloat ;
  end;

  LLstEmpresas := fEmpresasArrToList ;
  try
    TDemonstracaoFluxoCaixaGerar.GravarSaldoExercicio(AExercicio, LLstEmpresas, LValorSaldo) ;
  finally
    FreeAndNil(LLstEmpresas) ;
  end;
  result := True ;
end;

function TfrmDemonstracaoFluxoCaixa.fIncluirDe(
  const AExercicio: integer; const ACodEmp: String): boolean;
var
  qryDfc : TUniquery ;
  cdsCon : TUniClientDataSet ;
  strIdent : string ;
begin
  ////busca os dados do exercicio a ser copiado
  qryDfc := fCriaQuery() ;
  try
    TDemonstracaoFluxoCaixaParametros.IncluirDe(AExercicio, ACodEmp, qryDfc, cdsCon) ;

    cdsParametros.DisableControls ;
    cdsParametrosContas.DisableControls ;
    try
      cdsParametros.EmptyDataSet;
      cdsParametrosContas.EmptyDataSet;
      while not qryDfc.Eof do
      begin
        cdsParametros.Append ;
        cdsParametros.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PARDFC',Vs_strCodEmp) ;
        cdsParametros.FieldByName('DFC_NIVEL_').AsString := qryDfc.FieldByName('DFC_NIVEL_').AsString ;
        cdsParametros.FieldByName('DFC_ORDEM_').AsString := qryDfc.FieldByName('DFC_ORDEM_').AsString ;
        cdsParametros.FieldByName('DFC_EDITAV').AsString := qryDfc.FieldByName('DFC_EDITAV').AsString ;
        cdsParametros.FieldByName('DFC_NEGRIT').AsString := qryDfc.FieldByName('DFC_NEGRIT').AsString ;
        cdsParametros.FieldByName('DFC_CONTAS').AsString := qryDfc.FieldByName('DFC_CONTAS').AsString ;
        cdsParametros.FieldByName('DFC_EXERCI').AsString := qryDfc.FieldByName('DFC_EXERCI').AsString ;
        cdsParametros.FieldByName('DFC_CODEMP').AsString := qryDfc.FieldByName('DFC_CODEMP').AsString ;
        strIdent := fReplicatorStr(' ',qryDfc.FieldByName('DFC_NIVEL_').AsInteger*3) ;
        cdsParametros.FieldByName('DFC_DESCRI').AsString := strIdent + qryDfc.FieldByName('DFC_DESCRI').AsString ;
        cdsParametros.Post ;
        ////adiciona as contas
        if cdsCon.FindKey([qryDfc.FieldByName('AUTOINCREM').AsString]) then
        begin
          while (cdsCon.FieldByName('DFC_SEQLAN').AsString = qryDfc.FieldByName('AUTOINCREM').AsString) and (not cdsCon.Eof) do
          begin

            cdsParametrosContas.Append ;
            cdsParametrosContas.FieldByName('DFC_SEQLAN').AsString := cdsParametros.FieldByName('AUTOINCREM').AsString ;
            cdsParametrosContas.FieldByName('DFC_CODCON').AsString := cdsCon.FieldByName('DFC_CODCON').AsString ;
            cdsParametrosContas.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [cdsCon.FieldByName('DFC_CODCON').AsString], False);
            cdsParametrosContas.Post ;

            cdsCon.Next;
          end;
        end;
        qryDfc.Next;
      end;
      cdsParametros.First ;
    finally
      cdsParametros.EnableControls ;
      cdsParametrosContas.EnableControls ;
    end;

  finally
    FreeAndNil(qryDfc) ;
    FreeAndNil(cdsCon) ;
  end;
  result := true ;
end;

function TfrmDemonstracaoFluxoCaixa.fListaExercicios(const ACodEmp: String): TStringList;
begin
  result := TDemonstracaoFluxoCaixaExercicio.Listar(ACodEmp) ;
end;

procedure TfrmDemonstracaoFluxoCaixa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if fEmEdicao then
  begin
    fMensagem('ATENÇÃO!', 'Gravar as alterações dos parâmetros, antes de fechar o módulo!' , ['&Ok']);
    CanClose := False ;
    exit ;
  end;

  if fEmEdicaoGeracao then
  begin
    fMensagem('ATENÇÃO!', 'Fechar o DFC, antes de fechar o módulo!' , ['&Ok']);
    CanClose := False ;
    exit ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  FListResponsavelContador := TObjectList<TInfoResponsavelContador>.Create() ;
  FListResponsavelEmpresa := TObjectList<TInfoResponsavelEmpresa>.Create() ;
  pCarregaResponsavel(FListResponsavelContador, FListResponsavelEmpresa) ;
  cdsDadosRelatorio.CreateDataSet ;
  cdsDadosRelatorio.Open ;
  FModoInsert := False ;
end;

procedure TfrmDemonstracaoFluxoCaixa.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FListResponsavelContador) ;
  FreeAndNil(FListResponsavelEmpresa) ;
end;

procedure TfrmDemonstracaoFluxoCaixa.FormShow(Sender: TObject);
begin
  inherited;
  pBotoesParametros(True) ;
  pBotoesGerar(True) ;
  pCarregaDadosParametros(-1, edtEmpSel01.Text) ;
  pCarregaResponsavelComboBoxAdministrador(FListResponsavelEmpresa, cbResponsavelEmpresa) ;
  pCarregaResponsavelComboBoxContador(FListResponsavelContador, cbResponsavelContador) ;
  ControlePaginas.ActivePageIndex := 0 ;
end;

function TfrmDemonstracaoFluxoCaixa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  intIndex : integer ;
  LLivro, LPagina : integer ;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtEmpSel) Then
    Begin
      if fEmptyStr(edtEmpSel.Text) then
      begin
        SetLength(arrEmpSel,0) ;
        edtNomEmpSel.Clear;
        Result := True;
      end
      else
      Begin
        edtNomEmpSel.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text], False);
        If (fEmptyStr(edtNomEmpSel.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        end
        else
        begin
          pDesmarcaLista(edtEmpSel, arrEmpSel);

          If Length(arrEmpSel) > 0 Then
          Begin
            For intIndex := Low(arrEmpSel) To High(arrEmpSel) Do
            Begin
              If Pos(arrEmpSel[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
              Begin
                edtNomEmpSel.Clear;
                fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrEmpSel[intIndex].strCodigo + '!', ['&O k']);
                Result := False;
                Break;
              End;
            End;
          End
          Else If Not fEmptyStr(edtEmpSel.Text) Then
          Begin
            If Pos(edtEmpSel.Text, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              edtNomEmpSel.Clear;
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
              Result := False;
            End;
            pCarregaConfRelRol(self.Name, arrEmpSel, LLivro, LPagina) ;
            edtNumeroLivro.Value := LLivro ;
            edtNumeroPaginaInicial.Value := LPagina ;
          End;
        End;
      End;
    End
    else If (Sender = edtEmpSel01) Then
    begin
      if not fEmptyStr(edtEmpSel01.Text) then
      Begin
        edtNomEmpSel01.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel01.Text], False);
        if fEmptyStr(edtNomEmpSel01.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtNomEmpSel01.Clear;
        edtEmpSel01.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End ;
    end;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDemonstracaoFluxoCaixa.GridGeracaoViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;

  if GridGeracaoViewDFC_CONTAS.DataBinding.Field.AsString <> '1'  then
  begin
    AAllow := false ;
    exit ;
  end;

  if AItem = GridGeracaoViewDescricao then
  begin
    AAllow := False ;
    Exit ;
  end;

  if AItem = GridGeracaoViewDFC then
  begin
    AAllow := False ;
    Exit ;
  end;

  if btnFecharGeracao.Enabled then
  begin
    AAllow := False ;
    Exit ;
  end;

end;

procedure TfrmDemonstracaoFluxoCaixa.GridGeracaoViewExercicioAnteriorPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  GridGeracaoView.DataController.PostEditingData ;
  pCalcularTotalGerar ;
end;

procedure TfrmDemonstracaoFluxoCaixa.GridGeracaoViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  ARowInfo: TcxRowInfo;
begin
  inherited;
  If ARecord.IsData Then
  begin
    if ARecord.Index > -1 then
    begin
      ARowInfo := GridGeracaoView.DataController.GetRowInfo(ARecord.Index);
      If VarToStr(GridGeracaoView.DataController.Values[ARowInfo.RecordIndex,
                         GridGeracaoViewDFC_NEGRIT.Index]) = '1' Then
      Begin
        AStyle := EstiloNegrito;
      End;
    end;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.GridParametrosViewCNT_BTNPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmDemonstracaoFluxoCaixaContasContabeis : TfrmDemonstracaoFluxoCaixaContasContabeis ;
  cdsTemp : TUniClientDataSet ;
begin
  inherited;
  pCriarFormularios(TfrmDemonstracaoFluxoCaixaContasContabeis, frmDemonstracaoFluxoCaixaContasContabeis);
  cdsTemp := TUniClientDataSet.Create(Self);
  try
    pCloneDataSet(cdsTemp, cdsParametrosContas);

    cdsParametrosContas.Filter := 'DFC_SEQLAN = '+quotedstr(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
    cdsParametrosContas.Filtered := True ;
    frmDemonstracaoFluxoCaixaContasContabeis.StrAutoIncParametros := cdsParametros.FieldByName('AUTOINCREM').AsString ;
    frmDemonstracaoFluxoCaixaContasContabeis.dsPlanco.DataSet := cdsParametrosContas ;
    frmDemonstracaoFluxoCaixaContasContabeis.blnModoEdicao := fEmEdicao ;
    frmDemonstracaoFluxoCaixaContasContabeis.ShowModal ;
    if frmDemonstracaoFluxoCaixaContasContabeis.ModalResult = idOK then
    begin
      pOcorrenciaContas(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
    end
    else
    begin
      cdsParametrosContas.Close ;
      cdsParametrosContas.Open ;
      cdsParametrosContas.Data := cdsTemp.Data ;
    end;
  finally
    FreeAndNil(cdsTemp) ;
    pFreeAndNil(frmDemonstracaoFluxoCaixaContasContabeis) ;
    cdsParametrosContas.Filtered := False ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.GridParametrosViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if AItem = GridParametrosViewDFC_DESCRI then
  begin
    AAllow := GridParametrosViewDFC_EDITAV.DataBinding.Field.AsString = '1' ;
    exit ;
  end;
  if AItem = GridParametrosViewCNT_BTN then
  begin
    AAllow := GridParametrosViewDFC_CONTAS.DataBinding.Field.AsString = '1' ;
    exit ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.GridParametrosViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  if AItem = GridParametrosViewCNT_BTN then
  begin

    if not fEmEdicao then
    begin
      key := #0 ;
      fMensagem('ATENÇÃO!', 'Coloque em modo de edição!' , ['&Ok']);
      exit ;
    end;

    if key = '/' then
    begin
      If Contabilidade.Consultas.fPesqPlanoContabil(Self, Nil, Nil, Nil, Key, arrSel, False, '', True, True) Then
      Begin
        key := #0 ;
        pInclusaoParametrosContas(arrSel, cdsParametros.FieldByName('AUTOINCREM').AsString) ;
        pOcorrenciaContas(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
      End;
    end
    else
    begin
      key := #0 ;
    end;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.GridParametrosViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  if AFocusedItem = GridParametrosViewCNT_BTN then
  begin
    if GridParametrosViewDFC_CONTAS.DataBinding.Field.AsString = '1' then
    begin
      pnlInfo.Caption := MENSAGEM_PESQUISA_CONTAS ;
    end
    else
    begin
      pnlInfo.Caption := '' ;
    end;
  end
  else
  begin
    pnlInfo.Caption := '' ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.GridParametrosViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  ARowInfo: TcxRowInfo;
begin
  inherited;
  If ARecord.IsData Then
  begin
    if ARecord.Index > -1 then
    begin
      ARowInfo := GridParametrosView.DataController.GetRowInfo(ARecord.Index);
      If VarToStr(GridParametrosView.DataController.Values[ARowInfo.RecordIndex,
                         GridParametrosViewDFC_NEGRIT.Index]) = '1' Then
      Begin
        AStyle := EstiloNegrito;
      End;
    end;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.Incluir1Click(Sender: TObject);
begin
  inherited;
  FModoInsert := True ;
  pInclusaoParametros ;
  pBotoesParametros(False) ;
  pSetFocus(edtExercicio) ;
end;

procedure TfrmDemonstracaoFluxoCaixa.Incluirde1Click(Sender: TObject);
var
  frmIncluirDeExercicio : TfrmIncluirDeExercicio ;
  LExercicio : integer ;
  LCodEmp : String ;
begin
  inherited;
  pCriarFormularios(TfrmIncluirDeExercicio, frmIncluirDeExercicio);
  try
    frmIncluirDeExercicio.funcListarExercicio := fListaExercicios ;
    frmIncluirDeExercicio.ShowModal ;
    if frmIncluirDeExercicio.Confirmado then
    begin
      LExercicio := frmIncluirDeExercicio.Exercicio ;
      LCodEmp := frmIncluirDeExercicio.CodEmpresa ;

      if fIncluirDe(LExercicio, LCodEmp) then
      begin
        FModoInsert := True ;
        pBotoesParametros(False) ;
        edtExercicio.Value := 0 ;
        pOcorrenciaContas ;
        edtEmpSel01.Text := LCodEmp ;
        fValidaCampos(edtEmpSel01) ;
        pSetFocus(edtExercicio) ;
      end;
    end;
  finally
    pFreeAndNil(frmIncluirDeExercicio) ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.pAfterScroll(DataSet: TDataSet);
begin
  if DataSet.FieldByName('DFC_CONTAS').AsString = '1' then
  begin
    pnlInfo.Caption := MENSAGEM_PESQUISA_CONTAS ;
  end
  else
  begin
    pnlInfo.Caption := '' ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.pAjustaLabelGridGerar(
  const ALimpar: boolean);
var
  strExercicio, strExercicioAnterior: string ;
begin
  pInfoAnoExercicio(ALimpar, strExercicio, strExercicioAnterior, strToInt(cbAnoExercicio.Text)) ;
  GridGeracaoViewExercicio.Caption := strExercicio ;
  GridGeracaoViewExercicioAnterior.Caption := strExercicioAnterior ;
end;

procedure TfrmDemonstracaoFluxoCaixa.pBotoesGerar(const AHabilitar: boolean);
begin
  btnGerarDados.Enabled := AHabilitar ;
  btnImprimir.Enabled := not AHabilitar ;
  btnFecharGeracao.Enabled := not AHabilitar ;
  /////
  cbAnoExercicio.Enabled := AHabilitar ;
  edtEmpSel.Enabled := AHabilitar ;
end;

procedure TfrmDemonstracaoFluxoCaixa.pBotoesParametros(
  const AHabilitar: boolean);
begin
  btnIncluir.Enabled  :=  AHabilitar ;
  btnGravar.Enabled   :=  not AHabilitar ;
  btnAlterar.Enabled  :=  AHabilitar ;
  btnExcluir.Enabled  :=  AHabilitar ;
  btnCancela.Enabled  :=  not AHabilitar ;
  btnPesquisa.Enabled :=  AHabilitar ;
  /////
  TcxTextEditProperties(GridParametrosViewDFC_DESCRI.Properties).ReadOnly := not fEmEdicao ;
  TcxButtonEditProperties(GridParametrosViewCNT_BTN.Properties).ReadOnly := not fEmEdicao ;
  ////no modo de alteração não é possivel alterar o exercicio, somente em inclusão.
  edtExercicio.Enabled := FModoInsert ;
  edtEmpSel01.Enabled := FModoInsert ;
  edtNomEmpSel01.Enabled := FModoInsert ;
end;

procedure TfrmDemonstracaoFluxoCaixa.pCalcularTotalGerar;
var
  iExercicio: integer ;
  lstEmpresas: TStringList ;
begin
  lstEmpresas := fEmpresasArrToList ;
  iExercicio := strtoint(cbAnoExercicio.Text) ;
  try
    TDemonstracaoFluxoCaixaGerar.CalcularTotais(iExercicio, lstEmpresas, cdsGerar);
  finally
    FreeAndNil(lstEmpresas);
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.pCarregaAnoExercicio(const ACodEmp: String);
var
  lst : TStringList ;
begin
  lst := fListaExercicios(ACodEmp) ;
  try
    cbAnoExercicio.Properties.Items.Assign(lst);
  finally
    FreeAndNil(lst) ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.pCarregaDadosParametros(
  const AExercicio: integer; const ACodEmp: String);
begin

  dsParametros.Enabled := False ;
  dsParametros.DataSet := Nil ;

  TDemonstracaoFluxoCaixaParametros.Carregar(AExercicio, ACodEmp, cdsParametros, cdsParametrosContas) ;

  cdsParametros.AfterScroll := pAfterScroll;

  pOcorrenciaContas ;

  if not cdsParametros.IsEmpty then
  begin
    edtExercicio.Value := cdsParametros.FieldByName('DFC_EXERCI').AsInteger ;
    edtEmpSel01.Text := cdsParametros.FieldByName('DFC_CODEMP').AsString ;
    fValidaCampos(edtEmpSel01) ;
  end
  else
  begin
    edtExercicio.Clear ;
    edtEmpSel01.Clear ;
  end;

  dsParametros.DataSet := cdsParametros ;
  dsParametros.Enabled := True ;

end;

procedure TfrmDemonstracaoFluxoCaixa.pInclusaoParametros;
var
  intLinhas : integer ;
  strIdent : string ;
begin
  cdsParametros.DisableControls ;
  try
    cdsParametros.EmptyDataSet;
    for intLinhas := PARAMETROS_LINHA_MIN to PARAMETROS_LINHA_MAX do
    begin
      cdsParametros.Append ;
      cdsParametros.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PARDFC',Vs_strCodEmp) ;
      cdsParametros.FieldByName('DFC_NIVEL_').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_NIVEL_] ;
      cdsParametros.FieldByName('DFC_ORDEM_').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_ORDEM_] ;
      cdsParametros.FieldByName('DFC_EDITAV').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_EDITAV] ;
      cdsParametros.FieldByName('DFC_NEGRIT').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_NEGRIT] ;
      cdsParametros.FieldByName('DFC_CONTAS').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_CONTAS] ;
      strIdent := fReplicatorStr(' ',cdsParametros.FieldByName('DFC_NIVEL_').AsInteger*3) ;
      cdsParametros.FieldByName('DFC_DESCRI').AsString := strIdent + PARAMETROS_PADRAO[intLinhas, PARAMETROS_DESCRI] ;
      cdsParametros.Post ;
    end;
    cdsParametros.First ;
  finally
    cdsParametros.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.pInclusaoParametrosContas(const AArrSel: TConsultasArray; const AAutoIncParametros: string);
var
  intCnt : integer ;
begin
  cdsParametrosContas.DisableControls ;
  try
    for intCnt := Low(AArrSel) to High(AArrSel) do
    begin
      ////evita duplicidade
      if cdsParametrosContas.FindKey([AArrSel[intCnt].strCodigo, AAutoIncParametros]) then
      begin
        continue ;
      end;
      ///
      cdsParametrosContas.Append ;
      cdsParametrosContas.FieldByName('DFC_SEQLAN').AsString := AAutoIncParametros ;
      cdsParametrosContas.FieldByName('DFC_CODCON').AsString := AArrSel[intCnt].strCodigo ;
      cdsParametrosContas.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [AArrSel[intCnt].strCodigo], False);
      cdsParametrosContas.Post ;
    end;
  finally
    cdsParametrosContas.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.pOcorrenciaContas(
  const AAutoIncParametros: string);
var
  intCount : integer ;
begin
  cdsParametros.DisableControls ;
  cdsParametrosContas.DisableControls ;
  try
    if fEmptyStr(AAutoIncParametros) then
    begin
      cdsParametros.First ;
      while not cdsParametros.Eof do
      begin
        try
          cdsParametrosContas.Filter := 'DFC_SEQLAN = '+quotedstr(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
          cdsParametrosContas.Filtered := True ;
          intCount := cdsParametrosContas.RecordCount ;
          if intCount <> 0 then
          begin
            cdsParametros.Edit ;
            cdsParametros.FieldByName('CNT_BTN').AsString := '+'+inttostr(intCount) ;
            cdsParametros.Post ;
          end;
        finally
          cdsParametrosContas.Filtered := False ;
        end;
        cdsParametros.Next ;
      end;
    end
    else
    begin
      try
        cdsParametrosContas.Filter := 'DFC_SEQLAN = '+quotedstr(AAutoIncParametros) ;
        cdsParametrosContas.Filtered := True ;
        intCount := cdsParametrosContas.RecordCount ;
        if intCount <> 0 then
        begin
          cdsParametros.Edit ;
          cdsParametros.FieldByName('CNT_BTN').AsString := '+'+inttostr(intCount) ;
          cdsParametros.Post ;
        end;
      finally
        cdsParametrosContas.Filtered := False ;
      end;
    end;
  finally
    cdsParametros.EnableControls ;
    cdsParametrosContas.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.pReplicaExercicio(const AExercicio: integer; const ACodEmp: String);
begin
  cdsParametros.DisableControls ;
  try
    cdsParametros.First ;
    while not cdsParametros.Eof do
    begin
      cdsParametros.Edit ;
      cdsParametros.FieldByName('DFC_EXERCI').AsInteger := AExercicio ;
      cdsParametros.FieldByName('DFC_CODEMP').AsString := ACodEmp ;
      cdsParametros.Post ;
      cdsParametros.Next ;
    end;
  finally
    cdsParametros.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if fIsAssignedProgresso(pgbProgresso) then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

function TfrmDemonstracaoFluxoCaixa.fIsAssignedProgresso(
  pgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(pgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

function TfrmDemonstracaoFluxoCaixa.fValidaImpressao: boolean;
begin
  result := False ;
  if (chkImprimirAssinatura.Checked) or (chkImprimirParaArquivo.Checked) then
  begin
    if cbResponsavelEmpresa.ItemIndex = -1 then
    begin
      fMensagem('ATENÇÃO!', 'Responsável empresa não selecionado!' , ['&Ok']);
      pSetFocus(cbResponsavelEmpresa);
      exit ;
    end;

    if cbResponsavelContador.ItemIndex = -1 then
    begin
      fMensagem('ATENÇÃO!', 'Responsável contador não selecionado!' , ['&Ok']);
      pSetFocus(cbResponsavelContador);
      exit ;
    end;
  end;
  result := True ;
end;

procedure TfrmDemonstracaoFluxoCaixa.pCarregaDadosRelatorio;
begin
  cdsDadosRelatorio.EmptyDataSet ;
  cdsGerar.DisableControls ;
  try
    cdsGerar.First ;
    while not cdsGerar.Eof do
    begin
      cdsDadosRelatorio.Append ;
      cdsDadosRelatorio.FieldByName('DESCRI').AsString := cdsGerar.FieldByName('DFC_DESCRI').AsString ;
      if cdsGerar.FieldByName('DFC_EXERCI').AsFloat < 0 then
      begin
        cdsDadosRelatorio.FieldByName('EXERCI').AsString := '('+FormatCurr('#,##0.00', abs(cdsGerar.FieldByName('DFC_EXERCI').AsFloat))+')' ;
      end
      else
      begin
        cdsDadosRelatorio.FieldByName('EXERCI').AsString := FormatCurr('#,##0.00', cdsGerar.FieldByName('DFC_EXERCI').AsFloat) ;
      end;
      if cdsGerar.FieldByName('DFC_EXEANT').AsFloat < 0 then
      begin
        cdsDadosRelatorio.FieldByName('EXEANT').AsString := '('+FormatCurr('#,##0.00', abs(cdsGerar.FieldByName('DFC_EXEANT').AsFloat))+')' ;
      end
      else
      begin
        cdsDadosRelatorio.FieldByName('EXEANT').AsString := FormatCurr('#,##0.00', cdsGerar.FieldByName('DFC_EXEANT').AsFloat) ;
      end;
      if cdsGerar.FieldByName('DFC_VALOR_').AsFloat < 0 then
      begin
        cdsDadosRelatorio.FieldByName('VALOR_').AsString := '('+FormatCurr('#,##0.00', abs(cdsGerar.FieldByName('DFC_VALOR_').AsFloat))+')' ;
      end
      else
      begin
        cdsDadosRelatorio.FieldByName('VALOR_').AsString := FormatCurr('#,##0.00', cdsGerar.FieldByName('DFC_VALOR_').AsFloat) ;
      end;
      if cdsGerar.FieldByName('DFC_VALOR_').IsNull then
      begin
        cdsDadosRelatorio.FieldByName('VALOR_').Clear ;
      end;

      cdsDadosRelatorio.FieldByName('CONTAS').AsString := cdsGerar.FieldByName('DFC_CONTAS').AsString ;
      cdsDadosRelatorio.FieldByName('NEGRIT').AsString := cdsGerar.FieldByName('DFC_NEGRIT').AsString ;
      cdsDadosRelatorio.Post ;
      cdsGerar.Next ;
    end;
  finally
    cdsGerar.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixa.pShowComboResponsavel(
  const AAssinatura, AArquivo: Boolean);
var
  LCondicao: boolean ;
begin
  LCondicao := AAssinatura or AArquivo ;

  lbResponsavelEmpresa.Visible := LCondicao ;
  cbResponsavelEmpresa.Visible := LCondicao ;
  lbResponsavelContador.Visible := LCondicao ;
  cbResponsavelContador.Visible := LCondicao ;
end;

end.
