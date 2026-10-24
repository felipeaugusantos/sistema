unit untFatEfetivarItensOrcamentoEmPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, DB, Uni, BitBtnLockedIncrem, Mask, MaskEditFocus, untTypesSistema,
  cxProgressBar, TypInfo, untGravarOrcamentoComoPedido, frxClass, frxExportCSVTestabilidade,
  Vcl.Grids, DBGridCitel, Vcl.DBGrids, UniClientDataSet, UniDataSetProvider, untMsgInterna,
  untLiberacao, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid;

type
  TfrmFatEfetivarItensOrcamentoEmPedido = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlBusca: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtNumDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    pnlForPagAtu: TPanel;
    lbl7: TLabel;
    edtForPagAtu: TEditFocus;
    edtDesFpgAtu: TEditFocus;
    pnl2: TPanel;
    lbl8: TLabel;
    edtCodCndAtu: TEditFocus;
    mskCndPagAtu: TMaskEditFocus;
    edtDesCndAtu: TEditFocus;
    pnl3: TPanel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edtCodCli: TEditFocus;
    edtDtaEnt: TEditFocus;
    edtDesCli: TEditFocus;
    edtVlrCon: TEditFocus;
    pnlItens: TPanel;
    lbl3: TLabel;
    edtCodVen: TEditFocus;
    Label1: TLabel;
    edtTotPro: TEditFocus;
    Label2: TLabel;
    edtDesEsp: TEditFocus;
    Label3: TLabel;
    edtTotIpi: TEditFocus;
    edtTotRet: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    edtDesAce: TEditFocus;
    Label6: TLabel;
    edtTotFre: TEditFocus;
    lblTotCBS: TLabel;
    lblTotIBS: TLabel;
    lblTotIS: TLabel;
    edtTotCBS: TEditFocus;
    edtTotIBS: TEditFocus;
    edtTotIS: TEditFocus;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    Label7: TLabel;
    dbgItensDBTableView: TcxGridDBTableViewCitel;
    dbgItensLevel1: TcxGridLevel;
    dbgItens: TcxGridCitel;
    ITE_CODITE: TcxGridDBColumn;
    ITE_DESITE: TcxGridDBColumn;
    ITE_SIGUNI: TcxGridDBColumn;
    ITE_QTDITE: TcxGridDBColumn;
    ITE_UNITAR: TcxGridDBColumn;
    ITE_TOTITE: TcxGridDBColumn;
    ITE_CODFAB: TcxGridDBColumn;
    ITE_SEQDET: TcxGridDBColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaErro(Sender: TWinControl; strMsgErro: string;
      E: Exception);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure dbgItensDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    dtsDados : TDataSource;
    cdsDados : TUniClientDataSet;

    cdsVendaBkp : TUniClientDataSet;

    intSemaforoValidar : Integer;

    objGravarDoc: TGravarOrcamentoComoPedido;

    stlSelecionados: TStringList;

    cdsInfAdcItem : TUniClientDataSet;
    objLiberacao : TLiberacao;

    procedure pCriarObjetoGravarDoc_Singleton;

    procedure pLimparTela;
    procedure pAtualizaDadosDocumento;

    procedure pAfterOpen(DataSet: TDataSet);

    procedure pSelecionarItensDoPedido;

    procedure pLimparItens;

    procedure pCriaClientInfAdcItem;
    procedure pProcessaClientInfAdcItem;
    procedure pConfirmar;

    function fCarregarDocumento(): Boolean;
    function fExecutarCarregarDocumento(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pLimparDadosFaturamento;
    procedure pLimparDadosFaturamentoItem(strAutIncFdo: String);

    function fLimparDadosFaturamentoItensNaoSelecionados: Boolean;
    function fPermiteCalcularPesoBrutoELiquido: Boolean;

    function fRetTipFat: String;

  public
    { Public declarations }
    arrIteExpPed : TItensExpedidosPedido;
    strNumOrc, strEmpOrc: String;
    blnGravouPedido: Boolean;
    blnOrigemCrm: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;
  end;

var
  frmFatEfetivarItensOrcamentoEmPedido: TfrmFatEfetivarItensOrcamentoEmPedido;

implementation

uses StrUtils, untConsultas, untPanelCxPedOrc, System.UITypes, untPnlDadosPedOrc,
     untFuncoes, untConstantes, untFuncoesSimples, untFuncFat, untGravando, untDigOcorrencia,
     untAdiantamentoCliente, untIFatReservaSaldo,
     untTFatReservaSaldo, untTFatReprocessarSaldoItem;

{$R *.dfm}

procedure TfrmFatEfetivarItensOrcamentoEmPedido.btnConfirmaErro(Sender: TWinControl;
  strMsgErro: string; E: Exception);
begin
  inherited;
  If E Is EAbort Then
    Exit;

  If E Is Exception Then
    pMensagensErro(E.Message, '');
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.btnDesmarcarClick(
  Sender: TObject);
begin
  inherited;
  stlSelecionados.Clear;
  dbgItensDBTableView.DataController.Refresh;
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.btnMarcarClick(Sender: TObject);
begin
  inherited;
  If Not cdsDados.Active Then
    Exit;

  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    If stlSelecionados.IndexOf(cdsDados.FieldByName('ITE_SEQDET').AsString) = -1 Then
      stlSelecionados.Add(cdsDados.FieldByName('ITE_SEQDET').AsString);
    cdsDados.Next;
  End;
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.dbgItensDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if (not cdsDados.Active) then
    Exit;

  if (cdsDados.IsEmpty) then
    Exit;

  if (stlSelecionados.IndexOf(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, ITE_SEQDET.Index])) >= 0) then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clMoneyGreen;
    end;
  end;

end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.edtNumDocKeyPress(Sender: TObject; var Key: Char);
  Var
    arrDoc    : TConsultasArray;
    qryFatGor : TUniQuery;
begin
  Try
    inherited;

    If fEntraCons(Key) And (Not edtNumDoc.ReadOnly) Then
    Begin
      qryFatGor := fCriarQuery('SELECT * FROM FATGOR F ' +
                               'LEFT JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM ' +
                               'LEFT JOIN SERGOR S ON S.FGO_SEQFGO = F.AUTOINCREM ' +
                               'WHERE FALSE', Self);

      If fPesqPedOrc(conPedDigDoc, Self, 'OR', 'OR', VS_strCodEmp, edtNumDoc, edtEspDoc, edtCodEmp, qryFatGor, Key, arrDoc) Then
      Begin
        edtNumDoc.Text := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
        fValidaCampos(edtNumDoc);
      End;

      FreeAndNil(qryFatGor);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatEfetivarItensOrcamentoEmPedido.edtNumDocKeyPress]');
  End;
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pSelecionarItensDoPedido;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If cdsVenda.Locate('ITE_SEQDET', cdsDados.FieldByName('ITE_SEQDET').AsString, []) Then
      Begin
        If stlSelecionados.IndexOf(cdsDados.FieldByName('ITE_SEQDET').AsString) = -1 Then
          cdsVenda.Delete;
      End;
      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
  End;
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('ITE_TOTITE') <> nil Then
      TFloatField(FieldByName('ITE_TOTITE')).DisplayFormat := fMskDigitos(2);

    If FindField('ITE_UNITAR') <> nil Then
      TFloatField(FieldByName('ITE_UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

    If FindField('ITE_QTDITE') <> nil Then
      TFloatField(FieldByName('ITE_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  End;
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pAtualizaDadosDocumento;
begin
  With objGravarDoc.objVenda, objGravarDoc.qryFatGor Do
  Begin
    edtCodCli.Text    := strCodCli;
    edtDesCli.Text    := strCliNom;
    edtCodCndAtu.Text := strCodCnd;
    mskCndPagAtu.Text := strConPag;
    edtDesCndAtu.Text := strDesCnd;
    edtForPagAtu.Text := strCodFpg;
    edtDesFpgAtu.Text := strDesFpg;
    edtCodVen.Text    := strCodVen + ' - ' + strNomVen;

    edtDtaEnt.Text := FormatDateTime('DD/MM/YYYY', FieldByName('FGO_DTAENT').AsDateTime);

    edtTotPro.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTPRO').AsFloat);
    edtDesEsp.Text := FormatFloat('##,#0.00', FieldByName('FGO_DESESP').AsFloat);
    edtTotIpi.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTIPI').AsFloat);
    edtTotRet.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTRET').AsFloat);
    edtDesAce.Text := FormatFloat('##,#0.00', FieldByName('FGO_DESACE').AsFloat);
    edtTotFre.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTFRE').AsFloat);
    edtTotCBS.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTCBS').AsFloat);
    edtTotIBS.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTIBS').AsFloat);
    edtTotIS.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOT_IS').AsFloat);
    lblTotCBS.Visible := fSomarNovosImpostosDaReformaAoValorContabil;
    edtTotCBS.Visible := lblTotCBS.Visible;
    lblTotIBS.Visible := lblTotCBS.Visible;
    edtTotIBS.Visible := lblTotCBS.Visible;
    lblTotIS.Visible := lblTotCBS.Visible;
    edtTotIS.Visible := lblTotCBS.Visible;
    edtVlrCon.Text := FormatFloat('##,#0.00', FieldByName('FGO_VLRCON').AsFloat);

    pCloneDataSet(cdsDados, cdsVenda);

    pProcessaClientInfAdcItem;

    pnlItens.Enabled  := True;
    pnlBusca.Enabled  := False;
    btnConfirma.Enabled := True;
    btnMarcar.Enabled := True;
    btnDesmarcar.Enabled := True;

    cdsDados.FieldByName('ITE_QTDITE').FocusControl;
    pSetFocus(dbgItens);
  End;
end;

function TfrmFatEfetivarItensOrcamentoEmPedido.fExecutarCarregarDocumento(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  Try
    objGravarDoc.pgbProgresso := pgbStatus;

    If GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil Then
      objGravarDoc.lblInformacao := TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando'));

    objGravarDoc.strNumOrc := edtNumDoc.Text;
    objGravarDoc.strEmpOrc := edtCodEmp.Text;
    objGravarDoc.blnOrigemCrm := blnOrigemCrm;

    Result := objGravarDoc.fCarregarOrcamento;

    If Result Then
    Begin
      pAtualizaDadosDocumento;
      pCloneDataSet(cdsVendaBkp, cdsVenda);
    End;
  Finally
    objGravarDoc.pgbProgresso := nil;
    objGravarDoc.lblInformacao := nil;
  End;
end;

function TfrmFatEfetivarItensOrcamentoEmPedido.fLimparDadosFaturamentoItensNaoSelecionados: Boolean;
begin
  Try
    fStartTransaction;

    With cdsDados Do
    Begin
      First;
      While Not Eof Do
      Begin
        If stlSelecionados.IndexOf(FieldByName('ITE_SEQDET').AsString) = -1 Then
        Begin
          pLimparDadosFaturamento;
          pLimparDadosFaturamentoItem(FieldByName('ITE_SEQDET').AsString);
        End;
        Next;
      End;
    End;

    fCommit;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollback;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

function TfrmFatEfetivarItensOrcamentoEmPedido.fCarregarDocumento: Boolean;
  Var
    frmGravando: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fExecutarCarregarDocumento;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'');
    End;
  End;
  pFreeAndNil(frmGravando);
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pCriaClientInfAdcItem;
begin
  cdsInfAdcItem := TUniClientDataSet.Create(Self);

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_SEQDET';
    DataType := ftString;
    Size := 20;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESESP';
    DataType := ftFloat;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_VALFRE';
    DataType := ftFloat;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESACE';
    DataType := ftFloat;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_TOTITE';
    DataType := ftFloat;
  End;

  cdsInfAdcItem.CreateDataSet;
  cdsInfAdcItem.IndexFieldNames := 'ITE_SEQDET';
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pCriarObjetoGravarDoc_Singleton;
begin

  If Assigned(objGravarDoc) Then
    FreeAndNil(objGravarDoc);

  objGravarDoc := TGravarOrcamentoComoPedido.Create(Self);
  objGravarDoc.objVenda.blnSolicitouFecharOREmPD := True;

  If (objGravarDoc.objVenda.blnLiberacaoRemotaNoFinalVenda) Then
    objGravarDoc.objVenda.pMontaArrayTravasLogAviFinalVenda;

  If (fCfgSis('TRAREM', varInteger) = 2) And (fCfgSis('HABREM', varBoolean)) Then
    If (Not fCfgSis('EXITRA', varBoolean)) Then
      untFuncFat.blnExibeTravas := False;

end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pLimparTela;
  Const
    TAG_NAO_LIMPAR = 1;
    TAG_VALORES = 2;
  Var
    intIdx: Integer;
begin
  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx].Tag <> TAG_NAO_LIMPAR Then
    Begin
      If Self.Components[intIdx] Is TEditFocus Then
        If Self.Components[intIdx].Tag = TAG_VALORES Then
          (Self.Components[intIdx] As TEditFocus).Text := '0,00'
        Else
          (Self.Components[intIdx] As TEditFocus).Clear;

      If Self.Components[intIdx] Is TMaskEditFocus Then
        (Self.Components[intIdx] As TMaskEditFocus).Clear;
    End;
  End;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  edtEspDoc.Text := 'OR';

  btnConfirma.Enabled   := False;
  btnMarcar.Enabled     := False;
  btnDesmarcar.Enabled  := False;
  pnlItens.Enabled      := False;
  pnlBusca.Enabled      := True;

  pSetFocus(edtNumDoc);
  pLimparItens;
  stlSelecionados.Clear;

  pCriarObjetoGravarDoc_Singleton;

end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pProcessaClientInfAdcItem;
  Var
    qryFatDor: TUniQuery;
begin
  qryFatDor := fCriaQuery(nil);

  qryFatDor.Sql.Text := 'SELECT FDO_DESESP, FDO_TOTFRE, FDO_DESACE, FDO_TOTITE ' +
                        'FROM FATDOR WHERE AUTOINCREM = :AUTINC ';

  cdsInfAdcItem.EmptyDataSet;

  cdsVenda.First;
  While Not cdsVenda.Eof Do
  Begin

    If Not cdsInfAdcItem.FindKey([cdsVenda.FieldByName('ITE_SEQDET').AsString]) Then
    Begin
      qryFatDor.Close;
      qryFatDor.ParamByName('AUTINC').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
      qryFatDor.Open;

      cdsInfAdcItem.Append;
      cdsInfAdcItem.FieldByName('ITE_SEQDET').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
      cdsInfAdcItem.FieldByName('ITE_DESESP').AsFloat  := qryFatDor.FieldByName('FDO_DESESP').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_VALFRE').AsFloat  := qryFatDor.FieldByName('FDO_TOTFRE').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_DESACE').AsFloat  := qryFatDor.FieldByName('FDO_DESACE').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_TOTITE').AsFloat  := qryFatDor.FieldByName('FDO_TOTITE').AsFloat;
      cdsInfAdcItem.Post;
    End;

    cdsVenda.Next;
  End;

  FreeAndNil(qryFatDor);
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pLimparItens;
begin
  cdsDados.EmptyDataSet;
end;

function TfrmFatEfetivarItensOrcamentoEmPedido.fPermiteCalcularPesoBrutoELiquido: Boolean;
begin
  Result := (Not fPermiteInformarPesoNoPedidoDeVenda);
end;

function TfrmFatEfetivarItensOrcamentoEmPedido.fRetTipFat: String;
var
  fltValFat: Double;
  strTipFat: String;
begin
  Result := fCfgSis('TIPFAT');

  if fEmptyStr(objGravarDoc.objVenda.strCodCli) then
    Exit;

  fltValFat := fCampoTabela('CLI_FTNFES', 'CADCLI', ['CLI_CODCLI'], [objGravarDoc.objVenda.strCodCli], False);
  strTipFat := fCampoTabela('CLI_TIPFAT', 'CADCLI', ['CLI_CODCLI'], [objGravarDoc.objVenda.strCodCli], False);

  if (fCfgSis('TIPFAT', varString) = 'E') and (fCfgSis('FTNFES', varBoolean)) and (fCfgSis('SOLFNE', varBoolean)) then
    Result := IIF(fEmptyStr(strTipFat), 'A', strTipFat)
  else if (fCfgSis('FTNFES', varBoolean)) and (fltValFat > 0) then
    Result := strTipFat;

  if Result = 'E' then
    Result := 'A';
end;

function TfrmFatEfetivarItensOrcamentoEmPedido.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    blnJaFatu,
    blnJaBaix,
    blnImpresso,
    blnSepImpresso: Boolean;
    strCodRom: String;
    strCodVen: String;

    function fDocEmRomaneio: Boolean;
    Begin
      strCodRom := '';
      If (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        strCodRom := fDocumentoEmRomaneio(edtNumDoc.Text, edtEspDoc.Text);
      End;
      Result := Not fEmptyStr(strCodRom);
    End;

begin

  Result    := True;
  blnJaFatu := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin

      If InterlockedIncrement(intSemaforoValidar) = 0 Then
      Begin

        Try

          If fEmptyStr(edtNumDoc.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O número do documento deve ser informado!', ['&O k']);
            Result := False;
          End

          Else If (Pos(edtEspDoc.Text, 'OR_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Espécie deve ser OR!', ['&O k']);
            Result := False;
          End

          Else If (Not fDocumentoFatExiste(objGravarDoc.qryFatGor, edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, blnJaFatu, blnJaBaix, blnImpresso, strCodVen, blnSepImpresso)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse documento não está cadastrado!', ['&O k']);
            Result := False;
          End

          Else If (blnJaFatu) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse documento já foi faturado!', ['&O k']);
            Result := False;
          End

          Else If (fPedidoFaturadoParcialmente(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Documento faturado parcialmente não pode ser alterado!', ['&O k']);
            Result := False;
          End

          Else If fTemServico(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, '') Then
          Begin
            fMensagem('','Documento com serviços não pode ser alterado!',['&OK']);
            Result := False;
          End

          Else If fTemVidro(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
          Begin
            fMensagem('','Documento com vidros não pode ser alterado!',['&OK']);
            Result := False;
          End

          Else If (Not fEmptyStr(edtNumDoc.Text)) And (edtEspDoc.Text = 'OR') And (Not fVerificaAcessoSistema('VERORC')) And (strCodVen <> strLoginUsuarioLogado) And (Not fEmptyStr(strCodVen)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Acesso ao documento não permitido!', ['&O k']);
            Result := False;
          End

          Else If fDocEmRomaneio And (Not fCfgSis('USPRRO', varBoolean)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Documento está associado ao(s) Romaneio(s): ' + strCodRom + '.' + #13#10 +
                                  'Remova esse Documento do(s) romaneio(s) para poder alterá-lo!', ['&Ok']);
            Result := False;
          End;

          {***********************************************************}
          {* CASO NAO PERMITA ALTERAR PEDIDOS COM SEPARAÇÃO IMPRESSA *}
          {********************************************************MM*}
          If Result And (blnSepImpresso) And (Not fEmptyStr(edtNumDoc.Text)) Then
          Begin
            If fImpressaoParcialConsiderandoJaImpresso Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar esse Documento, pois a separação já foi impressa!', ['&Ok']);
              Result := False;
            End
            Else If (fCfgSis('ALTPDS') = 'N') Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar esse Documento, pois a separação já foi impressa!', ['&Ok']);

              objLiberacao.Clear;
              objLiberacao.objMsgLibera.pAddTexto('Não é possível alterar esse Documento, pois a separação já foi impressa!');
              objLiberacao.objMsgLibera.pAddTextoCaption('Documento', objGravarDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                      objGravarDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                      objGravarDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString);
              objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'  , objGravarDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                      fRetNomCliente(objGravarDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString));

              objLiberacao.strDirAce := 'ALTPDS';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;
              objLiberacao.blnSempreVariavelUsuario := True;

              Result := objLiberacao.fLibera;
            End
            Else If (fCfgSis('ALTPDS') = 'C') And
                    (objGravarDoc.qryFatGor.FieldByName('FGO_ENT_CD').AsString = 'S') And
                    (objGravarDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString = 'PD') And
                    (objGravarDoc.qryFatGor.FieldByName('FGO_EMP_CD').AsString <> VS_strCodEmp) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar, pois este pedido é entrega '
                                  + 'pelo CD e a separação já foi impressa. '
                                  + 'Somente será possível realizar alteração após limpar separação. '
                                  + 'Entre em contato com o responsável pelo CD.', ['&Ok']);
              Result := False;
            End;
          End;

          {***********************************************************}
          {* CASO NAO PERMITA ALTERAR PEDIDOS COM ORDEM DE PRODUÇÃO  *}
          {* DE PRODUTOS TINTOMÉTRICOS IMPRESSA                      *}
          {********************************************************MM*}
          If (Result) And (Not fEmptyStr(edtNumDoc.Text)) And
             (VS_strUsaTmq = 'S')  And (Not fCfgSis('ALTPDT', varBoolean)) And

             (fTemProdutoTintometrico(objGravarDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                      objGravarDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                      objGravarDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString,
                                      objGravarDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString)) And

             (fTemOrdemProducaoTintaImpresso(objGravarDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                             objGravarDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                             objGravarDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString,
                                             objGravarDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString)) Then
          Begin
            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Não é possível alterar esse Documento, pois a ordem de produção de produtos tintométricos já foi impressa!');
            objLiberacao.objMsgLibera.pAddTextoCaption('Documento', objGravarDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                    objGravarDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                    objGravarDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString);
            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'  , objGravarDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                    fRetNomCliente(objGravarDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString));


            objLiberacao.strDirAce := 'ALTPDT';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.blnSempreVariavelUsuario := True;

            If objLiberacao.fLibera Then
            Begin
              Result := True;
            End
            Else
            Begin
              Result := False;
            End;
          End;

          If Result Then
          Begin
            blnMudarFoco := False;
            Result := fCarregarDocumento;
          End;

          InterlockedDecrement(intSemaforoValidar);

        Except
          On E: Exception Do
          Begin
            Result := False;
            InterlockedDecrement(intSemaforoValidar);
            pMensagensErro(E.Message, '');
          End;
        End;

      End
      ELse
        InterlockedDecrement(intSemaforoValidar);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.FormCreate(Sender: TObject);
begin
  inherited;
  intSemaforoValidar  := -1;
  blnGravouPedido := False;

  objLiberacao := TLiberacao.Create;
  stlSelecionados := TStringList.Create;

  pCriarObjetoGravarDoc_Singleton;

  cdsDados := TUniClientDataSet.Create(Self);
  cdsDados.AfterOpen   := pAfterOpen;

  cdsVendaBkp := TUniClientDataSet.Create(Self);
  dtsDados := fCriaDataSource(cdsDados);

  dbgItensDBTableView.DataController.DataSource := dtsDados;

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  edtEspDoc.Text := 'OR';

  strNumOrc := '';
  strEmpOrc := '';
  SetLength(arrIteExpPed, 0);

  pCriaClientInfAdcItem;
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(stlSelecionados) Then FreeAndNil(stlSelecionados);
  If Assigned(objGravarDoc)    Then FreeAndNil(objGravarDoc);
  If Assigned(dtsDados)        Then FreeAndNil(dtsDados);
  If Assigned(cdsDados)        Then FreeAndNil(cdsDados);
  If Assigned(cdsVendaBkp)     Then FreeAndNil(cdsVendaBkp);
  If Assigned(cdsInfAdcItem)   Then FreeAndNil(cdsInfAdcItem);
  if Assigned(objLiberacao)    Then FreeAndNil(objLiberacao);

  SetLength(arrIteExpPed, 0);
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F6: btnMarcar.Click;
    VK_F7: btnDesmarcar.Click;
    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;
    VK_ESCAPE: pEscapePressed;
    VK_DELETE: If ssCtrl In Shift Then Key := 0;
    VK_RETURN: If dbgItensDBTableView.Focused And (cdsDados.RecordCount > 0) Then
               Begin
                 If stlSelecionados.IndexOf(cdsDados.FieldByName('ITE_SEQDET').AsString) = -1 Then
                   stlSelecionados.Add(cdsDados.FieldByName('ITE_SEQDET').AsString)
                 Else
                   stlSelecionados.Delete(stlSelecionados.IndexOf(cdsDados.FieldByName('ITE_SEQDET').AsString));

                 dbgItensDBTableView.DataController.Refresh;
               End;
  End;
End;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.FormShow(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(strNumOrc)) And (Not fEmptyStr(strEmpOrc)) Then
  Begin
    edtNumDoc.ReadOnly    := True;
    edtNumDoc.Color       := edtEspDoc.Color;
    edtNumDoc.FocusColor  := edtEspDoc.FocusColor;
    edtNumDoc.NormalColor := edtEspDoc.NormalColor;

    edtNumDoc.Text := strNumOrc;
    edtCodEmp.Text := strEmpOrc;
    edtEspDoc.Text := 'OR';
    edtDesEmp.Text := fRetNomeEmpresa(strEmpOrc);

    If Not fCarregarDocumento() Then
    Begin
      fMensagem('ATENÇÃO!', 'Carregamento do orçamento falhou. Operação cancelada!', ['&Ok']);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    End
    Else
    Begin
      btnMarcar.Click;
      pSetFocus(dbgItens);
    End;
  End;
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.btnConfirmaClick(Sender: TObject);
begin
  If Assigned(cdsDados) And (Not cdsDados.IsEmpty) Then
    TfrmGravando.fExecutarModal(pConfirmar, 'Aguarde, Gravando documento...', '')
  Else
    pMensagemOk('É necessário selecionar um orçamento!');
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pConfirmar;

  procedure pExcluirNovoDocumentoGerado;
  Var
    blnTransacaoLocal : Boolean;
  begin

    blnTransacaoLocal := False;
    If Not fInTransaction() Then
    Begin
      fStartTransaction();
      blnTransacaoLocal := True;
    End;

    Try
      {Reprocessar Saldos}
      TReprocessarSaldoItem.New
        .AddItensDoDocumento(
          TItensReprocessarDoDocumento.New
            .Documento(objGravarDoc.objVenda.strNumDoc)
            .Especie('PD')
            .Empresa(VS_strCodEmp)
          ).NotificarRoboParaReprocessarSaldos;

      fExecutaSQL('DELETE FROM FATGOR WHERE FGO_NUMDOC = "' + objGravarDoc.objVenda.strNumDoc + '" AND ' +
                  'FGO_ESPDOC = "PD" AND FGO_CODEMP = "' + VS_strCodEmp + '"');

      If blnTransacaoLocal Then
        fCommit();

    Except

      If blnTransacaoLocal Then
        fRollBack();

      Raise;

    End;

  end;

  procedure pLimpar;
  begin
    pLimparTela;

    If Not fEmptyStr(strNumOrc) Then
      Self.close;
  end;

  function fLiberouDemaisTravas : Boolean;
  var
    blnTravarNoFinal : Boolean;
  begin

    Result := True;

    blnTravarNoFinal := objGravarDoc.objVenda.blnLiberacaoRemotaNoFinalVenda;

    Try

      If Not objGravarDoc.objVenda.fVerificaConsultaDeCredito(objGravarDoc.objVenda.strConPag, objGravarDoc.objVenda.strCodFpg, objGravarDoc.objVenda.strOpcDoc) Then
        Result := False;

      If Not objGravarDoc.objVenda.fVerificaConsultaDadosCobranca(objGravarDoc.objVenda.strConPag, objGravarDoc.objVenda.strCodFpg) Then
        Result := False;

      If Not objGravarDoc.objVenda.fVerificaIntervaloMargemValorCndPagto Then
        Result := False;

    Finally

      If (blnTravarNoFinal) And (Not objGravarDoc.objVenda.fRealizarLiberacaoRemotaFinalVenda) Then
        Result := False;

      If Not Result Then
        pMensagemOk('Não foi possível gerar o pedido!');

    End;

  end;

begin
  inherited;

  If Not btnConfirma.Enabled Then
    Exit;

  If stlSelecionados.Count = 0 Then
  Begin
    pMensagemOk('Nenhum item do orçamento foi selecionado!');
    Exit;
  End;

  pCloneDataSet(cdsVenda, cdsVendaBkp);//Restaura o backup
  objGravarDoc.objVenda.cdsDadosPedBaixados.EmptyDataSet;//Remove os itens ja baixados do orcamento

  If fEmptyStr(objGravarDoc.objVenda.strTipPed) and (fCfgSis('TPDCEX') = '1') Then
  begin
    objGravarDoc.objVenda.strTipPed := fRetTipFat;

    if fEmptyStr(objGravarDoc.objVenda.strTipPed) then
      objGravarDoc.objVenda.strTipPed := 'A';
  end;

  If fCfgSis('DTORPD', varBoolean) Then
  Begin
    objGravarDoc.objVenda.dtaGraPed := objGravarDoc.objVenda.dtaDtaEntOri;
    objGravarDoc.objVenda.dtaPrevis := objGravarDoc.objVenda.dtaPreVisOri;
  End
  Else
  Begin
    objGravarDoc.objVenda.dtaGraPed := VS_Date;
    objGravarDoc.objVenda.dtaHorPed := fRetHoraServidor;

    objGravarDoc.objVenda.dtaDtaOri := VS_Date;

    If objGravarDoc.objVenda.dtaPreVis < objGravarDoc.objVenda.dtaGraPed Then
      objGravarDoc.objVenda.dtaPreVis := objGravarDoc.objVenda.dtaGraPed;
  End;

  {Req.: 124204 - Deve imprimir os documentos!}
  objGravarDoc.objVenda.blnImprimeDocs := True;
  objGravarDoc.objVenda.blnImprimeSep  := fCfgSis('PEDSEP', varBoolean);

  pSelecionarItensDoPedido;

  If objGravarDoc.fCarregarMatrizItens       And
     objGravarDoc.fCalcularTotalVenda(fPermiteCalcularPesoBrutoELiquido) And
     objGravarDoc.fValidacoesFinanceiras     And
     objGravarDoc.fItensSemEstoqueParaCorte  And
     objGravarDoc.fPedeLojasTE               And
     objGravarDoc.fPedeLojasColorantesTE     And
     objGravarDoc.fDigitarDadosPedido        And
     objGravarDoc.fDigitarDadosPedidoCompra  And
     objGravarDoc.fValidarEstoque            And
     objGravarDoc.fDefineAbastecimentoItens(True) And
     objGravarDoc.fCalcularTotalVenda(fPermiteCalcularPesoBrutoELiquido) And
     objGravarDoc.fAbaterCreditosAutomaticamente(objGravarDoc.objVenda.fltTotCadRec) And
     objGravarDoc.fProcessarRequisicaoCompra Then
  Begin

    If Not fLiberouDemaisTravas Then
      Exit;

    objGravarDoc.pTravasNaConversaoORPD;
    If objGravarDoc.fGravarPedido Then
    Begin
      If fLimparDadosFaturamentoItensNaoSelecionados Then
      Begin
        objGravarDoc.objVenda.pExibirMensagemDocumentoGravado();
        blnGravouPedido := True;
        pLimpar;
      End
      Else
        pExcluirNovoDocumentoGerado;
    End
    Else
      pMensagemOk('Não foi possível gerar o Pedido!');

  End
  Else
    pMensagemOk('Não foi possível gerar o Pedido!');

end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pEscapePressed;
begin
  If ((ActiveControl) = edtNumDoc) Or edtNumDoc.ReadOnly Then
    inherited
  Else
    pLimparTela;
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pLimparDadosFaturamento;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  FATGOR ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  FGO_NUMFAT = NULL, ';
  strSQL := strSQL + '  FGO_TIPFAT = NULL, ';
  strSQL := strSQL + '  FGO_EMPFAT = NULL, ';
  strSQL := strSQL + '  FGO_DTAFAT = NULL, ';
  strSQL := strSQL + '  FGO_VENFAT = NULL, ';
  strSQL := strSQL + '  FGO_CNDFAT = NULL, ';
  strSQL := strSQL + '  FGO_VALFAT = NULL, ';
  strSQL := strSQL + '  FGO_JAFATU = 0     ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FGO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FGO_CODEMP = :EMPDOC ';

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    ParamByName('EMPDOC').AsString := edtCodEmp.Text;
    ExecSQL;
    Close;
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmFatEfetivarItensOrcamentoEmPedido.pLimparDadosFaturamentoItem(strAutIncFdo: String);
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  FDO_NUMFAT = NULL, ';
  strSQL := strSQL + '  FDO_TIPFAT = NULL, ';
  strSQL := strSQL + '  FDO_EMPFAT = NULL, ';
  strSQL := strSQL + '  FDO_DTAFAT = NULL, ';
  strSQL := strSQL + '  FDO_VENFAT = NULL, ';
  strSQL := strSQL + '  FDO_CNDFAT = NULL, ';
  strSQL := strSQL + '  FDO_VALFAT = NULL, ';
  strSQL := strSQL + '  FDO_QTDBAI = NULL, ';
  strSQL := strSQL + '  FDO_JAFATU = 0     ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM = :AUTINC ';
  strSQL := strSQL + 'ORDER BY  ';
  strSQL := strSQL + '  FDO_CODITE ';

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('AUTINC').AsString := strAutIncFdo;
    ExecSQL;
    Close;
  End;

  FreeAndNil(qryGen);
end;

end.
