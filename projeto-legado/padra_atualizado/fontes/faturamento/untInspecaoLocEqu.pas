unit untInspecaoLocEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, EditFocus,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Uni, cxButtonEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  UniClientDataSet, cadastro.Model.ContratoLocacaoEquipamentos, TypesRel, untTypesSistema,
  untTypesLocEqu, MaskEditFocus, untTLock, untFuncoesLocEqu,
  cadastro.Controller.ContratoLocacaoEquipamentos;

type
  TfrmInspecaoLocEqu = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblNumCon: TLabel;
    edtNumCon: TEditFocus;
    pnlDadosContrato: TPanel;
    lblCodCli: TLabel;
    lblCodVen: TLabel;
    lblEntCli: TLabel;
    lblQtde: TLabel;
    edtCodCli: TDBEditFocus;
    edtNomCli: TDBEditFocus;
    edtCodVen: TDBEditFocus;
    edtNomVen: TDBEditFocus;
    grbDuracao: TGroupBox;
    edtQtde: TDBEditFocus;
    grpDetalhesEquipamentos: TGroupBox;
    grdItens: TcxGridCitel;
    grdItensView: TcxGridDBTableViewCitel;
    grdItensEQD_SEQEQL: TcxGridDBColumn;
    grdItensEQL_DESCRI: TcxGridDBColumn;
    grdItensEQL_NSERIE: TcxGridDBColumn;
    grdItensEQD_STTIPS: TcxGridDBColumn;
    grdItensEQD_STTIPE: TcxGridDBColumn;
    grdItensLvl: TcxGridLevel;
    Panel1: TPanel;
    edtLocalizacao: TDBEditFocus;
    dtsContrato: TDataSource;
    dtsEqlDet: TDataSource;
    grpDetalhesAcessorios: TGroupBox;
    cxGridAcessorios: TcxGridCitel;
    cxGridDBTableViewAcessorios: TcxGridDBTableViewCitel;
    cxGridDBColumnEQD_SEQACL: TcxGridDBColumn;
    cxGridDBColumnDESCRICAO: TcxGridDBColumn;
    cxGridDBColumnEQD_STTIPS: TcxGridDBColumn;
    cxGridDBColumnEQD_STTIPE: TcxGridDBColumn;
    cxGridAcessoriosLeve1: TcxGridLevel;
    Panel2: TPanel;
    cxGridDBColumnEQD_QTDACL: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    dtsAcessorios: TDataSource;
    cdsAcessorios: TUniClientDataSet;
    cdsAcessoriosEQD_SEQEQL: TStringField;
    cdsAcessoriosEQD_OPEIPS: TStringField;
    cdsAcessoriosEQD_SUPIPE: TStringField;
    cdsAcessoriosEQD_OBSIPS: TStringField;
    cdsAcessoriosEQD_OBSIPE: TStringField;
    cdsAcessoriosEQD_QTDACL: TFloatField;
    cdsAcessoriosEQD_SEQCON: TStringField;
    tr: TStringField;
    cdsAcessoriosEQD_STTIPS: TStringField;
    cdsAcessoriosAUTOINCREM: TStringField;
    cdsAcessoriosEQD_SEQACL: TStringField;
    cdsAcessoriosDESCRICAO: TStringField;
    cdsEqlDet: TUniClientDataSet;
    StringField1: TStringField;
    cdsEqlDetEQL_NSERIE: TStringField;
    cdsEqlDetEQL_DESCRI: TStringField;
    cdsEqlDetEQD_STTIPS: TStringField;
    cdsEqlDetEQD_STTIPE: TStringField;
    cdsEqlDetAUTOINCREM: TStringField;
    pnlDuracaoDiariaHoras: TPanel;
    lblInicio: TLabel;
    edtDtaIni: TDBEditFocus;
    edtHorIni: TDBEditFocus;
    lblTermino: TLabel;
    edtDtaFin: TDBEditFocus;
    edtHorFin: TDBEditFocus;
    pnlDuracaoMensal: TPanel;
    lblMesIni: TLabel;
    edtMesIni: TMaskEditFocus;
    lblMesFin: TLabel;
    edtMesFin: TMaskEditFocus;
    lblNumPed: TLabel;
    edtNumPed: TEditFocus;
    grdItensEQD_QTDEQU: TcxGridDBColumn;
    cdsEqlDetEQD_QTDEQU: TFloatField;
    cdsAcessoriosEQA_QTDTOT: TFloatField;
    cxGridDBColumnEQA_QTDTOT: TcxGridDBColumn;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure edtNumConKeyPress(Sender: TObject; var Key: Char);
    procedure grdItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdItensEQD_STTIPSPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure grdItensEQD_STTIPEPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure cdsEqlDetAfterScroll(DataSet: TDataSet);
    procedure cxGridDBTableViewAcessoriosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridDBColumnEQD_STTIPSPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridDBColumnEQD_STTIPEPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    objContrato: TContratoLocacaoEquipamentos;
    blnCarregandoItens: Boolean;
    ObjItemAcessorio: TAcessorioContratoLocacaoEquipamentos;
    ObjItemEquipamento: TItemContratoLocacaoEquipamentos;
    FblnRealizaInspTodosEqu: Boolean;
    FobjLock: TLock;
    FobjValidaCtr: TValidarContrato;

    function fCarregarContrato(strNumeroContrato: String; strNumPed: String = '';
      blnExibirMsg: Boolean = True): Boolean;
    procedure pCarregaDetalhes;
    procedure pInformaInspecao();
    procedure pInformaInspecaoAcessorio;
    procedure pAdicionarAcessorioGrid;
    procedure pAbrirTelaInspecaoSaida(blnAlterar: Boolean);
    procedure pAbrirTelaInspecaoEntrada(blnAlterar: Boolean);
    procedure pAbrirTelaInspecaoAcessorioSaida(blnAlterar: Boolean);
    procedure pAbrirTelaInspecaoAcessorioEntrada(blnAlterar: Boolean);
    procedure pConfirma;
    procedure pImprimeComprovanteIspEnt;
    function fVerificaItensInspecionadosImpressao : Boolean;
    procedure pImprimeComprovanteIspSai;
    procedure pLimparCampos;
    function fConfirmaAtualizarDataTermino: Boolean;
    procedure pHabilitaDesabilitaInspecao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untInspecaoLocEquSaida,
  untInspecaoLocEquEntrada, untObservacao, untEditorFastImpressao;

procedure TfrmInspecaoLocEqu.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  pConfirma;
end;

procedure TfrmInspecaoLocEqu.cdsEqlDetAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If Not DataSet.IsEmpty Then
  begin
    pSetFocus(grdItens);
  end;

  pAdicionarAcessorioGrid;
end;

procedure TfrmInspecaoLocEqu.cxGridDBColumnEQD_STTIPEPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  If cdsAcessorios.FieldByName('EQD_STTIPE').AsString = 'PENDENTE' Then
    fMensagem('ATENÇÃO', 'Acessório com inspeção de entrada ainda pendente', ['&Ok'])
  Else
  Begin
    pAbrirTelaInspecaoAcessorioEntrada(False);
  End;
end;

procedure TfrmInspecaoLocEqu.cxGridDBColumnEQD_STTIPSPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  If cdsAcessorios.FieldByName('EQD_STTIPS').AsString = 'PENDENTE' Then
    fMensagem('ATENÇÃO', 'Acessório com inspeção de saída ainda pendente', ['&Ok'])
  Else
  Begin
    pAbrirTelaInspecaoAcessorioSaida(False);
  End;
end;

procedure TfrmInspecaoLocEqu.cxGridDBTableViewAcessoriosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);
    VK_RETURN: pInformaInspecaoAcessorio();
  End;

end;

procedure TfrmInspecaoLocEqu.edtNumConKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel, True, False) Then
    fValidaCampos(edtNumCon);
end;

procedure TfrmInspecaoLocEqu.edtNumPedKeyPress(Sender: TObject; var Key: Char);
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

function TfrmInspecaoLocEqu.fCarregarContrato(strNumeroContrato: String; strNumPed: String = '';
  blnExibirMsg: Boolean = True): Boolean;
begin

  If Not Assigned(objContrato) Then
    Exit(False);

  objContrato.pLimpar;

  If Not objContrato.fCarregarContrato('', strNumeroContrato, True, strNumPed) Then
  Begin
    If blnExibirMsg Then
      fMensagem('ATENÇÃO', 'Contrato não encontrado!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not FobjValidaCtr.fVerificaPodeRealizarInspecao Then
  Begin
    fMensagem('ATENÇÃO', FobjValidaCtr.strMensagemRetorno, ['&Ok']);
    Result := False;
    Exit;
  End;

  If (Not fValidaTravasContrato(objContrato.AutInc)) Then
  Begin
    Exit(False);
  End;

  pLimparCampos;
  edtMesIni.Text := objContrato.strMesIni;
  edtMesFin.Text := objContrato.strMesFin;
  edtNumCon.Text := objContrato.NroContrato;
  edtCodCli.Text := objContrato.Cliente.Codigo;
  edtNomCli.Text := objContrato.Cliente.NomeCliente;
  edtCodVen.Text := objContrato.Vendedor.Codigo;
  edtNomVen.Text := objContrato.Vendedor.Nome;
  edtLocalizacao.Text := objContrato.Localizacao;
  edtDtaIni.Text := FormatDateTime('dd/mm/yyyy', objContrato.DataInicial);
  edtHorIni.Text := FormatDateTime('hh:mm', objContrato.HoraInicial);
  edtDtaFin.Text := FormatDateTime('dd/mm/yyyy', objContrato.DataFinal);
  edtHorFin.Text := FormatDateTime('hh:mm', objContrato.HoraFinal);
  edtQtde.Text := FloatToStr(objContrato.QuantidadeEquipamentos);
  edtNumPed.Text := Copy(objContrato.NumDocPedAdiantamento, 0, 12);
  edtCodEmp.Text := objContrato.Emitente.Codigo;

  pCarregaDetalhes;
  pAdicionarAcessorioGrid;

  pSetFocus(grdItens);
  grdItensView.DataController.FocusedRowIndex := 0;

  If Not(fEmptyStr(objContrato.AutInc)) Then
    FobjLock.fLock_Unlock(cst_TRAVA_INSPEC_LOCEQU + objContrato.AutInc, True, False);

  pHabilitaDesabilitaInspecao;

  Result := True;

end;

procedure TfrmInspecaoLocEqu.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

  If Not fEmptyStr(ObjContrato.NroContrato) Then
  Begin
    If Not ObjContrato.blnInspecaoRealizada Then
    Begin
      If fMensagem('ATENÇÃO', 'Deseja sair? As inspeções não serão salvas.', ['&Sim', '&Não']) = 2 Then
      Begin
        CanClose := False;
      End;
    End;
  End;

  inherited;

end;

procedure TfrmInspecaoLocEqu.FormCreate(Sender: TObject);
begin
  inherited;

  cdsEqlDet.CreateDataSet;
  cdsAcessorios.CreateDataSet;
  objContrato := TContratoLocacaoEquipamentos.Create(opInspecao);

  FobjValidaCtr := TValidarContrato.Create(objContrato);

  grpDetalhesAcessorios.Visible := fCfgSis('UTIACE', VarBoolean);

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

    lblNumCon.Left := lblNumPed.Left ;
    edtNumCon.Left := lblNumCon.Left + lblNumCon.Width + 3;
  End;

  FobjLock := TLock.Create;

  Self.WindowState := wsMaximized;
end;

procedure TfrmInspecaoLocEqu.FormDestroy(Sender: TObject);
begin
  inherited;

  FobjLock.fLock_Unlock(cst_TRAVA_INSPEC_LOCEQU + objContrato.AutInc, False, False);
  FreeAndNil(FobjLock);
  FreeAndNil(objContrato);
  FreeAndNil(FobjValidaCtr);
end;

procedure TfrmInspecaoLocEqu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10 : pConfirma;
  End;

  FblnRealizaInspTodosEqu := False;

end;

procedure TfrmInspecaoLocEqu.FormShow(Sender: TObject);
begin
  If fCfgSis('PDRCTR', VarBoolean) Then
    pSetFocus(edtNumPed)
  Else
    pSetFocus(edtNumCon);
end;

function TfrmInspecaoLocEqu.fConfirmaAtualizarDataTermino: Boolean;
begin

  If Not fCfgSis('ATUCTR', VarBoolean) Then
    Exit(True);

  If (Not FobjValidaCtr.fContratoPossuiInspecaoEntradaAberto) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Foi realizada a inspeção de todos os equipamentos. ' +
                             'Deseja atualizar a data do término do contrato ?', ['&Sim', '&Não']) = 1 Then
    Begin
      Result := objContrato.fAlterarDataTerminoContrato(objContrato.DataInicialEstimada, fNow,
                                                         '', '', True);
      If Result Then
        fMensagem('ATENÇÃO!', 'Data de término do contrato atualizada!', ['&O k'])
      Else If Not fEmptyStr(FobjValidaCtr.strMensagemRetorno) Then
        fMensagem('ATENÇÃO!', FobjValidaCtr.strMensagemRetorno, ['&O k']);
    End
    Else
      Exit(True);
  End
  Else
    Exit(True);

end;

function TfrmInspecaoLocEqu.fValidaCampos(Sender: TWinControl;
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
        Result := fCarregarContrato(edtNumCon.Text);
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

procedure TfrmInspecaoLocEqu.grdItensEQD_STTIPEPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  If cdsEqlDet.FieldByName('EQD_STTIPE').AsString = 'PENDENTE' Then
    fMensagem('ATENÇÃO', 'Inspeção de entrada ainda pendente', ['&Ok'])
  Else
  Begin
    pAbrirTelaInspecaoEntrada(False);
  End;
end;

procedure TfrmInspecaoLocEqu.grdItensEQD_STTIPSPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  If cdsEqlDet.FieldByName('EQD_STTIPS').AsString = 'PENDENTE' Then
    fMensagem('ATENÇÃO', 'Inspeção de saída ainda pendente', ['&Ok'])
  Else
  Begin
    pAbrirTelaInspecaoSaida(False);
  End;
end;

procedure TfrmInspecaoLocEqu.grdItensViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);
    VK_RETURN: pInformaInspecao();
  End;
end;

procedure TfrmInspecaoLocEqu.pAbrirTelaInspecaoAcessorioSaida(
  blnAlterar: Boolean);
var
  frmInspecaoLocEquSaida: TfrmInspecaoLocEquSaida;
begin
  If cdsAcessorios.IsEmpty Then
    Exit;

  If Not FobjValidaCtr.fVerificaPodeRealizarInspecaoSaida  Then
  Begin
    fMensagem('ATENÇÃO', FobjValidaCtr.strMensagemRetorno, ['&Ok']);
    Exit;
  End;

  ObjItemAcessorio := ObjContrato.fRetornaItemAcessorioContrato(cdsAcessorios.FieldByName('EQD_SEQEQL').AsString, cdsAcessorios.FieldByName('EQD_SEQACL').AsString);

  pCriarFormularios(TfrmInspecaoLocEquSaida, frmInspecaoLocEquSaida);
  Try
    frmInspecaoLocEquSaida.strChaveDet := cdsAcessorios.FieldByName('AUTOINCREM').AsString;
    frmInspecaoLocEquSaida.blnAlterar := blnAlterar;
    frmInspecaoLocEquSaida.blnCarregarDados := Not blnAlterar;
    frmInspecaoLocEquSaida.TipoEquipamento := tpAcessorio;
    frmInspecaoLocEquSaida.ObjItemAcessorio := ObjItemAcessorio;
    frmInspecaoLocEquSaida.ShowModal;

    cdsAcessorios.Edit;
    cdsAcessorios.FieldByName('EQD_STTIPE').AsString := ObjItemAcessorio.strInspecaoEntrada;
    cdsAcessorios.FieldByName('EQD_STTIPS').AsString := ObjItemAcessorio.strInspecaoSaida;
    cdsAcessorios.Post;
  Finally
    pFreeAndNil(frmInspecaoLocEquSaida);
  End;
end;

procedure TfrmInspecaoLocEqu.pAbrirTelaInspecaoAcessorioEntrada(
  blnAlterar: Boolean);
var
  frmInspecaoLocEquEntrada: TfrmInspecaoLocEquEntrada;
begin

  If Not FobjValidaCtr.fVerificaPodeRealizarInspecaoEntrada  Then
  Begin
    fMensagem('ATENÇÃO', FobjValidaCtr.strMensagemRetorno, ['&Ok']);
    Exit;
  End;

  ObjItemAcessorio := ObjContrato.fRetornaItemAcessorioContrato(cdsAcessorios.FieldByName('EQD_SEQEQL').AsString, cdsAcessorios.FieldByName('EQD_SEQACL').AsString);

  pCriarFormularios(TfrmInspecaoLocEquEntrada, frmInspecaoLocEquEntrada);
  Try
    frmInspecaoLocEquEntrada.strChaveDet := cdsAcessorios.FieldByName('AUTOINCREM').AsString;
    frmInspecaoLocEquEntrada.blnAlterar := blnAlterar;
    frmInspecaoLocEquEntrada.blnCarregarDados := Not blnAlterar;
    frmInspecaoLocEquEntrada.TipoEquipamento := tpAcessorio;
    frmInspecaoLocEquEntrada.ObjItemAcessorio := ObjItemAcessorio;
    frmInspecaoLocEquEntrada.ShowModal;

    cdsAcessorios.Edit;
    cdsAcessorios.FieldByName('EQD_STTIPE').AsString := ObjItemAcessorio.strInspecaoEntrada;
    cdsAcessorios.FieldByName('EQD_STTIPS').AsString := ObjItemAcessorio.strInspecaoSaida;
    cdsAcessorios.Post;
  Finally
    pFreeAndNil(frmInspecaoLocEquEntrada);
  End;
end;

procedure TfrmInspecaoLocEqu.pAbrirTelaInspecaoEntrada(blnAlterar: Boolean);
var
  frmInspecaoLocEquEntrada: TfrmInspecaoLocEquEntrada;
begin
  If Not FobjValidaCtr.fVerificaPodeRealizarInspecaoEntrada  Then
  Begin
    fMensagem('ATENÇÃO', FobjValidaCtr.strMensagemRetorno, ['&Ok']);
    Exit;
  End;

  ObjItemEquipamento := ObjContrato.fRetornaItemContrato(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);

  pCriarFormularios(TfrmInspecaoLocEquEntrada, frmInspecaoLocEquEntrada);
  Try
    frmInspecaoLocEquEntrada.strChaveDet := cdsEqlDet.FieldByName('AUTOINCREM').AsString;
    frmInspecaoLocEquEntrada.blnAlterar := blnAlterar;
    frmInspecaoLocEquEntrada.blnCarregarDados := Not blnAlterar;
    frmInspecaoLocEquEntrada.TipoEquipamento := tpPrincipal;
    frmInspecaoLocEquEntrada.ObjItemEquipamento := ObjItemEquipamento;
    frmInspecaoLocEquEntrada.ShowModal;


    cdsEqlDet.Edit;
    cdsEqlDet.FieldByName('EQD_STTIPE').AsString := ObjItemEquipamento.strInspecaoEntrada;
    cdsEqlDet.FieldByName('EQD_STTIPS').AsString := ObjItemEquipamento.strInspecaoSaida;
    cdsEqlDet.Post;
  Finally
    pFreeAndNil(frmInspecaoLocEquEntrada);
  End;
end;

procedure TfrmInspecaoLocEqu.pAbrirTelaInspecaoSaida(blnAlterar: Boolean);
var
  frmInspecaoLocEquSaida: TfrmInspecaoLocEquSaida;
begin
  If Not FobjValidaCtr.fVerificaPodeRealizarInspecaoSaida  Then
  Begin
    fMensagem('ATENÇÃO', FobjValidaCtr.strMensagemRetorno, ['&Ok']);
    Exit;
  End;

  ObjItemEquipamento := ObjContrato.fRetornaItemContrato(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);

  pCriarFormularios(TfrmInspecaoLocEquSaida, frmInspecaoLocEquSaida);
  Try
    frmInspecaoLocEquSaida.strChaveDet := cdsEqlDet.FieldByName('AUTOINCREM').AsString;
    frmInspecaoLocEquSaida.blnAlterar := blnAlterar;
    frmInspecaoLocEquSaida.blnCarregarDados := Not blnAlterar;
    frmInspecaoLocEquSaida.TipoEquipamento := tpPrincipal;
    frmInspecaoLocEquSaida.ObjItemEquipamento := ObjItemEquipamento;
    frmInspecaoLocEquSaida.ShowModal;

    cdsEqlDet.Edit;
    cdsEqlDet.FieldByName('EQD_STTIPE').AsString := ObjItemEquipamento.strInspecaoEntrada;
    cdsEqlDet.FieldByName('EQD_STTIPS').AsString := ObjItemEquipamento.strInspecaoSaida;
    cdsEqlDet.Post;
  Finally
    pFreeAndNil(frmInspecaoLocEquSaida);
  End;
End;

procedure TfrmInspecaoLocEqu.pAdicionarAcessorioGrid;
var
  intCnt,
  intCont: Integer;
  aItem: TAcessorioContratoLocacaoEquipamentos;
begin
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
        If objContrato.Itens[intCont].Equipamento.Codigo = cdsEqlDet.FieldByName('EQD_SEQEQL').AsString Then
        Begin
          For intCnt := 0 to objContrato.Itens[intCont].Acessorios.Count  -1 Do
          Begin
            aItem := objContrato.Itens[intCont].Acessorios[intCnt];

            cdsAcessorios.Insert;
            cdsAcessorios.FieldByName('EQD_SEQEQL').AsString := aItem.CodEquipamento;
            cdsAcessorios.FieldByName('EQD_SEQACL').AsString := aItem.Acessorio.Codigo;
            cdsAcessorios.FieldByName('DESCRICAO').AsString  := aItem.Acessorio.Descricao;
            cdsAcessorios.FieldByName('EQD_QTDACL').AsFloat  := aItem.Quantidade;
            cdsAcessorios.FieldByName('EQD_STTIPS').AsString := aItem.strInspecaoSaida;
            cdsAcessorios.FieldByName('EQD_STTIPE').AsString := aItem.strInspecaoEntrada;
            cdsAcessorios.FieldByName('EQA_QTDTOT').AsFloat  := aItem.Quantidade * objContrato.Itens[intCont].Quantidade;
            cdsAcessorios.Post;
          End;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmInspecaoLocEqu.pAdicionarAcessorioGrid]');
      End;
    End;
  Finally
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmInspecaoLocEqu.pAfterOpen(DataSet: TDataSet);
begin
  TTimeField(DataSet.FieldByName('EQL_HORINI')).DisplayFormat := 'hh:nn';
  TTimeField(DataSet.FieldByName('EQL_HORFIN')).DisplayFormat := 'hh:nn';
end;

procedure TfrmInspecaoLocEqu.pCarregaDetalhes;
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
        cdsEqlDet.FieldByName('EQL_DESCRI').AsString := ObjContrato.Itens[intCnt].Equipamento.Descricao;
        cdsEqlDet.FieldByName('EQL_NSERIE').AsString := ObjContrato.Itens[intCnt].Equipamento.NumSerie;
        cdsEqlDet.FieldByName('EQD_STTIPE').AsString := ObjContrato.Itens[intCnt].strInspecaoEntrada;
        cdsEqlDet.FieldByName('EQD_STTIPS').AsString := ObjContrato.Itens[intCnt].strInspecaoSaida;
        cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat  := ObjContrato.Itens[intCnt].Quantidade;
        cdsEqlDet.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmInspecaoLocEqu.pCarregaDetalhes]');
      End;
    End;
  Finally
    cdsEqlDet.EnableControls;
    blnCarregandoItens := False;
  End;
end;

procedure TfrmInspecaoLocEqu.pConfirma;
var
  frmObservacao: TfrmObservacao;
begin
  inherited;

  If grpDetalhesAcessorios.Visible Then
  Begin
    If Not ObjContrato.fValidarInspecao Then
    Begin
      pCriarFormularios(TfrmObservacao, frmObservacao);
      Try
        frmObservacao.Caption := 'Inspeção de Equipamentos ';
        frmObservacao.lblMensagem.Visible := False;
        frmObservacao.memObs.Texto := ObjContrato.MensagemRetorno;
        frmObservacao.memObs.SelStart := 0;
        frmObservacao.ShowModal;
      Finally
        pFreeAndNil(frmObservacao);
      End;

      Exit;
    End;
  End;

  If Not ObjContrato.fConfirmarInspecao Then
    pMensagensErro(ObjContrato.MensagemRetorno, 'TfrmInspecaoLocEqu.btnConfirmaClick')
  Else
  Begin
    If fConfirmaAtualizarDataTermino And
      (Not fVerificaItensInspecionadosImpressao) Then
      pMensagemOk('Processo concluído com sucesso!');

    Self.Close;
  End;
end;

procedure TfrmInspecaoLocEqu.pHabilitaDesabilitaInspecao;
begin
  btnConfirma.Enabled := False;

  If Not Assigned(ObjContrato) Then
    Exit;

  If ObjContrato.Emitente.Codigo = VS_strCodEmp Then
  Begin
    btnConfirma.Enabled := True;
    Exit;
  End;

  If FobjValidaCtr.fRealizarProcessoLocacaoOutraEmpresa Then
    btnConfirma.Enabled := True;
end;

procedure TfrmInspecaoLocEqu.pInformaInspecao;
begin
  If cdsEqlDet.FieldByName('EQD_STTIPS').AsString = 'PENDENTE' Then
  Begin
    pAbrirTelaInspecaoSaida(True);
  End
  Else If cdsEqlDet.FieldByName('EQD_STTIPE').AsString = 'PENDENTE' Then
  Begin
    pAbrirTelaInspecaoEntrada(True);
  End
  Else
  Begin
    fMensagem('ATENÇÃO', 'Não há inspeção pendente para ser realizada neste registro!', ['&Ok']);
    Exit;
  End;
end;

procedure TfrmInspecaoLocEqu.pInformaInspecaoAcessorio;
begin
  If cdsAcessorios.FieldByName('EQD_STTIPS').AsString = 'PENDENTE' Then
  Begin
    pAbrirTelaInspecaoAcessorioSaida(True);
  End
  Else If cdsAcessorios.FieldByName('EQD_STTIPE').AsString = 'PENDENTE' Then
  Begin
    pAbrirTelaInspecaoAcessorioEntrada(True);
  End
  Else
  Begin
    fMensagem('ATENÇÃO', 'Não há inspeção pendente para ser realizada neste registro!', ['&Ok']);
  End;
end;

procedure TfrmInspecaoLocEqu.pLimparCampos;
begin
  edtNumPed.Clear;
  edtNumCon.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtLocalizacao.Clear;
  edtDtaIni.Clear;
  edtHorIni.Clear;
  edtDtaFin.Clear;
  edtHorFin.Clear;
  edtQtde.Clear;
end;

procedure TfrmInspecaoLocEqu.pImprimeComprovanteIspEnt;
  Var
    strLayPadrao: String;
    objImpressao: TEditorFastImpressao;
begin
  strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeInspecaoEnt], VS_strCodEmp, 'S']);

  If fEmptyStr(strLayPadrao) Then
  Begin
    pMensagemOk('Não há layout disponível para impressão!');
    Exit;
  End;


  objImpressao := TEditorFastImpressao.Create(Nil);
  Try
    objImpressao.recDocume.strEquipamentos := '';
    objImpressao.recDocume.strNumDoc       := edtNumCon.Text;
    objImpressao.recDocume.strCodEmp       := VS_strCodEmp;
    {Alimentar os equipamentos inspecionados}
    cdsEqlDet.DisableControls;
    cdsEqlDet.First;
    While not cdsEqlDet.EOF do
    Begin
      If (cdsEqlDet.FieldByName('EQD_STTIPE').OldValue = 'PENDENTE') and (Pos('REALIZADA',cdsEqlDet.FieldByName('EQD_STTIPE').asString) > 0) then
      Begin
        If fEmptyStr(objImpressao.recDocume.strEquipamentos) Then
          objImpressao.recDocume.strEquipamentos := QuotedStr(cdsEqlDet.FieldByName('AUTOINCREM').asString)
        else
          objImpressao.recDocume.strEquipamentos := objImpressao.recDocume.strEquipamentos + ',' + QuotedStr(cdsEqlDet.FieldByName('AUTOINCREM').asString);
      End;
      cdsEqlDet.Next;
    End;
    cdsEqlDet.EnableControls;
    objImpressao.recDocume.blnInspecaoEnt  := True;
    objImpressao.tpeTipoEtiqueta           := tpeInspecaoEnt;
    objImpressao.fImprimeDocumento;
  Finally
    FreeAndNil(objImpressao);
  End;
end;

function TfrmInspecaoLocEqu.fVerificaItensInspecionadosImpressao : Boolean;
Var blnCompEnt, blnCompSai : Boolean;
begin
  blnCompEnt := False;
  blnCompSai := False;
  Result := False;

  If fCfgSis('ISPCMP', VarBoolean) then
  Begin
    cdsEqlDet.DisableControls;
    cdsEqlDet.First;
    While not cdsEqlDet.EOF do
    Begin
      blnCompSai := (cdsEqlDet.FieldByName('EQD_STTIPS').OldValue = 'PENDENTE') and
                    (Pos('REALIZADA',cdsEqlDet.FieldByName('EQD_STTIPS').asString) > 0);

      blnCompEnt := (cdsEqlDet.FieldByName('EQD_STTIPE').OldValue = 'PENDENTE') and
                    (Pos('REALIZADA',cdsEqlDet.FieldByName('EQD_STTIPE').asString) > 0);

      If (blnCompEnt or blnCompSai) then
      Begin
        Result := True;
        cdsEqlDet.EnableControls;

        If (fMensagem('CONFIRMAÇÃO!', 'Inspeção realizada com sucesso. Deseja imprimir o comprovante?', ['&Sim', '&Não'], 1) = 2) Then
          Exit;

        Break;
      End
      Else
        cdsEqlDet.Next;
    End;
    cdsEqlDet.EnableControls;


    if blnCompEnt then
      pImprimeComprovanteIspEnt;

    if blnCompSai then
      pImprimeComprovanteIspSai;
  End;

end;

procedure TfrmInspecaoLocEqu.pImprimeComprovanteIspSai;
  Var
    strLayPadrao: String;
    objImpressao: TEditorFastImpressao;
begin
  strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeInspecaoSai], VS_strCodEmp, 'S']);

  If fEmptyStr(strLayPadrao) Then
  Begin
    pMensagemOk('Não há layout disponível para impressão!');
    Exit;
  End;


  objImpressao := TEditorFastImpressao.Create(Nil);
  Try
    objImpressao.recDocume.strEquipamentos := '';
    objImpressao.recDocume.strNumDoc       := edtNumCon.Text;
    objImpressao.recDocume.strCodEmp       := VS_strCodEmp;
    {Alimentar os equipamentos inspecionados}
    cdsEqlDet.DisableControls;
    cdsEqlDet.First;
    While not cdsEqlDet.EOF do
    Begin
      If (cdsEqlDet.FieldByName('EQD_STTIPS').OldValue = 'PENDENTE') and (Pos('REALIZADA',cdsEqlDet.FieldByName('EQD_STTIPS').asString) > 0) Then
      Begin
        If fEmptyStr(objImpressao.recDocume.strEquipamentos) Then
          objImpressao.recDocume.strEquipamentos := QuotedStr(cdsEqlDet.FieldByName('AUTOINCREM').asString)
        else
          objImpressao.recDocume.strEquipamentos := objImpressao.recDocume.strEquipamentos + ',' + QuotedStr(cdsEqlDet.FieldByName('AUTOINCREM').asString);
      End;
      cdsEqlDet.Next;
    End;
    cdsEqlDet.EnableControls;
    objImpressao.recDocume.blnInspecaoSai  := True;
    objImpressao.tpeTipoEtiqueta           := tpeInspecaoSai;
    objImpressao.fImprimeDocumento;
  Finally
    FreeAndNil(objImpressao);
  End;
end;


end.
