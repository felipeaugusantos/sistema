unit untManutencaoEmpresaCentralizadora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, ComboBoxFocus, EditFocus, Vcl.Mask, MaskEditFocus, QColorLabel,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, dxCustomWizardControl,
  dxWizardControl, untCustomWizardControl, untZClient, untTypesSistema, untFuncoesConsulta,
  Uni, Vcl.ComCtrls, cxContainer, cxProgressBar;

type

  TAcao = (taInicio, taVoltar, taProximo);

  TfrmManutencaoEmpresaCentralizadora = class(TfrmPai)
    dtsEmpresas: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    pnlContainer: TPanel;
    pnlAcoes: TPanel;
    pnlHeader: TPanel;
    lblTitulo: TLabel;
    lblSubTitulo: TLabel;
    btnVoltar: TBitBtnLocked;
    btnProximo: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlContent: TPanel;
    pnlTela1: TPanel;
    cxgEmpresas: TcxGrid;
    cxgEmpresasDB: TcxGridDBTableView;
    cxgEmpresasEmpresa: TcxGridDBColumn;
    cxgEmpresasDescricao: TcxGridDBColumn;
    cxgEmpresasEmpresaCentralizada: TcxGridDBColumn;
    cxgEmpresasEmpCentralDescricao: TcxGridDBColumn;
    cxgEmpresasLevel1: TcxGridLevel;
    pnlIteEmbBottom: TPanel;
    Label63: TLabel;
    Label125: TLabel;
    Label1: TLabel;
    pnlTela3: TPanel;
    pnlTela2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label167: TLabel;
    Label14: TLabel;
    Label31: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    ColorLabel1: TColorLabel;
    Label13: TLabel;
    lbl50: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtCodUni: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    cmbGiroEstoque: TComboBoxFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodAbr: TEditFocus;
    edtDesAbr: TEditFocus;
    edtClaIPI: TEditFocus;
    edtStatus: TEditFocus;
    edtExcIpi: TEditFocus;
    dtsProdutos: TDataSource;
    cxgProdutos: TcxGridCitel;
    cxgProdutosTableView: TcxGridDBTableViewCitel;
    cxgProdutosTableViewSIMNAO: TcxGridDBColumn;
    cxgProdutosTableViewCODITE: TcxGridDBColumn;
    cxgProdutosTableViewDESITE: TcxGridDBColumn;
    cxgProdutosTableViewREFERE: TcxGridDBColumn;
    cxgProdutosTableViewDESMAR: TcxGridDBColumn;
    cxgProdutosTableViewSIGUNI: TcxGridDBColumn;
    cxgProdutosLevel: TcxGridLevel;
    Panel1: TPanel;
    Label11: TLabel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure pOnMudarPainel(ANewPanel, AAcitvePanel: TPanel; var AAllow: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgEmpresasDBEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxgEmpresasDBKeyPress(Sender: TObject; var Key: Char);
    procedure cxgEmpresasDBKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure btnProximoClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgProdutosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);


  private
    intPanelAtivo: Integer;
    cdsEmpresas,
    cdsEmpresaBackup,
    cdsCadIte : TZClient;
    intSeq: Integer;

    qryConsulta: TUniQuery;
    qryUpdate: TUniQuery;
    arrLinGru : TConsultasArray;
    arrCodUni : TConsultasArray;
    arrCodMar : TConsultasArray;
    arrPrdGru : TConsultasArray;
    arrGruCmp : TConsultasArray;
    arrCodFor : TConsultasArray;
    arrCodAbr : TConsultasArray;

    strLinGru : String;
    strCodUni : String;
    strCodMar : String;
    strPrdGru : String;
    strGruCmp : String;
    strCodFor : String;
    strCodAbr : String;
    procedure pConsultaEmpresa(var Key: Char);
    procedure pSetCodEmpresa(blnLimpar: Boolean = False);
    procedure OnCdsEmpresasBeforePost(DataSet: TDataSet);
    procedure OnCdsEmpresasAfterPost(DataSet: TDataSet);
    procedure OnCdsEmpresasAfterDelete(DataSet: TDataSet);
    procedure pControlaNavegacao(AAcao: TAcao);
    procedure pReiniciaTela;
    procedure pMarcaDesmar;
    procedure pMarcaDesmarTodos(blnMarcar: Boolean);
    function fAbreDadosCadIte : Boolean;
    function fGetSQLCadIte: String;
    function fGetSQLEmpresas(strCodEmp: String = ''): String;
    function fGetNomeCampo(blnDesc: Boolean = False): string;
    function fValidaValoresInseridos: Boolean;
    function fGravaProgresso(cxProgress : TCxProgressBar) : Boolean;
    function fVerificaEmpresasGravadasCorretamente: Boolean;
    function fExisteItemMarcado: Boolean;


    { Private declarations }
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;

  public
    { Public declarations }
  end;

var
  frmManutencaoEmpresaCentralizadora: TfrmManutencaoEmpresaCentralizadora;

implementation

uses
  untFuncoesSimples, untConsultas, untGravando;

{$R *.dfm}

procedure TfrmManutencaoEmpresaCentralizadora.btnConfirmaClick(Sender: TObject);
begin
  If Not fExisteItemMarcado Then
  Begin
    fMensagem('', 'Nenhum item foi marcado para ser atualizado.', ['&Ok']);
    Exit;
  End;
  If Not fPergunta('Confirmar a gravação das empresas centralizadoras?') Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaProgresso;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

end;

procedure TfrmManutencaoEmpresaCentralizadora.btnDesmarcaTodosClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarTodos(False);
end;

procedure TfrmManutencaoEmpresaCentralizadora.btnMarcaTodosClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarTodos(true)
end;

procedure TfrmManutencaoEmpresaCentralizadora.btnProximoClick(Sender: TObject);
begin
  inherited;
  pControlaNavegacao(taproximo);
end;

procedure TfrmManutencaoEmpresaCentralizadora.btnVoltarClick(Sender: TObject);
begin
  inherited;
  pControlaNavegacao(taVoltar);
end;

procedure TfrmManutencaoEmpresaCentralizadora.cxgEmpresasDBEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  pConsultaEmpresa(Key);
end;

procedure TfrmManutencaoEmpresaCentralizadora.cxgEmpresasDBKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_DELETE Then
  Begin
    If cdsEmpresas.IsEmpty Then
      Exit;
    If fMensagem('Atenção', 'Esta ação removerá a relação. Continuar?', ['&Sim', '&Não']) = 1 Then
      cdsEmpresas.Delete;
  End
  Else If Key = VK_INSERT Then
    cxgEmpresasEmpresa.Focused := True;

end;

procedure TfrmManutencaoEmpresaCentralizadora.cxgEmpresasDBKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultaEmpresa(Key);
end;

procedure TfrmManutencaoEmpresaCentralizadora.cxgProdutosTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_SPACE Then
    pMarcaDesmar;
end;

procedure TfrmManutencaoEmpresaCentralizadora.pOnMudarPainel(
          ANewPanel, AAcitvePanel: TPanel; var AAllow: Boolean);
begin
  If ANewPanel = pnlTela1 Then
    btnProximo.Enabled := (cdsEmpresas.RecordCount > 0)
  Else If AAcitvePanel = pnlTela1 Then
  Begin
    AAllow := fVerificaEmpresasGravadasCorretamente;
    if Not AAllow then
      fMensagem('', 'Existe Empresa sem Empresa Centralizadora ou vice-versa. Corrigir para continuar', ['&Ok']);
  End
  Else If (AAcitvePanel = pnlTela2) And
     (ANewPanel = pnlTela3) Then
  Begin
    AAllow := fValidaPanel(pnlTela2, True);
    If not AAllow Then
      Exit;

    If not fAbreDadosCadIte Then
    Begin
      fMensagem('', 'Não há dados para atualizar!', ['&Ok']);
      AAllow := False;
    End;
  End;
end;

procedure TfrmManutencaoEmpresaCentralizadora.pReiniciaTela;
begin
  cdsEmpresas.EmptyDataSet;
  cdsEmpresaBackup.EmptyDataSet;
  cdsCadIte.EmptyDataSet;
  edtDesGru.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;
  edtCodUni.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtPrdGru.Clear;
  edtDesPrdPro.Clear;
  edtGruCmp.Clear;
  edtDesGruCmp.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodAbr.Clear;
  edtDesAbr.Clear;
  edtClaIPI.Clear;
  edtStatus.Text := 'T';
  edtExcIpi.Clear;
  cmbGiroEstoque.ItemIndex := -1;
  btnProximo.Enabled := False;
  cxgProdutosTableView.DataController.Filter.Clear;
end;

procedure TfrmManutencaoEmpresaCentralizadora.FormCreate(Sender: TObject);
begin
  inherited;
  pControlaNavegacao(taInicio);
  edtCodAbr.MaxLength :=  IIf(fCfgSis('USASAN') = 'S', 7, 3);
  btnProximo.Enabled := False;
  cdsCadIte := TZClient.Create(Self);
  cdsEmpresas := TZClient.Create(Self, fGetSQLEmpresas);
  cdsEmpresaBackup := TZClient.Create(Self, fGetSQLEmpresas);
  cdsEmpresas.fAbreClient(True, 'TfrmManutencaoEmpresaCentralizadora.FormCreate');
  dtsEmpresas.DataSet := cdsEmpresas;
  dtsProdutos.DataSet := cdsCadIte;
  qryConsulta := fCriaQuery;
  qryUpdate := fCriaQuery;
  cdsEmpresas.BeforePost := OnCdsEmpresasBeforePost;
  cdsEmpresas.AfterPost  := OnCdsEmpresasAfterPost;
  cdsEmpresas.AfterDelete := OnCdsEmpresasAfterDelete;
  intSeq := 0;
  intPanelAtivo := 0;
end;

procedure TfrmManutencaoEmpresaCentralizadora.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsCadIte);
  FreeAndNil(cdsEmpresas);
  FreeAndNil(cdsEmpresaBackup);
  FreeAndNil(qryConsulta);
  FreeAndNil(qryUpdate);
  inherited;
end;

procedure TfrmManutencaoEmpresaCentralizadora.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If intPanelAtivo = 2 then
  Begin
    If Key = VK_F7 Then
      pMarcaDesmarTodos(True)
    Else If Key = VK_F6 Then
      pMarcaDesmarTodos(False)
  End;
end;

procedure TfrmManutencaoEmpresaCentralizadora.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnSair);
end;

function TfrmManutencaoEmpresaCentralizadora.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = mskLinGru) Then
    Begin
      If fEmptyStr(mskLinGru.text) Then
        Exit;

      pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
      If fEmptyStr(edtDesGru.Text) Then
        Result := False
    End
    Else If Sender = edtCodMar Then
    Begin
      If fEmptyStr(edtCodMar.text) Then
        Exit;

      pEdtCodSelectExit(edtCodMar, edtDesMar, arrCodMar, fRetNomMarca, nil, 'da Marca');
      If fEmptyStr(edtDesMar.Text) Then
        Result := False
    End
    Else If Sender = edtPrdGru Then
    Begin
      If fEmptyStr(edtPrdGru.text) Then
        Exit;

      pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrPrdGru, fRetNomeGrupoProduto, nil, 'do Grupo de Produto');
      If fEmptyStr(edtDesPrdPro.Text) Then
        Result := False
    End
    Else If (Sender = edtGruCmp) Then
    Begin
      If fEmptyStr(edtGruCmp.text) Then
        Exit;

      pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, nil, fRetDescGrupoCompra, 'do Grupo de Compra');
      If fEmptyStr(edtDesGruCmp.Text) Then
        Result := False
    End
    Else If (Sender = edtCodUni) Then
    Begin
      If fEmptyStr(edtCodUni.text) Then
        Exit;

      If Not fEmptyStr(edtCodUni.Text) Then
        If fEmptyStr(fRetNomUnidade(edtCodUni.Text)) Then
          Result := False;
    End
    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.text) Then
        Exit;

      pEdtCodSelectExit(edtCodFor, edtNomFor, arrCodFor, fRetNomFornecedor, nil, 'do Fornecedor');
      If fEmptyStr(edtNomFor.Text) Then
        Result := False
    End

    Else If (Sender = edtCodAbr) Then
    Begin
      If fEmptyStr(edtCodAbr.text) Then
        Exit;

      pEdtCodSelectExit(edtCodAbr, edtDesAbr, arrCodAbr, fRetDesAbfIcm, Nil, 'da Abreviação Fiscal');
      If fEmptyStr(edtDesAbr.Text) Then
        Result := False
    End
  End;

end;

function TfrmManutencaoEmpresaCentralizadora.fValidaValoresInseridos: Boolean;
begin
  cdsEmpresaBackup.Filtered := False;
  cdsEmpresaBackup.Filter   := 'EMP_CODEMP = ' + QuotedStr(cdsEmpresas.FieldByName('EMP_CODEMP').AsString)  +
                               ' AND EMP_SEQUEN <> ' + cdsEmpresas.FieldByName('EMP_SEQUEN').AsString;
  cdsEmpresaBackup.Filtered := True;
  Result := cdsEmpresaBackup.IsEmpty;
  cdsEmpresaBackup.Filtered := False;
end;

function TfrmManutencaoEmpresaCentralizadora.fVerificaEmpresasGravadasCorretamente: Boolean;
begin
  cdsEmpresaBackup.Filtered := False;
  cdsEmpresaBackup.Filter := 'EMP_CODEMP = ' + QuotedStr('');
  cdsEmpresaBackup.Filtered := True;
  Result := cdsEmpresaBackup.IsEmpty;
  cdsEmpresaBackup.Filtered := False;
end;

procedure TfrmManutencaoEmpresaCentralizadora.OnCdsEmpresasAfterPost(
  DataSet: TDataSet);
begin
  If (cdsEmpresas.FieldByName('EMP_CODEMP').AsString = '') And
     (cdsEmpresas.FieldByName('EMP_CODCEN').AsString = '') Then
     cdsEmpresas.Delete;

  btnProximo.Enabled := cdsEmpresas.RecordCount > 0;
  cdsEmpresaBackup.Data := cdsEmpresas.Data;
end;

procedure TfrmManutencaoEmpresaCentralizadora.OnCdsEmpresasAfterDelete(DataSet: TDataSet);
begin
  btnProximo.Enabled := cdsEmpresas.RecordCount > 0;
  cdsEmpresaBackup.Data := cdsEmpresas.Data;
End;

procedure TfrmManutencaoEmpresaCentralizadora.OnCdsEmpresasBeforePost(DataSet: TDataSet);
  var
    strEmpresa: String;
Begin


  If cdsEmpresas.FieldByName(fGetNomeCampo).AsString <> '' Then
  Begin
    strEmpresa := fPadL(cdsEmpresas.FieldByName(fGetNomeCampo).AsString, 3, '0');
    cdsEmpresas.FieldByName(fGetNomeCampo).AsString := strEmpresa;

    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Text := fGetSQLEmpresas(cdsEmpresas.FieldByName(fGetNomeCampo).AsString);
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
      pSetCodEmpresa(True)
    Else
      pSetCodEmpresa;

    If cdsEmpresas.FieldByName(fGetNomeCampo).AsString = '' Then
      fMensagem('', 'Empresa não encontrada.', ['&Ok']);

    If cdsEmpresas.FieldByName('EMP_SEQUEN').AsInteger < 1 Then
    Begin
      Inc(intSeq);
      cdsEmpresas.FieldByName('EMP_SEQUEN').AsInteger       := intSeq;
    End;

    If Not fValidaValoresInseridos Then
    begin
      fMensagem('Atenção', 'A Empresa ' +
                           cdsEmpresas.FieldByName('EMP_CODEMP').AsString + '-' +
                           cdsEmpresas.FieldByName('EMP_NOMEMP').AsString + ' ' +
                           'já foi incluída.', ['&Ok']);

      cdsEmpresas.FieldByName(fGetNomeCampo).AsString := '';
      cdsEmpresas.FieldByName(fGetNomeCampo(True)).AsString := '';
      Exit;
    End
    Else
      cxgEmpresasEmpresaCentralizada.Focused := True;
  End;
End;

function TfrmManutencaoEmpresaCentralizadora.fGetNomeCampo(blnDesc: Boolean = False): string;
begin
  If blnDesc Then
    Result := IIf(cxgEmpresasEmpresa.Focused, 'EMP_NOMEMP', 'EMP_DESCEN')
  Else
    Result := IIf(cxgEmpresasEmpresa.Focused, 'EMP_CODEMP', 'EMP_CODCEN');
end;


procedure TfrmManutencaoEmpresaCentralizadora.pSetCodEmpresa(blnLimpar: Boolean = False);
Begin
  With cdsEmpresas do
  Begin
    FieldByName(fGetNomeCampo).AsString       := IIf(blnLimpar, '', qryConsulta.FieldByName('EMP_CODEMP').AsString);
    FieldByName(fGetNomeCampo(True)).AsString := IIf(blnLimpar, '', qryConsulta.FieldByName('EMP_NOMEMP').AsString);
  End;
End;

procedure TfrmManutencaoEmpresaCentralizadora.pConsultaEmpresa(var Key: Char);
  var arrSel:  TConsultasArray;
begin
  If (dtsEmpresas.State in dsEditModes) And
     ((cxgEmpresasEmpresa.Focused) or (cxgEmpresasEmpresaCentralizada.Focused)) And (fEntraCons(Key)) Then
  Begin
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    If fPesqEmpresa(conEmpSimples, Self, nil, nil, qryConsulta, Key, arrSel) then
       pSetCodEmpresa;
  End;
end;

procedure TfrmManutencaoEmpresaCentralizadora.pControlaNavegacao(AAcao: TAcao);
  var pnlAtivo: TPanel;
      blnContinuaTroca: Boolean;
      intPanelAtivoNovo: integer;
  function fRetPanelAtivo: TPanel;
  Begin
    case intPanelAtivo of
      0: Result := pnlTela1;
      1: Result := pnlTela2;
      2: Result := pnlTela3;
      Else
        Result := pnlTela1;
    End
  End;

  function fRetPanel(intPanel: integer): TPanel;
  Begin
    case intPanel of
      0: Result := pnlTela1;
      1: Result := pnlTela2;
      2: Result := pnlTela3;
      Else
        Result := pnlTela1;
    End
  End;

  procedure pDefinepainelVisible;
  Begin
    pnlTela1.Visible := pnlTela1 = pnlAtivo;
    pnlTela2.Visible := pnlTela2 = pnlAtivo;
    pnlTela3.Visible := pnlTela3 = pnlAtivo;
  End;

  procedure pEscreveTitulo(strTitulo, strSubTitulo: String);
  Begin
    lblTitulo.Caption := strTitulo;
    lblSubTitulo.Caption := strSubTitulo;
  End;

  procedure pDefineTitulo;
  Begin
    case intPanelAtivo of
      0: pEscreveTitulo('Empresas Centralizadoras', 'Defina as empresas centralizadoras');
      1: pEscreveTitulo('Filtros', 'Utilize os filtros para escolher os produtos que serão atualizados');
      2: pEscreveTitulo('Confirmação', 'Confirme os produtos que serão atualizados. Você pode desmarcar os produtos que não deseja atualizar.');
    End
  End;

begin
  blnContinuaTroca := True;
  intPanelAtivoNovo := intPanelAtivo;
  case AAcao of
    taVoltar: Dec(intPanelAtivoNovo);
    taProximo: inc(intPanelAtivoNovo) ;
    taInicio: Begin
                intPanelAtivoNovo := 0;
                pnlAtivo := pnlTela1;
                If intPanelAtivo > 0 Then
                  pReiniciaTela;
              End;
  end;

  case AAcao of
    taVoltar,
    taProximo: Begin
                 pOnMudarPainel(fRetPanel(intPanelAtivoNovo), fRetPanel(intPanelAtivo), blnContinuaTroca);
               End;
  end;
  If blnContinuaTroca Then
  Begin
    intPanelAtivo := intPanelAtivoNovo;
    pnlAtivo := fRetPanelAtivo;
    pDefinepainelVisible;
    pDefineTitulo;
    btnVoltar.Visible := Not(pnlAtivo = pnlTela1);
    btnConfirma.Visible := pnlAtivo = pnlTela3;
    btnProximo.Visible :=  Not(pnlAtivo = pnlTela3);
    If btnConfirma.Visible Then
       btnConfirma.Left := btnProximo.Left;


    If AAcao <> tainicio Then
    Begin
      If pnlAtivo = pnlTela1 Then
        pSetFocus(cxgEmpresas)
      Else If pnlAtivo = pnlTela2 Then
        pSetFocus(mskLinGru)
      Else If pnlAtivo = pnlTela3 Then
        pSetFocus(cxgProdutos);
    End;
  End;
end;

procedure TfrmManutencaoEmpresaCentralizadora.pMarcaDesmar;
begin
  If cdsCadIte.IsEmpty then
    Exit;
  cdsCadIte.Edit;
  cdsCadIte.FieldByName('SIMNAO').AsInteger := IIf(cdsCadIte.FieldByName('SIMNAO').AsInteger = 1, 0, 1);
  cdsCadIte.Post;
end;

procedure TfrmManutencaoEmpresaCentralizadora.pMarcaDesmarTodos(
  blnMarcar: Boolean);
begin
  cdsCadIte.DisableControls;
  Try
    cdsCadIte.Filtered := False;
    cdsCadIte.Filter := UpperCase(cxgProdutosTableView.DataController.Filter.FilterText);
    cdsCadIte.Filtered:= True;
    While not cdsCadIte.Eof do
    Begin
      cdsCadIte.Edit;
      cdsCadIte.FieldByName('SIMNAO').AsInteger := IIf(blnMarcar, 1, 0);
      cdsCadIte.Post;
      cdsCadIte.Next;
    End;
  Finally
    cdsCadIte.EnableControls;
    cdsCadIte.Filtered:= False;
  End;

end;

function TfrmManutencaoEmpresaCentralizadora.fAbreDadosCadIte : Boolean;
Begin
  cdsCadIte.qryQuery.Close;
  cdsCadIte.qryQuery.SQL.Clear;
  cdsCadIte.qryQuery.SQL.Add(fGetSQLCadIte);

  cdsCadIte.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', cdsCadIte.qryQuery);
  pSetaParam(edtCodMar.Text, arrCodMar, strCodMar, 'CODMAR', cdsCadIte.qryQuery);
  pSetaParam(edtPrdGru.Text, arrPrdGru, strPrdGru, 'PRDGRU', cdsCadIte.qryQuery);
  pSetaParam(edtGruCmp.Text, arrGruCmp, strGruCmp, 'GRUCMP', cdsCadIte.qryQuery);
  pSetaParam(edtCodFor.Text, arrCodFor, strCodFor, 'CODFOR', cdsCadIte.qryQuery);
  pSetaParam(edtCodAbr.Text, arrCodAbr, strCodAbr, 'CODABF', cdsCadIte.qryQuery);
  pSetaParam(edtCodUni.Text, arrCodUni, strCodUni, 'CODUNI', cdsCadIte.qryQuery);

  If Not fEmptyStr(edtDesIte.Text) Then
    cdsCadIte.qryQuery.ParamByName('DESITE').AsString := edtDesIte.Text + '%';

  If Not fEmptyStr(edtRefere.Text) Then
    cdsCadIte.qryQuery.ParamByName('REFERE').AsString := edtRefere.Text + '%';

  If Not fEmptyStr(edtClaIPI.Text) Then
    cdsCadIte.qryQuery.ParamByName('CLAIPI').AsString := edtClaIPI.Text + '%';

  If Not fEmptyStr(edtExcIpi.Text) Then
    cdsCadIte.qryQuery.ParamByName('EXCIPI').AsString := edtExcIpi.Text;

  If (Pos(edtStatus.Text, 'SN') > 0) Then
    cdsCadIte.qryQuery.ParamByName('ITEATI').AsString := edtStatus.Text;

  If Not fEmptyStr(cmbGiroEstoque.Text) then
    cdsCadIte.qryQuery.ParamByName('NVLGIR').AsString := cmbGiroEstoque.Text;

  cdsCadIte.fAbreClient(True, 'TfrmManutancaoDescontoEmbalagem.pAbreDadosCadIte');

  Result := (cdsCadIte.RecordCount > 0);

End;

function TfrmManutencaoEmpresaCentralizadora.fExisteItemMarcado: Boolean;
begin
  cdsCadIte.DisableControls;
  Try
    cdsCadIte.Filtered := False;
    cdsCadIte.Filter := 'SIMNAO = 1';
    cdsCadIte.Filtered := True;
    Result := cdsCadIte.RecordCount > 0;
  Finally
    cdsCadIte.EnableControls;
    cdsCadIte.Filtered:= False;
  End;
end;

function TfrmManutencaoEmpresaCentralizadora.fGetSQLCadIte: String;
begin
  Result := '';
  Result := Result + ' SELECT I.ITE_CODITE AS CODITE,                     ';
  Result := Result + '        I.ITE_DESITE AS DESITE,                     ';
  Result := Result + '        I.ITE_REFERE AS REFERE,                     ';
  Result := Result + '          MAR_DESMAR AS DESMAR,                     ';
  Result := Result + '          UNI_SIGUNI AS SIGUNO,                     ';
  Result := Result + '          1        AS SIMNAO                      ';
  Result := Result + ' FROM ITEGER G                                      ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + ' LEFT  JOIN CADMAR   ON   MAR_CODMAR = I.ITE_CODMAR ';
  Result := Result + ' LEFT  JOIN CADUNI   ON   UNI_CODUNI = I.ITE_CODUNI ';
  Result := Result + ' WHERE G.ITE_CODEMP = :CODEMP                       ';
  Result := Result + fStrLocateLinGru(mskLinGru, arrLinGru, 'I.ITE_CODGRU', 'CODGRU');
  Result := Result + fStrLocate(edtCodMar, arrCodMar, 'I.ITE_CODMAR', 'CODMAR');
  Result := Result + fStrLocate(edtPrdGru, arrPrdGru, 'I.ITE_PRDGRU', 'PRDGRU');
  Result := Result + fStrLocate(edtGruCmp, arrGruCmp, 'I.ITE_GRUCMP', 'GRUCMP');
  Result := Result + fStrLocate(edtCodFor, arrCodFor, 'I.ITE_CODFOR', 'CODFOR');
  Result := Result + fStrLocate(edtCodUni, arrCodUni, 'I.ITE_CODUNI', 'CODUNI');

  If fCfgSIs('TIPABF') = '1' Then
    Result := Result + fStrLocate(edtCodAbr, arrCodAbr, 'I.ITE_CODABF', 'CODABF')
  Else
    Result := Result + fStrLocate(edtCodAbr, arrCodAbr, 'G.ITE_CODABF', 'CODABF');

  If Not fEmptyStr(edtDesIte.Text) Then
    Result := Result + ' AND I.ITE_DESITE LIKE :DESITE ';

  If Not fEmptyStr(edtRefere.Text) Then
    Result := Result + ' AND I.ITE_REFERE LIKE :REFERE ';

  If Not fEmptyStr(edtClaIPI.Text) Then
    Result := Result + ' AND LEFT(I.ITE_CLAIPI,'+IntToStr(Length(edtClaIPI.Text))+') = :CLAIPI ';

  If Not fEmptyStr(edtExcIpi.Text) Then
    Result := Result + ' AND I.ITE_EXCIPI = :EXCIPI ';

  If (Pos(edtStatus.Text, 'SN') > 0) Then
    Result := Result + ' AND I.ITE_ITEATI = :ITEATI ';

  If Not fEmptyStr(cmbGiroEstoque.Text) then
    Result := Result + ' AND I.ITE_NVLGIR = :NVLGIR ';

  Result := Result + ' ORDER BY I.ITE_DESITE ';

end;

function TfrmManutencaoEmpresaCentralizadora.fGetSQLEmpresas(strCodEmp: String = ''): String;
begin
  Result := '';
  Result := Result + 'SELECT  EMP_CODEMP ';
  Result := Result + '       ,EMP_NOMEMP ';
  If fEmptyStr(strCodEmp) Then
  Begin
    Result := Result + '       ,EMP_CODEMP AS EMP_CODCEN ';
    Result := Result + '       ,EMP_NOMEMP AS EMP_DESCEN ';
  End;
  Result := Result + '       ,0 AS EMP_SEQUEN ';
  Result := Result + '  FROM CADEMP ';
  If fEmptyStr(strCodEmp) Then
    Result := Result + ' WHERE FALSE '
  Else
    Result := Result + ' WHERE EMP_CODEMP = "'+ strCodEmp + '"';
end;

function TfrmManutencaoEmpresaCentralizadora.fGravaProgresso(
  cxProgress: TCxProgressBar): Boolean;
  procedure pPreparaUpdate;
  Begin
    If (cdsEmpresas.FieldByName('EMP_CODEMP').AsString <> '') Then
    Begin

      qryUpdate.SQL.Add('UPDATE ITEGER SET ');
      If cdsEmpresas.FieldByName('EMP_CODCEN').AsString <> '' Then
      begin
        qryUpdate.SQL.Add('       ITE_CPRCEN = "S", ');
        qryUpdate.SQL.Add('       ITE_EMPCEN = "' + cdsEmpresas.FieldByName('EMP_CODCEN').AsString + '"');
      End
      Else
      Begin
        qryUpdate.SQL.Add('       ITE_CPRCEN = "N", ');
        qryUpdate.SQL.Add('       ITE_EMPCEN = NULL');
      End;
      qryUpdate.SQL.Add(' WHERE ITE_CODEMP = "' + cdsEmpresas.FieldByName('EMP_CODEMP').AsString + '"');
      qryUpdate.SQL.Add('   AND ITE_CODITE = "' + cdsCadIte.FieldByName('CODITE').AsString + '";');

    End;
  End;
begin
  cdsCadIte.DisableControls;
  cdsCadIte.Filtered := False;
  cdsCadIte.Filter := 'SIMNAO = 1';
  cdsCadIte.Filtered := True;

  Try
    cdsCadIte.First;
    cxProgress.Properties.Max := cdsCadIte.RecordCount;
    While Not cdsCadIte.Eof Do
    Begin
      cdsEmpresas.First;
      While not cdsEmpresas.Eof Do
      Begin
        pPreparaUpdate;
        cdsEmpresas.Next;
      End;
      If Not fEmptyStr(qryUpdate.SQL.Text) Then
      Begin
        qryUpdate.ExecSQL;
        qryUpdate.SQL.Clear;
      End;

      cxProgress.Position := cxProgress.Position  + 1;
      cdsCadIte.Next;

    End;
    Result := True;
    fMensagem('', 'Gravação concluída', ['&Ok']);
    pControlaNavegacao(taInicio);
  Finally
    cdsCadIte.Filtered := False;
    cdsCadIte.EnableControls;
  End;
end;

procedure TfrmManutencaoEmpresaCentralizadora.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrLinGru) Then
  Begin
    if fValidaCampos(mskLinGru, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutencaoEmpresaCentralizadora.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrCodMar) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutencaoEmpresaCentralizadora.edtPrdGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrPrdGru) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutencaoEmpresaCentralizadora.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmManutencaoEmpresaCentralizadora.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrCodFor) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutencaoEmpresaCentralizadora.edtCodAbrKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqAbrevFiscal(Self, edtCodAbr, edtDesAbr, Nil, Key, arrCodAbr) Then
  Begin
    If fValidaCampos(edtCodAbr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutencaoEmpresaCentralizadora.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqUnidade(Self, edtCodUni, nil, nil, nil, Key, arrCodUni) Then
  Begin
    If fvalidaCampos(edtCodUni,False) then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.
