unit Contabilidade.View.DemonstracaoValorAdicionado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxButtonEdit, cxCalc, cxClasses, cxGridBandedTableView,
  cxGridDBBandedTableView, cxCheckBox, EditFocus, cxDropDownEdit, cxLabel,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGridCitel, cxGrid, cxButtons, cxMaskEdit, cxSpinEdit,
  cxGroupBox, cxPC, Datasnap.DBClient, UniClientDataSet, untTypesSistema, MemDS,
  DBAccess, Uni, cxProgressBar, frxDBSet, System.Generics.Collections,
  Contabilidade.Interfaces, frxExportPDF;

const
  TITULO_RELATORIO = 'DVA - Demonstração do Valor Adicionado' ;

type
  TfrmDemonstracaoValorAdicionado = class(TfrmPaiContabilidade)
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
    GridParametrosViewDVA_EXERCI: TcxGridDBColumn;
    GridParametrosViewDVA_DESCRI: TcxGridDBColumn;
    GridParametrosViewDVA_NIVEL_: TcxGridDBColumn;
    GridParametrosViewDVA_ORDEM_: TcxGridDBColumn;
    GridParametrosViewDVA_EDITAV: TcxGridDBColumn;
    GridParametrosViewDVA_NEGRIT: TcxGridDBColumn;
    GridParametrosViewCNT_BTN: TcxGridDBColumn;
    GridParametrosViewDVA_CONTAS: TcxGridDBColumn;
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
    GridGeracaoViewDVA_CONTAS: TcxGridDBBandedColumn;
    GridGeracaoViewDVA_NEGRIT: TcxGridDBBandedColumn;
    GridGeracaoLevel: TcxGridLevel;
    gbBotoesGerar: TcxGroupBox;
    btnFecharGeracao: TcxButton;
    mnuIncluir: TPopupMenu;
    Incluir1: TMenuItem;
    Incluirde1: TMenuItem;
    StyleRepository: TcxStyleRepository;
    EstiloNegrito: TcxStyle;
    dsGerar: TDataSource;
    dsParametros: TDataSource;
    frxRelatorio: TfrxReport;
    frxDBRelatorio: TfrxDBDataset;
    lbResponsavelEmpresa: TcxLabel;
    lbResponsavelContador: TcxLabel;
    cbResponsavelEmpresa: TcxComboBox;
    cbResponsavelContador: TcxComboBox;
    cdsDadosRelatorio: TUniClientDataSet;
    cdsDadosRelatorioDVA_DESCRI: TStringField;
    cdsDadosRelatorioDVA_EXERCI: TStringField;
    cdsDadosRelatorioDVA_EXEANT: TStringField;
    cdsDadosRelatorioDVA_CONTAS: TStringField;
    cdsDadosRelatorioDVA_NEGRIT: TStringField;
    frxPDFExport: TfrxPDFExport;
    cxLabel6: TcxLabel;
    cxLabel5: TcxLabel;
    edtEmpSel01: TEditFocus;
    edtNomEmpSel01: TEditFocus;
    procedure FormShow(Sender: TObject);
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
    procedure Incluir1Click(Sender: TObject);
    procedure Incluirde1Click(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure GridParametrosViewCNT_BTNPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
    procedure ControlePaginasPageChanging(Sender: TObject; NewPage: TcxTabSheet;
      var AllowChange: Boolean);
    procedure btnGerarDadosClick(Sender: TObject);
    procedure GridGeracaoViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridGeracaoViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure btnFecharGeracaoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GridGeracaoViewExercicioPropertiesEditValueChanged(
      Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkImprimirAssinaturaPropertiesEditValueChanged(Sender: TObject);
    procedure chkImprimirParaArquivoPropertiesEditValueChanged(Sender: TObject);
    procedure edtEmpSel01KeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpSelExit(Sender: TObject);
  private
    FListResponsavelContador: TObjectList<TInfoResponsavelContador> ;
    FListResponsavelEmpresa: TObjectList<TInfoResponsavelEmpresa> ;
    FModoInsert: boolean;
    cdsParametros: TUniClientDataSet;
    cdsParametrosContas: TUniClientDataSet;
    arrEmpSel: TConsultasArray;
    cdsGerar: TUniClientDataSet;
    procedure pCarregaDadosParametros(const AExercicio: integer; const ACodEmp: String);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pOcorrenciaContas(const AAutoIncParametros: string='');
    procedure pBotoesParametros(const AHabilitar: boolean);
    function fEmEdicao: boolean;
    function fEmEdicaoGeracao: boolean;
    procedure pBotoesGerar(const AHabilitar: boolean);
    procedure pInclusaoParametrosContas(const AArrSel: TConsultasArray;
      const AAutoIncParametros: string);
    procedure pReplicaExercicio(const AExercicio: integer; const ACodEmp: String);
    function fExercicioCadastrado(const AExercicio: integer; const ACodEmp: String): boolean;
    procedure pInclusaoParametros;
    function fListaExercicios(const ACodEmp: String): TStringList;
    function fIncluirDe(const AExercicio: integer; const ACodEmp: String): boolean;
    function fGravarParametros: boolean;
    function fDeletarParametros: boolean;
    procedure pCarregaAnoExercicio(const ACodEmp: String);
    function fGerarDados(pgbProgresso: TcxProgressBar): boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
      strTexto: String);
    function fEmpresasArrToList: TStringList;
    procedure pAjustaLabelGridGerar(const ALimpar: boolean=False);
    function fIsAssignedProgresso(pgbProgresso: TcxProgressBar): boolean;
    procedure pCalcularTotalGerar;
    procedure pShowComboResponsavel(const AAssinatura, AArquivo: Boolean);
    function fValidaImpressao: boolean ;
    procedure pCarregaDadosRelatorio ;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, Contabilidade.Classes.TDemonstracaoValorAdicionado,
  Contabilidade.Consultas, Contabilidade.View.IncluirDeExercicio,
  Contabilidade.View.DemonstracaoFluxoCaixaContasContabeis, untConsultas,
  untFuncoesConsulta, Contabilidade.Funcoes ;

const
  MENSAGEM_PESQUISA_CONTAS = 'Tecle / para adicionar contas contábeis!' ;

procedure TfrmDemonstracaoValorAdicionado.FormCloseQuery(Sender: TObject;
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
    fMensagem('ATENÇÃO!', 'Fechar o DVA, antes de fechar o módulo!' , ['&Ok']);
    CanClose := False ;
    exit ;
  end;
end;

procedure TfrmDemonstracaoValorAdicionado.FormCreate(Sender: TObject);
begin
  inherited;
  FListResponsavelContador := TObjectList<TInfoResponsavelContador>.Create() ;
  FListResponsavelEmpresa := TObjectList<TInfoResponsavelEmpresa>.Create() ;
  pCarregaResponsavel(FListResponsavelContador, FListResponsavelEmpresa) ;
  cdsDadosRelatorio.CreateDataSet ;
  cdsDadosRelatorio.Open ;
end;

procedure TfrmDemonstracaoValorAdicionado.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FListResponsavelContador) ;
  FreeAndNil(FListResponsavelEmpresa) ;
end;

procedure TfrmDemonstracaoValorAdicionado.FormShow(Sender: TObject);
begin
  inherited;
  pBotoesParametros(True) ;
  pBotoesGerar(True) ;
  pCarregaDadosParametros(-1, '') ;
  pCarregaResponsavelComboBoxAdministrador(FListResponsavelEmpresa, cbResponsavelEmpresa) ;
  pCarregaResponsavelComboBoxContador(FListResponsavelContador, cbResponsavelContador) ;
  ControlePaginas.ActivePageIndex := 0 ;
end;

function TfrmDemonstracaoValorAdicionado.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  intIndex : integer ;
  LLivro, LPagina : Integer ;
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
          End;
          pCarregaConfRelRol(self.Name, arrEmpSel, LLivro, LPagina) ;
          edtNumeroLivro.Value := LLivro ;
          edtNumeroPaginaInicial.Value := LPagina ;
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

function TfrmDemonstracaoValorAdicionado.fValidaImpressao: boolean;
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

procedure TfrmDemonstracaoValorAdicionado.GridGeracaoViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if GridGeracaoViewDVA_CONTAS.DataBinding.Field.AsString <> '1'  then
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

procedure TfrmDemonstracaoValorAdicionado.GridGeracaoViewExercicioPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  GridGeracaoView.DataController.PostEditingData ;
  pCalcularTotalGerar ;
end;

procedure TfrmDemonstracaoValorAdicionado.GridGeracaoViewStylesGetContentStyle(
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
                         GridGeracaoViewDVA_NEGRIT.Index]) = '1' Then
      Begin
        AStyle := EstiloNegrito;
      End;
    end;
  end;
end;

procedure TfrmDemonstracaoValorAdicionado.GridParametrosViewCNT_BTNPropertiesButtonClick(
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

    cdsParametrosContas.Filter := 'DVA_SEQLAN = '+quotedstr(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
    cdsParametrosContas.Filtered := True ;
    frmDemonstracaoFluxoCaixaContasContabeis.StrAutoIncParametros := cdsParametros.FieldByName('AUTOINCREM').AsString ;
    frmDemonstracaoFluxoCaixaContasContabeis.dsPlanco.DataSet := cdsParametrosContas ;
    frmDemonstracaoFluxoCaixaContasContabeis.blnModoEdicao := fEmEdicao ;
    frmDemonstracaoFluxoCaixaContasContabeis.StrFieldSeqLan := 'DVA_SEQLAN' ;
    frmDemonstracaoFluxoCaixaContasContabeis.StrFieldCodCon := 'DVA_CODCON' ;
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

procedure TfrmDemonstracaoValorAdicionado.GridParametrosViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if AItem = GridParametrosViewDVA_DESCRI then
  begin
    AAllow := GridParametrosViewDVA_EDITAV.DataBinding.Field.AsString = '1' ;
    exit ;
  end;
  if AItem = GridParametrosViewCNT_BTN then
  begin
    AAllow := GridParametrosViewDVA_CONTAS.DataBinding.Field.AsString = '1' ;
    exit ;
  end;
end;

procedure TfrmDemonstracaoValorAdicionado.GridParametrosViewEditKeyPress(
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

procedure TfrmDemonstracaoValorAdicionado.GridParametrosViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  if AFocusedItem = GridParametrosViewCNT_BTN then
  begin
    if GridParametrosViewDVA_CONTAS.DataBinding.Field.AsString = '1' then
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

procedure TfrmDemonstracaoValorAdicionado.GridParametrosViewStylesGetContentStyle(
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
                         GridParametrosViewDVA_NEGRIT.Index]) = '1' Then
      Begin
        AStyle := EstiloNegrito;
      End;
    end;
  end;
end;

procedure TfrmDemonstracaoValorAdicionado.Incluir1Click(Sender: TObject);
begin
  inherited;
  FModoInsert := True ;
  pInclusaoParametros ;
  pBotoesParametros(False) ;
  pSetFocus(edtExercicio) ;
end;

procedure TfrmDemonstracaoValorAdicionado.Incluirde1Click(Sender: TObject);
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

procedure TfrmDemonstracaoValorAdicionado.pCarregaDadosParametros(
  const AExercicio: integer; const ACodEmp: String);
begin
  dsParametros.Enabled := False ;
  dsParametros.DataSet := Nil ;

  TDemonstracaoValorAdicionadoParametros.Carregar(AExercicio, ACodEmp, cdsParametros, cdsParametrosContas) ;

  cdsParametros.AfterScroll := pAfterScroll;

  pOcorrenciaContas ;

  if not cdsParametros.IsEmpty then
  begin
    edtExercicio.Value := cdsParametros.FieldByName('DVA_EXERCI').AsInteger ;
    edtEmpSel01.Text := cdsParametros.FieldByName('DVA_CODEMP').AsString ;
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

procedure TfrmDemonstracaoValorAdicionado.pCarregaDadosRelatorio;
begin
  cdsDadosRelatorio.EmptyDataSet ;
  cdsGerar.DisableControls ;
  try
    cdsGerar.First ;
    while not cdsGerar.Eof do
    begin
      cdsDadosRelatorio.Append ;
      cdsDadosRelatorio.FieldByName('DVA_DESCRI').AsString := cdsGerar.FieldByName('DVA_DESCRI').AsString ;
      if cdsGerar.FieldByName('DVA_EXERCI').AsFloat < 0 then
      begin
        cdsDadosRelatorio.FieldByName('DVA_EXERCI').AsString := '('+FormatCurr('#,##0.00', abs(cdsGerar.FieldByName('DVA_EXERCI').AsFloat))+')' ;
      end
      else
      begin
        cdsDadosRelatorio.FieldByName('DVA_EXERCI').AsString := FormatCurr('#,##0.00', cdsGerar.FieldByName('DVA_EXERCI').AsFloat) ;
      end;
      if cdsGerar.FieldByName('DVA_EXEANT').AsFloat < 0 then
      begin
        cdsDadosRelatorio.FieldByName('DVA_EXEANT').AsString := '('+FormatCurr('#,##0.00', abs(cdsGerar.FieldByName('DVA_EXEANT').AsFloat))+')' ;
      end
      else
      begin
        cdsDadosRelatorio.FieldByName('DVA_EXEANT').AsString := FormatCurr('#,##0.00', cdsGerar.FieldByName('DVA_EXEANT').AsFloat) ;
      end;
      cdsDadosRelatorio.FieldByName('DVA_CONTAS').AsString := cdsGerar.FieldByName('DVA_CONTAS').AsString ;
      cdsDadosRelatorio.FieldByName('DVA_NEGRIT').AsString := cdsGerar.FieldByName('DVA_NEGRIT').AsString ;
      cdsDadosRelatorio.Post ;
      cdsGerar.Next ;
    end;
  finally
    cdsGerar.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoValorAdicionado.pAfterScroll(DataSet: TDataSet);
begin
  if DataSet.FieldByName('DVA_CONTAS').AsString = '1' then
  begin
    pnlInfo.Caption := MENSAGEM_PESQUISA_CONTAS ;
  end
  else
  begin
    pnlInfo.Caption := '' ;
  end;
end;

procedure TfrmDemonstracaoValorAdicionado.pOcorrenciaContas(
  const AAutoIncParametros: string='');
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
          cdsParametrosContas.Filter := 'DVA_SEQLAN = '+quotedstr(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
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
        cdsParametrosContas.Filter := 'DVA_SEQLAN = '+quotedstr(AAutoIncParametros) ;
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

procedure TfrmDemonstracaoValorAdicionado.pBotoesParametros(
  const AHabilitar: boolean);
begin
  btnIncluir.Enabled  :=  AHabilitar ;
  btnGravar.Enabled   :=  not AHabilitar ;
  btnAlterar.Enabled  :=  AHabilitar ;
  btnExcluir.Enabled  :=  AHabilitar ;
  btnCancela.Enabled  :=  not AHabilitar ;
  btnPesquisa.Enabled :=  AHabilitar ;
  /////
  TcxTextEditProperties(GridParametrosViewDVA_DESCRI.Properties).ReadOnly := not fEmEdicao ;
  TcxButtonEditProperties(GridParametrosViewCNT_BTN.Properties).ReadOnly := not fEmEdicao ;
  ////no modo de alteração não é possivel alterar o exercicio, somente em inclusão.
  edtExercicio.Enabled := FModoInsert ;
  edtEmpSel01.Enabled := FModoInsert ;
  edtNomEmpSel01.Enabled := FModoInsert ;
end;

procedure TfrmDemonstracaoValorAdicionado.btnAlterarClick(Sender: TObject);
begin
  inherited;

  if cdsParametros.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  pBotoesParametros(False) ;
end;

procedure TfrmDemonstracaoValorAdicionado.btnCancelaClick(Sender: TObject);
begin
  inherited;
  FModoInsert := False ;
  pCarregaDadosParametros(edtExercicio.Value, edtEmpSel01.Text) ;
  pBotoesParametros(True) ;
end;

procedure TfrmDemonstracaoValorAdicionado.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if cdsParametros.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  if fMensagem('ATENÇÃO!', 'Confirma a exclusão dos parametros do exercício '+
                cdsParametros.FieldByName('DVA_EXERCI').AsString+'? ', ['&Sim', '&Não'], 1) = 2 then
  begin
    Exit;
  end;

  if not fDeletarParametros then
  begin
    exit ;
  end;

  pCarregaDadosParametros(-1, '') ;
end;

procedure TfrmDemonstracaoValorAdicionado.btnFecharGeracaoClick(
  Sender: TObject);
begin
  inherited;
  pGravaConfRelRol(self.Name, arrEmpSel, edtNumeroLivro.Value, edtNumeroPaginaInicial.Value) ;
  cdsGerar.EmptyDataSet ;
  pAjustaLabelGridGerar(True) ;
  pBotoesGerar(True) ;
end;

procedure TfrmDemonstracaoValorAdicionado.btnGerarDadosClick(Sender: TObject);
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

procedure TfrmDemonstracaoValorAdicionado.btnGravarClick(Sender: TObject);
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

procedure TfrmDemonstracaoValorAdicionado.btnImprimirClick(Sender: TObject);
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

procedure TfrmDemonstracaoValorAdicionado.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrPesq: TConsultasArray;
  LExercicio: Integer ;
  LCodEmp: String ;
  LRetornoPesquisa: String ;
begin
  chrKey := '/';
  If fPesqDemonstracaoValorAdicionado(Self, Nil, Nil, Nil, chrKey, arrPesq, False) Then
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

procedure TfrmDemonstracaoValorAdicionado.chkImprimirAssinaturaPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pShowComboResponsavel(TcxCheckBox(Sender).Checked, chkImprimirParaArquivo.Checked) ;
end;

procedure TfrmDemonstracaoValorAdicionado.chkImprimirParaArquivoPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pShowComboResponsavel(chkImprimirAssinatura.Checked, TcxCheckBox(Sender).Checked) ;
end;

procedure TfrmDemonstracaoValorAdicionado.ControlePaginasPageChanging(
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

procedure TfrmDemonstracaoValorAdicionado.edtEmpSel01KeyPress(Sender: TObject;
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

procedure TfrmDemonstracaoValorAdicionado.edtEmpSelExit(Sender: TObject);
begin
  inherited;
  pCarregaAnoExercicio(TEditFocus(Sender).Text) ;
end;

procedure TfrmDemonstracaoValorAdicionado.edtEmpSelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, arrEmpSel, True) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDemonstracaoValorAdicionado.fEmEdicao: boolean;
begin
  result := btnGravar.Enabled ;
end;

function TfrmDemonstracaoValorAdicionado.fEmEdicaoGeracao: boolean;
begin
  result := btnFecharGeracao.Enabled ;
end;

procedure TfrmDemonstracaoValorAdicionado.pBotoesGerar(
  const AHabilitar: boolean);
begin
  btnGerarDados.Enabled := AHabilitar ;
  btnImprimir.Enabled := not AHabilitar ;
  btnFecharGeracao.Enabled := not AHabilitar ;
  /////
  cbAnoExercicio.Enabled := AHabilitar ;
  edtEmpSel.Enabled := AHabilitar ;
end;

procedure TfrmDemonstracaoValorAdicionado.pInclusaoParametrosContas(
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
      cdsParametrosContas.FieldByName('DVA_SEQLAN').AsString := AAutoIncParametros ;
      cdsParametrosContas.FieldByName('DVA_CODCON').AsString := AArrSel[intCnt].strCodigo ;
      cdsParametrosContas.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [AArrSel[intCnt].strCodigo], False);
      cdsParametrosContas.Post ;
    end;
  finally
    cdsParametrosContas.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoValorAdicionado.pReplicaExercicio(
  const AExercicio: integer; const ACodEmp: String);
begin
  cdsParametros.DisableControls ;
  try
    cdsParametros.First ;
    while not cdsParametros.Eof do
    begin
      cdsParametros.Edit ;
      cdsParametros.FieldByName('DVA_EXERCI').AsInteger := AExercicio ;
      cdsParametros.FieldByName('DVA_CODEMP').AsString := ACodEmp ;
      cdsParametros.Post ;
      cdsParametros.Next ;
    end;
  finally
    cdsParametros.EnableControls ;
  end;
end;

function TfrmDemonstracaoValorAdicionado.fExercicioCadastrado(
  const AExercicio: integer; const ACodEmp: String): boolean;
begin
  result := TDemonstracaoValorAdicionadoExercicio.VerificarExistente(AExercicio, ACodEmp, FModoInsert);
end;

procedure TfrmDemonstracaoValorAdicionado.pInclusaoParametros;
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
      cdsParametros.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PARDVA',Vs_strCodEmp) ;
      cdsParametros.FieldByName('DVA_NIVEL_').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_NIVEL_] ;
      cdsParametros.FieldByName('DVA_ORDEM_').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_ORDEM_] ;
      cdsParametros.FieldByName('DVA_EDITAV').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_EDITAV] ;
      cdsParametros.FieldByName('DVA_NEGRIT').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_NEGRIT] ;
      cdsParametros.FieldByName('DVA_CONTAS').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_CONTAS] ;
      strIdent := fReplicatorStr(' ',cdsParametros.FieldByName('DVA_NIVEL_').AsInteger*3) ;
      cdsParametros.FieldByName('DVA_DESCRI').AsString := strIdent + PARAMETROS_PADRAO[intLinhas, PARAMETROS_DESCRI] ;
      cdsParametros.Post ;
    end;
    cdsParametros.First ;
  finally
    cdsParametros.EnableControls ;
  end;
end;

function TfrmDemonstracaoValorAdicionado.fListaExercicios(const ACodEmp: String): TStringList;
begin
  result := TDemonstracaoValorAdicionadoExercicio.Listar(ACodEmp) ;
end;

function TfrmDemonstracaoValorAdicionado.fIncluirDe(
  const AExercicio: integer; const ACodEmp: String): boolean;
var
  qryCopiar : TUniquery ;
  cdsCon : TUniClientDataSet ;
  strIdent : string ;
begin
  ////busca os dados do exercicio a ser copiado
  qryCopiar := fCriaQuery() ;
  try
    TDemonstracaoValorAdicionadoParametros.IncluirDe(AExercicio, ACodEmp, qryCopiar, cdsCon) ;

    cdsParametros.DisableControls ;
    cdsParametrosContas.DisableControls ;
    try
      cdsParametros.EmptyDataSet;
      cdsParametrosContas.EmptyDataSet;
      while not qryCopiar.Eof do
      begin
        cdsParametros.Append ;
        cdsParametros.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PARDVA',Vs_strCodEmp) ;
        cdsParametros.FieldByName('DVA_CODEMP').AsString := qryCopiar.FieldByName('DVA_CODEMP').AsString ;
        cdsParametros.FieldByName('DVA_NIVEL_').AsString := qryCopiar.FieldByName('DVA_NIVEL_').AsString ;
        cdsParametros.FieldByName('DVA_ORDEM_').AsString := qryCopiar.FieldByName('DVA_ORDEM_').AsString ;
        cdsParametros.FieldByName('DVA_EDITAV').AsString := qryCopiar.FieldByName('DVA_EDITAV').AsString ;
        cdsParametros.FieldByName('DVA_NEGRIT').AsString := qryCopiar.FieldByName('DVA_NEGRIT').AsString ;
        cdsParametros.FieldByName('DVA_CONTAS').AsString := qryCopiar.FieldByName('DVA_CONTAS').AsString ;
        strIdent := fReplicatorStr(' ',qryCopiar.FieldByName('DVA_NIVEL_').AsInteger*3) ;
        cdsParametros.FieldByName('DVA_DESCRI').AsString := strIdent + qryCopiar.FieldByName('DVA_DESCRI').AsString ;
        cdsParametros.Post ;
        ////adiciona as contas
        if cdsCon.FindKey([qryCopiar.FieldByName('AUTOINCREM').AsString]) then
        begin
          while (cdsCon.FieldByName('DVA_SEQLAN').AsString = qryCopiar.FieldByName('AUTOINCREM').AsString) and (not cdsCon.Eof) do
          begin

            cdsParametrosContas.Append ;
            cdsParametrosContas.FieldByName('DVA_SEQLAN').AsString := cdsParametros.FieldByName('AUTOINCREM').AsString ;
            cdsParametrosContas.FieldByName('DVA_CODCON').AsString := cdsCon.FieldByName('DVA_CODCON').AsString ;
            cdsParametrosContas.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [cdsCon.FieldByName('DVA_CODCON').AsString], False);
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

function TfrmDemonstracaoValorAdicionado.fGravarParametros: boolean;
begin
  result := TDemonstracaoValorAdicionadoParametros.Gravar(edtExercicio.Value, edtEmpSel01.Text, cdsParametros, cdsParametrosContas, FModoInsert) ;
end;

function TfrmDemonstracaoValorAdicionado.fDeletarParametros: boolean;
begin
  result := TDemonstracaoValorAdicionadoParametros.Deletar(cdsParametros.FieldByName('DVA_EXERCI').AsInteger, cdsParametros.FieldByName('DVA_CODEMP').AsString) ;
end;

procedure TfrmDemonstracaoValorAdicionado.pCarregaAnoExercicio(const ACodEmp: String);
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

function TfrmDemonstracaoValorAdicionado.fGerarDados(
  pgbProgresso: TcxProgressBar): boolean;
var
  objGerar : TDemonstracaoValorAdicionadoGerar  ;
  lstEmpresas : TStringList ;
begin
  Result := True;
  pgbProgresso.Properties.Max := 1 ;
  pSetaTextoProgresso(pgbProgresso, 'Gerando Lançamentos: DVA ' + cbAnoExercicio.Text);

  dsGerar.Enabled := False ;
  dsGerar.DataSet := Nil ;
  if Assigned(cdsGerar) then
  begin
    FreeAndNil(cdsGerar) ;
  end;


  lstEmpresas := fEmpresasArrToList ;
  objGerar := TDemonstracaoValorAdicionadoGerar.Create  ;
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

procedure TfrmDemonstracaoValorAdicionado.pSetaTextoProgresso(
  pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if fIsAssignedProgresso(pgbProgresso) then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TfrmDemonstracaoValorAdicionado.pShowComboResponsavel(
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

function TfrmDemonstracaoValorAdicionado.fEmpresasArrToList: TStringList;
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

procedure TfrmDemonstracaoValorAdicionado.pAjustaLabelGridGerar(
  const ALimpar: boolean=False);
var
  strExercicio, strExercicioAnterior: string ;
begin
  pInfoAnoExercicio(ALimpar, strExercicio, strExercicioAnterior, strToInt(cbAnoExercicio.Text)) ;
  GridGeracaoViewExercicio.Caption := strExercicio ;
  GridGeracaoViewExercicioAnterior.Caption := strExercicioAnterior ;
end;

function TfrmDemonstracaoValorAdicionado.fIsAssignedProgresso(
  pgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(pgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

procedure TfrmDemonstracaoValorAdicionado.pCalcularTotalGerar;
var
  iExercicio: integer ;
  lstEmpresas: TStringList ;
begin
  lstEmpresas := fEmpresasArrToList ;
  iExercicio := strtoint(cbAnoExercicio.Text) ;
  try
    TDemonstracaoValorAdicionadoGerar.CalcularTotais(iExercicio, lstEmpresas, cdsGerar);
  finally
    FreeAndNil(lstEmpresas);
  end;
end;



end.
