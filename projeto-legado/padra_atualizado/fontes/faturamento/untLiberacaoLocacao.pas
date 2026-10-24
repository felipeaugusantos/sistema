unit untLiberacaoLocacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxButtonEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, EditFocus, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Datasnap.DBClient, UniClientDataSet,
  cadastro.Model.ContratoLocacaoEquipamentos, cxCheckBox,
  cadastro.Controller.ContratoLocacaoEquipamentos, untTypesSistema, Uni,
  System.Generics.Collections, untTLock, untFuncoesLocEqu;

type
  TfrmLiberacaoLocacao = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblNumCon: TLabel;
    edtNumCon: TEditFocus;
    pnlDadosContrato: TPanel;
    lblCodCli: TLabel;
    lblCodVen: TLabel;
    lblEntCli: TLabel;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    edtLocalizacao: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodCli: TEditFocus;
    edtCodVen: TEditFocus;
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
    cdsEqlDet: TUniClientDataSet;
    StringField1: TStringField;
    cdsEqlDetEQL_NSERIE: TStringField;
    cdsEqlDetEQL_DESCRI: TStringField;
    cdsEqlDetAUTOINCREM: TStringField;
    dtsEqlDet: TDataSource;
    dtsAcessorios: TDataSource;
    cdsEqlDetEQD_DTAIPE: TDateTimeField;
    cdsEqlDetEQD_AVARIA: TStringField;
    cdsEqlDetEQD_OBSIPE: TMemoField;
    cdsEqlDetEQD_SUPERV: TStringField;
    cdsEqlDetEQD_CONFER: TStringField;
    cdsAcessoriosEQD_DTAIPE: TDateTimeField;
    cdsAcessoriosEQD_AVARIA: TStringField;
    cdsAcessoriosEQD_CONFER: TStringField;
    cdsAcessoriosEQD_SUPERV: TStringField;
    pnlItensContrato: TPanel;
    grpEquipamentos: TGroupBox;
    cxgrdItens: TcxGridCitel;
    cxgrdItensView: TcxGridDBTableViewCitel;
    cxgrdItensViewEQD_SEQEQL: TcxGridDBColumn;
    cxgrdItensViewEQL_DESCRI: TcxGridDBColumn;
    cxgrdItensViewEQL_NSERIE: TcxGridDBColumn;
    cxgrdItensViewEQD_AVARIA: TcxGridDBColumn;
    cxgrdItensViewEQD_OBSIPE: TcxGridDBColumn;
    cxgrdItensViewEQD_CONFER: TcxGridDBColumn;
    cxgrdItensViewEQD_SUPERV: TcxGridDBColumn;
    cxgrdItensLvl: TcxGridLevel;
    grpAcessorios: TGroupBox;
    cxGridAcessorios: TcxGridCitel;
    cxGridDBTableViewAcessorios: TcxGridDBTableViewCitel;
    cxGridDBTableViewAcessoriosEQD_SEQACL: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_DESCRI: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_QTDACL: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_DTAIPE: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_AVARIA: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_OBSIPE: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_CONFER: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_SUPERV: TcxGridDBColumn;
    cxGridAcessoriosLeve1: TcxGridLevel;
    cdsAcessoriosEQD_MARDES: TStringField;
    cdsEqlDetEQD_MARDES: TStringField;
    cdsEqlDetEQA_MARDES: TStringField;
    cdsAcessoriosEQD_DESCRI: TStringField;
    cxgrdItensViewEQD_DTAIPE: TcxGridDBColumn;
    cxgrdItensViewEQD_MARDES: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_MARDES: TcxGridDBColumn;
    btnMarcarAcessEquip: TBitBtnLocked;
    lblTroca: TLabel;
    edtNroTrc: TEditFocus;
    edtNumPed: TEditFocus;
    lblNumPed: TLabel;
    cdsEqlDetEQD_QTDEQU: TFloatField;
    cxgrdItensViewEQD_QTDEQU: TcxGridDBColumn;
    cdsAcessoriosEQA_QTDTOT: TFloatField;
    cxGridDBTableViewAcessoriosEQA_QTDTOT: TcxGridDBColumn;
    procedure edtNumConKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure cxgrdItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridDBTableViewAcessoriosCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgrdItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridDBTableViewAcessoriosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarcarAcessEquipClick(Sender: TObject);
    procedure edtNroTrcKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ObjContrato: TContratoLocacaoEquipamentos;
    ObjTroca: TTrocaContrato;
    blnCarregandoItens: Boolean;
    arrSelTroca: TConsultasArray;
    qryTroca: TUniQuery;
    FobjLock: TLock;

    function  fValidarInspecaoAcessoriosEquipamentosSelecionados: Boolean;
    function  fAcessoriosItemSelecionados(const strCodEQL: String): String;
    function  fCarregarContrato(strNumeroContrato: String; strNumPed: String = '';
      blnExibirMsg: Boolean = True): Boolean;
    function  fCarregarTroca(const strNroTrc: String): Boolean;
    function  fConfirmar: Boolean;

    procedure pCarregarEquipamentosTroca(const aListaEquipamentos: TList<TItemContratoLocacaoEquipamentos>);
    procedure pCarregarEquipamentos;
    procedure pCarregarAcessorios;
    procedure pCarregarAcessoriosTroca(const aListaAcessorios: TList<TAcessorioContratoLocacaoEquipamentos>);
    procedure pFormatarCampos;
    procedure pMarcarTodos(const blnMarcar: Boolean);
    procedure pMarcarTodosEquipamentos(const blnMarcar: Boolean);
    procedure pMarcarTodosAcessorios(const blnMarcar: Boolean);
    procedure pMarcarEquipamento(const blnMarcar: Boolean; blnExibirPergunta: Boolean = True);
    procedure pMarcarAcessoriosEquipamento(const strCodEql: String; const blnMarcar: Boolean);
    procedure pMarcarAcessorio(const blnMarcar: Boolean);
    procedure pAtivarItensSelecionados;
    procedure pAtivarEquipamentos;
    procedure pAtivarAcessorios;
    procedure pLimparCampos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untConsultas, untFuncoesSimples, untObservacao, cadastro.Model.EquipamentoLocacao, cadastro.Model.AcessorioLocacao,
  untTypesLocEqu;

{$R *.dfm}

procedure TfrmLiberacaoLocacao.FormCreate(Sender: TObject);
begin
  inherited;

  ObjContrato := TContratoLocacaoEquipamentos.Create;
  ObjTroca := TTrocaContrato.Create(ObjContrato);

  cdsEqlDet.CreateDataSet;
  cdsAcessorios.CreateDataSet;

  grpAcessorios.Visible := fCfgSis('UTIACE', VarBoolean);

  btnMarcarAcessEquip.Visible := grpAcessorios.Visible;

  qryTroca := fCriarQuery('SELECT * FROM TRCEQL WHERE TRUE', Self);

  pFormatarCampos;

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
    edtNroTrc.Left := edtNomCli.Left;
    lblTroca.Left := lblCodCli.Left;
  End;

  FobjLock := TLock.Create;

  Self.WindowState := wsMaximized;
end;

procedure TfrmLiberacaoLocacao.FormDestroy(Sender: TObject);
begin
  inherited;

  FobjLock.fLock_Unlock(cst_TRAVA_LIBERA_LOCEQU + ObjContrato.AutInc, False, False);
  FreeAndNil(FobjLock);

  If Assigned(ObjContrato) Then
    FreeAndNil(ObjContrato);

  If Assigned(ObjTroca) Then
    FreeAndNil(ObjTroca);

  FreeAndNil(qryTroca);
end;

procedure TfrmLiberacaoLocacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10 : Begin
               If fConfirmar Then
                 Self.Close;
             End;
    VK_F3  : Begin
               btnMarcarTodos.Click;
             End;
    VK_F4  : Begin
               btnDesmarcarTodos.Click;
             End;
    VK_F5  : Begin
               btnMarcarAcessEquip.Click;
             End;
  End;
end;

procedure TfrmLiberacaoLocacao.FormShow(Sender: TObject);
begin
  inherited;

  If fCfgSis('PDRCTR', VarBoolean) Then
    pSetFocus(edtNumPed)
  Else
    pSetFocus(edtNumCon);
end;

function TfrmLiberacaoLocacao.fValidaCampos(Sender: TWinControl;
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
    Else If (Sender = edtNroTrc) Then
    Begin
      If Not fEmptyStr(edtNroTrc.Text) Then
      Begin
        Result := fCarregarTroca(edtNroTrc.Text);
      End;
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

function TfrmLiberacaoLocacao.fValidarInspecaoAcessoriosEquipamentosSelecionados: Boolean;
var
  intRecNo: Integer;
  frmObservacao: TfrmObservacao;
  blnExibirMensagem: Boolean;
  intSel: Integer;
  strListaAcessoriosNaoSelecionados: String;
begin
  Result := True;
  blnExibirMensagem := False;
  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  intSel := 0;
  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.Caption := 'Inspeção de Equipamentos ';
    frmObservacao.lblMensagem.Visible := False;
    frmObservacao.memObs.Lines.Add('Há acessórios do(s) equipamento(s) listado(s) abaixo que não foram liberados. ' +
                                   'Finalize a liberação de todos os acessórios dos equipamentos selecionados para continuar.');

    frmObservacao.memObs.Lines.Add('');
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      If cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M' Then
      Begin
        Inc(intSel);
        If Not objContrato.fValidarInspecaoEntradaEquipamentos(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString) Then
        Begin
          frmObservacao.memObs.Lines.Add(ObjContrato.MensagemRetorno);
          blnExibirMensagem := True;
        End;

        strListaAcessoriosNaoSelecionados := fAcessoriosItemSelecionados(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);
        If Not fEmptyStr(strListaAcessoriosNaoSelecionados)Then
        Begin
          frmObservacao.memObs.Lines.Add('Equipamento: ' + cdsEqlDet.FieldByName('EQD_SEQEQL').AsString + ' - ' + cdsEqlDet.FieldByName('EQL_DESCRI').AsString);
          frmObservacao.memObs.Lines.Add('Acessórios:  ');
          frmObservacao.memObs.Lines.Add(strListaAcessoriosNaoSelecionados);

          blnExibirMensagem := True;
        End;

      End;

      cdsEqlDet.Next;
    End;

    If intSel = 0 Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO', 'Nenhum item selecionado!', ['&Ok']);
      Exit;
    End;

    frmObservacao.memObs.SelStart := 0;
    If blnExibirMensagem Then
    Begin
      Result := False;
      frmObservacao.ShowModal;
    End;

  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
    pFreeAndNil(frmObservacao);
  End;
end;

procedure TfrmLiberacaoLocacao.btnConfirmaClick(Sender: TObject);
Begin
  If fConfirmar Then
  Begin
    pMensagemOk('Processo concluído com sucesso!');
    Self.Close;
  End;
End;

procedure TfrmLiberacaoLocacao.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;

  pMarcarTodos(False);
end;

procedure TfrmLiberacaoLocacao.btnMarcarAcessEquipClick(
  Sender: TObject);
begin
  inherited;

  If fMensagem('ATENÇÃO', 'Deseja marcar também os acessórios do equipamento?' , ['&Sim', '&Não']) = 1 Then
  Begin
    pMarcarEquipamento(True, False);
    pMarcarAcessoriosEquipamento(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString, cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M');
  End
  Else
    pMarcarEquipamento(True, False);
end;

procedure TfrmLiberacaoLocacao.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

  pMarcarTodos(True);
end;

procedure TfrmLiberacaoLocacao.cxgrdItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.GridRecord.Values[cxgrdItensViewEQD_MARDES.Index] = 'M' Then
  Begin
    ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmLiberacaoLocacao.cxgrdItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);
    VK_RETURN: pMarcarEquipamento(cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'D');
  End;
end;

procedure TfrmLiberacaoLocacao.cxGridDBTableViewAcessoriosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.GridRecord.Values[cxGridDBTableViewAcessoriosEQD_MARDES.Index] = 'M' Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmLiberacaoLocacao.cxGridDBTableViewAcessoriosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);
    VK_RETURN: pMarcarAcessorio(cdsAcessorios.FieldByName('EQD_MARDES').AsString = 'D');
  End;
end;

procedure TfrmLiberacaoLocacao.edtNroTrcKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqTrocaContrato(Self, edtNroTrc, qryTroca, Key, arrSelTroca) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoLocacao.edtNumConKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel) Then
    fValidaCampos(edtNumCon);
end;

procedure TfrmLiberacaoLocacao.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
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

function TfrmLiberacaoLocacao.fAcessoriosItemSelecionados(const strCodEQL: String): String;
var
  intRecNo: Integer;
  SLListaAcessorios: TStringList;
begin
  If Not grpAcessorios.Visible Then
    Exit;

  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  SLListaAcessorios := TStringList.Create;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      If cdsAcessorios.FieldByName('EQD_SEQEQL').AsString  = strCodEQL Then
      Begin
        If cdsAcessorios.FieldByName('EQD_MARDES').AsString <> 'M' Then
        Begin
          SLListaAcessorios.Add(cdsAcessorios.FieldByName('EQD_SEQACL').AsString + ' - ' + cdsAcessorios.FieldByName('EQD_DESCRI').AsString);
        End;
      End;

      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.RecNo := intRecNo;
    cdsAcessorios.EnableControls;
    Result := SLListaAcessorios.Text;
    FreeAndNil(SLListaAcessorios);
  End;
end;
function TfrmLiberacaoLocacao.fCarregarContrato(
  strNumeroContrato: String; strNumPed: String = '';
  blnExibirMsg: Boolean = True): Boolean;
begin
  pLimparCampos;
  objContrato.pLimpar;
  objContrato.fCarregarContrato('', strNumeroContrato, True, strNumPed);

  If fEmptyStr(objContrato.NroContrato) Then
  Begin
    If blnExibirMsg Then
      fMensagem('ATENÇÃO', 'Contrato não encontrado!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If objContrato.Status = 'O' Then
  Begin
    fMensagem('ATENÇÃO', 'Contrato não está ativo! Favor realizar a ativação do contrato antes da inspeção.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If objContrato.Status = 'F' Then
  Begin
    fMensagem('ATENÇÃO', 'Contrato já faturado.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If objContrato.Status = 'E' Then
  Begin
    fMensagem('ATENÇÃO', 'Contrato Encerrado.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fValidaTravasContrato(objContrato.AutInc) Then
  Begin
    Result := False;
    Exit;
  End;

  edtCodCli.Text := objContrato.CodCliente;
  edtNomCli.Text := objContrato.NomCliente;
  edtCodVen.Text := objContrato.Vendedor.Codigo;
  edtNomVen.Text := objContrato.Vendedor.Nome;
  edtLocalizacao.Text := objContrato.Localizacao;
  edtNumPed.Text := Copy(objContrato.NumDocPedAdiantamento, 0, 12);

  pCarregarEquipamentos;

  If grpAcessorios.Visible Then
    pCarregarAcessorios;

  If cdsEqlDet.RecordCount = 0 Then
  Begin
    If cdsAcessorios.RecordCount = 0 Then
    Begin
      fMensagem('ATENÇÃO', 'O Contrato não possui itens bloqueados.', ['&Ok']);
      objContrato.pLimpar;
      pLimparCampos;
    End;
  End;

  pSetFocus(cxgrdItens);
  cxgrdItensView.DataController.FocusedRowIndex := 0;

  If Not(fEmptyStr(objContrato.AutInc)) Then
    FobjLock.fLock_Unlock(cst_TRAVA_LIBERA_LOCEQU + objContrato.AutInc, True, False);

  Result := True;
end;

function TfrmLiberacaoLocacao.fCarregarTroca(const strNroTrc: String): Boolean;
var
  strAutInc: String;
begin
  Result := False;
  blnCarregandoItens := True;
  Try
    Try
      strAutInc := qryTroca.FieldByName('AUTOINCREM').AsString;

      ObjTroca.pCarregarTroca(strAutInc, strNroTrc);
      ObjContrato := ObjTroca.Contrato;

      edtNumCon.Text := objContrato.NroContrato;
      edtCodCli.Text := objContrato.CodCliente;
      edtNomCli.Text := objContrato.NomCliente;
      edtCodVen.Text := objContrato.Vendedor.Codigo;
      edtNomVen.Text := objContrato.Vendedor.Nome;
      edtLocalizacao.Text := objContrato.Localizacao;

      pCarregarEquipamentosTroca(ObjTroca.ListaEquipamentos);

      If grpAcessorios.Visible Then
        pCarregarAcessoriosTroca(ObjTroca.ListaAcessorios);

      If cdsEqlDet.RecordCount = 0 Then
      Begin
        If cdsAcessorios.RecordCount = 0 Then
        Begin
          fMensagem('ATENÇÃO', 'A troca não possui itens bloqueados.', ['&Ok']);
          objContrato.pLimpar;
          pLimparCampos;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.fCarregarTroca');
      End;
    End;
  Finally
    blnCarregandoItens := False;
  End;

end;

procedure TfrmLiberacaoLocacao.pAtivarAcessorios;
var
  intRecNo: Integer;
begin
  If Not grpAcessorios.Visible Then
    Exit;

  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      If cdsAcessorios.FieldByName('EQD_MARDES').AsString = 'M' Then
      Begin
        TEquipamentoLocacaoAcessorio.pAtivarAcessorio(cdsAcessorios.FieldByName('AUTOINCREM').AsString);
      End;

      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.RecNo := intRecNo;
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmLiberacaoLocacao.pAtivarEquipamentos;
var
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
        TEquipamentoLocacaoPrincipal.pAtivarEquipamento(cdsEqlDet.FieldByName('AUTOINCREM').AsString);
      End;

      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmLiberacaoLocacao.pAtivarItensSelecionados;
begin
  pAtivarEquipamentos;
  pAtivarAcessorios;
end;

procedure TfrmLiberacaoLocacao.pCarregarAcessorios;
var
  intCnt,
  intCont: Integer;
  aItem: TAcessorioContratoLocacaoEquipamentos;
begin
  If Not grpAcessorios.Visible Then
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

          If aItem.Acessorio.Status <> 'B' Then
            Continue;

          cdsAcessorios.Insert;
          cdsAcessorios.FieldByName('EQD_MARDES').AsString := 'D';
          cdsAcessorios.FieldByName('AUTOINCREM').AsString := aItem.Acessorio.AutInc;
          cdsAcessorios.FieldByName('EQD_SEQEQL').AsString := aItem.CodEquipamento;
          cdsAcessorios.FieldByName('EQD_SEQACL').AsString := aItem.Acessorio.Codigo;
          cdsAcessorios.FieldByName('EQD_DESCRI').AsString := aItem.Acessorio.Descricao;
          cdsAcessorios.FieldByName('EQD_QTDACL').AsFloat  := aItem.Quantidade;
          cdsAcessorios.FieldByName('EQD_DTAIPE').AsDateTime := aItem.DataInspecaoEntrada + aItem.HoraInspecaoEntrada;
          cdsAcessorios.FieldByName('EQD_AVARIA').AsString := aItem.Avaria;
          cdsAcessorios.FieldByName('EQD_OBSIPE').AsString := aItem.ObservacoesEntrada;
          If Not fEmptyStr(aItem.CodConferenteEntrada) Then
            cdsAcessorios.FieldByName('EQD_CONFER').AsString := aItem.CodConferenteEntrada + ' - ' + aItem.NomConferenteEntrada;
          If Not fEmptyStr(aItem.CodSupervisorEntrada) Then
            cdsAcessorios.FieldByName('EQD_SUPERV').AsString := aItem.CodSupervisorEntrada + ' - ' + aItem.NomSupervisorEntrada;
          cdsAcessorios.FieldByName('EQA_QTDTOT').AsFloat  := aItem.Quantidade * objContrato.Itens[intCont].Quantidade;

          cdsAcessorios.Post;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmRetornoLocEqu.pCarregarAcessorios]');
      End;
    End;
  Finally
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmLiberacaoLocacao.pCarregarAcessoriosTroca(
  const aListaAcessorios: TList<TAcessorioContratoLocacaoEquipamentos>);
var
  intCnt: Integer;
begin
  If Not grpAcessorios.Visible Then
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
      For intCnt := 0 to aListaAcessorios.Count-1 Do
      Begin
        If aListaAcessorios[intCnt].Acessorio.Status <> 'B' Then
          Continue;

         cdsAcessorios.Insert;
         cdsAcessorios.FieldByName('EQD_MARDES').AsString := 'D';
         cdsAcessorios.FieldByName('AUTOINCREM').AsString := aListaAcessorios[intCnt].Acessorio.AutInc;
         cdsAcessorios.FieldByName('EQD_SEQEQL').AsString := aListaAcessorios[intCnt].CodEquipamento;
         cdsAcessorios.FieldByName('EQD_SEQACL').AsString := aListaAcessorios[intCnt].Acessorio.Codigo;
         cdsAcessorios.FieldByName('EQD_DESCRI').AsString := aListaAcessorios[intCnt].Acessorio.Descricao;
         cdsAcessorios.FieldByName('EQD_QTDACL').AsFloat  := aListaAcessorios[intCnt].Quantidade;
         cdsAcessorios.FieldByName('EQD_DTAIPE').AsDateTime := aListaAcessorios[intCnt].DataInspecaoEntrada + aListaAcessorios[intCnt].HoraInspecaoEntrada;
         cdsAcessorios.FieldByName('EQD_AVARIA').AsString := aListaAcessorios[intCnt].Avaria;
         cdsAcessorios.FieldByName('EQD_OBSIPE').AsString := aListaAcessorios[intCnt].ObservacoesEntrada;
         If Not fEmptyStr(aListaAcessorios[intCnt].CodConferenteEntrada) Then
           cdsAcessorios.FieldByName('EQD_CONFER').AsString := aListaAcessorios[intCnt].CodConferenteEntrada + ' - ' + aListaAcessorios[intCnt].NomConferenteEntrada;
         If Not fEmptyStr(aListaAcessorios[intCnt].CodSupervisorEntrada) Then
           cdsAcessorios.FieldByName('EQD_SUPERV').AsString := aListaAcessorios[intCnt].CodSupervisorEntrada + ' - ' + aListaAcessorios[intCnt].NomSupervisorEntrada;

         cdsAcessorios.Post;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmRetornoLocEqu.pCarregarAcessorios]');
      End;
    End;
  Finally
    cdsAcessorios.EnableControls;
  End;
end;


procedure TfrmLiberacaoLocacao.pCarregarEquipamentos;
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
        If ObjContrato.Itens[intCnt].Equipamento.Status <> 'B' Then
          Continue;

        cdsEqlDet.Insert;
        cdsEqlDet.FieldByName('EQD_MARDES').AsString := 'D';
        cdsEqlDet.FieldByName('AUTOINCREM').AsString := ObjContrato.Itens[intCnt].Equipamento.AutInc;
        cdsEqlDet.FieldByName('EQD_SEQEQL').AsString := ObjContrato.Itens[intCnt].Equipamento.Codigo;
        cdsEqlDet.FieldByName('EQL_DESCRI').AsString := ObjContrato.Itens[intCnt].Equipamento.Descricao;
        cdsEqlDet.FieldByName('EQL_NSERIE').AsString := ObjContrato.Itens[intCnt].Equipamento.NumSerie;
        cdsEqlDet.FieldByName('EQD_DTAIPE').AsDateTime := ObjContrato.Itens[intCnt].DataInspecaoEntrada + ObjContrato.Itens[intCnt].HoraInspecaoEntrada;
        cdsEqlDet.FieldByName('EQD_AVARIA').AsString := ObjContrato.Itens[intCnt].Avaria;
        cdsEqlDet.FieldByName('EQD_OBSIPE').AsString := ObjContrato.Itens[intCnt].ObservacoesEntrada;
        If Not fEmptyStr(ObjContrato.Itens[intCnt].CodConferenteEntrada) Then
          cdsEqlDet.FieldByName('EQD_CONFER').AsString := ObjContrato.Itens[intCnt].CodConferenteEntrada + ' - ' + ObjContrato.Itens[intCnt].NomConferenteEntrada;
        If Not fEmptyStr(ObjContrato.Itens[intCnt].CodSupervisorEntrada) Then
          cdsEqlDet.FieldByName('EQD_SUPERV').AsString := ObjContrato.Itens[intCnt].CodSupervisorEntrada + ' - ' + ObjContrato.Itens[intCnt].NomSupervisorEntrada;
        cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat := ObjContrato.Itens[intCnt].Quantidade;
        cdsEqlDet.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmLiberacaoLocacao.pCarregarEquipamentos]');
      End;
    End;
  Finally
    cdsEqlDet.EnableControls;
    blnCarregandoItens := False;
  End;
end;

procedure TfrmLiberacaoLocacao.pCarregarEquipamentosTroca(const aListaEquipamentos: TList<TItemContratoLocacaoEquipamentos>);
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
      For intCnt := 0 to aListaEquipamentos.Count-1 Do
      Begin
        If aListaEquipamentos[intCnt].Equipamento.Status <> 'B' Then
          Continue;

        cdsEqlDet.Insert;
        cdsEqlDet.FieldByName('EQD_MARDES').AsString := 'D';
        cdsEqlDet.FieldByName('AUTOINCREM').AsString := aListaEquipamentos[intCnt].Equipamento.AutInc;
        cdsEqlDet.FieldByName('EQD_SEQEQL').AsString := aListaEquipamentos[intCnt].Equipamento.Codigo;
        cdsEqlDet.FieldByName('EQL_DESCRI').AsString := aListaEquipamentos[intCnt].Equipamento.Descricao;
        cdsEqlDet.FieldByName('EQL_NSERIE').AsString := aListaEquipamentos[intCnt].Equipamento.NumSerie;
        cdsEqlDet.FieldByName('EQD_DTAIPE').AsDateTime := aListaEquipamentos[intCnt].DataInspecaoEntrada + aListaEquipamentos[intCnt].HoraInspecaoEntrada;
        cdsEqlDet.FieldByName('EQD_AVARIA').AsString := aListaEquipamentos[intCnt].Avaria;
        cdsEqlDet.FieldByName('EQD_OBSIPE').AsString := aListaEquipamentos[intCnt].ObservacoesEntrada;
        If Not fEmptyStr(aListaEquipamentos[intCnt].CodConferenteEntrada) Then
          cdsEqlDet.FieldByName('EQD_CONFER').AsString := aListaEquipamentos[intCnt].CodConferenteEntrada + ' - ' + aListaEquipamentos[intCnt].NomConferenteEntrada;
        If Not fEmptyStr(aListaEquipamentos[intCnt].CodSupervisorEntrada) Then
          cdsEqlDet.FieldByName('EQD_SUPERV').AsString := aListaEquipamentos[intCnt].CodSupervisorEntrada + ' - ' + aListaEquipamentos[intCnt].NomSupervisorEntrada;
        cdsEqlDet.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmLiberacaoLocacao.pCarregarEquipamentos]');
      End;
    End;
  Finally
    cdsEqlDet.EnableControls;
    blnCarregandoItens := False;
  End;
end;

function TfrmLiberacaoLocacao.fConfirmar: Boolean;
var
  strMensagemConfirmacao: String;
begin

  Result := False;
  Try
    strMensagemConfirmacao :=  'Deseja finalizar a rotina e ativar todos os equipamentos ' +
                               IIF(grpAcessorios.Visible, 'e acessórios ', '')  +'selecionados?' ;

    If fValidarInspecaoAcessoriosEquipamentosSelecionados Then
    Begin
      If fMensagem('ATENÇÃO', strMensagemConfirmacao, ['&Sim', '&Não']) = 1 Then
      Begin
        pAtivarItensSelecionados;
        Result := True;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmLiberacaoLocacao.fConfirmar]');
    End;
  End;
end;

procedure TfrmLiberacaoLocacao.pFormatarCampos;
begin
  TTimeField(cdsEqlDet.FieldByName('EQD_DTAIPE')).DisplayFormat  := 'dd/mm/yyyy hh:nn';
  TTimeField(cdsAcessorios.FieldByName('EQD_DTAIPE')).DisplayFormat  := 'dd/mm/yyyy hh:nn';
end;

procedure TfrmLiberacaoLocacao.pLimparCampos;
begin
  inherited;

  edtNumCon.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtLocalizacao.Clear;

end;

procedure TfrmLiberacaoLocacao.pMarcarAcessorio(const blnMarcar: Boolean);
begin
  If Not grpAcessorios.Visible Then
    Exit;

  cdsAcessorios.Edit;
  cdsAcessorios.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsAcessorios.Post;
end;

procedure TfrmLiberacaoLocacao.pMarcarAcessoriosEquipamento(const strCodEql: String;
  const blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  If Not grpAcessorios.Visible Then
    Exit;

  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      If strCodEql = cdsAcessorios.FieldByName('EQD_SEQEQL').AsString  Then
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

procedure TfrmLiberacaoLocacao.pMarcarEquipamento(const blnMarcar: Boolean; blnExibirPergunta: Boolean = True);
begin
  cdsEqlDet.Edit;
  cdsEqlDet.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsEqlDet.Post;

  If Not grpAcessorios.Visible Then
    Exit;

  If blnMarcar Then
  Begin
    If blnExibirPergunta Then
    Begin
      If fMensagem('ATENÇÃO', 'Deseja marcar também os acessórios do equipamento?' , ['&Sim', '&Não']) = 1 Then
        pMarcarAcessoriosEquipamento(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString, cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M');
    End;
  End
  Else
    pMarcarAcessoriosEquipamento(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString, False);
end;

procedure TfrmLiberacaoLocacao.pMarcarTodos(const blnMarcar: Boolean);
begin
  pMarcarTodosEquipamentos(blnMarcar);
  pMarcarTodosAcessorios(blnMarcar);
end;

procedure TfrmLiberacaoLocacao.pMarcarTodosAcessorios(const blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  If Not grpAcessorios.Visible Then
    Exit;

  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      pMarcarAcessorio(blnMarcar);

      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.RecNo := intRecNo;
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmLiberacaoLocacao.pMarcarTodosEquipamentos(const blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      pMarcarEquipamento(blnMarcar);

      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

end.
