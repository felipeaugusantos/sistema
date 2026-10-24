unit untCadPromocaoBrindes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Grids, DBGridCitel, DBGrids, Mask, MaskEditFocus, StdCtrls,
  EditFocus, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls, DBEditFocus, DB,
  CheckLst, Uni, StrUtils, untSeqTmp, AppEvnts, UniClientDataSet, Provider,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  untModulo, MaskUtils, BitBtnLockedIncrem, cxProgressBar, untZClient,
  ComboBoxFocus, DBComboBoxFocus, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, UniDataSetProvider, MemDS, DBAccess,
  untGravando, untPromocaoBrindes,
  frxClass, frxExportCSVTestabilidade, cxGridBandedTableView,
  cxGridDBBandedTableView, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog;

Type
  TfrmCadPromocaoBrindes = class(TfrmPaiCad)
    btnHeranca: TBitBtnLocked;
    pnlGrid: TPanel;
    pnlClient: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeCodPro: TDBEditFocus;
    dbeDesPro: TDBEditFocus;
    dbeDtaIni: TDBEditFocus;
    dbeDtaFin: TDBEditFocus;
    pnlGridVenda: TPanel;
    pnlGridBrinde: TPanel;
    cxgItensVenda: TcxGrid;
    cxgItensVendaView: TcxGridDBBandedTableView;
    cxgItensVendaViewColumn1: TcxGridDBBandedColumn;
    cxgItensVendaViewColumn2: TcxGridDBBandedColumn;
    cxgItensVendaViewColumn3: TcxGridDBBandedColumn;
    cxgItensVendaViewColumn4: TcxGridDBBandedColumn;
    cxgItensVendaViewColumn5: TcxGridDBBandedColumn;
    cxgItensVendaLevel: TcxGridLevel;
    Panel1: TPanel;
    Panel2: TPanel;
    btnAdicionarProdutos: TBitBtnLocked;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel5: TPanel;
    Panel9: TPanel;
    cxgItensBrinde: TcxGrid;
    cxgItensBrindeView: TcxGridDBBandedTableView;
    cxGridDBBandedColumn1: TcxGridDBBandedColumn;
    cxGridDBBandedColumn2: TcxGridDBBandedColumn;
    cxGridDBBandedColumn3: TcxGridDBBandedColumn;
    cxGridDBBandedColumn4: TcxGridDBBandedColumn;
    cxGridDBBandedColumn5: TcxGridDBBandedColumn;
    cxgItensBrindeLevel: TcxGridLevel;
    Label4: TLabel;
    dbePonAcu: TDBEditFocus;
    lblInfPonAcu: TLabel;
    btnAdicionarBrindes: TBitBtnLocked;
    Label6: TLabel;
    Label3: TLabel;
    pnlTabelasEmpresa: TPanel;
    pnlEmpresa: TPanel;
    clbEmpresa: TCheckListBox;
    Panel3: TPanel;
    Label16: TLabel;
    pnlTabelas: TPanel;
    clbTabPre: TCheckListBox;
    Panel4: TPanel;
    lblTabPreco: TLabel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Bevel2: TBevel;
    dtsTabela: TDataSource;
    btnAlterarProduto: TBitBtnLocked;
    btnAlterarBrinde: TBitBtnLocked;
    btnExcluirProdutos: TBitBtnLocked;
    btnExcluirBrindes: TBitBtnLocked;
    Panel13: TPanel;
    btnVisualizarBrindes: TBitBtnLocked;
    Panel14: TPanel;
    btnVisualizarProdutos: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure dbeDtaIniEnter(Sender: TObject);
    procedure dbeDtaFinEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure clbTabPreExit(Sender: TObject);
    procedure clbEmpresaExit(Sender: TObject);
    procedure clbTabPreDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure clbTabPreClickCheck(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnAdicionarProdutosClick(Sender: TObject);
    procedure btnAdicionarBrindesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnVisualizarBrindesClick(Sender: TObject);
    procedure btnVisualizarProdutosClick(Sender: TObject);
    procedure pnlGridVendaEnter(Sender: TObject);
    procedure pnlGridVendaExit(Sender: TObject);
    procedure pnlGridBrindeEnter(Sender: TObject);
    procedure pnlGridBrindeExit(Sender: TObject);
    procedure btnAlterarProdutoClick(Sender: TObject);
    procedure btnAlterarBrindeClick(Sender: TObject);
    procedure btnExcluirProdutosClick(Sender: TObject);
    procedure btnExcluirBrindesClick(Sender: TObject);
    procedure cxgItensVendaViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensBrindeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    objPromocaoBrindes: TPromocaoBrindes;
    procedure pHabilitarBotoesItensVenda(blnHabilitar: Boolean);
    procedure pHabilitarBotoesItensBrinde(blnHabilitar: Boolean);
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pOnStateChange; override;
  public
    { Public declarations }
    strCodIte: String;
  end;

implementation

uses untPai, untFuncoes, untfuncoesSimples, untConsultas,
  untFuncoesConsulta, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmCadPromocaoBrindes.FormActivate(Sender: TObject);
begin
  inherited;
  FormResize(Self);
  pSetFocus(btnIncluir);
end;

procedure TfrmCadPromocaoBrindes.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'PROBRI_GER';
  strNomeCampo  := 'PRO_CODPRO';

  objPromocaoBrindes := TPromocaoBrindes.Create(clbEmpresa, clbTabPre);

  qryTabela := objPromocaoBrindes.qryTabela;

  dtsTabela.Dataset := qryTabela;

  cxgItensVendaView.DataController.DataSource := objPromocaoBrindes.cdsItensVenda.dtsSource;
  cxgItensBrindeView.DataController.DataSource := objPromocaoBrindes.cdsItensBrinde.dtsSource;

  clbTabPre.OnKeyDown  := pOnKeyDownEdits;
  clbEmpresa.OnKeyDown := pOnKeyDownEdits;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPro;
end;

procedure TfrmCadPromocaoBrindes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objPromocaoBrindes);
  inherited;
end;

procedure TfrmCadPromocaoBrindes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3: btnAdicionarProdutos.Click;
    VK_F4: btnAdicionarBrindes.Click;
  End;
end;

procedure TfrmCadPromocaoBrindes.FormResize(Sender: TObject);
begin
  inherited;
  pnlGridVenda.Width  := (Self.Width - 35) Div 2;
  pnlGridBrinde.Width := (Self.Width - 35) Div 2;
end;

procedure TfrmCadPromocaoBrindes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  objPromocaoBrindes.pLimparProdutos;
  objPromocaoBrindes.fCarregaItensVenda;
  objPromocaoBrindes.fCarregaItensBrinde;
end;

procedure TfrmCadPromocaoBrindes.btnExcluirBrindesClick(Sender: TObject);
  Var
    intOpcao: Integer;
begin
  inherited;
  If btnExcluirBrindes.Enabled Then
  Begin
    intOpcao := fMensagem('', 'Deseja excluir o brinde?', ['&Sim', '&Não', '&Todos']);

    Case intOpcao Of
      1: objPromocaoBrindes.pExcluirProdutos(itemBrinde,
           objPromocaoBrindes.cdsItensBrinde.FieldByName('CODBRI').AsString);

      3: objPromocaoBrindes.pExcluirProdutos(itemBrinde);
    End;

    pHabilitarBotoesItensBrinde(True);
    pSetFocus(cxgItensBrinde);
  End;
end;

procedure TfrmCadPromocaoBrindes.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPromocaoBrindes.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadPromocaoBrindes.btnExcluirProdutosClick(Sender: TObject);
  Var
    intOpcao: Integer;
begin
  inherited;
  If btnExcluirProdutos.Enabled Then
  Begin
    intOpcao := fMensagem('', 'Deseja excluir o produto?', ['&Sim', '&Não', '&Todos']);

    Case intOpcao Of
      1: objPromocaoBrindes.pExcluirProdutos(itemVenda,
           objPromocaoBrindes.cdsItensVenda.FieldByName('CODITE').AsString);

      3: objPromocaoBrindes.pExcluirProdutos(itemVenda);
    End;

    pHabilitarBotoesItensVenda(True);
    pSetFocus(cxgItensVenda);
  End;
end;

procedure TfrmCadPromocaoBrindes.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrPromocoes: TConsultasArray;
begin
  chrKey := '/';
  If fPesqPromocoesBrindes(Self, Nil, Nil, qryTabela, chrKey, arrPromocoes) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadPromocaoBrindes.btnVisualizarBrindesClick(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgItensBrinde);
end;

procedure TfrmCadPromocaoBrindes.btnVisualizarProdutosClick(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgItensVenda);
end;

function TfrmCadPromocaoBrindes.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDesPro) Then
    Begin

      If (fEmptyStr(dbeDesPro.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição da promoção deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = dbeDtaIni) Then
    Begin

      If (dbeDtaIni.Enabled) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(dbeDtaIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'A data da inicial deve ser preenchida!', ['&OK']);
          Result := False;
        End
        Else If (qryTabela.State = dsInsert) And (StrToDate(dbeDtaIni.Text) < VS_Date) Then
        Begin
          fMensagem('ATENÇÃO', 'A data da inicial deve ser Maior ou igual a data atual!', ['&O K']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dbeDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(dbeDtaIni.Text, dbeDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = dbePonAcu) Then
    Begin
      If fStrToFloat(dbePonAcu.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A quantidade de pontos acumulados deve ser maior que zero!', ['&O K']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadPromocaoBrindes.pEscapePressed;
begin
  inherited;
end;

procedure TfrmCadPromocaoBrindes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodPro, dbeDesPro, False);
end;

procedure TfrmCadPromocaoBrindes.btnAdicionarBrindesClick(Sender: TObject);
begin
  inherited;
  If btnAdicionarBrindes.Enabled Then
  Begin
    objPromocaoBrindes.pAdicionaItem(itemBrinde);
    pHabilitarBotoesItensBrinde(True);
    pSetFocus(cxgItensBrinde);
  End;
end;

procedure TfrmCadPromocaoBrindes.btnAdicionarProdutosClick(Sender: TObject);
begin
  inherited;
  If btnAdicionarProdutos.Enabled Then
  Begin
    objPromocaoBrindes.pAdicionaItem(itemVenda);
    pHabilitarBotoesItensVenda(True);
    pSetFocus(cxgItensVenda);
  End;
end;

procedure TfrmCadPromocaoBrindes.btnAlterarBrindeClick(Sender: TObject);
begin
  inherited;
  If btnAlterarBrinde.Enabled Then
  Begin
    objPromocaoBrindes.pAdicionaItem(itemBrinde,
      objPromocaoBrindes.cdsItensBrinde.FieldByName('CODBRI').AsString);
    pHabilitarBotoesItensBrinde(True);
    pSetFocus(cxgItensBrinde);
  End;
end;

procedure TfrmCadPromocaoBrindes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodPro, dbeDesPro, False);
end;

procedure TfrmCadPromocaoBrindes.btnAlterarProdutoClick(Sender: TObject);
begin
  inherited;
  If btnAlterarProduto.Enabled Then
  Begin
    objPromocaoBrindes.pAdicionaItem(itemVenda,
      objPromocaoBrindes.cdsItensVenda.FieldByName('CODITE').AsString);
    pHabilitarBotoesItensVenda(True);
    pSetFocus(cxgItensVenda);
  End;
end;

procedure TfrmCadPromocaoBrindes.btnGravarClick(Sender: TObject);
begin
  If fVerificaCampos And objPromocaoBrindes.fGravarPromocao Then
  Begin
    pSetButton(qryTabela, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisa, btnSair);
    pOnStateChange;
    pEnabled(Self, False);
    pSetFocus(btnIncluir);
  End;
end;

procedure TfrmCadPromocaoBrindes.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

procedure TfrmCadPromocaoBrindes.pnlGridBrindeEnter(Sender: TObject);
begin
  inherited;
  pHabilitarBotoesItensBrinde(True);
end;

procedure TfrmCadPromocaoBrindes.pnlGridBrindeExit(Sender: TObject);
begin
  inherited;
  pHabilitarBotoesItensBrinde(False);
end;

procedure TfrmCadPromocaoBrindes.pnlGridVendaEnter(Sender: TObject);
begin
  inherited;
  pHabilitarBotoesItensVenda(True);
end;

procedure TfrmCadPromocaoBrindes.pnlGridVendaExit(Sender: TObject);
begin
  inherited;
  pHabilitarBotoesItensVenda(False);
end;

procedure TfrmCadPromocaoBrindes.FormShow(Sender: TObject);
begin
  inherited;
  pOnStateChange;

  pSetaCodIte( dbeCodPro );

end;

procedure TfrmCadPromocaoBrindes.clbTabPreClickCheck(Sender: TObject);
Var
  intTab: Integer;
begin
  inherited;
  For intTab := 1 To clbTabPre.Items.Count Do
    If VS_strTabVen[intTab] <> 'S' Then
      clbTabPre.Checked[Pred(intTab)] := False;
end;

procedure TfrmCadPromocaoBrindes.clbTabPreDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
Var
  Flags: Longint;
begin
  With TCheckListBox(Control) Do
  Begin
    If VS_strTabVen[Succ(Index)] <> 'S' Then
      Canvas.Font.Color := clSilver;

    Canvas.FillRect(Rect);

    Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);

    If Not UseRightToLeftAlignment then
      Inc(Rect.Left, 2)
    Else
      Dec(Rect.Right, 2);

    DrawText(Canvas.Handle, pWideChar(Items[Index]), Length(Items[Index]),
      Rect, Flags);
  End;
end;

procedure TfrmCadPromocaoBrindes.clbTabPreExit(Sender: TObject);
begin
  inherited;
  If Pos('S', objPromocaoBrindes.fGetTabelasPrecoSelecionadas) <= 0 Then
  Begin
    fMensagem('AVISO', 'Selecione ao menos uma tabela de preço para a promoção!', ['&O K']);
    pSetFocus(clbTabPre);
  End;
end;

procedure TfrmCadPromocaoBrindes.cxgItensBrindeViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: btnVisualizarProdutos.Click;
    VK_F2    : btnAlterarBrinde.Click;
    VK_DELETE: btnExcluirBrindes.Click;
    VK_ESCAPE: Self.SelectFirst;
  end;
end;

procedure TfrmCadPromocaoBrindes.cxgItensVendaViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: btnVisualizarBrindes.Click;
    VK_F2    : btnAlterarProduto.Click;
    VK_DELETE: btnExcluirProdutos.Click;
    VK_ESCAPE: Self.SelectFirst;
  end;
end;

procedure TfrmCadPromocaoBrindes.pHabilitarBotoesItensVenda(blnHabilitar: Boolean);
begin
  inherited;
  btnVisualizarBrindes.Enabled := blnHabilitar;
  btnAlterarProduto.Enabled := blnHabilitar And Not objPromocaoBrindes.cdsItensVenda.IsEmpty;
  btnExcluirProdutos.Enabled := blnHabilitar And Not objPromocaoBrindes.cdsItensVenda.IsEmpty;
end;

procedure TfrmCadPromocaoBrindes.pHabilitarBotoesItensBrinde(blnHabilitar: Boolean);
begin
  inherited;
  btnVisualizarProdutos.Enabled := blnHabilitar;
  btnAlterarBrinde.Enabled := blnHabilitar And Not objPromocaoBrindes.cdsItensBrinde.IsEmpty;
  btnExcluirBrindes.Enabled := blnHabilitar And Not objPromocaoBrindes.cdsItensBrinde.IsEmpty;
end;

procedure TfrmCadPromocaoBrindes.clbEmpresaExit(Sender: TObject);
begin
  inherited;
  If objPromocaoBrindes.fGetEmpresasSelecionadas = '' Then
  Begin
    fMensagem('AVISO', 'Selecionar ao menos uma empresa para a promoção!', ['&O K']);
    pSetFocus(clbEmpresa);
  End;
end;

procedure TfrmCadPromocaoBrindes.btnHerancaClick(Sender: TObject);
begin
  inherited;
  If objPromocaoBrindes.fHerancaPromocao Then
    pSetFocus(dbeDesPro);
end;

procedure TfrmCadPromocaoBrindes.dbeDtaIniEnter(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsInsert) Then
    dbeDtaIni.Text := DateToStr(VS_Date);
end;

procedure TfrmCadPromocaoBrindes.dbeDtaFinEnter(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsInsert) Then
    dbeDtaFin.Text := DateToStr(VS_Date);
end;

procedure TfrmCadPromocaoBrindes.pOnStateChange;
begin
  inherited;
  btnHeranca.Enabled := (qryTabela.State In [dsInsert]);
  pnlTabelas.Enabled := (qryTabela.State In [dsInsert, dsEdit]);
  pnlEmpresa.Enabled := (qryTabela.State In [dsInsert, dsEdit]);

  pnlGridVenda.Enabled  := (qryTabela.State In [dsInsert, dsEdit]);
  pnlGridBrinde.Enabled := (qryTabela.State In [dsInsert, dsEdit]);

  btnAdicionarBrindes.Enabled  := (qryTabela.State In [dsInsert, dsEdit]);
  btnAdicionarProdutos.Enabled := (qryTabela.State In [dsInsert, dsEdit]);
end;

end.
