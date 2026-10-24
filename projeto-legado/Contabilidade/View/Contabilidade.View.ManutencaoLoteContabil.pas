unit Contabilidade.View.ManutencaoLoteContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, ComboBoxFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, EditFocus, Contabilidade.View.TfrmPaiContabilidade, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataSet,
  cxMaskEdit, cxButtonEdit, FilenameEditFocus, cxProgressBar, Vcl.ComCtrls,
  MemoFocus, dxCore, cxDateUtils, cxDropDownEdit, cxCalendar;

type
  TfrmManutencaoLoteContabil = class(TfrmPaiContabilidade)
    pnlFundo: TPanel;
    btnGravarLote: TBitBtnLocked;
    cxgDadosTableView: TcxGridDBTableViewCitel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDados: TcxGridCitel;
    dtsDados: TDataSource;
    cxgDadosTableViewCON_DTALAN: TcxGridDBColumn;
    cxgDadosTableViewCON_EMPLAN: TcxGridDBColumn;
    cxgDadosTableViewCON_CONDEB: TcxGridDBColumn;
    cxgDadosTableViewCON_CONCRE: TcxGridDBColumn;
    cxgDadosTableViewCON_VALLAN: TcxGridDBColumn;
    cxgDadosTableViewCON_HISTOR: TcxGridDBColumn;
    cxgDadosTableViewCON_CCUSTO: TcxGridDBColumn;
    cxgDadosTableViewCON_CCUSCR: TcxGridDBColumn;
    gpbDadosLote: TGroupBox;
    Label3: TLabel;
    Label7: TLabel;
    gpbDadosLancto: TGroupBox;
    gpbTotais: TGroupBox;
    lblDebitos: TLabel;
    lblCreditos: TLabel;
    lblDiferenca: TLabel;
    lblLancamentos: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    mskContaCredito: TMaskEditFocus;
    mskContaDebito: TMaskEditFocus;
    edtDesContaDebito: TEditFocus;
    edtDesContaCRedito: TEditFocus;
    Label14: TLabel;
    Label15: TLabel;
    edtEmpLan: TEditFocus;
    edtNomEmp: TEditFocus;
    edtDesCCustoDebito: TEditFocus;
    edtDesCCustoCredito: TEditFocus;
    edtHistorico: TMemoFocus;
    Label16: TLabel;
    Label17: TLabel;
    edtValor: TCurrencyEditFocus;
    btnAdicionar: TBitBtnLocked;
    edtNumLot: TEditFocus;
    edtValPrev: TCurrencyEditFocus;
    mskDtaLan: TcxDateEdit;
    Label1: TLabel;
    edtCCustoDebito: TEditFocus;
    edtCCustoCredito: TEditFocus;
    Label2: TLabel;
    cxgDadosTableViewDES_CONDEB: TcxGridDBColumn;
    cxgDadosTableViewDES_CONCRE: TcxGridDBColumn;
    cxgDadosTableViewDES_CCUSTO: TcxGridDBColumn;
    cxgDadosTableViewDES_CCUSCR: TcxGridDBColumn;
    pnlGrid: TPanel;
    pnlTotais: TPanel;
    pnlTopo: TPanel;
    btnPesquisa: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancelarEfetivacao: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarLoteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure edtEmpLanKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaDebitoExit(Sender: TObject);
    procedure mskContaDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaCreditoExit(Sender: TObject);
    procedure mskContaCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure cxgDadosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCCustoDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCCustoCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCCustoDebitoExit(Sender: TObject);
    procedure edtCCustoCreditoExit(Sender: TObject);
    procedure cxgDadosTableViewEditKeyDown(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarEfetivacaoClick(Sender: TObject);
    procedure pAfterPost(DataSet: TDataSet);
    procedure pAfterDelete(DataSet: TDataSet);
    procedure pStatusBotoes(DataSet: TDataSet);
    procedure btnCancelarClick(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean = True): Boolean; Override;
  private
    { Private declarations }
    cdsPlancoVigencia: TUniClientDataSet;
    FValidarVigenciaCta : boolean;
    FAutoincrem : integer;
    FLoteGravacao : string;
    cdsDados : TUniClientDataSet;
    cdsDebitos : TUniClientDataSet;
    cdsCreditos : TUniClientDataSet;
    FStrPatrimCre : string;
    FStrPatrimDeb : string;
    function fCriaCdsDados(blnCriaSoma: boolean = false): TUniClientDataSet;
    procedure pLimparDadosLancamento;
    procedure pLancar(ACdsDados: TUniClientDataSet; intAutoincrem: integer; dtaDtaLan: TDateTime; strEmpLan, strContaDebito, strContaCredito, strHistorico, strCentroDeCustoDebito, strCentroDeCustoCredito: string; fltValor: double);
    procedure pSomatorioDados(var fltDebitos, fltCreditos: double);
    procedure pAtualizaInformativos;
    function fGravarDadosDoLote(pgbProgresso: TcxProgressBar): Boolean;
    procedure pGravaLotCon(strNumLot: string; fltValPrev: double);
    procedure pDeletaLotCon(strNumLot: string);
    procedure pGravaLotLan(strNumLot: string; pgbProgresso: TcxProgressBar);
    function fGravarDadosLanCon(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCarregaDadosLote(strNumLot: string);
    procedure pResetarTela;
    function fLoteFechado(strNumLot: string): boolean;
    function fValidaConta(strConta: string): boolean;
    function fCancelarEfetivacao(strNumLot: string): boolean;
    function fPodeCancelarPeriodo(strNumLot: string): boolean;
    function fPermiteEfetivar: boolean;
    procedure pLiberaPlancoVigencia;
  public
    { Public declarations }
  end;


implementation

uses
  Uni, StrUtils, untTypesSistema, untFuncoesSimples, Contabilidade.Funcoes,
  untConsultas, DateUtils, Contabilidade.Consultas;

{$R *.dfm}

{ TfrmManutencaoLoteContabil }

procedure TfrmManutencaoLoteContabil.btnAdicionarClick(Sender: TObject);
var
  strMensagemValidacao : String ;
begin
  if fLoteFechado(edtNumLot.Text) then
    exit;

  if not fVerificaCampos then
    exit;

  if (fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text + mskContaCredito.Text))) then
  begin
    fMensagem('ATENÇÃO!', 'Ao menos uma conta (débito e/ou crédito) deve ser preenchida!', ['&OK']);
    pSetFocus(mskContaDebito);
    Exit;
  end;

  if not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                 mskDtaLan.Date,
                                 fSemMascaraPlaNco(mskContaCredito.Text),
                                 strMensagemValidacao,
                                 edtEmpLan.Text) then
  begin
    fMensagem('', strMensagemValidacao, ['&OK']);
    Exit;
  end ;

  if not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                 mskDtaLan.Date,
                                 fSemMascaraPlaNco(mskContaDebito.Text),
                                 strMensagemValidacao,
                                 edtEmpLan.Text) then
  begin
    fMensagem('', strMensagemValidacao, ['&OK']);
    Exit;
  end ;

  Inc(FAutoincrem);

  pLancar(cdsDados, FAutoincrem, mskDtaLan.Date, edtEmpLan.Text, fSemMascaraPlaNco(mskContaDebito.Text), fSemMascaraPlaNco(mskContaCredito.Text), edtHistorico.Texto, edtCCustoDebito.Text, edtCCustoCredito.Text, edtValor.Value);

  if (not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) then
    pLancar(cdsDebitos, FAutoincrem, mskDtaLan.Date, edtEmpLan.Text, fSemMascaraPlaNco(mskContaDebito.Text), fSemMascaraPlaNco(mskContaCredito.Text), edtHistorico.Texto, edtCCustoDebito.Text, edtCCustoCredito.Text, edtValor.Value);

  if (not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) then
    pLancar(cdsCreditos, FAutoincrem, mskDtaLan.Date, edtEmpLan.Text, fSemMascaraPlaNco(mskContaDebito.Text), fSemMascaraPlaNco(mskContaCredito.Text), edtHistorico.Texto, edtCCustoDebito.Text, edtCCustoCredito.Text, edtValor.Value);

  pLimparDadosLancamento;
  pAtualizaInformativos;
  pSetFocus(mskDtaLan);
end;

procedure TfrmManutencaoLoteContabil.btnCancelarClick(Sender: TObject);
begin
  pCarregaDadosLote('');
  edtNumLot.Clear;
end;

procedure TfrmManutencaoLoteContabil.btnCancelarEfetivacaoClick(
  Sender: TObject);
begin
  if fEmptyStr(edtNumLot.Text) then
  begin
    fMensagem('', 'É necessário carregar um lote!', ['&OK']);
    Exit;
  end;

  if not fPodeCancelarPeriodo(edtNumLot.Text) then
    exit;

  if (fMensagem('', 'Deseja cancelar a efetivação do lote "' + edtNumLot.Text + '"?', ['&Sim', '&Não'], 2) = 1) then
  begin
    if fCancelarEfetivacao(edtNumLot.Text) then
    begin
      pCarregaDadosLote(edtNumLot.Text);
      fMensagem('ATENÇÃO!', 'Cancelamento da efetivação concluído com sucesso!', ['&OK']);
    end;
  end;
end;

procedure TfrmManutencaoLoteContabil.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if (fMensagem('', 'Deseja excluir o lote "' + edtNumLot.Text + '"?', ['&Sim', '&Não'], 2) = 1) then
  begin
    pDeletaLotCon(edtNumLot.Text);
    pCarregaDadosLote('');
    edtNumLot.Clear;
    fMensagem('ATENÇÃO!', 'Lote excluido com sucesso!', ['&OK']);
  end;
end;

procedure TfrmManutencaoLoteContabil.btnGravarLoteClick(Sender: TObject);
begin
  if not fValidaCampos(edtNumLot, True) then
    exit;

  if fLoteFechado(edtNumLot.Text) then
    exit;

  if not fValidaCampos(edtValPrev, True) then
    exit;

  if cdsDados.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Nenhum registro foi informado!', ['&OK']);
    exit;
  end;

  if (fMensagem('', 'Confirma gravação do ' + IIF(fEmptyStr(edtNumLot.Text), 'novo lote', 'lote ' + edtNumLot.Text) + '?', ['&Sim', '&Não'], 2) = 2) then
    exit;

  FLoteGravacao := '';
  if fChamaTelaGravando(fGravarDadosDoLote) then
  begin
    if (fPermiteEfetivar) then
    begin
      if (fMensagem('', 'Deseja efetuar o fechamento do lote selecionado?', ['&Sim', '&Não'], 2) = 1) then
      begin
        // tranforma os dados da LOTCON em LANCON e grava a DATA DE FECHAMENTO na LOTCON
        fChamaTelaGravando(fGravarDadosLanCon);
      end;
    end;
  end;

  edtNumLot.Text := '';
  pResetarTela;
  pStatusBotoes(cdsDados);
  pSetFocus(edtValPrev);
end;

procedure TfrmManutencaoLoteContabil.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    charKey: Char;
begin
  charKey := '/';
  if fPesqLotContabil(Self, edtNumLot, nil, charKey, arrSel) then
  begin
    pCarregaDadosLote(edtNumLot.Text);
    SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmManutencaoLoteContabil.cxgDadosTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
  var
    strValor : string;
begin
  if Key = VK_RETURN then
  Begin
    If not Assigned(AItem) then
      Exit;

    If not (AItem is TcxGridDBColumn) then
      Exit;

    if not (cdsDados.State in [dsInsert, dsEdit]) then
      exit;

    if (cxgDadosTableViewCON_CONDEB.Focused) then
    begin
      strValor := fSemMascaraPlaNco(AEdit.EditingValue);

      if not fValidaConta(strValor) then
      begin
        fMensagem('ATENÇÃO!', 'Conta Débito inválida!', ['&OK']);
        cdsDados.Cancel;
      end
      else
      begin
        cdsDados.FieldByName('CON_CONDEB').AsString := strValor;
        cdsDados.FieldByName('DES_CONDEB').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(strValor)], False);
        cdsDados.Post;
      end;
    end
    else if (cxgDadosTableViewCON_CONCRE.Focused) then
    begin
      strValor := fSemMascaraPlaNco(AEdit.EditingValue);

      if not fValidaConta(strValor) then
      begin
        fMensagem('ATENÇÃO!', 'Conta Crédito inválida!', ['&OK']);
        cdsDados.Cancel;
      end
      else
      begin
        cdsDados.FieldByName('CON_CONCRE').AsString := strValor;
        cdsDados.FieldByName('DES_CONCRE').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(strValor)], False);
        cdsDados.Post;
      end;
    end
    else if (cxgDadosTableViewCON_CCUSTO.Focused) then
    begin
      if fEmptyStr(fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [AEdit.EditingValue], False)) then
      begin
        fMensagem('ATENÇÃO!', 'Centro de Custo inválido!', ['&OK']);
        cdsDados.Cancel;
      end
      else
      begin
        cdsDados.FieldByName('CON_CCUSTO').AsString := AEdit.EditingValue;
        cdsDados.FieldByName('DES_CCUSTO').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [AEdit.EditingValue], False);
        cdsDados.Post;
      end;
    end
    else if (cxgDadosTableViewCON_CCUSCR.Focused) then
    begin
      if fEmptyStr(fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [AEdit.EditingValue], False)) then
      begin
        fMensagem('ATENÇÃO!', 'Centro de Custo inválido!', ['&OK']);
        cdsDados.Cancel;
      end
      else
      begin
        cdsDados.FieldByName('CON_CCUSCR').AsString := AEdit.EditingValue;
        cdsDados.FieldByName('DES_CCUSCR').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [AEdit.EditingValue], False);
        cdsDados.Post;
      end;
    end
    else if (cxgDadosTableViewCON_DTALAN.Focused) then
    begin
      if not fDataValida(AEdit.EditingValue) then
      begin
        fMensagem('ATENÇÃO!', 'Data inválida!', ['&OK']);
        cdsDados.Cancel;
      end
      else
      begin
        cdsDados.FieldByName('CON_DTALAN').AsDateTime := AEdit.EditingValue;
        cdsDados.Post;
      end;
    end;
  End;
end;

procedure TfrmManutencaoLoteContabil.cxgDadosTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_DELETE) Then
  Begin
    if fLoteFechado(edtNumLot.Text) then
      exit;

    If (cdsDados.Active) And
       (cdsDados.RecordCount > 0) And
       (fMensagem('', 'Deseja remover o registro selecionado?', ['&Sim', '&Não'], 2) = 1) Then
    begin
      if cdsDebitos.Locate('AUTOINCREM', cdsDados.FieldByName('AUTOINCREM').AsInteger, []) then
        cdsDebitos.Delete;
      if cdsCreditos.Locate('AUTOINCREM', cdsDados.FieldByName('AUTOINCREM').AsInteger, []) then
        cdsCreditos.Delete;
      cdsDados.Delete;
      pAtualizaInformativos;
    end;
  End;
end;

procedure TfrmManutencaoLoteContabil.edtCCustoCreditoExit(Sender: TObject);
begin
  edtDesCCustoCredito.Text := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [edtCCustoCredito.Text], False);
  if fEmptyStr(edtDesCCustoCredito.Text) then
  begin
    edtCCustoCredito.Clear ;
  end;
end;

procedure TfrmManutencaoLoteContabil.edtCCustoCreditoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEvento : TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, edtCCustoCredito, edtDesCCustoCredito, Nil, Key, arrEvento, True, True) Then
  Begin
    If fValidaCampos(edtCCustoCredito, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutencaoLoteContabil.edtCCustoDebitoExit(Sender: TObject);
begin
  edtDesCCustoDebito.Text := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [edtCCustoDebito.Text], False);
  if fEmptyStr(edtDesCCustoDebito.Text) then
  begin
    edtCCustoDebito.Clear ;
  end;
end;

procedure TfrmManutencaoLoteContabil.edtCCustoDebitoKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmManutencaoLoteContabil.edtEmpLanKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpLan, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpLan) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmManutencaoLoteContabil.fCriaCdsDados(blnCriaSoma: boolean = false): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);
  With Result, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name     := 'AUTOINCREM';
      DataType := ftInteger;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'CON_DTALAN';
      DataType := ftDate;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_INCDOC';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_EMPLAN';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CONCRE';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CONDEB';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_VALLAN';
      DataType := ftFloat;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_HISTOR';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CCUSTO';
      DataType := ftString;
      Size     := 5;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CCUSCR';
      DataType := ftString;
      Size     := 5;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'DES_CONDEB';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'DES_CCUSTO';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'DES_CCUSCR';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'DES_CONCRE';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    IndexFieldNames := 'CON_DTALAN';
    CreateDataSet;

    if (blnCriaSoma) then
    begin
      Result.AggregatesActive := True;
      Result.Close;
      pCriaAggregate(Result, 'CON_VALLAN', 'TOT_VALLAN');
      Open;
    end;

    TFloatField(Result.FieldByName('CON_VALLAN')).DisplayFormat := '##,#0.00';
    Result.FieldByName('CON_CONDEB').EditMask := fMskCon;
    Result.FieldByName('CON_CONCRE').EditMask := fMskCon;
  End;
end;

procedure TfrmManutencaoLoteContabil.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtValPrev);
end;

procedure TfrmManutencaoLoteContabil.FormCreate(Sender: TObject);
  var
    intTamCodEve : Integer;
    strMascara : string;
begin
  inherited;
  FLoteGravacao := '';
  FAutoincrem := 0;
  cdsDados := fCriaCdsDados;
  cdsDebitos := fCriaCdsDados(True);
  cdsCreditos := fCriaCdsDados(True);
  dtsDados.DataSet := cdsDados;

  cdsDados.AfterPost := pAfterPost;
  cdsDados.AfterDelete := pAfterDelete;

  intTamCodEve := Contabilidade.Funcoes.fTamCodEve;
  edtCCustoDebito.MaxLength := intTamCodEve;
  edtCCustoDebito.TamCampo := intTamCodEve;
  edtCCustoCredito.MaxLength := intTamCodEve;
  edtCCustoCredito.TamCampo := intTamCodEve;

  strMascara := fMskCon;
  mskContaDebito.EditMask := strMascara;
  mskContaCredito.EditMask := strMascara;
  FValidarVigenciaCta := fTemVigencia;
  /////carrega as contas em uma tabela de memoria para verificação
  cdsPlancoVigencia := fCarregaPlancoVigencia ;
  FStrPatrimCre := '' ;
  FStrPatrimDeb := '' ;
  if fCfgObrCcu = 'N' then
  begin
    edtCCustoDebito.Enabled := False ;
    edtCCustoCredito.Enabled := False ;
  end;
end;

procedure TfrmManutencaoLoteContabil.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDados);
  FreeAndNil(cdsDebitos);
  FreeAndNil(cdsCreditos);
  pLiberaPlancoVigencia ;
  inherited;
end;

procedure TfrmManutencaoLoteContabil.pSomatorioDados(var fltDebitos, fltCreditos: double);
begin
  fltDebitos := fDoubleAggregate(cdsDebitos, 'TOT_VALLAN');
  fltCreditos := fDoubleAggregate(cdsCreditos, 'TOT_VALLAN');
end;

procedure TfrmManutencaoLoteContabil.pStatusBotoes(DataSet: TDataSet);
begin
  btnCancelar.Enabled := Not DataSet.IsEmpty;
  btnGravarLote.Enabled := Not DataSet.IsEmpty;
end;

function TfrmManutencaoLoteContabil.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtEmpLan) Then
    Begin
      If (Not fEmptyStr(edtEmpLan.Text)) Then
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpLan.Text], False);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&OK']);
          Result := False;
        End;
      End
      Else
      begin
        edtNomEmp.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = edtValor) then
    begin
      if (edtValor.Value <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'O Valor do lançamento deve ser preenchido!', ['&OK']);
        Result := False;
      end;
    end

    else if (Sender = mskDtaLan) then
    begin
      if fEmptyStr(fTiraCaracEspeciais(mskDtaLan.Text)) then
      begin
        fMensagem('', 'O campo data deve ser preenchido!', ['&OK']);
        Result := False;
      end
    end

    else if (Sender = edtValPrev) then
    begin
      if (edtValPrev.Value <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'O valor previsto deve ser maior que zero!', ['&OK']);
        result := false;
      end;
    end

    else if (Sender = edtCCustoDebito) and (edtCCustoDebito.Enabled) then
    begin
      if fEmptyStr(edtCCustoDebito.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Obrigatório informar centro de custo de débito!', ['&OK']);
        Result := False;
      end;
    end

    else if (Sender = edtCCustoCredito) and (edtCCustoCredito.Enabled) then
    begin
      if fEmptyStr(edtCCustoCredito.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Obrigatório informar centro de custo de crédito!', ['&OK']);
        Result := False;
      end;
    end;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmManutencaoLoteContabil.mskContaCreditoExit(Sender: TObject); 
begin
  edtDesContaCredito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaCredito.Text)], False);
  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) And (fEmptyStr(edtDesContaCredito.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Conta de Crédito Inválida!',['&OK']);
    pSetFocus(mskContaCredito);
    Exit;
  End;
  FStrPatrimCre := fCampoTabelaPlanco('NCO_PATRIM', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaCredito.Text)], False) ;
  edtCCustoCredito.Enabled := (fCfgObrCcu = 'S') and (FStrPatrimCre = 'N') ;
end;

procedure TfrmManutencaoLoteContabil.mskContaCreditoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlan: TConsultasArray;
begin
  If fPesqPlanoContabil(Self, mskContaCredito, edtDesContaCRedito, Nil, Key, arrPlan) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmManutencaoLoteContabil.mskContaDebitoExit(Sender: TObject);
begin
  edtDesContaDebito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)], False);
  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) And (fEmptyStr(edtDesContaDebito.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Conta de Débito Inválida!',['&OK']);
    pSetFocus(mskContaDebito);
    Exit;
  End;
  FStrPatrimDeb := fCampoTabelaPlanco('NCO_PATRIM', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)], False) ;
  edtCCustoDebito.Enabled := (fCfgObrCcu = 'S') and (FStrPatrimDeb = 'N') ;
end;

procedure TfrmManutencaoLoteContabil.mskContaDebitoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlan: TConsultasArray;
begin
  If fPesqPlanoContabil(Self, mskContaDebito, edtDesContaDebito, Nil, Key, arrPlan) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmManutencaoLoteContabil.pAfterDelete(DataSet: TDataSet);
begin
  pStatusBotoes(DataSet);
end;

procedure TfrmManutencaoLoteContabil.pAfterPost(DataSet: TDataSet);
begin
  pStatusBotoes(DataSet);
end;

procedure TfrmManutencaoLoteContabil.pAtualizaInformativos;
  var
    fltDebitos, fltCreditos : double;
begin
  pSomatorioDados(fltDebitos, fltCreditos);
  lblDebitos.Caption     := 'Débitos....:  ' + FloatToStrF(fltDebitos, ffNumber, 15, 2);
  lblCreditos.Caption    := 'Créditos...:  ' + FloatToStrF(fltCreditos, ffNumber, 15, 2);
  lblDiferenca.Caption   := 'Diferença..:  ' + FloatToStrF(fltCreditos-fltDebitos, ffNumber, 15, 2);
  lblLancamentos.Caption := 'Lançamentos:  ' + IntToStr(cdsDados.RecordCount);
end;

function TfrmManutencaoLoteContabil.fCancelarEfetivacao(strNumLot: string): boolean;
  var
    qryCancela : TUniQuery;
    qryLotLan : TUniQuery;
begin
  qryCancela := fCriaQuery(Self);
  qryLotLan := fCriaQuery(Self);
  try
    fStartTransaction;
    try
      qryCancela.SQL.Text := 'UPDATE LOTCON SET CON_DTAFEC = NULL WHERE CON_NUMLOT = :NUMLOT';
      qryCancela.ParamByName('NUMLOT').AsString := strNumLot;
      qryCancela.ExecSQL;

      qryLotLan.SQL.Text := 'SELECT AUTOINCREM FROM LOTLAN WHERE LAN_NUMLOT = :NUMLOT';
      qryLotLan.ParamByName('NUMLOT').AsString := strNumLot;
      qryLotLan.Open;

      qryCancela.Close;
      qryCancela.SQL.Text := 'DELETE FROM LANCON WHERE CON_TIPLAN = :TIPLAN AND CON_INCDOC = :INCDOC';

      qryLotLan.First;
      while not qryLotLan.Eof do
      begin
        qryCancela.Close;
        qryCancela.ParamByName('TIPLAN').AsString := 'LOT';
        qryCancela.ParamByName('INCDOC').AsString := qryLotLan.FieldByName('AUTOINCREM').AsString;
        qryCancela.ExecSQL;

        qryLotLan.Next;
      end;

      fCommit;
      Result := True;
    except
      on E: Exception do
      begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[TfrmManutencaoLoteContabil.fCancelarEfetivacao]');
      end;
    end;
  finally
    FreeAndNil(qryCancela);
    FreeAndNil(qryLotLan);
  end;
end;

procedure TfrmManutencaoLoteContabil.pCarregaDadosLote(strNumLot: string);
  var
    qryLotCon : TUniQuery;
    qryLotLan : TUniQuery;
begin
  pResetarTela;

  qryLotCon := fCriaQuery(Self);
  qryLotLan := fCriaQuery(Self);
  try
    qryLotCon.SQL.Text := 'SELECT * FROM LOTCON WHERE CON_NUMLOT = :NUMLOT';
    qryLotCon.ParamByname('NUMLOT').AsString := strNumLot;
    qryLotCon.Open;

    if (not qryLotCon.isEmpty) then
    begin
      edtValPrev.Value := qryLotCon.FieldByName('CON_VALPRE').AsFloat;

      qryLotLan.SQL.Text := 'SELECT * FROM LOTLAN WHERE LAN_NUMLOT = :NUMLOT';
      qryLotLan.ParamByname('NUMLOT').AsString := strNumLot;
      qryLotLan.Open;

      qryLotLan.First;
      while not qryLotLan.Eof do
      begin
        Inc(FAutoincrem);
        pLancar(cdsDados, FAutoincrem, qryLotLan.FieldByName('LAN_DTALAN').AsDateTime, qryLotLan.FieldByName('LAN_EMPLAN').AsString, qryLotLan.FieldByName('LAN_CONDEB').AsString, qryLotLan.FieldByName('LAN_CONCRE').AsString, qryLotLan.FieldByName('LAN_HISTOR').AsString, qryLotLan.FieldByName('LAN_CCUSTO').AsString, qryLotLan.FieldByName('LAN_CCUSCR').AsString, qryLotLan.FieldByName('LAN_VALLAN').AsFloat);

        if not fEmptyStr(qryLotLan.FieldByName('LAN_CONDEB').AsString) then
          pLancar(cdsDebitos, FAutoincrem, qryLotLan.FieldByName('LAN_DTALAN').AsDateTime, qryLotLan.FieldByName('LAN_EMPLAN').AsString, qryLotLan.FieldByName('LAN_CONDEB').AsString, qryLotLan.FieldByName('LAN_CONCRE').AsString, qryLotLan.FieldByName('LAN_HISTOR').AsString, qryLotLan.FieldByName('LAN_CCUSTO').AsString, qryLotLan.FieldByName('LAN_CCUSCR').AsString, qryLotLan.FieldByName('LAN_VALLAN').AsFloat);

        if not fEmptyStr(qryLotLan.FieldByName('LAN_CONCRE').AsString) then
          pLancar(cdsCreditos, FAutoincrem, qryLotLan.FieldByName('LAN_DTALAN').AsDateTime, qryLotLan.FieldByName('LAN_EMPLAN').AsString, qryLotLan.FieldByName('LAN_CONDEB').AsString, qryLotLan.FieldByName('LAN_CONCRE').AsString, qryLotLan.FieldByName('LAN_HISTOR').AsString, qryLotLan.FieldByName('LAN_CCUSTO').AsString, qryLotLan.FieldByName('LAN_CCUSCR').AsString, qryLotLan.FieldByName('LAN_VALLAN').AsFloat);

        qryLotLan.Next;
      end;

      btnExcluir.Enabled := qryLotCon.FieldByName('CON_DTAFEC').IsNull;
      btnCancelarEfetivacao.Enabled := not qryLotCon.FieldByName('CON_DTAFEC').IsNull;
    end;

    pAtualizaInformativos;
    pStatusBotoes(cdsDados);
  finally
    FreeAndNil(qryLotCon);
    FreeAndNil(qryLotLan);
  end;
end;

procedure TfrmManutencaoLoteContabil.pDeletaLotCon(strNumLot: string);
  var
    qryLotCon : TUniQuery;
begin
  qryLotCon := fCriaQuery(Self);
  try
    qryLotCon.SQL.Text := 'DELETE FROM LOTCON WHERE CON_NUMLOT = :NUMLOT';
    qryLotCon.ParamByName('NUMLOT').AsString := strNumLot;
    qryLotCon.ExecSQL;
  finally
    FreeAndNil(qryLotCon);
  end;
end;

procedure TfrmManutencaoLoteContabil.pLancar(ACdsDados: TUniClientDataSet; intAutoincrem: integer; dtaDtaLan: TDateTime; strEmpLan, strContaDebito, strContaCredito, strHistorico, strCentroDeCustoDebito, strCentroDeCustoCredito: string; fltValor: double);
begin
  ACdsDados.Insert;
  ACdsDados.FieldByName('AUTOINCREM').AsInteger := intAutoincrem;
  ACdsDados.FieldByName('CON_DTALAN').AsDateTime := dtaDtaLan;
  ACdsDados.FieldByName('CON_EMPLAN').AsString := strEmpLan;
  ACdsDados.FieldByName('CON_CONDEB').AsString := strContaDebito;
  ACdsDados.FieldByName('CON_CONCRE').AsString := strContaCredito;
  ACdsDados.FieldByName('CON_VALLAN').AsFloat  := fltValor;
  ACdsDados.FieldByName('CON_HISTOR').AsString := strHistorico;
  ACdsDados.FieldByName('CON_CCUSTO').AsString := strCentroDeCustoDebito;
  ACdsDados.FieldByName('CON_CCUSCR').AsString := strCentroDeCustoCredito;
  ACdsDados.FieldByName('DES_CONDEB').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [strContaDebito], False);
  ACdsDados.FieldByName('DES_CONCRE').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [strContaCredito], False);
  ACdsDados.FieldByName('DES_CCUSTO').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [strCentroDeCustoDebito], False);
  ACdsDados.FieldByName('DES_CCUSCR').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [strCentroDeCustoCredito], False);
//  ACdsDados.FieldByName('CON_C_G_C_').AsString := strCnpj;
  ACdsDados.Post;
end;

procedure TfrmManutencaoLoteContabil.pGravaLotCon(strNumLot: string; fltValPrev: double);
  var
    qryLotCon : TUniQuery;
begin
  qryLotCon := fCriaQuery(Self);
  try
    qryLotCon.SQL.Text := 'SELECT * FROM LOTCON WHERE FALSE';
    qryLotCon.Open;
    qryLotCon.Insert;
    qryLotCon.FieldByName('CON_NUMLOT').AsString := strNumLot;
    qryLotCon.FieldByName('CON_VALPRE').AsFloat := fltValPrev;
    qryLotCon.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOTCON', VS_strCodEmp);
    qryLotCon.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado;
    qryLotCon.FieldByName('CON_DTALAN').AsDateTime := VS_Date;
    //qryLotCon.FieldByName('CON_DTAFEC').AsDateTime :=
    qryLotCon.Post;
  finally
    FreeAndNil(qryLotCon);
  end;
end;

procedure TfrmManutencaoLoteContabil.pGravaLotLan(strNumLot: string; pgbProgresso: TcxProgressBar);
  var
    qryLotLan : TUniQuery;
begin
  qryLotLan := fCriaQuery(Self);
  try
    qryLotLan.SQL.Text := 'SELECT * FROM LOTLAN WHERE FALSE';
    qryLotLan.Open;

    if Assigned(pgbProgresso) then
      pgbProgresso.Properties.Max := cdsDados.RecordCount;

    cdsDados.First;
    while not cdsDados.Eof do
    begin
      if Assigned(pgbProgresso) then
      begin
        pgbProgresso.Position := cdsDados.RecNo;
        Application.ProcessMessages;
      end;

      qryLotLan.Insert;
      qryLotLan.FieldByName('LAN_NUMLOT').AsString := strNumLot;
      qryLotLan.FieldByName('LAN_EMPLAN').AsString := cdsDados.FieldByName('CON_EMPLAN').AsString;
      qryLotLan.FieldByName('LAN_DTALAN').AsDateTime := cdsDados.FieldByName('CON_DTALAN').AsDateTime;

      if not fEmptyStr(cdsDados.FieldByName('CON_CONDEB').AsString) then
        qryLotLan.FieldByName('LAN_CONDEB').AsString := cdsDados.FieldByName('CON_CONDEB').AsString;

      if not fEmptystr(cdsDados.FieldByName('CON_CONCRE').AsString) then
        qryLotLan.FieldByName('LAN_CONCRE').AsString := cdsDados.FieldByName('CON_CONCRE').AsString;

      if not fEmptyStr(cdsDados.FieldByName('CON_CCUSTO').AsString) then
        qryLotLan.FieldByName('LAN_CCUSTO').AsString := cdsDados.FieldByName('CON_CCUSTO').AsString;

      if not fEmptyStr(cdsDados.FieldByName('CON_CCUSCR').AsString) then
        qryLotLan.FieldByName('LAN_CCUSCR').AsString := cdsDados.FieldByName('CON_CCUSCR').AsString;

      qryLotLan.FieldByName('LAN_HISTOR').AsString := cdsDados.FieldByName('CON_HISTOR').AsString;
      qryLotLan.FieldByName('LAN_VALLAN').AsFloat := cdsDados.FieldByName('CON_VALLAN').AsFloat;
      qryLotLan.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOTLAN', VS_strCodEmp);
      qryLotLan.Post;

      cdsDados.Edit;
      cdsDados.FieldByName('CON_INCDOC').AsString := qryLotLan.FieldByName('AUTOINCREM').AsString;
      cdsDados.Post;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(qryLotLan);
  end;
end;

function TfrmManutencaoLoteContabil.fGravarDadosLanCon(
  pgbProgresso: TcxProgressBar): Boolean;
  var
    qryLanCon : TUniQuery;
    qryLotCon : TUniQuery;
begin
  qryLanCon := fCriaQuery(Self);
  qryLotCon := fCriaQuery(Self);
  try
    cdsDados.DisableControls;

    qryLanCon.SQL.Text := 'SELECT * FROM LANCON WHERE FALSE';
    qryLanCon.Open;

    fStartTransaction;
    try
      if Assigned(pgbProgresso) then
        pgbProgresso.Properties.Max := cdsDados.RecordCount;

      cdsDados.First;
      while not cdsDados.Eof do
      begin
        if Assigned(pgbProgresso) then
        begin
          pgbProgresso.Position := cdsDados.RecNo;
          Application.ProcessMessages;
        end;

        qryLanCon.Insert;
        qryLanCon.FieldByName('CON_TIPLAN').AsString := 'LOT';
        qryLanCon.FieldByName('CON_EMPLAN').AsString := cdsDados.FieldByName('CON_EMPLAN').AsString;
        qryLanCon.FieldByName('CON_DTALAN').AsDateTime := cdsDados.FieldByName('CON_DTALAN').AsDateTime;

        if not fEmptyStr(cdsDados.FieldByName('CON_CONCRE').AsString) then
          qryLanCon.FieldByName('CON_CONCRE').AsString := cdsDados.FieldByName('CON_CONCRE').AsString;

        if not fEmptyStr(cdsDados.FieldByName('CON_CONDEB').AsString) then
          qryLanCon.FieldByName('CON_CONDEB').AsString := cdsDados.FieldByName('CON_CONDEB').AsString;

        qryLanCon.FieldByName('CON_HISTOR').AsString := cdsDados.FieldByName('CON_HISTOR').AsString;
        qryLanCon.FieldByName('CON_VALLAN').AsFloat := cdsDados.FieldByName('CON_VALLAN').AsFloat;
        qryLanCon.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado;

        if not fEmptyStr(cdsDados.FieldByName('CON_CCUSTO').AsString) then
          qryLanCon.FieldByName('CON_CCUSTO').AsString := cdsDados.FieldByName('CON_CCUSTO').AsString;

        if not fEmptyStr(cdsDados.FieldByName('CON_CCUSCR').AsString) then
          qryLanCon.FieldByName('CON_CCUSCR').AsString := cdsDados.FieldByName('CON_CCUSCR').AsString;

        qryLanCon.FieldByName('CON_INCDOC').AsString := cdsDados.FieldByName('CON_INCDOC').AsString;
        qryLanCon.Post;

        cdsDados.Next;
      end;

      qryLotCon.SQL.Text := 'UPDATE LOTCON SET CON_DTAFEC = :DTAFEC WHERE CON_NUMLOT = :NUMLOT';
      qryLotCon.ParamByName('DTAFEC').AsDateTime := VS_Date;
      qryLotCon.ParamByName('NUMLOT').AsString := FLoteGravacao;
      qryLotCon.ExecSQL;

      fCommit;
      fMensagem('ATENÇÃO!', 'Fechamento efetuado com sucesso!', ['&OK']);

      Result := true;
    except
      on E: Exception do
      begin
        Result := false;
        fRollBack;
        fMensagem('ATENÇÃO!', 'Erro ao efetuar fechamento: ' + E.Message, ['&OK']);
      end;
    end;
  finally
    cdsDados.First;
    cdsDados.EnableControls;
    FreeAndNil(qryLanCon);
    FreeAndNil(qryLotCon);
  end;
end;

function TfrmManutencaoLoteContabil.fLoteFechado(strNumLot: string): boolean;
  var
    qryLotCon : TUniQuery;
begin
  qryLotCon := fCriaQUery(Self);
  try
    qryLotCon.SQL.Text := 'SELECT CON_DTAFEC FROM LOTCON WHERE CON_NUMLOT = :NUMLOT';
    qryLotCon.ParamByName('NUMLOT').AsString := strNumLot;
    qryLotCon.Open;

    if not qryLotCon.IsEmpty then
      Result := not qryLotCon.FieldByName('CON_DTAFEC').IsNull
    else
      Result := False;

    if Result then
      fMensagem('ATENÇÃO!', 'Lote já foi fechado, não permite mais alterações!', ['&OK']);
  finally
    FreeAndNil(qryLotCon);
  end;
end;

function TfrmManutencaoLoteContabil.fGravarDadosDoLote(pgbProgresso: TcxProgressBar): Boolean;
begin
  fStartTransaction;
  try
    FLoteGravacao := edtNumLot.Text;
    if fEmptyStr(FLoteGravacao) then
      FLoteGravacao := fInserirLotInc('LOTE', 'LOT', VS_strCodEmp, VS_Date, 0);
    pDeletaLotCon(FLoteGravacao);
    pGravaLotCon(FLoteGravacao, edtValPrev.Value);
    pGravaLotLan(FLoteGravacao, pgbProgresso);
    fCommit;
    fMensagem('ATENÇÃO!', 'Gravação do lote efetuada com sucesso!', ['&OK']);
    Result := true;
  except
    on E: Exception do
    begin
      fRollBack;
      raise;
    end;
  end;
end;

procedure TfrmManutencaoLoteContabil.pLimparDadosLancamento;
begin
  edtEmpLan.Clear;
  edtNomEmp.Clear;
  mskContaDebito.Clear;
  mskContaCredito.Clear;
  edtDesContaDebito.Clear;
  edtDesContaCredito.Clear;
  edtCCustoDebito.Clear;
  edtDesCCustoDebito.Clear;
  edtCCustoCredito.Clear;
  edtDesCCustoCredito.Clear;
  edtHistorico.Clear;
  edtCCustoDebito.Enabled := False;
  edtCCustoCredito.Enabled := False;
  FStrPatrimCre := '' ;
  FStrPatrimDeb := '' ;
  edtValor.Value := 0;
end;

procedure TfrmManutencaoLoteContabil.pResetarTela;
begin
  FAutoincrem := 0;
  cdsDados.EmptyDataSet;
  cdsDebitos.EmptyDataSet;
  cdsCreditos.EmptyDataSet;
  edtValPrev.Value := 0;
  btnExcluir.Enabled := False;
  btnGravarLote.Enabled := False;
  btnCancelarEfetivacao.Enabled := False;

  pLimparDadosLancamento;
  pAtualizaInformativos;
end;

function TfrmManutencaoLoteContabil.fPermiteEfetivar: boolean;
  var fltDebitos, fltCreditos: double;
begin
  pSomatorioDados(fltDebitos, fltCreditos);
  Result := (fFormataFloat(fltDebitos, 2) = fFormataFloat(fltCreditos, 2));
end;

function TfrmManutencaoLoteContabil.fPodeCancelarPeriodo(strNumLot: string): boolean;
  var
    qryLotLan : TUniQuery;
    dtaDtaIni, dtaDtaFin: TDateTime;
    strMensagem: string;
begin
  qryLotLan := fCriaQUery(Self);
  try
    Result := True;

    qryLotLan.SQL.Text := 'SELECT MIN(LAN_DTALAN) AS DTAINI, MAX(LAN_DTALAN) AS DTAFIN, LAN_EMPLAN FROM LOTLAN WHERE LAN_NUMLOT = :NUMLOT GROUP BY LAN_EMPLAN';
    qryLotLan.ParamByName('NUMLOT').AsString := strNumLot;
    qryLotLan.Open;

    if not qryLotLan.IsEmpty then
    begin
      qryLotLan.First;
      while not qryLotLan.Eof do
      begin
        dtaDtaIni := 0;
        dtaDtaFin := 0;

        if not qryLotLan.FieldByName('DTAINI').IsNull then
          dtaDtaIni := qryLotLan.FieldByName('DTAINI').AsDateTime;

        if not qryLotLan.FieldByName('DTAFIN').IsNull then
          dtaDtaFin := qryLotLan.FieldByName('DTAFIN').AsDateTime;

        if (dtaDtaIni <> 0) and (dtaDtaFin <> 0) then
        begin
          if fLancamentoAnteriorFechamento(dtaDtaIni, qryLotLan.FieldByName('LAN_EMPLAN').AsString, strMensagem) then
          begin
            Result := False;
            fMensagem('', strMensagem, ['&OK']);
            Exit;
          end;
        end;

        qryLotLan.Next;
      end;
    end;
  finally
    FreeAndNil(qryLotLan);
  end;
end;

function TfrmManutencaoLoteContabil.fValidaConta(strConta: string): boolean;
begin
  result := true;
  if fEmptyStr(fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(strConta)], False)) then
    Result := False;
end;

procedure TfrmManutencaoLoteContabil.pLiberaPlancoVigencia;
begin
  if not FValidarVigenciaCta then
  begin
    exit ;
  end;

  if assigned(cdsPlancoVigencia) then
    FreeAndNil(cdsPlancoVigencia);
end;

end.
