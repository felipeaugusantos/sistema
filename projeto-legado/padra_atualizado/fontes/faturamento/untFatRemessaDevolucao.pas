unit untFatRemessaDevolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass, untGravando,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Shared.Functions.DataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, untTypesSistema,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, Uni,
  Datasnap.DBClient, UniClientDataSet, untFatRemessaDevolucaoClasse, StrUtils,
  cxProgressBar,

  Fulfillment.Funcoes;

type
  TfrmFatRemessaDevolucao = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    pnlOperacao: TPanel;
    lblOperacao: TLabel;
    pnlInfoRemessa: TPanel;
    lblLegendaDelRemessa: TLabel;
    pnlCabecalho: TPanel;
    lblNumeroRemessa: TLabel;
    lblBarraChave: TLabel;
    edtNumeroRemessa: TEditFocus;
    EdtBarraChave: TEditFocus;
    btnConsultar: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    cxgRemessa: TcxGridCitel;
    cxgRemessaDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgRemessaLevel: TcxGridLevel;
    btnConfirma: TBitBtnLocked;
    BtnImprimir: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    cdsRemessa: TUniClientDataSet;
    cdsRemessaDTAENT: TDateField;
    cdsRemessaHORENT: TTimeField;
    cdsRemessaNUMDOC: TStringField;
    cdsRemessaESPDOC: TStringField;
    cdsRemessaCODEMP: TStringField;
    cdsRemessaCODCLI: TStringField;
    cdsRemessaNOMCLI: TStringField;
    cdsRemessaACESSO: TStringField;
    dtsRemessa: TDataSource;
    cxgRemessaDTAENT: TcxGridDBColumn;
    cxgRemessaHORENT: TcxGridDBColumn;
    cxgRemessaNUMDOC: TcxGridDBColumn;
    cxgRemessaESPDOC: TcxGridDBColumn;
    cxgRemessaCODEMP: TcxGridDBColumn;
    cxgRemessaCODCLI: TcxGridDBColumn;
    cxgRemessaNOMCLI: TcxGridDBColumn;
    cxgRemessaACESSO: TcxGridDBColumn;
    cdsRemessaAUTINC: TStringField;
    rdgOperacao: TRadioGroup;
    lblInformacaoRemessa: TLabel;
    btnNovaRemessa: TBitBtnLocked;
    btnDocumentosPendentes: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure EdtBarraChaveKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure cxgRemessaDBTableViewCitelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtNumeroRemessaExit(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure edtNumeroRemessaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnImprimirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNovaRemessaClick(Sender: TObject);
    procedure btnDocumentosPendentesClick(Sender: TObject);
  private
    { Private declarations }
    FObjRemessaDevolucao: TRemessaDevolucao;
    FCarregouRemessa: Boolean;
    FTipOpe: String;
    FNumeroRemessaCarregada: String;
    procedure pIncluirDocumentoGrid(AChaveAcesso: String);
    procedure pLiberarTodosDocumentos;
    procedure pGerarRemessa(ATipoOperacao: TTipoOperacaoRemessa; Var ANumRemessa: String);
    procedure pEfetivarOperacao;
    procedure pCarregaDocumento;
    procedure pAtivaInativaTela(AAtiva: Boolean = False);
    procedure pCarregaRemessa(ANumRemessa: String);
    procedure pCarregaTransferencia(ANumRemessa: String);
    procedure pCarregaOutrasSaidas(ANumRemessa: String);
    procedure pCarregaColetor(ANumRemessa: String);
    procedure pCancelarOperacao;
    procedure pTravaDocumentosCarregados;
    function fCarregouRemessaTipoDev: Boolean;
    procedure pPrepararNovaRemessa;
    function fVerificaNotaFulfillment_GeraPedidoReserva(AChaveAcesso: String): Boolean;
    function fGeraPedidoReservaEstoqueParaEnderecamentoFulfillment(pgbProgresso: TcxProgressBar): Boolean;
    function fChavesSelecionadas: String;
  public
    { Public declarations }
  end;


implementation

uses
  untFuncoesSimples, untFatVendas, untConsultas, untFatDocsPendentesRemessaDevolucao;


{$R *.dfm}

procedure TfrmFatRemessaDevolucao.btnCancelarClick(Sender: TObject);
begin
  inherited;

  if not btnCancelar.Enabled then
    Exit;

  if not btnCancelar.Visible then
    Exit;

  if fMensagem('ATENÇÃO!', 'Deseja realmente cancelar a remessa gerada?', ['&Sim', '&Não'], 2) = 2 then
    Exit;

  TfrmGravando.fExecutarModal(pCancelarOperacao, 'Aguarde, Cancelando TL e excluindo lotes gerados...', '');
  FCarregouRemessa := False;
  FTipOpe := EmptyStr;
  FNumeroRemessaCarregada := EmptyStr;
end;

procedure TfrmFatRemessaDevolucao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if not btnConfirma.Enabled then
    Exit;

  if not btnConfirma.Visible then
    Exit;

  if (cdsRemessa.RecordCount <= 0) And (FCarregouRemessa)  and (rdgOperacao.Items.Strings[0] = 'Alterar Remessa') then
  begin
    if fMensagem('ATENÇÃO!', 'Deseja realmente cancelar a remessa gerada?', ['&Sim', '&Não'], 2) = 2 then
      Exit;

    TfrmGravando.fExecutarModal(pCancelarOperacao, 'Aguarde, Cancelando TL e excluindo lotes gerados...', '');
    FCarregouRemessa := False;
    FTipOpe := EmptyStr;
    FNumeroRemessaCarregada := EmptyStr;
  end
  else
  begin
    TfrmGravando.fExecutarModal(pEfetivarOperacao, 'Aguarde, Incluindo Remessa...', '');
    FCarregouRemessa := False;
    FTipOpe := EmptyStr;
    FNumeroRemessaCarregada := EmptyStr;
  end;
end;

procedure TfrmFatRemessaDevolucao.btnConsultarClick(Sender: TObject);
begin
  inherited;

  if not btnConsultar.Enabled then
    Exit;

  if not btnConsultar.Visible then
    Exit;

  if fCarregouRemessaTipoDev then
  begin
    if fMensagem('ATENÇÃO!', 'Deseja salvar a remessa atual?', ['&Sim', '&Não']) = 1 then
      btnConfirma.Click;
  end;

  TfrmGravando.fExecutarModal(pCarregaDocumento, 'Aguarde, Incluindo devoluções no grid...', '');
end;

function TfrmFatRemessaDevolucao.fChavesSelecionadas: String;
  Var
    cdsDados : TUniClientDataSet;
begin
  Result := EmptyStr;

  If cdsRemessa.IsEmpty Then
    Exit;

  cdsDados := TUniClientDataSet.Create(Self);
  Try
    pCloneDataSet(cdsDados, cdsRemessa);

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      Result := Result + cdsRemessaACESSO.AsString + '_';

      cdsDados.Next;
    End;
  Finally
    FreeAndNil(cdsDados);
  End;
end;

procedure TfrmFatRemessaDevolucao.btnDocumentosPendentesClick(Sender: TObject);
  Var
    frmFatDocsPendentesRemessaDevolucao : TfrmFatDocsPendentesRemessaDevolucao;
begin
  inherited;

  pCriarFormularios(TfrmFatDocsPendentesRemessaDevolucao, frmFatDocsPendentesRemessaDevolucao);
  Try
    frmFatDocsPendentesRemessaDevolucao.strChavesJaInclusas := fChavesSelecionadas;
    frmFatDocsPendentesRemessaDevolucao.ShowModal;
  Finally
    pFreeAndNil(frmFatDocsPendentesRemessaDevolucao);
  End;
end;

procedure TfrmFatRemessaDevolucao.BtnImprimirClick(Sender: TObject);
begin
  inherited;

  if not BtnImprimir.Enabled then
    Exit;

  if not BtnImprimir.Visible then
    Exit;

  FObjRemessaDevolucao.pImprimeRemessaDevolucao(edtNumeroRemessa.Text);

end;

procedure TfrmFatRemessaDevolucao.btnIncluirClick(Sender: TObject);
begin
  inherited;

  if not btnIncluir.Enabled then
    Exit;

  if not btnIncluir.Visible then
    Exit;

  pIncluirDocumentoGrid(EdtBarraChave.Text);
end;

procedure TfrmFatRemessaDevolucao.btnNovaRemessaClick(Sender: TObject);
begin
  inherited;

  if not btnNovaRemessa.Visible then
    Exit;

  if not btnNovaRemessa.Enabled then
    Exit;

  pPrepararNovaRemessa;
end;

procedure TfrmFatRemessaDevolucao.btnSairClick(Sender: TObject);
begin
  Close;
  inherited;

end;

procedure TfrmFatRemessaDevolucao.cxgRemessaDBTableViewCitelKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  LDocumento: String;
begin
  inherited;
  if key = VK_DELETE then
  begin
    if cdsRemessa.RecordCount <= 0 then
      Exit;

    if cdsRemessa.RecNo <= 0 then
      Exit;

    if not cxgRemessa.Enabled then
      Exit;

    LDocumento := Concat(cdsRemessaNUMDOC.AsString,'-',cdsRemessaESPDOC.AsString,'-',cdsRemessaCODEMP.AsString);

    if fMensagem('ATENÇÃO!', 'Deseja realmente excluir o documento '+LDocumento+' do grid?', ['&Sim', '&Não'], 2) = 2 then
      Exit;

    fLock_Unlock('REMDEV'+cdsRemessaNUMDOC.AsString+cdsRemessaESPDOC.AsString+cdsRemessaCODEMP.AsString, False);
    cdsRemessa.Delete;
  end;
end;

procedure TfrmFatRemessaDevolucao.EdtBarraChaveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = #13) Then
    pIncluirDocumentoGrid(EdtBarraChave.Text);

  If (Not CharInSet(Key, ['0'..'9', #3, #8, #9, #16, #22, #24, #26])) Then
  Begin
    Key := #0;
  End;
end;

procedure TfrmFatRemessaDevolucao.edtNumeroRemessaExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtNumeroRemessa.Text) then
    Exit;

  edtNumeroRemessa.Text := fStrZero(edtNumeroRemessa.Text, edtNumeroRemessa.TamCampo);
end;

procedure TfrmFatRemessaDevolucao.edtNumeroRemessaKeyPress(Sender: TObject;
  var Key: Char);
var
  qryConGen: TUniQuery;
  arrSel   : TConsultasArray;
begin
  inherited;

  qryConGen := fCriaQuery(Self);

  Try
    If fPesqRemessaDevolucao(Self, edtNumeroRemessa, qryConGen, Key, arrSel) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;

  Finally
    FreeAndNil(qryConGen);
  End;
end;

function TfrmFatRemessaDevolucao.fCarregouRemessaTipoDev: Boolean;
begin
  Result := False;

  if not FCarregouRemessa then
    Exit;

  if fEmptyStr(FNumeroRemessaCarregada) then
    Exit;

  if FTipOpe <> 'REM_DEV' then
    Exit;

  Result := True;
end;

procedure TfrmFatRemessaDevolucao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if cdsRemessa.RecordCount > 0 then
  begin
    if fMensagem('ATENÇÃO!', 'Deseja realmente cancelar a operação?', ['&Sim', '&Não'], 2) = 2 then
      Abort;

    pLiberarTodosDocumentos;
  end;

  inherited;

end;

procedure TfrmFatRemessaDevolucao.FormCreate(Sender: TObject);
begin
  inherited;
  BtnImprimir.Enabled := False;
  btnCancelar.Visible := False;
  cdsRemessa.CreateDataSet;
  FObjRemessaDevolucao := TRemessaDevolucao.Create;
  FCarregouRemessa := False;
  FTipOpe := EmptyStr;
  FNumeroRemessaCarregada := EmptyStr;
  lblInformacaoRemessa.Caption := EmptyStr;
end;

procedure TfrmFatRemessaDevolucao.FormDestroy(Sender: TObject);
begin
  FObjRemessaDevolucao.Free;
  inherited;

end;

procedure TfrmFatRemessaDevolucao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case key of
    VK_ESCAPE: Close;
    VK_F10: btnConfirma.Click;
    VK_F7: BtnImprimir.Click;
    VK_F6: btnCancelar.Click;
    VK_F8: btnNovaRemessa.Click;
    VK_F9: btnDocumentosPendentes.Click;
  end;
end;

procedure TfrmFatRemessaDevolucao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumeroRemessa);
end;

procedure TfrmFatRemessaDevolucao.pCancelarOperacao;
begin
  if FObjRemessaDevolucao.fCancelaRemessa(edtNumeroRemessa.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Remessa Nº '+edtNumeroRemessa.Text+' cancelada com sucesso!', ['&Ok']);
    pAtivaInativaTela(True);
    pLiberarTodosDocumentos;
    pAtivaInativaTela(True);
  end;

  rdgOperacao.Items.Strings[0] := 'Gerar Remessa';
end;

procedure TfrmFatRemessaDevolucao.pCarregaColetor(ANumRemessa: String);
var
  LQryColetor: TUniQuery;
begin
  LQryColetor := fCriaQuery;

  try
    LQryColetor.Close;
    LQryColetor.SQL.Clear;
    LQryColetor.SQL.Add('SELECT RMV_LIBCOL ');
    LQryColetor.SQL.Add('FROM REMDEV');
    LQryColetor.SQL.Add('WHERE RMV_TIPOPE = "REM_COL" ');
    LQryColetor.SQL.Add('AND RMV_LIBCOL = "S" ');
    LQryColetor.SQL.Add('AND RMV_NUMREM = :NUMREM');
    LQryColetor.SQL.Add('AND RMV_EMPREM = :EMPREM');
    LQryColetor.ParamByName('NUMREM').AsString := ANumRemessa;
    LQryColetor.ParamByName('EMPREM').AsString := VS_strCodEmp;
    LQryColetor.Open;

    if LQryColetor.IsEmpty then
      Exit;

    rdgOperacao.ItemIndex := 3;
    pAtivaInativaTela;

    lblInformacaoRemessa.Caption := 'Remessa já liberada para guardar no coletor.';
    btnCancelar.Caption := '[ F6 ] Cancelar Liberação para Coletor';
    btnCancelar.Visible := True;
    btnCancelar.Width := 206;
  finally
    FreeAndNil(LQryColetor);
  end;
end;

procedure TfrmFatRemessaDevolucao.pCarregaDocumento;
begin
  if fEmptyStr(edtNumeroRemessa.Text) then
    Exit;

  if FObjRemessaDevolucao.fCarregaRemessa(cdsRemessa, edtNumeroRemessa.Text) then
  begin
    FCarregouRemessa := True;
    FNumeroRemessaCarregada := edtNumeroRemessa.Text;
    BtnImprimir.Enabled := True;
    pTravaDocumentosCarregados;
    FTipOpe := fCampoTabela('RMV_TIPOPE', 'REMDEV', ['RMV_NUMDOC','RMV_ESPDOC','RMV_CODEMP'], [cdsRemessaNUMDOC.AsString, cdsRemessaESPDOC.AsString, cdsRemessaCODEMP.AsString]);

    case AnsiIndexStr(UpperCase(FTipOpe), ['REM_DEV','REM_TRA','REM_OUF','REM_COL']) of
      0:pCarregaRemessa(edtNumeroRemessa.Text);
      1:pCarregaTransferencia(edtNumeroRemessa.Text);
      2:pCarregaOutrasSaidas(edtNumeroRemessa.Text);
      3:pCarregaColetor(edtNumeroRemessa.Text);
    end;
  end
  else
  begin
    FCarregouRemessa := False;
    FTipOpe := EmptyStr;
    FNumeroRemessaCarregada := EmptyStr;
    BtnImprimir.Enabled := False;
    edtNumeroRemessa.Clear;
  end;
end;

procedure TfrmFatRemessaDevolucao.pCarregaOutrasSaidas(ANumRemessa: String);
var
  LQryOutrasSaidas: TUniQuery;
  LAutInc: String;
  LNumDoc: String;
  LEspDoc: String;
  LCodEmp: String;
begin
  LQryOutrasSaidas := fCriaQuery;

  try
    LQryOutrasSaidas.Close;
    LQryOutrasSaidas.SQL.Clear;
    LQryOutrasSaidas.SQL.Add('SELECT RMV_AUTOUF ');
    LQryOutrasSaidas.SQL.Add('FROM REMDEV');
    LQryOutrasSaidas.SQL.Add('WHERE RMV_TIPOPE = "REM_OUF" ');
    LQryOutrasSaidas.SQL.Add('AND RMV_NUMREM = :NUMREM');
    LQryOutrasSaidas.SQL.Add('AND RMV_EMPREM = :EMPREM');
    LQryOutrasSaidas.ParamByName('NUMREM').AsString := ANumRemessa;
    LQryOutrasSaidas.ParamByName('EMPREM').AsString := VS_strCodEmp;
    LQryOutrasSaidas.Open;

    if LQryOutrasSaidas.IsEmpty then
      Exit;

    rdgOperacao.ItemIndex := 2;
    pAtivaInativaTela;

    while not LQryOutrasSaidas.Eof do
    begin
      if not fEmptyStr(LQryOutrasSaidas.FieldByName('RMV_AUTOUF').AsString) then
      begin
        LAutInc := LQryOutrasSaidas.FieldByName('RMV_AUTOUF').AsString;
        LNumDoc := fCampoTabela('DET_NUMDOC', 'MOVDET', ['AUTOINCREM'], [LAutInc], False);
        LEspDoc := fCampoTabela('DET_ESPDOC', 'MOVDET', ['AUTOINCREM'], [LAutInc], False);
        LCodEmp := fCampoTabela('DET_CODEMP', 'MOVDET', ['AUTOINCREM'], [LAutInc], False);
        lblInformacaoRemessa.Caption := 'Documento Vinculado: '+LNumDoc+'-'+LEspDoc+'-'+LCodEmp+'';
        Exit;
      end;

      LQryOutrasSaidas.Next;
    end;

    lblInformacaoRemessa.Caption := 'Acesse a rotina de outras saídas para fornecedor para emitir o documento ou faça o cancelamento da remessa.';
    btnCancelar.Visible := True;
  finally
    FreeAndNil(LQryOutrasSaidas);
  end;
end;

procedure TfrmFatRemessaDevolucao.pCarregaRemessa(ANumRemessa: String);
var
  LQryRemessa: TUniQuery;
begin
  LQryRemessa := fCriaQuery;

  try
    LQryRemessa.Close;
    LQryRemessa.SQL.Clear;
    LQryRemessa.SQL.Add('SELECT RMV_AUTTRA ');
    LQryRemessa.SQL.Add('FROM REMDEV');
    LQryRemessa.SQL.Add('WHERE RMV_TIPOPE = "REM_DEV" ');
    LQryRemessa.SQL.Add('AND RMV_NUMREM = :NUMREM');
    LQryRemessa.SQL.Add('AND RMV_EMPREM = :EMPREM');
    LQryRemessa.ParamByName('NUMREM').AsString := ANumRemessa;
    LQryRemessa.ParamByName('EMPREM').AsString := VS_strCodEmp;
    LQryRemessa.Open;

    if LQryRemessa.IsEmpty then
      Exit;

    rdgOperacao.Items.Strings[0] := 'Alterar Remessa';

    rdgOperacao.ItemIndex := 0;
    pAtivaInativaTela(True);

    btnCancelar.Visible := True;
  finally
    FreeAndNil(LQryRemessa);
  end;
end;

procedure TfrmFatRemessaDevolucao.pCarregaTransferencia(ANumRemessa: String);
var
  LQryTransferencia: TUniQuery;
  LAutInc: String;
  LNumDoc: String;
  LEspDoc: String;
  LCodEmp: String;
begin
  LQryTransferencia := fCriaQuery;

  try
    LQryTransferencia.Close;
    LQryTransferencia.SQL.Clear;
    LQryTransferencia.SQL.Add('SELECT RMV_AUTTRA ');
    LQryTransferencia.SQL.Add('FROM REMDEV');
    LQryTransferencia.SQL.Add('WHERE RMV_TIPOPE = "REM_TRA" ');
    LQryTransferencia.SQL.Add('AND RMV_NUMREM = :NUMREM');
    LQryTransferencia.SQL.Add('AND RMV_EMPREM = :EMPREM');
    LQryTransferencia.ParamByName('NUMREM').AsString := ANumRemessa;
    LQryTransferencia.ParamByName('EMPREM').AsString := VS_strCodEmp;
    LQryTransferencia.Open;

    if LQryTransferencia.IsEmpty then
      Exit;

    rdgOperacao.ItemIndex := 1;
    pAtivaInativaTela;

    while not LQryTransferencia.Eof do
    begin
      if not fEmptyStr(LQryTransferencia.FieldByName('RMV_AUTTRA').AsString) then
      begin
        LAutInc := LQryTransferencia.FieldByName('RMV_AUTTRA').AsString;
        LNumDoc := fCampoTabela('DET_NUMDOC', 'MOVDET', ['AUTOINCREM'], [LAutInc], False);
        LEspDoc := fCampoTabela('DET_ESPDOC', 'MOVDET', ['AUTOINCREM'], [LAutInc], False);
        LCodEmp := fCampoTabela('DET_CODEMP', 'MOVDET', ['AUTOINCREM'], [LAutInc], False);
        lblInformacaoRemessa.Caption := 'Documento Vinculado: '+LNumDoc+'-'+LEspDoc+'-'+LCodEmp+'';
        Exit;
      end;

      LQryTransferencia.Next;
    end;

    lblInformacaoRemessa.Caption := 'Acesse a rotina de transferência de estoque para emitir o documento da remessa ou faça o cancelamento da remessa.';
    btnCancelar.Visible := True;
  finally
    FreeAndNil(LQryTransferencia);
  end;
end;

procedure TfrmFatRemessaDevolucao.pEfetivarOperacao;
Var
  LNumRemessa: String;
begin
  case rdgOperacao.ItemIndex of
    0: pGerarRemessa(toRemessa, LNumRemessa);
    1: begin
         pGerarRemessa(toTransferencia, LNumRemessa);
         FObjRemessaDevolucao.pAbreTransferenciaEstoque(LNumRemessa);
       end;
    2: pGerarRemessa(toOutrasSaidas, LNumRemessa);
    3: pGerarRemessa(toColetor, LNumRemessa);
  end;
end;

function TfrmFatRemessaDevolucao.fVerificaNotaFulfillment_GeraPedidoReserva(AChaveAcesso: String): Boolean;
var
  LNfeImport: String;
begin
  Result := True;

  if FObjRemessaDevolucao.fTemPedidoDeEnderecamentoVinculado(AChaveAcesso) then
    Exit;

  if not FObjRemessaDevolucao.fVerificaNotaFulfillment(AChaveAcesso, LNfeImport) then
    Exit;

  if LNfeImport <> 'S' then
  begin
    fMensagem('ATENÇÃO!', 'A chave de acesso informada pertence ao Fulfillment e ainda não foi importada e por isso, '+
                          'não pode ser incluída em uma remessa de devolução. Fale com o operador responsável e após a '+
                          'importação da nota, tente novamente.', ['&Ok']);
    Exit(False);
  end;

  if ExisteDocumentoReferenciadoFulFillment(AChaveAcesso) then
  begin
    fMensagem('ATENÇÃO!', 'A chave de acesso informada pertence ao Fulfillment e possui outro xml emitido pela empresa '+
                          'externa vinculado a ela. Dessa forma, a nota não pode ser incluída em uma remessa de devolução. '+
                          'Por favor, entre em contato com a Citel para análise da movimentação de estoque desse produto.', ['&Ok']);
    Exit(False);
  end;

  Result := fChamaTelaGravando(fGeraPedidoReservaEstoqueParaEnderecamentoFulfillment, 'Aguarde, gerando pedido de endereçamento...');
end;

function TfrmFatRemessaDevolucao.fGeraPedidoReservaEstoqueParaEnderecamentoFulfillment(pgbProgresso: TcxProgressBar): Boolean;
var
  LMensagem: String;
begin
  pgbProgresso.Visible := False;

  Result := FObjRemessaDevolucao.fGeraPedidoReservaEstoqueParaEnderecamentoFulfillment(EdtBarraChave.Text, LMensagem);

  if not Result then
    fMensagem('ATENÇÃO!', 'Não foi possível gerar o pedido de endereçamento. Motivo: '+ LMensagem, ['&Ok']);
end;

procedure TfrmFatRemessaDevolucao.pGerarRemessa(ATipoOperacao: TTipoOperacaoRemessa; Var ANumRemessa: String);
var
  LAutInc: String;
  LAlterar: Boolean;
begin
  ANumRemessa := EmptyStr;

  if cdsRemessa.RecordCount <= 0 then
    Exit;

  if (FCarregouRemessa)  and (rdgOperacao.Items.Strings[0] <> 'Alterar Remessa') then
    Exit;

  cdsRemessa.DisableControls;

  try
    cdsRemessa.First;
    LAutInc := EmptyStr;

    while not cdsRemessa.Eof do
    begin
      pIncrementaListaStr(cdsRemessaAUTINC.AsString, LAutInc, True);
      cdsRemessa.Next;
    end;
  finally
    cdsRemessa.First;
    cdsRemessa.EnableControls;
  end;

  if fEmptyStr(LAutInc) then
    Exit;

  LAlterar := False;

  if rdgOperacao.Items.Strings[0] = 'Alterar Remessa' then
  begin
    ANumRemessa := FNumeroRemessaCarregada;
    LAlterar := True;
  end;

  if FObjRemessaDevolucao.fGerarRemessa(LAutInc, ANumRemessa, ATipoOperacao, LAlterar) then
  begin
    fMensagem('ATENÇÃO!', 'Remessa Nº '+ANumRemessa+' '+IIF(LAlterar, 'alterada', 'gerada')+' com sucesso!', ['&Ok']);
    pLiberarTodosDocumentos;
    cdsRemessa.EmptyDataSet;
    pAtivaInativaTela(True);
  end;

  rdgOperacao.Items.Strings[0] := 'Gerar Remessa';
end;

procedure TfrmFatRemessaDevolucao.pAtivaInativaTela(AAtiva: Boolean = False);
begin
  EdtBarraChave.Enabled := AAtiva;
  btnIncluir.Enabled := AAtiva;
  cxgRemessa.Enabled := AAtiva;
  rdgOperacao.Enabled := AAtiva;
  btnConfirma.Enabled := AAtiva;
  BtnImprimir.Enabled := Not(AAtiva);

  if AAtiva then
  begin
    btnCancelar.Visible := False;

    if not fCarregouRemessaTipoDev then
      edtNumeroRemessa.Clear;

    lblInformacaoRemessa.Caption := EmptyStr;
  end;
end;

procedure TfrmFatRemessaDevolucao.pIncluirDocumentoGrid(AChaveAcesso: String);
var
  LAutInc: String;
  LObjDocumento: IMyCampoTabela;
  LDocumento: STring;
begin
  if fEmptyStr(AChaveAcesso) then
    Exit;

  try
    if (FCarregouRemessa) and (rdgOperacao.Items.Strings[0] <> 'Alterar Remessa') then
      Exit;

    if Length(AChaveAcesso) <> 44 then
    begin
      fMensagem('ATENÇÃO!', 'Chave de acesso inválida!', ['&Ok']);
      Exit;
    end;

    if cdsRemessa.Locate('ACESSO', AChaveAcesso, []) then
    begin
      LDocumento := Concat(cdsRemessaNUMDOC.AsString,'-',cdsRemessaESPDOC.AsString,'-',cdsRemessaCODEMP.AsString);
      fMensagem('ATENÇÃO!', 'O documento '+LDocumento+' já foi inserido no grid.', ['&Ok']);
      Exit;
    end;

    if not FObjRemessaDevolucao.fValidaChaveAcesso(AChaveAcesso, LAutInc) then
      Exit;

    if not fVerificaNotaFulfillment_GeraPedidoReserva(AChaveAcesso) then
      Exit;

    if not FObjRemessaDevolucao.fTemPedidoDeEnderecamentoVinculado(AChaveAcesso) then
    begin
      if FObjRemessaDevolucao.fTemPedidoDeEnderecamentoVinculado(AChaveAcesso, True) then
        fMensagem('ATENÇÃO!', 'O pedido de endereçamento dessa nota fiscal já foi endereçado.', ['&Ok'])
      else
        fMensagem('ATENÇÃO!', 'Nota fiscal sem pedido de endereçamento vinculado. Não é possível inserir na rotina de remessa. ' +sLineBreak+
                              'Verifique a origem dessa nota e fale com o operador responsável.', ['&Ok']);

      Exit;
    end;

    LObjDocumento := fCampoTabela(['GER_DTAENT','GER_HORENT','GER_NUMDOC','GER_ESPDOC','GER_CODEMP','GER_CODCLI'], 'MOVGER', ['AUTOINCREM'], [LAutInc], False);

    if not fLock_Unlock('REMDEV'+LObjDocumento.FieldByName('GER_NUMDOC')+LObjDocumento.FieldByName('GER_ESPDOC')+LObjDocumento.FieldByName('GER_CODEMP'), True, False) then
    begin
      fMensagem('ATENÇÃO!', 'O documento sendo usado por outra estação.', ['&Ok']);
      Exit;
    end;

    cdsRemessa.Append;
    cdsRemessaDTAENT.AsDateTime := LObjDocumento.FieldByName('GER_DTAENT');
    cdsRemessaHORENT.AsDateTime := LObjDocumento.FieldByName('GER_HORENT');
    cdsRemessaNUMDOC.AsString := LObjDocumento.FieldByName('GER_NUMDOC');
    cdsRemessaESPDOC.AsString := LObjDocumento.FieldByName('GER_ESPDOC');
    cdsRemessaCODEMP.AsString := LObjDocumento.FieldByName('GER_CODEMP');
    cdsRemessaCODCLI.AsString := LObjDocumento.FieldByName('GER_CODCLI');
    cdsRemessaNOMCLI.AsString := fRetNomCliente(LObjDocumento.FieldByName('GER_CODCLI'));
    cdsRemessaACESSO.AsString := AChaveAcesso;
    cdsRemessaAUTINC.AsString := LAutInc;
    cdsRemessa.Post;

  finally
    EdtBarraChave.Clear;
    pSetFocus(EdtBarraChave);
  end;
end;

procedure TfrmFatRemessaDevolucao.pLiberarTodosDocumentos;
begin
  if cdsRemessa.RecordCount <= 0 then
    Exit;

  cdsRemessa.DisableControls;

  try
    cdsRemessa.First;

    while not cdsRemessa.Eof do
    begin
      fLock_Unlock('REMDEV'+cdsRemessaNUMDOC.AsString+cdsRemessaESPDOC.AsString+cdsRemessaCODEMP.AsString, False);
      cdsRemessa.Next;
    end;
  finally
    cdsRemessa.First;
    cdsRemessa.EnableControls;
  end;
end;

procedure TfrmFatRemessaDevolucao.pPrepararNovaRemessa;
begin
  if fCarregouRemessaTipoDev then
  begin
    if fMensagem('ATENÇÃO!', 'Deseja salvar a remessa atual?', ['&Sim', '&Não']) = 1 then
      btnConfirma.Click;
  end;

  pLiberarTodosDocumentos;
  cdsRemessa.EmptyDataSet;
  pAtivaInativaTela(True);
  edtNumeroRemessa.Clear;
  FCarregouRemessa := False;
  FNumeroRemessaCarregada := EmptyStr;
  FTipOpe := EmptyStr;
end;

procedure TfrmFatRemessaDevolucao.pTravaDocumentosCarregados;
var
  LQryTrava: TUniQuery;
  LChave: String;
begin
  if fEmptyStr(edtNumeroRemessa.Text) then
    Exit;

  if cdsRemessa.RecordCount <= 0 then
    Exit;

  LQryTrava := fCriaQuery;

  try
    LQryTrava.Close;
    LQryTrava.SQL.Clear;
    LQryTrava.SQL.Add('SELECT RMV_NUMDOC, RMV_ESPDOC, RMV_CODEMP');
    LQryTrava.SQL.Add('FROM REMDEV');
    LQryTrava.SQL.Add('WHERE RMV_NUMREM = :NUMREM');
    LQryTrava.SQL.Add('AND RMV_EMPREM = :EMPREM');
    LQryTrava.SQL.Add('GROUP BY RMV_NUMDOC, RMV_ESPDOC, RMV_CODEMP');

    LQryTrava.ParamByName('NUMREM').AsString := edtNumeroRemessa.Text;
    LQryTrava.ParamByName('EMPREM').AsString := VS_strCodEmp;

    LQryTrava.Open;

    if LQryTrava.IsEmpty then
      Exit;

    while not LQryTrava.Eof do
    begin
      LChave := Concat('REMDEV', LQryTrava.FieldByName('RMV_NUMDOC').AsString, LQryTrava.FieldByName('RMV_ESPDOC').AsString, LQryTrava.FieldByName('RMV_CODEMP').AsString);
      fLock_Unlock(LChave, True, False);
      LQryTrava.Next;
    end;

  finally
    FreeAndNil(LQryTrava);
  end;
end;

end.
