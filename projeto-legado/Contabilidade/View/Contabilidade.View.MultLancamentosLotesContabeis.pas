unit Contabilidade.View.MultLancamentosLotesContabeis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  MemoFocus, cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, EditFocus, Vcl.Mask,
  MaskEditFocus, cxMaskEdit, cxButtonEdit, ComboEditFocus, ComboBoxFocus,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxGroupBox,
  Datasnap.DBClient, UniClientDataSet, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  MemDS, DBAccess, Uni, cxCalc, System.Generics.Collections;

type
  TrecMultDadosLote = record
    con_condeb : string ;
    con_vallan : double ;
    con_histor : string ;
    con_ccusto : string ;
    con_hispad : string ;
    con_tiplan : string ;
    con_clifor : string ;
    con_tip_fc : string ;
  end;

  TfrmMultLancamentosLotesContabeis = class(TfrmPaiContabilidade)
    dtsDados: TDataSource;
    gbDadosLancamento: TGroupBox;
    Label12: TLabel;
    mskContaDebito: TMaskEditFocus;
    edtConDebRed: TEditFocus;
    edtDesContaDebito: TEditFocus;
    lbCCustoDebito: TLabel;
    edtCCustoDebito: TEditFocus;
    edtDesCCustoDebito: TEditFocus;
    lbValor: TLabel;
    edtValor: TCurrencyEditFocus;
    lbedtHisPad: TLabel;
    edtHisPad: TEditFocus;
    edtDesHistPadrao: TEditFocus;
    lbedtHistor: TLabel;
    edtHistor: TMemoFocus;
    Label2: TLabel;
    edtTipo: TComboBoxFocus;
    gbBotoes: TGroupBox;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    gbLancamentos: TGroupBox;
    GridCitel: TcxGridCitel;
    GridCitelTableView: TcxGridDBTableViewCitel;
    GridCitelTableViewAUTOINCREM: TcxGridDBColumn;
    GridCitelTableViewCON_CONDEB: TcxGridDBColumn;
    GridCitelTableViewDES_CONDEB: TcxGridDBColumn;
    GridCitelTableViewCON_CCUSTO: TcxGridDBColumn;
    GridCitelTableViewDES_CCUSTO: TcxGridDBColumn;
    GridCitelTableViewCON_VALLAN: TcxGridDBColumn;
    GridCitelTableViewCON_HISPAD: TcxGridDBColumn;
    GridCitelTableViewDES_HISPAD: TcxGridDBColumn;
    GridCitelTableViewCON_HISTOR: TcxGridDBColumn;
    GridCitelTableViewCON_TIPLAN: TcxGridDBColumn;
    GridCitelLevel1: TcxGridLevel;
    gbDiferenca: TcxGroupBox;
    Label3: TLabel;
    edtDebito: TCurrencyEditFocus;
    Label6: TLabel;
    edtCredito: TCurrencyEditFocus;
    Label7: TLabel;
    edtDiferenca: TCurrencyEditFocus;
    dtsBusca: TDataSource;
    dbgBuscaConta: TDBGridCitel;
    btnConfirmar: TBitBtnLocked;
    lbSubconta: TLabel;
    edtOpcSubconta: TEditFocus;
    edtCodCliForSubconta: TEditFocus;
    edtNomCliForSubconta: TEditFocus;
    GridCitelTableViewCON_CLIFOR: TcxGridDBColumn;
    GridCitelTableViewCON_TIP_FC: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mskContaDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCCustoDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure edtHisPadKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaDebitoClick(Sender: TObject);
    procedure mskContaDebitoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtConDebRedClick(Sender: TObject);
    procedure edtConDebRedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbgBuscaContaDblClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure GridCitelTableViewDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtOpcSubcontaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliForSubcontaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FblnFormInCreate: Boolean ;
    FdictDefaultTop: TDictionary<String,Integer> ;
    FdictDefaultHeight: TDictionary<String,Integer> ;
    FblnCreditoDebitoComSubconta: Boolean ;
    FblnConfirma: boolean ;
    FblnDadosAlterados: boolean ;
    FValorLancado: double ;
    FCodEmp: string ;
    FDtaLan: TDateTime ;
    cdsDados: TUniClientDataSet ;
    blnCfg_SENLCOExiste: boolean ;
    blnExisteCampoNCO_NATURE: boolean ;
    blnExisteCampoCON_CCUSCR: boolean ;
    blnExisteCampoCON_CCUSTO: boolean ;
    FValidarVigenciaCta: boolean ;
    FModoInclusao: boolean ;
    FModoEdicao: boolean ;
    cdsPlancoVigencia: TUniClientDataSet;
    qryBusca : TUniQuery;
    FHabilitaTipoLancamento: boolean ;
    function fCriaCdsDados: TUniClientDataSet;
    procedure pDesabilitarCampos;
    procedure pLiberaPlancoVigencia;
    procedure pHabilitaControles(const AHabilitar: boolean);
    procedure pDesativaCentroCusto(const AContaContabil: string);
    procedure pCarregaPlanoContabilDebito(const blnBuscaPorChave: Boolean;
      blnCampoContaReduzida: Boolean=False);
    function fCarregaCentroCusto(const ACodigo: string): string;
    function fCarregaHistoricoPadrao(const ACodigo: string): string;
    procedure pBuscarConta(dbeTexto: TCustomEdit; blnRed: Boolean;
      intTag: Integer);
    function fTemInformacaoGrid: boolean;
    procedure pLimparCampos;
    function fValidarCentroCusto: boolean;
    function fInformouHistorico: boolean;
    procedure pLancar(const ACdsDados: TUniClientDataSet;
      const ADados: TrecMultDadosLote; const AModoInclusao: boolean);
    function fCarregarGridParaCampos: boolean;
    procedure pTotalizaValores;
    procedure pConfiguraTipo;
    procedure pFocoInicial;
    procedure pReorganizaEntradaDadosSubContasInterno(const AblnContaCreditoDebito: Boolean) ;
    procedure pReorganizaEntradaDadosSubContas ;
    procedure pRestauraPosicionamentoSubContasDefault ;
    procedure pSalvaPosicionamentoSubContasDefault ;
    procedure pSetCreditoDebitoComSubconta(const AValue: Boolean) ;
    procedure pEhContaContabilComSubConta(const AstrConta, AstrEmpLan: String) ;
    function fValidaOpcaoSubConta(AedtCampo: TEditFocus): Boolean ;
    function fCarregaCliForSubConta(AedtCodigo, AedtDescricao: TEditFocus; const AstrOpcao: String): Boolean ;
    procedure pMostraColunasSubConta(const AblnMostrar: Boolean);
    procedure pFormBeginUpdate;
    procedure pFormEndUpdate ;
    property CreditoDebitoComSubconta: Boolean read FblnCreditoDebitoComSubconta write pSetCreditoDebitoComSubconta ;
  public
    { Public declarations }
    property ValorLancado: Double read FValorLancado write FValorLancado ;
    property CodEmp: string read FCodEmp write FCodEmp ;
    property DtaLan: TDateTime read FDtaLan write FDtaLan ;
    property blnConfirma: Boolean read FblnConfirma ;
    property HabilitaTipoLancamento: boolean read FHabilitaTipoLancamento write FHabilitaTipoLancamento ;
    procedure pCarregaDadosAlteracao(const ACdsDados: TUniClientDataSet) ;
    function fMovimentaLinha(const Key: Word; Sender: TObject): boolean ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Consultas, untTypesSistema,
     untConsultas, Contabilidade.Funcoes, Contabilidade.Interfaces ;

{$R *.dfm}

const
  cCREDITO = 'Crédito' ;
  cDEBITO = 'Débito' ;

procedure TfrmMultLancamentosLotesContabeis.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if (FblnDadosAlterados) and (not FblnConfirma) then
  begin
    if (fMensagem('', 'Cancelar alterações na partida multipla?', ['&Sim', '&Não'], 2) = 2) then
    begin
      CanClose := False ;
      exit ;
    end ;
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.FormCreate(Sender: TObject);
var
  strMascara : string ;
begin
  inherited;
  FblnFormInCreate := True ;
  FdictDefaultTop    := TDictionary<String,Integer>.Create ;
  FdictDefaultHeight := TDictionary<String,Integer>.Create ;
  pSalvaPosicionamentoSubContasDefault ;
  FblnDadosAlterados := False ;
  strMascara := fMskCon;
  mskContaDebito.EditMask := strMascara;
  pReorganizaEntradaDadosSubContasInterno(False) ;

  cdsDados := fCriaCdsDados ;
  dtsDados.DataSet := cdsDados ;

  qryBusca := fCriaQuery(Self);
  dtsBusca.DataSet := qryBusca;

  blnCfg_SENLCOExiste := fConfiguracaoExiste('SENLCO');

  blnExisteCampoNCO_NATURE := fCampoExiste('PLANCO', 'NCO_NATURE');

  blnExisteCampoCON_CCUSCR := fCampoExiste('LANCON', 'CON_CCUSCR');
  blnExisteCampoCON_CCUSTO := True ;

  if  (fCfgExpEcd = 'S') and (fCfgObrCcu = 'N') then
  begin
    blnExisteCampoCON_CCUSCR := False ;
    blnExisteCampoCON_CCUSTO := False ;
  end;

  FValidarVigenciaCta := fTemVigencia;

  pDesabilitarCampos ;

  cdsPlancoVigencia := fCarregaPlancoVigencia ;

  pHabilitaControles(False) ;

  FModoInclusao := False ;
  FModoEdicao := False ;

  FblnConfirma := False ;

  FHabilitaTipoLancamento := False ;
  FblnCreditoDebitoComSubconta := False ;
  pMostraColunasSubConta(fCfgDesmembrarSubContaCliFor = 'S') ;
  FblnFormInCreate := False ;
end;

procedure TfrmMultLancamentosLotesContabeis.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FdictDefaultTop) ;
  FreeAndNil(FdictDefaultHeight) ;
  pLiberaPlancoVigencia ;
  FreeAndNil(cdsDados) ;
  FreeAndNil(qryBusca) ;
end;

procedure TfrmMultLancamentosLotesContabeis.FormShow(Sender: TObject);
begin
  inherited;
  pTotalizaValores ;
  pConfiguraTipo ;
  pSetFocus(btnIncluir);
end;

function TfrmMultLancamentosLotesContabeis.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strTplaco: string ;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskContaDebito) Then
    Begin
      pCarregaPlanoContabilDebito(blnBuscaPorChave) ;
      pDesativaCentroCusto(mskContaDebito.Text) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) And (fEmptyStr(edtDesContaDebito.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta de Débito Inválida!',['&OK']);
        Result := False;
      end
      else if (blnExisteCampoNCO_NATURE) and (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) then
      begin
        strTplaco := fRetTplacoEmpresaLogada(FCodEmp) ;
        if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]) = 'S') then
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

    Else If (Sender = edtTipo) Then
    Begin
      if fEmptyStr(edtTipo.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Tipo de Lançamento deve ser preenchido!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = edtCCustoDebito) and (edtCCustoDebito.Enabled) Then
    Begin
      If Not fEmptyStr(edtCCustoDebito.Text) Then
      Begin
        edtDesCCustoDebito.Text := fCarregaCentroCusto(edtCCustoDebito.Text);
        If fEmptyStr(edtDesCCustoDebito.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesCCustoDebito.Clear;
      End;
    End

    else if (Sender = edtHisPad) then
    begin
      If Not fEmptyStr(edtHisPad.Text) Then
      Begin
        edtDesHistPadrao.Text := fCarregaHistoricoPadrao(edtHisPad.Text);
        If fEmptyStr(edtDesHistPadrao.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse histórico padrão não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesHistPadrao.Clear;
      End;

    end
    else if (Sender = edtOpcSubconta) and (edtOpcSubconta.Visible) then
    begin
      Result := fValidaOpcaoSubConta(edtOpcSubconta) ;
    end
    else if (Sender = edtCodCliForSubconta) and (edtCodCliForSubconta.Visible) then
    begin
      if not fValidaOpcaoSubConta(edtOpcSubconta) then
      begin
        pSetFocus(edtOpcSubconta);
        Result := False ;
        Exit ;
      end ;
      Result := fCarregaCliForSubConta(edtCodCliForSubconta, edtNomCliForSubconta, edtOpcSubconta.Text) ;
    end;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmMultLancamentosLotesContabeis.fValidaOpcaoSubConta(
  AedtCampo: TEditFocus): Boolean;
begin
  Result := False ;
  If fEmptyStr(AedtCampo.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Tipo Subconta deve ser preenchido!', ['&Ok']);
    exit ;
  End
  Else If (AedtCampo.Text <> 'C') And (AedtCampo.Text <> 'F') Then
  Begin
    fMensagem('ATENÇÃO!', 'O Tipo Subconta com valor inválido[C/F]!', ['&Ok']);
    Exit ;
  End;
  Result := True ;
end;

procedure TfrmMultLancamentosLotesContabeis.mskContaDebitoClick(
  Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmMultLancamentosLotesContabeis.mskContaDebitoKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrPlan: TConsultasArray;
  strTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    strTplaco := fRetTplacoEmpresaLogada(FCodEmp) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, mskContaDebito, edtDesContaDebito, Nil, Key, arrPlan, True, strTplaco, not blnExisteCampoNCO_NATURE) Then
      SelectNext(ActiveControl, True, True);

    edtDesContaDebito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]);
    edtConDebRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]);
    pEhContaContabilComSubConta(mskContaDebito.Text, FCodEmp) ;
    pDesativaCentroCusto(mskContaDebito.Text) ;
  End;
end;

procedure TfrmMultLancamentosLotesContabeis.mskContaDebitoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(mskContaDebito, False, 1);
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.edtCCustoDebitoKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrEvento : TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, edtCCustoDebito, edtDesCCustoDebito, Nil, Key, arrEvento, True, True) Then
  Begin
    If fValidaCampos(edtCCustoDebito, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMultLancamentosLotesContabeis.edtCodCliForSubcontaKeyPress(
  Sender: TObject; var Key: Char);
var
  arrRetornoConsultas : TConsultasArray;
begin
  inherited;

  if not fValidaOpcaoSubConta(edtOpcSubconta) then
  begin
    pSetFocus(edtOpcSubconta);
    Exit ;
  end ;

  if edtOpcSubconta.Text = 'C' then //clientes
  begin
    If fPesqClientesCont(Self, edtCodCliForSubconta, edtNomCliForSubconta, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubconta, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end
  else // fornecedores
  begin
    If fPesqFornecedoresCont(Self, edtCodCliForSubconta, edtNomCliForSubconta, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubconta, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end ;

end;

procedure TfrmMultLancamentosLotesContabeis.edtConDebRedClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmMultLancamentosLotesContabeis.edtConDebRedKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(edtConDebRed, True, 1);
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.edtHisPadKeyPress(Sender: TObject;
  var Key: Char);
var
  arrHisPad : TConsultasArray;
begin
  inherited;
  If fPesqHistoricoPadrao(Self, edtHisPad, edtDesHistPadrao, Nil, Key, arrHisPad, True, CodEmp) Then
  Begin
    If fValidaCampos(edtHisPad, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMultLancamentosLotesContabeis.edtOpcSubcontaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if not CharInSet(key, [#13, #9]) then
  begin
    edtCodCliForSubconta.Clear ;
    edtNomCliForSubconta.Clear ;
  end ;
end;

function TfrmMultLancamentosLotesContabeis.fCriaCdsDados: TUniClientDataSet;
var
  LField : TFieldDef ;
begin
  Result := TUniClientDataSet.Create(Self);

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'AUTOINCREM';
  LField.DataType := ftAutoInc;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_CONDEB';
  LField.DataType := ftString;
  LField.Size     := 20;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_VALLAN';
  LField.DataType := ftFloat;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_HISTOR';
  LField.DataType := ftString;
  LField.Size     := 200;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_CCUSTO';
  LField.DataType := ftString;
  LField.Size     := 5;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_CONDEB';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_CCUSTO';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_HISPAD';
  LField.DataType := ftInteger;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_HISPAD';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_TIPLAN';
  LField.DataType := ftString;
  LField.Size     := 10;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_CLIFOR';
  LField.DataType := ftString;
  LField.Size     := 8;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_TIP_FC';
  LField.DataType := ftString;
  LField.Size     := 1;
  LField.Required := False;

  Result.IndexFieldNames := 'AUTOINCREM';
  Result.CreateDataSet;

  TFloatField(Result.FieldByName('CON_VALLAN')).DisplayFormat := '##,#0.00';
  Result.FieldByName('CON_CONDEB').EditMask := fMskCon;
end;

procedure TfrmMultLancamentosLotesContabeis.pDesabilitarCampos;
begin
  if edtTipo.Text = cCREDITO then
  begin
    edtCCustoDebito.Enabled := blnExisteCampoCON_CCUSTO ;
  end
  else /// debito
  begin
    edtCCustoDebito.Enabled := blnExisteCampoCON_CCUSCR ;
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.pLiberaPlancoVigencia;
begin
  if not FValidarVigenciaCta then
  begin
    exit ;
  end;

  if assigned(cdsPlancoVigencia) then
    FreeAndNil(cdsPlancoVigencia);
end;

procedure TfrmMultLancamentosLotesContabeis.pHabilitaControles(
  const AHabilitar: boolean);
begin
  /// campos
  mskContaDebito.Enabled := AHabilitar ;
  edtConDebRed.Enabled := AHabilitar ;
  edtCCustoDebito.Enabled := AHabilitar ;
  edtValor.Enabled := AHabilitar ;
  edtHisPad.Enabled := AHabilitar ;
  edtHistor.Enabled := AHabilitar ;
  edtTipo.Enabled := AHabilitar ;

  /// botões
  btnIncluir.Enabled := not AHabilitar ;
  btnGravar.Enabled := AHabilitar ;
  btnCancela.Enabled := AHabilitar ;
  btnAlterar.Enabled := not AHabilitar ;
  btnExcluir.Enabled := not AHabilitar ;

  GridCitel.Enabled := not AHabilitar ;

  if not HabilitaTipoLancamento then
  begin
    edtTipo.Enabled := False ;
  end;
  if AHabilitar then
  begin
    pDesabilitarCampos ;
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.pDesativaCentroCusto(
  const AContaContabil: string);
var
  LPatrim: string ;
  strTplaco: string ;
begin
  if fCfgExpEcd = 'N' then
  begin
    Exit ;
  end;

  if fCfgObrCcu = 'N' then
  begin
    exit ;
  end;

  strTplaco := fRetTplacoEmpresaLogada(FCodEmp) ;
  LPatrim := fCampoTabela('NCO_PATRIM', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(AContaContabil), strTplaco]) ;
  if LPatrim = 'S' then
  begin
    edtCCustoDebito.Enabled := False ;
    edtCCustoDebito.Clear ;
    edtDesCCustoDebito.Clear ;
  end;

  if LPatrim = 'N' then
  begin
    edtCCustoDebito.Enabled := True ;
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.pEhContaContabilComSubConta(
  const AstrConta, AstrEmpLan: String);
var
  LstrConta: String ;
  LstrTplaco: String ;
  LstrSubConta: String ;
begin
  if fCfgDesmembrarSubContaCliFor = 'N' then
    Exit ;

  LstrTplaco := fRetTplacoEmpresaLogada(AstrEmpLan) ;
  LstrConta := fSemMascaraPlaNco(AstrConta) ;

  LstrSubConta := fCampoTabela('NCO_SUBCNT', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [LstrConta, LstrTplaco], False) ;

  CreditoDebitoComSubconta := LstrSubConta = 'S' ;
end;

procedure TfrmMultLancamentosLotesContabeis.pFocoInicial;
begin
  if FHabilitaTipoLancamento then
  begin
    pSetFocus(edtTipo);
  end
  else
  begin
    pSetFocus(mskContaDebito);
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.pFormBeginUpdate;
begin
  if FblnFormInCreate then
    Exit ;

  SendMessage(Self.Handle, WM_SETREDRAW, Ord(False), 0);
end;

procedure TfrmMultLancamentosLotesContabeis.pFormEndUpdate;
begin
  if FblnFormInCreate then
    Exit ;

  SendMessage(Self.Handle, WM_SETREDRAW, Ord(True), 0);
  RedrawWindow(Self.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

procedure TfrmMultLancamentosLotesContabeis.pCarregaDadosAlteracao(
  const ACdsDados: TUniClientDataSet);
begin
  ACdsDados.First ;
  while not ACdsDados.Eof do
  begin
    cdsDados.Append ;
    cdsDados.FieldByName('CON_VALLAN').AsFloat := ACdsDados.FieldByName('CON_VALLAN').AsFloat ;
    cdsDados.FieldByName('CON_HISTOR').AsString := ACdsDados.FieldByName('CON_HISTOR').AsString ;
    cdsDados.FieldByName('CON_HISPAD').AsString := ACdsDados.FieldByName('CON_HISPAD').AsString ;
    cdsDados.FieldByName('DES_HISPAD').AsString := ACdsDados.FieldByName('DES_HISPAD').AsString ;
    if not fEmptyStr(fSemMascaraPlaNco(ACdsDados.FieldByName('CON_CONDEB').AsString)) then
    begin
      cdsDados.FieldByName('CON_TIPLAN').AsString := cDEBITO ;
      cdsDados.FieldByName('CON_CONDEB').AsString := ACdsDados.FieldByName('CON_CONDEB').AsString ;
      cdsDados.FieldByName('CON_CCUSTO').AsString := ACdsDados.FieldByName('CON_CCUSTO').AsString ;
      cdsDados.FieldByName('DES_CONDEB').AsString := ACdsDados.FieldByName('DES_CONDEB').AsString ;
      cdsDados.FieldByName('DES_CCUSTO').AsString := ACdsDados.FieldByName('DES_CCUSTO').AsString ;
    end
    else
    begin
      cdsDados.FieldByName('CON_TIPLAN').AsString := cCREDITO ;
      cdsDados.FieldByName('CON_CONDEB').AsString := ACdsDados.FieldByName('CON_CONCRE').AsString ;
      cdsDados.FieldByName('CON_CCUSTO').AsString := ACdsDados.FieldByName('CON_CCUSCR').AsString ;
      cdsDados.FieldByName('DES_CONDEB').AsString := ACdsDados.FieldByName('DES_CONCRE').AsString ;
      cdsDados.FieldByName('DES_CCUSTO').AsString := ACdsDados.FieldByName('DES_CCUSCR').AsString ;
    end;
    cdsDados.FieldByName('CON_CLIFOR').AsString := ACdsDados.FieldByName('CON_CLIFOR').AsString ;
    cdsDados.FieldByName('CON_TIP_FC').AsString := ACdsDados.FieldByName('CON_TIP_FC').AsString ;
    cdsDados.Post ;
    ACdsDados.Next ;
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.pCarregaPlanoContabilDebito(
  const blnBuscaPorChave: Boolean; blnCampoContaReduzida: Boolean);
var
  strTplaco : string ;
begin
  if blnBuscaPorChave then
  begin
    edtDesContaDebito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)]);
    if not blnCampoContaReduzida then
    begin
      edtConDebRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)]);
    end;
  end
  else
  begin
    strTplaco := fRetTplacoEmpresaLogada(FCodEmp) ;
    edtDesContaDebito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]);
    if not blnCampoContaReduzida then
    begin
      edtConDebRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]);
    end;
  end;
  pEhContaContabilComSubConta(mskContaDebito.Text, FCodEmp) ;
end;

procedure TfrmMultLancamentosLotesContabeis.pConfiguraTipo;
begin
  if ValorLancado < 0 then
  begin
    edtTipo.ItemIndex := edtTipo.Items.IndexOf(cCREDITO) ;
  end
  else
  begin
    edtTipo.ItemIndex := edtTipo.Items.IndexOf(cDEBITO) ;
  end;
end;

function TfrmMultLancamentosLotesContabeis.fCarregaCentroCusto(
  const ACodigo: string): string;
begin
  result := fRetNomEvento(ACodigo) ;
end;

function TfrmMultLancamentosLotesContabeis.fCarregaCliForSubConta(AedtCodigo,
  AedtDescricao: TEditFocus; const AstrOpcao: String): Boolean;
var
  LstrDescrMensagem: String ;
begin
  Result := True ;
  If Not fEmptyStr(AedtCodigo.Text) Then
  Begin
    AedtDescricao.Text := fCarregaCliForBD(AedtCodigo.Text, AstrOpcao) ;
    if AstrOpcao = 'C' then // cliente
      LstrDescrMensagem := 'Esse cliente não está cadastrado!'
    else // fornecedor
      LstrDescrMensagem := 'Esse fornecedor não está cadastrado!' ;

    If fEmptyStr(AedtDescricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', LstrDescrMensagem, ['&OK']);
      Result := False;
    End;
  End
  Else
  Begin
    AedtDescricao.Clear;
  End;
end;

function TfrmMultLancamentosLotesContabeis.fCarregaHistoricoPadrao(
  const ACodigo: string): string;
begin
  result := fRetDescHistoricoPadrao(ACodigo, CodEmp);
end;

procedure TfrmMultLancamentosLotesContabeis.btnAlterarClick(Sender: TObject);
begin
  if not fTemInformacaoGrid then
  begin
    exit ;
  end;

  FModoEdicao := True ;

  pHabilitaControles(True) ;

  fCarregarGridParaCampos ;

  pFocoInicial ;
end;

procedure TfrmMultLancamentosLotesContabeis.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pLimparCampos ;

  pHabilitaControles(False) ;

  FModoInclusao := False ;
  FModoEdicao := False ;

  pSetFocus(btnIncluir);
end;

procedure TfrmMultLancamentosLotesContabeis.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if FblnDadosAlterados then
  begin
    if fFormataFloat(edtDiferenca.Value, 2) <> 0.00 then
    begin
      fMensagem('ATENÇÃO!', 'Há diferença de '+FormatCurr('#,##0.00', edtDiferenca.Value)+' nas contas lançadas', ['&OK']);
      exit ;
    end;

    if (fMensagem('', 'Confirma as alterações na partida multipla?', ['&Sim', '&Não'], 2) = 2) then
    begin
      exit ;
    end ;

    FblnConfirma := True ;
  end;
  Close ;
end;

procedure TfrmMultLancamentosLotesContabeis.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if not fTemInformacaoGrid then
  begin
    exit ;
  end;

  if (fMensagem('', 'Deseja excluir o lançamento?', ['&Sim', '&Não'], 2) = 1) then
  begin
    cdsDados.Delete ;

    pTotalizaValores ;
    FblnDadosAlterados := True ;
    fMensagem('ATENÇÃO!', 'Lançamento excluido com sucesso!', ['&OK']);
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.btnGravarClick(Sender: TObject);
var
  strMensagemValidacao : String ;
  recDados : TrecMultDadosLote ;
begin
  inherited;

  if not fVerificaCampos then
    exit;

  if fLancamentoAnteriorFechamento(FDtaLan, FCodEmp, strMensagemValidacao) then
  begin
    fMensagem('', strMensagemValidacao, ['&OK']);
    Exit;
  end;

  if edtValor.Value <= 0.00 then
  begin
    fMensagem('', 'Valor deve ser maior que zero!', ['&OK']);
    pSetFocus(edtValor) ;
    Exit;
  end;

  if not fValidarCentroCusto then
  begin
    exit ;
  end;

  if not fInformouHistorico then
  begin
    exit ;
  end;

  if not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                 FDtaLan,
                                 fSemMascaraPlaNco(mskContaDebito.Text),
                                 strMensagemValidacao,
                                 FCodEmp) then
  begin
    fMensagem('', strMensagemValidacao, ['&OK']);
    Exit;
  end ;

  recDados.con_condeb := fSemMascaraPlaNco(mskContaDebito.Text) ;
  recDados.con_vallan := edtValor.Value ;
  recDados.con_histor := edtHistor.Text ;
  recDados.con_ccusto := edtCCustoDebito.Text ;
  recDados.con_hispad := edtHisPad.Text ;
  recDados.con_tiplan := edtTipo.Text ;
  recDados.con_clifor := edtCodCliForSubconta.Text ;
  recDados.con_tip_fc := edtOpcSubconta.Text ;

  pLancar(cdsDados, recDados, FModoInclusao);

  pTotalizaValores ;

  FModoInclusao := False ;
  FModoEdicao := False ;
  FblnDadosAlterados := True ;

  pLimparCampos ;

  pHabilitaControles(False) ;

  pSetFocus(btnIncluir);
end;

procedure TfrmMultLancamentosLotesContabeis.btnIncluirClick(Sender: TObject);
begin
  inherited;
  FModoInclusao := True ;

  pHabilitaControles(True) ;

  pFocoInicial;
end;

procedure TfrmMultLancamentosLotesContabeis.dbgBuscaContaDblClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
  If (dbgBuscaConta.Tag = 1) or (dbgBuscaConta.Tag = 11) Then
  Begin
    mskContaDebito.Text := qryBusca.FieldByName('CODCON').AsString;
    pDesativaCentroCusto(mskContaDebito.Text) ;
    edtConDebRed.Text := qryBusca.FieldByName('CONRED').AsString;
    edtDesContaDebito.Text := qryBusca.FieldByName('DESCON').AsString;
    pEhContaContabilComSubConta(mskContaDebito.Text, FCodEmp) ;
    if dbgBuscaConta.Tag = 1 then
      pSetFocus(mskContaDebito)
    else
      pSetFocus(edtConDebRed) ;
  End;

end;

procedure TfrmMultLancamentosLotesContabeis.pBuscarConta(dbeTexto: TCustomEdit; blnRed: Boolean; intTag: Integer);
var
  strTplaco: string ;
begin
  If (fEmptyStr(fSemMascaraPlaNco(dbeTexto.Text), True)) Then
  Begin
    dbgBuscaConta.Visible := False;
    Exit;
  End;

  strTplaco := fRetTplacoEmpresaLogada(FCodEmp) ;

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
        qryBusca.Locate('NCO_CODCON', mskContaDebito.Text, []);
    end;

    dbgBuscaConta.Left := dbeTexto.Left;
    dbgBuscaConta.Top := dbeTexto.Top + dbeTexto.Height + 1;
    dbgBuscaConta.Visible := True;
    dbgBuscaConta.Tag := intTag;
    if blnRed then
    begin
      dbgBuscaConta.Tag := dbgBuscaConta.Tag + 10 ;
    end;
  End
  Else
    dbgBuscaConta.Visible := False;
end;

function TfrmMultLancamentosLotesContabeis.fTemInformacaoGrid: boolean;
begin
  result := false ;
  if not cdsDados.Active then
  begin
    exit ;
  end;

  if cdsDados.IsEmpty then
  begin
    exit ;
  end;
  result := true ;
end;

procedure TfrmMultLancamentosLotesContabeis.pLimparCampos;
begin
  mskContaDebito.Clear ;
  edtConDebRed.Clear ;
  edtDesContaDebito.Clear ;
  edtValor.Clear ;
  edtHistor.Clear ;
  edtCCustoDebito.Clear ;
  edtDesCCustoDebito.Clear ;
  edtHisPad.Clear ;
  edtDesHistPadrao.Clear ;
  edtCodCliForSubconta.Clear ;
  edtOpcSubconta.Clear ;
  edtNomCliForSubconta.Clear ;
  CreditoDebitoComSubconta := False ;
end;

procedure TfrmMultLancamentosLotesContabeis.pMostraColunasSubConta(
  const AblnMostrar: Boolean);
begin
  GridCitelTableViewCON_TIP_FC.Visible := AblnMostrar ;
  GridCitelTableViewCON_CLIFOR.Visible := AblnMostrar ;

  GridCitelTableViewCON_TIP_FC.VisibleForCustomization := AblnMostrar ;
  GridCitelTableViewCON_CLIFOR.VisibleForCustomization := AblnMostrar ;
end;

procedure TfrmMultLancamentosLotesContabeis.pReorganizaEntradaDadosSubContas;
begin
  if fCfgDesmembrarSubContaCliFor = 'N' then
    Exit ;

  pReorganizaEntradaDadosSubContasInterno(FblnCreditoDebitoComSubconta) ;
end;

procedure TfrmMultLancamentosLotesContabeis.pReorganizaEntradaDadosSubContasInterno(
  const AblnContaCreditoDebito: Boolean);
const
  INT_ESPACAMENTO = 25 ;
begin
  pFormBeginUpdate ;
  try
    lbSubconta.Visible := AblnContaCreditoDebito ;
    edtCodCliForSubconta.Visible := AblnContaCreditoDebito ;
    edtNomCliForSubconta.Visible := AblnContaCreditoDebito ;
    edtOpcSubconta.Visible := AblnContaCreditoDebito ;

    pRestauraPosicionamentoSubContasDefault ;

    if not AblnContaCreditoDebito then
    begin
      lbCCustoDebito.Top := lbCCustoDebito.Top - INT_ESPACAMENTO ;
      edtCCustoDebito.Top := edtCCustoDebito.Top - INT_ESPACAMENTO ;
      edtDesCCustoDebito.Top := edtDesCCustoDebito.Top - INT_ESPACAMENTO ;
      lbValor.Top := lbValor.Top - INT_ESPACAMENTO ;
      edtValor.Top := edtValor.Top - INT_ESPACAMENTO ;
      lbedtHisPad.Top := lbedtHisPad.Top - INT_ESPACAMENTO ;
      edtHisPad.Top := edtHisPad.Top - INT_ESPACAMENTO ;
      edtDesHistPadrao.Top := edtDesHistPadrao.Top - INT_ESPACAMENTO ;
      lbedtHistor.Top := lbedtHistor.Top - INT_ESPACAMENTO ;
      edtHistor.Top := edtHistor.Top - INT_ESPACAMENTO ;

      gbDadosLancamento.Height :=  gbDadosLancamento.Height - INT_ESPACAMENTO ;
      self.Height :=  self.Height - INT_ESPACAMENTO ;

    end ;
  finally
    pFormEndUpdate ;
  end ;
end;

procedure TfrmMultLancamentosLotesContabeis.pRestauraPosicionamentoSubContasDefault;
var
  AprInfoTop: TPair<String,Integer> ;
  Lcmp: TComponent ;
begin
  for AprInfoTop in FdictDefaultTop do
  begin
    Lcmp := self.FindComponent(AprInfoTop.Key) ;
    if Assigned(Lcmp) then
    begin
      TWinControl(Lcmp).Top := AprInfoTop.Value ;
    end ;
  end ;

  Self.Height := FdictDefaultHeight.Items[Self.Name] ;
  gbDadosLancamento.Height := FdictDefaultHeight.Items[gbDadosLancamento.Name] ;

end;

procedure TfrmMultLancamentosLotesContabeis.pSalvaPosicionamentoSubContasDefault;
var
  LintCnt: Integer ;
  LcmpParent: TComponent ;
begin
  FdictDefaultTop.Clear ;
  for LintCnt := 0 to self.ComponentCount-1 do
  begin
    LcmpParent := self.Components[LintCnt].GetParentComponent ;
    if Assigned(LcmpParent) then
    begin
      if LcmpParent.Name = gbDadosLancamento.Name then
      begin
        FdictDefaultTop.Add(self.Components[LintCnt].Name, TWinControl(self.Components[LintCnt]).Top);
      end ;
    end ;
  end ;
  ///Height do Tgroup e TForm
  FdictDefaultHeight.Add(gbDadosLancamento.Name, gbDadosLancamento.Height);
  FdictDefaultHeight.Add(Self.Name, Self.Height);
end;

procedure TfrmMultLancamentosLotesContabeis.pSetCreditoDebitoComSubconta(
  const AValue: Boolean);
begin
  if FblnCreditoDebitoComSubconta <> AValue then
  begin
    FblnCreditoDebitoComSubconta := AValue ;
    pReorganizaEntradaDadosSubContas;
  end ;
end;

function TfrmMultLancamentosLotesContabeis.fValidarCentroCusto: boolean;
begin
  result := True ;
  if fCfgObrCcu = 'N' then
  begin
    exit ;
  end;

  if edtCCustoDebito.Enabled then
  begin
    if fEmptyStr(edtCCustoDebito.Text) then
    begin
      if fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text)) then
      begin
        Exit ;
      end;

      fMensagem('ATENÇÃO!', '"Centro Custo" deve ser informado!', ['&OK']);
      pSetFocus(edtCCustoDebito);
      exit(False) ;
    end;
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.GridCitelTableViewDblClick(
  Sender: TObject);
begin
  inherited;
  btnAlterar.Click ;
end;

function TfrmMultLancamentosLotesContabeis.fInformouHistorico: boolean;
begin
  result := False ;
  if (fEmptyStr(trim(edtHisPad.Text))) and (fEmptyStr(trim(edtHistor.Text))) then
  begin
    fMensagem('ATENÇÃO!', 'Pelo menos um dos campos devem ser informados "Histórico Padrão" e/ou "Complemento"!', ['&OK']);
    pSetFocus(edtHisPad);
    exit ;
  end;
  result := True ;
end;

function TfrmMultLancamentosLotesContabeis.fMovimentaLinha(const Key: Word;
  Sender: TObject): boolean;
begin
  Result := False ;
  if not dbgBuscaConta.Visible then
  begin
    exit ;
  end;
  if key = VK_DOWN then
  begin
    if not qryBusca.Active then
    begin
      exit ;
    end ;
    qryBusca.Next ;
    Result := True ;
  end
  else if key = VK_UP then
  begin
    if not qryBusca.Active then
    begin
      exit ;
    end ;
    qryBusca.Prior ;
    Result := True ;
  end ;
  if Result then
  begin
    if Sender is TMaskEditFocus then
    begin
      TMaskEditFocus(Sender).Text := qryBusca.FieldByName('CODCON').AsString;
    end
    else if Sender is TEditFocus then
    begin
      TMaskEditFocus(Sender).Text := qryBusca.FieldByName('CONRED').AsString;
    end;
  end;
end;

procedure TfrmMultLancamentosLotesContabeis.pLancar(const ACdsDados: TUniClientDataSet; const ADados: TrecMultDadosLote; const AModoInclusao: boolean);
var
  strTplaco: string ;
begin
  if AModoInclusao then
  begin
    ACdsDados.Insert;
  end
  else
  begin
    ACdsDados.Edit;
  end;
  ACdsDados.FieldByName('CON_TIPLAN').AsString := ADados.con_tiplan;
  ACdsDados.FieldByName('CON_CONDEB').AsString := ADados.con_condeb;
  ACdsDados.FieldByName('CON_VALLAN').AsFloat  := ADados.con_vallan;
  ACdsDados.FieldByName('CON_HISTOR').AsString := ADados.con_histor;
  ACdsDados.FieldByName('CON_CCUSTO').AsString := ADados.con_ccusto;
  ACdsDados.FieldByName('CON_CLIFOR').AsString := ADados.con_clifor;
  ACdsDados.FieldByName('CON_TIP_FC').AsString := ADados.con_tip_fc;
  strTplaco := fRetTplacoEmpresaLogada(FCodEmp) ;
  ACdsDados.FieldByName('DES_CONDEB').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [ADados.con_condeb, strTplaco], False);
  ACdsDados.FieldByName('DES_CCUSTO').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [ADados.con_ccusto], False);
  ACdsDados.FieldByName('CON_HISPAD').AsString := ADados.con_hispad;
  ACdsDados.FieldByName('DES_HISPAD').AsString := fRetDescHistoricoPadrao(ADados.con_hispad, FCodEmp);
  ACdsDados.Post;
end;

function TfrmMultLancamentosLotesContabeis.fCarregarGridParaCampos:boolean;
begin
  result := false ;
  if not fTemInformacaoGrid then
  begin
    exit ;
  end;

  mskContaDebito.Text := cdsDados.FieldByName('CON_CONDEB').AsString;
  edtValor.Value := cdsDados.FieldByName('CON_VALLAN').AsFloat ;
  edtHistor.Text := cdsDados.FieldByName('CON_HISTOR').AsString ;
  edtCCustoDebito.Text := cdsDados.FieldByName('CON_CCUSTO').AsString ;
  edtDesContaDebito.Text := cdsDados.FieldByName('DES_CONDEB').AsString ;
  edtDesCCustoDebito.Text := cdsDados.FieldByName('DES_CCUSTO').AsString ;
  edtHisPad.Text := cdsDados.FieldByName('CON_HISPAD').AsString;
  edtDesHistPadrao.Text := cdsDados.FieldByName('DES_HISPAD').AsString ;
  edtTipo.ItemIndex := edtTipo.Items.IndexOf(CdsDados.FieldByName('CON_TIPLAN').AsString) ;
  edtOpcSubconta.Text := cdsDados.FieldByName('CON_TIP_FC').AsString ;
  edtCodCliForSubconta.Text := cdsDados.FieldByName('CON_CLIFOR').AsString ;
  edtNomCliForSubconta.Text := fCarregaCliForBD(edtCodCliForSubconta.Text, edtOpcSubconta.Text) ; ;
  pEhContaContabilComSubConta(mskContaDebito.Text, FCodEmp) ;
  result := true ;
end;

procedure TfrmMultLancamentosLotesContabeis.pTotalizaValores;
var
  LSomaCreditos, LSomaDebitos : double;
  cdsAux: TUniClientDataSet ;
begin
  LSomaCreditos := 0;
  LSomaDebitos := 0;

  cdsAux := TUniClientDataSet.Create(Nil) ;
  try
    cdsAux.Data := cdsDados.Data;
    cdsAux.DisableControls ;
    try
      cdsAux.First;
      while not cdsAux.Eof do
      begin
        if (cdsAux.FieldByName('CON_TIPLAN').AsString = cCREDITO) then
          LSomaCreditos := LSomaCreditos + fFormataFloat(cdsAux.FieldByName('CON_VALLAN').AsFloat, 2)
        else
          LSomaDebitos := LSomaDebitos + fFormataFloat(cdsAux.FieldByName('CON_VALLAN').AsFloat, 2);

        cdsAux.Next;
      end;
    finally
      cdsAux.EnableControls ;
    end;
  finally
    FreeAndNil(cdsAux) ;
  end;

  edtCredito.Value := 0.00 ;
  edtDebito.Value := 0.00 ;
  if ValorLancado < 0 then
  begin
    edtDebito.Value := abs(ValorLancado) ;
  end
  else if ValorLancado > 0 then
  begin
    edtCredito.Value := abs(ValorLancado) ;
  end
  else
  begin
    edtCredito.Value := 0 ;
    edtDebito.Value :=  0 ;
  end;

  edtCredito.Value := edtCredito.Value + LSomaCreditos ;
  edtDebito.Value := edtDebito.Value + LSomaDebitos ;

  edtDiferenca.Value := edtCredito.Value - edtDebito.Value ;

end;


end.
