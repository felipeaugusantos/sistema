unit untNegociacaoOrdemServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, cxProgressBar,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Grids, Uni,
  Vcl.DBGrids, DBGridCitel, EditFocus, Vcl.Mask, MaskEditFocus, UniClientDataSet,
  untNegociacaoOS, untLiberacao, StrUtils, Vcl.DBCtrls, DBEditFocus, untTypesSistema,
  untFuncFatImp;

type
  TfrmNegociacaoOrdemServico = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    dbgGridOrdSer: TDBGridCitel;
    lblNumNeg: TLabel;
    lblStaNeg: TLabel;
    lblCliente: TLabel;
    edtNegSta: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlCndHis: TPanel;
    pnlTotais: TPanel;
    pnlMsgDel: TPanel;
    pnlDesconto: TPanel;
    edtNegNum: TEditFocus;
    lblOrdSer: TLabel;
    lblAplDes: TLabel;
    rbSemDes: TRadioButton;
    rbDesPrd: TRadioButton;
    rbDesSer: TRadioButton;
    rbPrdSer: TRadioButton;
    btnIncluir: TBitBtnLocked;
    grbCndPag: TGroupBox;
    pnlCndPag: TPanel;
    lblCndPag: TLabel;
    lblForPag: TLabel;
    edtCodCnd: TEditFocus;
    mskCndPag: TMaskEditFocus;
    edtDesCndPag: TEditFocus;
    edtForPag: TEditFocus;
    edtDesForPag: TEditFocus;
    grbHistorico: TGroupBox;
    dbgGridHisDes: TDBGridCitel;
    pnlButtons: TPanel;
    FlwPnlButtons: TFlowPanel;
    btnGravar: TBitBtnLocked;
    btnFinalizar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnFechar: TBitBtnLocked;
    edtNumOse: TEditFocus;
    dtsOrdSer: TDataSource;
    dtsHisDes: TDataSource;
    lblST: TLabel;
    lblIPI: TLabel;
    lblTotaST: TLabel;
    lblTotIPI: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label32: TLabel;
    lblVlrDes: TLabel;
    lblTotDes: TLabel;
    lblTotGer: TLabel;
    pnlCliente: TPanel;
    lblCliNeg: TLabel;
    dbeNomCli: TDBEditFocus;
    dbeCodCli: TDBEditFocus;
    lblNegEmp: TLabel;
    edtCodEmpNeg: TEditFocus;
    edtDesEmpNeg: TEditFocus;
    lblOSEmp: TLabel;
    edtCodEmpOS: TEditFocus;
    edtDesEmpOS: TEditFocus;
    rbVlrNeg: TRadioButton;
    btnAplicar: TBitBtnLocked;
    pnlValNeg: TPanel;
    edtVlrNeg: TEditFocus;
    lblValNeg: TLabel;
    pnlDesProSer: TPanel;
    pnlDesSer: TPanel;
    Label1: TLabel;
    edtDesSer: TEditFocus;
    pnlDesPro: TPanel;
    edtDesPrd: TEditFocus;
    lblPorDes: TLabel;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumOseKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure edtForPagKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCndEnter(Sender: TObject);
    procedure edtCodCndExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtNegNumKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dbgGridOrdSerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgGridHisDesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNegNumExit(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpNegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpOSKeyPress(Sender: TObject; var Key: Char);
    procedure edtNegNumChange(Sender: TObject);
    procedure edtNumOseChange(Sender: TObject);
    procedure btnAplicarClick(Sender: TObject);
  private
    { Private declarations }
    FblnManterPrecos: Boolean;
    FstrCcnAnt   : String;
    FstrFpgAnt   : String;
    FstrTipDesAnt: String;
    FstrDesApl   : String;
    FfltPerDesAnt: Double;
    FfltPerSerAnt: Double;
    FfltVlrNegAnt: Double;
    FblnMaoSem   : Boolean;
    qryNegOse    : TUniQuery;
    qryEquGer    : TUniQuery;
    qryConCnd    : TUniQuery;
    qryVerifica  : TUniQuery;
    objNegOSE    : TNegociacaoOS;
    objLiberacao : TLiberacao;
    pgbStatus    : TcxProgressBar;
    intDecimal   : Integer;
    stlNegociacaoAltLck: TStringList;

    FfltPreTra      : Double;
    FfltPreTraUni   : Double;
    FfltValMin      : Double;
    FfltTotGer      : Double;
    FfltDesConcedido: Double;
    FfltPerDesConced: Double;
    FfltDesMaximoPer: Double;
    FfltMinCus      : Double;
    FfltPreTab      : Double;
    FfltTotDesSer   : Double;
    FfltDesSerMax   : Double;
    FfltTotalSer    : Double;

    objFatVendaImpNeg: TFatVendaImp;

    procedure pLimparTela;
    procedure pCarregaCondicao;
    procedure pCarregaForPag;
    procedure pDeletaOSGrid;
    procedure pMontaTotais;
    procedure pValidaTipDescontoMarcado;
    procedure pDestravaELimpaStlNegociacaoLck;
    procedure pIncluirOrdensServico;
    procedure pAtualizaTela;
    procedure pAprovarOrdensServico;
    procedure pMostraDocumentosGerados;
    procedure pRadioButtonClick(Sender: TObject);
    procedure pAplicarDescValorNegociado;
    procedure pAplicarDescPercentual;
    procedure pImprimeDocsGerados;
    procedure pCarregaLogItensSep(var cdsLogItensSep: TUniClientDataSet);

    function fMSG_SenhaManterPrecos(astrConPag: String): Boolean;
    function fCarregaNegociacaoComProgres: Boolean;
    function fCalculaDescontosComProgress: Boolean;
    function fFinalizarComProgress: Boolean;
    function fCarregaNegociacao(pgbProgresso: TcxProgressBar = nil): Boolean;
    function fCalculaDesconto(pgbProgresso: TcxProgressBar = nil): Boolean;
    function fAlterouCndFpg: Boolean;
    function fValidaIncluirCliente: Boolean;
    function fValidaIncluirOS: Boolean;
    function fVerificaDescontoMaximo: Boolean;
    function fValidaDescProdutos: Boolean;
    function fValidaDescServicos: Boolean;
    function fRetornaUnitarioTrava(fltUniDig, fltUniOri, fltQtdIte: Double; strCodIte, strTabPre: String): Double;
    function fValidaIncluir: Boolean;
    function fRetornaVrDesconto(fltValUni, fltDesCon: Double): Double;
    function fDescontoMaximoItem(astrCodIte, astrTabPre: String; afltQtdIte: Double): Double;
    function fTravaERegistraStlNegociacaoLck(astrNumNeg, astrCodEmp: String): Boolean;
    function fFinalizar(pgbProgresso: TcxProgressBar = nil): Boolean;
    function fValidaIncluirMultiplasOS(AarrSel: TConsultasArray): Boolean;
    function fValidaDescDigProdutos: Boolean;
    function fValidaDescDigServicos: Boolean;
    function fValidaSemDesconto: Boolean;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  untConsultas, untFuncoesSimples, untPanelCxClientes, untPnlDadosCliente,
  untPanelCxLegendaConsertoEquip, untPnlLegendaConsertoEquip, untPesqAux, untFatSelecaoTabelaPreco,
  untFuncoes, untConstantes, untMensagemNegociacaoOS, untGravando, untFatManConsertoEquip,
  untConsertoEquipAprovacao, untDigCliente, untFuncFatTypes, untFatPedidosImpr,
  untFuncFat;

procedure TfrmNegociacaoOrdemServico.edtCodCndEnter(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtCodCnd.Text)) And (FstrCcnAnt <> edtCodCnd.Text) Then
    FstrCcnAnt := edtCodCnd.Text;
end;

procedure TfrmNegociacaoOrdemServico.edtCodCndExit(Sender: TObject);
begin
  inherited;
  If ((edtCodCnd.Text <> FstrCcnAnt) Or (FstrFpgAnt <> edtForPag.Text)) Then
    pCarregaCondicao;

  If (mskCndPag.Enabled) Then
  Begin
    SelectNext(ActiveControl, True, True)
  End
  Else
    SelectNext(edtCodCnd, True, True);
end;

procedure TfrmNegociacaoOrdemServico.edtCodCndKeyPress(Sender: TObject; var Key: Char);
var
  LarrCnd: TConsultasArray;
  LstrCndCli: String;
begin
  if (fCfgSis('TRACND', varBoolean)) then
    LstrCndCli := edtCodCli.Text
  else
    LstrCndCli := EmptyStr;

  {*******************************}
  {* NOVA CONSULTA DE COND. PGTO *}
  {****************************RV*}
  if edtCodCnd.Enabled and (not edtCodCnd.ReadOnly) then
  begin
    if fPesqCondicoesPgto(Self, edtCodCnd, edtDesCndPag, nil, Key, LarrCnd, True, False,
                          IIF(fCfgSis('PFLCLI', varBoolean), conCndPerfil, conCndSimples),
                          0, 0, LstrCndCli, True) then
    begin
      pCarregaCondicao;

      if fValidaCampos(edtCodCnd, True) then
        SelectNext(ActiveControl, True, True);
    end;
  end;
end;

procedure TfrmNegociacaoOrdemServico.edtCodEmpNegKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  if fPesqEmpresa(conEmpSimples, Self, edtCodEmpNeg, edtDesEmpNeg, nil, Key, arrSel) then
  begin
    if fValidaCampos(edtCodEmpNeg, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmNegociacaoOrdemServico.edtCodEmpOSKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  if fPesqEmpresa(conEmpSimples, Self, edtCodEmpOS, edtDesEmpOS, nil, Key, arrSel) then
  begin
    if fValidaCampos(edtCodEmpOS, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmNegociacaoOrdemServico.edtForPagKeyPress(Sender: TObject; var Key: Char);
var
  LarrForma: TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) and (not edtForPag.ReadOnly) then
  begin
    if fPesqFormaPgto(conFpgBaiAvi, Self, edtForPag, edtDesForPag, nil, Key, LarrForma) then
    begin
      if (fValidaCampos(edtForPag, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    end;
    pCarregaForPag;
  end;
end;

procedure TfrmNegociacaoOrdemServico.edtNegNumChange(Sender: TObject);
begin
  inherited;

  if (not FblnMaoSem) then
    Exit;

  edtCodEmpNeg.Enabled := (not fEmptyStr(edtNegNum.Text));

  if fEmptyStr(edtNegNum.Text) then
  begin
    edtCodEmpNeg.Clear;
    edtDesEmpNeg.Clear;
  end;
end;

procedure TfrmNegociacaoOrdemServico.edtNegNumExit(Sender: TObject);
begin
  inherited;
  objNegOSE.blnNovNeg := fEmptyStr(edtNegNum.Text);
end;

procedure TfrmNegociacaoOrdemServico.edtNegNumKeyPress(Sender: TObject; var Key: Char);
var
  LarrSel: TConsultasArray;
begin
  inherited;

  if fPesqNegociacaoOS(Self, qryNegOse, Key, LarrSel) then
  begin
    edtNegNum.Text    := qryNegOse.FieldByName('NEG_NRONEG').AsString;

    if (not FblnMaoSem) then
      fValidaCampos(edtNegNum, True)
    else
    begin
      edtCodEmpNeg.Text := qryNegOse.FieldByName('NEG_CODEMP').AsString;
      fValidaCampos(edtCodEmpNeg, True);
    end;
  end;
end;

procedure TfrmNegociacaoOrdemServico.edtNumOseChange(Sender: TObject);
begin
  inherited;

  if (not FblnMaoSem) then
    Exit;

  edtCodEmpOS.Enabled := (not fEmptyStr(edtNumOse.Text));

  if fEmptyStr(edtNumOse.Text) then
  begin
    edtCodEmpOS.Clear;
    edtDesEmpOS.Clear;
  end;
end;

procedure TfrmNegociacaoOrdemServico.edtNumOseKeyPress(Sender: TObject; var Key: Char);
var
  LobjfrmPnl: TPanelCxConsertoEquip;
  LarrSel   : TConsultasArray;
  LdtaOS    : TDatetime;
  LstrStatus,
  LstrSubsta,
  LstrSituac,
  LstrFone  : String;
begin
  inherited;
  LstrStatus := SELECT_STATUS_OS;
  LstrSubsta := SELECT_SUBSTA_OS;
  LstrSituac := SELECT_SITUAC_OS;
  LstrFone   := ' IF(IFNULL(EQU_NOMCON, "") <> "", EQU_TELCON, CLI_FONE01) ';

  try
    if fEntraCons(Key) then
    begin
      LobjfrmPnl := TPanelCxConsertoEquip.Create(TfrmPnlLegendaConsertoEquip);
      LobjfrmPnl.blnNegociacao := True;

      if (not fEmptyStr(dbeCodCli.Text)) then
        LobjfrmPnl.strCodCli := dbeCodCli.Text;

      if fPesqOrdServ(Self, edtNumOse, qryEquGer, Key, LarrSel, LdtaOS, LstrStatus, LstrFone, False,
                      'Consulta de Ordens de Serviço', 1, LstrSubsta, LstrSituac, LobjfrmPnl) then
      begin
        if (Length(LarrSel) > 1) then
        begin
          if (not objNegOSE.cdsOrdSer.IsEmpty) and (qryEquGer.FieldByName('EQU_CODCLI').AsString <> objNegOSE.cdsOrdSer.FieldByName('CODCLI').AsString) then
          begin
            fMensagem('ATENÇÃO', 'As OS selecionadas não podem ser incluídas na negociação pois já foram inseridas OS''s de outro cliente. Cliente da negociação:' +
                       #13 + objNegOSE.cdsOrdSer.FieldByName('CODCLI').AsString + ' - ' + objNegOSE.cdsOrdSer.FieldByName('NOMCLI').AsString, ['&Ok']);
            pSetFocus(edtNumOse);
            Exit;
          end;
          qryVerifica := fCriaQuery(Self);

          try
            if fValidaIncluirMultiplasOS(LarrSel) then
            pIncluirOrdensServico;

            pAtualizaTela;
          finally
            FreeAndNil(qryVerifica);
          end;
        end
        else
        begin
          if (not FblnMaoSem) then
            fValidaCampos(edtNumOse, True)
          else
          begin
            edtCodEmpOS.Text := qryEquGer.FieldByName('EQU_CODEMP').AsString;
            fValidaCampos(edtCodEmpOS, True);
          end;
        end;
      end;
    end;
  finally
    pFreeAndNil(LobjfrmPnl);
  end;
end;

function TfrmNegociacaoOrdemServico.fAlterouCndFpg: Boolean;
begin
  Result := ((edtCodCnd.Text <> FstrCcnAnt) And (FstrCcnAnt <> '')) Or ((FstrFpgAnt <> edtForPag.Text) And (FstrFpgAnt <> ''));
end;

procedure TfrmNegociacaoOrdemServico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (Action <> CaNone) And (Assigned(stlNegociacaoAltLck)) Then
  Begin
    pDestravaELimpaStlNegociacaoLck();
    FreeAndNil(stlNegociacaoAltLck);
  End;
end;

procedure TfrmNegociacaoOrdemServico.FormCreate(Sender: TObject);
begin
  inherited;

  qryNegOse    := fCriaQuery(Self);
  qryConCnd    := fCriaQuery(Self);

  qryEquGer    := fCriaQuery(Self);
  qryEquGer.SQL.Text := ' SELECT * FROM EQUGER WHERE FALSE ';

  if (not fCfgSis('USCNFP', varBoolean)) Then
    grbCndPag.Visible := False;

  objNegOSE    := TNegociacaoOS.Create(Nil);
  objLiberacao := TLiberacao.Create;

  stlNegociacaoAltLck := TStringList.Create;
  pLimparTela;
  intDecimal := fCfgSis('DECUNI', varInteger);
  FblnMaoSem := fCfgSis('MAOSEM', varBoolean);

  lblNegEmp.Visible    := FblnMaoSem;
  edtCodEmpNeg.Visible := FblnMaoSem;
  edtDesEmpNeg.Visible := FblnMaoSem;

  lblOSEmp.Visible     := FblnMaoSem;
  edtCodEmpOS.Visible  := FblnMaoSem;
  edtDesEmpOS.Visible  := FblnMaoSem;
end;

procedure TfrmNegociacaoOrdemServico.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(qryNegOse);
  FreeAndNil(qryConCnd);
  FreeAndNil(qryEquGer);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  dbgGridOrdSer.DataSource := Nil;
  dbgGridHisDes.DataSource := Nil;

  dtsOrdSer.DataSet        := Nil;
  dtsHisDes.DataSet        := Nil;

  dbeCodCli.DataSource     := Nil;
  dbeNomCli.DataSource     := Nil;

  FreeAndNil(objNegOSE);
end;

procedure TfrmNegociacaoOrdemServico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F2:  btnGravar.Click;
    VK_F10: btnFinalizar.Click;
    VK_F5:  btnExcluir.Click;
  end;
end;

procedure TfrmNegociacaoOrdemServico.FormShow(Sender: TObject);
begin
  inherited;

  dtsOrdSer.DataSet        := objNegOSE.cdsOrdSer;
  dtsHisDes.DataSet        := objNegOSE.cdsHisDes;

  dbgGridOrdSer.DataSource := dtsOrdSer;
  dbgGridHisDes.DataSource := dtsHisDes;

  dbeCodCli.DataSource := dtsOrdSer;
  dbeNomCli.DataSource := dtsOrdSer;

  rbSemDes.OnClick := pRadioButtonClick;
  rbDesPrd.OnClick := pRadioButtonClick;
  rbDesSer.OnClick := pRadioButtonClick;
  rbPrdSer.OnClick := pRadioButtonClick;
  rbVlrNeg.OnClick := pRadioButtonClick;
end;

procedure TfrmNegociacaoOrdemServico.btnAplicarClick(Sender: TObject);
begin
  inherited;

  if (objNegOSE.cdsOrdSer.IsEmpty) then
  begin
    edtDesPrd.Clear;
    edtDesSer.Clear;
    Exit;
  end;

  if (rbVlrNeg.Checked) then
    pAplicarDescValorNegociado
  else
    pAplicarDescPercentual;
end;

procedure TfrmNegociacaoOrdemServico.btnExcluirClick(Sender: TObject);
begin
  inherited;

  if (not btnExcluir.Enabled) then
    Exit;

  if fMensagem('ATENÇÃO', 'Confirma a exclusão da negociação?', ['&Sim', '&Não']) = 1 then
  begin
    try
      if objNegOSE.fExcluirNegociacao(Self.Name) then
      begin
        fMensagem('', 'Negociação ' + objNegOSE.strNumNeg + ' excluída com sucesso!', ['&Ok']);
        pLimparTela;
      end;
    except on E: Exception do
      pMensagensErro(e.Message, 'btnExcluirClick - untNegociacaoOrdemServico');
    end;
  end;
end;

procedure TfrmNegociacaoOrdemServico.btnFinalizarClick(Sender: TObject);
begin
  inherited;

  if (not btnFinalizar.Enabled) then
    Exit;

  if (objNegOSE.cdsOrdSer.IsEmpty) then
  begin
    fMensagem('AVISO', 'Não foram informadas ordens de serviço para negociação!', ['&Ok']);
    Exit;
  end;

  if (fVerificaCampos) then
  begin
    if fMensagem('ATENÇÃO', 'Ao finalizar a negociação o sistema atualizará os valores nas ordens ' +
      'de serviço e depois disto não será mais possível alterar a negociação. Deseja realmente continuar?', ['&Sim', '&Não']) = 1 then
    begin
      try
        if fFinalizarComProgress then
        begin
          if fMensagem('ATENÇÃO', 'Deseja aprovar todas as ordens de serviço desta negociação?', ['&Sim', '&Não']) = 1 then
            pAprovarOrdensServico;

          fMensagem('', 'Negociação ' + objNegOSE.strNumNeg + ' finalizada e ativada com sucesso!', ['&Ok']);
          pLimparTela;
        end;
      except
        on e:exception do
          pMensagensErro(e.Message, 'btnFinalizarClick - untNegociacaoOrdemServico');
      end;
    end;
  end;
end;

procedure TfrmNegociacaoOrdemServico.btnGravarClick(Sender: TObject);
begin
  inherited;

  if (not btnGravar.Enabled) then
    Exit;

  try
    if (objNegOSE.cdsOrdSer.IsEmpty) then
    begin
      fMensagem('AVISO', 'Não foram informadas ordens de serviço para negociação!', ['&Ok']);
      Exit;
    end;

    if (fVerificaCampos) then
    begin
      if (objNegOSE.blnNovNeg) then
      begin
        objNegOSE.strCodEmp := VS_strCodEmp;
        objNegOSE.strCodOpe := strLoginUsuarioLogado;
        objNegOSE.dtaDtaCad := nOw;
        objNegOSE.strStatus := 'A';
      end;

      objNegOSE.strCodCli := objNegOSE.cdsOrdSer.FieldByName('CODCLI').AsString;
      objNegOSE.strCodCnd := edtCodCnd.Text;
      objNegOSE.strCodFpg := edtForPag.Text;
      objNegOSE.strConPag := mskCndPag.Text;

      if (objNegOSE.fGravarNegociacao) then
      begin
        if fMensagem('ATENÇÃO', 'Negociação ' + objNegOSE.strNumNeg + ' gravada com sucesso. Deseja já finalizar e ativar a negociação?', ['&Sim', '&Não'], 2) = 1 then
        begin
          objNegOSE.blnFinGra := True;
          objNegOSE.blnNovNeg := False;
          edtNegNum.Text := objNegOSE.strNumNeg;
          btnFinalizar.Enabled := True;
          btnFinalizar.Click;
        end;

        pLimparTela;
      end;
    end;
  except
    on e:exception do
      pMensagensErro(e.Message, 'btnGravarClick - untNegociacaoOrdemServico');
  end;
end;

procedure TfrmNegociacaoOrdemServico.btnIncluirClick(Sender: TObject);
var
  LblnIncluir: Boolean;
begin
  inherited;

  qryVerifica := fCriaQuery(Self);

  try
    LblnIncluir := fValidaIncluir;

    if LblnIncluir then
      pIncluirOrdensServico;

    pAtualizaTela;
  finally
    FreeAndNil(qryVerifica);
  end;
end;

procedure TfrmNegociacaoOrdemServico.dbgGridHisDesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then
    pEscapePressed;
end;

procedure TfrmNegociacaoOrdemServico.dbgGridOrdSerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_ESCAPE: pEscapePressed;
    VK_DELETE:
      begin
        if (edtNegSta.Text <> 'FINALIZADA') then
          pDeletaOSGrid;
      end;
  end;
end;

procedure TfrmNegociacaoOrdemServico.edtCodCliKeyPress(Sender: TObject; var Key: Char);
var
  LarrClientes: TConsultasArray;
  LobjfrmPnl  : TPanelCxClientes;
begin
  inherited;

  try
    try
      LobjfrmPnl            := TPanelCxClientes.Create(TfrmPnlDadosCliente);
      LobjfrmPnl.strNomForm := Self.Name;
      if fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, LarrClientes,true,LobjfrmPnl) Then
      begin
        if fValidaCampos(edtCodCli, True) then
        begin
          if not fEmptyStr(edtCodCli.Text) then
            pSetFocus(btnIncluir)
          else
            SelectNext(ActiveControl, True, True);
        end;
      end;
    except
      On E: Exception Do
        pMensagensErro(E.Message, '[pCodCliKeyPress]');
    end;
  finally
    pFreeAndNil(LobjfrmPnl);
  end;
end;

function TfrmNegociacaoOrdemServico.fRetornaVrDesconto(fltValUni, fltDesCon: Double): Double;
begin
  Result := fltDesCon;

  if (fCfgSis('TIPDES') = '%') then
    Result := fFormataFloat((fltValUni * fltDesCon) / 100, 04);
end;

function TfrmNegociacaoOrdemServico.fTravaERegistraStlNegociacaoLck(astrNumNeg, astrCodEmp: String): Boolean;
var
  LstrAux: String;
begin
  Result := False;

  LstrAux := 'MANEQU_' + astrNumNeg + '_' + astrCodEmp;

  If Not fLock_Unlock(LstrAux, True, False) Then
  Begin
    fMensagem('Atenção', 'Esta Negociação está sendo utilizada em outra estação por ' + fGetHostLock(LstrAux) + '!', ['&OK']);

    Result := True;
  End
  Else
    stlNegociacaoAltLck.Add(LstrAux);
end;

function TfrmNegociacaoOrdemServico.fDescontoMaximoItem(astrCodIte, astrTabPre: String; afltQtdIte: Double): Double;
begin
  if fCfgSis('ITETBP', VarBoolean) then
    Result := fCampoTabela('ITE_DESMAX', 'ITETBP', ['ITE_CODITE', 'ITE_CODEMP', 'ITE_TABPRE'],
                          [astrCodIte, VS_strCodEmp, astrTabPre])

  else if fCfgSis('DMVFQV', VarBoolean) then
    Result := GetDesMaxFaixaQtde(astrCodIte, VS_strCodEmp, afltQtdIte)
  else
    Result := fCampoTabela('ITE_DESMAX', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [astrCodIte, VS_strCodEmp]);
end;

function TfrmNegociacaoOrdemServico.fFinalizar(pgbProgresso: TcxProgressBar): Boolean;
begin
  objNegOSE.strCodCli := objNegOSE.cdsOrdSer.FieldByName('CODCLI').AsString;
  objNegOSE.strCodCnd := edtCodCnd.Text;
  objNegOSE.strCodFpg := edtForPag.Text;
  objNegOSE.strConPag := mskCndPag.Text;
  objNegOSE.blnAtuCnd := grbCndPag.Visible;

  Result := objNegOSE.fFinalizarNegociacao;
end;

function TfrmNegociacaoOrdemServico.fFinalizarComProgress: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  try
    pgbStatus := frmGravando.pgbStatus;
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.lblGravando.Caption := 'Aguarde, Finalizando Negociação...';
    frmGravando.fExecutarAcao := fFinalizar;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  finally
    pFreeAndNil(frmGravando);
  end;
end;

function TfrmNegociacaoOrdemServico.fRetornaUnitarioTrava(fltUniDig, fltUniOri,
  fltQtdIte: Double; strCodIte, strTabPre: String): Double;
var
  qryIte     : TUniQuery;
  fltTraFat,
  fltPreTra  : Double;
begin
  fltTraFat    := 0.00;
  fltPreTra    := 0.00;
  qryIte       := fCriaQuery;

  If (fCfgSis('TRDEOS') = '1') Then
  Begin
    If fEmptyStr(strTabPre) Then
      strTabPre := '1'; //PADRAO

    If (strToInt(strTabPre) In [1..Length(VS_STRTABPRC)]) Then
      fltTraFat := fCfgSis('TFTOS' + strTabPre, varDouble);

    fltPreTra := fltUniOri * fltTraFat;
  End
  Else If (fCfgSis('TRDEOS') = '2') Then
  Begin
    fltPreTra := fFormataFloat(fltUniOri, intDecimal) -
                 fRetornaVrDesconto(fFormataFloat(fltUniOri, intDecimal), fDescontoMaximoItem(strCodIte, strTabPre, fltQtdIte));
  End;

  Result := fFormataFloat(fltPreTra, intDecimal);

  FreeAndNil(qryIte);
end;

function TfrmNegociacaoOrdemServico.fMSG_SenhaManterPrecos(astrConPag: String): Boolean;
Begin
  Result := True;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Senha para Manter os Preços da Ordem de Serviço Quando Trocar a Condição de Pagamento');
  objLiberacao.objMsgLibera.pAddSeparador(75);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cnd.Pagto Anterior'        , fFormataCondPag(FstrCcnAnt)                                         , 24);
  objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagto Anterior'   , FstrFpgAnt + ' - ' + fRetDesFpg(FstrFpgAnt)                          , 24);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cnd.Pagto'                 , fFormataCondPag(astrConPag)                                         , 24);
  objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagto'            , edtForPag.Text + ' - ' + edtDesForPag.Text                         , 24);
  objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'        , FormatFloat('#,##0.00', objNegOSE.fltTotGer)                       , 24);

  objLiberacao.strDirAce := 'SENEQU';
  objLiberacao.strSenLib := fCfgSis('SENEQU');
  objLiberacao.strMsgSen := 'Senha para manter os preços da venda quando trocar a condição de pagamento';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCliente := objNegOSE.strCodCli + '-' + objNegOSE.strNomCli;
  objLiberacao.strCpfCnpj := objNegOSE.strCgcCli;

  if Not objLiberacao.fLibera then
    Result := False;
end;

function TfrmNegociacaoOrdemServico.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  LstrConPag: String;
  LblnManterPrecos: Boolean;
begin
  Result := True;

  if (Sender = edtNegNum) then
  begin
    if not fEmptyStr(edtNegNum.Text) and (not edtCodEmpNeg.Visible) and (blnBuscaPorChave) then
      Result := fCarregaNegociacaoComProgres;
  end
  else if (Sender = edtCodEmpNeg) and (edtCodEmpNeg.Visible) and (blnBuscaPorChave) then
  begin
    edtDesEmpNeg.Text := fRetNomeEmpresaSelec(edtCodEmpNeg.Text);

    if fEmptyStr(edtCodEmpNeg.Text) then
    begin
      fMensagem('', 'Informe o código da empresa!', ['&OK']);
      Result := False;
    end
    else if fEmptyStr(edtDesEmpNeg.Text) then
    begin
      fMensagem('', 'O código da empresa informado não é válido!', ['&OK']);
      Result := False;
    end
    else if not fEmptyStr(edtNegNum.Text) and (blnBuscaPorChave) then
      Result := fCarregaNegociacaoComProgres;
  end
  else if (Sender = edtCodCli) then
  begin
    edtNomCli.Clear;

    if not fEmptyStr(edtCodCli.Text) then
    begin
      edtNumOse.Clear;
      edtCodCli.Text := fPadL(edtCodCli.Text, edtCodCli.TamCampo, '0');
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

      if fEmptyStr(edtNomCli.Text) then
      begin
        fMensagem('AVISO', 'Cliente não encontrado!', ['&Ok']);
        edtCodCli.Clear;
        edtNomCli.Clear;
        Result := False;
      end;
    end;
  end
  else if (Sender = edtNumOse) then
  begin
    if not fEmptyStr(edtNumOse.Text) then
    begin
      edtNumOse.Text := fPadL(edtNumOse.Text, edtNumOse.TamCampo, '0');
      edtCodCli.Clear;
      edtNomCli.Clear;

      if (not edtCodEmpOS.Visible) and (not objNegOSE.fVerificaExisteOrdSer(edtNumOse.Text, VS_strCodEmp)) then
      begin
        fMensagem('AVISO', 'Ordem de Serviço não encontrada!', ['&Ok']);
        edtNumOse.Clear;
        Result := False;
      end;
    end;
  end
  else if (Sender = edtCodEmpOS) and (edtCodEmpOS.Visible) and (blnBuscaPorChave) then
  begin
    edtDesEmpOS.Text := fRetNomeEmpresaSelec(edtCodEmpOS.Text);

    if fEmptyStr(edtCodEmpOS.Text) then
    begin
      fMensagem('', 'Informe o código da empresa!', ['&OK']);
      Result := False;
    end
    else if fEmptyStr(edtDesEmpOS.Text) then
    begin
      fMensagem('', 'O código da empresa informado não é válido!', ['&OK']);
      Result := False;
    end
    else if not fEmptyStr(edtNumOse.Text) and (not objNegOSE.fVerificaExisteOrdSer(edtNumOse.Text, edtCodEmpOS.Text)) and (blnBuscaPorChave) then
    begin
      fMensagem('AVISO', 'Ordem de Serviço não encontrada!', ['&Ok']);
      edtNumOse.Clear;
      Result := False;
    end;
  end
  else if (Sender = edtCodCnd) And ((grbCndPag.Visible) or (blnBuscaPorChave)) then
  begin
    if fEmptyStr(edtCodCnd.Text) and fEmptyStr(FstrCcnAnt) then
    begin
      fMensagem('ATENÇÃO', 'A condição deve ser preenchida!', ['&O k']);
      pSetFocus(edtCodCnd);
      Result := False;
    End
    Else If Result And (fCfgSis('USACND', varBoolean)) And (Not fEmpresaTemAcessoCondicaoPagto(edtCodCnd.Text)) Then
    Begin
      fMensagem('ATENÇÃO', 'Empresa sem acesso para utilizar esta condição. Verifique o Cadastro de Condições de Pagamento - Aba "Empresas Acesso".' , ['&O k']);
      Result := False;
    End

    Else If Not fCondicaoPagamentoClienteOk('PD', edtCodCnd.Text, 'C', edtCodCli.Text) Then
      Result := False;

    If fAlterouCndFpg Then
    Begin

      if fCfgSis('EQUCND', varString) = 'I' then
        pCarregaCondicao;

      If qryConCnd.FieldByName('CND_CODIGO').IsNull Then
      Begin
        fMensagem('ATENÇÃO', 'Essa condição não está cadastrada!', ['&O k']);
        Result := False;
      End;

      If (Result) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'A condição de pagamento deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaCndPag(mskCndPag.Text, LstrConPag, VS_Date) Then
        Begin
          fMensagem('ATENÇÃO', 'Essa condição de pagamento ' + fFormataCondPag(mskCndPag.Text) + ' ' +
                                'não é valida!' + #13#10 +
                                'Verifique se informou todas as parcelas e se as mesmas estão em ordem progressiva, ' +
                                'exemplos válidos: (01)000, (01)030, (03)030.060.090', ['&O k']);
          Result := False;
        End
        Else If fEmptyStr(mskCndPag.Text) Then
        Begin
          Result := False;
        End;

        {*****************************************}
        {* CASO A CONDIÇÃO ESTEJA OK             *}
        {**************************************MV*}
        If (Result) Then
        Begin
          LblnManterPrecos := False;
          If (fCfgSis('CNDVEN') = 'I') And (fCfgSis('EQUMPO', varBoolean)) Then
          Begin
            If (fMensagem('AVISO', 'Deseja manter os preços originais?', ['&Sim', '&Não'], 2) = 1) Then
            Begin
              LblnManterPrecos := True;

              If (Not (fEmptyStr(fCfgSis('SENEQU')))) Then
              Begin
                if not fEmptyStr(objNegOSE.strCodCli) then
                  Result := fMSG_SenhaManterPrecos(LstrConPag);

                LblnManterPrecos := Result;

                if Not(Result) then
                begin
                  fMensagem('','Senha incorreta!',['&OK']);
                end;
              end;
            End;

            FblnManterPrecos := LblnManterPrecos;
          end;

          mskCndPag.Text := LstrConPag;
          FstrFpgAnt     := edtForPag.Text;
        end;
        FstrCcnAnt := edtCodCnd.Text;
      end;
    end;
  end
  else if (Sender = edtForPag) and ((pnlCndPag.Visible) or blnBuscaPorChave) then
  begin
    if fEmptyStr(edtForPag.Text) and fEmptyStr(FstrFpgAnt) then
    begin
      fMensagem('','O campo forma de pagamento deve ser preenchido!',['&OK']);
      Result := False;
    end
    else if (edtForPag.Text = '009') then
    begin
      fMensagem('ATENÇÃO', 'Esta condição não pode ser utilizada em Conserto de Equipamentos!', ['&O k']);
      Result := False;
    end
    else if fRetornaStatusCadastro(edtForPag.Text, 'FPG', 'CADFPG', 'FPG_CODIGO') <> 'A' then
    begin
      fMensagem('ATENÇÃO', 'Esta forma de pagamento não pode ser utilizada pois está inativa!', ['&O k']);
      Result := False;
    end
    else
    begin
      pCarregaForPag;

      if fEmptyStr(edtDesForPag.Text) then
      begin
        fMensagem('','Forma de pagamento não encontrada!',['&OK']);
        Result := False;
      end;
    end;

    if (fStatusCndPag(mskCndPag.Text) = A_VISTA) and
       (Pos(edtForPag.Text,'008_010_') > 0)      and
       (mskCndPag.Text <> '01999')               then
    begin
      fMensagem('','A forma de pagamento deve ser a vista!',['&OK']);
      Result := False;
    end;

    if (Result) and (not fEmptyStr(edtForPag.Text)) and (not fEmptyStr(mskCndPag.Text)) then
    begin
      if Pos(edtForPag.Text,'001_006_' + IIF(fCfgSis('PRACHC',varBoolean),'','002_007_')) > 0 then
      begin
        if (fStatusCndPag(mskCndPag.Text) <> A_VISTA) And (mskCndPag.Text <> '01999') then
        begin
          fMensagem('','A condição de pagamento deve ser a vista!',['&OK']);
          Result := False;
        end;
      end;
    end;
  end;
end;

function TfrmNegociacaoOrdemServico.fValidaDescDigProdutos: Boolean;
begin
  Result := True;

  if (not rbDesPrd.Checked) and (not rbPrdSer.Checked) then
    Exit;

  if (fEmptyStr(edtDesPrd.Text)) then
  begin
    Result := False;
    fMensagem('ATENÇÃO', 'Informe a porcentagem de desconto dos produtos.', ['&Ok']);
    Exit;
  end;

  if (fStrToFloat(edtDesPrd.Text) <= 0) or (fStrToFloat(edtDesPrd.Text) > 100) then
  begin
    Result := False;
    fMensagem('', 'O percentual de desconto dos produtos deve ser maior que 0 e menor que 100!', ['&Ok']);
    edtDesPrd.Clear;
    Exit;
  end;
end;

function TfrmNegociacaoOrdemServico.fValidaDescDigServicos: Boolean;
begin
  Result := True;

  if (not rbDesSer.Checked) and (not rbPrdSer.Checked) then
    Exit;

  if (fEmptyStr(edtDesSer.Text)) then
  begin
    Result := False;
    fMensagem('ATENÇÃO', 'Informe a porcentagem de desconto dos serviços.', ['&Ok']);
    Exit;
  end;

  if (fStrToFloat(edtDesSer.Text) <= 0) or (fStrToFloat(edtDesSer.Text) > 100) then
  begin
    Result := False;
    fMensagem('', 'O percentual de desconto dos serviços deve ser maior que 0 e menor que 100!', ['&Ok']);
    edtDesSer.Clear;
    Exit;
  end;
end;

function TfrmNegociacaoOrdemServico.fValidaDescProdutos: Boolean;
var
  cdsDados           : TUniClientDataSet;
  qryAux             : TUniQuery;
begin
  Result := False;
  qryAux := fCriaQuery;
  cdsDados := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, objNegOSE.cdsOrdSer);

  cdsDados.Filtered := False;
  cdsDados.Filter   := objNegOSE.cdsOrdSer.Filter;
  cdsDados.Filtered := True;

  try
    if (FstrDesApl = 'P') or (FstrDesApl = 'PS') then
    begin
      qryAux.SQL.Text := ' SELECT * FROM EQUDET WHERE EQU_SEQGER = :SEQGER ';
      cdsDados.First;

      while not cdsDados.Eof do
      begin
        qryAux.Close;
        qryAux.ParamByName('SEQGER').AsString := cdsDados.FieldByName('SEQGER').AsString;
        qryAux.Open;

        while not qryAux.Eof do
        begin
          if (qryAux.FieldByName('EQU_BRINDE').AsString <> 'S') and
             (not fEhItemServico(qryAux.FieldByName('EQU_CODITE').AsString)) then
          begin
            FfltPreTraUni := fFormataFloat(fRetornaUnitarioTrava(qryAux.FieldByName('EQU_UNITAR').AsFloat,
                                                                qryAux.FieldByName('EQU_UNIORI').AsFloat,
                                                                qryAux.FieldByName('EQU_QTDITE').AsFloat,
                                                                qryAux.FieldByName('EQU_CODITE').AsString,
                                                                qryAux.FieldByName('EQU_TABPRE').AsString), intDecimal);

            FfltPreTra := FfltPreTra + FfltPreTraUni;
            FfltPreTab := FfltPreTab + fFormataFloat((qryAux.FieldByName('EQU_UNIORI').AsFloat * qryAux.FieldByName('EQU_QTDITE').AsFloat), intDecimal);
            FfltValMin := FfltValMin + fFormataFloat((FfltPreTraUni * qryAux.FieldByName('EQU_QTDITE').AsFloat), intDecimal);

            if (FstrDesApl = 'P') then
              FfltTotGer := FfltTotGer + qryAux.FieldByName('EQU_TOTITE').AsFloat -
                (qryAux.FieldByName('EQU_TOTITE').AsFloat / cdsDados.FieldByName('TOTPRO').AsFloat) *
                ((cdsDados.FieldByName('TOTPRO').AsFloat / objNegOSE.fltTotPro) * objNegOSE.fltVlrDes)
            else
              FfltTotGer := FfltTotGer + qryAux.FieldByName('EQU_TOTITE').AsFloat -
                (qryAux.FieldByName('EQU_TOTITE').AsFloat / cdsDados.FieldByName('TOTPRO').AsFloat) *
                ((cdsDados.FieldByName('TOTPRO').AsFloat / cdsDados.FieldByName('TOTOSE').AsFloat) *
                ((cdsDados.FieldByName('TOTOSE').AsFloat / objNegOSE.fltTotOse) * objNegOSE.fltVlrDes));

            FfltMinCus := FfltMinCus + fFormataFloat((qryAux.FieldByName('EQU_TOTCUS').AsFloat), intDecimal);
          End;

          qryAux.Next;
        end;

        cdsDados.Next;
      end;

      Result := (fFormataFloat(FfltTotGer, 2) < fFormataFloat(FfltValMin, 2));
    end;
  finally
    FreeAndNil(cdsDados);
    FreeAndNil(qryAux);
  end;
end;

function TfrmNegociacaoOrdemServico.fValidaDescServicos: Boolean;
var
  cdsDados: TUniClientDataSet;
  qryAux  : TUniQuery;
begin
  Result := False;
  qryAux := fCriaQuery;
  cdsDados := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, objNegOSE.cdsOrdSer);

  cdsDados.Filtered := False;
  cdsDados.Filter   := objNegOSE.cdsOrdSer.Filter;
  cdsDados.Filtered := True;

  try
    if (FstrDesApl = 'S') or (FstrDesApl = 'PS') then
    begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT EQUSER.*, CADSER.SER_DESMAX FROM EQUSER ');
      qryAux.SQL.Add(' INNER JOIN CADSER ON EQUSER.EQU_CODSER = CADSER.SER_CODSER ');
      qryAux.SQL.Add(' WHERE EQU_SEQGER = :SEQGER ');

      cdsDados.First;

      while not cdsDados.Eof do
      begin
        qryAux.Close;
        qryAux.ParamByName('SEQGER').AsString := cdsDados.FieldByName('SEQGER').AsString;
        qryAux.Open;

        if (not qryAux.IsEmpty) then
        begin
          while not qryAux.Eof do
          begin
            FfltDesSerMax := FfltDesSerMax + ((qryAux.FieldByName('SER_DESMAX').AsFloat / 100) * qryAux.FieldByName('EQU_VALUNI').AsFloat);

            qryAux.Next;
          end;

          if (FstrDesApl = 'S') then
            FfltTotDesSer := FfltTotDesSer + (cdsDados.FieldByName('TOTSER').AsFloat / objNegOSE.fltTotSer) * objNegOSE.fltVlrDes
          else
            FfltTotDesSer := FfltTotDesSer + ((cdsDados.FieldByName('TOTSER').AsFloat / cdsDados.FieldByName('TOTOSE').AsFloat) * ((cdsDados.FieldByName('TOTSER').AsFloat / objNegOSE.fltTotSer) * objNegOSE.fltVlrDes));
        end;

        FfltTotalSer := FfltTotalSer + cdsDados.FieldByName('TOTSER').AsFloat;

        cdsDados.Next;
      end;

      Result := FfltDesSerMax < FfltTotDesSer;
    end;
  finally
    FreeAndNil(cdsDados);
    FreeAndNil(qryAux);
  end;
end;

function TfrmNegociacaoOrdemServico.fValidaIncluir: Boolean;
begin
  if (fEmptyStr(edtCodCli.Text)) and
      (fEmptyStr(edtNumOse.Text)) then
  begin
    fMensagem('AVISO', 'Informe um cliente ou uma ordem de serviço.', ['&Ok']);
    Result := False;
    Exit;
  end;

  if not fEmptyStr(edtCodCli.Text) then
  begin
    if not fValidaCampos(edtCodCli, True) then
    begin
      Result := False;
      Exit;
    end;

    Result := fValidaIncluirCliente;
  end
  else
  begin
    if not fValidaCampos(edtNumOse, True) then
    begin
      Result := False;
      Exit;
    end;

    Result := fValidaIncluirOS;
  end;
end;

function TfrmNegociacaoOrdemServico.fValidaIncluirCliente: Boolean;
var
  frmMensagemNegociacaoOS: TfrmMensagemNegociacaoOS;
begin
  Result := False;

  if not objNegOSE.cdsOrdSer.IsEmpty then
  begin
    if (edtCodCli.Text <> objNegOSE.cdsOrdSer.FieldByName('CODCLI').AsString) then
    begin
      fMensagem('ATENÇÃO', 'O cliente informado não pode ser incluído na negociação pois já foram inseridas OS''s de outro cliente. Cliente da negociação:' +
                 #13 + objNegOSE.cdsOrdSer.FieldByName('CODCLI').AsString + ' - ' + objNegOSE.cdsOrdSer.FieldByName('NOMCLI').AsString, ['&Ok']);
      pSetFocus(edtCodCli);
      Exit;
    end;
  end;

  objNegOSE.pVerificaNegociacoes(qryVerifica, 'C', edtCodCli.Text, IIF((not FblnMaoSem), VS_strCodEmp, ''));

  qryVerifica.Filtered := False;
  qryVerifica.Filter   := ' EQUSTA=''F'' ';
  qryVerifica.Filtered := True;

  {* Verifica se encontrou OS com orçamento realizado para o cliente informado *}
  if qryVerifica.IsEmpty then
  begin
    fMensagem('AVISO', 'Não foram encontradas Ordens de Serviço com orçamento realizado para o cliente informado.', ['&Ok']);
    pSetFocus(edtCodCli);
    Exit;
  end;

  qryVerifica.Filtered := False;
  qryVerifica.Filter   := ' NRONEG IS NOT NULL AND EQUSTA = ''F'' ';
  if not objNegOSE.blnNovNeg then
    qryVerifica.Filter := qryVerifica.Filter + ' AND NRONEG <> ''' + edtNegNum.Text + '';
  qryVerifica.Filtered := True;

  {*** Verifica se há ordens de serviço do cliente informado com negociação ***}
  if not qryVerifica.IsEmpty then
  begin
    pCriarFormularios(TfrmMensagemNegociacaoOS, frmMensagemNegociacaoOS);

    try
      frmMensagemNegociacaoOS.dtsNegociacoes.DataSet := qryVerifica;
      frmMensagemNegociacaoOS.ShowModal;
    finally
      pFreeAndNil(frmMensagemNegociacaoOS);
    end;
  end;

  Result := True;
end;

function TfrmNegociacaoOrdemServico.fValidaIncluirMultiplasOS(AarrSel: TConsultasArray): Boolean;
var
  frmMensagemNegociacaoOS: TfrmMensagemNegociacaoOS;
begin
  Result := False;

  objNegOSE.pVerificaNegociacoes(qryVerifica, 'M', '', '', AarrSel);

  qryVerifica.Filtered := False;
  qryVerifica.Filter   := ' EQUSTA=''F'' ';
  qryVerifica.Filtered := True;

  {* Verifica se encontrou OS com orçamento realizado para o cliente informado *}
  if qryVerifica.IsEmpty then
  begin
    fMensagem('AVISO', 'Não foram encontradas Ordens de Serviço com orçamento realizado entre as OS selecionadas.', ['&Ok']);
    pSetFocus(edtCodCli);
    Exit;
  end;

  qryVerifica.Filtered := False;
  qryVerifica.Filter   := ' NRONEG IS NOT NULL AND EQUSTA = ''F'' ';
  if not objNegOSE.blnNovNeg then
    qryVerifica.Filter := qryVerifica.Filter + ' AND NRONEG <> ''' + edtNegNum.Text + '';
  qryVerifica.Filtered := True;

  {*** Verifica se há ordens de serviço do cliente informado com negociação ***}
  if not qryVerifica.IsEmpty then
  begin
    pCriarFormularios(TfrmMensagemNegociacaoOS, frmMensagemNegociacaoOS);

    try
      frmMensagemNegociacaoOS.dtsNegociacoes.DataSet := qryVerifica;
      frmMensagemNegociacaoOS.ShowModal;
    finally
      pFreeAndNil(frmMensagemNegociacaoOS);
    end;
  end;

  Result := True;
end;

function TfrmNegociacaoOrdemServico.fValidaIncluirOS: Boolean;
var
  frmMensagemNegociacaoOS: TfrmMensagemNegociacaoOS;
begin
  Result := False;

  objNegOSE.pVerificaNegociacoes(qryVerifica, 'O', edtNumOse.Text, IIF(FblnMaoSem, edtCodEmpOS.Text, VS_strCodEmp));

  {* Verifica se a OS está com orçamento realizado *}
  if (qryVerifica.FieldByName('EQUSTA').AsString = 'E') then
  begin
    fMensagem('ATENÇÃO', 'A OS informada ainda não teve o orçamento realizado e por isso, não pode ser negociada.', ['&Ok']);
    pSetFocus(edtNumOse);
    Exit;
  end;

  if (qryVerifica.FieldByName('EQUSTA').AsString <> 'E') and (qryVerifica.FieldByName('EQUSTA').AsString <> 'F') then
  begin
    fMensagem('ATENÇÃO', 'Não é possível negociar a OS informada pois a mesma se encontra com status: ' + qryVerifica.FieldByName('DESSTA').AsString + '.', ['&Ok']);
    pSetFocus(edtNumOse);
    Exit;
  end;

  if not objNegOSE.cdsOrdSer.IsEmpty then
  begin
    if (qryVerifica.FieldByName('CODCLI').AsString <> objNegOSE.cdsOrdSer.FieldByName('CODCLI').AsString) then
    begin
      fMensagem('ATENÇÃO', 'A OS informada não pode ser incluída na negociação pois já foram inseridas OS''s de outro cliente. Cliente da negociação:' +
                 #13 + objNegOSE.cdsOrdSer.FieldByName('CODCLI').AsString + ' - ' + objNegOSE.cdsOrdSer.FieldByName('NOMCLI').AsString, ['&Ok']);
      pSetFocus(edtNumOse);
      Exit;
    end;
  end;

  qryVerifica.Filtered := False;
  qryVerifica.Filter   := ' NRONEG IS NOT NULL ';
  if (not objNegOSE.blnNovNeg) then
    qryVerifica.Filter := qryVerifica.Filter + ' AND NRONEG <> ''' + edtNegNum.Text + '';
  qryVerifica.Filtered := True;

  {*** Verifica se há ordens de serviço do cliente informado com negociação ***}
  if not qryVerifica.IsEmpty then
  begin
    if (qryVerifica.FieldByName('STATUS').AsString = 'EM ABERTO') then
    begin
      fMensagem('AVISO', 'Não é permitido inserir esta OS pois ela já foi negociada anteriormente. Número da negociação: ' +
                 qryVerifica.FieldByName('NRONEG').AsString, ['&Ok']);
      pSetFocus(edtNumOse);
      Exit;
    end
    else
    begin
      pCriarFormularios(TfrmMensagemNegociacaoOS, frmMensagemNegociacaoOS);

      try
        frmMensagemNegociacaoOS.dtsNegociacoes.DataSet := qryVerifica;
        frmMensagemNegociacaoOS.ShowModal;
      finally
        pFreeAndNil(frmMensagemNegociacaoOS);
      end;
    end;
  end;

  Result := True;
end;

function TfrmNegociacaoOrdemServico.fValidaSemDesconto: Boolean;
begin
  Result := True;

  if (not rbSemDes.Checked) then
    Exit;

  if ((objNegOse.fltPerDes > 0) or (objNegOse.fltPerSer > 0)) then
  begin
    if (fMensagem('ATENÇÃO', 'Deseja zerar os descontos aplicados nos produtos e serviços?', ['&Sim', '&Não']) = 2) then
      Result := False;
  end
  else
    Result := False;
end;

function TfrmNegociacaoOrdemServico.fVerificaDescontoMaximo: Boolean;
var
  LblnPrdDescMaiorMax: Boolean;
  LblnSerDescMaiorMax: Boolean;
begin
  Result := True;

  FfltValMin          := 0;
  FfltTotGer          := 0;
  FfltMinCus          := 0;
  FfltPreTab          := 0;
  FfltPreTra          := 0;
  FfltTotDesSer       := 0;
  FfltDesSerMax       := 0;
  FfltTotalSer        := 0;

  LblnPrdDescMaiorMax := fValidaDescProdutos;
  LblnSerDescMaiorMax := fValidaDescServicos;

  if (LblnPrdDescMaiorMax) or (LblnSerDescMaiorMax) then
  begin
    objLiberacao.Clear;

    if (LblnPrdDescMaiorMax) then
    begin
      FfltDesConcedido := FfltPreTab - FfltTotGer;
      FfltPerDesConced := (FfltDesConcedido / FfltPreTab) * 100;
      FfltDesMaximoPer := (FfltPreTab - FfltValMin);

      objLiberacao.objMsgLibera.pAddTexto('VALOR DOS PRODUTOS MENOR QUE O VALOR MÍNIMO');
      objLiberacao.objMsgLibera.pAddTextoCaption('Preço de Tabela'           , FormatFloat('#,##0.00', FfltPreTab)             , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('Desconto Máximo Permitido' , FormatFloat('#,##0.00', FfltDesMaximoPer)       , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('Desconto Concedido'        , FormatFloat('#,##0.00', FfltDesConcedido)       , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('% Desconto Concedido'      , FormatFloat('#,##0.00', FfltPerDesConced) + '%' , 25);

      if (VS_strTRVEPR = '2') Then
      begin
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor dos Produtos'      , FormatFloat('#,##0.00', FfltTotGer)             , 25);
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor mínimo permitido'  , FormatFloat('#,##0.00', FfltValMin)             , 25);
      end;

      objLiberacao.objMsgLibera.pAddTexto('');
      objLiberacao.objMsgLibera.pAddTexto('');
    end;

    if (LblnSerDescMaiorMax) then
    begin
      objLiberacao.objMsgLibera.pAddTexto('DESCONTO MÁXIMO DE SERVIÇO ULTRAPASSADO');
      objLiberacao.objMsgLibera.pAddTextoCaption('Desconto Máximo Permitido' , FormatFloat('#,##0.00', FfltDesSerMax)        , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('Desconto Concedido'        , FormatFloat('#,##0.00', FfltTotDesSer)        , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('% Desconto Concedido'      , FormatFloat('#,##0.00', (FfltTotDesSer / FfltTotalSer) * 100) + '%', 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor dos Serviços'        , FormatFloat('#,##0.00', FfltTotalSer)         , 25);
    end;

    objLiberacao.strDirAce := 'OSMIN';
    objLiberacao.strSenLib := fCfgSis('SENLBD');
    objLiberacao.strMsgSen := 'Trava de Preço';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  end;
end;

procedure TfrmNegociacaoOrdemServico.pAplicarDescPercentual;
var
  LfltPerDesOld,
  LfltPerSerOld,
  LfltVlrDesOld,
  LfltTotNegOld: Double;
  LstrDesAplOld,
  LstrTipDesOld: String;
begin
  if (not fValidaSemDesconto) then
    Exit;

  if (not fValidaDescDigProdutos) then
    Exit;

  if (not fValidaDescDigServicos) then
    Exit;

  LstrTipDesOld := objNegOSE.strTipDes;
  pValidaTipDescontoMarcado;

  LfltPerDesOld := objNegOse.fltPerDes;
  LfltPerSerOld := objNegOse.fltPerSer;
  LfltVlrDesOld := objNegOse.fltVlrDes;
  LstrDesAplOld := FstrDesApl;
  LfltTotNegOld := objNegOse.fltTotNeg;

  objNegOse.fltPerDes := fStrToFloat(edtDesPrd.Text, 0);
  objNegOse.fltPerSer := fStrToFloat(edtDesSer.Text, 0);

  case AnsiIndexStr(UpperCase(objNegOSE.strTipDes), ['0', '1', '2', '3']) of
    0:
      begin
        objNegOse.fltVlrDes := 0;
        FstrDesApl          := 'PS';
      end;
    1:
      begin
        objNegOse.fltVlrDes := objNegOse.fltTotPro * (objNegOse.fltPerDes / 100);
        FstrDesApl          := 'P';
      end;
    2:
      begin
        objNegOse.fltVlrDes := objNegOse.fltTotSer * (objNegOse.fltPerSer / 100);
        FstrDesApl          := 'S';
      end;
    3:
      begin
        objNegOse.fltVlrDes := objNegOse.fltTotPro * (IIF(objNegOse.fltPerDes > 0, (objNegOse.fltPerDes / 100), 0));
        objNegOse.fltVlrDes := objNegOse.fltVlrDes + (objNegOse.fltTotSer * (IIF(objNegOse.fltPerSer > 0, (objNegOse.fltPerSer / 100), 0)));
        FstrDesApl          := 'PS';
      end;
  end;

  objNegOse.fltTotNeg := objNegOse.fltTotOse - objNegOse.fltVlrDes;

  edtDesPrd.Clear;
  edtDesSer.Clear;

  if (not fVerificaDescontoMaximo) then
  begin
    objNegOse.fltPerDes := LfltPerDesOld;
    objNegOse.fltPerSer := LfltPerSerOld;
    objNegOse.fltVlrDes := LfltVlrDesOld;
    FstrDesApl          := LstrDesAplOld;
    objNegOse.fltTotNeg := LfltTotNegOld;
    Exit;
  end;

  fCalculaDescontosComProgress;
  objNegOSE.pInsereHistoricoDesconto(FstrDesApl, 'P', objNegOse.fltPerDes, objNegOse.fltPerSer, objNegOse.fltVlrDes);

  FfltVlrNegAnt := objNegOse.fltTotNeg;
  FfltPerDesAnt := objNegOse.fltPerDes;
  FstrTipDesAnt := objNegOse.strTipDes;
end;

procedure TfrmNegociacaoOrdemServico.pAplicarDescValorNegociado;
var
  LfltPerDesOld,
  LfltPerSerOld,
  LfltVlrDesOld,
  LfltTotNegOld: Double;
  LstrDesAplOld,
  LstrTipDesOld: String;
begin
  inherited;

  if (fEmptyStr(edtVlrNeg.Text)) then
  begin
    fMensagem('ATENÇÃO', 'Informe o valor final das OS a ser negociado.', ['&Ok']);
    Exit;
  end;

  if (fStrToFloat(edtVlrNeg.Text) < 0) then
  begin
    fMensagem('', 'O Valor Negociado Final deve ser maior ou igual a zero!', ['&Ok']);
    edtVlrNeg.Clear;
    Exit;
  end;

  if (fStrToFloat(edtVlrNeg.Text) > objNegOSE.fltTotOse) then
  begin
    fMensagem('', 'O Valor Negociado Final não pode ser maior que o valor total das Ordens de Serviço!', ['&Ok']);
    edtVlrNeg.Clear;
    Exit;
  end;

  if (edtVlrNeg.Text = FloatToStrF(FfltVlrNegAnt, ffFixed, 10,2)) then
  begin
    edtVlrNeg.Clear;
    Exit;
  end;

  LstrTipDesOld := objNegOSE.strTipDes;
  LfltPerDesOld := objNegOse.fltPerDes;
  LfltPerSerOld := objNegOse.fltPerSer;
  LfltVlrDesOld := objNegOse.fltVlrDes;
  LstrDesAplOld := FstrDesApl;
  LfltTotNegOld := objNegOse.fltTotNeg;

  objNegOse.strTipDes := '3';
  objNegOse.fltTotNeg := fStrToFloat(edtVlrNeg.Text);
  objNegOse.fltPerDes := ((objNegOse.fltTotOse - objNegOse.fltTotNeg) / objNegOse.fltTotOse) * 100;
  objNegOse.fltPerSer := objNegOse.fltPerDes;
  objNegOse.fltVlrDes := objNegOse.fltTotOse * (objNegOse.fltPerDes / 100);

  edtVlrNeg.Clear;

  if (not fVerificaDescontoMaximo) then
  begin
    objNegOse.fltPerDes := LfltPerDesOld;
    objNegOse.fltPerSer := LfltPerSerOld;
    objNegOse.fltVlrDes := LfltVlrDesOld;
    FstrDesApl          := LstrDesAplOld;
    objNegOse.fltTotNeg := LfltTotNegOld;
    Exit;
  end;

  fCalculaDescontosComProgress;
  FstrDesApl          := 'PS';
  objNegOSE.pInsereHistoricoDesconto(FstrDesApl, 'V', objNegOse.fltPerDes, objNegOse.fltPerSer, objNegOse.fltVlrDes);

  FfltVlrNegAnt := objNegOse.fltTotNeg;
  FfltPerDesAnt := objNegOse.fltPerDes;
  FfltPerSerAnt := objNegOse.fltPerSer;
  FstrTipDesAnt := objNegOse.strTipDes;
end;

procedure TfrmNegociacaoOrdemServico.pAprovarOrdensServico;
var
  LstrAprPor   : String;
  LstrOsPdCl   : String;
  LintSubStatus: Integer;
  LstrSubSta   : String;
  LstrCodDig   : String;
  LstrSenDig   : String;
  LstrCliGar   : String;
  LstrEmpFatSemSaldo: String;
  frmFatManConsertoEquip   : TfrmFatManConsertoEquip;
  frmConsertoEquipAprovacao: TfrmConsertoEquipAprovacao;
  frmDigCliente            : TfrmDigCliente;
begin
  objFatVendaImpNeg := TFatVendaImp.Create;

  try
    pCriarFormularios(TfrmConsertoEquipAprovacao, frmConsertoEquipAprovacao);

    try
      frmConsertoEquipAprovacao.blnAprova := False;
      frmConsertoEquipAprovacao.strGarant := 'N';
      frmConsertoEquipAprovacao.strCodCli := dbeCodCli.Text;
      frmConsertoEquipAprovacao.blnNegoci := True;
      frmConsertoEquipAprovacao.cdsIteNeg := objNegOSE.cdsIteOrd;
      frmConsertoEquipAprovacao.ShowModal();

      LstrAprPor := frmConsertoEquipAprovacao.strAprPor;
      LstrOsPdCl := frmConsertoEquipAprovacao.strNumPed;
      LintSubStatus := frmConsertoEquipAprovacao.intTipApr;

      LstrEmpFatSemSaldo := '';
      If fCfgSis('FATSSA', varBoolean) Then
        LstrEmpFatSemSaldo := frmConsertoEquipAprovacao.edtCodEmpFat.Text;

      case LintSubStatus Of
        1: LstrSubSta := 'C';
        2: LstrSubSta := 'G';
        3: LstrSubSta := 'B';
        else Exit;
      end;

      if (fCfgSis('USADIG', varBoolean)) then
      begin
        LstrCodDig := frmConsertoEquipAprovacao.strCodOpe;
        LstrSenDig := frmConsertoEquipAprovacao.strSenDig;
      end;
    finally
      pFreeAndNil(frmConsertoEquipAprovacao);
    end;

    if (LstrSubSta = 'G') then
    begin
      pCriarFormularios(TfrmDigCliente, frmDigCliente);

      try
        if (frmDigCliente.ShowModal = mrOk) then
          LstrCliGar := frmDigCliente.edtCodCli.Text;
      finally
        pFreeAndNil(frmDigCliente);
      end;
    end;

    objNegOSE.cdsDocGer.EmptyDataSet;

    objNegOSE.cdsOrdSer.First;

    while not objNegOSE.cdsOrdSer.Eof do
    begin
      pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquip);

      try
        frmFatManConsertoEquip.blnNegociacao  := True;
        frmFatManConsertoEquip.edtNumero.Text := objNegOSE.cdsOrdSer.FieldByName('NUMOSE').AsString;
        frmFatManConsertoEquip.edtCodEmp.Text := objNegOSE.cdsOrdSer.FieldByName('CODEMP').AsString;
        frmFatManConsertoEquip.FstrAprPor     := LstrAprPor;
        frmFatManConsertoEquip.FstrOsPdCl     := LstrOsPdCl;
        frmFatManConsertoEquip.FstrSubSta     := LstrSubSta;
        frmFatManConsertoEquip.FstrCodDig     := LstrCodDig;
        frmFatManConsertoEquip.FstrSenDig     := LstrSenDig;
        frmFatManConsertoEquip.FstrCliGar     := LstrCliGar;
        frmFatManConsertoEquip.cdsIteNeg      := objNegOSE.cdsIteOrd;
        frmFatManConsertoEquip.FcdsDocGerNeg  := objNegOSE.cdsDocGer;
        frmFatManConsertoEquip.objFatVendaImpNeg := objFatVendaImpNeg;
        frmFatManConsertoEquip.FstrEmpFatSemSaldo := LstrEmpFatSemSaldo;
        frmFatManConsertoEquip.ShowModal();
      finally
        pFreeAndNil(frmFatManConsertoEquip);
      end;

      objNegOSE.cdsOrdSer.Next;
    end;

    pMostraDocumentosGerados;
  finally
    FreeAndNil(objFatVendaImpNeg);
  end;
end;

procedure TfrmNegociacaoOrdemServico.pAtualizaTela;
begin
  if (not objNegOSE.cdsOrdSer.IsEmpty) then
  begin
    objNegOSE.strCodCli := objNegOSE.cdsOrdSer.FieldByName('CODCLI').AsString;
    objNegOSE.strNomCli := objNegOSE.cdsOrdSer.FieldByName('NOMCLI').AsString;
    objNegOSE.strCgcCli := objNegOSE.cdsOrdSer.FieldByName('CGCCLI').AsString;
  end;

  pMontaTotais;
  case AnsiIndexStr(UpperCase(objNegOSE.strTipDes), ['0', '1', '2', '3']) of
    0: objNegOse.fltVlrDes := 0;
    1: objNegOse.fltVlrDes := objNegOse.fltTotPro * (objNegOse.fltPerDes / 100);
    2: objNegOse.fltVlrDes := objNegOse.fltTotSer * (objNegOse.fltPerSer / 100);
    3:
      begin
        objNegOse.fltVlrDes := objNegOse.fltTotPro * (IIF(objNegOse.fltPerDes > 0, (objNegOse.fltPerDes / 100), 0));
        objNegOse.fltVlrDes := objNegOse.fltVlrDes + (objNegOse.fltTotSer * (IIF(objNegOse.fltPerSer > 0, (objNegOse.fltPerSer / 100), 0)));
      end;
  end;

  objNegOse.fltTotNeg := objNegOse.fltTotOse - objNegOse.fltVlrDes;

  fCalculaDescontosComProgress;
  if (objNegOse.fltPerDes > 0) or (objNegOse.fltPerSer > 0) then
    objNegOSE.pInsereHistoricoDesconto(FstrDesApl, 'P', objNegOse.fltPerDes, objNegOse.fltPerSer, objNegOse.fltVlrDes);
  FfltVlrNegAnt := objNegOse.fltTotNeg;

  edtCodCli.Clear;
  edtNomCli.Clear;
  edtNumOse.Clear;
end;

procedure TfrmNegociacaoOrdemServico.pCarregaCondicao;
var
  LstrMultTabPreco: string;
begin
  if not Assigned(qryConCnd) then
    Exit;

  pPesquisaCadCnd(qryConCnd, qryConCnd, edtCodCnd.Text);
  if ( not qryConCnd.IsEmpty ) then
  begin
    if ( qryConCnd.FieldByName('CND_TIPFOR').AsString = 'OUTROS' ) then
    begin
      mskCndPag.Enabled     := True;
      mskCndPag.Color       := clWindow;
      mskCndPag.NormalColor := clWindow;

      mskCndPag.Text := qryConCnd.FieldByName('CND_CNDPAG').AsString;
    end
    else
    begin
      mskCndPag.Enabled     := False;
      mskCndPag.Color       := $00FFDFB8;
      mskCndPag.NormalColor := $00FFDFB8;
      mskCndPag.Text        := fRetCondicao('',
                                            0,
                                            qryConCnd.FieldByName('CND_CODIGO').AsString,
                                            qryConCnd.FieldByName('CND_TIPFOR').AsString,
                                            qryConCnd.FieldByName('CND_CNDPAG').AsString);
    end;

    mskCndPag.Text := fRetCondicaoDiaFixoCliente('', 0, edtCodCli.Text, mskCndPag.Text);

    if not fEmptyStr(qryConCnd.FieldByName('CND_CODFPG').AsString) Then
    begin
      edtForPag.Text     := qryConCnd.FieldByName('CND_CODFPG').AsString;
      edtForPag.ReadOnly := True;
      pCarregaForPag;
    end
    else
      edtForPag.ReadOnly := False;

    LstrMultTabPreco := fDevolveTabelaPreco(qryConCnd.FieldbyName('CND_PRETAB').AsString);

    edtDesCndPag.Text  := qryConCnd.FieldByName('CND_DESCRI').AsString;
  end
  else
    edtDesCndPag.Clear;
end;

procedure TfrmNegociacaoOrdemServico.pCarregaForPag;
begin
  if not fEmptyStr(edtForPag.Text) then
    edtDesForPag.Text := fRetDesFpg(edtForPag.Text)
  else
    edtDesForPag.Text := '';
end;

procedure TfrmNegociacaoOrdemServico.pCarregaLogItensSep(var cdsLogItensSep: TUniClientDataSet);
begin
  if Assigned(cdsLogItensSep) then
    cdsLogItensSep.EmptyDataSet
  else
    cdsLogItensSep := fCriaTemporaria(Self);

  while not objNegOSe.cdsIteOrd.Eof do
  begin
    cdsLogItensSep.Append;
    cdsLogItensSep.FieldByName('AUTOINCREM').AsString := '0';
    cdsLogItensSep.FieldByName('ITE_CODITE').AsString := objNegOSe.cdsIteOrd.FieldByName('CODITE').AsString;
    cdsLogItensSep.FieldByName('ITE_DESITE').AsString := objNegOSe.cdsIteOrd.FieldByName('DESITE').AsString;
    cdsLogItensSep.FieldByName('ITE_QTDITE').AsFloat  := objNegOSe.cdsIteOrd.FieldByName('QTDITE').AsFloat;
    cdsLogItensSep.FieldByName('ITE_STALOG').AsString := 'I';
    cdsLogItensSep.FieldByName('ITE_DESUNI').AsString := objNegOSe.cdsIteOrd.FieldByName('UNIDAD').AsString;
    cdsLogItensSep.Post;

    objNegOSe.cdsIteOrd.Next;
  end;
end;

function TfrmNegociacaoOrdemServico.fCarregaNegociacaoComProgres: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    pgbStatus := frmGravando.pgbStatus;
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.lblGravando.Caption := 'Aguarde, Carregando Ordens de Serviços...';
    frmGravando.fExecutarAcao := fCarregaNegociacao;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmNegociacaoOrdemServico.pDeletaOSGrid;
begin
  if (not objNegOSE.cdsOrdSer.IsEmpty) then
  begin
    if fMensagem('ATENÇÃO', 'Confirma a exclusão do registro?', ['&Sim', '&Não']) = 1 then
    begin
      objNegOse.pRemoveTrava;

      if (objNegOSE.blnNovNeg) or
         (objNegOSE.cdsOrdSer.FieldByName('OPERAC').AsString = 'I') then
        objNegOSE.cdsOrdSer.Delete
      else
      begin
        objNegOSE.cdsOrdSer.Edit;
        objNegOSE.cdsOrdSer.FieldByName('OPERAC').AsString := 'D';
        objNegOSE.cdsOrdSer.Post;
      end;

      pMontaTotais;
      case AnsiIndexStr(UpperCase(objNegOSE.strTipDes), ['0', '1', '2', '3']) of
        0: objNegOse.fltVlrDes := 0;
        1: objNegOse.fltVlrDes := objNegOse.fltTotPro * (objNegOse.fltPerDes / 100);
        2: objNegOse.fltVlrDes := objNegOse.fltTotSer * (objNegOse.fltPerSer / 100);
        3:
          begin
            objNegOse.fltVlrDes := objNegOse.fltTotPro * (IIF(objNegOse.fltPerDes > 0, (objNegOse.fltPerDes / 100), 0));
            objNegOse.fltVlrDes := objNegOse.fltVlrDes + (objNegOse.fltTotSer * (IIF(objNegOse.fltPerSer > 0, (objNegOse.fltPerSer / 100), 0)));
          end;
      end;

      objNegOse.fltTotNeg := objNegOse.fltTotOse - objNegOse.fltVlrDes;

      fCalculaDescontosComProgress;
      if (objNegOse.fltPerDes > 0) or (objNegOse.fltPerSer > 0) then
        objNegOSE.pInsereHistoricoDesconto(FstrDesApl, 'P', objNegOse.fltPerDes, objNegOse.fltPerSer, objNegOse.fltVlrDes);

      FfltVlrNegAnt := objNegOse.fltTotNeg;
    end;
  end;
end;

procedure TfrmNegociacaoOrdemServico.pDestravaELimpaStlNegociacaoLck;
var
  LintAux: Integer;
Begin
  For LintAux := 0 To stlNegociacaoAltLck.Count - 1 Do
    fLock_Unlock(stlNegociacaoAltLck[LintAux], False, False);

  stlNegociacaoAltLck.Clear;
end;

procedure TfrmNegociacaoOrdemServico.pEscapePressed;
begin
  if dbgGridOrdSer.Focused or dbgGridHisDes.Focused then
    pLimparTela
  else if (Assigned(ActiveControl)) and
          (((ActiveControl.Parent = pnlTopo) and (ActiveControl <> edtNegNum)) or
          ((ActiveControl.Parent = pnlCndPag) and (ActiveControl <> edtNegNum)) or
          (pnlBotoes.Focused) or
          ((ActiveControl.Parent = pnlButtons) Or (ActiveControl.Parent = FlwPnlButtons)) ) then
  begin
    if fMensagem('ATENÇÃO', 'Deseja abortar a operação?', ['&Sim', '&Não']) = 1 then
      pLimparTela;
  end
  else if (Assigned(ActiveControl)) and (ActiveControl.Parent = pnlTopo) and (edtNegNum.Focused) then
    inherited;
end;

procedure TfrmNegociacaoOrdemServico.pImprimeDocsGerados;
var
  intIndex: Integer;
  imImpPdOr,
  imImpSep: TDadosImprimePdOrSep;
  cdsLogItensSep: TUniClientDataSet;
begin
  try
    objNegOSe.cdsDocGer.First;

    while not objNegOSe.cdsDocGer.Eof do
    begin
      for intIndex := 0 to Pred(objFatVendaImpNeg.ItemsCount) do
      begin
        if (objFatVendaImpNeg.Items[intIndex].strNumDoc = objNegOSe.cdsDocGer.FieldByName('NUMDOC').AsString) and
           (objFatVendaImpNeg.Items[intIndex].strEspDoc = objNegOSe.cdsDocGer.FieldByName('ESPDOC').AsString) and
           (objFatVendaImpNeg.Items[intIndex].strEmpDoc = objNegOSe.cdsDocGer.FieldByName('CODEMP').AsString) then
        begin
          objFatVendaImpNeg.blnPDORMultiLoja := True;

          {***************************************************************}
          {* ESSAS VARIAVEIS DEFINIE SE IRÁ OU NÃO IMPRIMIR O PD/OR/SEP  *}
          {* OBS: POR DEFAULT A FUNÇÃO pImprimeDocumento, JÁ VEM SETADO  *}
          {* imPerguntaSeImprime. AQUI NESTE CASO NÃO PRECISA PERGUNTAR, *}
          {* OU IMPRIME SE ESTIVER CONFIGURADO OU NÃO IMPRIME NADA.      *}
          {************************************************************FC*}
          imImpPdOr := TDadosImprimePdOrSep.Create;
          imImpPdOr.imImpDoc := imNaoImprime;
          imImpPdOr.intQtdVia := 0;

          imImpSep := TDadosImprimePdOrSep.Create;
          imImpSep.imImpDoc := imNaoImprime;
          imImpSep.intQtdVia := 0;

          if objNegOSe.cdsDocGer.FieldByName('IMPRIM').AsBoolean and
             (objNegOSe.cdsDocGer.FieldByName('QTDVIA').AsInteger > 0) then
          begin
            imImpPdOr.imImpDoc := imImprimeSemPergutar;
            imImpPdOr.intQtdVia := objNegOSe.cdsDocGer.FieldByName('QTDVIA').AsInteger;
          end;

          if objNegOSe.cdsDocGer.FieldByName('IMPSEP').AsBoolean and
             (objNegOSe.cdsDocGer.FieldByName('SEPVIA').AsInteger > 0) then
          begin
            imImpSep.imImpDoc := imImprimeSemPergutar;
            imImpSep.intQtdVia := objNegOSe.cdsDocGer.FieldByName('SEPVIA').AsInteger;
          end;

          objNegOSe.cdsIteOrd.Filtered := False;
          objNegOSe.cdsIteOrd.Filter   := 'NUMOSE=' + QuotedStr(objNegOSe.cdsDocGer.FieldByName('NUMOSE').AsString) +
            ' AND EMPOSE=' + QuotedStr(objNegOSe.cdsDocGer.FieldByName('EMPOSE').AsString);
          objNegOSe.cdsIteOrd.Filtered := True;

          pCarregaLogItensSep(cdsLogItensSep);
          objFatVendaImpNeg.pSetCdsLogSep(intIndex, cdsLogItensSep);

          if (not ((imImpPdOr.imImpDoc = imNaoImprime) and (imImpSep.imImpDoc = imNaoImprime))) then
            objFatVendaImpNeg.pImprimeDocumento(objFatVendaImpNeg.Items[intIndex], imImpPdOr, imImpSep);

          FreeAndNil(imImpPdOr);
          FreeAndNil(imImpSep);

          if not objNegOSe.cdsDocGer.FieldByName('PRDAMO').AsBoolean then
            Break;
        end;
      end;

      Application.ProcessMessages;
      objNegOSe.cdsDocGer.Next;
    end;
  finally
    if Assigned(cdsLogItensSep) then
      FreeAndNil(cdsLogItensSep);
  end;
end;

procedure TfrmNegociacaoOrdemServico.pIncluirOrdensServico;
begin
  {*** Insere apenas as Ordens de Serviço que não tem negociação ou possui negociação já finalizada ***}
  qryVerifica.Filtered := False;
  qryVerifica.Filter   := ' EQUSTA = ''F'' ';

  if objNegOSE.blnNovNeg then
    qryVerifica.Filter := qryVerifica.Filter + ' AND (NEG_NRONEG IS NULL OR STATUS = ''FINALIZADA'') '
  else
    qryVerifica.Filter := qryVerifica.Filter + ' OR NEG_NRONEG = ''' + edtNegNum.Text + '''';
  qryVerifica.Filtered := True;

  qryVerifica.First;

  while not qryVerifica.Eof do
  begin
    objNegOSE.pInserirOSGrid(qryVerifica.FieldByName('NUMOSE').AsString, qryVerifica.FieldByName('CODEMP').AsString);
    edtNegNum.Enabled    := False;
    edtCodEmpNeg.Enabled := False;

    if fEmptyStr(objNegOSE.strStatus) then
    begin
      edtNegNum.Clear;
      edtCodEmpNeg.Clear;
      objNegOSE.blnNovNeg := True;
    end;

    qryVerifica.Next;
  end;
end;

procedure TfrmNegociacaoOrdemServico.pLimparTela;
begin
  edtNegNum.Clear;
  edtCodEmpNeg.Clear;
  edtDesEmpNeg.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtNumOSE.Clear;
  edtCodEmpOS.Clear;
  edtDesEmpOS.Clear;
  edtNegSta.Clear;
  edtCodCnd.Clear;
  mskCndPag.Clear;
  edtDesCndPag.Clear;
  edtForPag.Clear;
  edtDesForPag.Clear;
  edtDesPrd.Clear;
  edtDesSer.Clear;
  edtVlrNeg.Clear;
  FfltPerDesAnt := 0;
  FfltPerSerAnt := 0;
  FfltVlrNegAnt := 0;

  lblTotaST.Caption    := '0,00';
  lblTotIPI.Caption    := '0,00';
  lblTotGer.Caption    := '0,00';
  lblVlrDes.Caption    := '0,00';
  lblTotDes.Caption    := '0,00';

  edtNegNum.Enabled    := True;
  edtCodCli.Enabled    := True;
  edtNumOse.Enabled    := True;
  pSetFocus(edtNegNum);

  mskCndPag.EditMask := MASK_CONPAG;

  btnIncluir.Enabled   := True;
  btnGravar.Enabled    := True;
  btnFinalizar.Enabled := False;
  btnExcluir.Enabled   := False;

  pnlDesconto.Enabled  := True;
  grbCndPag.Enabled    := True;

  rbSemDes.Checked     := True;
  FstrDesApl           := 'PS';

  if stlNegociacaoAltLck.Count > 0  then
    pDestravaELimpaStlNegociacaoLck();

  objNegOSE.pLimpar;
end;

procedure TfrmNegociacaoOrdemServico.pMontaTotais;
begin
  objNegOSE.pCalculaTotais;

  lblTotaST.Caption := FormatFloat(fMskDigitos(2), objNegOSE.fltTotRet);
  lblTotIPI.Caption := FormatFloat(fMskDigitos(2), objNegOSE.fltTotIPI);
  lblTotGer.Caption := FormatFloat(fMskDigitos(2), objNegOSE.fltTotGer);
  lblVlrDes.Caption := FormatFloat(fMskDigitos(2), objNegOSE.fltVlrDes);
  lblTotDes.Caption := FormatFloat(fMskDigitos(2), objNegOSE.fltTotDes);
end;

procedure TfrmNegociacaoOrdemServico.pMostraDocumentosGerados;
begin
  pCriarFormularios(TfrmFatPedidosImpr, frmFatPedidosImpr);

  try
    try
      frmFatPedidosImpr.blnImprime := True;
      frmFatPedidosImpr.blnSepara  := frmFatPedidosImpr.blnImprime and objNegOSe.cdsDocGer.Locate('IMPSEP', True, []);
      frmFatPedidosImpr.blnMostraPreco := fCfgSis('ORCSPR', varBoolean, VS_strCodEmp);
      frmFatPedidosImpr.blnConEqu  := True;
      frmFatPedidosImpr.dtsDocumentos.DataSet := objNegOSe.cdsDocGer;

      objNegOSe.cdsDocGer.BeforePost := objNegOSe.pCdsDocGerBeforePost;

      if (frmFatPedidosImpr.ShowModal = mrOk) then
      begin
        if (not objNegOSe.cdsDocGer.IsEmpty) and frmFatPedidosImpr.blnImprime then
          pImprimeDocsGerados;

        objNegOSe.cdsDocGer.BeforePost := nil;
      End;
    except
      on E: Exception Do
      begin
        pMensagensErro(E.Message, '[pMostraDocumentosGerados]');
      end;
    end;
  finally
    pFreeAndNil(frmFatPedidosImpr);
  end;
end;

procedure TfrmNegociacaoOrdemServico.pRadioButtonClick(Sender: TObject);
begin
  pnlInfo.Caption := '';
  pnlDesProSer.Visible := False;
  pnlValNeg.Visible    := False;
  pnlDesPro.Visible    := False;
  pnlDesSer.Visible    := False;
  pnlDesPro.Left       := 0;

  edtDesPrd.Clear;
  edtDesSer.Clear;
  edtVlrNeg.Clear;

  if rbDesPrd.Checked then
  begin
    pnlDesProSer.Visible := True;
    pnlDesPro.Visible    := True;
    pnlDesPro.Left       := 175;
  end
  else if rbDesSer.Checked then
  begin
    pnlDesProSer.Visible := True;
    pnlDesSer.Visible    := True;
  end
  else if rbPrdSer.Checked then
  begin
    pnlDesProSer.Visible := True;
    pnlDesPro.Visible    := True;
    pnlDesSer.Visible    := True;
  end
  else if rbVlrNeg.Checked then
  begin
    pnlValNeg.Visible    := True;
    pnlInfo.Caption := 'O Valor Negociado Final refere-se a soma do total das Ordens de Serviço';
  end;
end;

procedure TfrmNegociacaoOrdemServico.pValidaTipDescontoMarcado;
begin
  if rbSemDes.Checked then
    objNegOSe.strTipDes := '0'
  else if rbDesPrd.Checked then
    objNegOSe.strTipDes := '1'
  else if rbDesSer.Checked then
    objNegOSe.strTipDes := '2'
  else if rbPrdSer.Checked then
    objNegOSe.strTipDes := '3';
end;

function TfrmNegociacaoOrdemServico.fCalculaDesconto(pgbProgresso: TcxProgressBar): Boolean;
const
  MAX_PROGRESSO = 4;
var
  intEtapa: integer;
begin
  Result := True;
  pInformacao('Aguarde, Calculando desconto...', pgbStatus);
  pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
  objNegOSE.pCalculaDescontos;

  pInformacao('Aguarde, Calculando totais...', pgbStatus);
  pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
  pMontaTotais;
end;

function TfrmNegociacaoOrdemServico.fCalculaDescontosComProgress: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    pgbStatus := frmGravando.pgbStatus;
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.lblGravando.Caption := 'Aguarde, Aplicando desconto nas ordens de serviço...';
    frmGravando.fExecutarAcao := fCalculaDesconto;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TfrmNegociacaoOrdemServico.fCarregaNegociacao(pgbProgresso: TcxProgressBar = nil): Boolean;
const
  MAX_PROGRESSO = 4;
var
  intEtapa: integer;
begin
  Result := True;

  if (fTravaERegistraStlNegociacaoLck(edtNegNum.Text, IIF(FblnMaoSem, edtCodEmpNeg.Text, VS_strCodEmp))) then
    Exit;

  if objNegOSE.fCarregaNegociacao(edtNegNum.Text, IIF(FblnMaoSem, edtCodEmpNeg.Text, VS_strCodEmp)) then
  begin
    pInformacao('Aguarde, Carregando Negociação...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);

    edtNegNum.Enabled    := False;
    edtCodEmpNeg.Enabled := False;
    edtNegSta.Text       := objNegOSE.strNegSta;
    edtCodCnd.Text       := objNegOSE.strCodCnd;
    mskCndPag.Text       := objNegOSE.strConPag;
    edtForPag.Text       := objNegOSE.strCodFpg;

    pInformacao('Aguarde, Carregando Condições de Pagamento...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    pCarregaCondicao;

    pInformacao('Aguarde, Carregando Formas de Pagamento...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    pCarregaForPag;

    pInformacao('Aguarde, Calculando Totais...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    pMontaTotais;

    pInformacao('Aguarde, Calculando desconto...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    objNegOSE.pCalculaDescontos;
    pMontaTotais;
    FstrDesApl        := objNegOSE.cdsHisDes.FieldByName('DESAPL').AsString;

    FfltPerDesAnt     := objNegOSE.fltPerDes;
    FfltPerSerAnt     := objNegOSE.fltPerSer;
    FfltVlrNegAnt     := objNegOSE.fltTotOse - objNegOSE.fltVlrDes;

    if edtNegSta.Text = 'FINALIZADA' then
    begin
      btnGravar.Enabled    := False;
      btnIncluir.Enabled   := False;
      edtCodCli.Enabled    := False;
      edtNumOse.Enabled    := False;
      pnlDesconto.Enabled  := False;
      grbCndPag.Enabled    := False;
    end
    else
    begin
      btnFinalizar.Enabled := True;
      btnExcluir.Enabled   := True;
    end;
  end
  else
  begin
    edtNegNum.Clear;
    pLimparTela;
    Result := False;
  end;
end;

end.
