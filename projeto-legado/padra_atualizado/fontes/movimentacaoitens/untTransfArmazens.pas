unit untTransfArmazens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, EditFocus,
  Mask, DBCtrls, DBEditFocus, UniClientDataSet,
  untTransferenciaArmazens, BitBtnLockedIncrem,
  Uni, ComCtrls, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, untLiberacao,
  cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog,
  untCadArmazemOperadores;

type
  TfrmTransfArmazens = class(TfrmPaiConfirma)
    pnlCabec: TPanel;
    cxgItensView: TcxGridDBTableViewCitel;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGridCitel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    pnlItem: TPanel;
    dbeCodIte: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    dbeArmOri: TDBEditFocus;
    dbeArmDes: TDBEditFocus;
    dbeSaldos: TDBEditFocus;
    Label1: TLabel;
    lblOrigem: TLabel;
    lblDestino: TLabel;
    Label4: TLabel;
    lblSaldo: TLabel;
    grbOrigem: TGroupBox;
    lblSalOri: TLabel;
    dbeSalOri: TDBEditFocus;
    lblMaxOri: TLabel;
    dbeMaxOri: TDBEditFocus;
    lblRepOri: TLabel;
    dbeRepOri: TDBEditFocus;
    grbDestino: TGroupBox;
    lblSalDes: TLabel;
    lblMaxDes: TLabel;
    lblRepDes: TLabel;
    dbeSalDes: TDBEditFocus;
    dbeMaxDes: TDBEditFocus;
    dbeRepDes: TDBEditFocus;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensARMORI: TStringField;
    cdsItensARMDES: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensSALORI: TFloatField;
    cdsItensSALDES: TFloatField;
    cdsItensMAXORI: TFloatField;
    cdsItensMAXDES: TFloatField;
    cdsItensREPORI: TFloatField;
    cdsItensREPDES: TFloatField;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewTAQtdItem: TcxGridDBColumn;
    cdsItensDESITE: TStringField;
    cdsItensSALDOS: TFloatField;
    btnAdicionar: TBitBtnLocked;
    prgProgresso: TProgressBar;
    cdsItensPRECUS: TFloatField;
    cdsItensTOTCUS: TAggregateField;
    dtsGrid: TDataSource;
    btnExcluir: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    cdsItensLOCORI: TStringField;
    cdsItensLOCDES: TStringField;
    cdsItensDESLFO: TStringField;
    cdsItensDESLFD: TStringField;
    btnCadRapLotWMS: TSpeedButton;
    dbeQtdIte: TDBEditFocus;
    dbeDesMar: TDBEditFocus;
    dbeCodMar: TDBEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    dbeSigUni: TDBEditFocus;
    cdsItensCODMAR: TStringField;
    cdsItensDESMAR: TStringField;
    cdsItensSIGUNI: TStringField;
    cxgItensViewColumn6: TcxGridDBColumn;
    cxgItensViewColumn7: TcxGridDBColumn;
    Label7: TLabel;
    Label8: TLabel;
    dbeSalOriRes: TDBEditFocus;
    dbeSalOriDis: TDBEditFocus;
    Label10: TLabel;
    dbeSalDesRes: TDBEditFocus;
    dbeSalDesDis: TDBEditFocus;
    Label11: TLabel;
    cdsItensSALORIRES: TFloatField;
    cdsItensSALORIDIS: TFloatField;
    cdsItensSALDESRES: TFloatField;
    cdsItensSALDESDIS: TFloatField;
    shpLiberado: TShape;
    edtObse01: TEditFocus;
    edtObse02: TEditFocus;
    lblObserv: TLabel;
    btnImportar: TBitBtnLocked;
    chkLimparFiltros: TCheckBox;
    cdsItensDESAMZLOCORI: TStringField;
    cdsItensDESAMZLOCDES: TStringField;
    cxgItensViewColumn8: TcxGridDBColumn;
    cxgItensViewColumn9: TcxGridDBColumn;
    cdsItensDESAMZORI: TStringField;
    cdsItensDESAMZDES: TStringField;
    cdsItensDESLOCORI: TStringField;
    cdsItensDESLOCDES: TStringField;
    cxgItensViewColumn10: TcxGridDBColumn;
    cxgItensViewColumn11: TcxGridDBColumn;
    dbtAmzOri: TDBText;
    dbtAmzDes: TDBText;
    lblInfoLimparFiltros: TLabel;
    cxgItensViewTAQtdMaxDes: TcxGridDBColumn;
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure cxgItensEnter(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlItemEnter(Sender: TObject);
    procedure pnlItemExit(Sender: TObject);
    procedure dbeArmOriKeyPress(Sender: TObject; var Key: Char);
    procedure dbeArmDesKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnCadRapLotWMSClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure chkLimparFiltrosClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cxgItensViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    objLiberacao : TLiberacao;
    blnLibSenha : Boolean;

    blnTaCapExc : Boolean;

    blnUsaLote : Boolean;
    objTransf: TTransferenciaArmazens;
    strNomSing: String;
    strNomPlur: String;
    blnLiberado: Boolean;
    fltBarEmbala: Double;
    blnPesqITEBAR: Boolean;
    strCodIteOriginal,
    strCodAmzOrigemOriginal: String;
    strIteAlterandoBackup,
    strAmzAlterandoBackup: String;
    blnAlterandoItem: Boolean;
    Function fedtCodIteKeyPressGer(Sender: TObject; var Key: Char): Boolean;
    Procedure pValidaArmazensQuandoNaoLimparFiltros;
    Procedure pAjustarCamposQuandoNaoLimparFiltros;
    Procedure pAssumeQuantidadeBarEmbala;
    Function fRetornaTipoControle: String;
    procedure pLiberaBloqueioDosLotes;

    Function fVerificaCapMaxExc: Boolean;
    procedure pAjustaStatusLote(blnAjustaOrigem: Boolean);

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fNumLotAtivoLocal(ACodIte, AAmzOri, ACodEmp: string): Boolean;
    function fLoteJaInserido(ACodIte, AAmzOri: string): Boolean;
  end;

implementation

uses untFuncoesSimples, untConsultas,untPnlDadosItem, untPanelCxItem, untTypesSistema,
  untCadLoteItens, untPesqAux, untCadLote, untFuncFat, untObservacaoGenerica,
  untIFatEntregaFutura, untTFatEntregaFutura, untTransfArmazensImportacao,
  untIteBar;

{$R *.dfm}

procedure TfrmTransfArmazens.btnImportarClick(Sender: TObject);
var
  frmTransfArmazensImportacao: TfrmTransfArmazensImportacao;
begin
  inherited;
  if fEmptyStr(edtSenDig.Text) then
  begin
    fMensagem('', 'Informe o digitador!', ['&O k']);
    pSetFocus(edtSenDig);
    Exit;
  end;

  pCriarFormularios(TfrmTransfArmazensImportacao, frmTransfArmazensImportacao);
  try
    frmTransfArmazensImportacao.strNomSing := strNomSing;
    frmTransfArmazensImportacao.strNomPlur := strNomPlur;
    if frmTransfArmazensImportacao.ShowModal = MrOK then
    begin
      frmTransfArmazensImportacao.CdsItens.First;
      while not frmTransfArmazensImportacao.CdsItens.Eof do
      begin
        if frmTransfArmazensImportacao.cdsItens.FieldByName('ERRO').AsString = '' then
        begin
          dtsItens.DataSet.Append;
          dtsItens.DataSet.FieldByName('CODITE').AsString := frmTransfArmazensImportacao.CdsItens.FieldByName('ITECOD').AsString;
          dtsItens.DataSet.FieldByName('DESITE').AsString := frmTransfArmazensImportacao.CdsItens.FieldByName('DESITE').AsString;
          dtsItens.DataSet.FieldByName('ARMORI').AsString := frmTransfArmazensImportacao.CdsItens.FieldByName('LOTORI').AsString;
          dtsItens.DataSet.FieldByName('ARMDES').AsString := frmTransfArmazensImportacao.CdsItens.FieldByName('LOTDES').AsString;
          dtsItens.DataSet.FieldByName('QTDITE').AsFloat  := frmTransfArmazensImportacao.CdsItens.FieldByName('ITEQTD').AsFloat;
          objTransf.fCarregaArmazem(True, dtsItens.DataSet.FieldByName('ARMORI').AsString);
          objTransf.fCarregaArmazem(False, dtsItens.DataSet.FieldByName('ARMDES').AsString);

          dtsItens.DataSet.FieldByName('CODMAR').AsString := fRetMarcaItem(dtsItens.DataSet.FieldByName('CODITE').AsString);
          dtsItens.DataSet.FieldByName('DESMAR').AsString := fRetNomMarcaItem(dtsItens.DataSet.FieldByName('CODITE').AsString);
          dtsItens.DataSet.FieldByName('SIGUNI').AsString := fRetSiglaUnidadePorCodIte(dtsItens.DataSet.FieldByName('CODITE').AsString);

          If fVerificaCampos Then
            objTransf.pSalvaItem;
        end;
        frmTransfArmazensImportacao.CdsItens.Next;
      end;
    end;
  finally
    pFreeAndNil(frmTransfArmazensImportacao);
  end;
end;

procedure TfrmTransfArmazens.btnAdicionarClick(Sender: TObject);
var
  strIteBackup, strAmzBackup: string;
begin
  inherited;
  {************************************}
  {*O BOTÃO RECEBE O FOCO PARA O VALOR*}
  {*DO EDTQTD SER ATUALIZADO NO CDS   *}
  {*POIS O CLIENTE USAVA O ATALHO DO  *}
  {*BOTAO CONFIRMAR E O VALOR NÃO ERA *}
  {*ATUALIZADO NO CDS E FICAVA 0(ZERO)*}
  {*********************************GB*}
  pSetFocus(btnAdicionar);

  blnPesqITEBAR := False;
  try
    If fVerificaCampos Then
    With objTransf Do
    Begin
      strIteBackup := strCodIteOriginal;
      strAmzBackup := strCodAmzOrigemOriginal;

      If blnAlterandoItem Then
        pAjustaStatusLote(False);

      try
        pSalvaItem;
      except
        // Quando fValidaCampos já executou pAjustaStatusLote(False) por mudança de armazém,
        // strCodAmzOrigemOriginal foi atualizado para o novo armazém — strAmzBackup estaria errado.
        // strAmzAlterandoBackup preserva o armazém original que foi de fato desbloqueado.
        If blnAlterandoItem Then
        Begin
          If (Not fEmptyStr(strAmzAlterandoBackup)) And
             (Not fEmptyStr(strIteAlterandoBackup)) Then
            objTransf.pBloqueiaArmazemOrigem(strAmzAlterandoBackup, strIteAlterandoBackup, True) // reaplica o lock se o save falhou
          Else If (Not fEmptyStr(strAmzBackup)) And
                  (Not fEmptyStr(strIteBackup)) Then
            objTransf.pBloqueiaArmazemOrigem(strAmzBackup, strIteBackup, True);
        End;

        raise;                   // repropaga a exceção normalmente
      end;

      pAjustarCamposQuandoNaoLimparFiltros;

      If blnAlterandoItem Then
        pAjustaStatusLote(True);

      strCodIteOriginal := '';
      strCodAmzOrigemOriginal := '';
      strIteAlterandoBackup := '';
      strAmzAlterandoBackup := '';
      blnAlterandoItem := False;
      dbeCodIte.Enabled := True;
      pSetFocus(dbeCodIte);
    End;
  Finally
    blnPesqITEBAR := fCfgSis('ITEBAR', varBoolean);
  End;
end;

procedure TfrmTransfArmazens.btnCadRapLotWMSClick(Sender: TObject);
  Var
    frmCadLoteItens: TfrmCadLoteItens;
    strLotCad: String;

  function fDataValidadeLote: String;
    Var
      dtaValidade: TDateTime;
  begin
    dtaValidade := fCampoTabela('LOT_DTAVAL', 'CADLOT',
                               ['LOT_CODITE', 'LOT_NUMLOT', 'LOT_CODEMP'],
                               [dbeCodIte.Text, dbeArmOri.Text, VS_strCodEmp]);
    If dtaValidade < fNow Then
       dtaValidade := fNow;

    If dtaValidade = 0 Then
      Result := ''
    Else
      Result := DateToStr(dtaValidade);
  end;

begin
  inherited;
  If Not btnCadRapLotWMS.Visible Then
    Exit;

  If Not fValidaCampos(dbeArmOri, True) Then
    Exit;

  If Not fVerificaAcessoSistema('frmCadLoteItensRapido') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao cadastro de ' + strNomPlur + '!', ['&O k']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
    frmCadLoteItens.strCodigoItemCadastroRapidoWMS   := dbeCodIte.Text;
    frmCadLoteItens.strDataValidadeCadastroRapidoWMS := fDataValidadeLote;
    frmCadLoteItens.ShowModal;
    strLotCad := frmCadLoteItens.strNumeroLoteCadastroRapidoWMS;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmCadLoteItens);

  //Caso gravou um novo Lote para o produto
  If Not fEmptyStr(strLotCad) Then
  Begin
    dbeArmDes.Text := strLotCad;
    If fValidaCampos(dbeArmDes, True) Then
       SelectNext(dbeArmDes, True, True);
  End;
end;

procedure TfrmTransfArmazens.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  With objTransf Do
  Begin
    If blnAlterandoItem And
       (Not fEmptyStr(strIteAlterandoBackup)) And
       (Not fEmptyStr(strAmzAlterandoBackup)) And
       (strIteAlterandoBackup = dbeCodIte.Text) Then
    Begin
      objTransf.pBloqueiaArmazemOrigem(strAmzAlterandoBackup, strIteAlterandoBackup, True);
      strIteAlterandoBackup := '';
      strAmzAlterandoBackup := '';
    End;

    pCancelaEdicaoItem;

    pAjustarCamposQuandoNaoLimparFiltros;

    strCodIteOriginal := '';
    strCodAmzOrigemOriginal := '';

    blnAlterandoItem := False;
    dbeCodIte.Enabled := True;
    pSetFocus(dbeCodIte);
  End;

end;

procedure TfrmTransfArmazens.btnConfirmaClick(Sender: TObject);
var blnGerarReserva: Boolean;
begin
  If cdsItens.IsEmpty Then
  Begin
    pMensagemOk('Inclua os itens para transferência!');
    Exit;
  End;

  //  inherited;
  If Not fPergunta('Confirma a transferência entre ' + fRetornaTipoControle + '?') Then
    Exit;

  If (Not blnUsaLote) And (blnTaCapExc) Then
  Begin
    If (Not fVerificaCapMaxExc) Then
      Exit;
  End;

  Try
    With objTransf Do
    Begin
      chkLimparFiltros.Checked := True;
      pnlBotoes.Enabled := False;
      pnlCabec.Enabled  := False;
      pnlItem.Enabled   := False;

      pCancelaEdicaoItem(opcGravar);

      (* Se Tiver liberado vai movimentar Saldo e Kardex
       Caso contrario não movimenta Saldo e Kardex *)

      blnGerarReserva := (fCfgSis('CTLEST', VarString) = '2') And (fCfgSis('TRAMZ2', VarString) <> 'N');

      If blnGerarReserva Then
        objTransf.blnFilKar := True
      Else
        objTransf.blnFilKar := Not blnLiberado;

      If fEmptyStr(objTransf.strObservacao) Then
        objTransf.strObservacao :=  fstrInputObservacao('Digite uma observação para esta "TA"');

      objTransf.OnBeforeCommit := pLiberaBloqueioDosLotes;
      If objTransf.fGeraTransferencia(blnUsaLote, True, blnGerarReserva ) Then
      Begin
        If (Not blnUsaLote) And (blnTaCapExc) And (blnLibSenha) Then
          pGeraLogLiberacao(strNumDoc, strEspDoc, VS_strCodEmp);

        If fPergunta('Transferência ' + strEspDoc + '-' + strNumDoc + ' gerada com sucesso! Imprime?') Then
          pImprimeTranferencia;

        FreeAndNil(objTransf);
        cdsItens.EmptyDataSet;
        objTransf := TTransferenciaArmazens.Create(Self, cdsItens, dtsItens, prgProgresso);
        objTransf.BloqueiaLoteOrigem := True;
        edtSenDig.Clear;
        edtNomDig.Clear;
        edtObse01.Clear;
        edtObse02.Clear;
      End;
    End;

  Finally
    blnLibSenha := False;
    objTransf.OnBeforeCommit := nil;
    pnlBotoes.Enabled := True;
    pnlCabec.Enabled  := True;
    pnlItem.Enabled   := True;
    SelectFirst;
  End;

end;

procedure TfrmTransfArmazens.btnExcluirClick(Sender: TObject);
  var
    strCodIte,
    strArmzOri,
    strArmzDes,
    strDesIte,
    strMsg: string;
begin
  inherited;

  If (Not cdsItens.Active) Or (cdsItens.IsEmpty) Then
    Exit;

  // 1. Captura os dados diretamente do DataSet ANTES de qualquer outra ação
  // Isso evita que resets de interface limpem as variáveis
  strCodIte  := cdsItens.FieldByName('CODITE').AsString;
  strDesIte := cdsItens.FieldByName('DESITE').AsString;
  strArmzOri := cdsItens.FieldByName('ARMORI').AsString;
  strArmzDes := cdsItens.FieldByName('ARMDES').AsString;

  if strCodIte = '' then Exit; // Proteção extra

  // Monta a mensagem personalizada
  strMsg := Format('Deseja realmente excluir o produto %s - %s?', [strCodIte, strDesIte]);

  if fPergunta(strMsg) then
  begin
    Try
      // 2. Remove do DataSet principal (o que limpa o Grid)
      cdsItens.Delete;

      // 3. Chama a sua classe de negócio para limpar a cópia interna e gerenciar bloqueios
      // Note que pDeleteRegistroCopia precisa exatamente desses valores para o Locate
      objTransf.pDeleteRegistroCopia(strCodIte, strArmzOri, strArmzDes);
    Finally
      // 4. Reseta o estado de edição da interface
      btnCancelaItem.Click;
      pSetFocus(dbeCodIte);
    End;
  end;
end;

procedure TfrmTransfArmazens.chkLimparFiltrosClick(Sender: TObject);
begin
  inherited;
  objTransf.blnLimparFiltros := chkLimparFiltros.Checked;
  lblInfoLimparFiltros.Visible := Not chkLimparFiltros.Checked;
end;

procedure TfrmTransfArmazens.cxgItensEnter(Sender: TObject);
begin
  inherited;

  If dtsGrid.DataSet.RecordCount <= 0 Then
    Exit;

  With objTransf Do
  Begin
    pCancelaEdicaoItem(opcEditar);
    objTransf.blnSomarQuantidade := False;
  End;

end;

procedure TfrmTransfArmazens.cxgItensViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  If (Not VarIsNull(ACellViewInfo.GridRecord.Values[cxgItensViewColumn1.Index])) And
     (Not fEmptyStr(ACellViewInfo.GridRecord.Values[cxgItensViewColumn3.Index])) Then
  Begin
    strCodIteOriginal := ACellViewInfo.GridRecord.Values[cxgItensViewColumn1.Index];
    strCodAmzOrigemOriginal := ACellViewInfo.GridRecord.Values[cxgItensViewColumn3.Index];
    dbeCodIte.Enabled := False;
    strIteAlterandoBackup := '';
    strAmzAlterandoBackup := '';
    blnAlterandoItem := True;
    pSetFocus(dbeArmOri);
  End;
end;

procedure TfrmTransfArmazens.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if cdsItens.IsEmpty then
    Exit;
  inherited;

  If (Not blnUsaLote) And (blnTaCapExc) Then
  Begin
    If (Not Assigned(cdsItens)) Or (Not cdsItens.Active) Then
      Exit;

    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTAQtdItem.Index] >
        Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTAQtdMaxDes.Index]) And
       (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTAQtdMaxDes.Index] > 0) Then
      ACanvas.Font.Color := clRed;
  End;
end;

procedure TfrmTransfArmazens.cxgItensViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if cdsItens.IsEmpty then
    Exit;
  inherited;

  If (Not blnUsaLote) And (blnTaCapExc) Then
  Begin
    If (Not Assigned(cdsItens)) Or (Not cdsItens.Active) Then
      Exit;

    If (Sender.DataController.Values[AFocusedRecord.RecordIndex, cxgItensViewTAQtdItem.Index] >
        Sender.DataController.Values[AFocusedRecord.RecordIndex, cxgItensViewTAQtdMaxDes.Index]) And
       (Sender.DataController.Values[AFocusedRecord.RecordIndex, cxgItensViewTAQtdMaxDes.Index] > 0) Then
    Begin
      pnlInfo.Font.Color := clRed;
      pnlInfo.Caption := 'Quantidade à transferir maior que a capacidade máxima do armazém de destino';
    End
    Else
    Begin
      pnlInfo.Font.Color := clBlack;
      pnlInfo.Caption := '';
    End;
  End;
end;

procedure TfrmTransfArmazens.dbeArmDesKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqLoteFat(Self, dbeArmDes, fCfgSis('DECUNI'), dbeCodIte.Text,
                  False, False, Nil, Key, arrSel, VS_strCodEmp) And
     fValidaCampos(dbeArmDes, True) Then
   Self.SelectNext(ActiveControl, True, True);

end;

procedure TfrmTransfArmazens.dbeArmOriKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqLoteFat(Self, dbeArmOri, fCfgSis('DECUNI'), dbeCodIte.Text,
                  False, False, Nil, Key, arrSel, VS_strCodEmp) And
     fValidaCampos(dbeArmOri, True) Then
   Self.SelectNext(ActiveControl, True, True);

end;

procedure TfrmTransfArmazens.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pValidaArmazensQuandoNaoLimparFiltros;
end;

procedure TfrmTransfArmazens.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  fedtCodIteKeyPressGer(Sender, Key);

end;

procedure TfrmTransfArmazens.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtSenDig);
end;

procedure TfrmTransfArmazens.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If ( Not cdsItens.IsEmpty) And
     ( Not fPergunta('Deseja cancelar a tarefa?')) Then
  Begin
    Action := caNone;
    Exit;
  End;

  FreeAndNil(objLiberacao);
end;

procedure TfrmTransfArmazens.FormCreate(Sender: TObject);
begin
  inherited;

  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  With cdsItens Do
  Begin
    CreateDataSet;
    Open;
  End;

  objTransf := TTransferenciaArmazens.Create(Self, cdsItens, dtsItens, prgProgresso);
  objTransf.BloqueiaLoteOrigem := True;

  objLiberacao := TLiberacao.Create;
  blnLibSenha := False;

  blnTaCapExc := (fCfgSis('TACAEX', varBoolean));

  strFilRel := 'frmFatVendas_TA';

  strNomSing          := 'Armazém';
  strNomPlur          := 'Armazéns';

  blnUsaLote := (fCfgSis('CTLEST', varString) = '1');
  If blnUsaLote Then
  Begin
    strFilRel           := 'frmFatVendas_TL';
    Caption             := 'Transferência entre Lotes';

    strNomSing          := 'Lote';
    strNomPlur          := 'Lotes';

    lblDestino.Caption  := 'Lote destino:';
    grbDestino.Caption  := 'Lote destino';
    lblMaxDes.Caption   := 'Localização Física:';

    If fCfgSis('CADLOC', VarBoolean) Then
    Begin
      dbeMaxDes.Width     := 245;
      dbeMaxDes.DataField := 'DESLFD';
    End
    Else
      dbeMaxDes.DataField := 'LOCDES';

    lblOrigem.Caption   := 'Lote origem:';
    grbOrigem.Caption   := 'Lote origem';
    lblMaxOri.Caption   := 'Localização Física:';

    If fCfgSis('CADLOC', VarBoolean) Then
    Begin
      dbeMaxOri.Width     := 245;
      dbeMaxOri.DataField := 'DESLFO';
    End
    Else
      dbeMaxOri.DataField := 'LOCORI';

    dbeRepOri.Visible  := False;
    lblRepOri.Visible  := False;
    lblRepDes.Visible  := False;
    dbeRepDes.Visible  := False;
  End;

  If fUsaRotinaWMS Then
  Begin
    lblSalOri.Caption := 'Saldo disponível:';
    lblSalDes.Caption := 'Saldo disponível:';
  End;

  btnCadRapLotWMS.Visible := fUsaRotinaWMS;

  blnPesqITEBAR := fCfgSis('ITEBAR', varBoolean);

  If Not btnCadRapLotWMS.Visible Then
    dbtAmzOri.Left := 190;

  fltBarEmbala := 0;
end;

procedure TfrmTransfArmazens.FormDestroy(Sender: TObject);
begin
  If Assigned(objTransf) Then
    pLiberaBloqueioDosLotes;
  inherited;

end;

procedure TfrmTransfArmazens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If pnlBotoes.Enabled Then
    Case Key Of
      VK_F8    : Begin
                   Key := 0;
                   btnCadRapLotWMS.Click;
                 End;

      VK_F10   : Begin
                   Key := 0;
                   btnConfirma.Click;
                 End;

      VK_DELETE: If fCheckParent(ActiveControl, cxgItens) Then
                   btnExcluir.Click;

      VK_RETURN: If fCheckParent(ActiveControl, cxgItens) And dbeCodIte.CanFocus then
                   pSetFocus(dbeCodIte);
    End;

end;

procedure TfrmTransfArmazens.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;

  { ** sistema verde/vermelho só funciona com Armazém, pois a rotina de liberação de Transferencia ** }
  { ** só fica visível quando é armazém. (untPrincipal->mnuLiberacaoTransferenciaArmazem.Visible)  ** }
  If (fCfgSis('CTLEST', VarString) = '2') And (fCfgSis('TRAMZ2', varString) <> 'N') Then
  begin
    blnLiberado := fVerificaAcessoSistema('F10TRA');

    If (Not blnLiberado) Then
      shpLiberado.Brush.Color  := clRed
    Else
      shpLiberado.Brush.Color  := clGreen;
  End
  Else
  Begin
     blnLiberado := True;
     shpLiberado.Brush.Color  := clGreen;
  End;

end;

function TfrmTransfArmazens.fRetornaTipoControle: String;
begin
  Result := 'lotes';

  If fCfgSis('CTLEST') = '1' Then
    Exit;

  Result := 'armazéns';
end;

function TfrmTransfArmazens.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    blnBuscaCodBar : Boolean;
    qryBusca       : TUniQuery;
    fltQtdTransferir,
    fltQtdUsada: Double;
    intQuantITEBAR: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtSenDig) Then
    Begin
      objTransf.strCodOpe := fRetCodVendedor(edtSenDig.Text);
      edtNomDig.Text := fRetNomVendRep(objTransf.strCodOpe);

      If fEmptyStr(edtNomDig.Text) Then
      Begin
        pMensagemOk('Senha inválida!');
        Result := False;
      End;
    End

    Else If Sender = edtObse01 Then
      objTransf.strMsg001 := edtObse01.Text

    Else If Sender = edtObse02 Then
      objTransf.strMsg002 := edtObse02.Text

    Else If Sender = dbeCodIte Then
    Begin
      If fEmptyStr(dbeCodIte.Text) Then
      Begin
        blnMudarFoco := False;
        pSetFocus(btnConfirma);
      End Else
      Begin
        If blnPesqITEBAR Then
        Begin
          dbeCodIte.Text := fBuscaItemITEBAR(dbeCodIte.Text, intQuantITEBAR);
        End
        Else
        Begin
          If blnBuscaPorChave Then
          Begin
            blnBuscaCodBar := True;
            If (Length(Trim(dbeCodIte.Text)) <= fTamCodIte)  Then
            Begin
              dbeCodIte.Text := fStrZero(dbeCodIte.Text, fTamCodIte);
              blnBuscaCodBar := False;
            End;

            Try
              qryBusca := fCriaQuery(Self);
              pPesquisaCadSem(qryBusca, qryBusca, dbeCodIte.Text, '', blnBuscaCodBar);

              If not qryBusca.IsEmpty Then
              Begin
                dbeCodIte.Text := qryBusca.FieldByName('ITE_CODITE').AsString;
                fltBarEmbala := qryBusca.FieldByName('BAR_EMBALA').AsFloat;
                if Not blnAlterandoItem Then
                  dtsItens.DataSet.FieldByName('QTDITE').AsFloat := qryBusca.FieldByName('BAR_EMBALA').AsFloat;
              End;

            Finally
              FreeAndNil(qryBusca);
            End;
          End;
        End;

        dbeDesIte.Field.Value := fRetNomProduto(dbeCodIte.Text);
          dbeSaldos.Field.Value := fRetornaSaldoDisponivel(dbeCodIte.Text, False, True);
          If (fCfgSis('CALSAL', varInteger)) = 2 And (fCfgSis('ENTFUT', varBoolean)) Then
            dbeSaldos.Field.Value := dbeSaldos.Field.Value + TEntregaFutura.New(
                                                               TParamEF.New()
                                                                 .CodIte(dbeCodIte.Text)
                                                                 .CodEmp(VS_strCodEmp)
                                                                 .TipoTE(tteTodas)
                                                               ).Total();

        dbeCodMar.Field.Value := fRetMarcaItem(dbeCodIte.Text);
        dbeDesMar.Field.Value := fRetNomMarcaItem(dbeCodIte.Text);
        dbeSigUni.Field.Value := fRetSiglaUnidadePorCodIte(dbeCodIte.Text);

        If fEmptyStr(dbeDesIte.Text) Then
        Begin
          pMensagemOk('Produto não encontrado!');
          Result := False;
        End;
      End;
    End

    Else If Sender = dbeArmOri Then
    Begin
      If fUsaEnderecamento And (UpperCase(dbeArmOri.Text) = 'A DEFINIR') Then
      Begin
        fMensagem('','Não é permitido transferir apartir do ' + strNomSing + ' "A Definir" quando utiliza o Endereçamento de Produtos!', ['&OK']);
        Result := False
      End

      Else If Not fNumLotAtivoLocal(dbeCodIte.Text, dbeArmOri.Text, VS_strCodEmp) Then
      Begin
        pMensagemOK('Não é permitido movimentação de estoque para lotes inativos');
        Result := False;
      End

      Else If fVerificaLoteTransitorio(dbeCodIte.Text, dbeArmOri.Text, VS_strCodEmp) Then
      Begin
        pMensagemOK('Não é permitida a seleção de Lotes Transitórios!');
        Result := False;
      End

      Else If fCampoTabela('LOT_CHAPA_', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT' ], [dbeCodIte.Text, VS_strCodEmp, dbeArmOri.Text]) = 'S' Then
      Begin
        pMensagemOK('Não é permitido movimentação de estoque para lotes Mármore/Granito!');
        Result := False;
      End

      Else If TCadLot.fBloqueiaTranfSaldoLote(dbeArmOri.Text, '', dbeCodIte.Text, VS_strCodEmp, True, strNomSing) Then
      Begin
        Result := False;
      End

      Else
        Result := objTransf.fCarregaArmazem(True, dbeArmOri.Text);

      If fCfgSis('CTRAMZ', varBoolean) Then
      Begin
        If Not TfrmCadArmazemOperadores.fOperadorComAcesso(dbeArmOri.Text) Then
        Begin
          pMensagemOk('Esse operador não possui acesso ao armazém ' + QuotedStr(dbeArmOri.Text) + ' nessa empresa, favor verificar o cadastro de controle de armazém por operadores');
          Result := False;
        End;
      End;

      If Result And blnAlterandoItem And (dbeArmOri.Text <> strCodAmzOrigemOriginal) Then
      Begin
        if fEmptyStr(strIteAlterandoBackup) then
        begin
          strIteAlterandoBackup := strCodIteOriginal;
          strAmzAlterandoBackup := strCodAmzOrigemOriginal;
        end;
        pAjustaStatusLote(False);
      End;
    End

    Else If Sender = dbeArmDes Then
    Begin
      If SameText(dbeArmOri.Text, dbeArmDes.Text) Then
      Begin
        pMensagemOk(strNomSing + ' origem deve ser diferente do ' + strNomSing + ' destino!');
        Result := False;
      End

      Else If SameText('A DEFINIR', dbeArmDes.Text) Then
      Begin
        pMensagemOk('O ' + strNomSing + ' A DEFINIR não pode ser utilizado como destino!');
        Result := False;
      End

      Else If Not fNumLotAtivo(dbeCodIte.Text, dbeArmDes.Text, VS_strCodEmp) Then
      Begin
        pMensagemOK('Não é permitido movimentação de estoque para lotes inativos');
        Result := False;
      End

      Else If fVerificaLoteTransitorio(dbeCodIte.Text, dbeArmDes.Text, VS_strCodEmp) Then
      Begin
        pMensagemOK('Não é permitida a seleção de Lotes Transitórios!');
        Result := False;
      End

      Else If fCampoTabela('LOT_CHAPA_', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT' ], [dbeCodIte.Text, VS_strCodEmp, dbeArmDes.Text]) = 'S' Then
      Begin
        pMensagemOK('Não é permitido movimentação de estoque para lotes Mármore/Granito!');
        Result := False;
      End

      Else If TCadLot.fBloqueiaTranfSaldoLote(dbeArmDes.Text, '', dbeCodIte.Text, VS_strCodEmp, True, strNomSing) Then
      Begin
        Result := False;
      End

      Else Result := objTransf.fCarregaArmazem(False, dbeArmDes.Text);

      If fCfgSis('CTRAMZ', varBoolean) Then
      Begin
        If Not TfrmCadArmazemOperadores.fOperadorComAcesso(dbeArmDes.Text) Then
        Begin
          pMensagemOk('Esse operador não possui acesso ao armazém ' + QuotedStr(dbeArmDes.Text) + ' nessa empresa, favor verificar o cadastro de controle de armazém por operadores');
          Result := False;
        End;
      End;

      If Result And
         (dtsItens.DataSet <> cdsItens) {INCUINDO UM NOVO} And
         cdsItens.Locate('CODITE;ARMORI;ARMDES', VarArrayOf([dbeCodIte.Text, dbeArmOri.Text, dbeArmDes.Text]), []) Then
      Begin
        objTransf.pSetaArmazenDestino(dbeArmDes.Text);
        objTransf.pCancelaEdicaoItem(opcEditar);
        objTransf.pEditaItem;
        objTransf.blnSomarQuantidade := Not objTransf.blnLimparFiltros;
      End;

    End

    Else If Sender = dbeQtdIte Then
    Begin
      If fStrToFloat(dbeQtdIte.Text) <= 0 Then
      Begin
        pMensagemOk('A quantidade transferida deve ser maior que zero!');
        Result := False;
      End
      Else If blnUsaLote Then
      Begin
        fltQtdTransferir := fStrToFloat(dbeQtdIte.Text);
        fltQtdUsada := (objTransf.fSomaTotalTransferidoOrigem(dbeCodIte.Text, dbeArmOri.Text,
                       0, (dtsItens.DataSet <> cdsItens)));

        If (fStrToFloat(dbeSalOriDis.Text) - fltQtdTransferir - fltQtdUsada) < 0 Then
        Begin
          pMensagemOk('Não há saldo suficiente para essa transferência!');
          Result := False;
        End;
      End

      Else If fStrToFloat(dbeQtdIte.Text) > fStrToFloat(dbeSalOriDis.Text)  Then
      Begin
        pMensagemOk('Não há saldo suficiente para essa transferência!');
        Result := False;
      End

      Else If (Not blnUsaLote) and (objTransf.fSomaTotalTransferidoOrigem(dbeCodIte.Text, dbeArmOri.Text,
         fStrToFloat(dbeQtdIte.Text), (dtsItens.DataSet <> cdsItens)) > fStrToFloat(dbeSalOriDis.Text)) Then
      Begin
        pMensagemOk('A quantidade total transferida no documento excede o saldo do ' + strNomSing + 'origem!');
        Result := False;
      End

      Else If (Not blnTaCapExc) Then
      Begin
        If  (Not blnUsaLote) and (fStrToFloat(dbeQtdIte.Text) > (fStrToFloat(dbeMaxDes.Text) - fStrToFloat(dbeSalDes.Text))) And
                                      (fStrToFloat(dbeMaxDes.Text) > 0) Then
        Begin
          pMensagemOk('Quantidade excede a capacidade máxima do destino!');
          Result := False;
        End

        Else If (Not blnUsaLote) and
                (fStrToFloat(dbeMaxDes.Text) > 0) And
                (objTransf.fSomaTotalTransferidoDestino(dbeCodIte.Text, dbeArmDes.Text,
           fStrToFloat(dbeQtdIte.Text),(dtsItens.DataSet <> cdsItens)) > (fStrToFloat(dbeMaxDes.Text) - fStrToFloat(dbeSalDes.Text))) Then
        Begin
          pMensagemOk('A quantidade total transferida no documento excede a capacidade do destino!');
          Result := False;
        End

      End

    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmTransfArmazens.fVerificaCapMaxExc: Boolean;
  Var
    fltTotalTransf: Double;
    strFilter : String;
    intRecNo: Integer;
    strCodIte: String;
    strIndexField: String;
begin
  Result := True;
  cdsItens.DisableControls;
  strFilter := '';
  intRecNo := 0;
  if cdsItens.Filtered then
  begin
    intRecNo:= cdsItens.RecNo;
    cdsItens.Filtered := False;
    strFilter := cdsItens.Filter;
  end;

  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE TRANSFERÊNCIA ENTRE ARMAZÉNS - CAPACIDADE MÁXIMA EXCEDIDA NO DESTINO');
    objLiberacao.objMsgLibera.pAddSeparador(81);

    strIndexField := cdsItens.IndexFieldNames;
    cdsItens.IndexFieldNames := 'CODITE';

    strCodIte := '';

    If (Not cdsItens.IsEmpty) Then
    Begin
      cdsItens.First;
      While (Not cdsItens.Eof) Do
      Begin
        if strCodIte = cdsItens.FieldByName('CODITE').AsString  then
        Begin
          cdsItens.Next;
          Continue;
        End;

        strCodIte := cdsItens.FieldByName('CODITE').AsString;

        fltTotalTransf := objTransf.fSomaTotalTransferidoDestino(cdsItens.FieldByName('CODITE').AsString, cdsItens.FieldByName('ARMDES').AsString,
                          0, True) + cdsItens.FieldByName('SALDES').AsFloat;

        If (cdsItens.FieldByName('MAXDES').AsFloat > 0) And
           (fltTotalTransf > cdsItens.FieldByName('MAXDES').AsFloat) Then
        Begin
          objLiberacao.objMsgLibera.pAddSeparador(81);
          objLiberacao.objMsgLibera.pAddTextoCaption('PRODUTO'           , cdsItens.FieldByName('CODITE').AsString + ' - ' + cdsItens.FieldByName('DESITE').AsString          , 20);
          objLiberacao.objMsgLibera.pAddTextoCaption('ARMAZÉM ORIGEM'    , cdsItens.FieldByName('ARMORI').AsString                                                            , 20);
          objLiberacao.objMsgLibera.pAddTextoCaption('ARMAZÉM DESTINO'   , cdsItens.FieldByName('ARMDES').AsString                                                            , 20);
          objLiberacao.objMsgLibera.pAddTextoCaption('CAPACIDADE MÁXIMA' , FormatFloat('#,##0.00', cdsItens.FieldByName('MAXDES').AsFloat)                                    , 20);
          objLiberacao.objMsgLibera.pAddTextoCaption('SALDO ATUAL'       , FormatFloat('#,##0.00', cdsItens.FieldByName('SALDESDIS').AsFloat)                                 , 20);
          objLiberacao.objMsgLibera.pAddTextoCaption('QTDE. TRANSFERIDA' , FormatFloat('#,##0.00', cdsItens.FieldByName('QTDITE').AsFloat)                                    , 20);
          objLiberacao.objMsgLibera.pAddTextoCaption('SALDO FINAL'       , FormatFloat('#,##0.00', fltTotalTransf)                                                            , 20);
          objLiberacao.objMsgLibera.pAddTextoCaption('QTDE. EXCEDENTE'   , FormatFloat('#,##0.00', (fltTotalTransf - cdsItens.FieldByName('MAXDES').AsInteger))               , 20);
          objLiberacao.objMsgLibera.pAddSeparador(81);

          Result := False;
        End;

        cdsItens.Next;
      End;
    End;

    If (Not Result) Then
    Begin
      objLiberacao.strDirAce := 'TACAPMAXDES';
      objLiberacao.strMsgSen := 'Liberar Transferência entre Armazéns com quantidade maior que a Capacidade Máxima do Armazén Destino';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      If objLiberacao.fLibera Then
      Begin
        blnLibSenha := True;
        Result := True;
      End
      Else
      Begin
        blnLibSenha := False;
        Result := False;
      End;
    End;
  Finally
    If strFilter <> '' Then
    begin
      cdsItens.Filter := strFilter;
      cdsItens.Filtered := True;
      cdsItens.RecNo := intRecNo;
    end;
    cdsItens.IndexFieldNames := strIndexField;

    cdsItens.EnableControls;
  End;
end;

procedure TfrmTransfArmazens.pAjustarCamposQuandoNaoLimparFiltros;
begin
  objTransf.blnSomarQuantidade := False;

  If objTransf.blnLimparFiltros Then
    Exit;

  dbeCodite.Field.Clear;
  dbeDesIte.Field.Clear;

  dbeCodMar.Field.Clear;
  dbeDesMar.Field.Clear;
  dbeSigUni.Field.Clear;

  dbeSaldos.Field.Clear;

  dbeSalOri.Field.Clear;
  dbeSalOriRes.Field.Clear;
  dbeSalOriDis.Field.Clear;
  dbeMaxOri.Field.Clear;
  dbeRepOri.Field.Clear;
  dbeSalDes.Field.Clear;
  dbeSalDesRes.Field.Clear;
  dbeSalDesDis.Field.Clear;
  dbeMaxDes.Field.Clear;
  dbeRepDes.Field.Clear;
end;

procedure TfrmTransfArmazens.pAjustaStatusLote(blnAjustaOrigem: Boolean);
begin
  if (Not blnAjustaOrigem) And
     (Not fEmptyStr(dbeCodIte.Text)) And
     (Not fEmptyStr(dbeArmOri.Text)) And
     (Not fEmptyStr(strCodIteOriginal)) And
     (Not fEmptyStr(strCodAmzOrigemOriginal)) And
     ((strCodIteOriginal <> dbeCodIte.Text) Or
      (strCodAmzOrigemOriginal <> dbeArmOri.Text)) Then
   Begin
     objTransf.pBloqueiaArmazemOrigem(strCodAmzOrigemOriginal,
                                      strCodIteOriginal,
                                      False);

     strCodIteOriginal := dbeCodIte.Text;
     strCodAmzOrigemOriginal := dbeArmOri.Text;
   End;

   if blnAjustaOrigem Then
   Begin
     objTransf.pBloqueiaArmazemOrigem(strCodAmzOrigemOriginal,
                                      strCodIteOriginal,
                                      True);
   End;
end;

procedure TfrmTransfArmazens.pAssumeQuantidadeBarEmbala;
begin
  If fltBarEmbala <= 0 Then
    Exit;

  dtsItens.DataSet.FieldByName('QTDITE').AsFloat := fltBarEmbala;
  fltBarEmbala := 0;
end;

procedure TfrmTransfArmazens.pLiberaBloqueioDosLotes;
begin
  cdsItens.First;
  while not cdsItens.Eof Do
  Begin
    objTransf.pBloqueiaArmazemOrigem(cdsItens.FieldByName('ARMORI').AsString,
                                     cdsItens.FieldByName('CODITE').AsString,
                                     False);
    cdsItens.Next;
  End;
end;

procedure TfrmTransfArmazens.pnlItemEnter(Sender: TObject);
begin
  inherited;

  objTransf.pEditaItem;

end;

procedure TfrmTransfArmazens.pnlItemExit(Sender: TObject);
begin
  inherited;

  objTransf.pCancelaEdicaoItem;

end;

procedure TfrmTransfArmazens.pValidaArmazensQuandoNaoLimparFiltros;
begin
  If objTransf.blnLimparFiltros Then
    Exit;

  If fEmptyStr(dbeCodIte.Text) Then
    Exit;

  If fEmptyStr(dbeArmOri.Text) Then
    Exit;

  If fEmptyStr(dbeArmDes.Text) Then
    Exit;

  If Not fValidaCampos(dbeArmOri) Then
    Exit;

  If Not fValidaCampos(dbeArmDes) Then
    Exit;

  pAssumeQuantidadeBarEmbala;

  pSetFocus(dbeQtdIte);
end;

Function TfrmTransfArmazens.fedtCodIteKeyPressGer(Sender: TObject;
  var Key: Char): Boolean;
  Var
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    qryConCit: TUniQuery;
begin
  If (fEntraCons(Key))         And
     (Not dbeCodIte.ReadOnly)  Then
  Begin
    Try
      qryConCit := fCriaQuery(Self);
      objfrmPnl := TPanelCxItem.New();

      Try
        objFrmPnl.strNomForm := Self.Name;
        objFrmPnl.recParametros.strCodCli  := '';
        objFrmPnl.strCodVen  := '';
        objFrmPnl.strCodDig  := '';
        objFrmPnl.intPraMedio:= 0;
        objFrmPnl.recParametros.strTabPre  := '1';

        If fPesqItem(conIteCompleta,
                     Self,
                     dbeCodIte,
                     dbeDesIte,
                     qryConCit,
                     Key,
                     arrSel,
                     True,
                     objfrmPnl,
                     'Consulta de Itens',
                     objFrmPnl.recParametros.strTabPre,
                     '',
                     0,
                     false,
                     false,
                     0) Then
        Begin
          If blnPesqITEBAR Then
            dbeCodIte.Text := fBuscaCodBarraITEBAR(dbeCodIte.Text);


          If fValidaCampos(dbeCodIte) Then
            SelectNext(ActiveControl, True, True);

        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmEntNFEDigManualEdit.fedtCodIteKeyPressGer]');
        End;
      End;


    Finally
      FreeAndNil(objfrmPnl);
      FreeAndNil(qryConCit);
    End;

  End;

  Result := True;

end;

function TfrmTransfArmazens.fLoteJaInserido(ACodIte, AAmzOri: string): Boolean;
var recNo: integer;
begin
  Result := False;
  If blnAlterandoItem Then
    Exit;

  recNo := cdsItens.RecNo;
  Try
    cdsItens.First;
    while not cdsItens.Eof do
    begin
      If (cdsItens.FieldByName('CODITE').AsString = ACodIte) And
         (cdsItens.FieldByName('ARMORI').AsString = AAmzOri) Then
        Exit(True);
      cdsItens.Next;
    End;
  Finally
    cdsItens.RecNo := recNo;
  End;
end;

function TfrmTransfArmazens.fNumLotAtivoLocal(ACodIte, AAmzOri,
  ACodEmp: string): Boolean;
begin
  Result := fLoteJaInserido(ACodIte, AAmzOri);
  If Not Result then
    Result := fNumLotAtivo(ACodIte, AAmzOri, ACodEmp);
end;

end.
