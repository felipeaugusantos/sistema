unit untCadMetasEmpresaFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.Menus, cxButtons, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  EditFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, frxClass, untTMetAno, untTValidaExcel;

type
  TfraCadMetasEmpresaFrame = class(TFrame)
    pnlFundoFrame: TPanel;
    pnlGradeMeta: TPanel;
    cxGridMetas: TcxGrid;
    cxGridMetasTableView: TcxGridDBTableView;
    cxGridMetasTableViewINDEX: TcxGridDBColumn;
    cxGridMetasTableViewMESANO: TcxGridDBColumn;
    cxGridMetasTableViewDIAUTI: TcxGridDBColumn;
    cxGridMetasTableViewMETDIA: TcxGridDBColumn;
    cxGridMetasTableViewMETPRO: TcxGridDBColumn;
    cxGridMetasTableViewMETREA: TcxGridDBColumn;
    cxGridMetasTableViewRESULT: TcxGridDBColumn;
    cxGridMetasTableViewMARMES: TcxGridDBColumn;
    cxGridMetasTableViewMARREA: TcxGridDBColumn;
    cxGridMetasTableViewLITPRO: TcxGridDBColumn;
    cxGridMetasTableViewLITREA: TcxGridDBColumn;
    cxGridMetasLevel1: TcxGridLevel;
    pnlHeaderMeta: TPanel;
    pnlLegMet: TPanel;
    pnlEditaveis: TPanel;
    lblCamEdt: TLabel;
    shpCamEdt: TShape;
    pnlSomProIncompleta: TPanel;
    shpSomPro: TShape;
    lblSomProj: TLabel;
    pnlSomProCompleta: TPanel;
    shpSomCom: TShape;
    lblSomaProCompleta: TLabel;
    cdsMeta: TUniClientDataSet;
    cdsMetaINDEX: TIntegerField;
    cdsMetaDIAUTI: TFloatField;
    cdsMetaMESANO: TStringField;
    cdsMetaMETDIA: TFloatField;
    cdsMetaMETPRO: TFloatField;
    cdsMetaMETREA: TFloatField;
    cdsMetaRESULT: TFloatField;
    cdsMetaMARMES: TFloatField;
    cdsMetaMARREA: TFloatField;
    cdsMetaLITPRO: TFloatField;
    cdsMetaLITREA: TFloatField;
    frxHelp: TfrxReport;
    dtsMeta: TDataSource;
    pnlEmpresa: TPanel;
    pnlFiltros: TPanel;
    rdgEmpFatOri: TRadioGroup;
    btnCalMet: TBitBtnLocked;
    lblAno: TLabel;
    edtAnoMet: TEditFocus;
    btnCalMetAno: TBitBtnLocked;
    btnImportarMetas: TBitBtnLocked;
    btnHlpImp: TcxButton;
    edtCodEmp: TEditFocus;
    lblEmpresa: TLabel;
    shpCodEmp: TShape;
    edtNomEmp: TEditFocus;
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnImportarMetasClick(Sender: TObject);
    procedure edtAnoMetExit(Sender: TObject);
    procedure edtAnoMetEnter(Sender: TObject);
    procedure btnCalMetClick(Sender: TObject);
    procedure btnCalMetAnoClick(Sender: TObject);
    procedure cxGridMetasTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridMetasTableViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxGridMetasTableViewEditValueChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
  private
    objMetAno: TMetAno;
    strAnoAtual: String;
    blnSalvouMetaComEnter: Boolean;

    Const
      QTDCOL = 3;
      METPRO = 'A';
      MARMES = 'B';
      LITPRO = 'C';
      DES_METPRO = 'Meta Mensal Proj.';
      DES_MARMES = 'Marg. Proj.';
      DES_LITPRO = 'Litragem Proj.';

    procedure pImportarMetas;
    procedure pCriaValidadorExcel(Var objValidador: TValidadorExcel; strCaminho: String);
    procedure pCopiaDadosImportacao(objExcel: TValidadorExcel);
    procedure pDesabilitarLegendas;
    procedure pPreencheValoresMetaMargem(Var fltMeta, fltMarMes, fltLitr: Double);
    procedure pCalculaMetaAnual;
    function fValidaEmpSelec: Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
    function fCaminhoArquivo: String;
    function fValidaDadosArquivo(objValidaExcel: TValidadorExcel): Boolean;
  public
    procedure pHabilitaDesabilitaComponentesEdicao(blnHabilita: Boolean);
    procedure pGravarMetas;
    procedure pFormShow;
    procedure pOnFormCreate;
    procedure pFormDestroy;
    procedure pPesquisaEmpresa(Key: Char = '/');
  end;

implementation

uses
  untTypesSistema, untFuncoesSimples, untDigMetMar, untFuncoesConsulta, untConsultas,
  untImportacaoArquivo;

{$R *.dfm}

procedure TfraCadMetasEmpresaFrame.btnCalMetAnoClick(Sender: TObject);
begin
  pCalculaMetaAnual;
end;

procedure TfraCadMetasEmpresaFrame.pCalculaMetaAnual;
  Var
    fltMeta: Double;
    fltLitr: Double;
    fltMarMes: Double;
begin
  inherited;

  fltMeta := 0;
  fltMarMes := 0;
  fltLitr := 0;

  If (Not fValidaEmpSelec) Then
    Exit;

  pPreencheValoresMetaMargem(fltMeta, fltMarMes, fltLitr);

  If (fltMeta + fltMarMes + fltLitr) = 0 Then
    Exit;

  pDesabilitarLegendas;

  Try
    objMetAno.blnEmpOri := (rdgEmpFatOri.ItemIndex = 1);

    objMetAno.pCarregar(edtAnoMet.Text, fltMeta, fltMarMes, edtCodEmp.Text, True,
      cdsMeta, False, 1, 12, True, fltLitr);

    objMetAno.pCalculaTotal(cdsMeta);
    objMetAno.First;

    cxGridMetasTableView.ApplyBestFit();
  Except
    On E:Exception Do
      pMensagensErro(E.Message, '[pCalculaMetaAnual]');
  End;
end;

procedure TfraCadMetasEmpresaFrame.pPreencheValoresMetaMargem(Var fltMeta, fltMarMes, fltLitr: Double);
  Var
    frmDigMetMar: TfrmDigMetMar;
begin
  pCriarFormularios(TfrmDigMetMar, frmDigMetMar);

  Try
    frmDigMetMar.ShowModal;

    If (frmDigMetMar.blnConfirma) Then
    Begin
      fltMeta   := fStrToFloat(frmDigMetMar.edtTotMet.Text);
      fltMarMes := fStrToFloat(frmDigMetMar.edtMarMes.Text);
      fltLitr   := fStrToFloat(frmDigMetMar.edtTotLit.Text);
    End;
  Finally
    pFreeAndNil(frmDigMetMar);
  End;
end;

procedure TfraCadMetasEmpresaFrame.btnCalMetClick(Sender: TObject);
begin
  edtAnoMetExit(Self);
end;

procedure TfraCadMetasEmpresaFrame.btnHlpImpClick(Sender: TObject);
begin
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfraCadMetasEmpresaFrame.pDesabilitarLegendas;
begin
  pnlSomProIncompleta.Visible := False;
  pnlEditaveis.Visible := False;
  pnlSomProCompleta.Visible := False;
end;

procedure TfraCadMetasEmpresaFrame.btnImportarMetasClick(Sender: TObject);
begin
  pImportarMetas;
end;

procedure TfraCadMetasEmpresaFrame.cxGridMetasTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnPintarLime : Boolean;
    blnPintarAqua : Boolean;
begin
  If (Not Assigned(cdsMeta)) Or (Not cdsMeta.Active) Then
    Exit;

  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridMetasTableViewMESANO.Index] <> objMetAno.fGetSTR_TOTAL) And
     (AViewInfo.Item.Options.Editing) Then
  Begin
    If Not pnlEditaveis.Visible Then
      pnlEditaveis.Visible := True;

    ACanvas.Brush.Color := clYellow;

    If (AViewInfo.Item.Focused) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clBlack;
  End;

  blnPintarLime := False;
  blnPintarAqua := False;

  If (Not blnPintarLime) And (objMetAno.blnMetaIncompleta) Then
  Begin
    blnPintarLime := (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridMetasTableViewMESANO.Index] <> objMetAno.fGetSTR_TOTAL) And
                     ((AViewInfo.Item.Index = cxGridMetasTableViewMETREA.Index) And
                      (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridMetasTableViewMETREA.Index] <> 0)) Or
                     ((AViewInfo.Item.Index = cxGridMetasTableViewMETPRO.Index) And
                      (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridMetasTableViewMETPRO.Index] <> 0) And
                      (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridMetasTableViewMETREA.Index] = 0));
  End;

  If (Not blnPintarLime) And (objMetAno.blnLitragemIncompleta) Then
  Begin
    blnPintarLime := (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridMetasTableViewMESANO.Index] <> objMetAno.fGetSTR_TOTAL) And
                     ((AViewInfo.Item.Index = cxGridMetasTableViewLITREA.Index) And
                      (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridMetasTableViewLITREA.Index] <> 0)) Or
                     ((AViewInfo.Item.Index = cxGridMetasTableViewLITPRO.Index) And
                      (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridMetasTableViewLITPRO.Index] <> 0) And
                      (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridMetasTableViewLITREA.Index] = 0));
  End;

  If (Not blnPintarLime) And (Not objMetAno.blnLitragemIncompleta) Then
  Begin
    blnPintarLime := ((AViewInfo.Item.Index = cxGridMetasTableViewLITREA.Index) And
                      (AViewInfo.GridRecord.RecordIndex In [11, 12])) Or
                     ((AViewInfo.Item.Index = cxGridMetasTableViewLITPRO.Index) And
                      (AViewInfo.GridRecord.RecordIndex = 11));
  End;

  If (Not blnPintarLime) And (Not objMetAno.blnMetaIncompleta) Then
  Begin
    blnPintarLime := ((AViewInfo.Item.Index = cxGridMetasTableViewMETREA.Index) And
                     (AViewInfo.GridRecord.RecordIndex In [11, 12])) Or
                     ((AViewInfo.Item.Index = cxGridMetasTableViewMETPRO.Index) And
                      (AViewInfo.GridRecord.RecordIndex = 11));
  End;

  If (Not blnPintarAqua) And (Not objMetAno.blnLitragemIncompleta) Then
  Begin
    blnPintarAqua := ((AViewInfo.Item.Index = cxGridMetasTableViewLITPRO.Index) And
                      (AViewInfo.GridRecord.RecordIndex = 12));
  End;

  If (Not blnPintarAqua) And (Not objMetAno.blnMetaIncompleta) Then
  Begin
    blnPintarAqua := ((AViewInfo.Item.Index = cxGridMetasTableViewMETPRO.Index) And
                      (AViewInfo.GridRecord.RecordIndex = 12));
  End;

  If blnPintarLime Then
  Begin
    If Not pnlSomProIncompleta.Visible Then
      pnlSomProIncompleta.Visible := True;

     ACanvas.Brush.Color := clLime;

    If (AViewInfo.Item.Focused) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clBlack;
  End;

  If blnPintarAqua Then
  Begin
    If Not pnlSomProCompleta.Visible Then
      pnlSomProCompleta.Visible := True;

     ACanvas.Brush.Color := clAqua;

    If (AViewInfo.Item.Focused) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfraCadMetasEmpresaFrame.cxGridMetasTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  If (Key in [VK_RETURN, VK_DOWN, VK_UP]) Then
  Begin
    blnSalvouMetaComEnter := True;
    Try
      If cdsMeta.State = dsEdit Then
        cdsMeta.Post;
      cdsMeta.DisableControls;
      objMetAno.pCalculaTotal(cdsMeta);
    Finally
      If cdsMeta.ControlsDisabled Then
        cdsMeta.EnableControls;
      blnSalvouMetaComEnter := False;
    End;
  End;
end;

procedure TfraCadMetasEmpresaFrame.cxGridMetasTableViewEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  If Not blnSalvouMetaComEnter Then
  Begin
    Try
      If cdsMeta.State = dsEdit Then
      Begin
        cdsMeta.Post;
        cdsMeta.DisableControls;
        objMetAno.pCalculaTotal(cdsMeta);
      End;
    Finally
      If cdsMeta.ControlsDisabled Then
        cdsMeta.EnableControls;
    End;
  End;
end;

procedure TfraCadMetasEmpresaFrame.edtAnoMetEnter(Sender: TObject);
begin
  strAnoAtual := edtAnoMet.Text;
end;

procedure TfraCadMetasEmpresaFrame.edtAnoMetExit(Sender: TObject);
begin
  If (Not fValidaEmpSelec) Then
    Exit;

  If (Not fEmptyStr(strAnoAtual)) And (strAnoAtual <> edtAnoMet.Text) And (cdsMeta.recordCount > 1) And
    (cxGridMetas.Enabled) Then
  Begin
    If (fMensagem('ATENÇÃO!', 'Os dados do ano de [' + strAnoAtual + ']'+
                              ' ainda não foram salvos, o que deseja fazer?',
                              ['&Salvar', '&Descartar'])) = 1 Then
    Begin
      objMetAno.pGravarMetaEmpresa;
    End;
  End;

  Try
    If (Not fEmptyStr(edtAnoMet.Text)) Then
    Begin
      pDesabilitarLegendas;
      objMetAno.blnEmpOri := (rdgEmpFatOri.ItemIndex = 1);
      objMetAno.pCarregar(edtAnoMet.Text, 0, 0, edtCodEmp.Text, False, cdsMeta, True);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[edtAnoMetExit]');
  End;
end;

procedure TfraCadMetasEmpresaFrame.edtCodEmpExit(Sender: TObject);
  Var
    arrEmp: TConsultasArray;
begin
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfraCadMetasEmpresaFrame.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  pPesquisaEmpresa(Key);
end;

procedure TfraCadMetasEmpresaFrame.pPesquisaEmpresa(Key: Char = '/');
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, GetParentForm(Self) As TForm, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, True, True) Then
  Begin
    If (fValidaCampos(edtCodEmp, True)) Then
      SelectNext(edtCodEmp, True, True);
  End;
end;

function TfraCadMetasEmpresaFrame.fValidaEmpSelec: Boolean;
begin
  Result := (Not fEmptyStr(edtCodEmp.Text));

  If (Not Result) Then
    fMensagem('ATENÇÃO', 'Selecione uma empresa para efetuar essa operação!', ['&Ok']);
End;

procedure TfraCadMetasEmpresaFrame.pHabilitaDesabilitaComponentesEdicao(blnHabilita: Boolean);
begin
  edtAnoMet.Enabled := blnHabilita;
  edtCodEmp.Enabled := Not blnHabilita;
  btnCalMetAno.Enabled := blnHabilita;
  btnImportarMetas.Enabled := blnHabilita;
  btnHlpImp.Enabled := blnHabilita;
end;

procedure TfraCadMetasEmpresaFrame.pImportarMetas;
  Var
    objValidaExcel: TValidadorExcel;
    strCaminhoArquivo: String;
begin
  strCaminhoArquivo := fCaminhoArquivo;

  If (fEmptyStr(strCaminhoArquivo)) Then
    Exit;

  pCriaValidadorExcel(objValidaExcel, strCaminhoArquivo);

  Try
    If (fValidaDadosArquivo(objValidaExcel)) Then
    Begin
      pCopiaDadosImportacao(objValidaExcel);
      cdsMeta.DisableControls;
      objMetAno.pCalculaTotal(cdsMeta);
      cdsMeta.EnableControls;
    End;
  Finally
    FreeAndNil(objValidaExcel);
  End;
end;

function TfraCadMetasEmpresaFrame.fValidaDadosArquivo(objValidaExcel: TValidadorExcel): Boolean;
begin
  Result := False;

  If (objValidaExcel.intQtdLinhas = 0) Then
    Exit;

  If (Not objValidaExcel.fValidaCampos(True)) Then
    Exit;

  Result := True;
end;

procedure TfraCadMetasEmpresaFrame.pOnFormCreate;
begin
  objMetAno := TMetAno.Create(True);
  cdsMeta.CreateDataSet;
  cdsMeta.IndexFieldNames := 'INDEX';
  blnSalvouMetaComEnter := False;
  rdgEmpFatOri.ItemIndex := 0;
  pHabilitaDesabilitaComponentesEdicao(False);
end;

procedure TfraCadMetasEmpresaFrame.pFormDestroy;
begin
  FreeAndNil(objMetAno);
end;

procedure TfraCadMetasEmpresaFrame.pFormShow;
begin
  edtAnoMet.Text := FormatDateTime('yyyy', VS_Date);
  strAnoAtual := edtAnoMet.Text;
  cxGridMetasTableViewLITPRO.Visible := (VS_strUsaTmq = 'S');
  cxGridMetasTableViewLITREA.Visible := (VS_strUsaTmq = 'S');
  cxGridMetasTableView.ApplyBestFit();
  pVerdeVermelho(edtCodEmp, shpCodEmp, fVerificaAcessoSistema('ALTEMPMET'), False, False);
end;

procedure TfraCadMetasEmpresaFrame.pGravarMetas;
begin
  If (cdsMeta.RecordCount > 0) Then
    objMetAno.pGravarMetaEmpresa;
end;

procedure TfraCadMetasEmpresaFrame.pCriaValidadorExcel(Var objValidador: TValidadorExcel; strCaminho: String);
begin
  objValidador := TValidadorExcel.Create(strCaminho, QTDCOL, METPRO, '', 0);
  objValidador.pAddCampo(objValidador.fMontaCampoFloat(DES_METPRO, METPRO));
  objValidador.pAddCampo(objValidador.fMontaCampoFloat(DES_MARMES, MARMES));
  objValidador.pAddCampo(objValidador.fMontaCampoFloat(DES_LITPRO, LITPRO));
end;

procedure TfraCadMetasEmpresaFrame.pCopiaDadosImportacao(objExcel: TValidadorExcel);
  Var
    intContador: Integer;
begin
  cdsMeta.First;

  For intContador := 0 To (objExcel.ArquivoCSV.Count -1) Do
  Begin
    If (intContador > objExcel.ArquivoCSV.Count) Then
      Continue;

    cdsMeta.Edit;
    cdsMetaMETPRO.AsVariant := objExcel.fGetValueCSV(intContador, METPRO);
    cdsMetaMARMES.AsVariant := objExcel.fGetValueCSV(intContador, MARMES);
    cdsMetaLITPRO.AsVariant := objExcel.fGetValueCSV(intContador, LITPRO);
    cdsMeta.Post;
    cdsMeta.Next;

    Application.ProcessMessages;
  End;
end;

function TfraCadMetasEmpresaFrame.fCaminhoArquivo: String;
  Var
    frmImportacaoArquivo: TfrmImportacaoArquivo;
    strCaminhoArquivo: String;
begin
  strCaminhoArquivo := '';
  pCriarFormularios(TfrmImportacaoArquivo, frmImportacaoArquivo);

  Try
    If (frmImportacaoArquivo.ShowModal = mrOk) Then
      strCaminhoArquivo := frmImportacaoArquivo.edtCaminhoArquivo.Text;

    Result := strCaminhoArquivo;
  Finally
    pFreeAndNil(frmImportacaoArquivo);
  End;
end;

function TfraCadMetasEmpresaFrame.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtAnoMet) Then
  Begin
    If (fEmptyStr(edtAnoMet.Text)) Then
    Begin
      fMensagem('', 'Campo "Ano" deve ser preenchido', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      Try
        edtAnoMet.Text := fTrataAnoDataMesAno(edtAnoMet.Text);
        strToDate('01/01/' + edtAnoMet.Text);
      Except
        fMensagem('', 'Ano inválido!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
