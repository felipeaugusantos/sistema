unit Contabilidade.View.ManutencaoLancamentoContabil;

interface

uses
  Classes, Controls, StdCtrls, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, QColorLabel, Menus, EditFocus, DB, Uni, Windows,
  MaskEditFocus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, strUtils, cxProgressBar,
  UniClientDataSet, DBMemoFocus, Vcl.Grids, Vcl.DBGrids, Contabilidade.View.TfrmPaiCadContabilidade,
  ComboBoxFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, DBGridCitel,
  Contabilidade.Model.TDadosImportacaoContabil,
  System.Generics.Collections, Contabilidade.Funcoes;

type
  TfrmManLanCon = class(TfrmPaiCadContabilidade)
    Label2: TLabel;
    dbeConCre: TDBEditFocus;
    Label3: TLabel;
    dbeDtaLan: TDBEditFocus;
    Label6: TLabel;
    dbeValLan: TDBEditFocus;
    edtDesConCre: TEditFocus;
    pnlFundo: TPanel;
    dtsLanCon: TDataSource;
    Label10: TLabel;
    dbeConDeb: TDBEditFocus;
    edtDesConDeb: TEditFocus;
    dbeHistor: TDBMemoFocus;
    Label4: TLabel;
    dbeEmpLan: TDBEditFocus;
    Label5: TLabel;
    Label7: TLabel;
    dbeCcusto: TDBEditFocus;
    edtDesCCusto: TEditFocus;
    edtConCreRed: TEditFocus;
    edtConDebRed: TEditFocus;
    Label8: TLabel;
    dbeCodOpe: TDBEditFocus;
    edtNomOpe: TEditFocus;
    lbTipLan: TLabel;
    dbcAutoma: TDBCheckBox;
    dbgBuscaConta: TDBGridCitel;
    dtsBusca: TDataSource;
    dbeAutoincrem: TDBEditFocus;
    edtTipLan: TComboBoxFocus;
    tbsConferencia: TTabSheet;
    Label11: TLabel;
    lblCodEmp: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtTipoLanctoConf: TComboBoxFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    mskDtaFin: TMaskEditFocus;
    mskDtaIni: TMaskEditFocus;
    cxgConf: TcxGridCitel;
    cxgConfDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgConfDBTableViewCitel1Column1: TcxGridDBColumn;
    cxgConfDBTableViewCitel1Column2: TcxGridDBColumn;
    cxgConfDBTableViewCitel1Column4: TcxGridDBColumn;
    cxgConfDBTableViewCitel1Column5: TcxGridDBColumn;
    cxgConfDBTableViewCitel1Column6: TcxGridDBColumn;
    cxgConfDBTableViewCitel1Column7: TcxGridDBColumn;
    cxgConfLevel1: TcxGridLevel;
    edtContaDebitoConf: TEditFocus;
    edtContaCreditoConf: TEditFocus;
    edtHisPadConf: TEditFocus;
    edtDesHisPadConf: TEditFocus;
    edtValLanConf: TEditFocus;
    edtSomaCReditoConf: TEditFocus;
    edtSomaDebitoConf: TEditFocus;
    btnFiltrar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    dtsConfer: TDataSource;
    popConsulta: TPopupMenu;
    mnuFiltros: TMenuItem;
    mnuRegistroSelecionado: TMenuItem;
    Label1: TLabel;
    dbeHisPad: TDBEditFocus;
    edtDesHistPadrao: TEditFocus;
    lbCCuscr: TLabel;
    dbeCcuscr: TDBEditFocus;
    edtDesCcuscr: TEditFocus;
    btnExclusaoLote: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure dbeConCreKeyPress(Sender: TObject; var Key: Char);
    procedure dbeConDebKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCcustoKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExclusaoLoteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgBuscaContaDblClick(Sender: TObject);
    procedure edtConDebRedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtConCreRedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeConDebKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeConCreKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeConDebClick(Sender: TObject);
    procedure edtConDebRedClick(Sender: TObject);
    procedure dbeConCreClick(Sender: TObject);
    procedure edtConCreRedClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure cxgConfDBTableViewCitel1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgConfDBTableViewCitel1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure pgcDadosChange(Sender: TObject);
    procedure mnuFiltrosClick(Sender: TObject);
    procedure mnuRegistroSelecionadoClick(Sender: TObject);
    procedure dbeHisPadKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCcuscrKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEmpLanExit(Sender: TObject);
  private
    { Private declarations }
    cdsPlancoVigencia: TUniClientDataSet;
    FValidarVigenciaCta : boolean;
    qryBusca : TUniQuery;
    qryConEve: TUniQuery;
    qryConfer : TUniQuery;
    blnCfg_SENLCOExiste : boolean;
    blnUtilizaRotinaLoteContabil : boolean;
    blnFiltrarRegistroSelecionado : boolean;
    listaMultLancamento : TObjectList<TDadosImportacaoContabil>;
    blnExisteCampoNCO_NATURE : boolean;
    blnExisteCampoCON_VERSIS : boolean ;
    blnExisteCampoCON_EMPLOG : boolean ;
    procedure pLimpaEdits;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregarDados;
    procedure pCarregaEventos;
    procedure pCarregaHistorico;
    procedure pBuscarConta(dbeTexto: TCustomEdit; blnRed: Boolean; intTag: Integer);
    procedure pBeforePost(Dataset: TDataset);
    function fValidouCamposConferencia: boolean;
    procedure pCarregaDadosConferencia;
    procedure pSetaDadosConferencia;
    procedure pSetaSomaPeriodoConferencia;
    function fGerar(pgbProgresso: TcxProgressBar): Boolean;
    function fValidouOperacao: boolean;
    procedure pDeletarLotInc(strIncDoc, strTipLan, strEmpLan: string);
    function fGetQtdLanCon(strIncDoc, strTipLan, strEmpLan: string): integer;
    procedure pAtribuiValoresOnPost(DataSet: TDataSet);
    function fPermiteFiltrarSelecionado: boolean;
    function fInformouPartidaSimples(var fltValorLancamento: double): boolean;
    procedure pGravarMultLancamentos;
    function fLancouContasIguais: boolean;
    procedure pCarregaEventosCredito;
    procedure pEscondeCentroCustoCredito;
    procedure pLiberaPlancoVigencia; 
    procedure pCarregaPlanoContabilDebito(const blnBuscaPorChave: Boolean=False; blnCampoContaReduzida: Boolean=False);
    procedure pCarregaPlanoContabilCredito(const blnBuscaPorChave: Boolean=False; blnCampoContaReduzida: Boolean=False);
    procedure pSetFocusValidacaoTrDcZe;
    function fValidarTrDcZe: Boolean ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    function fProximoCodigo: String; override;
  public
    { Public declarations }
    prcMultLancamentos: TProcedureMultLancamentosContabeis;
  end;

var
  frmManLanCon: TfrmManLanCon;

implementation

uses SysUtils, Variants, Forms, Contabilidade.Interfaces, untFuncoesSimples,
     Contabilidade.View.ExclusaoLanctoContabil, untConstantes, untTypesSistema,
  untConsultas, Contabilidade.Consultas,untPesqAux,
  Contabilidade.Classes.UniQueryAuditoria;

{$R *.dfm}

{ TfrmManLanCon }

procedure TfrmManLanCon.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmManLanCon.FormCreate(Sender: TObject);
begin
  inherited;
  blnFiltrarRegistroSelecionado := False;
  if btnPesquisa.Parent = FlwBotoes then
  begin
    btnExclusaoLote.Top := btnPesquisa.Top + FlwBotoes.Top ;
    btnExclusaoLote.Left := btnExclusaoLote.Left + FlwBotoes.Left + 5 ;
  end;

  strNomeCampo  := 'AUTOINCREM';

  strNomeTabela := 'LANCON';
  qryTabela     := fCriaQueryContabilidade('LANCON', Self.Name, Self);
  qryTabela.SQL.Text := 'SELECT * FROM LANCON WHERE FALSE';
  qryConEve     := fCriarQuery('SELECT * FROM CADEVE WHERE FALSE', Self);
  qryTabela.AfterOpen := pAfterOpen;
  qryTabela.BeforePost := pBeforePost;
  dtsLanCon.DataSet := qryTabela;

  SetLength(arrCamposChave, 0);

  ///verifica se o campo existe
  if not assigned(qryTabela.FindField('CON_CCUSCR')) then
  begin
    pEscondeCentroCustoCredito ;
  end;

  qryBusca := fCriaQuery(Self);
  dtsBusca.DataSet := qryBusca;
  pCarregaTiposContabeis(edtTipLan, False, True);

  qryConfer := fCriaQuery(Self);
  dtsConfer.DataSet := qryConfer;
  pCarregaTiposContabeis(edtTipoLanctoConf, False, True);

  pgcDados.ActivePageIndex := 0;

  blnVerificaProCod := False;
  blnUsaProCodigo := False;

  blnCfg_SENLCOExiste := fConfiguracaoExiste('SENLCO');

  prcMultLancamentos := Nil;
  listaMultLancamento := TObjectList<TDadosImportacaoContabil>.Create;

  blnUtilizaRotinaLoteContabil := (fConfiguracaoExiste('LTCONT'));
  if (blnUtilizaRotinaLoteContabil) then
    blnUtilizaRotinaLoteContabil := fCfgSis('LTCONT', varBoolean);

  blnExisteCampoNCO_NATURE := fCampoExiste('PLANCO', 'NCO_NATURE');
  blnExisteCampoCON_VERSIS := fCampoExiste('LANCON', 'CON_VERSIS');
  blnExisteCampoCON_EMPLOG := fCampoExiste('LANCON', 'CON_EMPLOG');

  FValidarVigenciaCta := fTemVigencia;
  /////carrega as contas em uma tabela de memoria para verificação
  cdsPlancoVigencia := fCarregaPlancoVigencia ;
end;

procedure TfrmManLanCon.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryBusca);
  FreeAndNil(qryConfer);
  FreeAndNil(listaMultLancamento);
  pLiberaPlancoVigencia ;
  inherited;
end;

function TfrmManLanCon.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDtaLan) Then
    Begin
      Try
        If fEmptyStr(Trim(fTiraCaracEspeciais(dbeDtaLan.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data do Lançamento deve ser preenchida!', ['&OK']);
          Result := False;
        End;
      Except
        On E: EConvertError Do
        Begin
          fMensagem('ATENÇÃO!', dbeDtaLan.Text + ' não é uma data válida!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeValLan) Then
    Begin
      If fEmptyStr(dbeValLan.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Lançamento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If fStrToFloat(dbeValLan.Text) <= 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do Lançamento deve ser maior que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If fStrToFloat(dbeValLan.Text) > MAX_VALMON Then
          Begin
            fMensagem('ATENÇÃO!', 'O Valor do Lançamento não pode ser maior que 9.999.999.999,99!', ['&O k']);
            Result := False;
          End
        End;
      End;
    End

    Else If (Sender = dbeConCre) Then
    Begin
      pCarregaPlanoContabilCredito(blnBuscaPorChave) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(dbeConCre.Text))) And (fEmptyStr(edtDesConCre.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta de Crédito Inválida!',['&OK']);
        Result := False;
      end
      else if (blnExisteCampoNCO_NATURE) and (Not fEmptyStr(fSemMascaraPlaNco(dbeConCre.Text))) then
      begin
        if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConCre.Text)]) = 'S') then
        begin
          fMensagem('ATENÇÃO!','Conta de natureza sintética não pode ser selecionada para o lançamento!',['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtConCreRed) Then
    Begin
      if dbgBuscaConta.Visible then
      begin
        dbgBuscaContaDblClick(Nil);
        pCarregaPlanoContabilCredito(blnBuscaPorChave, True) ;
      end;
    End

    Else If (Sender = dbeConDeb) Then
    Begin
      pCarregaPlanoContabilDebito(blnBuscaPorChave) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(dbeConDeb.Text))) And (fEmptyStr(edtDesConDeb.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta de Débito Inválida!',['&OK']);
        Result := False;
      end
      else if (blnExisteCampoNCO_NATURE) and (Not fEmptyStr(fSemMascaraPlaNco(dbeConDeb.Text))) then
      begin
        if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConDeb.Text)]) = 'S') then
        begin
          fMensagem('ATENÇÃO!','Conta de natureza sintética não pode ser selecionada para o lançamento!',['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtConDebRed) Then
    Begin
      if dbgBuscaConta.Visible then
      begin
        dbgBuscaContaDblClick(Nil);
        pCarregaPlanoContabilDebito(blnBuscaPorChave, True) ;
      end;
    End

    Else If (Sender = edtTipLan) Then
    Begin
      if fEmptyStr(edtTipLan.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Tipo de Lançamento deve ser preenchido!', ['&O k']);
        Result := False;
      end;
    End

    Else If (Sender = dbeCCusto) Then
    Begin
      If Not fEmptyStr(dbeCcusto.Text) Then
      Begin
        pCarregaEventos;
        If fEmptyStr(edtDesCCusto.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        qryTabela.FieldByName('CON_CCUSTO').AsVariant := Null;
        edtDesCCusto.Clear;
      End;
    End

    Else If (dbeCCuscr.Visible) and (Sender = dbeCcuscr) Then
    Begin
      If Not fEmptyStr(dbeCcuscr.Text) Then
      Begin
        pCarregaEventosCredito;
        If fEmptyStr(edtDesCcuscr.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        qryTabela.FieldByName('CON_CCUSCR').AsVariant := Null;
        edtDesCcuscr.Clear;
      End;
    End

    else if (Sender = dbeHisPad) then
    begin
      If fEmptyStr(dbeHisPad.Text) Then
      Begin
        if fEmptyStr(dbeEmpLan.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Preencher Empresa do Lançamento!', ['&OK']);
          dbeHisPad.Text := '';
          Result := False;
          Exit;
        end;

        pCarregaHistorico;
        If fEmptyStr(edtDesHistPadrao.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse histórico padrão não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        qryTabela.FieldByName('CON_HISPAD').AsVariant := Null;
        edtDesHistPadrao.Clear;
      End;

    end

  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

function TfrmManLanCon.fValidarTrDcZe: Boolean;
begin
  Result := True ;
  if (fEmptyStr(fSemMascaraPlaNco(qryTabela.FieldByName('CON_CONCRE').AsString))) or
            (fEmptyStr(fSemMascaraPlaNco(qryTabela.FieldByName('CON_CONDEB').AsString))) then
  begin
    if fCfgTrDcZe = 'S' then
    begin
      fMensagem('', '"Conta de Débito" e "Conta de Crédito" devem ser informadas!', ['&OK']);
      Result := False ;
      pSetFocusValidacaoTrDcZe ;
      Exit;
    end;
  end;
end;

procedure TfrmManLanCon.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CON_DTALAN');
  stlCamInd.Add('CON_CONCRE');
  stlCamInd.Add('CON_CONDEB');

  stlDesInd.Add('Data Lançamento');
  stlDesInd.Add('Conta Crédito');
  stlDesInd.Add('Conta Débito');
end;

procedure TfrmManLanCon.btnAlterarClick(Sender: TObject);
var
  strMensagem: string;
begin
  if (qryTabela.Active) And (Not qryTabela.IsEmpty) And
     (fLancamentoAnteriorFechamento(qryTabela.FieldByName('CON_DTALAN').AsDateTime, qryTabela.FieldByName('CON_EMPLAN').AsString, strMensagem)) then
  begin
    fMensagem('', strMensagem, ['&OK']);
    Exit;
  end;

  if not fValidouOperacao then
    exit;

  inherited;
  dbeEmpLan.Enabled := False;
  dbeCodOpe.Enabled := False;
  dbcAutoma.Enabled := False;
end;

procedure TfrmManLanCon.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregarDados;
end;

procedure TfrmManLanCon.btnCancelarClick(Sender: TObject);
begin
  inherited;
  edtTipoLanctoConf.ItemIndex := -1;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtSomaDebitoConf.Clear;
  edtSomaCreditoConf.Clear;
  qryConfer.Close;
  pSetaDadosConferencia;
  pSetFocus(edtTipoLanctoConf);
end;

procedure TfrmManLanCon.btnExcluirClick(Sender: TObject);
var
  strMensagem: string;
begin
  blnPerguntarParaExcluir := False;

  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  if (qryTabela.Active) And (Not qryTabela.IsEmpty) And
     (fLancamentoAnteriorFechamento(qryTabela.FieldByName('CON_DTALAN').AsDateTime, qryTabela.FieldByName('CON_EMPLAN').AsString, strMensagem)) then
  begin
    fMensagem('', strMensagem, ['&OK']);
    Exit;
  end;

  if not fValidouOperacao then
    exit;

  if (fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 2) then
  begin
    Exit;
  end;

  fStartTransaction;
  try
    if (blnUtilizaRotinaLoteContabil) then
    begin
      if (fGetQtdLanCon(qryTabela.FieldByName('CON_INCDOC').AsString,
                        qryTabela.FieldByName('CON_TIPLAN').AsString,
                        qryTabela.FieldByName('CON_EMPLAN').AsString) <= 1) then
      begin
        pDeletarLotInc(qryTabela.FieldByName('CON_INCDOC').AsString,
                       qryTabela.FieldByName('CON_TIPLAN').AsString,
                       qryTabela.FieldByName('CON_EMPLAN').AsString);
      end;
    end;
    inherited;
    if (blnExcluiu) then
    begin
      fCommit;
      pCarregarDados;
    end
    else
      fRollBack;
  except
    On E: Exception do
    begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmManLanCon.btnExcluirClick]');
    end;
  end;
end;

procedure TfrmManLanCon.btnExclusaoLoteClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmExclusaoLanctoContabil, frmExclusaoLanctoContabil);
end;

procedure TfrmManLanCon.btnFiltrarClick(Sender: TObject);
  Var
    Posicao: TPoint;
begin
  if fPermiteFiltrarSelecionado then
  begin
    GetCursorPos(Posicao);
    popConsulta.Popup(Posicao.X, Posicao.Y)
  end
  else
    mnuFiltros.Click;
end;

procedure TfrmManLanCon.btnGravarClick(Sender: TObject);
  var
    blnInsertMode : boolean;
    strLoteContabil : string;
    intSeqLotInc : Integer;
    strIncDoc : string;
    fltValorLancamento: double;
    strMensagemValidacao: string;
begin
  blnVerificaProCod := False;
  blnUsaProCodigo := False;
  blnInsertMode := (qryTabela.State = dsInsert);

  if fEmptyStr(qryTabela.FieldByName('CON_EMPLAN').AsString) then
    qryTabela.FieldByName('CON_EMPLAN').AsString := VS_strCodEmp;

  if (qryTabela.Active) And (Not qryTabela.IsEmpty) And
     (fLancamentoAnteriorFechamento(qryTabela.FieldByName('CON_DTALAN').AsDateTime, qryTabela.FieldByName('CON_EMPLAN').AsString, strMensagemValidacao)) then
  begin
    fMensagem('', strMensagemValidacao, ['&OK']);
    Exit;
  end;

  if (fLancouContasIguais) then
  begin
    fMensagem('', 'Não é permitido lançar contas contábeis iguais!', ['&OK']);
    Exit;
  end;

  if not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                 qryTabela.FieldByName('CON_DTALAN').AsDateTime,
                                 qryTabela.FieldByName('CON_CONCRE').AsString,
                                 strMensagemValidacao,
                                 qryTabela.FieldByName('CON_EMPLAN').AsString) then
  begin
    fMensagem('', strMensagemValidacao, ['&OK']);
    Exit;
  end ;

  if not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                 qryTabela.FieldByName('CON_DTALAN').AsDateTime,
                                 qryTabela.FieldByName('CON_CONDEB').AsString,
                                 strMensagemValidacao,
                                 qryTabela.FieldByName('CON_EMPLAN').AsString) then
  begin
    fMensagem('', strMensagemValidacao, ['&OK']);
    Exit;
  end ;

  if (fInformouPartidaSimples(fltValorLancamento)) and
     (Assigned(prcMultLancamentos)) then
  begin
    listaMultLancamento.Clear;
    if (fMensagem('', 'Deseja informar os lançamentos da partida múltipla?', ['&Sim', '&Não'], 2) = 1) Then
    begin
      prcMultLancamentos(listaMultLancamento, fltValorLancamento, qryTabela.FieldByName('CON_DTALAN').AsDateTime, qryTabela.FieldByName('CON_EMPLAN').AsString);
    end
    else
    begin
      if not fValidarTrDcZe then
      begin
        Exit;
      end;
    end;
  end
  else
  begin
    if not fValidarTrDcZe then
    begin
      Exit;
    end;
  end;

  fStartTransaction;
  try
    if (blnInsertMode) and (blnUtilizaRotinaLoteContabil) then
    begin
      pAtribuiValoresOnPost(qryTabela);

      intSeqLotInc := fGetNovoLoteContabil;

      strIncDoc := qryTabela.FieldByName('CON_INCDOC').AsString;
      if fEmptyStr(strIncDoc) then
      begin
        strIncDoc := fFormatoLoteContabil(FormatDateTime('yyyymm', VS_Date), intSeqLotInc);
        qryTabela.FieldByName('CON_INCDOC').AsString := strIncDoc;
      end;

      strLoteContabil := fInserirLotInc(strIncDoc,
                                        qryTabela.FieldByName('CON_TIPLAN').AsString,
                                        qryTabela.FieldByName('CON_EMPLAN').AsString,
                                        qryTabela.FieldByName('CON_DTALAN').AsDateTime,
                                        qryTabela.FieldByName('CON_AUTOMA').AsInteger,
                                        intSeqLotInc);

      if fEmptyStr(strLoteContabil) then
        raise Exception.Create('Aconteceu um erro ao gravar o lote contábil!');
    end;

    if (blnInsertMode) and (qryTabela.FieldByName('CON_INCDOC').AsString.IsEmpty) then
      qryTabela.FieldByName('CON_INCDOC').AsString := fGerarIncDocLanConManual ;

    inherited;
    if (blnGravou) then
    begin
      if (blnInsertMode) then
        pGravarMultLancamentos;

      fCommit;
      pCarregarDados;
    end
    else
      fRollBack;
  except
    On E: Exception do
    begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmManLanCon.btnGravarClick]');
    end;
  end;
end;

procedure TfrmManLanCon.btnIncluirClick(Sender: TObject);
begin
  if not fValidouOperacao then
    exit;

  inherited;
  dbeCodOpe.Enabled := False;
  dbeEmpLan.Enabled := False;
  dbcAutoma.Enabled := False;
  pLimpaEdits;

  dbeEmpLan.Field.AsString := VS_strCodEmp;
  qryTabela.FieldByName('CON_TIPLAN').AsString := 'MAN';

  if blnExisteCampoCON_VERSIS then
    qryTabela.FieldByName('CON_VERSIS').AsString := VC_StrVersaoContabilidade;

  if blnExisteCampoCON_EMPLOG then
    qryTabela.FieldByName('CON_EMPLOG').AsString := VS_strCodEmp;

  edtTipLan.ItemIndex := fGetIndexTipLan(edtTipLan.Items, qryTabela.FieldByName('CON_TIPLAN').AsString);
  Self.SelectFirst;
  pSetFocus(dbeDtaLan);
end;

procedure TfrmManLanCon.btnPesquisaClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrkey : Char;
    plcTipoPesquisa : TPesquisaLancamentoContabil ;
begin
  chrKey := '/';
  If fPesqLanCon(Self, dbeAutoincrem, dbeEmpLan, qryTabela, chrKey, arrSel, plcTipoPesquisa) Then
  Begin
    If btnAlterar.Visible And btnAlterar.Enabled Then
    begin
      pCarregarDados;
      pSetFocus(btnAlterar);
    end;
  End;
end;

procedure TfrmManLanCon.cxgConfDBTableViewCitel1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pSetaDadosConferencia;
end;

procedure TfrmManLanCon.cxgConfDBTableViewCitel1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key Of
    VK_UP, VK_DOWN: pSetaDadosConferencia;
  end;
end;

procedure TfrmManLanCon.dbeCcuscrKeyPress(Sender: TObject; var Key: Char);
Var
  arrEvento : TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, dbeCcuscr, edtDesCcuscr, Nil, Key, arrEvento, True, True) Then
  Begin
    If fValidaCampos(dbeCcuscr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManLanCon.dbeCcustoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEvento : TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, dbeCCusto, edtDesCCusto, Nil, Key, arrEvento, True, True) Then
  Begin
    If fValidaCampos(dbeCCusto, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManLanCon.dbeConCreClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmManLanCon.dbeConCreKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPlan: TConsultasArray;
    strTplaco: string ;
begin
  If fEntraCons(Key) Then
  Begin
    strTplaco :=   Contabilidade.Funcoes.fRetTplacoEmpresaLogada(dbeEmpLan.Field.AsString) ;
    TStringField(qryTabela.FieldByName('CON_CONCRE')).EditMask := '';
    Try
      If fPesqPlanoContabil(Self, dbeConCre, edtDesConCre, Nil, Key, arrPlan, True, '', not blnExisteCampoNCO_NATURE) Then
        SelectNext(ActiveControl, True, True);

      edtDesConCre.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(dbeConCre.Text), strTplaco]);
      edtConCreRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(dbeConCre.Text), strTplaco]);
    Finally
        TStringField(qryTabela.FieldByName('CON_CONCRE')).EditMask := fMskCon;
    End;
  End;
end;

procedure TfrmManLanCon.dbeConCreKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pBuscarConta(dbeConCre, False, 2);
end;

procedure TfrmManLanCon.dbeConDebClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmManLanCon.dbeConDebKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPlan: TConsultasArray;
    strTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(dbeEmpLan.Field.AsString) ;
    TStringField(qryTabela.FieldByName('CON_CONDEB')).EditMask := '';
    Try
      If fPesqPlanoContabil(Self, dbeConDeb, edtDesConDeb, Nil, Key, arrPlan, True, '', not blnExisteCampoNCO_NATURE) Then
        SelectNext(ActiveControl, True, True);

      edtDesConDeb.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(dbeConDeb.Text), strTplaco]);
      edtConDebRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(dbeConDeb.Text), strTplaco]);
    Finally
      TStringField(qryTabela.FieldByName('CON_CONDEB')).EditMask := fMskCon;
    End;
  End;
end;

procedure TfrmManLanCon.dbeConDebKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pBuscarConta(dbeConDeb, False, 1);
end;

procedure TfrmManLanCon.dbeEmpLanExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeHisPad);
end;

procedure TfrmManLanCon.dbeHisPadKeyPress(Sender: TObject; var Key: Char);
  var
    arrHisPad : TConsultasArray;
begin
  inherited;

  if fEmptyStr(dbeEmpLan.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Preencher Empresa do Lançamento!', ['&OK']);
    Key := #0;
    Exit;
  end;

  If fPesqHistoricoPadrao(Self, dbeHisPad, edtDesHistPadrao, Nil, Key, arrHisPad, True, dbeEmpLan.Text) Then
  Begin
    If fValidaCampos(dbeHisPad, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManLanCon.dbgBuscaContaDblClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
  If (dbgBuscaConta.Tag = 1) Then
  Begin
    TStringField(qryTabela.FieldByName('CON_CONDEB')).EditMask := '';
    try
      qryTabela.FieldByName('CON_CONDEB').AsString := qryBusca.FieldByName('CODCON').AsString;
      dbeConDeb.Text := qryBusca.FieldByName('CODCON').AsString;
      edtConDebRed.Text := qryBusca.FieldByName('CONRED').AsString;
    finally
      TStringField(qryTabela.FieldByName('CON_CONDEB')).EditMask := fMskCon;
    end;
  End
  Else If (dbgBuscaConta.Tag = 2) Then
  Begin
    TStringField(qryTabela.FieldByName('CON_CONCRE')).EditMask := '';
    try
      qryTabela.FieldByName('CON_CONCRE').AsString := qryBusca.FieldByName('CODCON').AsString;
      dbeConCre.Text := qryBusca.FieldByName('CODCON').AsString;
      edtConCreRed.Text := qryBusca.FieldByName('CONRED').AsString;
    finally
      TStringField(qryTabela.FieldByName('CON_CONCRE')).EditMask := fMskCon;
    end;
  End;
end;

procedure TfrmManLanCon.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
end;

procedure TfrmManLanCon.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManLanCon.edtConCreRedClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmManLanCon.edtConCreRedKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pBuscarConta(edtConCreRed, True, 2);
end;

procedure TfrmManLanCon.edtConDebRedClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmManLanCon.edtConDebRedKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pBuscarConta(edtConDebRed, True, 1);
end;

procedure TfrmManLanCon.pLiberaPlancoVigencia;
begin
  if not FValidarVigenciaCta then
  begin
    exit ;
  end;

  if assigned(cdsPlancoVigencia) then
    FreeAndNil(cdsPlancoVigencia);
end;

procedure TfrmManLanCon.pLimpaEdits;
begin
  edtDesConCre.Clear;
  edtDesConDeb.Clear;
  edtConDebRed.Clear;
  edtConCreRed.Clear;
  edtDesHistPadrao.Clear;
  edtNomOpe.Clear;
  edtTipLan.ItemIndex := -1;
end;

procedure TfrmManLanCon.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('CON_CONCRE') <> nil Then
      TStringField(FieldByName('CON_CONCRE')).EditMask := fMskCon;

    If FindField('CON_CONDEB') <> nil Then
      TStringField(FieldByName('CON_CONDEB')).EditMask := fMskCon;

    If FindField('CON_DTALAN') <> nil Then
      TDateField(FieldByName('CON_DTALAN')).EditMask := '99/99/9999';

    If FindField('CON_VALLAN') <> nil Then
      TFloatField(FieldByName('CON_VALLAN')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmManLanCon.pAtribuiValoresOnPost(DataSet: TDataSet);
begin
  Dataset.FieldByName('CON_TIPLAN').AsString := LeftStr(edtTipLan.Text, 3);
  if Dataset.State = dsInsert then
    Dataset.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado;
end;

procedure TfrmManLanCon.pBeforePost(Dataset: TDataset);
begin
  pAtribuiValoresOnPost(DataSet);
end;

procedure TfrmManLanCon.pBuscarConta(dbeTexto: TCustomEdit; blnRed: Boolean; intTag: Integer);
var
  strTplaco: string ;
begin
  If (fEmptyStr(fSemMascaraPlaNco(dbeTexto.Text), True)) Then
  Begin
    dbgBuscaConta.Visible := False;
    Exit;
  End;

  strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(dbeEmpLan.Field.AsString) ;

  dbgBuscaConta.Tag := 0;

  qryBusca.Close;
  qryBusca.SQL.Clear;
  qryBusca.SQL.Add(' SELECT NCO_CODCON AS CODCON, NCO_DESCRI AS DESCON, NCO_CONRED AS CONRED ');
  qryBusca.SQL.Add('   FROM PLANCO ');
  qryBusca.SQL.Add('  WHERE TRUE AND NCO_TPLACO = :TPLACO ');
  qryBusca.ParamByName('TPLACO').AsString := strTplaco ;
  If (blnRed) Then
    qryBusca.SQL.Add('  AND (NCO_CONRED LIKE :CODCON) ')
  Else
    qryBusca.SQL.Add('  AND (NCO_CODCON LIKE :CODCON) ');

  if fCfgCtntsi = 'N' then
  begin
    qryBusca.SQL.Add(' AND IFNULL(NCO_NATURE,"A") = "A" ') ;
  end ;

  qryBusca.ParamByName('CODCON').AsString := '%' + fTiraCaracEspeciais(fSemMascaraPlaNco(dbeTexto.Text), True, True, True, True, True) + '%';
  qryBusca.SQL.Add('  ORDER BY NCO_CODCON ');
  qryBusca.Open;

  If (Not qryBusca.IsEmpty) Then
  Begin
    If (blnRed) Then
    begin
      if (intTag = 1) then
        qryBusca.Locate('NCO_CODCON', dbeConDeb.Text, [])
      else
        qryBusca.Locate('NCO_CODCON', dbeConCre.Text, []);
    end;

    dbgBuscaConta.Left := dbeTexto.Left;
    dbgBuscaConta.Top := dbeTexto.Top + dbeTexto.Height + 1;
    dbgBuscaConta.Visible := True;
    dbgBuscaConta.Tag := intTag;
  End
  Else
    dbgBuscaConta.Visible := False;
end;

procedure TfrmManLanCon.pCarregaEventos;
begin
  If Not fEmptyStr(dbeCcusto.Text) Then
    edtDesCCusto.Text := fRetNomEvento(dbeCcusto.Text)
  Else
    edtDesCCusto.Clear;
end;

procedure TfrmManLanCon.pCarregaEventosCredito;
begin
  If Not fEmptyStr(dbeCcuscr.Text) Then
    edtDesCcuscr.Text := fRetNomEvento(dbeCcuscr.Text)
  Else
    edtDesCCuscr.Clear;
end;

procedure TfrmManLanCon.pCarregaHistorico;
begin
  if not fEmptyStr(dbeHisPad.Text) then
    edtDesHistPadrao.Text := fRetDescHistoricoPadrao(dbeHisPad.Text, dbeEmpLan.Text)
  else
    edtDesHistPadrao.Clear;
end;

procedure TfrmManLanCon.pCarregaPlanoContabilCredito(
  const blnBuscaPorChave: Boolean; blnCampoContaReduzida: Boolean);
begin
  if blnBuscaPorChave then
  begin
    edtDesConCre.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConCre.Text)]);
    if not blnCampoContaReduzida then
    begin
      edtConCreRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConCre.Text)]);
    end;
  end
  else
  begin
    edtDesConCre.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConCre.Text)]);
    if not blnCampoContaReduzida then
    begin
      edtConCreRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConCre.Text)]);
    end;
  end;
end;

procedure TfrmManLanCon.pCarregaPlanoContabilDebito(
  const blnBuscaPorChave: Boolean; blnCampoContaReduzida: Boolean);
begin
  if blnBuscaPorChave then
  begin
    edtDesConDeb.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConDeb.Text)]);
    if not blnCampoContaReduzida then
    begin
      edtConDebRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConDeb.Text)]);
    end;
  end
  else
  begin
    edtDesConDeb.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConDeb.Text)]);
    if not blnCampoContaReduzida then
    begin
      edtConDebRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConDeb.Text)]);
    end;
  end;
end;

procedure TfrmManLanCon.pCarregarDados;
begin
  dbgBuscaConta.Visible := False;
  edtDesHistPadrao.Text := IfThen(not string(dbeEmpLan.Text).Trim.IsEmpty, fRetDescHistoricoPadrao(dbeHisPad.Text, dbeEmpLan.Text));
  edtDesCCusto.Text := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [dbeCCusto.Text]);
  if dbeCCuscr.Visible then
    edtDesCCuscr.Text := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [dbeCCuscr.Text]);
  edtNomOpe.Text := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [dbeCodOpe.Text]);
  edtDesConCre.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConCre.Text)]);
  edtConCreRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConCre.Text)]);
  edtDesConDeb.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConDeb.Text)]);
  edtConDebRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeConDeb.Text)]);
  edtTipLan.ItemIndex := fGetIndexTipLan(edtTipLan.Items, qryTabela.FieldByName('CON_TIPLAN').AsString);
end;

function TfrmManLanCon.fGetQtdLanCon(strIncDoc, strTipLan, strEmpLan: string): integer;
  var
    qryDel : TUniQuery;
begin
  qryDel := fCriaQuery;
  try
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add(' SELECT COUNT(*) CNT ');
    qryDel.SQL.Add('   FROM LANCON ');
    qryDel.SQL.Add('  WHERE CON_TIPLAN = :TIPLAN ');
    qryDel.SQL.Add('    AND CON_INCDOC = :INCDOC ');
    qryDel.SQL.Add('    AND CON_EMPLAN = :EMPLAN ');
    qryDel.ParamByName('TIPLAN').AsString := strTipLan;
    qryDel.ParamByName('INCDOC').AsString := strIncDoc;
    qryDel.ParamByName('EMPLAN').AsString := strEmpLan;
    qryDel.Open;
    Result := qryDel.FieldByName('CNT').AsInteger;
    qryDel.Close;
  finally
    FreeAndNil(qryDel);
  end;
end;

function TfrmManLanCon.fInformouPartidaSimples(var fltValorLancamento: double): boolean;
begin
  fltValorLancamento := qryTabela.FieldByName('CON_VALLAN').AsFloat;

  Result := (fEmptyStr(fSemMascaraPlaNco(qryTabela.FieldByName('CON_CONCRE').AsString))) or
            (fEmptyStr(fSemMascaraPlaNco(qryTabela.FieldByName('CON_CONDEB').AsString)));

  if (fEmptyStr(fSemMascaraPlaNco(qryTabela.FieldByName('CON_CONCRE').AsString))) then
    fltValorLancamento := -fltValorLancamento;
end;

procedure TfrmManLanCon.pDeletarLotInc(strIncDoc, strTipLan, strEmpLan: string);
  var
    qryDel : TUniQuery;
begin
  qryDel := fCriaQuery;
  try
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add(' DELETE ');
    qryDel.SQL.Add('   FROM LOTINC ');
    qryDel.SQL.Add('  WHERE INC_TIPLAN = :TIPLAN ');
    qryDel.SQL.Add('    AND INC_INCDOC = :INCDOC ');
    qryDel.SQL.Add('    AND INC_EMPLAN = :EMPLAN ');
    qryDel.ParamByName('TIPLAN').AsString := strTipLan;
    qryDel.ParamByName('INCDOC').AsString := strIncDoc;
    qryDel.ParamByName('EMPLAN').AsString := strEmpLan;
    qryDel.ExecSQL;
  finally
    FreeAndNil(qryDel);
  end;
end;

procedure TfrmManLanCon.pEscondeCentroCustoCredito;
const
  C_HEIGHT = 26 ;
begin
  /////esconde os campos.
  lbCCuscr.Visible := False ;
  dbeCCuscr.Visible := False ;
  edtDesCCuscr.Visible := False ;
  ///remove o link com o field
  dbeCCuscr.DataField := '' ;
  //////desloca os campos a baixo para cima
  lbTipLan.Top := lbTipLan.Top - C_HEIGHT ;
  edtTipLan.Top := edtTipLan.Top - C_HEIGHT ;
  dbcAutoma.Top := dbcAutoma.Top - C_HEIGHT ;
  //////ajusta o tamanho do formulario
  self.Height := self.Height - C_HEIGHT ;
end;

procedure TfrmManLanCon.pgcDadosChange(Sender: TObject);
begin
  inherited;
  if pgcDados.ActivePage = tbsConferencia then
  begin
    edtTipoLanctoConf.Enabled := True;
    edtCodEmp.Enabled := True;
    mskDtaIni.Enabled := True;
    mskDtaFin.Enabled := True;
    mnuRegistroSelecionado.Enabled := fPermiteFiltrarSelecionado;
  end;
end;

procedure TfrmManLanCon.pGravarMultLancamentos;
  var
    qryDados : TUniQuery;
    Ldados : TDadosImportacaoContabil;
begin
  if (listaMultLancamento.Count = 0) then
    Exit;

  qryDados := fCriaQuery(Self);
  try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT * FROM LANCON WHERE FALSE');
    qryDados.Open;

    for Ldados in listaMultLancamento do
    begin
      if (Ldados.fltValorLancamento <> 0) then
      begin
        qryDados.Insert;
        qryDados.FieldByName('CON_EMPLAN').AsString := qryTabela.FieldByName('CON_EMPLAN').AsString;
        qryDados.FieldByName('CON_DTALAN').AsDateTime := qryTabela.FieldByName('CON_DTALAN').AsDateTime;
        qryDados.FieldByName('CON_TIPLAN').AsString := qryTabela.FieldByName('CON_TIPLAN').AsString;
        qryDados.FieldByName('CON_CLAFIS').AsString := qryTabela.FieldByName('CON_CLAFIS').AsString;
        qryDados.FieldByName('CON_NATOPE').AsString := qryTabela.FieldByName('CON_NATOPE').AsString;
        qryDados.FieldByName('CON_DESVAL').AsString := qryTabela.FieldByName('CON_DESVAL').AsString;
        qryDados.FieldByName('CON_CONCRE').AsString := Ldados.strContaCredito;
        qryDados.FieldByName('CON_CONDEB').AsString := Ldados.strContaDebito;
        qryDados.FieldByName('CON_HISPAD').AsInteger := Ldados.intCodigoHistoricoPadrao;
        qryDados.FieldByName('CON_HISTOR').AsString := fRetDescHistoricoPadrao(Ldados.intCodigoHistoricoPadrao.ToString, qryTabela.FieldByName('CON_EMPLAN').AsString);
        qryDados.FieldByName('CON_VALLAN').AsFloat := Ldados.fltValorLancamento;
        qryDados.FieldByName('CON_AUTOMA').AsInteger := qryTabela.FieldByName('CON_AUTOMA').AsInteger;
        qryDados.FieldByName('CON_CCUSTO').AsString := qryTabela.FieldByName('CON_CCUSTO').AsString;
        qryDados.FieldByName('CON_CODOPE').AsString := qryTabela.FieldByName('CON_CODOPE').AsString;
        qryDados.FieldByName('CON_INCDOC').AsString := qryTabela.FieldByName('CON_INCDOC').AsString;
        qryDados.FieldByName('CON_C_G_C_').AsString := qryTabela.FieldByName('CON_C_G_C_').AsString;
        qryDados.FieldByName('CON_CCUSCR').AsString := qryTabela.FieldByName('CON_CCUSCR').AsString;
        qryDados.FieldByName('CON_TABELA').AsString := qryTabela.FieldByName('CON_TABELA').AsString;

        if blnExisteCampoCON_VERSIS then
          qryDados.FieldByName('CON_VERSIS').AsString := qryTabela.FieldByName('CON_VERSIS').AsString;

        if blnExisteCampoCON_EMPLOG then
          qryDados.FieldByName('CON_EMPLOG').AsString := qryTabela.FieldByName('CON_EMPLOG').AsString;

        if qryDados.FieldByName('CON_NATOPE').AsString.IsEmpty then
          qryDados.FieldByName('CON_NATOPE').Value := Null;

        if qryDados.FieldByName('CON_HISPAD').AsInteger = -1 then
          qryDados.FieldByName('CON_HISPAD').Value := Null;

        if qryDados.FieldByName('CON_CCUSTO').AsString.IsEmpty then
          qryDados.FieldByName('CON_CCUSTO').Value := Null;

        if qryDados.FieldByName('CON_CODOPE').AsString.IsEmpty then
          qryDados.FieldByName('CON_CODOPE').Value := Null;

        if qryDados.FieldByName('CON_C_G_C_').AsString.IsEmpty then
          qryDados.FieldByName('CON_C_G_C_').Value := Null;

        if qryDados.FieldByName('CON_CCUSCR').AsString.IsEmpty then
          qryDados.FieldByName('CON_CCUSCR').Value := Null;

        if qryDados.FieldByName('CON_CONCRE').AsString.IsEmpty then
          qryDados.FieldByName('CON_CONCRE').Value := Null;

        if qryDados.FieldByName('CON_CONDEB').AsString.IsEmpty then
          qryDados.FieldByName('CON_CONDEB').Value := Null;

        qryDados.Post;
      end;
    end;
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmManLanCon.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      Close;
    End
    Else
    Begin
      SelectNext(ActiveControl, False, True);
    End;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmManLanCon.fPermiteFiltrarSelecionado: boolean;
begin
  Result := True;

  if not Assigned(qryTabela) then
    Exit(False);

  if (not qryTabela.Active) then
    Exit(False);

  if (qryTabela.IsEmpty) then
    Exit(False);

  if not Assigned(qryTabela.FindField('CON_INCDOC')) then
    Exit(False);

  if qryTabela.FieldByName('CON_INCDOC').AsString.IsEmpty then
    Exit(False);
end;

function TfrmManLanCon.fProximoCodigo: String;
begin
  Result := IntToStr(StrToInt(fAtualizaProCod(strNomeTabela, '', '')));
end;

function TfrmManLanCon.fValidouCamposConferencia: boolean;
begin
  Result := True;

  If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&OK']);
    pSetFocus(mskDtaIni);
    Result := False;
  End

  Else If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&OK']);
    pSetFocus(mskDtaFin);
    Result := False;
  End

  Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&OK']);
    pSetFocus(mskDtaIni);
    Result := False;
  End;
end;

function TfrmManLanCon.fValidouOperacao: boolean;
  var
    strSenha : string;
begin
  Result := True;

  if (not blnCfg_SENLCOExiste) then
    exit;

  if (fEmptyStr(fCfgSis('SENLCO', VarString))) then
    exit;

  strSenha := '';
  If ffrmSenha(strSenha, 'Bloqueio do lançamento contábil.') Then
    Result := (strSenha = fCfgSis('SENVRU'))
  Else
    Result := False;
end;

procedure TfrmManLanCon.mnuFiltrosClick(Sender: TObject);
begin
  if not fValidouCamposConferencia then
    exit;

  blnFiltrarRegistroSelecionado := False;
  fChamaTelaGravando(fGerar);
end;

procedure TfrmManLanCon.mnuRegistroSelecionadoClick(Sender: TObject);
begin
  blnFiltrarRegistroSelecionado := True;
  try
    fChamaTelaGravando(fGerar);
  finally
    blnFiltrarRegistroSelecionado := False;
  end;
end;

function TfrmManLanCon.fGerar(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  btnFiltrar.Enabled := False;
  try
    pCarregaDadosConferencia;
    pSetaDadosConferencia;
    pSetaSomaPeriodoConferencia;
  finally
    btnFiltrar.Enabled := True;
  end;
end;

procedure TfrmManLanCon.pSetaSomaPeriodoConferencia;
  var
    qrySomaConf : TUniQuery;
begin
  qrySomaConf := fCriaQuery(Self);
  try
    qrySomaConf.SQL.Add(' SELECT SUM(IF(CON_CONDEB IS NULL, 0, CON_VALLAN)) AS DEBITO,  ');
    qrySomaConf.SQL.Add('        SUM(IF(CON_CONCRE IS NULL, 0, CON_VALLAN)) AS CREDITO  ');
    qrySomaConf.SQL.Add('   FROM LANCON ');

    if (blnFiltrarRegistroSelecionado) then
    begin
      qrySomaConf.SQL.Add(' WHERE CON_TIPLAN = :TIPLAN ');
      qrySomaConf.SQL.Add('   AND CON_INCDOC = :INCDOC ');
      qrySomaConf.SQL.Add('   AND CON_EMPLAN = :EMPLAN ');

      qrySomaConf.ParamByName('TIPLAN').AsString := qryTabela.FieldByName('CON_TIPLAN').AsString;
      qrySomaConf.ParamByName('INCDOC').AsString := qryTabela.FieldByName('CON_INCDOC').AsString;
      qrySomaConf.ParamByName('EMPLAN').AsString := qryTabela.FieldByName('CON_EMPLAN').AsString;
    end
    else
    begin
      qrySomaConf.SQL.Add(' WHERE CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

      if (edtTipoLanctoConf.ItemIndex >= 0) then
      begin
        qrySomaConf.SQL.Add('  AND CON_TIPLAN = :TIPLAN ');
        qrySomaConf.ParamByName('TIPLAN').AsString := LeftStr(edtTipoLanctoConf.Items[edtTipoLanctoConf.ItemIndex], 3);
      end;

      if (not fEmptyStr(edtCodEmp.Text)) then
      begin
        qrySomaConf.SQL.Add('  AND CON_EMPLAN = :EMPLAN ');
        qrySomaConf.ParamByName('EMPLAN').AsString := edtCodEmp.Text;
      end;

      qrySomaConf.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      qrySomaConf.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    end;

    qrySomaConf.Open;
    edtSomaDebitoConf.Text := FloatToStrF(qrySomaConf.FieldByName('DEBITO').AsFloat, ffFixed, 12, 2);
    edtSomaCReditoConf.Text := FloatToStrF(qrySomaConf.FieldByName('CREDITO').AsFloat, ffFixed, 12, 2);
  finally
    FreeAndNil(qrySomaConf);
  end;
end;

procedure TfrmManLanCon.pSetFocusValidacaoTrDcZe;
begin
  if fEmptyStr(fSemMascaraPlaNco(dbeConDeb.Text)) then
  begin
    pSetFocus(dbeConDeb);
    exit ;
  end ;

  if fEmptyStr(fSemMascaraPlaNco(dbeConCre.Text)) then
  begin
    pSetFocus(dbeConCre);
    exit ;
  end ;
end;

procedure TfrmManLanCon.pSetaDadosConferencia;
begin
  if (qryConfer.Active) and (not qryConfer.IsEmpty) then
  begin
    edtContaDebitoConf.Text := qryConfer.FieldByName('CON_CONDEB').AsString;
    edtContaCreditoConf.Text := qryConfer.FieldByName('CON_CONCRE').AsString;
    edtHisPadConf.Text := qryConfer.FieldByName('CON_HISPAD').AsString;
    edtDesHisPadConf.Text := qryConfer.FieldByName('PAD_DESCRI').AsString;
    edtValLanConf.Text := FloatToStrF(qryConfer.FieldByName('CON_VALLAN').AsFloat, ffFixed, 12, 2);
  end
  else
  begin
    edtContaDebitoConf.Clear;
    edtContaCreditoConf.Clear;
    edtHisPadConf.Clear;
    edtDesHisPadConf.Clear;
    edtValLanConf.Clear;
  end;
end;

procedure TfrmManLanCon.pCarregaDadosConferencia;
begin
  qryConfer.Close;
  qryConfer.SQL.Clear;
  qryConfer.SQL.Add(' SELECT CON_EMPLAN, CON_DTALAN, CON_CONDEB, CON_CONCRE, ');
  qryConfer.SQL.Add('        CON_VALLAN, CON_HISPAD, PAD_DESCRI, ');
  qryConfer.SQL.Add('        CONCAT(CON_CONDEB, "-", PD.NCO_DESCRI) AS CONDEB, ');
  qryConfer.SQL.Add('        CONCAT(CON_CONCRE, "-", PC.NCO_DESCRI) AS CONCRE  ');
  qryConfer.SQL.Add('   FROM LANCON ');
  qryConfer.SQL.Add('   INNER JOIN CADEMP E ON LANCON.CON_EMPLAN = E.EMP_CODEMP ');
  qryConfer.SQL.Add('   LEFT JOIN HISPAD ON CON_HISPAD = PAD_CODIGO ');
  if fCfgHisTpl then
    qryConfer.SQL.Add('  AND PAD_TPLACO = E.EMP_TPLACO ')
  else
    qryConfer.SQL.Add('  AND IFNULL(PAD_TPLACO, "") = "" ');
  qryConfer.SQL.Add('   LEFT JOIN PLANCO PD ON CON_CONDEB = PD.NCO_CODCON AND PD.NCO_TPLACO = E.EMP_TPLACO ');
  qryConfer.SQL.Add('   LEFT JOIN PLANCO PC ON CON_CONCRE = PC.NCO_CODCON AND PC.NCO_TPLACO = E.EMP_TPLACO ');

  if (blnFiltrarRegistroSelecionado) then
  begin
    qryConfer.SQL.Add(' WHERE CON_TIPLAN = :TIPLAN ');
    qryConfer.SQL.Add('   AND CON_INCDOC = :INCDOC ');
    qryConfer.SQL.Add('   AND CON_EMPLAN = :EMPLAN ');

    qryConfer.ParamByName('TIPLAN').AsString := qryTabela.FieldByName('CON_TIPLAN').AsString;
    qryConfer.ParamByName('INCDOC').AsString := qryTabela.FieldByName('CON_INCDOC').AsString;
    qryConfer.ParamByName('EMPLAN').AsString := qryTabela.FieldByName('CON_EMPLAN').AsString;
  end
  else
  begin
    qryConfer.SQL.Add('  WHERE CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    if (edtTipoLanctoConf.ItemIndex >= 0) then
    begin
      qryConfer.SQL.Add('  AND CON_TIPLAN = :TIPLAN ');
      qryConfer.ParamByName('TIPLAN').AsString := LeftStr(edtTipoLanctoConf.Items[edtTipoLanctoConf.ItemIndex], 3);
    end;

    if (not fEmptyStr(edtCodEmp.Text)) then
    begin
      qryConfer.SQL.Add('  AND CON_EMPLAN = :EMPLAN ');
      qryConfer.ParamByName('EMPLAN').AsString := edtCodEmp.Text;
    end;

    qryConfer.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    qryConfer.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
  end;
  qryConfer.Open;
  TFloatField(qryConfer.FieldByName('CON_VALLAN')).DisplayFormat := '#,##0.00';
  qryConfer.First;
end;

function TfrmManLanCon.fLancouContasIguais: boolean;
begin
  Result := False;

  if (not qryTabela.FieldByName('CON_CONCRE').AsString.IsEmpty) and
     (not qryTabela.FieldByName('CON_CONDEB').AsString.IsEmpty) then
  begin
    Result := SameText(qryTabela.FieldByName('CON_CONCRE').AsString, qryTabela.FieldByName('CON_CONDEB').AsString);
  end;
end;

end.
