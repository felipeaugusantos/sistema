unit Contabilidade.View.MultLancamentosContabeis;

interface

uses
  Windows, Classes, Controls, Forms, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, DBCtrls, DBEditFocus, DB, Uni, AppEvnts, BitBtnLockedIncrem,
  DBLookupComboBoxFocus, UniClientDataSet, Mask, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, EditFocus, Variants, untZClient,
  ComboBoxFocus, cxDataControllerConditionalFormattingRulesManagerDialog,
  Vcl.CheckLst, System.StrUtils, MaskEditFocus, cxContainer, cxTextEdit,
  cxCurrencyEdit, CurrencyEditFocus, Contabilidade.View.TfrmPaiContabilidade, Contabilidade.Model.TDadosImportacaoContabil,
  System.Generics.Collections;

type
  TfrmMultLancamentosContabeis = class(TfrmPaiContabilidade)
    pnlFundo: TPanel;
    pnlAddReg: TPanel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDadosTableView: TcxGridDBTableViewCitel;
    cxgDados: TcxGridCitel;
    cxgDadosTableViewCOD_DESVAL: TcxGridDBColumn;
    cxgDadosTableViewCONTA_DEBITO: TcxGridDBColumn;
    dtsDados: TDataSource;
    pnlDados: TPanel;
    cxgDadosTableViewCOD_CONDEB: TcxGridDBColumn;
    cxgDadosTableViewCONTA_CREDITO: TcxGridDBColumn;
    pnlDadosDigitacao: TPanel;
    mskConta: TMaskEditFocus;
    edtTipoLancamento: TComboBoxFocus;
    Label24: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    btnAddReg: TBitBtnLocked;
    edtDesConta: TEditFocus;
    edtValor: TCurrencyEditFocus;
    edtDesHisCre: TEditFocus;
    edtHisPad: TEditFocus;
    Label8: TLabel;
    btnConfirmar: TBitBtnLocked;
    cxgDadosTableViewVALLAN: TcxGridDBColumn;
    pnlValores: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddRegClick(Sender: TObject);
    procedure cxgDadosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskContaKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaExit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtHisPadExit(Sender: TObject);
    procedure edtHisPadKeyPress(Sender: TObject; var Key: Char);
    procedure cxgDadosTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    cdsPlancoVigencia: TUniClientDataSet;
    FValidarVigenciaCta : boolean;
    cdsDados : TUniClientDataSet;
    procedure pLimparDigitacaoContas;
    procedure pAdicionaRegistro;
    function fValidaConta(strConta: string): boolean;
    function fCriarCdsDados: TUniClientDataSet;
    function fVaiDeletarRegistro(Key: Word): boolean;
    procedure pAdicionarLancamentos;
    function fInformouValorCorreto(var fltValorInformado: double): boolean;
    procedure pAtualizaValoresNoPanel(const fltValorInformado: double);
    procedure pLiberaPlancoVigencia;
  public
    { Public declarations }
    fltValorTotalLanctos : double;
    listaLancamentos : TObjectList<TDadosImportacaoContabil>;
    dtaLan : TDate ;
    strEmpLan: string ;
  end;

implementation

uses SysUtils, untFuncoesSimples, untTypesSistema, System.MaskUtils,
  Contabilidade.Funcoes, Contabilidade.Consultas;

{$R *.dfm}

procedure TfrmMultLancamentosContabeis.FormCreate(Sender: TObject);
begin
  inherited;
  mskConta.EditMask := fMskCon;
  cdsDados := fCriarCdsDados;
  fltValorTotalLanctos := 0;

  FValidarVigenciaCta := fTemVigencia;
  /////carrega as contas em uma tabela de memoria para verificação
  cdsPlancoVigencia := fCarregaPlancoVigencia ;
end;

procedure TfrmMultLancamentosContabeis.FormDestroy(Sender: TObject);
begin
  pLiberaPlancoVigencia ;
  FreeAndNil(cdsDados);
  inherited;
end;

procedure TfrmMultLancamentosContabeis.FormShow(Sender: TObject);
begin
  inherited;
  listaLancamentos.Clear;
  dtsDados.DataSet := cdsDados;
  pAtualizaValoresNoPanel(0);
end;

procedure TfrmMultLancamentosContabeis.pAdicionaRegistro;
begin
  cdsDados.Insert;
  cdsDados.FieldByName('CODCON').AsString := fSemMascaraPlaNco(mskConta.Text);
  cdsDados.FieldByName('CONMSK').AsString := FormatMaskText(fMskCon, fSemMascaraPlaNco(mskConta.Text));
  cdsDados.FieldByName('DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(mskConta.Text)], False);
  cdsDados.FieldByName('TIPLAN').AsString := LeftStr(edtTipoLancamento.Text, 1);
  cdsDados.FieldByName('DESTPL').AsString := edtTipoLancamento.Text;
  cdsDados.FieldByName('VALLAN').AsFloat := edtValor.Value;

  if fEmptyStr(edtHisPad.Text) then
    cdsDados.FieldByName('HISPAD').AsInteger := -1
  else
    cdsDados.FieldByName('HISPAD').AsInteger := StrToInt(edtHisPad.Text);

  cdsDados.FieldByName('DESHIS').AsString := edtDesHisCre.Text;
  cdsDados.Post;
end;

procedure TfrmMultLancamentosContabeis.pAdicionarLancamentos;
  var
    dados: TDadosImportacaoContabil;
begin
  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

  if (cdsDados.FieldByName('TIPLAN').AsString = 'C') then
    dados.strContaCredito := cdsDados.FieldByName('CODCON').AsString
  else
    dados.strContaDebito := cdsDados.FieldByName('CODCON').AsString;

  dados.fltValorLancamento := cdsDados.FieldByName('VALLAN').AsFloat;
  dados.intCodigoHistoricoPadrao := cdsDados.FieldByName('HISPAD').AsInteger;

  listaLancamentos.Add(dados);
end;

procedure TfrmMultLancamentosContabeis.pAtualizaValoresNoPanel(const fltValorInformado: double);
begin
  pnlValores.Caption := 'Valor do Lançamento: ' + FloatToStrF(fltValorTotalLanctos, ffFixed, 12, 2) +
    ' - Valor Digitado: ' + FloatToStrF(fltValorInformado, ffFixed, 12, 2) + '   ';
end;

procedure TfrmMultLancamentosContabeis.pLimparDigitacaoContas;
begin
  edtTipoLancamento.ItemIndex := -1;
  edtValor.Value := 0;
  mskConta.Clear;
  edtDesConta.Clear;
  edtHisPad.Clear;
  edtDesHisCre.Clear;
  pSetFocus(edtTipoLancamento);
end;

procedure TfrmMultLancamentosContabeis.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  cdsDados.First;
  while not cdsDados.Eof do
  begin
    pAdicionarLancamentos;
    cdsDados.Next;
  end;

  Self.Close;
end;

procedure TfrmMultLancamentosContabeis.cxgDadosTableViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pnlInfo.Caption := '[Pressione delete para remover um registro]';
end;

procedure TfrmMultLancamentosContabeis.cxgDadosTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  var
    fltValorInformado: double;
begin
  if fVaiDeletarRegistro(Key) then
  begin
    if (fMensagem('', 'Deseja remover o registro selecionado?', ['&Sim', '&Não'], 2) = 1) Then
    begin
      cdsDados.Delete;
      btnConfirmar.Enabled := fInformouValorCorreto(fltValorInformado);
      pAtualizaValoresNoPanel(fltValorInformado);
    end;
  end;
end;

procedure TfrmMultLancamentosContabeis.edtHisPadExit(Sender: TObject);
begin
  inherited;
  edtDesHisCre.Text := fRetDescHistoricoPadrao(edtHisPad.Text, strEmpLan);
  If (Not fEmptyStr(edtHisPad.Text)) Then
  begin
    if (fEmptyStr(edtDesHisCre.Text)) Then
    Begin
      fMensagem('ATENÇÃO!','Histórico de Crédito Inválido!',['&OK']);
      pSetFocus(edtHisPad);
      Exit;
    End;
  end;
end;

procedure TfrmMultLancamentosContabeis.edtHisPadKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrHist: TConsultasArray;
begin
  If fPesqHistoricoPadrao(Self, edtHisPad, Nil, Nil, Key, arrHist, True, strEmpLan) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmMultLancamentosContabeis.btnAddRegClick(Sender: TObject);
  var
    fltValorInformado : double;
    strMensagemValidacao : string ;
begin
  If (edtTipoLancamento.Items.Count < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O tipo de lançamento deve ser preenchido!', ['&OK']);
    pSetFocus(edtTipoLancamento);
    Exit;
  End;

  if (edtValor.Value <= 0) then
  begin
    fMensagem('ATENÇÃO!', 'O valor informado é inválido!', ['&OK']);
    pSetFocus(edtValor);
    Exit;
  end;

  if not fValidaConta(mskConta.Text) then
  begin
    fMensagem('ATENÇÃO!', 'A conta deve ser preenchida corretamente!', ['&OK']);
    pSetFocus(mskConta);
    exit;
  end;

  if not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                 dtaLan,
                                 fSemMascaraPlaNco(mskConta.Text),
                                 strMensagemValidacao,
                                 VS_strCodEmp) then
  begin
    fMensagem('', strMensagemValidacao, ['&OK']);
    Exit;
  end ;

  pAdicionaRegistro;
  pLimparDigitacaoContas;
  btnConfirmar.Enabled := fInformouValorCorreto(fltValorInformado);
  pAtualizaValoresNoPanel(fltValorInformado);
end;

procedure TfrmMultLancamentosContabeis.mskContaExit(Sender: TObject);
begin
  inherited; 
  edtDesConta.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskConta.Text)], False);
end;

procedure TfrmMultLancamentosContabeis.mskContaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlan: TConsultasArray;
begin
  If fPesqPlanoContabil(Self, mskConta, Nil, Nil, Key, arrPlan) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmMultLancamentosContabeis.fVaiDeletarRegistro(Key: Word): boolean;
begin
  Result := False;
  if (Key = VK_DELETE) then
  begin
    if (cdsDados.Active) then
    begin
      if (cdsDados.RecordCount > 0) then
      begin
        Result := True;
      end;
    end;
  end;
end;

function TfrmMultLancamentosContabeis.fValidaConta(strConta: string): boolean;
begin
  result := true;

  if fEmptyStr(fSemMascaraPlaNco(strConta)) then
    Exit(False);

  if fEmptyStr(fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(strConta)], False)) then
    Exit(False);
end;

function TfrmMultLancamentosContabeis.fCriarCdsDados: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);
  Result.FieldDefs.Add('CODCON', ftString, 20, False);
  Result.FieldDefs.Add('CONMSK', ftString, 50, False);
  Result.FieldDefs.Add('DESCRI', ftString, 50, False);
  Result.FieldDefs.Add('TIPLAN', ftString, 01, False);
  Result.FieldDefs.Add('DESTPL', ftString, 30, False);
  Result.FieldDefs.Add('VALLAN', ftFloat,   0, False);
  Result.FieldDefs.Add('HISPAD', ftInteger, 0, False);
  Result.FieldDefs.Add('DESHIS', ftString, 50, False);
  Result.IndexFieldNames := 'CODCON';
  Result.CreateDataSet;
  Result.Open;
  TFloatField(Result.FieldByName('VALLAN')).DisplayFormat := '##,#0.00';
end;

function TfrmMultLancamentosContabeis.fInformouValorCorreto(var fltValorInformado: double): boolean;
  var
    LSomaCreditos, LSomaDebitos : double;
begin
  fltValorInformado := 0;

  LSomaCreditos := 0;
  LSomaDebitos := 0;
  cdsDados.First;
  while not cdsDados.Eof do
  begin
    if (cdsDados.FieldByName('TIPLAN').AsString = 'C') then
      LSomaCreditos := LSomaCreditos + fFormataFloat(cdsDados.FieldByName('VALLAN').AsFloat, 2)
    else
      LSomaDebitos := LSomaDebitos + fFormataFloat(cdsDados.FieldByName('VALLAN').AsFloat, 2);

    cdsDados.Next;
  end;

  if (fFormataFloat(fltValorTotalLanctos, 2) > 0) then
    Result := (((LSomaCreditos + fFormataFloat(fltValorTotalLanctos, 2)) - LSomaDebitos) = 0)
  else
    Result := ((LSomaCreditos - (fFormataFloat(Abs(fltValorTotalLanctos), 2) + LSomaDebitos)) = 0);

  fltValorInformado := LSomaCreditos - LSomaDebitos;
end;

procedure TfrmMultLancamentosContabeis.pLiberaPlancoVigencia;
begin
  if not FValidarVigenciaCta then
  begin
    exit ;
  end;

  if assigned(cdsPlancoVigencia) then
    FreeAndNil(cdsPlancoVigencia);
end;

end.

