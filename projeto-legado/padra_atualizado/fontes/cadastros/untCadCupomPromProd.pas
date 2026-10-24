unit untCadCupomPromProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, EditFocus, MaskEditFocus, Vcl.CheckLst, Data.DB, MemDS, DBAccess,
  Uni, cxProgressBar, StrUtils, Vcl.Grids, Vcl.DBGrids, DBGridCitel, TypesRel,
  Datasnap.DBClient, UniClientDataSet, QColorLabel, DBLookupComboBoxFocus,
  ComboBoxFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar;

type
  TfrmCadCupomPromProd = class(TfrmPaiCad)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    tbsItens: TTabSheet;
    rdgTipPro: TRadioGroup;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    Label9: TLabel;
    Label11: TLabel;
    lblDescricao: TLabel;
    edtDescriIni: TEditFocus;
    Label8: TLabel;
    edtRefere: TEditFocus;
    Label4: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label13: TLabel;
    edtDescriFin: TEditFocus;
    Label12: TLabel;
    edtUnidade: TEditFocus;
    pnlEmpresa: TPanel;
    Label16: TLabel;
    clbEmpresa: TCheckListBox;
    dtsPromo: TDataSource;
    dbeDtaIni: TDBEditFocus;
    dbeDtaFin: TDBEditFocus;
    dbeCodPro: TDBEditFocus;
    dbeDesPro: TDBEditFocus;
    pnlCabecalho: TPanel;
    pnlItens: TPanel;
    dbeVLCPP1: TDBEditFocus;
    dbeVLCPP2: TDBEditFocus;
    dbeNumCup: TDBEditFocus;
    btnConfirmar: TBitBtnLocked;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    DBGridCitel1: TDBGridCitel;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    btnLimparGrid: TBitBtnLocked;
    dbeTipCli: TDBEditFocus;
    clb3: TColorLabel;
    lbl24: TLabel;
    chkCpcLcs: TDBCheckBox;
    chkAcmVal: TDBCheckBox;
    tabVendedores: TTabSheet;
    pnlVendedores: TPanel;
    Label5: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    Label6: TLabel;
    dbeDescri: TDBMemo;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    Label24: TLabel;
    btnConfirmarVendedor: TBitBtnLocked;
    btnLimparGridVendedores: TBitBtnLocked;
    DBGridCitelVendedores: TDBGridCitel;
    Label7: TLabel;
    cdsVendedores: TUniClientDataSet;
    dtsVendedores: TDataSource;
    cdsVendedoresOPE_CODOPE: TStringField;
    cdsVendedoresOPE_NOMOPE: TStringField;
    cbxTipoOperadores: TComboBoxFocus;
    Label14: TLabel;
    lblLayout: TLabel;
    edtCodLay: TDBEditFocus;
    edtDesLay: TEditFocus;
    ckbTodosItens: TDBCheckBox;
    tabSorteados: TTabSheet;
    pnlSorteados: TPanel;
    lblCupom: TLabel;
    lblDtaSorteio: TLabel;
    edtCupom: TEditFocus;
    mskDtaIni: TcxDateEdit;
    Panel1: TPanel;
    Label15: TLabel;
    lbldataSorteio: TLabel;
    edtCupSorteio: TEditFocus;
    dtaDataSorteio: TcxDateEdit;
    btnSorteio: TBitBtnLocked;
    grdSorteio: TDBGridCitel;
    cdsSorteio: TUniClientDataSet;
    cdsSorteioAUTINC: TStringField;
    cdsSorteioSEQPRO: TStringField;
    cdsSorteioCODEMP: TStringField;
    cdsSorteioCODOPE: TStringField;
    cdsSorteioDTAENT: TDateField;
    cdsSorteioNUMCUP: TStringField;
    cdsSorteioDTASOR: TDateField;
    cdsSorteioNUMDOC: TStringField;
    cdsSorteioESPDOC: TStringField;
    cdsSorteioEMPDOC: TStringField;
    cdsSorteioCODCLI: TStringField;
    cdsSorteioDOCUME: TStringField;
    cdsSorteioCLIENT: TStringField;
    dtsSorteio: TDataSource;
    btnAltDataFin: TBitBtnLocked;
    chkImpCup: TDBCheckBox;
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtsPromoStateChange(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure DBGridCitel1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLimparGridClick(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure btnLimparGridVendedoresClick(Sender: TObject);
    procedure DBGridCitelVendedoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarVendedorClick(Sender: TObject);
    procedure rdgTipProClick(Sender: TObject);
    procedure edtCodLayKeyPress(Sender: TObject; var Key: Char);
    procedure btnSorteioClick(Sender: TObject);
    procedure grdSorteioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAltDataFinClick(Sender: TObject);
  private
    { Private declarations }
    qryCadUni: TUniQuery;
    qryConIte: TUniQuery;

    procedure pCarregaEmpresa;
    procedure pEnableDisablePanel(Panel: TPanel; blnEnabled: Boolean = True);
    procedure pGravarEmpresas(strAutIncPro: String; pgbStatus: TcxProgressBar = Nil);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregaTipoPromocao(strAutInc: string);
    procedure pCarregaEmpresaPromocao(strAutInc: string; pgbProgresso: TcxProgressBar = nil);
    procedure pDesativaEmpresas(strAutInc: String);
    function fCarregaItens(pgbProgresso: TcxProgressBar = nil):Boolean;
    procedure pGravaItens(strAutInc: string; pgbProgresso: TcxProgressBar = nil);
    function fTemEmpresa: boolean;
    function fGravarCupom(pgbProgresso: TcxProgressBar = nil):Boolean;
    function fCarregarCupom(pgbProgresso: TcxProgressBar = nil):Boolean;
    procedure pCarregarCdsItens(qryItens: TUniQuery; pgbProgresso: TcxProgressBar = nil);
    function fValidaPreenchimentoTipoPromocaoQuantidadeFixa: boolean;
    function fValidaPreenchimentoTipoPromocaoValor: boolean;
    function fPreencheuFaixaDeDescricao: boolean;
    procedure pCarregaItensPromocao(strAutInc: string; pgbProgresso: TcxProgressBar = nil);
    procedure pLimpaCAmposItens;
    procedure pIniciaValoresPadrao;

    function fCarregaVendedores(pgbProgresso: TcxProgressBar = nil):Boolean;
    procedure pCarregarCdsVendedores(qryVendedores: TUniQuery; pgbProgresso: TcxProgressBar = nil);
    procedure pLimpaCamposVendedores;
    procedure pCarregaVendedoresPromocao(strAutInc: string; pgbProgresso: TcxProgressBar = nil);
    procedure pGravaVendedores(strAutInc: string; pgbProgresso: TcxProgressBar = nil);
    procedure pHabilitaDesabilitaCheckboxAcumulaValor;
    procedure pValidaCupomSorteio(strNumCup: String; dtaDtaSor: TDate);
    procedure pGravaCupomSorteio(strAutInc: String; pgbProgresso: TcxProgressBar = nil);
    procedure pCarregaCuponsSorteados(strAutInc: String; pgbProgresso: TcxProgressBar = nil);
  protected
    procedure pInicializaIndices; override;
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema, untTipoOperadores, untFuncoes,
  untDigDataPeriodo;

{$R *.dfm}

procedure TfrmCadCupomPromProd.btnAltDataFinClick(Sender: TObject);
var
  LDtaIni,
  LDtaFin: TDateTime;
  LQry: TUniQuery;
  LDigDataPeriodo: TfrmDigDataPeriodo;
begin
  LQry := fCriaQuery;
  pCriarFormularios(TfrmDigDataPeriodo, LDigDataPeriodo);

  try
    LDigDataPeriodo.Caption := 'Informe o novo Período da Promoção';
    LDigDataPeriodo.lblDtaIni.Caption := 'Data Inicial';
    LDigDataPeriodo.lblDtaFin.Caption := 'Data Final';

    try
      LDigDataPeriodo.dtaDtaIni.Date := qryTabela.FieldByName('CPP_DTAINI').AsDateTime;
    except
      LDigDataPeriodo.dtaDtaIni.Date := VS_Date;
    end;

    try
      LDigDataPeriodo.dtaDtaFin.Date := qryTabela.FieldByName('CPP_DTAFIN').AsDateTime;
    except
      LDigDataPeriodo.dtaDtaFin.Date := VS_Date;
    end;

    if (LDigDataPeriodo.ShowModal = mrOk) then
    begin
      LDtaIni := LDigDataPeriodo.dtaDtaIni.Date;
      LDtaFin := LDigDataPeriodo.dtaDtaFin.Date;

      try
        fStartTransaction;
        LQry.SQL.Add('UPDATE CADCPP ');
        LQry.SQL.Add('SET CPP_DTAINI = :DTAINI, ');
        LQry.SQL.Add('    CPP_DTAFIN = :DTAFIN  ');
        LQry.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
        LQry.ParamByName('DTAINI').AsDateTime := LDtaIni;
        LQry.ParamByName('DTAFIN').AsDateTime := LDtaFin;
        LQry.ParamByName('AUTINC').AsString   := qryTabela.FieldByName('AUTOINCREM').AsString;;
        LQry.ExecSQL;
        fCommit;
      except
        on E: Exception Do
        begin
          fRollBack;
          pMensagensErro(E.Message, '[untCadCupomPromProd.btnAltDataFinClick]');
        end;
      end;
    end;
  finally
    pFreeAndNil(LDigDataPeriodo);
    FreeAndNil(LQry);
    qryTabela.Close;
    qryTabela.Open;
  end;
end;

procedure TfrmCadCupomPromProd.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodPro, dbeDesPro, False);
  rdgTipPro.Enabled := True;
  pHabilitaDesabilitaCheckboxAcumulaValor;
  chkAcmVal.Enabled := rdgTipPro.Enabled;
end;

procedure TfrmCadCupomPromProd.btnCancelaClick(Sender: TObject);
begin
  inherited;

  if (not fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) then
    fCarregarCupom;
end;

procedure TfrmCadCupomPromProd.btnLimparGridVendedoresClick(Sender: TObject);
begin
  inherited;
  cdsVendedores.EmptyDataSet;
end;

procedure TfrmCadCupomPromProd.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fCarregaItens, 'Adicionando itens, por favor, aguarde...');
  pLimpaCAmposItens;
end;

procedure TfrmCadCupomPromProd.btnConfirmarVendedorClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fCarregaVendedores, 'Adicionando vendedores, por favor, aguarde...');
  pLimpaCamposVendedores;
end;

procedure TfrmCadCupomPromProd.btnExcluirClick(Sender: TObject);
var
  strAutInc: string;
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  strAutInc := qryTabela.FieldByName('AUTOINCREM').AsString;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCupomPromProd.btnExcluirClick]');
    End;
  End;

  if blnExcluiu then
  begin
    fCommit;
    pDesativaEmpresas(strAutInc);
    rdgTipPro.ItemIndex := 0;
    pLimparCampos;
    dbeCodPro.Clear;
    dbeDescri.Clear;
    mskLinhaGrupo.Clear;
    cdsItens.EmptyDataSet;
    cdsVendedores.EmptyDataSet;
    cdsSorteio.EmptyDataSet;
    pCarregaEmpresa;
  end
  else
    fRollBack;
end;

procedure TfrmCadCupomPromProd.btnGravarClick(Sender: TObject);
var
  blnTemEmpresa: Boolean;
begin
  blnTemEmpresa := fTemEmpresa;

  if not blnTemEmpresa then
  begin
    pMensagemOk('Selecione pelo menos uma empresa!');
    Exit;
  end;

  if (cdsItens.IsEmpty) and (not ckbTodosItens.Checked) then
  begin
    pMensagemOk('Inclua pelo menos um item nesta promoção ou marque a opção "Todos os Produtos"!');
    Exit;
  end;

  if (not fValidaPreenchimentoTipoPromocaoValor) then
  begin
    pMensagemOk('O valor da promoção deve ser preechido!');
    pSetFocus(dbeVLCPP1);
    Exit;
  end
  else
  begin
    if (not fValidaPreenchimentoTipoPromocaoQuantidadeFixa) then
    begin
      pMensagemOk('O valor da promoção e o número de cupons devem ser preechidos!');
      pSetFocus(dbeVLCPP2);
      Exit;
    end;
  end;

  if fVerificaCampos then
    fChamaTelaGravando(fGravarCupom, 'Gravando cupom, por favor, aguarde...');
end;

procedure TfrmCadCupomPromProd.btnIncluirClick(Sender: TObject);
begin
  inherited;
  rdgTipPro.ItemIndex := 0;
  pLimparCampos;
  dbeCodPro.Clear;
  dbeDescri.Clear;
  mskLinhaGrupo.Clear;
  cdsItens.EmptyDataSet;
  cdsVendedores.EmptyDataSet;
  cdsSorteio.EmptyDataSet;
  pHabilitaCodigo(dbeCodPro, dbeDesPro, False);
  pCarregaEmpresa;
  pIniciaValoresPadrao;
end;

procedure TfrmCadCupomPromProd.btnLimparGridClick(Sender: TObject);
begin
  inherited;
   cdsItens.EmptyDataSet;
end;

procedure TfrmCadCupomPromProd.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrProm: TConsultasArray;
begin
  pgcDados.ActivePageIndex := 0;
  chrKey := '/';
  If fPesqPromoCupom(Self, Nil, Nil, qryTabela, chrKey, arrProm) Then
    fChamaTelaGravando(fCarregarCupom, 'Carregando Cupom, por favor, aguarde...');
end;

procedure TfrmCadCupomPromProd.btnSorteioClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(edtCupSorteio.Text) then
  begin
    fMensagem('AVISO', 'O número do cupom deve ser informado!', ['&OK']);
    pSetFocus(edtCupSorteio);
    Exit;
  end;

  if fEmptyStr(fTiraCaracEspeciais(dtaDataSorteio.Text)) then
  begin
    fMensagem('AVISO', 'A data do sorteio deve ser informada!', ['&OK']);
    pSetFocus(dtaDataSorteio);
    Exit;
  end;

  pValidaCupomSorteio(edtCupSorteio.Text, dtaDataSorteio.Date);
end;

procedure TfrmCadCupomPromProd.DBGridCitel1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (cdsItens.RecordCount > 0) then
  begin
    if Key = VK_DELETE then
    begin
      cdsItens.Delete;
    end;
  end;
end;

procedure TfrmCadCupomPromProd.DBGridCitelVendedoresKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (cdsVendedores.RecordCount > 0) Then
  Begin
    If Key = VK_DELETE Then
    Begin
      cdsVendedores.Delete;
    End;
  End;
end;

procedure TfrmCadCupomPromProd.dtsPromoStateChange(Sender: TObject);
begin
  inherited;
  pEnableDisablePanel(pnlCabecalho, qryTabela.State In [dsInsert, dsEdit]);
  pEnableDisablePanel(pnlItens, qryTabela.State In [dsInsert, dsEdit]);
  pEnableDisablePanel(pnlVendedores, qryTabela.State In [dsInsert, dsEdit]);
  pEnableDisablePanel(pnlSorteados, qryTabela.State In [dsEdit]);

  btnAltDataFin.Enabled := (qryTabela.State = dsBrowse) and (not fEmptyStr(qryTabela.FieldByName('CPP_CODCPP').AsString));
end;

procedure TfrmCadCupomPromProd.edtCodDepExit(Sender: TObject);
begin
  inherited;
  edtDesDep.Text    := fRetDescDepartamento(edtCodDep.Text);
  edtDesDep.Enabled := False;

  If fEmptyStr(edtDesDep.Text) then
  begin
    If (Not fEmptyStr(edtCodDep.Text)) Then
    Begin
      fMensagem('AVISO', 'Código do Departamento não encontrado.', ['&O K']);
      edtCodDep.Clear;
      pSetFocus(edtCodDep);
    end;
  End;
end;

procedure TfrmCadCupomPromProd.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrSel, False) Then
    Begin
      If fValidaCampos(edtCodDep, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCupomPromProd.edtCodIteExit(Sender: TObject);
begin
  inherited;
  If edtCodIte.ReadOnly Then
    Exit;

  If fEmptyStr(edtCodIte.Text) Then
  Begin
    edtDesIte.Text := 'TODOS';
    edtUnidade.Text := '';
  End
  Else
  Begin
    edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
    edtUnidade.Text := fRetUnidadeItem(edtCodIte.Text);
  End;

  edtDesIte.Enabled := False;

  If fEmptyStr(edtDesIte.Text) then
  begin
    if (Not fEmptyStr(edtCodIte.Text)) Then
    Begin
      fMensagem('AVISO', 'Código do Produto não encontrado.', ['&O K']);
      edtCodIte.Clear;
      pSetFocus(edtCodIte);
    end;
  End;
end;

procedure TfrmCadCupomPromProd.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If edtCodIte.ReadOnly Then
    Exit;

  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      If fValidaCampos(edtCodIte, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCupomPromProd.edtCodLayKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  If fPesqLayout(Self, edtCodLay, edtDesLay, Nil,'J',Key, arrSel, True, IntToStr(ARR_TIPO_LAYOUT[tpeCupomPromocao])) Then
  Begin
    If fValidaCampos(edtCodLay, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCupomPromProd.edtCodOpeExit(Sender: TObject);
begin
  inherited;
  edtNomOpe.Text    := fRetNomVendRep(edtCodOpe.Text);
  edtNomOpe.Enabled := False;

  If fEmptyStr(edtNomOpe.Text) then
  begin
    If (Not fEmptyStr(edtCodOpe.Text)) Then
    Begin
      fMensagem('AVISO', 'Código do Vendedor não encontrado.', ['&O K']);
      edtCodOpe.Clear;
      pSetFocus(edtCodOpe);
    end;
  End;
end;

procedure TfrmCadCupomPromProd.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If (fPesqOperador(Self, edtCodOpe, edtNomOpe, nil, Key, arrSel, True, False, False, False, False, False, False, False, True)) Then
    Begin
      If fValidaCampos(edtCodOpe, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCupomPromProd.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  If edtFornecedor.ReadOnly Then
    Exit;

  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

  edtDesFornecedor.Enabled := False;

  If fEmptyStr(edtDesFornecedor.Text) then
  begin
    if (Not fEmptyStr(edtFornecedor.Text))  Then
    Begin
      fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
      edtFornecedor.Clear;
      pSetFocus(edtFornecedor);
    end;
  End;
end;

procedure TfrmCadCupomPromProd.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrFornec: TConsultasArray;
begin
  inherited;

  If edtFornecedor.ReadOnly Then
    Exit;

  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCupomPromProd.edtMarcaExit(Sender: TObject);
begin
  inherited;
  If edtMarca.ReadOnly Then
    Exit;

  If fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := 'TODOS'
  Else
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);

  edtDesMarca.Enabled := False;

  If fEmptyStr(edtDesMarca.Text) then
  begin
    if (Not fEmptyStr(edtMarca.Text))  Then
    Begin
      fMensagem('AVISO','Código da marca não encontrado.', ['&O K']);
      edtMarca.Clear;
      pSetFocus(edtMarca);
    end;
  End;
end;

procedure TfrmCadCupomPromProd.edtMarcaKeyPress(Sender: TObject; var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;

  If edtMarca.ReadOnly Then
    Exit;

  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;
procedure TfrmCadCupomPromProd.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
var
  chrKey: Char;
  arrUnidades: TConsultasArray;
begin
  inherited;

  {*****************************}
  {* NOVA CONSULTA DE UNIDADES *}
  {**************************AC*}
  chrKey := Key;
  if fPesqUnidade(Self, edtUnidade, Nil, Nil, qryCadUni, chrKey, arrUnidades) then
  begin
    If fValidaCampos(edtUnidade, True) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmCadCupomPromProd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> CaNone) Then
  Begin
    qryTabela.AfterOpen := nil;
    FreeAndNil(qryCadUni);
    FreeAndNil(qryConIte);
  End;
end;

procedure TfrmCadCupomPromProd.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADCPP';
  strNomeCampo  := 'AUTOINCREM';
  qryTabela := fCriarQuery('SELECT * FROM CADCPP', Self);
  qryTabela.AfterOpen := pAfterOpen;
  dtsPromo.DataSet := qryTabela;

  qryCadUni := fCriaQuery(Self);
  qryConIte := fCriaQuery(Self);

  cdsItens.CreateDataSet;
  cdsVendedores.CreateDataSet;
  cdsSorteio.CreateDataSet;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPro;

  edtCodIte.MaxLength := fTamCodIte();
  dtaDataSorteio.Date := fRetDataServidor;
end;

procedure TfrmCadCupomPromProd.FormShow(Sender: TObject);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
  rdgTipPro.ItemIndex := 0;
  pCarregaEmpresa;
  TListaTipoOperadores.pCarregaCombo(cbxTipoOperadores);
  pSetFocus(btnIncluir);
  chkImpCup.Visible := (fCfgSis('PROICP', varInteger) = 3);
end;

function TfrmCadCupomPromProd.fTemEmpresa: boolean;
  var
    intContador : integer;
begin
  Result := False;
  for intContador := 0 to clbEmpresa.Items.Count - 1 do
  begin
    if clbEmpresa.Checked[intContador] then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TfrmCadCupomPromProd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;


  If (inherited fValidaCampos(Sender)) Then
  begin
    if (Sender = dbeDesPro) then
    begin
      If fEmptyStr(dbeDesPro.Text) Then
      begin
        fMensagem('','Informe o título do Cupom!', ['&Ok']);
        Result := False;
      end;
    end
    else if (Sender = dbeDescri) then
    begin
      if fEmptyStr(dbeDescri.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A descrição do Cupom deve ser preenchida!', ['&O k']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeDtaIni) then
    begin
      If (dbeDtaIni.Text = '  /  /    ') Or fEmptyStr(dbeDtaIni.Text) Then
      begin
        fMensagem('','Informe a data inicial!', ['&Ok']);
        Result := False;
      end
      else if (StrToDate(dbeDtaIni.Text) < fRetDataServidor) and
              (qryTabela.State = dsInsert) then
      begin
        fMensagem('','Data inicial não pode ser anterior a data atual!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeDtaFin) then
    begin
      If (dbeDtaFin.Text = '  /  /    ') Or fEmptyStr(dbeDtaFin.Text) Then
      begin
        fMensagem('','Informe a data final!', ['&Ok']);
        Result := False;
      end
      {VALIDAR TAMBÉM SE DATA INICIAL FOI PREENCHIDA PARA EVITAR ERRO DE DATA INVALIDA}
      else if ((dbeDtaIni.Text <> '  /  /    ') and (fEmptyStr(dbeDtaIni.Text) = False)) then
      begin
        if (StrToDate(dbeDtaIni.Text) > StrToDate(dbeDtaFin.Text)) then
        begin
          fMensagem('','Data inicial não pode ser maior que a data final!', ['&Ok']);
          Result := False;
        end;
      end;
    end
    Else If (Sender = dbeTipCli) Then
    Begin
      If (Not MatchStr(dbeTipCli.Text, ['F','J','A'])) Then
      Begin
        fMensagem('', 'Informe um tipo de cliente válido: (F) Pessoa Física / (J) Pessoa Jurídica / (A) Ambos!', ['&O k']);
        Result := False;
      End;
    End
    Else If (Sender = edtDescriIni) Then
    Begin
      If fEmptyStr(edtDescriIni.Text) Then
        edtDescriFin.Enabled := False
      Else
        edtDescriFin.Enabled := True;
    End
    Else If (Sender = edtDescriFin) Then
    Begin
      If Not fEmptyStr(edtDescriIni.Text) Then
      Begin
        If fEmptyStr(edtDescriFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A descrição final deve ser preenchida!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodLay) Then
    Begin
      edtDesLay.Clear;
      If Not fEmptyStr(edtCodLay.Text) Then
      Begin
        edtCodLay.Text := fStrZero(edtCodLay.Text, 6);
        edtDesLay.Text := fRetornaDescricaoLayoutEtq(edtCodLay.Text);
        If fEmptyStr(edtDesLay.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Layout não encontrado!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtUnidade) Then
    Begin
      If Not fEmptyStr(edtUnidade.Text) Then
      Begin
        If fEmptyStr(fRetNomUnidade(edtUnidade.Text)) Then
        Begin
          fMensagem('', 'Unidade Inválida!', ['&OK']);
          Result := False;
        End;
      End;
    End;
  end;
  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadCupomPromProd.fPreencheuFaixaDeDescricao: boolean;
begin
  Result := True;

  if (fEmptyStr(edtDescriIni.Text)) then
    Exit(False);

  if (fEmptyStr(edtDescriFin.Text)) then
    Exit(False);
end;

function TfrmCadCupomPromProd.fValidaPreenchimentoTipoPromocaoQuantidadeFixa: boolean;
begin
  Result := True;

  if rdgTipPro.ItemIndex = 0 then
    Exit;

  if (fEmptyStr(dbeVLCPP2.Text)) then
    Exit(False);

  if (fEmptyStr(dbeNumCup.Text)) then
    Exit(False);
end;

function TfrmCadCupomPromProd.fValidaPreenchimentoTipoPromocaoValor: boolean;
begin
  Result := True;

  if rdgTipPro.ItemIndex = 0 then
  begin
    if fEmptyStr(dbeVLCPP1.Text) then
    begin
      Result := False;
    end;
  end;
end;

procedure TfrmCadCupomPromProd.grdSorteioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if cdsSorteio.RecordCount <= 0 then
    Exit;

  if cdsSorteio.RecNo <= 0 then
    Exit;

  if Key = VK_DELETE then
    cdsSorteio.Delete;
end;

procedure TfrmCadCupomPromProd.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If mskLinhaGrupo.ReadOnly Then
    Exit;

  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);

  edtDesGrupo.Enabled := False;

  If fEmptyStr(edtDesGrupo.Text) then
  begin
    if (Not fEmptyStr(mskLinhaGrupo.Text))  Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo.Clear;
      pSetFocus(mskLinhaGrupo);
    end;
  End;
end;

procedure TfrmCadCupomPromProd.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;

  If mskLinhaGrupo.ReadOnly Then
    Exit;

  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmCadCupomPromProd.pAfterOpen(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
    if DataSet.FindField('CPP_DTAINI') <> nil then
      TDateField(DataSet.FieldByName('CPP_DTAINI')).EditMask := '99/99/9999';

    if DataSet.FindField('CPP_DTAFIN') <> nil then
      TDateField(DataSet.FieldByName('CPP_DTAFIN')).EditMask := '99/99/9999';

    if DataSet.FindField('CPP_VLCPP1') <> nil then
      TDateField(DataSet.FieldByName('CPP_VLCPP1')).DisplayFormat := '#,##0.00';

    if DataSet.FindField('CPP_VLCPP2') <> nil then
      TDateField(DataSet.FieldByName('CPP_VLCPP2')).DisplayFormat := '#,##0.00';
  end;
end;

procedure TfrmCadCupomPromProd.pCarregaCuponsSorteados(strAutInc: String;
  pgbProgresso: TcxProgressBar);
var
  qryCupom: TUniQuery;
begin
  qryCupom := fCriaQuery;

  try
    cdsSorteio.EmptyDataSet;

    qryCupom.Close;
    qryCupom.SQL.Clear;
    qryCupom.SQL.Add('SELECT * FROM CUPSOR WHERE SOR_SEQPRO = :SEQPRO');
    qryCupom.ParamByName('SEQPRO').AsString := strAutInc;
    qryCupom.Open;

    if qryCupom.IsEmpty then
      Exit;

    pInfoStatusGravacao(pgbProgresso, 'Carregando cupons sorteados, por favor, aguarde...', qryCupom.RecordCount);

    while not qryCupom.Eof do
    begin
      pStepStatusGravacao(pgbProgresso);

      cdsSorteio.Append;
      cdsSorteioAUTINC.AsString   := qryCupom.FieldByName('AUTOINCREM').AsString;
      cdsSorteioSEQPRO.AsString   := qryCupom.FieldByName('SOR_SEQPRO').AsString;
      cdsSorteioCODEMP.AsString   := qryCupom.FieldByName('SOR_CODEMP').AsString;
      cdsSorteioCODOPE.AsString   := qryCupom.FieldByName('SOR_CODOPE').AsString;
      cdsSorteioDTAENT.AsDateTime := qryCupom.FieldByName('SOR_DTAENT').AsDateTime;
      cdsSorteioNUMCUP.AsString   := qryCupom.FieldByName('SOR_NUMCUP').AsString;
      cdsSorteioDTASOR.AsDateTime := qryCupom.FieldByName('SOR_DTASOR').AsDateTime;
      cdsSorteioNUMDOC.AsString   := qryCupom.FieldByName('SOR_NUMDOC').AsString;
      cdsSorteioESPDOC.AsString   := qryCupom.FieldByName('SOR_ESPDOC').AsString;
      cdsSorteioEMPDOC.AsString   := qryCupom.FieldByName('SOR_EMPDOC').AsString;
      cdsSorteioCODCLI.AsString   := qryCupom.FieldByName('SOR_CODCLI').AsString;
      cdsSorteioDOCUME.AsString   := Concat(qryCupom.FieldByName('SOR_NUMDOC').AsString, '-', qryCupom.FieldByName('SOR_ESPDOC').AsString, '-', qryCupom.FieldByName('SOR_EMPDOC').AsString);
      cdsSorteioCLIENT.AsString   := Concat(qryCupom.FieldByName('SOR_CODCLI').AsString, '-', fRetNomCliente(qryCupom.FieldByName('SOR_CODCLI').AsString));
      cdsSorteio.Post;

      qryCupom.Next;
    end;
  finally
    FreeAndNil(qryCupom);
  end;
end;

procedure TfrmCadCupomPromProd.pCarregaEmpresa;
Var
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  try
    clbEmpresa.Items.Clear;
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP ORDER BY EMP_CODEMP');
    qryGen.Open;
    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      clbEmpresa.Items.Add(qryGen.FieldByName('EMPNOM').AsString);
      qryGen.Next;
    End;
  finally
    FreeAndNil(qryGen);
  end;

End;

procedure TfrmCadCupomPromProd.pCarregaEmpresaPromocao(strAutInc: string; pgbProgresso: TcxProgressBar = nil);
var
  qryEmpresas: TUniQuery;
  strEmpresas: string;
  intContador: integer;
begin
  qryEmpresas := fCriaQuery;
  strEmpresas := EmptyStr;

  try
    qryEmpresas.Close;
    qryEmpresas.SQL.Clear;
    qryEmpresas.SQL.Text := 'SELECT CPP_CODEMP, CPP_STATUS '
                          + '  FROM CPPEMP '
                          + ' WHERE CPP_SEQCPP = :AUTINC '
                          + '   AND CPP_STATUS = "A" ';
    qryEmpresas.ParamByName('AUTINC').AsString := strAutInc;
    qryEmpresas.Open;

    if not qryEmpresas.IsEmpty then
    begin
      pInfoStatusGravacao(pgbProgresso, 'Carregando empresas, por favor, aguarde...', qryEmpresas.RecordCount);
      while not qryEmpresas.Eof do
      begin
        pStepStatusGravacao(pgbProgresso);
        strEmpresas := strEmpresas + qryEmpresas.FieldByName('CPP_CODEMP').AsString + '_';
        qryEmpresas.Next;
      end;

      for intContador := 0 to clbEmpresa.Items.Count -1 do
      begin
        if Pos(LeftStr(clbEmpresa.Items[intContador],3), strEmpresas) > 0 then
        begin
          clbEmpresa.Checked[intContador] := True;
        end
        else
        begin
          clbEmpresa.Checked[intContador] := False;
        end;
      end;
    end;
  finally
    FreeAndNil(qryEmpresas);
  end;
end;

function TfrmCadCupomPromProd.fCarregaItens(pgbProgresso: TcxProgressBar = nil):Boolean;
var
  qryItens: TUniQuery;
begin
  Result := False;
  qryItens := fCriaQuery;

  try
    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT ITE_CODITE, ITE_DESITE');
    qryItens.SQL.Add('FROM CADITE');
    qryItens.SQL.Add('WHERE ITE_ITEATI = "S"');

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      If RightStr(mskLinhaGrupo.Text,3) = '000' Then
        qryItens.SQL.Add('AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3)')
      Else
        qryItens.SQL.Add('AND ITE_CODGRU = :CODGRU ');
      qryItens.ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;
    End;

    If (fPreencheuFaixaDeDescricao) Then
    Begin
      qryItens.SQL.Add('AND LEFT(ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESITE AND :DESITE1 ');
      qryItens.ParamByName('MAIOR').AsString := edtDescriIni.Text;
      qryItens.ParamByName('DESITE').AsString := edtDescriIni.Text;
      qryItens.ParamByName('DESITE1').AsString := edtDescriFin.Text;
    End
    Else if (Not fEmptyStr(edtDescriIni.Text)) then
    Begin
      qryItens.SQL.Add('AND ITE_DESITE LIKE :DESITE ');
      qryItens.ParamByName('DESITE').AsString := edtDescriIni.Text + '%';
    End;

    pAdicionaCondicao(qryItens, edtCodIte.Text, 'AND ITE_CODITE = :CODITE', 'CODITE');
    pAdicionaCondicao(qryItens, edtFornecedor.Text, 'AND ITE_CODFOR = :CODFOR', 'CODFOR');
    pAdicionaCondicao(qryItens, edtMarca.Text, 'AND ITE_CODMAR = :CODMAR', 'CODMAR');
    pAdicionaCondicao(qryItens, edtRefere.Text, 'AND ITE_REFERE = :REFERE', 'REFERE');
    pAdicionaCondicao(qryItens, edtUnidade.Text, 'AND ITE_CODUNI = :CODUNI', 'CODUNI');

    qryItens.SQL.Add('ORDER BY CADITE.ITE_DESITE ');

    qryItens.Open;

    if qryItens.IsEmpty then
    begin
      pMensagemOk('Nenhum item retornado no filtro selecionado!');
      Exit;
    end;

    pCarregarCdsItens(qryItens, pgbProgresso);

    Result := True;
  finally
    FreeAndNil(qryItens);
  end;
end;

function TfrmCadCupomPromProd.fCarregarCupom(pgbProgresso: TcxProgressBar = nil): Boolean;
begin
  pCarregaTipoPromocao(qryTabela.FieldByName('AUTOINCREM').AsString);
  pCarregaEmpresaPromocao(qryTabela.FieldByName('AUTOINCREM').AsString, pgbProgresso);
  pCarregaItensPromocao(qryTabela.FieldByName('AUTOINCREM').AsString, pgbProgresso);
  pCarregaVendedoresPromocao(qryTabela.FieldByName('AUTOINCREM').AsString, pgbProgresso);
  pCarregaCuponsSorteados(qryTabela.FieldByName('AUTOINCREM').AsString, pgbProgresso);

  if (not fEmptyStr(edtCodLay.Text)) then
    edtDesLay.Text := fRetornaDescricaoLayoutEtq(edtCodLay.Text, qryTabela.FieldByName('CPP_CODEMP').AsString);

  pSetFocus(btnAlterar);

  Result := True;
end;

procedure TfrmCadCupomPromProd.pCarregaItensPromocao(strAutInc: string; pgbProgresso: TcxProgressBar = nil);
var
  qryItens: TUniQuery;
begin
  qryItens := fCriaQuery;

  try
    cdsItens.EmptyDataSet;

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT CPP_CODITE, CPP_DESITE FROM CPPITE WHERE CPP_SEQCPP = :AUTINC');
    qryItens.ParamByName('AUTINC').AsString := strAutInc;
    qryItens.Open;

    pInfoStatusGravacao(pgbProgresso, 'Carregando itens, por favor, aguarde...', qryItens.RecordCount);

    while not qryItens.Eof do
    begin
      pStepStatusGravacao(pgbProgresso);

      cdsItens.Append;
      cdsItensCODITE.AsString := qryItens.FieldByName('CPP_CODITE').AsString;
      cdsItensDESITE.AsString := qryItens.FieldByName('CPP_DESITE').AsString;
      cdsItens.Post;
      qryItens.Next;
    end;

    cdsItens.First;
  finally
    FreeAndNil(qryItens);
  end;
end;

procedure TfrmCadCupomPromProd.pCarregarCdsItens(qryItens: TUniQuery; pgbProgresso: TcxProgressBar = nil);
  Var
    strItensJaInseridos : String;
begin
  strItensJaInseridos := '';

  cdsItens.DisableControls;
  Try
    pInfoStatusGravacao(pgbProgresso, 'Carregando itens, por favor, aguarde...', qryItens.RecordCount);

    qryItens.First;
    while not qryItens.Eof do
    begin
      pStepStatusGravacao(pgbProgresso);

      if (cdsItens.Locate('CODITE', qryItens.FieldByName('ITE_CODITE').AsString,[])) then
      begin
        If fEmptyStr(strItensJaInseridos) Then
          strItensJaInseridos := cdsItensCODITE.AsString
        Else
          strItensJaInseridos := strItensJaInseridos + ', ' + cdsItensCODITE.AsString;
      end
      else
      begin
        cdsItens.Append;
        cdsItensCODITE.AsString := qryItens.FieldByName('ITE_CODITE').AsString;
        cdsItensDESITE.AsString := qryItens.FieldByName('ITE_DESITE').AsString;
        cdsItens.Post;
      end;

      qryItens.Next;
    end;
    cdsItens.First;

    If Not fEmptyStr(strItensJaInseridos) Then
    Begin
      If Pos(',', strItensJaInseridos) = 0 Then
        pMensagemOk('O item '+strItensJaInseridos+' já está na promoção de cupom atual!')
      Else
        pMensagemOk('Os itens ['+strItensJaInseridos+'] já estão na promoção de cupom atual!');
    End;
  Finally
    cdsItens.EnableControls;
  End;
end;

procedure TfrmCadCupomPromProd.pCarregarCdsVendedores(qryVendedores: TUniQuery; pgbProgresso: TcxProgressBar = nil);
begin
  cdsVendedores.DisableControls;

  pInfoStatusGravacao(pgbProgresso, 'Carregando vendedores, por favor, aguarde...', qryVendedores.RecordCount);

  qryVendedores.First;
  while not qryVendedores.Eof do
  begin
    pStepStatusGravacao(pgbProgresso);

    If (Not cdsVendedores.Locate('OPE_CODOPE', qryVendedores.FieldByName('OPE_CODOPE').AsString,[])) then
    begin
      cdsVendedores.Append;
      cdsVendedoresOPE_CODOPE.AsString := qryVendedores.FieldByName('OPE_CODOPE').AsString;
      cdsVendedoresOPE_NOMOPE.AsString := qryVendedores.FieldByName('OPE_NOMOPE').AsString;
      cdsVendedores.Post;
    end;

    qryVendedores.Next;
  end;
  cdsVendedores.First;
  cdsVendedores.EnableControls;
end;

procedure TfrmCadCupomPromProd.pCarregaTipoPromocao(strAutInc: string);
var
  qryTipProm: TUniQuery;
begin
  qryTipProm := fCriaQuery;

  try
    qryTipProm.Close;
    qryTipProm.SQL.Clear;
    qryTipProm.SQL.Add('SELECT CPP_TIPPRO FROM CADCPP WHERE AUTOINCREM = :AUTINC');
    qryTipProm.ParamByName('AUTINC').AsString := strAutInc;
    qryTipProm.Open;

    if not qryTipProm.IsEmpty then
    begin
      rdgTipPro.ItemIndex := qryTipProm.FieldByName('CPP_TIPPRO').AsInteger;
    end;
  finally
    FreeAndNil(qryTipProm);
  end;
end;

function TfrmCadCupomPromProd.fCarregaVendedores(pgbProgresso: TcxProgressBar = nil):Boolean;
var
  qryVendedores : TUniQuery;
begin
  qryVendedores := fCriaQuery;
  Try
    qryVendedores.Close;
    qryVendedores.SQL.Clear;
    qryVendedores.SQL.Add('SELECT ');
    qryVendedores.SQL.Add('       OPE_CODOPE ');
    qryVendedores.SQL.Add('     , OPE_NOMOPE ');
    qryVendedores.SQL.Add('  FROM CADOPE ');
    qryVendedores.SQL.Add(' WHERE OPE_STATUS = "A" ');

    pAdicionaCondicao(qryVendedores, edtCodOpe.Text, 'AND OPE_CODOPE = :CODOPE', 'CODOPE');
    pAdicionaCondicao(qryVendedores, edtCodDep.Text, 'AND OPE_CODDEP = :CODDEP', 'CODDEP');

    If (cbxTipoOperadores.ItemIndex > -1) Then
      pAdicionaCondicao(qryVendedores, TItemCombo(cbxTipoOperadores.Items.Objects[cbxTipoOperadores.ItemIndex]).Codigo, 'AND OPE_INTEXT = :INTEXT', 'INTEXT');

    qryVendedores.SQL.Add(' ORDER BY OPE_NOMOPE ');
    qryVendedores.Open;

    If qryVendedores.IsEmpty Then
    Begin
      pMensagemOk('Nenhum item retornado no filtro selecionado!');
    End
    Else
      pCarregarCdsVendedores(qryVendedores, pgbProgresso);

    Result := True;
  Finally
    FreeAndNil(qryVendedores);
  End;
end;

procedure TfrmCadCupomPromProd.pCarregaVendedoresPromocao(strAutInc: string; pgbProgresso: TcxProgressBar = nil);
var
  qryVendedores: TUniQuery;
begin
  qryVendedores := fCriaQuery;
  Try
    cdsVendedores.EmptyDataSet;

    qryVendedores.Close;
    qryVendedores.SQL.Clear;
    qryVendedores.SQL.Text := 'SELECT CPV_CODOPE, CPV_DESCRI FROM CPPVEN '
                            + ' WHERE CPV_SEQCPP = :AUTINC ';

    qryVendedores.ParamByName('AUTINC').AsString := strAutInc;
    qryVendedores.Open;

    pInfoStatusGravacao(pgbProgresso, 'Carregando vendedores, por favor, aguarde...', qryVendedores.RecordCount);

    While Not qryVendedores.Eof Do
    Begin
      pStepStatusGravacao(pgbProgresso);

      cdsVendedores.Append;
      cdsVendedoresOPE_CODOPE.AsString := qryVendedores.FieldByName('CPV_CODOPE').AsString;
      cdsVendedoresOPE_NOMOPE.AsString := qryVendedores.FieldByName('CPV_DESCRI').AsString;
      cdsVendedores.Post;

      qryVendedores.Next;
    End;

    cdsVendedores.First;
  Finally
    FreeAndNil(qryVendedores);
  End;
end;

procedure TfrmCadCupomPromProd.pEnableDisablePanel(Panel: TPanel;
  blnEnabled: Boolean);
begin
  Panel.Enabled := blnEnabled;

  If (Panel = pnlCabecalho) Then
  Begin
    dbeCodPro.Enabled := blnEnabled;
    dbeDesPro.Enabled := blnEnabled;
    dbeDtaIni.Enabled := blnEnabled;
    dbeDtaFin.Enabled := blnEnabled;
    chkImpCup.Enabled := blnEnabled;
    dbeTipCli.Enabled := blnEnabled;
    chkCpcLcs.Enabled := blnEnabled;
    rdgTipPro.Enabled := blnEnabled And (qryTabela.State = dsInsert);
    chkAcmVal.Enabled := rdgTipPro.Enabled;
    clbEmpresa.Enabled := blnEnabled;
    dbeDescri.Enabled := blnEnabled;

  End
  Else If (Panel = pnlItens) Then
  Begin
    mskLinhaGrupo.Enabled := blnEnabled;
    edtMarca.Enabled := blnEnabled;
    edtCodIte.Enabled := blnEnabled;
    edtFornecedor.Enabled := blnEnabled;
    edtDescriIni.Enabled := blnEnabled;
    edtDescriFin.Enabled := blnEnabled And (Not fEmptyStr(edtDescriIni.Text));
    edtRefere.Enabled := blnEnabled;
    edtUnidade.Enabled := blnEnabled;
    ckbTodosItens.Enabled := blnEnabled;

  End
  Else If (Panel = pnlVendedores) Then
  Begin
    edtCodOpe.Enabled                := blnEnabled;
    edtCodDep.Enabled                := blnEnabled;
    cbxTipoOperadores.Enabled        := blnEnabled;
    btnConfirmarVendedor.Enabled     := blnEnabled;
    btnLimparGridVendedores.Enabled  := blnEnabled;

  End
  Else If (Panel = pnlSorteados) Then
  Begin
    edtCupom.Enabled := blnEnabled;
    dtaDataSorteio.Enabled := blnEnabled;
    btnSorteio.Enabled := blnEnabled;
  End;
end;

procedure TfrmCadCupomPromProd.pDesativaEmpresas(strAutInc: String);
var
  qryEmpresas: TUniQuery;
begin
  qryEmpresas := fCriaQuery;

  try
    qryEmpresas.Close;
    qryEmpresas.SQL.Clear;
    qryEmpresas.SQL.Text := 'UPDATE CPPEMP '
                          + '   SET CPP_STATUS = "I" '
                          + ' WHERE CPP_SEQCPP = :AUTINC ';
    qryEmpresas.ParamByName('AUTINC').AsString := strAutInc;
    qryEmpresas.ExecSQL;
  finally
    FreeAndNil(qryEmpresas);
  end;
end;

procedure TfrmCadCupomPromProd.pGravaCupomSorteio(strAutInc: String;
  pgbProgresso: TcxProgressBar);
var
  qryCupom: TUniQuery;
begin
  if cdsSorteio.IsEmpty then
    Exit;

  qryCupom := fCriaQuery;

  try
    qryCupom.Close;
    qryCupom.SQL.Clear;
    qryCupom.SQL.Add('DELETE FROM CUPSOR WHERE SOR_SEQPRO = :SEQPRO');
    qryCupom.ParamByName('SEQPRO').AsString := strAutInc;
    qryCupom.ExecSQL;

    qryCupom.Close;
    qryCupom.SQL.Clear;
    qryCupom.SQL.Add('INSERT INTO CUPSOR(AUTOINCREM, SOR_SEQPRO, SOR_CODEMP, SOR_CODOPE, SOR_DTAENT, SOR_NUMCUP, SOR_DTASOR,');
    qryCupom.SQL.Add('                   SOR_NUMDOC, SOR_ESPDOC, SOR_EMPDOC, SOR_CODCLI)');
    qryCupom.SQL.Add('VALUES(:AUTINC, :SEQPRO, :CODEMP, :CODOPE, :DTAENT, :NUMCUP, :DTASOR,');
    qryCupom.SQL.Add('       :NUMDOC, :ESPDOC, :EMPDOC, :CODCLI)');


    cdsSorteio.DisableControls;

    try
      pInfoStatusGravacao(pgbProgresso, 'Gravando cupons sorteados, por favor aguarde...', cdsSorteio.RecordCount);

      cdsSorteio.First;

      while not cdsSorteio.Eof do
      begin
        pStepStatusGravacao(pgbProgresso);

        qryCupom.ParamByName('AUTINC').AsString := fRetAutoIncrem('CUPSOR', VS_strCodEmp);
        qryCupom.ParamByName('SEQPRO').AsString := cdsSorteioSEQPRO.AsString;
        qryCupom.ParamByName('CODEMP').AsString := cdsSorteioCODEMP.AsString;
        qryCupom.ParamByName('CODOPE').AsString := cdsSorteioCODOPE.AsString;
        qryCupom.ParamByName('DTAENT').AsDate   := cdsSorteioDTAENT.AsDateTime;
        qryCupom.ParamByName('NUMCUP').AsString := cdsSorteioNUMCUP.AsString;
        qryCupom.ParamByName('DTASOR').AsDate   := cdsSorteioDTASOR.AsDateTime;
        qryCupom.ParamByName('NUMDOC').AsString := cdsSorteioNUMDOC.AsString;
        qryCupom.ParamByName('ESPDOC').AsString := cdsSorteioESPDOC.AsString;
        qryCupom.ParamByName('EMPDOC').AsString := cdsSorteioEMPDOC.AsString;
        qryCupom.ParamByName('CODCLI').AsString := cdsSorteioCODCLI.AsString;

        qryCupom.ExecSQL;

        cdsSorteio.Next;
      end;
    finally
      cdsSorteio.First;
      cdsSorteio.EnableControls;
    end;
  finally
    FreeAndNil(qryCupom);
  end;
end;

procedure TfrmCadCupomPromProd.pGravaItens(strAutInc: string; pgbProgresso: TcxProgressBar = nil);
var
  qryItens: TUniQuery;
begin
  if not cdsItens.IsEmpty then
  begin
    qryItens := fCriaQuery;

    try
      qryItens.Close;
      qryItens.SQL.Clear;
      qryItens.SQL.Add('DELETE FROM CPPITE WHERE CPP_SEQCPP = :SEQGER');
      qryItens.ParamByName('SEQGER').AsString := strAutInc;
      qryItens.ExecSQL;

      qryItens.SQL.Clear;
      qryItens.SQL.Add('INSERT INTO CPPITE (CPP_SEQCPP, CPP_CODITE, CPP_DESITE, CPP_DTAHRA) VALUES (:SEQCPP, :CODITE, :DESITE, :DTAHRA)');

      pInfoStatusGravacao(pgbProgresso, 'Gravando itens, por favor aguarde...', cdsItens.RecordCount);

      cdsItens.First;

      while not cdsItens.Eof do
      begin
        pStepStatusGravacao(pgbProgresso);

        qryItens.ParamByName('SEQCPP').AsString := strAutInc;
        qryItens.ParamByName('CODITE').AsString := cdsItensCODITE.AsString;
        qryItens.ParamByName('DESITE').AsString := cdsItensDESITE.AsString;
        qryItens.ParamByName('DTAHRA').AsDateTime := fRetDtaHraServidor;
        qryItens.ExecSQL;

        cdsItens.Next;
      end;
    finally
      FreeAndNil(qryItens);
    end;
  end;
end;

function TfrmCadCupomPromProd.fGravarCupom(pgbProgresso: TcxProgressBar = nil):Boolean;
begin
  Result := False;
  pInfoStatusGravacao(pgbProgresso, 'Gravando cupom, por favor aguarde...');

  fStartTransaction;
  Try
    If qryTabela.State = dsBrowse Then
      qryTabela.Insert;

    If qryTabela.State = dsInsert Then
    Begin
      qryTabela.FieldByName('CPP_CODCPP').AsString := fAtualizaProCod('CADCPP', 'CPP_CODCPP', '', 1, Nil,
        function (const AValue: String) : String
        begin
          Result := Concat(VS_strCodEmp, AValue);
        end
      );
      qryTabela.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADCPP', VS_strCodEmp);
    End;

    qryTabela.FieldByName('CPP_TIPPRO').AsInteger := rdgTipPro.ItemIndex;
    qryTabela.FieldByName('CPP_CODEMP').AsString := VS_strCodEmp;
    qryTabela.FieldByName('CPP_ULTALT').AsDateTime := fRetDataServidor;

    pGravarEmpresas(qryTabela.FieldByName('AUTOINCREM').AsString, pgbProgresso);

    pGravaItens(qryTabela.FieldByName('AUTOINCREM').AsString, pgbProgresso);
    pGravaVendedores(qryTabela.FieldByName('AUTOINCREM').AsString, pgbProgresso);
    pGravaCupomSorteio(qryTabela.FieldByName('AUTOINCREM').AsString, pgbProgresso);

    qryTabela.Post;

    pInfoStatusGravacao(pgbProgresso, 'Finalizando gravação do cupom, por favor aguarde...');

    fCommit;

    pOnStateChange;
    pMensagemOk('Promoção gravada com sucesso!');

    Result := True;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagemOk(E.Message);
    End;
  End;
end;

procedure TfrmCadCupomPromProd.pGravarEmpresas(strAutIncPro: String; pgbStatus: TcxProgressBar = Nil);
Var
  qryDados    : TUniQuery;
  qryGen      : TUniQuery;
  intContador : Integer;
begin
  qryDados := fCriaQuery(Self);
  qryGen   := fCriaQuery(Self);
  try
    qryDados.SQL.Text := 'SELECT CPP_CODEMP FROM CPPEMP '
                       + ' WHERE CPP_SEQCPP = :SEQCPP '
                       + '   AND CPP_CODEMP = :CODEMP ';

    pInfoStatusGravacao(pgbStatus, 'Gravando empresas, por favor aguarde...', clbEmpresa.Items.Count);

    For intContador := 0 To clbEmpresa.Items.Count -1 Do
    Begin
      pStepStatusGravacao(pgbStatus);

      qryDados.Close;
      qryDados.ParamByName('SEQCPP').AsString := strAutIncPro;
      qryDados.ParamByName('CODEMP').AsString := LeftStr(clbEmpresa.Items[intContador],3);
      qryDados.Open;

      If Not qryDados.IsEmpty Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Text := 'UPDATE CPPEMP '
                         + '   SET CPP_STATUS = :STATUS '
                         + ' WHERE CPP_CODEMP = :CODEMP '
                         + '   AND CPP_SEQCPP = :SEQCPP ';

        qryGen.ParamByName('SEQCPP').AsString := strAutIncPro;
        qryGen.ParamByName('CODEMP').AsString := LeftStr(clbEmpresa.Items[intContador],3);

        If clbEmpresa.Checked[intContador] Then
          qryGen.ParamByName('STATUS').AsString := 'A'
        Else
          qryGen.ParamByName('STATUS').AsString := 'I';

        qryGen.ExecSQL;
      End
      Else
      Begin
        If clbEmpresa.Checked[intContador] Then
        Begin
          qryGen.Close;
          qryGen.SQL.Clear;
          qryGen.SQL.Text := 'INSERT INTO CPPEMP ( '
                           + '       CPP_SEQCPP '
                           + '     , CPP_CODEMP '
                           + '     , CPP_STATUS '
                           + ') VALUES ('
                           + '       :SEQCPP '
                           + '     , :CODEMP '
                           + '     , :STATUS) ';

          qryGen.Close;
          qryGen.ParamByName('SEQCPP').AsString := strAutIncPro;
          qryGen.ParamByName('CODEMP').AsString := LeftStr(clbEmpresa.Items[intContador],3);
          qryGen.ParamByName('STATUS').AsString := 'A';
          qryGen.ExecSQL;
        End;
      End;
    End;
  finally
    FreeAndNil(qryGen);
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmCadCupomPromProd.pGravaVendedores(strAutInc: string; pgbProgresso: TcxProgressBar = nil);
var
  qryVendedores: TUniQuery;
begin
  qryVendedores := fCriaQuery;

  Try
    qryVendedores.Close;
    qryVendedores.SQL.Clear;
    qryVendedores.SQL.Text := 'DELETE FROM CPPVEN '
                            + ' WHERE CPV_SEQCPP = :SEQCPP ';
    qryVendedores.ParamByName('SEQCPP').AsString := strAutInc;
    qryVendedores.ExecSQL;

    If cdsVendedores.IsEmpty Then
      Exit;

    qryVendedores.SQL.Clear;
    qryVendedores.SQL.Text := 'INSERT INTO CPPVEN ( '
                            + '       CPV_SEQCPP '
                            + '     , CPV_CODOPE '
                            + '     , CPV_DESCRI '
                            + ') VALUES ( '
                            + '       :CPV_SEQCPP '
                            + '     , :CPV_CODOPE '
                            + '     , :CPV_DESCRI)';

    pInfoStatusGravacao(pgbProgresso, 'Gravando vendedores, por favor aguarde...', cdsVendedores.RecordCount);

    cdsVendedores.First;

    While Not cdsVendedores.Eof Do
    Begin
      pStepStatusGravacao(pgbProgresso);

      qryVendedores.ParamByName('CPV_SEQCPP').AsString := strAutInc;
      qryVendedores.ParamByName('CPV_CODOPE').AsString := cdsVendedoresOPE_CODOPE.AsString;
      qryVendedores.ParamByName('CPV_DESCRI').AsString := cdsVendedoresOPE_NOMOPE.AsString;
      qryVendedores.ExecSQL;

      cdsVendedores.Next;
    End;
  Finally
    FreeAndNil(qryVendedores);
  End;
end;

procedure TfrmCadCupomPromProd.pHabilitaDesabilitaCheckboxAcumulaValor;
begin
  If rdgTipPro.ItemIndex = 0 Then
    chkAcmVal.Enabled := True
  Else
  Begin
    chkAcmVal.Enabled := False;
    chkAcmVal.Checked := False;
  End;
end;

procedure TfrmCadCupomPromProd.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CPP_CODCPP');
  stlCamInd.Add('CPP_DESCPP');
  stlCamInd.Add('CPP_DTAINI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Data Inicial');
end;


procedure TfrmCadCupomPromProd.pIniciaValoresPadrao;
begin
  dbeTipCli.Text    := 'A';
  chkCpcLcs.Checked := False;
  chkAcmVal.Checked := False;
  chkImpCup.Checked := True;
end;

procedure TfrmCadCupomPromProd.pLimpaCAmposItens;
begin
  mskLinhaGrupo.Clear;
  edtDesGrupo.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtMarca.Clear;
  edtDesMarca.Clear;
  edtFornecedor.Clear;
  edtDesFornecedor.Clear;
  edtDescriIni.Clear;
  edtDescriFin.Clear;
  edtRefere.Clear;
  edtUnidade.Clear;
end;

procedure TfrmCadCupomPromProd.pLimpaCamposVendedores;
begin
  edtCodOpe.Clear;
  edtNomOpe.Clear;
  edtCodDep.Clear;
  edtDesDep.Clear;
  cbxTipoOperadores.ItemIndex := -1;
end;

procedure TfrmCadCupomPromProd.pValidaCupomSorteio(strNumCup: String;
  dtaDtaSor: TDate);
var
  qrySorteio: TUniQuery;
begin
  if cdsSorteio.Locate('NUMCUP', strNumCup, []) then
  begin
    fMensagem('AVISO', 'Cupom já inserido!', ['&OK']);
    edtCupSorteio.Clear;
    Exit;
  end;

  qrySorteio := fCriaQuery;

  try
    qrySorteio.Close;
    qrySorteio.SQL.Clear;
    qrySorteio.SQL.Add('SELECT C.AUTOINCREM, G.CPG_NUMDOC, G.CPG_ESPDOC, G.CPG_CODEMP,');
    qrySorteio.SQL.Add('       CONCAT(G.CPG_NUMDOC,"-",G.CPG_ESPDOC,"-",G.CPG_CODEMP) AS DOCUME,');
    qrySorteio.SQL.Add('       IFNULL(G.CPG_CLICPF, G.CPG_CODCLI) AS CODCLI');
    qrySorteio.SQL.Add('FROM CADCPP C');
    qrySorteio.SQL.Add('INNER JOIN CPPGER G');
    qrySorteio.SQL.Add('ON(C.CPP_CODCPP = G.CPG_CODCPP)');
    qrySorteio.SQL.Add('WHERE G.CPG_SEQUEN = :NUMCUP');
    qrySorteio.ParamByName('NUMCUP').AsString := strNumCup;
    qrySorteio.Open;

    if qrySorteio.IsEmpty then
    begin
      fMensagem('AVISO', 'Cupom não encontrado para a promoção!', ['&OK']);
      edtCupSorteio.Clear;
      Exit;
    end;

    cdsSorteio.Append;
    cdsSorteioSEQPRO.AsString := qrySorteio.FieldByName('AUTOINCREM').AsString;
    cdsSorteioCODEMP.AsString := VS_strCodEmp;
    cdsSorteioCODOPE.AsString := strLoginUsuarioLogado;
    cdsSorteioDTAENT.AsDateTime := fRetDataServidor;
    cdsSorteioNUMCUP.AsString := strNumCup;
    cdsSorteioDTASOR.AsDateTime := dtaDtaSor;
    cdsSorteioNUMDOC.AsString := qrySorteio.FieldByName('CPG_NUMDOC').AsString;
    cdsSorteioESPDOC.AsString := qrySorteio.FieldByName('CPG_ESPDOC').AsString;
    cdsSorteioEMPDOC.AsString := qrySorteio.FieldByName('CPG_CODEMP').AsString;
    cdsSorteioCODCLI.AsString := qrySorteio.FieldByName('CODCLI').AsString;
    cdsSorteioDOCUME.AsString := qrySorteio.FieldByName('DOCUME').AsString;
    cdsSorteioCLIENT.AsString := Concat(qrySorteio.FieldByName('CODCLI').AsString, '-', fRetNomCliente(qrySorteio.FieldByName('CODCLI').AsString));
    cdsSorteio.Post;

    edtCupSorteio.Clear;
  finally
    FreeAndNil(qrySorteio);
  end;
end;

procedure TfrmCadCupomPromProd.rdgTipProClick(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaCheckboxAcumulaValor;
end;

end.
