unit untCadComboProdVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Vcl.CheckLst, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Uni, untComboProdVenda, cxLabel, cxGridDBTableView,
  cxImageComboBox, System.ImageList, Vcl.ImgList, dxGDIPlusClasses,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList;

type
  TfrmCadComboProdVenda = class(TfrmPaiCad)
    pnlFundo: TPanel;
    pnlProdut: TPanel;
    pnlProGer: TPanel;
    cxgProAti: TcxGridCitel;
    cxGridDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    CODITEA: TcxGridDBBandedColumn;
    DESITEA: TcxGridDBBandedColumn;
    REFEREA: TcxGridDBBandedColumn;
    SIGUNIA: TcxGridDBBandedColumn;
    QTDITEA: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    pnlProCom: TPanel;
    pnlTopo: TPanel;
    Panel2: TPanel;
    clbEmpresa: TCheckListBox;
    Panel4: TPanel;
    pnlCabRig: TPanel;
    pnlCabeça: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCodCom: TDBEditFocus;
    dbeDesCom: TDBEditFocus;
    dbeDtaIni: TDBEditFocus;
    dbeDtaFin: TDBEditFocus;
    dtsProAti: TDataSource;
    dtsComVen: TDataSource;
    dtsProCom: TDataSource;
    lblTabPreco: TLabel;
    clbTabPre: TCheckListBox;
    pnlRodape: TPanel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    Label4: TLabel;
    Panel1: TPanel;
    Label5: TLabel;
    cxStyleRepository3: TcxStyleRepository;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxgProCom: TcxGridCitel;
    cxgProComDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    CODITEC: TcxGridDBBandedColumn;
    DESITEC: TcxGridDBBandedColumn;
    REFEREC: TcxGridDBBandedColumn;
    SIGUNIC: TcxGridDBBandedColumn;
    QTDITEC: TcxGridDBBandedColumn;
    BRINDEC: TcxGridDBBandedColumn;
    TABPREC: TcxGridDBBandedColumn;
    OPERADC: TcxGridDBBandedColumn;
    TIPDESC: TcxGridDBBandedColumn;
    VALDESC: TcxGridDBBandedColumn;
    cxgProComLevel1: TcxGridLevel;
    cxgProSim: TcxGridCitel;
    cxGridDBBandedTableViewCitel2: TcxGridDBBandedTableViewCitel;
    cxGridDBBandedColumn1: TcxGridDBBandedColumn;
    cxGridDBBandedColumn2: TcxGridDBBandedColumn;
    cxGridDBBandedColumn3: TcxGridDBBandedColumn;
    cxGridDBBandedColumn4: TcxGridDBBandedColumn;
    cxGridLevel2: TcxGridLevel;
    Panel3: TPanel;
    btnProCom: TBitBtnLocked;
    btnProSim: TBitBtnLocked;
    dtsProSim: TDataSource;
    Panel5: TPanel;
    Panel6: TPanel;
    btnProAti: TBitBtnLocked;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    cxgElemenLevel1: TcxGridLevel;
    cxgElemen: TcxGridCitel;
    Panel13: TPanel;
    Panel14: TPanel;
    btnMarTod: TBitBtnLocked;
    btnDesTod: TBitBtnLocked;
    dtsElemen: TDataSource;
    cxgElemenDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    DESELE: TcxGridDBBandedColumn;
    Label6: TLabel;
    TEMREG: TcxGridDBBandedColumn;
    cxImageList1: TcxImageList;
    btnInsEle: TBitBtnLocked;
    pnlLegEle: TPanel;
    Image1: TImage;
    Label7: TLabel;
    Image2: TImage;
    Label8: TLabel;
    btnHeranca: TBitBtnLocked;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnProAtiClick(Sender: TObject);
    procedure btnProComClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure clbTabPreDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure clbTabPreClickCheck(Sender: TObject);
    procedure cxGridDBBandedTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure cxgProComDBBandedTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnProSimClick(Sender: TObject);
    procedure cxGridDBBandedTableViewCitel2KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnMarTodClick(Sender: TObject);
    procedure btnDesTodClick(Sender: TObject);
    procedure btnInsEleClick(Sender: TObject);
    procedure cxGridDBBandedTableViewCitel1DblClick(Sender: TObject);
    procedure cxgProComDBBandedTableViewCitel1DblClick(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure cxgElemenDBBandedTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure clbEmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clbTabPreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    objComVen: TComVen;
    procedure pControlaFocoGrids;
    function  fValidaCamposCabecalho: Boolean;
    function  fValidaCamposGeral: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples, untTypesSistema, untHerancaCombo;

procedure TfrmCadComboProdVenda.btnProAtiClick(Sender: TObject);
begin
  inherited;
  If (Not fValidaCamposCabecalho) Then
    Exit;

  objComVen.setTipPro(pcoAtivacao);
  objComVen.setTabPre(clbTabPre);
  objComVen.setEmpresas(clbEmpresa);
  objComVen.setTabPre(objComVen.fRetornaTabelasSelecionadas(clbTabPre));
  objComVen.setDtaIni(strToDateDef(dbeDtaIni.Text, 0));
  objComVen.setDtaFin(strToDateDef(dbeDtaFin.Text, 0));

  If (objComVen.fAbreFiltroProduto) Then
  Begin
    objComVen.pMostraProdutosJaExistentesOutroCombo;
    pSetFocus(cxgProAti);
  End;
end;

procedure TfrmCadComboProdVenda.btnProComClick(Sender: TObject);
begin
  inherited;
  If (Not fValidaCamposCabecalho) Then
    Exit;

  If (Not objComVen.fExisteProdutosAtivacao) Then
  Begin
    fMensagem('ATENÇÃO!', 'Favor inserir o Produto de Ativação antes de inserir os Produtos do Combo!', ['&O k']);
    Exit;
  End;

  objComVen.setTipPro(pcoCombo);

  If (objComVen.fAbreFiltroProduto) Then
    pSetFocus(cxgProAti);
end;

procedure TfrmCadComboProdVenda.btnProSimClick(Sender: TObject);
begin
  inherited;
  If (Not fValidaCamposCabecalho) Then
    Exit;

  If (Not objComVen.fExisteProdutosCombo) Then
  Begin
    fMensagem('ATENÇÃO!', 'Favor inserir o Produto do Combo antes de inserir os Produtos Similares!', ['&O k']);
    Exit;
  End;

  objComVen.setTipPro(pcoSimilar);

  If (objComVen.fAbreFiltroProduto) Then
    pSetFocus(cxgProCom);
end;

procedure TfrmCadComboProdVenda.clbEmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    pSetFocus(dbeDesCom);
end;

procedure TfrmCadComboProdVenda.clbTabPreClickCheck(Sender: TObject);
begin
  inherited;
  objComVen.setTabPre(clbTabPre);
  objComVen.pDesmarcaTabelaPrecoNaoUtilizada;
end;

procedure TfrmCadComboProdVenda.clbTabPreDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
Var
  Flags: Longint;
begin
  inherited;
  With TCheckListBox(Control) Do
  Begin
    If VS_strTabVen[Succ(Index)] <> 'S' Then
      Canvas.Font.Color  := clSilver;

//  Canvas.Brush.Color := clWhite;
    Canvas.FillRect(Rect);

    Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);

    If Not UseRightToLeftAlignment then
      Inc(Rect.Left, 2)
    Else
      Dec(Rect.Right, 2);

    DrawText(Canvas.Handle, pWideChar(Items[Index]), Length(Items[Index]), Rect, Flags);
  End;
end;

procedure TfrmCadComboProdVenda.clbTabPreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    pSetFocus(dbeDesCom);
end;

procedure TfrmCadComboProdVenda.cxgElemenDBBandedTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    pSetFocus(dbeDesCom);
end;

procedure TfrmCadComboProdVenda.cxgProComDBBandedTableViewCitel1DblClick(
  Sender: TObject);
begin
  inherited;
  objComVen.pAlterarDadosProdutoCombo;
end;

procedure TfrmCadComboProdVenda.cxgProComDBBandedTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    objComVen.setTipPro(pcoCombo);
    objComVen.pApagaRegistro;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    objComVen.pAlterarDadosProdutoCombo;
  End
  Else If (Key = VK_ESCAPE) Then
    pSetFocus(dbeDesCom);
end;

procedure TfrmCadComboProdVenda.cxGridDBBandedTableViewCitel1DblClick(
  Sender: TObject);
begin
  inherited;
  objComVen.pAlterarDadosProdutoAtivacao;
end;

procedure TfrmCadComboProdVenda.cxGridDBBandedTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    objComVen.setTipPro(pcoAtivacao);
    objComVen.pApagaRegistro;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    objComVen.pAlterarDadosProdutoAtivacao;
  End
  Else If (Key = VK_ESCAPE) Then
    pSetFocus(dbeDesCom);


end;

procedure TfrmCadComboProdVenda.cxGridDBBandedTableViewCitel2KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    objComVen.setTipPro(pcoSimilar);
    objComVen.pApagaRegistro;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não existe dados para serem alterados nos Produtos Similares.' + #13#10 + 'Caso queira excluir o Produto, pressione DELETE.' , ['&O k']);
  End
  Else If (Key = VK_ESCAPE) Then
    pSetFocus(dbeDesCom);
end;

procedure TfrmCadComboProdVenda.btnMarTodClick(Sender: TObject);
begin
  inherited;
  If (Not pnlFundo.Enabled) Then
    Exit;

  objComVen.setEmpresas(clbEmpresa);
  objComVen.pMarcaTodasEmpresas;
end;

procedure TfrmCadComboProdVenda.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pnlFundo.Enabled := True;
  pHabilitaCodigo(dbeCodCom, dbeDesCom, False);
  objComVen.setIncAti(1);
end;

procedure TfrmCadComboProdVenda.btnCancelaClick(Sender: TObject);
begin
  inherited;
  objComVen.setTabPre(qryTabela.FieldByName('COM_TABPRE').AsString);
  objComVen.setAutInc(qryTabela.FieldByName('AUTOINCREM').AsString);
  objComVen.pCarregaDadosAlteracao;
  pnlFundo.Enabled   := False;
  btnHeranca.Enabled := False;
end;

procedure TfrmCadComboProdVenda.btnDesTodClick(Sender: TObject);
begin
  inherited;
  If (Not pnlFundo.Enabled) Then
    Exit;

  objComVen.setEmpresas(clbEmpresa);
  objComVen.pDesmarcaTodasEmpresas;
end;

procedure TfrmCadComboProdVenda.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadComboProdVenda.btnExcluirClick]');
    End;
  End;

  If (blnExcluiu) Then
  Begin
    fCommit;
    pnlFundo.Enabled := False;
    objComVen.pCarregaDadosAlteracao;
  End
  Else
    fRollBack;

end;

procedure TfrmCadComboProdVenda.btnGravarClick(Sender: TObject);
begin
  If (Not pnlFundo.Enabled) or (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If (Not fValidaCamposGeral) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('COM_TABPRE').AsString := objComVen.fRetornaTabelasSelecionadas(clbTabPre);

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadComboProdVenda.btnGravarClick]');
    End;
  End;


  If (blnGravou) Then
  Begin
    objComVen.setAutInc(qryTabela.FieldByName('AUTOINCREM').AsString);
    objComVen.setEmpresas(clbEmpresa);

    If (objComVen.fGravar) Then
    Begin
      fCommit;
      pnlFundo.Enabled   := False;
      btnHeranca.Enabled := False;
      fMensagem('', 'Combo de Produtos para Venda gravado com sucesso!', ['&O k']);
    End
    Else
      fRollBack;
  End
  Else
    fRollBack;

end;

procedure TfrmCadComboProdVenda.btnHerancaClick(Sender: TObject);
begin
  inherited;
  If (objComVen.fHerdarCombo) Then
  Begin
    qryTabela.FieldByName('COM_DESCOM').AsString   := objComVen.qryHeranc.FieldByName('COM_DESCOM').AsString;
    qryTabela.FieldByName('COM_DTAINI').AsDateTime := objComVen.qryHeranc.FieldByName('COM_DTAINI').AsDateTime;
    qryTabela.FieldByName('COM_DTAFIN').AsDateTime := objComVen.qryHeranc.FieldByName('COM_DTAFIN').AsDateTime;

    objComVen.setAutInc(objComVen.qryHeranc.FieldByName('AUTOINCREM').AsString);
    objComVen.setTabPre(objComVen.qryHeranc.FieldByName('COM_TABPRE').AsString);
    objComVen.setTabPre(clbTabPre);
    objComVen.pCarregaDadosAlteracao;
    objComVen.setAutInc('');
  End;
end;

procedure TfrmCadComboProdVenda.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pnlFundo.Enabled := True;
  pHabilitaCodigo(dbeCodCom, dbeDesCom, False);
  objComVen.setAutInc(qryTabela.FieldByName('AUTOINCREM').AsString);
  objComVen.setIncAti(1);
  objComVen.pValorDefault;
  objComVen.pMarcaTodasTabelasPrecos;
  btnHeranca.Enabled := True;
end;

procedure TfrmCadComboProdVenda.btnInsEleClick(Sender: TObject);
begin
  inherited;
  If (Not fValidaCamposCabecalho) Then
    Exit;

  objComVen.pAjustaElementos;
end;

procedure TfrmCadComboProdVenda.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCombos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  chrKey := '/';
  If fPesqComboVenda(Self, dbeCodCom, Nil, qryTabela, chrKey, arrCombos) Then
  Begin
    objComVen.setAutInc(qryTabela.FieldByName('AUTOINCREM').AsString);
    objComVen.setTabPre(qryTabela.FieldByName('COM_TABPRE').AsString);
    objComVen.setTabPre(clbTabPre);
    objComVen.pCarregaDadosAlteracao;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadComboProdVenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(objComVen);
  End;
end;

procedure TfrmCadComboProdVenda.FormCreate(Sender: TObject);
begin
  inherited;
  objComVen := TComVen.Create(Self);

  strNomeTabela := 'COMVEN';
  strNomeCampo  := 'COM_CODCOM';

  qryTabela             := objComVen.getQueryComVen;
  dtsComVen.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCom;
End;

procedure TfrmCadComboProdVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F3) Then
    pControlaFocoGrids
  Else If (Key = VK_F5) Then
    btnProAti.Click
  Else If (Key = VK_F6) Then
    btnProCom.Click
  Else If (Key = VK_F7) Then
    btnProSim.Click
  Else If (Key = VK_F8) Then
    btnInsEle.Click
  Else If (Key = VK_F11) Then
    btnMarTod.Click
  Else If (Key = VK_F12) Then
    btnDesTod.Click
  Else If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl Is TCheckListBox) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComboProdVenda.FormShow(Sender: TObject);
begin
  inherited;
  pnlFundo.Enabled := False;
  objComVen.setEmpresas(clbEmpresa);
  objComVen.setTabPre(clbTabPre);
  objComVen.pValorDeFault;
  dtsProAti.DataSet := objComVen.getCdsProAti;
  dtsProCom.DataSet := objComVen.getCdsProCom;
  dtsProSim.DataSet := objComVen.getCdsProSim;
  dtsElemen.DataSet := objComVen.getCdsElemen;
end;

function TfrmCadComboProdVenda.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDesCom) Then
    Begin
      If (fEmptyStr(dbeDesCom.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Combo deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDtaIni) Then
    Begin
      If (fEmptyDate(dbeDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial da Validade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (Not fValidaDataStr(dbeDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial informada é inválida!', ['&O k']);
        Result := False;
      End
      Else If (qryTabela.State = dsInsert) And (StrToDateDef(dbeDtaIni.Text, 0) < VS_DATE) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser menor que a data atual!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDtaFin) Then
    Begin
      If (fEmptyDate(dbeDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final da Validade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (Not fValidaDataStr(dbeDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final informada é inválida!', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyDate(dbeDtaIni.Text) And
               Not fEmptyDate(dbeDtaIni.Text) And
               Not fValidaPeriodo(dbeDtaIni.Text, dbeDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = clbEmpresa) Then
    Begin
      objComVen.setEmpresas(clbEmpresa);
      If (Not objComVen.fSelecionouEmpresa) Then
      Begin
        fMensagem('ATENÇÃO!', 'Favor selecionar uma ou mais Empresas!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCadComboProdVenda.fValidaCamposCabecalho: Boolean;
begin
  Result := True;

  If (Not pnlFundo.Enabled) Or (Not fVerificaCampos) Or (Not fValidaCampos(clbEmpresa, True)) Then
    Result := False;
end;

function TfrmCadComboProdVenda.fValidaCamposGeral: Boolean;
begin
  Result := fValidaCamposCabecalho;

  If (Result) Then
  Begin
    Result := objComVen.fExisteProdutosAtivacao;

    If (Not Result) Then
      fMensagem('ATENÇÃO!', 'Favor inserir pelo menos um Produto de Ativação' + #13#10 + 'antes de realizar a gravação.', ['&O k']);
  End;

  If (Result) Then
  Begin
    Result := objComVen.fTodosProdutosAtivacaoTemProdutoCombo;

    If (Not Result) Then
      fMensagem('ATENÇÃO!', 'Existem Produtos de Ativação sem Produtos do Combo vinculados.' + #13#10 + 'Favor informar os Produtos do Combo para cada Produto de Ativação' + #13#10 + 'antes de realizar a gravação.', ['&O k']);
  End;

  If (Result) Then
  Begin
    objComVen.setDtaIni(strToDateDef(dbeDtaIni.Text, 0));
    objComVen.setDtaFin(strToDateDef(dbeDtaFin.Text, 0));
    objComVen.setEmpresas(clbEmpresa);
    objComVen.setTabPre(clbTabPre);
    objComVen.setTabPre(objComVen.fRetornaTabelasSelecionadas(clbTabPre));

    Result := objComVen.fValidaProdutoOutroComboVigente;
  End;

end;

procedure TfrmCadComboProdVenda.pControlaFocoGrids;
begin
  If (cxgProAti.IsFocused) Then
  Begin
    If (objComVen.fExisteProdutosCombo) Then
      pSetFocus(cxgProCom)
    Else If (objComVen.fExisteProdutosSimilares) Then
      pSetFocus(cxgProSim)
    Else
      pSetFocus(cxgElemen);
  End
  Else If (cxgProCom.IsFocused) Then
  Begin
    If (objComVen.fExisteProdutosSimilares) Then
      pSetFocus(cxgProSim)
    Else
      pSetFocus(cxgElemen);
  End
  Else If (cxgProSim.IsFocused) Then
  Begin
    pSetFocus(cxgElemen)
  End
  Else If (cxgElemen.IsFocused) Then
  Begin
    If (objComVen.fExisteProdutosAtivacao) Then
      pSetFocus(cxgProAti)
    Else If (objComVen.fExisteProdutosCombo) Then
      pSetFocus(cxgProCom)
    Else If (objComVen.fExisteProdutosSimilares) Then
      pSetFocus(cxgProSim);
  End
  Else
  Begin
    If (objComVen.fExisteProdutosAtivacao) Then
      pSetFocus(cxgProAti)
    Else
      pSetFocus(cxgElemen);
  End;

end;

procedure TfrmCadComboProdVenda.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COM_CODCOM');
  stlCampos.Add('COM_DESCOM');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COM_CODCOM');
  stlCamInd.Add('COM_DESCOM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

end.
