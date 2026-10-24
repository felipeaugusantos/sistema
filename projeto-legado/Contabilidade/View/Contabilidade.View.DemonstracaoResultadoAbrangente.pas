unit Contabilidade.View.DemonstracaoResultadoAbrangente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxTextEdit,
  cxButtonEdit, cxCalc, cxGridBandedTableView, cxGridDBBandedTableView,
  cxCheckBox, EditFocus, cxDropDownEdit, cxLabel, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, cxButtons, cxMaskEdit, cxSpinEdit,
  cxGroupBox, cxPC, Datasnap.DBClient, UniClientDataSet, untTypesSistema, MemDS,
  DBAccess, Uni, cxProgressBar, frxExportPDF, frxDBSet, System.Generics.Collections,
  Contabilidade.Interfaces;

const
  TITULO_RELATORIO = 'DRA - Demonstração do Resultado Abrangente' ;

type
  TfrmDemonstracaoResultadoAbrangente = class(TfrmPaiContabilidade)
    dsParametros: TDataSource;
    mnuIncluir: TPopupMenu;
    Incluir1: TMenuItem;
    Incluirde1: TMenuItem;
    dsGerar: TDataSource;
    ControlePaginas: TcxPageControl;
    tsParametros: TcxTabSheet;
    gbExercicio: TcxGroupBox;
    edtExercicio: TcxSpinEdit;
    gbBotoes: TcxGroupBox;
    btnIncluir: TcxButton;
    btnGravar: TcxButton;
    btnAlterar: TcxButton;
    btnExcluir: TcxButton;
    btnCancela: TcxButton;
    btnPesquisa: TcxButton;
    GridParametros: TcxGridCitel;
    GridParametrosView: TcxGridDBTableViewCitel;
    GridParametrosViewAUTOINCREM: TcxGridDBColumn;
    GridParametrosViewDRA_EXERCI: TcxGridDBColumn;
    GridParametrosViewDRA_DESCRI: TcxGridDBColumn;
    GridParametrosViewDRA_NIVEL_: TcxGridDBColumn;
    GridParametrosViewDRA_ORDEM_: TcxGridDBColumn;
    GridParametrosViewDRA_EDITAV: TcxGridDBColumn;
    GridParametrosViewDRA_NEGRIT: TcxGridDBColumn;
    GridParametrosViewCNT_BTN: TcxGridDBColumn;
    GridParametrosViewDRA_CONTAS: TcxGridDBColumn;
    GridParametrosLevel: TcxGridLevel;
    tsGeracao: TcxTabSheet;
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
    btnGerarDados: TcxButton;
    btnImprimir: TcxButton;
    GridGeracao: TcxGridCitel;
    GridGeracaoView: TcxGridDBBandedTableView;
    GridGeracaoViewDescricao: TcxGridDBBandedColumn;
    GridGeracaoViewExercicio: TcxGridDBBandedColumn;
    GridGeracaoViewExercicioAnterior: TcxGridDBBandedColumn;
    GridGeracaoViewDRA_CONTAS: TcxGridDBBandedColumn;
    GridGeracaoViewDRA_NEGRIT: TcxGridDBBandedColumn;
    GridGeracaoLevel: TcxGridLevel;
    gbBotoesGerar: TcxGroupBox;
    btnFecharGeracao: TcxButton;
    StyleRepository: TcxStyleRepository;
    EstiloNegrito: TcxStyle;
    cdsDadosRelatorio: TUniClientDataSet;
    frxRelatorio: TfrxReport;
    frxDBRelatorio: TfrxDBDataset;
    frxPDFExport: TfrxPDFExport;
    lbResponsavelEmpresa: TcxLabel;
    lbResponsavelContador: TcxLabel;
    cbResponsavelEmpresa: TcxComboBox;
    cbResponsavelContador: TcxComboBox;
    cdsDadosRelatorioDESCRI: TStringField;
    cdsDadosRelatorioEXERCI: TStringField;
    cdsDadosRelatorioEXEANT: TStringField;
    cdsDadosRelatorioCONTAS: TStringField;
    cdsDadosRelatorioNEGRIT: TStringField;
    cxLabel5: TcxLabel;
    edtEmpSel01: TEditFocus;
    edtNomEmpSel01: TEditFocus;
    cxLabel6: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure Incluir1Click(Sender: TObject);
    procedure GridParametrosViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridParametrosViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure GridParametrosViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridParametrosViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure Incluirde1Click(Sender: TObject);
    procedure GridParametrosViewCNT_BTNPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure ControlePaginasPageChanging(Sender: TObject; NewPage: TcxTabSheet;
      var AllowChange: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarDadosClick(Sender: TObject);
    procedure GridGeracaoViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridGeracaoViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure btnFecharGeracaoClick(Sender: TObject);
    procedure GridGeracaoViewExercicioAnteriorPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure chkImprimirAssinaturaPropertiesEditValueChanged(Sender: TObject);
    procedure chkImprimirParaArquivoPropertiesEditValueChanged(Sender: TObject);
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
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pBotoesParametros(const AHabilitar:boolean);
    procedure pBotoesGerar(const AHabilitar:boolean);
    function fEmEdicao:boolean ;
    procedure pOcorrenciaContas(const AAutoIncParametros: string='');
    procedure pInclusaoParametros;
    procedure pInclusaoParametrosContas(const AArrSel: TConsultasArray; const AAutoIncParametros: string);
    function fListaExercicios(const ACodEmp: String):TStringList ;
    function fIncluirDe(const AExercicio: integer; const ACodEmp: String):boolean ;
    function fExercicioCadastrado(const AExercicio: integer; const ACodEmp: String):boolean;
    function fGravarParametros:boolean;
    function fDeletarParametros:boolean;
    procedure pReplicaExercicio(const AExercicio: integer; const ACodEmp: String);
    procedure pCarregaAnoExercicio(const ACodEmp: String) ;
    function fEmEdicaoGeracao:boolean ;
    function fGerarDados(pgbProgresso: TcxProgressBar):boolean ;
    function fIsAssignedProgresso(pgbProgresso: TcxProgressBar): boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
      strTexto: String);
    function fEmpresasArrToList:TStringList ;
    procedure pAjustaLabelGridGerar(const ALimpar: boolean=False) ;
    procedure pCalcularTotalGerar;
    function fValidaImpressao: boolean;
    procedure pCarregaDadosRelatorio;
    procedure pShowComboResponsavel(const AAssinatura, AArquivo: Boolean);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, Contabilidade.Classes.TDemonstracaoResultadoAbrangente,
  Contabilidade.Consultas, untConsultas,
  Contabilidade.View.IncluirDeExercicio, untFuncoesConsulta,
  Contabilidade.View.DemonstracaoFluxoCaixaContasContabeis,
  Contabilidade.Funcoes;

const
  MENSAGEM_PESQUISA_CONTAS = 'Tecle / para adicionar contas contábeis!' ;

procedure TfrmDemonstracaoResultadoAbrangente.btnAlterarClick(Sender: TObject);
begin
  inherited;

  if cdsParametros.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  pBotoesParametros(False) ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.btnCancelaClick(Sender: TObject);
begin
  inherited;
  FModoInsert := False ;
  pCarregaDadosParametros(edtExercicio.Value, edtEmpSel01.Text) ;
  pBotoesParametros(True) ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if cdsParametros.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  if fMensagem('ATENÇÃO!', 'Confirma a exclusão dos parametros do exercício '+
                cdsParametros.FieldByName('DRA_EXERCI').AsString+'? ', ['&Sim', '&Não'], 1) = 2 then
  begin
    Exit;
  end;

  if not fDeletarParametros then
  begin
    exit ;
  end;

  pCarregaDadosParametros(-1, edtEmpSel01.Text) ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.btnFecharGeracaoClick(
  Sender: TObject);
begin
  inherited;
  pGravaConfRelRol(self.Name, arrEmpSel, edtNumeroLivro.Value, edtNumeroPaginaInicial.Value) ;
  cdsGerar.EmptyDataSet ;
  pAjustaLabelGridGerar(True) ;
  pBotoesGerar(True) ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.btnGerarDadosClick(
  Sender: TObject);
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

procedure TfrmDemonstracaoResultadoAbrangente.btnGravarClick(Sender: TObject);
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

  pReplicaExercicio(edtExercicio.Value, edtEmpSel01.Text) ;

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

procedure TfrmDemonstracaoResultadoAbrangente.btnImprimirClick(Sender: TObject);
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

procedure TfrmDemonstracaoResultadoAbrangente.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrPesq: TConsultasArray;
  LExercicio: Integer ;
  LCodEmp: String ;
  LRetornoPesquisa: String ;
begin
  chrKey := '/';
  If fPesqDemonstracaoResultadoAbrangente(Self, Nil, Nil, Nil, chrKey, arrPesq, False) Then
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

procedure TfrmDemonstracaoResultadoAbrangente.chkImprimirAssinaturaPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pShowComboResponsavel(TcxCheckBox(Sender).Checked, chkImprimirParaArquivo.Checked) ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.chkImprimirParaArquivoPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pShowComboResponsavel(chkImprimirAssinatura.Checked, TcxCheckBox(Sender).Checked) ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.ControlePaginasPageChanging(
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
    fMensagem('ATENÇÃO!', 'Fechar o DRA, antes de mudar de página!' , ['&Ok']);
    AllowChange := false ;
    exit ;
  end;
end;

procedure TfrmDemonstracaoResultadoAbrangente.edtEmpSel01KeyPress(
  Sender: TObject; var Key: Char);
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

procedure TfrmDemonstracaoResultadoAbrangente.edtEmpSelExit(Sender: TObject);
begin
  inherited;
  pCarregaAnoExercicio(TEditFocus(Sender).Text) ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.edtEmpSelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, arrEmpSel, True) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDemonstracaoResultadoAbrangente.fDeletarParametros: boolean;
begin
  result := TDemonstracaoResultadoAbrangenteParametros.Deletar(cdsParametros.FieldByName('DRA_EXERCI').AsInteger, cdsParametros.FieldByName('DRA_CODEMP').AsString) ;
end;

function TfrmDemonstracaoResultadoAbrangente.fEmEdicao: boolean;
begin
  result := btnGravar.Enabled ;
end;

function TfrmDemonstracaoResultadoAbrangente.fEmEdicaoGeracao: boolean;
begin
  result := btnFecharGeracao.Enabled ;
end;

function TfrmDemonstracaoResultadoAbrangente.fEmpresasArrToList: TStringList;
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

function TfrmDemonstracaoResultadoAbrangente.fExercicioCadastrado(
  const AExercicio: integer; const ACodEmp: String): boolean;
begin
  result := TDemonstracaoResultadoAbrangenteExercicio.VerificarExistente(AExercicio, ACodEmp, FModoInsert);
end;

function TfrmDemonstracaoResultadoAbrangente.fGerarDados(
  pgbProgresso: TcxProgressBar): boolean;
var
  objGerar : TDemonstracaoResultadoAbrangenteGerar  ;
  lstEmpresas : TStringList ;
begin
  Result := True;
  pgbProgresso.Properties.Max := 1 ;
  pSetaTextoProgresso(pgbProgresso, 'Gerando Lançamentos: DRA ' + cbAnoExercicio.Text);

  dsGerar.Enabled := False ;
  dsGerar.DataSet := Nil ;
  if Assigned(cdsGerar) then
  begin
    FreeAndNil(cdsGerar) ;
  end;


  lstEmpresas := fEmpresasArrToList ;
  objGerar := TDemonstracaoResultadoAbrangenteGerar.Create  ;
  try
    objGerar.AnoExercicio := strtoint(cbAnoExercicio.Text) ;
    objGerar.Progresso := pgbProgresso ;
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

function TfrmDemonstracaoResultadoAbrangente.fGravarParametros: boolean;
begin
  result := TDemonstracaoResultadoAbrangenteParametros.Gravar(edtExercicio.Value, edtEmpSel01.Text, cdsParametros, cdsParametrosContas, FModoInsert) ;
end;

function TfrmDemonstracaoResultadoAbrangente.fIncluirDe(
  const AExercicio: integer; const ACodEmp: String): boolean;
var
  qryCopiar : TUniquery ;
  cdsCon : TUniClientDataSet ;
  strIdent : string ;
begin
  ////busca os dados do exercicio a ser copiado
  qryCopiar := fCriaQuery() ;
  try
    TDemonstracaoResultadoAbrangenteParametros.IncluirDe(AExercicio, ACodEmp, qryCopiar, cdsCon) ;

    cdsParametros.DisableControls ;
    cdsParametrosContas.DisableControls ;
    try
      cdsParametros.EmptyDataSet;
      cdsParametrosContas.EmptyDataSet;
      while not qryCopiar.Eof do
      begin
        cdsParametros.Append ;
        cdsParametros.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PARDRA',Vs_strCodEmp) ;
        cdsParametros.FieldByName('DRA_NIVEL_').AsString := qryCopiar.FieldByName('DRA_NIVEL_').AsString ;
        cdsParametros.FieldByName('DRA_ORDEM_').AsString := qryCopiar.FieldByName('DRA_ORDEM_').AsString ;
        cdsParametros.FieldByName('DRA_EDITAV').AsString := qryCopiar.FieldByName('DRA_EDITAV').AsString ;
        cdsParametros.FieldByName('DRA_NEGRIT').AsString := qryCopiar.FieldByName('DRA_NEGRIT').AsString ;
        cdsParametros.FieldByName('DRA_CONTAS').AsString := qryCopiar.FieldByName('DRA_CONTAS').AsString ;
        strIdent := fReplicatorStr(' ',qryCopiar.FieldByName('DRA_NIVEL_').AsInteger*3) ;
        cdsParametros.FieldByName('DRA_DESCRI').AsString := strIdent + qryCopiar.FieldByName('DRA_DESCRI').AsString ;
        cdsParametros.Post ;
        ////adiciona as contas
        if cdsCon.FindKey([qryCopiar.FieldByName('AUTOINCREM').AsString]) then
        begin
          while (cdsCon.FieldByName('DRA_SEQLAN').AsString = qryCopiar.FieldByName('AUTOINCREM').AsString) and (not cdsCon.Eof) do
          begin

            cdsParametrosContas.Append ;
            cdsParametrosContas.FieldByName('DRA_SEQLAN').AsString := cdsParametros.FieldByName('AUTOINCREM').AsString ;
            cdsParametrosContas.FieldByName('DRA_CODCON').AsString := cdsCon.FieldByName('DRA_CODCON').AsString ;
            cdsParametrosContas.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [cdsCon.FieldByName('DRA_CODCON').AsString], False);
            cdsParametrosContas.Post ;

            cdsCon.Next;
          end;
        end;
        qryCopiar.Next;
      end;
      cdsParametros.First ;
    finally
      cdsParametros.EnableControls ;
      cdsParametrosContas.EnableControls ;
    end;

  finally
    FreeAndNil(qryCopiar) ;
    FreeAndNil(cdsCon) ;
  end;
  result := true ;
end;

function TfrmDemonstracaoResultadoAbrangente.fIsAssignedProgresso(
  pgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(pgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

function TfrmDemonstracaoResultadoAbrangente.fListaExercicios(const ACodEmp: String): TStringList;
begin
  result := TDemonstracaoResultadoAbrangenteExercicio.Listar(ACodEmp) ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.FormCloseQuery(Sender: TObject;
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
    fMensagem('ATENÇÃO!', 'Fechar o DRA, antes de fechar o módulo!' , ['&Ok']);
    CanClose := False ;
    exit ;
  end;
end;

procedure TfrmDemonstracaoResultadoAbrangente.FormCreate(Sender: TObject);
begin
  inherited;
  FListResponsavelContador := TObjectList<TInfoResponsavelContador>.Create() ;
  FListResponsavelEmpresa := TObjectList<TInfoResponsavelEmpresa>.Create() ;
  pCarregaResponsavel(FListResponsavelContador, FListResponsavelEmpresa) ;
  cdsDadosRelatorio.CreateDataSet ;
  cdsDadosRelatorio.Open ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FListResponsavelContador) ;
  FreeAndNil(FListResponsavelEmpresa) ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.FormShow(Sender: TObject);
begin
  inherited;
  pBotoesParametros(True) ;
  pBotoesGerar(True) ;
  pCarregaDadosParametros(-1, '') ;
  pCarregaResponsavelComboBoxAdministrador(FListResponsavelEmpresa, cbResponsavelEmpresa) ;
  pCarregaResponsavelComboBoxContador(FListResponsavelContador, cbResponsavelContador) ;
  ControlePaginas.ActivePageIndex := 0 ;
end;

function TfrmDemonstracaoResultadoAbrangente.fValidaCampos(Sender: TWinControl;
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

procedure TfrmDemonstracaoResultadoAbrangente.GridGeracaoViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if GridGeracaoViewDRA_CONTAS.DataBinding.Field.AsString <> '1'  then
  begin
    AAllow := false ;
    exit ;
  end;

  if AItem = GridGeracaoViewDescricao then
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

procedure TfrmDemonstracaoResultadoAbrangente.GridGeracaoViewExercicioAnteriorPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  GridGeracaoView.DataController.PostEditingData ;
  pCalcularTotalGerar ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.GridGeracaoViewStylesGetContentStyle(
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
                         GridGeracaoViewDRA_NEGRIT.Index]) = '1' Then
      Begin
        AStyle := EstiloNegrito;
      End;
    end;
  end;
end;

procedure TfrmDemonstracaoResultadoAbrangente.GridParametrosViewCNT_BTNPropertiesButtonClick(
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

    cdsParametrosContas.Filter := 'DRA_SEQLAN = '+quotedstr(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
    cdsParametrosContas.Filtered := True ;
    frmDemonstracaoFluxoCaixaContasContabeis.StrAutoIncParametros := cdsParametros.FieldByName('AUTOINCREM').AsString ;
    frmDemonstracaoFluxoCaixaContasContabeis.dsPlanco.DataSet := cdsParametrosContas ;
    frmDemonstracaoFluxoCaixaContasContabeis.blnModoEdicao := fEmEdicao ;
    frmDemonstracaoFluxoCaixaContasContabeis.StrFieldSeqLan := 'DRA_SEQLAN' ;
    frmDemonstracaoFluxoCaixaContasContabeis.StrFieldCodCon := 'DRA_CODCON' ;
    frmDemonstracaoFluxoCaixaContasContabeis.StrFieldDescri := 'NCO_DESCRI' ;
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

procedure TfrmDemonstracaoResultadoAbrangente.GridParametrosViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if AItem = GridParametrosViewDRA_DESCRI then
  begin
    AAllow := GridParametrosViewDRA_EDITAV.DataBinding.Field.AsString = '1' ;
    exit ;
  end;
  if AItem = GridParametrosViewCNT_BTN then
  begin
    AAllow := GridParametrosViewDRA_CONTAS.DataBinding.Field.AsString = '1' ;
    exit ;
  end;
end;

procedure TfrmDemonstracaoResultadoAbrangente.GridParametrosViewEditKeyPress(
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

procedure TfrmDemonstracaoResultadoAbrangente.GridParametrosViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  if AFocusedItem = GridParametrosViewCNT_BTN then
  begin
    if GridParametrosViewDRA_CONTAS.DataBinding.Field.AsString = '1' then
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

procedure TfrmDemonstracaoResultadoAbrangente.GridParametrosViewStylesGetContentStyle(
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
                         GridParametrosViewDRA_NEGRIT.Index]) = '1' Then
      Begin
        AStyle := EstiloNegrito;
      End;
    end;
  end;
end;

procedure TfrmDemonstracaoResultadoAbrangente.Incluir1Click(Sender: TObject);
begin
  inherited;
  FModoInsert := True ;
  pInclusaoParametros ;
  pBotoesParametros(False) ;
  pSetFocus(edtExercicio) ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.Incluirde1Click(Sender: TObject);
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

procedure TfrmDemonstracaoResultadoAbrangente.pAfterScroll(DataSet: TDataSet);
begin
  if DataSet.FieldByName('DRA_CONTAS').AsString = '1' then
  begin
    pnlInfo.Caption := MENSAGEM_PESQUISA_CONTAS ;
  end
  else
  begin
    pnlInfo.Caption := '' ;
  end;
end;

procedure TfrmDemonstracaoResultadoAbrangente.pAjustaLabelGridGerar(
  const ALimpar: boolean);
var
  strExercicio, strExercicioAnterior: string ;
begin
  pInfoAnoExercicio(ALimpar, strExercicio, strExercicioAnterior, strToInt(cbAnoExercicio.Text)) ;
  GridGeracaoViewExercicio.Caption := strExercicio ;
  GridGeracaoViewExercicioAnterior.Caption := strExercicioAnterior ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.pBotoesGerar(
  const AHabilitar: boolean);
begin
  btnGerarDados.Enabled := AHabilitar ;
  btnImprimir.Enabled := not AHabilitar ;
  btnFecharGeracao.Enabled := not AHabilitar ;
  /////
  cbAnoExercicio.Enabled := AHabilitar ;
  edtEmpSel.Enabled := AHabilitar ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.pBotoesParametros(
  const AHabilitar: boolean);
begin
  btnIncluir.Enabled  :=  AHabilitar ;
  btnGravar.Enabled   :=  not AHabilitar ;
  btnAlterar.Enabled  :=  AHabilitar ;
  btnExcluir.Enabled  :=  AHabilitar ;
  btnCancela.Enabled  :=  not AHabilitar ;
  btnPesquisa.Enabled :=  AHabilitar ;
  /////
  TcxTextEditProperties(GridParametrosViewDRA_DESCRI.Properties).ReadOnly := not fEmEdicao ;
  TcxButtonEditProperties(GridParametrosViewCNT_BTN.Properties).ReadOnly := not fEmEdicao ;
  ////no modo de alteração não é possivel alterar o exercicio, somente em inclusão.
  edtExercicio.Enabled := FModoInsert ;
  edtEmpSel01.Enabled := FModoInsert ;
  edtNomEmpSel01.Enabled := FModoInsert ;
end;

procedure TfrmDemonstracaoResultadoAbrangente.pCarregaAnoExercicio(const ACodEmp: String);
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

procedure TfrmDemonstracaoResultadoAbrangente.pCarregaDadosParametros(
  const AExercicio: integer; const ACodEmp: String);
begin
  dsParametros.Enabled := False ;
  dsParametros.DataSet := Nil ;

  TDemonstracaoResultadoAbrangenteParametros.Carregar(AExercicio, ACodEmp, cdsParametros, cdsParametrosContas) ;

  cdsParametros.AfterScroll := pAfterScroll;

  pOcorrenciaContas ;

  if not cdsParametros.IsEmpty then
  begin
    edtExercicio.Value := cdsParametros.FieldByName('DRA_EXERCI').AsInteger ;
    edtEmpSel01.Text := cdsParametros.FieldByName('DRA_CODEMP').AsString ;
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

procedure TfrmDemonstracaoResultadoAbrangente.pInclusaoParametros;
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
      cdsParametros.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PARDRA',Vs_strCodEmp) ;
      cdsParametros.FieldByName('DRA_NIVEL_').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_NIVEL_] ;
      cdsParametros.FieldByName('DRA_ORDEM_').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_ORDEM_] ;
      cdsParametros.FieldByName('DRA_EDITAV').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_EDITAV] ;
      cdsParametros.FieldByName('DRA_NEGRIT').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_NEGRIT] ;
      cdsParametros.FieldByName('DRA_CONTAS').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_CONTAS] ;
      strIdent := fReplicatorStr(' ',cdsParametros.FieldByName('DRA_NIVEL_').AsInteger*3) ;
      cdsParametros.FieldByName('DRA_DESCRI').AsString := strIdent + PARAMETROS_PADRAO[intLinhas, PARAMETROS_DESCRI] ;
      cdsParametros.Post ;
    end;
    cdsParametros.First ;
  finally
    cdsParametros.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoResultadoAbrangente.pInclusaoParametrosContas(
  const AArrSel: TConsultasArray; const AAutoIncParametros: string);
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
      cdsParametrosContas.FieldByName('DRA_SEQLAN').AsString := AAutoIncParametros ;
      cdsParametrosContas.FieldByName('DRA_CODCON').AsString := AArrSel[intCnt].strCodigo ;
      cdsParametrosContas.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [AArrSel[intCnt].strCodigo], False);
      cdsParametrosContas.Post ;
    end;
  finally
    cdsParametrosContas.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoResultadoAbrangente.pOcorrenciaContas(
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
          cdsParametrosContas.Filter := 'DRA_SEQLAN = '+quotedstr(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
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
        cdsParametrosContas.Filter := 'DRA_SEQLAN = '+quotedstr(AAutoIncParametros) ;
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

procedure TfrmDemonstracaoResultadoAbrangente.pReplicaExercicio(
  const AExercicio: integer; const ACodEmp: String);
begin
  cdsParametros.DisableControls ;
  try
    cdsParametros.First ;
    while not cdsParametros.Eof do
    begin
      cdsParametros.Edit ;
      cdsParametros.FieldByName('DRA_EXERCI').AsInteger := AExercicio ;
      cdsParametros.FieldByName('DRA_CODEMP').AsString := ACodEmp ;
      cdsParametros.Post ;
      cdsParametros.Next ;
    end;
  finally
    cdsParametros.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoResultadoAbrangente.pSetaTextoProgresso(
  pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if fIsAssignedProgresso(pgbProgresso) then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TfrmDemonstracaoResultadoAbrangente.pCalcularTotalGerar;
var
  iExercicio: integer ;
  lstEmpresas: TStringList ;
begin
  lstEmpresas := fEmpresasArrToList ;
  iExercicio := strtoint(cbAnoExercicio.Text) ;
  try
    TDemonstracaoResultadoAbrangenteGerar.CalcularTotais(iExercicio, lstEmpresas, cdsGerar);
  finally
    FreeAndNil(lstEmpresas);
  end;
end;

function TfrmDemonstracaoResultadoAbrangente.fValidaImpressao: boolean;
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

procedure TfrmDemonstracaoResultadoAbrangente.pCarregaDadosRelatorio;
begin
  cdsDadosRelatorio.EmptyDataSet ;
  cdsGerar.DisableControls ;
  try
    cdsGerar.First ;
    while not cdsGerar.Eof do
    begin
      cdsDadosRelatorio.Append ;
      cdsDadosRelatorio.FieldByName('DESCRI').AsString := cdsGerar.FieldByName('DRA_DESCRI').AsString ;
      if cdsGerar.FieldByName('DRA_EXERCI').AsFloat < 0 then
      begin
        cdsDadosRelatorio.FieldByName('EXERCI').AsString := '('+FormatCurr('#,##0.00', abs(cdsGerar.FieldByName('DRA_EXERCI').AsFloat))+')' ;
      end
      else
      begin
        cdsDadosRelatorio.FieldByName('EXERCI').AsString := FormatCurr('#,##0.00', cdsGerar.FieldByName('DRA_EXERCI').AsFloat) ;
      end;
      if cdsGerar.FieldByName('DRA_EXEANT').AsFloat < 0 then
      begin
        cdsDadosRelatorio.FieldByName('EXEANT').AsString := '('+FormatCurr('#,##0.00', abs(cdsGerar.FieldByName('DRA_EXEANT').AsFloat))+')' ;
      end
      else
      begin
        cdsDadosRelatorio.FieldByName('EXEANT').AsString := FormatCurr('#,##0.00', cdsGerar.FieldByName('DRA_EXEANT').AsFloat) ;
      end;
      cdsDadosRelatorio.FieldByName('CONTAS').AsString := cdsGerar.FieldByName('DRA_CONTAS').AsString ;
      cdsDadosRelatorio.FieldByName('NEGRIT').AsString := cdsGerar.FieldByName('DRA_NEGRIT').AsString ;
      cdsDadosRelatorio.Post ;
      cdsGerar.Next ;
    end;
  finally
    cdsGerar.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoResultadoAbrangente.pShowComboResponsavel(
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
