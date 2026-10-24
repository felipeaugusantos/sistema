unit untAnaliseProducao;

interface

uses
  Windows, Controls, untPaiEdit, AppEvnts, Menus, untTypesSistema,
  StdCtrls, Buttons, ExtCtrls, BitBtnLockedIncrem, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Mask, MaskEditFocus, EditFocus, untFuncoesSimples,
  Uni, frxClass, frxDBSet, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, cxProgressBar, DB,
  untZClient, Classes, UniClientDataSet, frxExportCSVTestabilidade, Forms,
  cxDataControllerConditionalFormattingRulesManagerDialog, untEstadoTela,
  OrdemProducaoIndustrial.Tipos, OrdemProducaoIndustrial.Funcoes, QColorLabel, untFuncoesRel,
  cxCurrencyEdit, cxContainer, cxGroupBox, untSaldoLojas, Vcl.Dialogs, cxGridExportLink;

type
  TfrmAnaliseProducao = class(TfrmPaiEdit)
    btnImprimir: TBitBtnLocked;
    pnlFiltros: TPanel;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewESTMIN: TcxGridDBColumn;
    cxgItensViewColumn6: TcxGridDBColumn;
    cxgItensViewColumn7: TcxGridDBColumn;
    cxgItensSALFIN: TcxGridDBColumn;
    cxgItensViewColumn9: TcxGridDBColumn;
    cxgItensViewDIAEST: TcxGridDBColumn;
    shpMultSel: TShape;
    btnConfirma: TBitBtnLocked;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label2: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label11: TLabel;
    edtCodProduto: TEditFocus;
    edtDesProduto: TEditFocus;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    edtCodMarAca: TEditFocus;
    edtDesMarAca: TEditFocus;
    mskLinGruAca: TMaskEditFocus;
    edtDesGruAca: TEditFocus;
    Label5: TLabel;
    edtCodProdutoAca: TEditFocus;
    edtDesProdutoAca: TEditFocus;
    rdgEstoque: TRadioGroup;
    rdgGiro: TRadioGroup;
    lblQtdDia: TLabel;
    chkOrdPro: TCheckBox;
    edtQtdDia: TEditFocus;
    chkNecPro: TCheckBox;
    cxgItensViewColumn8: TcxGridDBColumn;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lbl1: TLabel;
    lbl2: TLabel;
    rdbAnaSin: TRadioButton;
    rdbAnaAna: TRadioButton;
    cxgItensPREVIS: TcxGridDBColumn;
    cxgItensQTDPRE: TcxGridDBColumn;
    btnManOrdProIndustrial: TBitBtnLocked;
    chkLibera: TCheckBox;
    edtDiasGiro: TEditFocus;
    Label6: TLabel;
    Panel1: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    cxgItensViewSALFEM: TcxGridDBColumn;
    cxgItensViewGIRDIA: TcxGridDBColumn;
    cxgItensViewCAPMAX: TcxGridDBColumn;
    chkConMin: TCheckBox;
    btnSaldoReservado: TBitBtnLocked;
    chkQbrLin: TCheckBox;
    edtStatus: TEditFocus;
    Label9: TLabel;
    ColorLabel1: TColorLabel;
    chkConMax: TCheckBox;
    Label8: TLabel;
    edtCodGruGer: TEditFocus;
    edtDesGruGer: TEditFocus;
    Label10: TLabel;
    edtCodGruGerAca: TEditFocus;
    edtDesGruGerAca: TEditFocus;
    cxgItensViewPESLIQ: TcxGridDBColumn;
    btnZerarProduzir: TBitBtnLocked;
    cxgItensViewQTDPRO: TcxGridDBColumn;
    frxDBItens: TfrxDBDataset;
    frxReportJ: TfrxReport;
    frxReportM: TfrxReport;
    frxReportM_ANAQTP: TfrxReport;
    frxReportJ_ANAQTP: TfrxReport;
    btnImprimirQtdPro: TBitBtnLocked;
    grpEntFut: TcxGroupBox;
    chkFaltaProduto: TCheckBox;
    chkPrevisaoEntrega: TCheckBox;
    chkAguardandoCliente: TCheckBox;
    cxgItensQTDPEN: TcxGridDBColumn;
    cxgItensViewSALDIS: TcxGridDBColumn;
    cxgItensViewSALDOP: TcxGridDBColumn;
    Label12: TLabel;
    edtAtePed: TEditFocus;
    ColorLabel2: TColorLabel;
    btnExportDados: TBitBtnLocked;
    rdgTipoFiltroData: TRadioGroup;
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure chkOrdProClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtCodMarAcaExit(Sender: TObject);
    procedure edtCodMarAcaKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruAcaExit(Sender: TObject);
    procedure mskLinGruAcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoAcaExit(Sender: TObject);
    procedure edtCodProdutoAcaKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure rdbAnaSinKeyPress(Sender: TObject; var Key: Char);
    procedure btnManOrdProIndustrialClick(Sender: TObject);
    procedure btnSaldoReservadoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodGruGerKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGruGerAcaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cxgItensViewQTDPROPropertiesEditValueChanged(Sender: TObject);
    procedure btnZerarProduzirClick(Sender: TObject);
    procedure btnImprimirQtdProClick(Sender: TObject);
    procedure btnExportDadosClick(Sender: TObject);
  private
    { Private declarations }
    arrLinGru    : TConsultasArray;
    arrMarca     : TConsultasArray;
    arrProduto   : TConsultasArray;
    arrLinGruAca : TConsultasArray;
    arrMarcaAca  : TConsultasArray;
    arrProdutoAca: TConsultasArray;

    strLinGru,
    strMarca,
    strProduto,
    strLinGruAca,
    strMarcaAca,
    strProdutoAca : String;

    cdsItens: TZClient;
    cdsDigitacaoBackup : TUniClientDataSet;
    pgbStatusGravacao: TcxProgressBar;
    strChave: String;

    blnGeraOpSubProdutos: Boolean;

    qryPrevis: TUniQuery;

    objEstadoTela : TEstadoTela;
    procedure pCriaCdsItens;

    Function fSQLItens: String;
    Function fSQLCampos: String;
    Function fAbreConsulta: Boolean;
    Function fQtdMeses: Integer;
    Function fCalculaMediaGiro(strCodIte: String; intQtdMeses: Integer): Double;
    Function fQuantidadeProducao(strCodIte: String;
      intQtdDias: Integer): Double;

    Procedure pCalculaSaldoReservado(cdsCalculo: TUniClientDataSet);
    Procedure pCalculaSaldoDisponivel(cdsCalculo: TUniClientDataSet);
    Procedure pImprimeRelatorio;
    Procedure pImprimeQtdProduzir;
    function fConfirma(pgbProgresso: TcxProgressBar = Nil): Boolean;
    procedure pSetTexto(strTexto: String);
    procedure pStepStatusGravacao;
    procedure pCarregaPrevisao(strCodIte: String; strCodEmp: String; dtaPrevIni: TDate = 0; dtaPrevFin: TDate = 0; blnApenasLiberados : boolean = False);
    procedure pProcessaAnalitico;
    procedure pSetarFiltro;
    function fGetChaveLayoutGrid: string;
    procedure pSetQuantidadeDigitada;
    function fSQLQtdPen: String;
    function fGetTipoFiltroData: TTipoFiltroDataAnaliseProducao;


  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses SysUtils, Variants, Graphics, StrUtils, DateUtils,
  untConsultas, untCfgRel, untFuncoesConsulta, untGravando,
  untManOrdProIndustrial, untIFatReservaSaldo, untTFatReservaSaldo,
  untReimpressao, untFatMostraPedSalRes;

{$R *.dfm}

procedure TfrmAnaliseProducao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.strChave := strChave;
    frmGravando.fExecutarAcao := fConfirma;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmAnaliseProducao.btnConfirma - frmGravando]');
    End;
  End;

  pFreeAndNil(frmGravando);
end;

procedure TfrmAnaliseProducao.btnImprimirQtdProClick(Sender: TObject);
begin
  inherited;
  pImprimeQtdProduzir;
end;

procedure TfrmAnaliseProducao.btnExportDadosClick(Sender: TObject);
var
  dlgSave : TSaveDialog;
begin
  inherited;

  Try
    Application.ProcessMessages;
    dlgSave := TSaveDialog.Create(Self);
    Try
      dlgSave.Title := 'Exportar Dados';
      dlgSave.DefaultExt := 'csv';
      dlgSave.FileName := 'Análise de Produção';
      dlgSave.Filter := 'Arquivos CSV|*.csv';
      If dlgSave.Execute Then
      Begin
        ExportGridToCSV(dlgSave.FileName, cxgItens,  True, True , ';');
        pMensagemOk('Arquivo gerado com sucesso!');
      End;
    Finally
      FreeAndNil(dlgSave);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAnaliseProducao.btnExportDadosClick]');
    End;
  End;
end;

procedure TfrmAnaliseProducao.btnImprimirClick(Sender: TObject);
begin
  inherited;

  pImprimeRelatorio;
end;

procedure TfrmAnaliseProducao.btnManOrdProIndustrialClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmManOrdProIndustrial);
end;

procedure TfrmAnaliseProducao.btnSaldoReservadoClick(Sender: TObject);
  Var
    dtaPrvIni : TDate;
    dtaPrvFin : TDate;
Begin
  inherited;
  If (Not fValidaCampos(mskDtaIni)) And (Not fValidaCampos(mskDtaFin)) Then
  Begin
    dtaPrvIni := 0;
    dtaPrvFin := 0;
  End
  Else
  Begin
    dtaPrvIni := StrToDateDef(mskDtaIni.Text, 0);
    dtaPrvFin := StrToDateDef(mskDtaFin.Text, 0);
  End;

  if cdsItens.Active and (not cdsItens.IsEmpty) then
    TfrmFatMostraPedSalRes.pExibeDocsSaldosReservado(cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp, pMostraDocumentoReimpressao, True, True, True, dtaPrvIni, dtaPrvFin, fGetTipoFiltroData);
end;

procedure TfrmAnaliseProducao.btnZerarProduzirClick(Sender: TObject);
var
  bkmAnalise : TBookmark;
begin
  if cdsItens.Active then
  begin
    cdsItens.DisableControls;
    try
      bkmAnalise := cdsItens.GetBookmark;
      try
        cdsItens.First;
        while not cdsItens.eof do
        begin
          cdsItens.Edit;
          cdsItens.fieldByName('QTDPRO').AsInteger := 0;
          cdsItens.Post;

          cdsItens.next;
        end;
      finally
        cdsItens.GotoBookmark(bkmAnalise);
        cdsItens.FreeBookmark(bkmAnalise);
      end;
    finally
      cdsItens.EnableControls;
    end;
  end;
end;

procedure TfrmAnaliseProducao.chkOrdProClick(Sender: TObject);
begin
  inherited;

  lblQtdDia.Enabled := chkOrdPro.Checked;
  edtQtdDia.Enabled := chkOrdPro.Checked;
end;

procedure TfrmAnaliseProducao.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewQTDPRO.Index])) > 0 Then
  begin
    If not (AViewInfo.Selected) Then
    begin
      ACanvas.Font.Color := clBlue;
      ACanvas.Brush.Color := $00CCFFFF;
    end
    else
      ACanvas.Font.Color := clWhite;

    if AViewInfo.Item = cxgItensViewQTDPRO then
      ACanvas.Font.Style := [fsBold];

    Exit;
  end;

  If (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensSALFIN.Index])) <
    fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewESTMIN.Index]))) And
    (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensSALFIN.Index])) >= 0)  Then
  Begin
    ACanvas.Font.Color := clGreen;
    ACanvas.Brush.Color := clSilver;
    Exit;
  End;

  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensSALFIN.Index])) < 0 Then
  Begin
    ACanvas.Font.Color := clRed;
  End
  Else
  Begin
    If Not AViewInfo.Selected Then
      ACanvas.Brush.Color := clWindow;
  End;
end;

procedure TfrmAnaliseProducao.cxgItensViewQTDPROPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if TcxCustomCurrencyEdit(Sender).Value < 0 then
  begin
    TcxCustomCurrencyEdit(Sender).Value := 0;
    pMensagemOk('A quantidade a produzir deve ser maior ou igual a zero!');
  end;
end;

procedure TfrmAnaliseProducao.edtCodMarAcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMarAca, edtDesMarAca, arrMarcaAca, fRetNomMarca,nil,'da Marca');

end;

procedure TfrmAnaliseProducao.edtCodMarAcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self,
                 edtCodMarAca,
                 edtDesMarAca,
                 Nil,
                 Key,
                 arrMarcaAca,
                 False) Then
  Begin
    If fValidaCampos(edtCodMarAca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAnaliseProducao.edtCodMarExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMar,edtDesMar,arrMarca,fRetNomMarca,nil,'da Marca');

end;

procedure TfrmAnaliseProducao.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self,
                 edtCodMar,
                 edtDesMar,
                 Nil,
                 Key,
                 arrMarca,
                 False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmAnaliseProducao.edtCodProdutoAcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodProdutoAca, edtDesProdutoAca, arrProdutoAca, nil, fRetNomProduto, 'do Produto');

end;

procedure TfrmAnaliseProducao.edtCodProdutoAcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodProdutoAca, edtDesProdutoAca,
               nil, Key, arrProdutoAca, False,
               nil, 'Consulta de Itens', '1',
               '',
               0,
               False,
               False,
               0,
               cdrCodIte,
               '',
               False,
               '',
               '',
               True,
               False,
               True,
               '',
               False,
               True,  {Departamento produto acabados cadestruturaindustrial}
               False,
               False) {Departamento produto granel cadestruturaindustrial} Then
  Begin
    If fValidaCampos(edtCodProdutoAca,False) then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAnaliseProducao.edtCodProdutoExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodProduto,edtDesProduto,arrProduto,nil,fRetNomProduto,'do Produto');
  
end;

procedure TfrmAnaliseProducao.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodProduto, edtDesProduto,
               nil, Key, arrProduto, False,
               nil, 'Consulta de Itens', '1',
               '',
               0,
               False,
               False,
               0,
               cdrCodIte,
               '',
               False,
               '',
               '',
               True,
               False,
               True,
               '',
               False,
               False,
               False,
               True) {Departamento produto granel cadestruturaindustrial} Then
  Begin
    If fValidaCampos(edtCodProduto,False) then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAnaliseProducao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fGetFuncoesCxGrid.pSalvarView(cxgItensView, fGetChaveLayoutGrid, cdsItens, False);
  inherited;
end;

procedure TfrmAnaliseProducao.pCriaCdsItens;
begin
  cdsItens := TZClient.Create(Self);
  frxDBItens.DataSet := cdsItens;
End;

procedure TfrmAnaliseProducao.FormCreate(Sender: TObject);
var
  intRecNo : Integer;
begin
  inherited;

  pCriaCdsItens;
  cdsDigitacaoBackup := TUniClientDataSet.Create(Self);
  qryPrevis := fCriaQuery(Self);

  objEstadoTela := TEstadoTela.Create(Self.Name, strLoginUsuarioLogado);

  objEstadoTela.pAddComponenteSalvar(rdgEstoque);
  objEstadoTela.pAddComponenteSalvar(rdgGiro);
  objEstadoTela.pAddComponenteSalvar(chkNecPro);
  objEstadoTela.pAddComponenteSalvar(chkLibera);
  objEstadoTela.pAddComponenteSalvar(chkConMin);
  objEstadoTela.pAddComponenteSalvar(chkConMax);
  objEstadoTela.pAddComponenteSalvar(chkOrdPro);
  objEstadoTela.pAddComponenteSalvar(edtQtdDia);
  objEstadoTela.pAddComponenteSalvar(edtDiasGiro);
  objEstadoTela.pAddComponenteSalvar(rdbAnaSin);
  objEstadoTela.pAddComponenteSalvar(rdbAnaAna);

  fGetFuncoesCxGrid.fCarregarView(cxgItensView, fGetChaveLayoutGrid, cdsItens, intRecNo, False);

  blnGeraOpSubProdutos := fCfgSis('GOPSPR', varBoolean);

  cxgItensViewCAPMAX.Visible := fCfgSis('CAPMAX', varBoolean);

  pgbStatusGravacao := Nil;
  strChave := 'PEDCOM';

  btnManOrdProIndustrial.Enabled := fVerificaAcessoSistema('frmManOrdProIndustrial');

  if not fCfgSis('ANAQTP', varBoolean) then
  begin
    cxgItensViewQTDPRO.Visible := False;
    btnZerarProduzir.Visible := False;
  end;

  pSetaCodIte(edtCodProduto);
  pSetaCodIte(edtCodProdutoAca);
end;

procedure TfrmAnaliseProducao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objEstadoTela);
  If Assigned(qryPrevis) Then
    FreeAndNil(qryPrevis);
end;

procedure TfrmAnaliseProducao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F7 then
    btnSaldoReservado.Click;
end;

procedure TfrmAnaliseProducao.FormShow(Sender: TObject);
begin
  inherited;
  objEstadoTela.pGetEstadoTela;
end;

function TfrmAnaliseProducao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, arrMarca);
    End

    Else If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru, arrLinGru, '', 6)
    End


    Else If (Sender = edtCodProduto) Then
    Begin
      pDesmarcaLista(edtCodProduto, arrProduto);

      If (Not fEmptyStr(edtCodProduto.Text)) And
         (Not SameText(edtCodProduto.Text, fStrZero('0', edtCodProduto.TamCampo))) And
         (fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodProduto.Text]) <>
           fRetTipoDepartamento((fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodProduto.Text])), 'PROGRA')) Then
      Begin
        Result := False;
        pMensagemOk('Esse produto não é A Granel!');
      End;
    End

    Else If (Sender = edtCodMarAca) Then
    Begin
      pDesmarcaLista(edtCodMarAca, arrMarcaAca);
    End

    Else If (Sender = mskLinGruAca) Then
    Begin
      pDesmarcaLista(mskLinGruAca, arrLinGruAca, '', 6)
    End

    Else If (Sender = edtCodProdutoAca) Then
    Begin
      pDesmarcaLista(edtCodProdutoAca, arrProdutoAca);

      If (Not fEmptyStr(edtCodProdutoAca.Text)) And
         (Not SameText(edtCodProdutoAca.Text, fStrZero('0', edtCodProdutoAca.TamCampo))) And
         (fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodProdutoAca.Text]) <>
           fRetTipoDepartamento((fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodProdutoAca.Text])), 'PROACA')) Then
      Begin
        Result := False;
        pMensagemOk('Esse produto não é Acabado!');
      End;
    End

    Else If (Sender = edtQtdDia) Then
    Begin
      If edtQtdDia.Enabled Then
      Begin
        If fEmptyStr(edtQtdDia.Text) Then
          edtQtdDia.Text := '0'

        Else If StrToIntDef(edtQtdDia.Text, -1) < 0 Then
        Begin
          Result := False;
          pMensagemOk('A quantidade de Dias deve ser maior ou igual a zero!');
        End;
      End;
    End

    Else If (Sender = edtDiasGiro) Then
    Begin
      If fEmptyStr(edtDiasGiro.Text) Then
        edtDiasGiro.Text := '0'

      Else If StrToIntDef(edtDiasGiro.Text, -1) < 0 Then
      Begin
        Result := False;
        pMensagemOk('A quantidade de Dias para Giro/Dia deve ser maior ou igual a zero!');
      End;
    End

    Else If (Sender = mskDtaIni) Then
    Begin
      mskDtaFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text));
      If Not mskDtaFin.Enabled Then
        mskDtaFin.Clear;
    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&OK']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&OK']);
          Result := False;
        End
      End;

    End
    Else If (sender = edtCodGruGer) Then
    Begin
      If blnBuscaPorChave then
      Begin
        If fEmptyStr(edtCodGruGer.Text) Then
          edtDesGruGer.Text := 'TODOS'
        Else
        Begin
          edtDesGruGer.Text :=  fRetDescricaoGrupoAnaliseProducao(edtCodGruGer.Text);
          If fEmptyStr(edtDesGruGer.Text) Then
          Begin
            edtCodGruGer.Clear;
            edtDesGruGer.Text := 'TODOS';
            pMensagemOk('Código do Grupo de Análise do Produto a Granel não encontrado!');
            result := False;
          End;
        End;
      End;
    End

    Else if (sender = edtCodGruGerAca) Then
    Begin
      If blnBuscaPorChave Then
      Begin
        If fEmptyStr(edtCodGruGerAca.Text) Then
          edtDesGruGerAca.Text := 'TODOS'
        Else
        Begin
          edtDesGruGerAca.Text :=  fRetDescricaoGrupoAnaliseProducao(edtCodGruGerAca.Text);
          If fEmptyStr(edtDesGruGerAca.Text) Then
          Begin
            edtCodGruGerAca.Clear;
            edtDesGruGerAca.Text := 'TODOS';
            pMensagemOk('Código do Grupo de Análise do Produto Acabado não encontrado!');
            result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtStatus) Then
    Begin
      If (Pos(edtStatus.Text, 'SNT') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para o filtro "Ativo", deve-se informar S, N ou T!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtAtePed) Then
    Begin
      If (Pos(edtAtePed.Text, 'PNT') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para o filtro "Atende Pedido", deve-se informar P, N ou T!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAnaliseProducao.mskLinGruAcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinGruAca, edtDesGruAca, arrLinGruAca, fRetNomeLinhaGrupo, Nil, 'da linha/grupo',6);

end;

procedure TfrmAnaliseProducao.mskLinGruAcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self,
                mskLinGruAca,
                edtDesGruAca,
                Nil,
                Key,
                arrLinGruAca,
                False) Then
  Begin
    If fValidaCampos(mskLinGruAca, True) then
      SelectNext(ActiveControl, True, True);
  End;


end;

procedure TfrmAnaliseProducao.mskLinGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo',6);
  
end;

procedure TfrmAnaliseProducao.mskLinGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self,
                mskLinGru,
                edtDesGru,
                Nil,
                Key,
                arrLinGru,
                False) Then
  Begin
    If fValidaCampos(mskLinGru, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmAnaliseProducao.fSQLQtdPen: String;
begin
  Result := '';
  Result := Result + ' 0.000 ';
  Result := Result + '    + IFNULL(ITE_QTEF_F, 0) ';
  Result := Result + '    + IFNULL(ITE_QTEF_A, 0) ';
  Result := Result + '    + IFNULL(ITE_QTEF_P, 0) ';

  Result := Result + '   AS QTDPEN, ';
end;

function TfrmAnaliseProducao.fSQLCampos: String;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + '   I.ITE_CODITE  AS CODITE, ';
  strSQL := strSQL + '   I.ITE_DESITE  AS DESITE, ';
  strSQL := strSQL + '   UNI_SIGUNI    AS SIGUNI, ';
  strSQL := strSQL + '   ITE_SALDOS    AS SALDOS, ';
  strSQL := strSQL + '   ITE_ESTMIN    AS ESTMIN, ';
  strSQL := strSQL + '   ITE_ESTMAX    AS ESTMAX, ';
  strSQL := strSQL + '   I.ITE_CODFAB  AS CODFAB, ';
  strSQL := strSQL + '   I.ITE_PESLIQ  AS PESLIQ, ';
  strSQL := strSQL + '   0.000         AS SALRES, ';
  strSQL := strSQL + '   0.000         AS SALFIN, ';
  strSQL := strSQL + '   0.000         AS SALFEM, ';
  strSQL := strSQL + '   0.000         AS SALOPR, ';
  strSQL := strSQL + '   0.000         AS MEDGIR, ';
  strSQL := strSQL + '   0.00          AS GIRDIA, ';
  strSQL := strSQL + '   0             AS DIAEST, ';
  strSQL := strSQL + '   0.000         AS SALPED, ';
  strSQL := strSQL + '   I.ITE_SITPRD  AS SITPRD, ';
  strSQL := strSQL + fSQLQtdPen;

  If chkFaltaProduto.Checked Then
    strSQL := strSQL + ' ITE_QTEF_F, ';

  If chkPrevisaoEntrega.Checked Then
    strSQL := strSQL + ' ITE_QTEF_P, ';

  If chkAguardandoCliente.Checked Then
    strSQL := strSQL + ' ITE_QTEF_A, ';

  strSQL := strSQL + '   "S"           AS MOSTRA, ';
  strSQL := strSQL + '   "N"           AS REPETE, ';
  strSQL := strSQL + '   ' + fCurrentDate + ' AS PREVIS, ';
  strSQL := strSQL + '   0.000         AS QTDPRE, ';
  strSQL := strSQL + '   GR.ITE_CODITE AS ITEGRA, ';
  strSQL := strSQL + '   IFNULL(UNI_KILLIT,"K") AS KILLIT, ';
  strSQL := strSQL + '   UNI_PESLIT    AS PESLIT, ';
  strSQL := strSQL + '   I.ITE_CODCOR  AS CODCOR, ';
  strSQL := strSQL + '   GMT_CAPMAX    AS CAPMAX, ';
  strSQL := strSQL + '   0.00          AS QTDPRO, ';
  strSQL := strSQL + '   I.ITE_CODPAG  AS CODPAG, ';
  strSQL := strSQL + '   CONCAT(LEFT(GRU_CODGRU,3),".",RIGHT(GRU_CODGRU,3),"-",GRU_DESGRU) AS DESGRU,';
  strSQL := strSQL + '   I.ITE_CNV_ML  AS CNV_ML, ';
  strSQL := strSQL + '   0.000         AS SALDIS, ';
  strSQL := strSQL + '   0.000         AS SALDOP  ';
  Result := strSQL;
end;

Function TfrmAnaliseProducao.fSQLItens: String;
Var
  strSQL: String;
Begin
  strSQL := ' /* untAnaliseProducao.fSQLItens */';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE DISTINCT ';
  strSQL := strSQL + fSQLCampos;
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    CADITE GR ';

  strSQL := strSQL + '  INNER JOIN CADITE I  ON I.ITE_CODPAG = GR.ITE_CODITE ';

  strSQL := strSQL + '  INNER JOIN ITEGER G  ON G.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '                          G.ITE_CODEMP = :CODEMP          ';

  strSQL := strSQL + '  INNER JOIN CADUNI ON UNI_CODUNI = I.ITE_CODUNI        ';
  strSQL := strSQL + '  INNER JOIN GEIMAT ON GMT_CODITE = I.ITE_CODPAG        ';
  strSQL := strSQL + '                   AND GMT_CODCOR = I.ITE_CODCOR        ';
  strSQL := strSQL + '                   AND GMT_STATUS = "A"                 ';
  strSQL := strSQL + '  LEFT JOIN CADGRU ON CONCAT(LEFT(I.ITE_CODGRU,3), "000") = GRU_CODGRU ';

  strSQL := strSQL + '  WHERE     ';
  strSQL := strSQL + '    GR.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROGRA') + ') ';

  strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinGru,  'GR.ITE_CODGRU', 'CODGRU');
  strSQL := strSQL + fStrLocate(edtCodMar,       arrMarca,   'GR.ITE_CODMAR', 'CODMAR');
  strSQL := strSQL + fStrLocate(edtCodProduto,   arrProduto, 'GR.ITE_CODITE', 'CODITE');

  strSQL := strSQL + fStrLocateLinGru(mskLinGruAca, arrLinGruAca,  'I.ITE_CODGRU', 'CODGRUACA');
  strSQL := strSQL + fStrLocate(edtCodMarAca,       arrMarcaAca,   'I.ITE_CODMAR', 'CODMARACA');
  strSQL := strSQL + fStrLocate(edtCodProdutoAca,   arrProdutoAca, 'I.ITE_CODITE', 'CODITEACA');

  Case rdgEstoque.ItemIndex Of
    1: strSQL := strSQL + ' AND ITE_SALDOS < ITE_ESTMIN ';
    2: strSQL := strSQL + ' AND ITE_SALDOS < 0          ';
  End;

  If edtStatus.Text = 'S' Then
    strSQL := strSQL + ' AND I.ITE_ITEATI = "S" '
  Else If edtStatus.Text = 'N' Then
    strSQL := strSQL + ' AND I.ITE_ITEATI = "N" ';

  If Not fEmptyStr(edtCodGruGer.Text) Then
  Begin
     strSQL := strSQL + ' AND GR.ITE_CODGRU IN (SELECT                                                ';
     strSQL := strSQL + '                         GRD_CODGRU                                          ';
     strSQL := strSQL + '                       FROM                                                  ';
     strSQL := strSQL + '                         GRUGER                                              ';
     strSQL := strSQL + '                         INNER JOIN GRUDET ON GRD_SEQGER = GRUGER.AUTOINCREM ';
     strSQL := strSQL + '                       WHERE GRG_CODIGO = :CODGRG)                           ';
  End;

  If not fEmptyStr(edtCodGruGerAca.Text) Then
  Begin
     strSQL := strSQL + ' AND I.ITE_CODGRU IN (SELECT                                                ';
     strSQL := strSQL + '                        GRD_CODGRU                                          ';
     strSQL := strSQL + '                      FROM                                                  ';
     strSQL := strSQL + '                        GRUGER                                              ';
     strSQL := strSQL + '                        INNER JOIN GRUDET ON GRD_SEQGER = GRUGER.AUTOINCREM ';
     strSQL := strSQL + '                      WHERE GRG_CODIGO = :CODGRGACA)                        ';
  End;

  Result := strSQL;
End;

Function TfrmAnaliseProducao.fAbreConsulta: Boolean;
Begin
  pSetTexto('Aguarde... Gerando necessidade de produção.');

  If fVerificaCampos Then
  Begin
    cxgItensView.DataController.DataSource := Nil;

    If (rdbAnaSin.Checked) Then
    Begin
      cxgItensPREVIS.Caption := 'Dta.Prx.Ent.';
      cxgItensQTDPRE.Visible := False;
    End
    Else
    Begin
      cxgItensPREVIS.Caption := 'Dta.Ent.';
      cxgItensQTDPRE.Visible := True;
    End;

    If Assigned(cdsItens) Then
    begin
      FreeAndNil(cdsItens);
      pCriaCdsItens;
    End;

    With cdsItens, qryQuery Do
    Begin
      SQL.Text := fSQLItens;

      pSetaParam(mskLinGru.Text,     arrLinGru,  strLinGru,  'CODGRU', qryQuery);
      pSetaParam(edtCodMar.Text,     arrMarca,   strMarca,   'CODMAR', qryQuery);
      pSetaParam(edtCodProduto.Text, arrProduto, strProduto, 'CODITE', qryQuery);

      pSetaParam(mskLinGruAca.Text,     arrLinGruAca,  strLinGruAca,  'CODGRUACA', qryQuery);
      pSetaParam(edtCodMarAca.Text,     arrMarcaAca,   strMarcaAca,   'CODMARACA', qryQuery);
      pSetaParam(edtCodProdutoAca.Text, arrProdutoAca, strProdutoAca, 'CODITEACA', qryQuery);

      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If Not fEmptyStr(edtCodGruGer.Text) Then
        ParamByName('CODGRG').AsString := edtCodGruGer.Text;

      If Not fEmptyStr(edtCodGruGerAca.Text) Then
        ParamByName('CODGRGACA').AsString := edtCodGruGerACA.Text;

      Result := cdsItens.fAbreClient(True, 'TfrmAnaliseProducao.btnConfirmaClick');

      If cdsItens.RecordCount > 0 Then
      Begin
        pgbStatusGravacao.Properties.Max := cdsItens.RecordCount;
        pgbStatusGravacao.Position := 0;

        pFormataDecimal('SALDOS', 3);
        pFormataDecimal('ESTMIN', 3);
        pFormataDecimal('ESTMAX', 3);
        pFormataDecimal('SALRES', 3);
        pFormataDecimal('SALOPR', 3);
        pFormataDecimal('MEDGIR', 3);
        pFormataDecimal('GIRDIA', 2);
        pFormataDecimal('SALFIN', 3);
        pFormataDecimal('SALFEM', 3);
        pFormataDecimal('QTDPRE', 3);
        pFormataDecimal('QTDPRO', 2);
        pFormataDecimal('QTDPEN', 3);
        pFormataDecimal('SALDIS', 3);

        pCalculaSaldoDisponivel(cdsItens);
        pCalculaSaldoReservado(cdsItens);

        cxgItensView.DataController.DataSource := cdsItens.dtsSource;
      End
      Else
        pMensagemOk('Nenhum registro encontrado!');

    End;
  End

  Else Result := False;

  pgbStatusGravacao := Nil;
End;

Function TfrmAnaliseProducao.fQtdMeses: Integer;
Begin

  Case rdgGiro.ItemIndex Of
    0:   Result := 03;
    1:   Result := 06;
    2:   Result := 12;
    Else Result := 03;

  End;
End;

Function TfrmAnaliseProducao.fQuantidadeProducao(strCodIte: String; intQtdDias: Integer): Double;
  Var
    qryProducao: TUniQuery;
Begin

  qryProducao := fCriaQuery(Self);
  With qryProducao, SQL Do
  Begin
    Close;

    Add('  /* untAnaliseProducao.fQuantidadeProducao */              ');
    Add(' SELECT SQL_NO_CACHE                                        ');
    Add('  SUM(ORD_QTDPRO) AS QTDPRO');
    Add(' FROM                                                       ');
    Add('  ORDDET D');
    Add('INNER JOIN ORDGER G ON G.AUTOINCREM = D.ORD_SEQGER ');
    Add('WHERE ');
    Add('  G.ORD_CODEMP = :CODEMP AND  ');
    Add('  D.ORD_CODITE = :CODITE AND  ');
    Add('  G.ORD_DTABAI IS NULL   AND  ');
    Add('  G.ORD_DTAPRE <= :DTALIM     ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('DTALIM').AsDate   := VS_Date + intQtdDias;

    Open;

      Result := FieldByName('QTDPRO').AsFloat;
  End;

  FreeAndNil(qryProducao);
End;

Function TfrmAnaliseProducao.fCalculaMediaGiro(strCodIte: String; intQtdMeses: Integer): Double;
  Var
    qryGirIte: TUniQuery;
    intContador: Integer;
    dtaDtaIni: TDate;
Begin
  qryGirIte := fCriaQuery(Self);
  dtaDtaIni := VS_Date;
  Result    := 0;

  With qryGirIte, SQL Do
  Begin
    Close;

    For intContador := 1 To intQtdMeses Do
    Begin
      dtaDtaIni := IncMonth(dtaDtaIni, -1);

      Clear;
      Add(' /* untAnaliseProducao.fCalculaMediaGiro */');
      Add('SELECT SQL_NO_CACHE');
      Add(' GIR_QSAI' + fStrZero(MonthOf(dtaDtaIni), 2) + ' AS VALMES');
      Add('FROM');
      Add('  GIRITE');
      Add('WHERE');
      Add('  GIR_CODITE = :CODITE AND ');
      Add('  GIR_CODEMP = :CODEMP AND ');
      Add('  GIR_A_N_O_ = :NROANO');


      ParamByName('CODITE').AsString  := strCodIte;
      ParamByName('CODEMP').AsString  := VS_strCodEmp;
      ParamByName('NROANO').AsString  := IntToStr(YearOf(dtaDtaIni));

      Open;

      Result := Result + FieldByName('VALMES').AsFloat;

      Close;

    End;

  End;
  FreeAndNil(qryGirIte);

  Result := Result / intQtdMeses;
End;

function TfrmAnaliseProducao.fConfirma(pgbProgresso: TcxProgressBar): Boolean;
begin
  Self.pgbStatusGravacao := pgbProgresso;

  if cdsDigitacaoBackup.Active then
    cdsDigitacaoBackup.EmptyDataSet;

  if cdsItens.Active then
    cdsDigitacaoBackup.Data := cdsItens.Data;

  objEstadoTela.pSetEstadoTela;

  Result := fAbreConsulta;

  pSetQuantidadeDigitada;

  btnImprimir.Enabled := Result And (cdsItens.RecordCount > 0);
  btnImprimirQtdPro.Enabled := Result And (cdsItens.RecordCount > 0);
end;


function TfrmAnaliseProducao.fGetChaveLayoutGrid: string;
begin
  Result := Self.Name + '.' + cxgItensView.Name + '.' + strLoginUsuarioLogado;
end;

Procedure TfrmAnaliseProducao.pCalculaSaldoReservado(cdsCalculo: TUniClientDataSet);
  Var
    dtaPrvIni : TDate;
    dtaPrvFin : TDate;
Begin
  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    dtaPrvIni := StrToDateDef(mskDtaIni.Text, 0)
  Else
    dtaPrvIni := 0;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    dtaPrvFin := StrToDateDef(mskDtaFin.Text, 0)
  Else
    dtaPrvFin := 0;

  With cdsCalculo Do
  Begin
    DisableControls;
    Filtered := False;
    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('SALRES').AsFloat := TSaldoReservado.New(
                                         TReservaParametros.New()
                                           .EmpresaItem(VS_strCodEmp)
                                           .CodigoItem(FieldByName('CODITE').AsString)
                                           .CodEmpresa(VS_strCodEmp)
                                           .DtaPrevisaoInicial(dtaPrvIni)
                                           .DtaPrevisaoFinal(dtaPrvFin)
                                           .ApenasPedidosLiberados(chkLibera.Checked)
                                         ).fGetQuantidade();

      FieldByName('SALPED').AsFloat := FieldByName('SALRES').AsFloat - TSaldoReservado.New(
                                                                         TReservaParametros.New()
                                                                           .EmpresaItem(VS_strCodEmp)
                                                                           .CodigoItem(FieldByName('CODITE').AsString)
                                                                           .CodEmpresa(VS_strCodEmp)
                                                                           .DtaPrevisaoInicial(dtaPrvIni)
                                                                           .DtaPrevisaoFinal(dtaPrvFin)
                                                                           .ApenasPedidosLiberados(chkLibera.Checked)
                                                                           .TipoReserva(trsGarantia)
                                                                         ).fGetQuantidade();

      FieldByName('SALFIN').AsFloat :=    FieldByName('SALDOS').AsFloat
                                        - FieldByName('SALRES').AsFloat
                                        - FieldByName('QTDPEN').AsFloat
                                        + FieldByName('SALOPR').AsFloat;

      If chkFaltaProduto.Checked Then
        FieldByName('SALDIS').AsFloat := FieldByName('SALDIS').AsFloat - FieldByName('ITE_QTEF_F').AsFloat;

      If chkPrevisaoEntrega.Checked Then
        FieldByName('SALDIS').AsFloat := FieldByName('SALDIS').AsFloat - FieldByName('ITE_QTEF_P').AsFloat;

      If chkAguardandoCliente.Checked Then
        FieldByName('SALDIS').AsFloat := FieldByName('SALDIS').AsFloat - FieldByName('ITE_QTEF_A').AsFloat;

      //FieldByName('SALFIN').AsFloat := FieldByName('SALDIS').AsFloat;

      If Not chkOrdPro.Checked Then
      Begin
        FieldByName('SALFIN').AsFloat := FieldByName('SALDIS').AsFloat - FieldByName('SALOPR').AsFloat;
        FieldByName('SALDIS').AsFloat := FieldByName('SALDIS').AsFloat - FieldByName('SALOPR').AsFloat;
      End;

      If chkConMax.Checked Then
        FieldByName('SALFEM').AsFloat := FieldByName('SALFIN').AsFloat - FieldByName('ESTMAX').AsFloat
      Else
        FieldByName('SALFEM').AsFloat := FieldByName('SALFIN').AsFloat;

      If chkConMin.Checked Then
        FieldByName('SALFIN').AsFloat := FieldByName('SALFIN').AsFloat - FieldByName('ESTMIN').AsFloat;

      If FieldByName('MEDGIR').AsFloat > 0 Then
      Begin
        FieldByName('DIAEST').AsInteger := Trunc((FieldByName('SALDOS').AsFloat / FieldByName('MEDGIR').AsFloat) * 30);
        FieldByName('GIRDIA').AsFloat := (FieldByName('MEDGIR').AsFloat/30) * StrToInt(edtDiasGiro.Text);
      end
      Else
      begin
        FieldByName('DIAEST').Clear;
        FieldByName('GIRDIA').AsFloat := 0;;
      end;

      If (FieldByName('SITPRD').AsString = '2') And ((FieldByName('SALPED').AsFloat <= 0) And (FieldByName('QTDPEN').AsFloat <= 0)) Then
      Begin
        FieldByName('MOSTRA').AsString := 'N';
      End;

      FieldByNAme('PREVIS').Clear;

      If (FieldByName('MOSTRA').AsString = 'S') And (FieldByName('SALPED').AsFloat > 0) And (rdbAnaSin.Checked) Then
      Begin
        pCarregaPrevisao(FieldByName('CODITE').AsString, VS_strCodEmp, dtaPrvIni, dtaPrvFin, chkLibera.Checked);
        FieldByNAme('PREVIS').AsDateTime := qryPrevis.FieldByName('PREVIS').AsDateTime;

        if FieldByName('PREVIS').AsDateTime = 0 then
          FieldByName('PREVIS').Clear;

      End
      Else If (FieldByName('MOSTRA').AsString = 'S') And (FieldByName('SALPED').AsFloat > 0) And (rdbAnaAna.Checked) Then
      Begin
        FieldByNAme('REPETE').AsString := 'S';
      End;

      Post;

      Next;

      pStepStatusGravacao;
    End;

    If (rdbAnaAna.Checked) Then
      pProcessaAnalitico;

    pSetarFiltro;

    If (rdbAnaSin.Checked) Then
      cdsCalculo.IndexFieldNames := 'DESITE'
    Else
      cdsCalculo.IndexFieldNames := 'DESITE;PREVIS';

    EnableControls;

    First;
  End;
End;

procedure TfrmAnaliseProducao.pCarregaPrevisao(strCodIte: String; strCodEmp: String; dtaPrevIni: TDate = 0; dtaPrevFin: TDate = 0; blnApenasLiberados : boolean = False);
  Var
    strSQL : String;
    strEmp_CD : String;
begin
  strEmp_CD := fCfgSis('EMP_CD', varString, strCodEmp);

  strSQL := '';
  strSQL := strSQL + ' SELECT FDO_CODITE AS CODITE, SUM(FDO_QTDITE - FDO_QTDBAI) AS SALRES, FGO_PREVIS AS PREVIS ';
  strSQL := strSQL + '   FROM FATDOR ';
  strSQL := strSQL + '   JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  strSQL := strSQL + '   LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';

  If (fCfgSis('BXSBIT') = '3') Or ((fCfgSis('BXSBIT') = '2') And (fCfgSis('EMOPPD') = 'S')) Then
    strSQL := strSQL + '  LEFT JOIN MOVPRO ON PRO_CODPRO = FDO_ORDPRO AND PRO_CODEMP = FDO_CODEMP ';

  strSQL := strSQL + '  WHERE FDO_JAFATU = 0 ';
  strSQL := strSQL + '    AND FDO_ESPDOC = "PD" ';
  strSQL := strSQL + '    AND FDO_CODITE = :CODITE ';
  strSQL := strSQL + '    AND ((((FDO_CODEMP = :CODEMP) AND (IFNULL(FDO_EMPITE, "") = "")) OR ';
  strSQL := strSQL + '        (FDO_EMPITE = :EMPITE)) ';

  If (fCfgSis('ENT_CD', varBoolean, strCodEmp)) And (VS_strCodEmp = strEmp_CD) Then
  Begin
    strSQL := strSQL + '   OR ( FGO_ENT_CD = "S" AND ' +
                       '        IFNULL(FGO_EMP_CD, ' + QuotedStr(strEmp_CD) + ') = ' + QuotedStr(strEmp_CD) + ' ) ) ';
  End
  Else
  Begin
    strSQL := strSQL + '   AND IFNULL(FGO_ENT_CD, "N") = "N") ';
  End;
  {will}
  If fCfgSis('REEFFP', varString, strCodEmp) = 'N' Then
    strSQL := strSQL + ' AND FDO_MOTFUT <> "F" ';

  If (fCfgSis('BXSBIT') = '3') Or ((fCfgSis('BXSBIT') = '2') And (fCfgSis('EMOPPD') = 'S')) Then
    strSQL := strSQL + ' AND IF(IFNULL(FDO_ORDPRO, "") = "", TRUE, PRO_DTABAI IS NOT NULL) ';

  If (fCfgSis('BXSBIT') = '2') And (fCfgSis('EMOPPD') = 'N') Then
    strSQL := strSQL + '  AND IFNULL(FDO_BXSBIT,"N") <> "S" ';

  If (dtaPrevIni <> 0) And (dtaPrevFin <> 0) Then
  Begin
    strSQL := strSQL + ' AND FGO_PREVIS BETWEEN :PRVINI AND :PRVFIN ';
  End;

  If (fCfgSis('BXSBIT') = '2') And (fCfgSis('EMOPPD') = 'N') Then
  Begin
    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + ' SELECT FDO_CODITE AS CODITE, SUM((FDO_QTDITE - FDO_QTDBAI) * DMT_QTDITE) AS SALRES, FGO_PREVIS AS PREVIS ';
    strSQL := strSQL + '   FROM FATDOR ';
    strSQL := strSQL + '   JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
    strSQL := strSQL + '   LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';

    strSQL := strSQL + '   INNER JOIN GERMAT ON GMT_CODITE = FDO_CODITE AND GMT_CODEMP = FDO_CODEMP ';
    strSQL := strSQL + '   INNER JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM ';

    strSQL := strSQL + '  WHERE FDO_JAFATU = 0 ';
    strSQL := strSQL + '    AND FDO_ESPDOC = "PD" ';
    strSQL := strSQL + '    AND DMT_ITESUB = :CODITE ';
    strSQL := strSQL + '    AND ((((FDO_CODEMP = :CODEMP) AND (IFNULL(FDO_EMPITE, "") = "")) OR ';
    strSQL := strSQL + '        (FDO_EMPITE = :EMPITE)) ';

    If (fCfgSis('ENT_CD', varBoolean, strCodEmp)) And (VS_strCodEmp = strEmp_CD) Then
    Begin
      strSQL := strSQL + '   OR ( FGO_ENT_CD = "S" AND ' +
                         '        IFNULL(FGO_EMP_CD, ' + QuotedStr(strEmp_CD) + ') = ' + QuotedStr(strEmp_CD) + ' ) ) ';
    End
    Else
    Begin
      strSQL := strSQL + '   AND IFNULL(FGO_ENT_CD, "N") = "N") ';
    End;

    If fCfgSis('REEFFP', varString, strCodEmp) = 'N' Then
      strSQL := strSQL + ' AND FDO_MOTFUT <> "F" ';

    strSQL := strSQL + ' AND FDO_BXSBIT = "S" ';//Baixa de estoque dos sub.itens

    If (dtaPrevIni <> 0) And (dtaPrevFin <> 0) Then
    Begin
      strSQL := strSQL + ' AND FGO_PREVIS BETWEEN :PRVINI AND :PRVFIN ';
    End;

  End;

  if blnApenasLiberados Then
    strSQL := strSQL + '  AND IFNULL(FGO_LIBERA, 0) > 0 ';

  strSQL := ' SELECT CODITE, SUM(SALRES) AS SALRES, PREVIS FROM (' + strSQL + ') T GROUP BY CODITE, PREVIS ';

  With qryPrevis Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('EMPITE').AsString := strCodEmp;
    If (dtaPrevIni <> 0) And (dtaPrevFin <> 0) Then
    Begin
      ParamByName('PRVINI').AsDate := dtaPrevIni;
      ParamByName('PRVFIN').AsDate := dtaPrevFin;
    End;
    Open;
  End;
end;

Procedure TfrmAnaliseProducao.pImprimeQtdProduzir;
  Var
    frxReport: TfrxReport;
    strTipImp,
    strNomImp: String;
Begin
  Try
    Try
      cdsItens.DisableControls;

      pCarregaConfImprRel(Self.Name, strNomImp, strTipImp);


      If fCfgSis('ANAQTP', varBoolean) then
      begin
        cdsItens.IndexFieldNames := 'DESITE;CODPAG;CODCOR';
        cdsItens.Filter := 'QTDPRO > 0';
        cdsItens.Filtered := True;
        If (strTipImp = 'M') Then
          frxReport := frxReportM_ANAQTP
        Else
          frxReport := frxReportJ_ANAQTP;
      end
      else
      begin
        cdsItens.IndexFieldNames := 'DESITE';

        If (strTipImp = 'M') Then
          frxReport := frxReportM
        Else
          frxReport := frxReportJ;
      end;

      if frxReport.FindObject('mmoZebra') <> nil then
        TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

      cdsItens.First;

      With frxReport, Script Do
      Begin
        Variables['NOMEMP']  := fRetNomeEmpresa;
        Variables['NOMREL']  := 'ANALISE DE PRODUCAO';

        Variables['LINHA']      := fStrTitulo(mskLinGru.Text,     edtDesGru,     arrLinGru,  strLinGru,  'LINHA/GRUPO A GRANEL');
        Variables['PRODUTO']    := fStrTitulo(edtCodProduto.Text, edtDesProduto, arrProduto, strProduto, 'PRODUTO A GRANEL');
        Variables['MARCA']      := fStrTitulo(edtCodMar.Text,     edtDesMar,     arrMarca,   strMarca,   'MARCA A GRANEL');

        Variables['LINHAACA']   := fStrTitulo(mskLinGruAca.Text,     edtDesGruAca,     arrLinGruAca,  strLinGruAca,  'LINHA/GRUPO ACABADOS');
        Variables['PRODUTOACA'] := fStrTitulo(edtCodProdutoAca.Text, edtDesProdutoAca, arrProdutoAca, strProdutoAca, 'PRODUTO ACABADO');
        Variables['MARCAACA']   := fStrTitulo(edtCodMarAca.Text,     edtDesMarAca,     arrMarcaAca,   strMarcaAca,   'MARCA ACABADOS');

        If chkOrdPro.Checked Then
          Variables['ORDPRO']   := 'CONSIDERAR ORDEM DE PRODUCAO ATE ' + edtQtdDia.Text + ' DIAS'
        Else
          Variables['ORDPRO']   := 'CONSIDERAR ORDEM DE PRODUCAO: NAO';

        If chkNecPro.Checked Then
          Variables['NECCOM']   := 'EXIBIR ITENS SEM NECESSIDADE DE PRODUÇÃO: SIM'
        Else
          Variables['NECCOM']   := 'EXIBIR ITENS SEM NECESSIDADE DE PRODUÇÃO: NAO';

        If chkConMin.Checked Then
          Variables['CONMIN']   := 'CONSIDERAR ESTOQUE MINIMO: SIM'
        Else
          Variables['CONMIN']   := 'CONSIDERAR ESTOQUE MINIMO: NAO';

        Case rdgEstoque.ItemIndex Of
          0: Variables['ESTOQUE'] := 'FILTRO DE ESTOQUE: TODOS';
          1: Variables['ESTOQUE'] := 'FILTRO DE ESTOQUE: ABAIXO DO ESTOQUE MINIMO';
          2: Variables['ESTOQUE'] := 'FILTRO DE ESTOQUE: ESTOQUE NEGATIVO';
        End;

        Case rdgGiro.ItemIndex Of
          0: Variables['GIRO'] := 'GIRO DE ESTOQUE: 3 MESES';
          1: Variables['GIRO'] := 'GIRO DE ESTOQUE: 6 MESES';
          2: Variables['GIRO'] := 'GIRO DE ESTOQUE: 12 MESES';
        End;

        PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

        PrepareReport;

        If fEmptyStr(strNomImp) Then
          ShowReport
        Else
          Print;
      End;

    Except
      on E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmAnaliseProducao.pImprimeRelatorio]');
      End;
    End;
  finally
    cdsItens.Filtered := False;
    pSetarFiltro;
    cdsItens.EnableControls;
  end;
End;

Procedure TfrmAnaliseProducao.pImprimeRelatorio;
Begin
  Try

    If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(389, 18211, [18211],
                          ['CODMAR',
                           'CODGRU',
                           'CODITE',
                           'MARACA',
                           'GRUACA',
                           'ITEACA',
                           'FILEST',
                           'QTDMES',
                           'NECCOM',
                           'LIBERA',
                           'DIAGIR',
                           'CONMIN',
                           'COMMAX',
                           'ORDPRO',
                           'QTDDIA',
                           'STATUS',
                           'DTAINI',
                           'DTAFIN',
                           'TIPANA',
                           'QBRLIN',
                           'ATEPED'],
                          [edtCodMar.Text,
                           mskLinGru.Text,
                           fStrFiltroAtaRelEditor(edtCodProduto, arrProduto),
                           edtCodMarAca.Text,
                           mskLinGruAca.Text,
                           fStrFiltroAtaRelEditor(edtCodProdutoAca, arrProdutoAca),
                           rdgEstoque.Items[rdgEstoque.ItemIndex],
                           rdgGiro.Items[rdgGiro.ItemIndex],
                           IfThen(chkNecPro.Checked, 'Sim', 'Não'),
                           IfThen(chkLibera.Checked, 'Sim', 'Não'),
                           edtDiasGiro.Text,
                           IfThen(chkConMin.Checked, 'Sim', 'Não'),
                           IfThen(chkConMax.Checked, 'Sim', 'Não'),
                           IfThen(chkOrdPro.Checked, 'Sim', 'Não'),
                           edtQtdDia.Text,
                           IfThen(edtStatus.Text = 'S', 'Sim', IfThen(edtStatus.Text = 'N', 'Não', 'Todos')),
                           IfThen(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)), '', mskDtaIni.Text),
                           IfThen(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)), '', mskDtaFin.Text),
                           IfThen(rdbAnaSin.Checked, 'Sintética', 'Analítica'),
                           IfThen(chkQbrLin.Checked, 'Sim', 'Não'),
                           IfThen(edtAtePed.Text = 'P', 'Positivo', IfThen(edtAtePed.Text = 'N', 'Negativo', 'Todos'))],
                          Nil,
                          Nil,
                          True);
  Except
    on E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAnaliseProducao.pImprimeRelatorio]');
    End;
  End;

  cdsItens.EnableControls;
End;

procedure TfrmAnaliseProducao.pProcessaAnalitico;
  Var
    cdsDados : TUniClientDataSet;
    intCnt : Integer;
    dtaPrvIni : TDate;
    dtaPrvFin : TDate;
begin
  If (Not Assigned(cdsItens)) Or (Not cdsItens.Active) Or (cdsItens.RecordCount = 0) Then
    Exit;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    dtaPrvIni := StrToDateDef(mskDtaIni.Text, 0)
  Else
    dtaPrvIni := 0;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    dtaPrvFin := StrToDateDef(mskDtaFin.Text, 0)
  Else
    dtaPrvFin := 0;

  cdsDados :=  TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, cdsItens);

  cdsItens.IndexFieldNames := 'CODITE';

  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    If (cdsDados.FieldByName('REPETE').AsString = 'N') Then
    Begin
      cdsDados.Next;
      Continue;
    End;

    pCarregaPrevisao(cdsDados.FieldByName('CODITE').AsString, VS_strCodEmp, dtaPrvIni, dtaPrvFin, chkLibera.checked);

    qryPrevis.First;
    While Not qryPrevis.Eof Do
    Begin

      If (qryPrevis.RecNo = 1) Then
      Begin
        cdsItens.FindKey([cdsDados.FieldByName('CODITE').AsString]);
        cdsItens.Edit;
      End
      Else
        cdsItens.Append;
        
      For intCnt := 0 To cdsDados.Fields.Count-1 Do
      Begin
        If Not cdsDados.Fields[intCnt].IsNull Then
        Begin
          cdsItens.FieldByName( cdsDados.Fields[intCnt].FieldName ).Value := cdsDados.Fields[intCnt].Value;
        End;
      End;

      cdsItens.FieldByName('PREVIS').AsDateTime := qryPrevis.FieldByName('PREVIS').AsDateTime;

      if cdsItens.FieldByName('PREVIS').AsDateTime = 0 then
        cdsItens.FieldByName('PREVIS').Clear;

      cdsItens.FieldByName('QTDPRE').AsFloat  := qryPrevis.FieldByName('SALRES').AsFloat;
      cdsItens.Post;

      qryPrevis.Next;
    End;

    cdsDados.Next;
  End;

  cdsDados.Close;
  FreeAndNil(cdsDados);
end;

procedure TfrmAnaliseProducao.pSetarFiltro;
  Var
    strFilter : String;
begin
  strFilter := '';

  If Not chkNecPro.Checked Then
    strFilter := 'SALFIN < 0';

  If fEmptyStr(strFilter) Then
    strFilter := 'MOSTRA = ' + QuotedStr('S')
  Else
    strFilter := strFilter + ' AND MOSTRA = ' + QuotedStr('S');

  If fEmptyStr(strFilter) Then
  Begin
    If edtAtePed.Text = 'P' Then
      strFilter := 'SALFEM > 0 '
    Else If edtAtePed.Text = 'N' Then
      strFilter := 'SALFEM < 0 ';
  End
  Else
  Begin
    If edtAtePed.Text = 'P' Then
      strFilter := strFilter + ' AND SALFEM > 0 '
    Else If edtAtePed.Text = 'N' Then
      strFilter := strFilter + ' AND SALFEM < 0 ';
  End;

  If Not fEmptyStr(strFilter) Then
  Begin
    cdsItens.Filter   := strFilter;
    cdsItens.Filtered := True;
  End;
end;

procedure TfrmAnaliseProducao.pSetTexto(strTexto: String);
begin
  If Assigned(pgbStatusGravacao) And (GetParentForm(pgbStatusGravacao).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatusGravacao).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TfrmAnaliseProducao.pStepStatusGravacao;
Begin
  If Assigned(pgbStatusGravacao) Then
  Begin
    pgbStatusGravacao.Position := pgbStatusGravacao.Position + 1;
    Application.ProcessMessages;
  End;
End;

procedure TfrmAnaliseProducao.rdbAnaSinKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = Char(VK_RETURN)) Then
    btnConfirma.Click;
end;

procedure TfrmAnaliseProducao.edtCodGruGerAcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqGruposAnaliseProducao(Self, edtCodGruGerAca, edtDesGruGerAca, qryTabela, Key) then
  begin
    If fValidaCampos(edtCodGruGerAca, True) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmAnaliseProducao.edtCodGruGerKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqGruposAnaliseProducao(Self, edtCodGruGer, edtDesGruGer, qryTabela, Key) then
  begin
    If fValidaCampos(edtCodGruGer, True) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmAnaliseProducao.pSetQuantidadeDigitada;
begin
  if cdsDigitacaoBackup.Active then
  begin

    cdsDigitacaoBackup.First;
    while not cdsDigitacaoBackup.Eof do
    begin
      if cdsItens.Locate('CODITE', cdsDigitacaoBackup.FieldByName('CODITE').AsString, []) then
      begin
        cdsItens.Edit;
        cdsItens.FieldByName('QTDPRO').AsString := cdsDigitacaoBackup.FieldByName('QTDPRO').AsString;
        cdsItens.Post;
      end;
      cdsDigitacaoBackup.Next;
    end;

    cdsItens.First;
  end;
end;

Procedure TfrmAnaliseProducao.pCalculaSaldoDisponivel(cdsCalculo: TUniClientDataSet);
  Var
    objSalLoj: TSaldoLojas;
    recSaldos,
    recSaldosML: TRecSaldos;
    fltSaldos: Double;
Begin
  objSalLoj := TSaldoLojas.Create(Self);
  Try
    With cdsCalculo Do
    Begin
      DisableControls;
      Filtered := False;
      First;

      While Not Eof Do
      Begin
        fltSaldos := FieldByName('SALDOS').AsFloat;
        objSalLoj.pCalculaSaldos(nil,
                                 recSaldos,
                                 recSaldosML,
                                 fltSaldos,
                                 VS_strCodEmp,
                                 VS_strCodEmp,
                                 FieldByName('CODITE').AsString,
                                 FieldByName('CNV_ML').AsFloat,
                                 fCfgSis('ENTFUT', varBoolean),
                                 false,
                                 fCfgSis('ORDPRO', varBoolean),
                                 fCfgSis('CALSAL', varInteger));
        Edit;
        FieldByName('SALDIS').AsFloat := recSaldos.fltEstFis - recSaldos.fltSalPed;
        FieldByName('SALDOS').AsFloat := recSaldos.fltEstFis;

        FieldByName('MEDGIR').AsFloat := fCalculaMediaGiro(FieldByName('CODITE').AsString, fQtdMeses);
        FieldByName('SALOPR').AsFloat := fQuantidadeProducao(FieldByName('CODITE').AsString, StrToIntDef(edtQtdDia.Text, 0));

        If FieldByName('MEDGIR').AsFloat = 0 Then
          FieldByName('SALDOP').AsFloat := 0
        Else
          FieldByName('SALDOP').AsFloat := Trunc(((FieldByName('SALDIS').AsFloat + FieldByName('SALOPR').AsFloat) / FieldByName('MEDGIR').AsFloat) * 30);

        Post;

        Next;

        pStepStatusGravacao;
      End;

      If (rdbAnaAna.Checked) Then
        pProcessaAnalitico;

      pSetarFiltro;

      If (rdbAnaSin.Checked) Then
        cdsCalculo.IndexFieldNames := 'DESITE'
      Else
        cdsCalculo.IndexFieldNames := 'DESITE;PREVIS';

      EnableControls;

      First;
    End;
  Finally
    FreeAndNil(objSalLoj);
  End;
End;

Function TfrmAnaliseProducao.fGetTipoFiltroData: TTipoFiltroDataAnaliseProducao;
Begin
  Result := tfdNenhum;
  Case rdgTipoFiltroData.ItemIndex Of
    0: Result := tfdPrevisaoPedido;
    1: Result := tfdEntregaItem;
  End;
End;

end.
