unit untEnvioLocEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  Data.DB, cxDBData, cxButtonEdit, EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, Uni, untFuncFat, untCadLote,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  UniClientDataSet, cadastro.Model.ContratoLocacaoEquipamentos,
  cadastro.Controller.ContratoLocacaoEquipamentos,
  MaskEditFocus, untTLock, untFuncoesLocEqu, untTypesLocEqu, untTypesSistema;

type
  TfrmEnvioLocEqu = class(TfrmPai)
    grpDetalhes: TGroupBox;
    grdItens: TcxGridCitel;
    grdItensView: TcxGridDBTableViewCitel;
    grdItensEQL_CODIGO: TcxGridDBColumn;
    grdItensEQL_DESCRI: TcxGridDBColumn;
    grdItensEQL_NSERIE: TcxGridDBColumn;
    grdItensEQD_STTIPS: TcxGridDBColumn;
    grdItensEQD_DOCENV: TcxGridDBColumn;
    grdItensLvl: TcxGridLevel;
    Panel1: TPanel;
    pnlDadosContrato: TPanel;
    lblCodCli: TLabel;
    lblCodVen: TLabel;
    lblEntCli: TLabel;
    lblQtde: TLabel;
    edtCodCli: TDBEditFocus;
    edtNomCli: TDBEditFocus;
    edtCodVen: TDBEditFocus;
    edtNomVen: TDBEditFocus;
    edtQtde: TDBEditFocus;
    edtLocalizacao: TDBEditFocus;
    pnlCabecalho: TPanel;
    lblNumCon: TLabel;
    edtNumCon: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    dtsContrato: TDataSource;
    dtsEqlDet: TDataSource;
    grdItensEQD_MARDES: TcxGridDBColumn;
    grpAcessorios: TGroupBox;
    cxGridCitelAcessorio: TcxGridCitel;
    cxGridDBTableViewCitelAcessorio: TcxGridDBTableViewCitel;
    cxGridDBColumnEQD_SEQACL: TcxGridDBColumn;
    cxGridDBColumnEQD_DESCR: TcxGridDBColumn;
    cxGridDBColumnEQD_QTDACL: TcxGridDBColumn;
    cxGridDBColumnEQD_STTIPS: TcxGridDBColumn;
    cxGridDBColumnEQD_DOCENV: TcxGridDBColumn;
    cxGridDBColumnEQD_MARDES: TcxGridDBColumn;
    cxGridLevel1Acessorio: TcxGridLevel;
    cdsEqlDet: TUniClientDataSet;
    cdsEqlDetEQD_SEQEQL: TStringField;
    cdsEqlDetEQD_DESCRI: TStringField;
    cdsEqlDetEQD_NSERIE: TStringField;
    cdsEqlDetEQD_STTIPS: TStringField;
    cdsEqlDetEQD_DOCENV: TStringField;
    cdsEqlDetEQD_MARDES: TStringField;
    cdsAcessorios: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    dtsAcessorios: TDataSource;
    cdsAcessoriosEQD_QTDACL: TFloatField;
    cdsEqlDetAUTOINCREM: TStringField;
    cdsAcessoriosAUTOINCREM: TStringField;
    cdsAcessoriosEQD_SEQACL: TStringField;
    grbDuracao: TGroupBox;
    pnlDuracaoDiariaHoras: TPanel;
    lblInicio: TLabel;
    lblTermino: TLabel;
    edtDtaIni: TDBEditFocus;
    edtHorIni: TDBEditFocus;
    edtDtaFin: TDBEditFocus;
    edtHorFin: TDBEditFocus;
    pnlDuracaoMensal: TPanel;
    lblMesIni: TLabel;
    lblMesFin: TLabel;
    edtMesIni: TMaskEditFocus;
    edtMesFin: TMaskEditFocus;
    lblNumPed: TLabel;
    edtNumPed: TEditFocus;
    btnImprimir: TBitBtnLocked;
    cdsEqlDetEQD_QTDEQU: TFloatField;
    grdItensEQD_QTDEQU: TcxGridDBColumn;
    cdsAcessoriosEQA_QTDTOT: TFloatField;
    cxGridDBColumnEQA_QTDTOT: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure edtNumConKeyPress(Sender: TObject; var Key: Char);
    procedure grdItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridDBTableViewCitelAcessorioCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    ObjContrato: TContratoLocacaoEquipamentos;
    ObjItemAcessorio: TAcessorioContratoLocacaoEquipamentos;
    ObjItemEquipamento: TItemContratoLocacaoEquipamentos;
    ObjNota: TNotaFiscalContratoLocacao;
    blnCarregandoItens: Boolean;
    FTipoDocEnvio: String;
    FobjLock: TLock;
    FValida: TValidarContrato;

    function fCarregarContrato(strNumeroContrato: String; strNumPed: String = ''; blnExibirMsg: Boolean = True): Boolean;
    function fPodeMarcarEquipamento(blnMostraMensagem: Boolean): Boolean;
    function fPodeMarcarAcessorio(blnMostraMensagem: Boolean): Boolean;
    function fVerificaSelecionado(): Boolean;
    function fConfirmaEnvioDocumento: Boolean;
    function fSelecionaTipoFaturamento: Boolean;
    function fVerificaProcessoExecucao(const strNomPro: String): Boolean;

    procedure pCarregarEquipamentos;
    procedure pCarregarAcessorios;
    procedure pMarcarEquipamento(blnMarcar: Boolean);
    procedure pMarcarAcessorio(blnMarcar: Boolean);
    procedure pMarcarAcessoriosEquipamento(const strCodEql: String; blnMarcar: Boolean);
    procedure pMarcarTodosEquipamentos(blnMarcar: Boolean);
    procedure pMarcarTodosAcessorios(blnMarcar: Boolean);
    procedure pMarcarTodos(blnMarcar: Boolean);
    procedure pAdicionaEquipamentosNota;
    procedure pAdicionaAcessoriosNota;
    procedure pHabilitarDesabilitarbtnImprimir;
    procedure pForcaLimparAplicacao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untGravando, untFuncoes,
  untFuncFatTypes, untFatTipoFaturamento, untObservacao;

{$R *.dfm}

procedure TfrmEnvioLocEqu.btnConfirmaClick(Sender: TObject);
var
  frmObservacao: TfrmObservacao;
begin
  inherited;

  If Not fVerificaSelecionado() Then
  Begin
    fMensagem('ATENÇÃO', 'Nenhum equipamento selecionado!', ['&Ok']);
    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Confirma a emissão do documento de envio dos equipamentos?', ['&Sim', '&Não']) = 2 Then
    Exit;

  If fConfirmaEnvioDocumento Then
  Begin
    fMensagem('ATENÇÃO', 'Documento de envio emitido com sucesso!', ['&Ok']);
    ObjContrato.pCarregarItensContrato;
    pCarregarEquipamentos;
    pCarregarAcessorios;
    pHabilitarDesabilitarbtnImprimir;
  End
  Else
  If Not fEmptyStr(ObjNota.MensagemRetorno) Then
  Begin
    pCriarFormularios(TfrmObservacao, frmObservacao);
    Try
      frmObservacao.Caption             := 'Envio de documentos';
      frmObservacao.lblMensagem.Caption := 'Documento não enviado';
      frmObservacao.memObs.Lines.Add(ObjNota.MensagemRetorno);
      frmObservacao.ShowModal;
    Finally
      pFreeAndNil(frmObservacao);
    End;
  End;
end;

procedure TfrmEnvioLocEqu.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos(False);
end;

procedure TfrmEnvioLocEqu.btnImprimirClick(Sender: TObject);
Var
  objImpCtr: TImpressaoLocacao;
  objCtrImp: TContratoLocacaoEquipamentos;
  blnErroApl: Boolean;
begin
  inherited;
  objCtrImp := TContratoLocacaoEquipamentos.Create;
  objImpCtr := TImpressaoLocacao.Create(objCtrImp);
  Try
    objImpCtr.ObjContrato.fCarregarContrato('', edtNumCon.Text, True);
    If objImpCtr.fImprimirContrato(blnErroApl) Then
    Begin
      If fMensagem('ATENÇÃO!', 'Contrato gerado com sucesso!' + #13 +
                               'Deseja abrir o documento?', ['&Sim', '&Não']) = 1 Then
         pExecArquivo(objImpCtr.strNomArquivo, Handle);
    End
    Else
    Begin
      If blnErroApl Then
      Begin
        fMensagem('ATENÇÃO!', 'O Sistema identificou falha na aplicação externa ao Autcom para impressão do documento. ' +
                          'Será realizada nova tentativa para impressão do documento. ' +
                          'Se o problema persistir finalize o LibreOffice manualmente pelo gerenciador de tarefas.' , ['&O k']);

        pForcaLimparAplicacao;
        objImpCtr.fImprimirContrato(blnErroApl, False);
      End;
    End;

    If Not fEmptyStr(objImpCtr.strMensagemRetorno) Then
    Begin
      fMensagem('ATENÇÃO!', objImpCtr.strMensagemRetorno, ['&Ok']);
    End;
  Finally
    FreeAndNil(objCtrImp);
    FreeAndNil(objImpCtr);
  End;
end;

procedure TfrmEnvioLocEqu.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos(True);
end;

procedure TfrmEnvioLocEqu.cxGridDBTableViewCitelAcessorioCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.GridRecord.Values[cxGridDBColumnEQD_MARDES.Index] = 'M' Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmEnvioLocEqu.edtNumConKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel) Then
    fValidaCampos(edtNumCon);
end;

procedure TfrmEnvioLocEqu.edtNumPedKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtNumPed, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmEnvioLocEqu.fCarregarContrato(strNumeroContrato: String; strNumPed: String = '';
  blnExibirMsg: Boolean = True): Boolean;
begin

  ObjContrato.pLimpar;
  ObjNota.pLimparItens;
  ObjContrato.fCarregarContrato('', strNumeroContrato, True, strNumPed);
  ObjNota.Contrato := ObjContrato;

  If Not FValida.fVerificaPodeRealizarEnvio Then
  Begin
    If blnExibirMsg Then
      fMensagem('ATENÇÃO', FValida.strMensagemRetorno, ['&Ok']);
    Result := False;
    Exit;
  End;

  If (Not fValidaTravasContrato(objContrato.AutInc)) Then
  Begin
    Exit(False);
  End;

  edtNumCon.Text := ObjContrato.NroContrato;
  edtCodCli.Text := ObjContrato.CodCliente;
  edtNomCli.Text := ObjContrato.NomCliente;
  edtCodVen.Text := ObjContrato.Vendedor.Codigo;
  edtNomVen.Text := ObjContrato.Vendedor.Nome;
  edtLocalizacao.Text := ObjContrato.Localizacao;
  edtNumPed.Text := Copy(ObjContrato.NumDocPedAdiantamento, 0, 12);
  edtDtaIni.Text := FormatDateTime('dd/mm/yyyy', ObjContrato.DataInicial);
  edtHorIni.Text := FormatDateTime('hh:mm', ObjContrato.HoraInicial);
  edtDtaFin.Text := FormatDateTime('dd/mm/yyyy', ObjContrato.DataFinal);
  edtHorFIn.Text := FormatDateTime('hh:mm', ObjContrato.HoraFinal);
  edtQtde.Text   := FloatToStr(ObjContrato.QuantidadeEquipamentos);

  pCarregarEquipamentos;
  pCarregarAcessorios;
  pHabilitarDesabilitarbtnImprimir;

  edtMesIni.Text := objContrato.strMesIni;
  edtMesFin.Text := objContrato.strMesFin;

  pSetFocus(grdItens);
  grdItensView.DataController.FocusedRowIndex := 0;

  If Not(fEmptyStr(objContrato.AutInc)) Then
    FobjLock.fLock_Unlock(cst_TRAVA_ENVIO__LOCEQU + objContrato.AutInc, True, False);

  Result := True;

end;

procedure TfrmEnvioLocEqu.pAdicionaEquipamentosNota;
var
  item: TItemNotaContratoLocacao;
  intRecNo: Integer;
begin
  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      If cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M' Then
      Begin
        ObjItemEquipamento := ObjContrato.fRetornaItemContrato(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);

        item := ObjNota.fAdicionarProduto;
        item.ItemContrato := ObjItemEquipamento;
        item.CodigoItem := ObjItemEquipamento.Equipamento.CodigoItem;
        item.DescricaoEquipamento := ObjItemEquipamento.Equipamento.Descricao;
        item.fltQtdIte := ObjItemEquipamento.Quantidade;
      End;
      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmEnvioLocEqu.pAdicionaAcessoriosNota;
var
  item: TItemNotaContratoLocacao;
  intRecNo: Integer;
begin
  If Not fCfgSis('UTIACE', VarBoolean) Then
    Exit;

  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      If cdsAcessorios.FieldByName('EQD_MARDES').AsString = 'M' Then
      Begin
        ObjItemAcessorio := ObjContrato.fRetornaItemAcessorioContrato(cdsAcessorios.FieldByName('EQD_SEQEQL').AsString, cdsAcessorios.FieldByName('EQD_SEQACL').AsString);

        item := ObjNota.fAdicionarAcessorio;
        item.AcessorioContrato := ObjItemAcessorio;
        item.CodigoItem := ObjItemAcessorio.Acessorio.CodigoItem;
        item.DescricaoEquipamento := ObjItemAcessorio.Acessorio.Descricao;
        item.fltQtdIte := ObjItemAcessorio.Quantidade * ObjItemAcessorio.ItemEquipamento.Quantidade;
      End;
      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.RecNo := intRecNo;
    cdsAcessorios.EnableControls;
  End;
end;

function TfrmEnvioLocEqu.fConfirmaEnvioDocumento: Boolean;
begin
  Result := False;
  Try
    ObjNota.pLimparItens;
    pAdicionaEquipamentosNota;
    pAdicionaAcessoriosNota;

    If fSelecionaTipoFaturamento Then
      Result := ObjNota.fEmiteDocumentoSimplesRemessaEnvio(FTipoDocEnvio);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmEnvioLocEqu.fConfirmaEnvioDocumento]');
    End;
  End;
end;

procedure TfrmEnvioLocEqu.FormCreate(Sender: TObject);
begin
  inherited;

  cdsEqlDet.CreateDataSet;
  cdsAcessorios.CreateDataSet;

  grpAcessorios.Visible := fCfgSis('UTIACE', VarBoolean);

  ObjContrato := TContratoLocacaoEquipamentos.Create;
  ObjNota := TNotaFiscalContratoLocacao.Create(ObjContrato, 'OU');
  FValida := TValidarContrato.Create(ObjContrato);

  grpAcessorios.Visible := fCfgSis('UTIACE', VarBoolean);

  If Not (fCfgSis('CTRMES', VarBoolean)) Then
  Begin
    pnlDuracaoMensal.Visible := False;
    grbDuracao.Height := grbDuracao.Height - pnlDuracaoMensal.Height + 5;
    pnlDadosContrato.Height := pnlDadosContrato.Height - pnlDuracaoMensal.Height;
  End;

  If fCfgSis('PDRCTR', VarBoolean) Then
  Begin
    edtNumPed.Visible := True;
  End
  Else
  Begin
    edtNumPed.Visible := False;
    lblNumPed.Visible := False;
    edtNumCon.Left := edtNomCli.Left;
    lblNumCon.Left := lblCodCli.Left;
  End;

  FobjLock := TLock.Create;

  Self.WindowState := wsMaximized;
end;

procedure TfrmEnvioLocEqu.FormDestroy(Sender: TObject);
begin

  FobjLock.fLock_Unlock(cst_TRAVA_ENVIO__LOCEQU + objContrato.AutInc, False, False);
  FreeAndNil(FobjLock);

  If Assigned(ObjItemAcessorio) Then
    FreeAndNil(ObjItemAcessorio);
  If Assigned(ObjItemEquipamento) Then
    FreeAndNil(ObjItemEquipamento);
  If Assigned(ObjContrato) Then
    FreeAndNil(ObjContrato);
  If Assigned(ObjNota) Then
    FreeAndNil(ObjNota);
  If Assigned(FValida) Then
    FreeAndNil(FValida);

  inherited;
end;

procedure TfrmEnvioLocEqu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Shift = []) Then
  Begin
    Case Key of
      VK_F10 : If btnConfirma.Enabled Then
                 btnConfirma.Click;
      VK_F3  : If btnMarcarTodos.Enabled Then
                 btnMarcarTodos.Click;
      VK_F4  : If btnDesmarcarTodos.Enabled Then
                 btnDesmarcarTodos.Click;
      VK_F6  : If btnImprimir.Enabled Then
                 btnImprimir.Click;
    End;
  End;
end;

procedure TfrmEnvioLocEqu.FormShow(Sender: TObject);
begin
  inherited;

  If fCfgSis('PDRCTR', VarBoolean) Then
    pSetFocus(edtNumPed)
  Else
    pSetFocus(edtNumCon);
end;

function TfrmEnvioLocEqu.fPodeMarcarAcessorio(
  blnMostraMensagem: Boolean): Boolean;
begin
  Result := True;

  If cdsAcessorios.FieldByName('EQD_STTIPS').AsString = 'PENDENTE' Then
  Begin
    If blnMostraMensagem Then
      fMensagem('ATENÇÃO', 'Não foi realizada a inspeção de saída desse acessório.', ['&Ok']);

    Result := False;
    Exit;
  End;

  If Not fEmptyStr(cdsAcessorios.FieldByName('EQD_DOCENV').AsString) Then
  Begin
    If blnMostraMensagem Then
      fMensagem('ATENÇÃO', 'Já foi emitido um documento de envio desse acessório.', ['&Ok']);

    Result := False;
    Exit;
  End;
end;

function TfrmEnvioLocEqu.fPodeMarcarEquipamento(blnMostraMensagem: Boolean): Boolean;
begin
  Result := True;

  If cdsEqlDet.FieldByName('EQD_STTIPS').AsString = 'PENDENTE' Then
  Begin
    If blnMostraMensagem Then
      fMensagem('ATENÇÃO', 'Não foi realizada a inspeção de saída desse equipamento.', ['&Ok']);

    Result := False;
    Exit;
  End;

  If Not fEmptyStr(cdsEqlDet.FieldByName('EQD_DOCENV').AsString) Then
  Begin
    If blnMostraMensagem Then
      fMensagem('ATENÇÃO', 'Já foi emitido um documento de envio desse equipamento.', ['&Ok']);

    Result := False;
    Exit;
  End;
end;

function TfrmEnvioLocEqu.fSelecionaTipoFaturamento: Boolean;
Var
  arrOpcoes: TOpcoesFaturamentoArray;
  frmFatTipoFaturamento : TfrmFatTipoFaturamento;
Begin
  Result := False;
  SetLength(arrOpcoes, 2);
  FTipoDocEnvio := 'NF';

  If ((Not fCfgSis('PREMFF', varBoolean)) or ( Not fCfgSis('PERMFF', varBoolean))) Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    arrOpcoes[0].strDesCri := 'Nota Fiscal';
    arrOpcoes[0].strEspDoc := 'NF';
    arrOpcoes[0].strOpcLet := 'N';
    arrOpcoes[0].strMosMen := 'S';

    arrOpcoes[1].strDesCri := 'Faturamento Futuro';
    arrOpcoes[1].strEspDoc := 'FF';
    arrOpcoes[1].strOpcLet := 'F';
    arrOpcoes[1].strMosMen := 'N';

    Try
      pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
      frmFatTipoFaturamento.strOpcDoc := 'LE';
      frmFatTipoFaturamento.fatVenda  := ObjNota.ObjFatVenda;
      frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
      frmFatTipoFaturamento.showModal;

      If frmFatTipoFaturamento.blnConfirma Then
      Begin
        FTipoDocEnvio := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmEnvioLocEqu.fSelecionaTipoFaturamento]');
      End;
    End;

  Finally
    pFreeAndNil(frmFatTipoFaturamento);
    SetLength(arrOpcoes, 0);
  end;
End;

function TfrmEnvioLocEqu.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then Begin

    If (Sender = edtNumCon) Then
    Begin
      If fEmptyStr(edtNumCon.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Informe o número do contrato.', ['&Ok']);
        Result := False;
      End
      Else
        Result := fCarregarContrato(edtNumCon.Text, '');
    End

    Else If (Sender = edtNumPed)  Then
    Begin
      If Not fEmptyStr(edtNumPed.Text) Then
      Begin
        fCarregarContrato('', edtNumPed.Text, False);
        If (fEmptyStr(edtNumCon.Text)) And (Not fEmptyStr(edtNumPed.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedido informado não é da rotina de Locação de Equipamentos.', ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmEnvioLocEqu.fVerificaProcessoExecucao(
  const strNomPro: String): Boolean;
begin
  If fEmptyStr(strNomPro) Then
    Exit(False);

  Result := fProcessExists(strNomPro);
end;

function TfrmEnvioLocEqu.fVerificaSelecionado: Boolean;
var
  intRecNo: Integer;
begin
  Result := False;

  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      Result := cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M';

      If Result Then
        Exit;

      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;

  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      Result := cdsAcessorios.FieldByName('EQD_MARDES').AsString = 'M';

      If Result Then
        Exit;

      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.RecNo := intRecNo;
    cdsAcessorios.EnableControls;
  End;

end;

procedure TfrmEnvioLocEqu.grdItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.GridRecord.Values[grdItensEQD_MARDES.Index] = 'M' Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmEnvioLocEqu.grdItensViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);
    VK_RETURN: If (cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M') Or fPodeMarcarEquipamento(True) Then
                 pMarcarEquipamento(cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'D');
  End;
end;

procedure TfrmEnvioLocEqu.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TTimeField(FieldByName('EQL_HORINI')).DisplayFormat := 'hh:nn';
    TTimeField(FieldByName('EQL_HORFIN')).DisplayFormat := 'hh:nn';
  End;
end;

procedure TfrmEnvioLocEqu.pCarregarAcessorios;
var
  intCnt,
  intCont: Integer;
  aItem: TAcessorioContratoLocacaoEquipamentos;
begin
  If Not fCfgSis('UTIACE', VarBoolean) Then
    Exit;

  If cdsAcessorios.Active Then
    cdsAcessorios.EmptyDataSet;

  If Not Assigned(objContrato) Then
    Exit;

  If blnCarregandoItens Then
    Exit;

  cdsAcessorios.DisableControls;
  Try
    Try
      For intCont := 0 to objContrato.Itens.Count  -1 Do
      Begin
        For intCnt := 0 to objContrato.Itens[intCont].Acessorios.Count  -1 Do
        Begin
          aItem := objContrato.Itens[intCont].Acessorios[intCnt];

          cdsAcessorios.Insert;
          cdsAcessorios.FieldByName('AUTOINCREM').AsString := aItem.AutInc;
          cdsAcessorios.FieldByName('EQD_SEQEQL').AsString := aItem.CodEquipamento;
          cdsAcessorios.FieldByName('EQD_SEQACL').AsString := aItem.Acessorio.Codigo;
          cdsAcessorios.FieldByName('EQD_DESCRI').AsString := aItem.Acessorio.Descricao;
          cdsAcessorios.FieldByName('EQD_QTDACL').AsFloat  := aItem.Quantidade;
          cdsAcessorios.FieldByName('EQD_STTIPS').AsString := aItem.strInspecaoSaida;
          cdsAcessorios.FieldByName('EQD_DOCENV').AsString := aItem.strDocEnv;
          cdsAcessorios.FieldByName('EQD_MARDES').AsString := 'N';
          cdsAcessorios.FieldByName('EQA_QTDTOT').AsFloat  := aItem.Quantidade * objContrato.Itens[intCont].Quantidade;

          cdsAcessorios.Post;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmEnvioLocEqu.pCarregarAcessorios]');
      End;
    End;
  Finally
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmEnvioLocEqu.pCarregarEquipamentos;
var
  intCnt: Integer;
begin
  blnCarregandoItens := True;

  If cdsEqlDet.Active Then
    cdsEqlDet.EmptyDataSet;

  If cdsAcessorios.Active Then
    cdsAcessorios.EmptyDataSet;

  cdsEqlDet.DisableControls;
  Try
    Try
      For intCnt := 0 to ObjContrato.Itens.Count-1 Do
      Begin
        cdsEqlDet.Insert;
        cdsEqlDet.FieldByName('AUTOINCREM').AsString := ObjContrato.Itens[intCnt].AutInc;
        cdsEqlDet.FieldByName('EQD_SEQEQL').AsString := ObjContrato.Itens[intCnt].Equipamento.Codigo;
        cdsEqlDet.FieldByName('EQD_DESCRI').AsString := ObjContrato.Itens[intCnt].Equipamento.Descricao;
        cdsEqlDet.FieldByName('EQD_NSERIE').AsString := ObjContrato.Itens[intCnt].Equipamento.NumSerie;
        cdsEqlDet.FieldByName('EQD_DOCENV').AsString := ObjContrato.Itens[intCnt].strDocEnv;
        cdsEqlDet.FieldByName('EQD_STTIPS').AsString := ObjContrato.Itens[intCnt].strInspecaoSaida;
        cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat  := ObjContrato.Itens[intCnt].Quantidade;
        cdsEqlDet.FieldByName('EQD_MARDES').AsString := 'N';
        cdsEqlDet.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmEnvioLocEqu.pCarregarEquipamentos]');
      End;
    End;
  Finally
    cdsEqlDet.EnableControls;
    blnCarregandoItens := False;
  End;
end;

procedure TfrmEnvioLocEqu.pForcaLimparAplicacao;
begin
  if fVerificaProcessoExecucao('soffice.bin') Then
    KillProcess('soffice.bin');
end;

procedure TfrmEnvioLocEqu.pHabilitarDesabilitarbtnImprimir;
begin
  btnImprimir.Enabled := ObjNota.ObjValidaCtr.fContratoPossuiNFDeEnvio();
end;

procedure TfrmEnvioLocEqu.pMarcarEquipamento(blnMarcar: Boolean);
begin
  cdsEqlDet.Edit;
  cdsEqlDet.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsEqlDet.Post;

  pMarcarAcessoriosEquipamento(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString, blnMarcar);
end;

procedure TfrmEnvioLocEqu.pMarcarAcessorio(blnMarcar: Boolean);
begin
  cdsAcessorios.Edit;
  cdsAcessorios.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsAcessorios.Post;
end;

procedure TfrmEnvioLocEqu.pMarcarTodosEquipamentos(blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      If (Not blnMarcar) Or fPodeMarcarEquipamento(False) Then
        pMarcarEquipamento(blnMarcar);

      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmEnvioLocEqu.pMarcarAcessoriosEquipamento(const strCodEql: String; blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      If strCodEql = cdsAcessorios.FieldByName('EQD_SEQEQL').AsString Then
      Begin
        pMarcarAcessorio(blnMarcar);
      End;

      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.RecNo := intRecNo;
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmEnvioLocEqu.pMarcarTodosAcessorios(blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      If (Not blnMarcar) Or fPodeMarcarAcessorio(False) Then
        pMarcarAcessorio(blnMarcar);

      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.RecNo := intRecNo;
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmEnvioLocEqu.pMarcarTodos(blnMarcar: Boolean);
Begin
  pMarcarTodosEquipamentos(blnMarcar);
  pMarcarTodosAcessorios(blnMarcar);
End;

end.
