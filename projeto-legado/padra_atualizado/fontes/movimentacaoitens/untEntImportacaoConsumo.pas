unit untEntImportacaoConsumo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.StdCtrls, UITypes,
  DirectoryEditFocus, Vcl.Mask, MaskEditFocus, EditFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxCheckBox, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Vcl.DBCtrls, DBMemoFocus, untEntImpConsumo,
  Datasnap.DBClient, cxContainer, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTypesSistema, cxDataControllerConditionalFormattingRulesManagerDialog,
  untFrameDirectoryEditFocus, MaskUtils, untFramePlanoDeContasMaskEdit,
  cxProgressBar,
  untGravando,
  untFuncoes,
  untDuplicatas,
  untConstantes,
  untConsultas,
  untFuncoesSimples,
  cxLabel,
  untCadCta;

type
  TfrmEntImpConsumo = class(TfrmPaiSimples)
    BitBtnLocked1: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlTail: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    lblCndPag: TLabel;
    mskDtaEnt: TMaskEditFocus;
    mskConPag: TMaskEditFocus;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    dbmLOGIMP: TDBMemoFocus;
    Panel5: TPanel;
    Shape1: TShape;
    Label5: TLabel;
    Shape2: TShape;
    Label6: TLabel;
    prgProgresso: TProgressBar;
    cxgArquivos: TcxGrid;
    cxgArquivosView: TcxGridDBTableView;
    cxgArquivosIMPORT: TcxGridDBColumn;
    cxgArquivosNOMARQ: TcxGridDBColumn;
    cxgArquivosSTATUS: TcxGridDBColumn;
    cxgArquivosNUMDOC: TcxGridDBColumn;
    cxgArquivosESPDOC: TcxGridDBColumn;
    cxgArquivosCGCTRA: TcxGridDBColumn;
    cxgArquivosCODTRA: TcxGridDBColumn;
    cxgArquivosNOMTRA: TcxGridDBColumn;
    cxgArquivosCNDPAG: TcxGridDBColumn;
    cxgArquivosVALTOT: TcxGridDBColumn;
    cxgArquivosLevel1: TcxGridLevel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    Label2: TLabel;
    dirPasta: TfraDirectoryEditFocus;
    cxgArquivosABRCOF: TcxGridDBColumn;
    cxgArquivosABRPIS: TcxGridDBColumn;
    chkGravaFinanceiro: TCheckBox;
    lblEventos: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    fraPlanoDeContasPga: TfraPlanoDeContasMskEdit;
    cxgArquivosDTADOC: TcxGridDBColumn;
    cxgArquivosCFOP: TcxGridDBColumn;
    lblMenConPag: TLabel;
    Label7: TLabel;
    Shape3: TShape;
    cxgArquivosViewColumn1: TcxGridDBColumn;
    chkCndPag: TCheckBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure cxgArquivosViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgArquivosCNDPAGGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure chkGravaFinanceiroClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkCndPagClick(Sender: TObject);

  private
    { Private declarations }
    FobjImportacao: TEntImpConsumo;
    procedure pReiniciaProcesso(blnHabilita: Boolean);
    function ValidaDiretorioXML(blnBuscaChave: Boolean): Boolean;
    function ValidaPlanoContas: Boolean;
    function ValidaPortador: Boolean;
    function ValidaCentroCusto: Boolean;
    function ValidaCondicaoPagamento(blnBuscaChave: Boolean): Boolean;
    function ValidaDataEntrada: Boolean;
    function pProcesso(AstrTitulo, AstrNomeProcesso: String;
      AobjFuncao: TReferenceFunctionProgresso): Boolean;
    function fConfirmar(AprgProgresso: TcxProgressBar): Boolean;
    function fXMLToDataSet(AprgProgresso: TcxProgressBar): Boolean;
    function fValidarArquivos: Boolean;
  public
    { Public declarations }
  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; Override;
    Procedure pHabilitaForm(blnHabilita: Boolean);
    function fValidaCondPagamento(blnBuscaPorChave: Boolean): Boolean;
  end;

implementation

{$R *.dfm}
{ TfrmEntFreConImpVarios }

procedure TfrmEntImpConsumo.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fPergunta('Confirma a importação dos arquivos selecionados?') TheN
    If pProcesso('Confirmando a importação', 'TfrmEntImpConsumo.btnConfirmaClick', fConfirmar) Then
      If (FobjImportacao.qryTabela.IsEmpty) Then
      Begin
        pReiniciaProcesso(True);
        pMensagemOk('Arquivos importados com sucesso!')
      End
      Else
        pMensagemOk('Há arquivos com erro de gravação!');
End;

function TfrmEntImpConsumo.fConfirmar(AprgProgresso: TcxProgressBar): Boolean;
Begin
  Result := False;
  Try
    pHabilitaForm(False);
    If fValidarArquivos Then
      pMensagemOk('Selecione os arquivos para importação!')
    Else
      Result := FobjImportacao.fConfirmarImportacaoConsumo(AprgProgresso);
  Finally
    pHabilitaForm(True);
  End;
end;

function TfrmEntImpConsumo.fValidarArquivos: Boolean;
Begin
  Result := FobjImportacao.qryTabela.IsEmpty;
End;

procedure TfrmEntImpConsumo.pHabilitaForm(blnHabilita: Boolean);
begin
  cxgArquivos.Enabled := blnHabilita;
  pnlBotoes.Enabled := blnHabilita;
end;

procedure TfrmEntImpConsumo.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  FobjImportacao.pMarcarTodosRegistros(False);
end;

procedure TfrmEntImpConsumo.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  FobjImportacao.pMarcarTodosRegistros(True);
end;

procedure TfrmEntImpConsumo.chkCndPagClick(Sender: TObject);
begin
  inherited;
  mskConPag.Enabled := chkCndpag.Checked And chkGravaFinanceiro.Checked;
  If Not (chkCndpag.Checked) Then
    mskConPag.Text := '';
end;

procedure TfrmEntImpConsumo.chkGravaFinanceiroClick(Sender: TObject);
begin
  inherited;
  edtCodPor.Enabled := chkGravaFinanceiro.Checked;
  edtCodEve.Enabled := chkGravaFinanceiro.Checked;
  fraPlanoDeContasPga.MskCodCta.Enabled := chkGravaFinanceiro.Checked;
  chkCndPag.Enabled := chkGravaFinanceiro.Checked;
  If Not edtCodPor.Enabled Then
  Begin
    edtCodPor.Text := '';
    edtCodEve.Text := '';
    fraPlanoDeContasPga.MskCodCta.Text := '';
    mskConPag.Text := '';
    chkCndPag.Checked := False;
  End;
  chkCndPagClick(chkCndPag);
end;

procedure TfrmEntImpConsumo.cxgArquivosCNDPAGGetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := FormatMaskText('(99)999.999.999.999.999.999.999.999.999.999.999.999;0;_', AText);
end;

procedure TfrmEntImpConsumo.cxgArquivosViewCustomDrawCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  intStatus: Integer;
begin
  inherited;
  intStatus := StrToIntDef
    (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
    cxgArquivosSTATUS.Index]), -1);

  Case intStatus Of
{$REGION 'IMPORTADO_COM_ERRO'}
    IMPORTADO_COM_ERRO:
      Begin
        ACanvas.Font.Color := clRed;
        If Not AViewInfo.Selected Then
          ACanvas.Brush.Color := clWindow;
      End;
{$ENDREGION}
{$REGION 'DOCUMENTO_JA_EXISTE'}
    DOCUMENTO_JA_EXISTE:
      Begin
        ACanvas.Brush.Color := clYellow;
        If AViewInfo.Selected Then
          ACanvas.Font.Color := clBlack;
      End;
{$ENDREGION}
{$REGION 'COM_ERRO_GRAVACAO'}
    COM_ERRO_GRAVACAO:
      Begin
        ACanvas.Brush.Color := clPurple;
        ACanvas.Font.Color := clWhite;
        If AViewInfo.Selected Then
          ACanvas.Font.Color := clYellow;
      End;
{$ENDREGION}
  End;
end;

procedure TfrmEntImpConsumo.edtCodEveKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, edtCodEve, edtDesEve, nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtCodEve) then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntImpConsumo.edtCodPorKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, nil, Key,
    arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntImpConsumo.FormCreate(Sender: TObject);
begin
  inherited;
  FobjImportacao := TEntImpConsumo.Create(Self);
  cxgArquivosView.DataController.DataSource := FobjImportacao.dtsTabela;
  dbmLOGIMP.DataSource := FobjImportacao.dtsTabela;
  pReiniciaProcesso(True);
end;

procedure TfrmEntImpConsumo.FormDestroy(Sender: TObject);
begin
  inherited;
  fAtuCfgSis('XMLCSM', dirPasta.edtDirectory.Text);
  FreeAndNil(FobjImportacao);
end;

procedure TfrmEntImpConsumo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = vkEscape) and (Not pnlTail.Enabled) And (fMensagem('', 'Deseja abandonar esta tarefa?', ['&SIM', '&NÃO'], 1) = 1) Then
  Begin
    pReiniciaProcesso(True);
  End;
  If Key = VK_F6 Then
    btnMarcaTodos.Click;
  If Key = VK_F7 Then
    btnDesmarcaTodos.Click;
end;

function TfrmEntImpConsumo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);
  if not Result then
    Exit;

  if (Sender = edtCodPor) then
    Result := ValidaPortador
  else if (Sender = fraPlanoDeContasPga.MskCodCta) then
    Result := ValidaPlanoContas
  else if (Sender = mskDtaEnt) then
    Result := ValidaDataEntrada
  else if (Sender = mskConPag) then
    Result := ValidaCondicaoPagamento(blnBuscaPorChave)
  else if (Sender = edtCodEve) then
    Result := ValidaCentroCusto
  else if (Sender = dirPasta) then
    Result := ValidaDiretorioXML(blnBuscaPorChave);

  if not Result then
  begin
    blnMudarFoco := False;
    pSetFocus(Sender);
  end;
end;

function TfrmEntImpConsumo.ValidaDataEntrada: Boolean;
begin
  Result := False;
  if not mskDtaEnt.Enabled then
    Exit(True);

  if fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text)) then
  begin
    fMensagem('', 'A Data de Entrada deve ser informada !', ['&OK']);
    Exit;
  end;
  Result := True;
end;

function TfrmEntImpConsumo.ValidaCondicaoPagamento(blnBuscaChave
  : Boolean): Boolean;
begin
  Result := True;
  if mskConPag.Enabled and chkGravaFinanceiro.Checked then
    If chkCndPag.Checked Then
      Result := fValidaCondPagamento(blnBuscaChave);
end;

function TfrmEntImpConsumo.ValidaCentroCusto: Boolean;
begin
  Result := False;
  if not fEmptyStr(edtCodEve.Text) then
  begin
    edtDesEve.Text := fRetNomEvento(edtCodEve.Text);
    if fEmptyStr(edtDesEve.Text) then
    begin
      fMensagem('ATENÇÃO!',
        'Esse Centro de Custos não está cadastrado!', ['&Ok']);
      Exit;
    end;

    if (fRetTipoEvento(edtCodEve.Text) = 'R') then
    begin
      fMensagem('ATENÇÃO',
        'Esse Centro de Custos pode ser aplicado somente às contas a receber!',
        ['&OK']);
      Exit;
    end;

    Result := True;
  end
  else
  begin
    if (fCfgSis('CTPOBE', varBoolean)) and chkGravaFinanceiro.Checked then
    begin
      fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&Ok']);
      Exit;
    end;
    edtDesEve.Clear;
    Result := True;
  end;
end;

function TfrmEntImpConsumo.ValidaPortador: Boolean;
begin
  Result := False;
  if not edtCodPor.Enabled then
    Exit(True);

  if fEmptyStr(edtCodPor.Text) then
  begin
    fMensagem('', 'O código do portador deve ser informado!', ['&OK']);
    Exit;
  end;

  edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
  if fEmptyStr(edtNomPor.Text) then
  begin
    fMensagem('', 'Código do Portador incorreto!', ['&OK']);
    Exit;
  end;

  if not fEmpresaTemAcessoPortador(edtCodPor.Text) then
  begin
    fMensagem('ATENÇÃO!',
      'Empresa sem acesso para utilizar este portador.', ['&Ok']);
    Exit;
  end;

  if (fCfgSisL('XMLCSM') <> '') and (dirPasta.edtDirectory.Text = '') then
    dirPasta.edtDirectory.Text := fCfgSisL('XMLCSM');

  Result := True;
end;

function TfrmEntImpConsumo.ValidaPlanoContas: Boolean;
begin
  Result := False;
  if not fraPlanoDeContasPga.MskCodCta.Enabled then
    Exit(True);

  if fEmptyStr(fraPlanoDeContasPga.MskCodCta.Text) then
  begin
    fMensagem('',
      'O código do Plano de Contas a Pagar deve ser informado!', ['&OK']);
    Exit;
  end;

  If Not fValidaLinhaGrupoCadCta(fraPlanoDeContasPga.mskCodCta.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Plano de Contas não permitido!', ['&Ok']);
    Exit;
  end;

  fraPlanoDeContasPga.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasPga.MskCodCta.Text);
  if fEmptyStr(fraPlanoDeContasPga.edtDesCta.Text) then
  begin
    fMensagem('', 'Código do Plano de Contas a Pagar incorreto!', ['&OK']);
    Exit;
  end;

  Result := PlanoDeContasAtivo(fraPlanoDeContasPga.MskCodCta.Text, True);

  if Result then
    fAtuCfgSis('XMLCSM', dirPasta.edtDirectory.Text);
end;

function TfrmEntImpConsumo.ValidaDiretorioXML(blnBuscaChave: Boolean): Boolean;
begin
  Result := False;

  if fEmptyStr(dirPasta.edtDirectory.Text) then
  begin
    fMensagem('', 'A pasta deve ser informada!', ['&OK']);
    Exit;
  end;

  if not DirectoryExists(dirPasta.edtDirectory.Text) then
  begin
    fMensagem('', 'Pasta não encontrada!', ['&OK']);
    Exit;
  end;

  if blnBuscaChave and fVerificaCampos then
  begin
    if not Assigned(FobjImportacao) then
      Exit;

    pHabilitaForm(False);
    try
      FobjImportacao.fCodigoEmpresa(VS_strCodEmp)
        .fCodigoOperador(strLoginUsuarioLogado).fCodigoPortador(edtCodPor.Text)
        .fCodigoEvento(edtCodEve.Text)
        .fCodigoConta(fraPlanoDeContasPga.MskCodCta.Text)
        .fCondicaoPagamento(mskConPag.Text)
        .fImportarSemVencimento(chkCndPag.Checked)
        .fDataEntrada(StrToDateDef(mskDtaEnt.Text, Date))
        .fGerarContasAPagar(chkGravaFinanceiro.Checked);

      pProcesso('Carregando xml', 'TfrmEntImpConsumo.ValidaDiretorioXML',
        fXMLToDataSet);
    finally
      pHabilitaForm(True);
      pReiniciaProcesso(False);
    end;
  end;

  fAtuCfgSis('XMLCSM', dirPasta.edtDirectory.Text);
  Result := True;
end;

function TfrmEntImpConsumo.fXMLToDataSet(AprgProgresso: TcxProgressBar)
  : Boolean;
Begin
  Result := True;
    pHabilitaForm(False);
    If fVerificaCampos Then
      FobjImportacao.fCarregarArquivosDiretorio(dirPasta.edtDirectory.Text,
      AprgProgresso);
  pHabilitaForm(True);
end;

function TfrmEntImpConsumo.fValidaCondPagamento(blnBuscaPorChave
  : Boolean): Boolean;
var
  strConPag: String;
begin
  Result := False;

  if fEmptyStr(fTiraCaracEspeciais(mskConPag.Text)) then
  begin
    pMensagemOk('A condição de pagamento deve ser preenchida!');
    Exit;
  end;

  if StrToIntDef(Copy(mskConPag.Text, 1, 2), 0) > 24 then
  begin
    pMensagemOk('Não é permitido mais que 24 parcelas!');
    Exit;
  end;

  if not fValidaCndPag(mskConPag.Text, strConPag, StrToDateDef(mskDtaEnt.Text,
    Date)) then
  begin
    pMensagemOk('Essa condição de pagamento não é válida!');
    Exit;
  end;

  mskConPag.Text := strConPag;
  Result := not fEmptyStr(strConPag);
end;

procedure TfrmEntImpConsumo.pReiniciaProcesso(blnHabilita: Boolean);
begin
  If blnHabilita Then
  Begin
    chkCndPag.Checked := False;
    edtCodPor.Clear;
    edtNomPor.Clear;
    edtCodEve.Clear;
    edtDesEve.Clear;
    fraPlanoDeContasPga.edtDesCta.Clear;
    fraPlanoDeContasPga.MskCodCta.Clear;
    mskDtaEnt.Clear;
    mskConPag.Clear;
    mskConPag.Enabled := False;
    dirPasta.edtDirectory.Text := fCfgSisL('XMLCSM');
    If Assigned(FobjImportacao) Then
      FobjImportacao.qryTabela.EmptyDataSet;
    pSetFocus(edtCodPor);
    chkGravaFinanceiro.Checked := True;
    mskDtaEnt.Text :=FormatDateTime('dd/mm/yyyy', fNow);
  End;
  pnlTail.Enabled := blnHabilita;
  chkGravaFinanceiro.Enabled := blnHabilita;
  edtCodPor.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  edtCodEve.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  fraPlanoDeContasPga.MskCodCta.Enabled := blnHabilita and
    chkGravaFinanceiro.Checked;
  mskDtaEnt.Enabled := blnHabilita;
  dirPasta.Enabled := blnHabilita;

  chkCndPag.Enabled := blnHabilita;
  mskConPag.Enabled := blnHabilita
    And chkGravaFinanceiro.Checked
    And chkCndPag.Checked;
  cxgArquivosCNDPAG.Options.Editing := chkGravaFinanceiro.Checked;
  FobjImportacao.qryTabela.Filtered := False;
end;

function TfrmEntImpConsumo.pProcesso(AstrTitulo: String;
  AstrNomeProcesso: String; AobjFuncao: TReferenceFunctionProgresso): Boolean;
Begin
  Result := TfrmGravando.fExecutarModalA(AobjFuncao, AstrTitulo, '');
End;

end.
